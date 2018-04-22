Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+v6NPX5qQKI9+JE6PhPEuCjFsnYSG1i+EZnNYZF9PfcTwGCPdF0CChiZNWiEUBRw+5KkxO
ARC-Seal: i=1; a=rsa-sha256; t=1524406813; cv=none;
        d=google.com; s=arc-20160816;
        b=0s/DkHsP2YnKDRW/YVlRpAAJxcQbxojDzlFPNiJbTHoImAFfNpDvdBghB++WPPmEzb
         L6HlXLMRP3C5uD87X706qTYV5qn8cSXm1jwafhuAfL7Sejg3w/gVaKeqpbE/wIQ705To
         T+BPUvgbHQkwDFb+7OaJblC+uxxK0mpfAoDvFg3qHJNxBE6yvof6fslPVtJ5yQWkU/Ep
         7a44spp/b0I+5Urlvj7EcawL81Wt4TmT4zMgaY1hhy9ORgLwfgBOHBYyfVYu8K5V10Zn
         aMl156eXU8eQrtod85c2c3p+jDf6nYXbPSvfGPRkDL3ntAFHxJSjyn6h/JvID+PJMivu
         37Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CLGi49+Imztu6ms2k6XUqnhAvRV1IMsrei5vcDUO/IA=;
        b=q7xxXCWYSBHInd30715LRPycNlkH6CucCYhHGDAnZYTrbse9fmMrANM4DUXK+Ojw0b
         S1XN0OG8aYxXymBWSKoGNni3mTbn8RyYgVCsp1xEntP1PBPrXJn+nGN9fJIX+C58GYS7
         lubja/UH0pCIyujNaY14q0KYeDdDe4WPj8GvwYEQLBc+nblpaxvan3VgQ9q2D0HflfWp
         WepT99pU3jDDKnKNVdsF7bvzK6RD9YfBGZXuJ51Sn73RT4qohXn/rl4ts+OZbp2hEmsj
         npOA0zZNztVH+6JB/uAc3FrFXFPstuxSdZxlHokvThgcZZlIrDuCJsKSI2Ejlb8Brmyc
         X1zQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jason Andryuk <jandryuk@gmail.com>,
	Eduardo Otubo <otubo@redhat.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH 3.18 14/52] xen-netfront: Fix hang on device removal
Date: Sun, 22 Apr 2018 15:53:47 +0200
Message-Id: <20180422135315.926366135@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455501364355262?=
X-GMAIL-MSGID: =?utf-8?q?1598456398592419151?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Andryuk <jandryuk@gmail.com>

commit c2d2e6738a209f0f9dffa2dc8e7292fc45360d61 upstream.

A toolstack may delete the vif frontend and backend xenstore entries
while xen-netfront is in the removal code path.  In that case, the
checks for xenbus_read_driver_state would return XenbusStateUnknown, and
xennet_remove would hang indefinitely.  This hang prevents system
shutdown.

xennet_remove must be able to handle XenbusStateUnknown, and
netback_changed must also wake up the wake_queue for that state as well.

Fixes: 5b5971df3bc2 ("xen-netfront: remove warning when unloading module")

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
Cc: Eduardo Otubo <otubo@redhat.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/xen-netfront.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -2067,7 +2067,10 @@ static void netback_changed(struct xenbu
 	case XenbusStateInitialised:
 	case XenbusStateReconfiguring:
 	case XenbusStateReconfigured:
+		break;
+
 	case XenbusStateUnknown:
+		wake_up_all(&module_unload_q);
 		break;
 
 	case XenbusStateInitWait:
@@ -2314,7 +2317,9 @@ static int xennet_remove(struct xenbus_d
 		xenbus_switch_state(dev, XenbusStateClosing);
 		wait_event(module_unload_q,
 			   xenbus_read_driver_state(dev->otherend) ==
-			   XenbusStateClosing);
+			   XenbusStateClosing ||
+			   xenbus_read_driver_state(dev->otherend) ==
+			   XenbusStateUnknown);
 
 		xenbus_switch_state(dev, XenbusStateClosed);
 		wait_event(module_unload_q,
