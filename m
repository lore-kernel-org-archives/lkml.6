Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+vxl49IVNucEyPkX+tDC6bz6QQR7c3GzSfb/jTtSmLvTPh2fq0NVBab7sKU3UwDr+fb26j
ARC-Seal: i=1; a=rsa-sha256; t=1524406615; cv=none;
        d=google.com; s=arc-20160816;
        b=q2ZYcERFe+pN/CsFX+8lnLDEzv8TH6UIxJMCl2pfkHEYh8jKr+owhLB5G8L1WTOwk9
         GgaphVo/snnSdCoC8ffqZn4ZogtyH9xl0PpqxEWazhBh6ZhjSN4j126xjvXYJTuJaGIK
         ckhYnUR4XHSYohU947QY5LVOaICL5W6jWVBjYvXUP9MC2IpK6uh0eA9X+dPEbjIhGigN
         72PiEw6g6aBh1UAbrGvpTgBiD50/SU+44V0FO0U0G0RrbtNFha4bNRKq6PnVKdmwtCC7
         r4XACwps+GSW2trIT1SVu74XoRSOLdTzkA4FvL+oOZRFtL4+QM2g2VfdMJCGnXXlrZrP
         J9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TF2MttnB/sLlOKnmHuzVe7MDrMhqTkSOHU0Ypc33GI0=;
        b=J0GuJ78CN4yst1rkNrG3K9GU2x5f64nYOlV6v8ARfGKmsvowx7JBWk0Tr7jry9OOOa
         jWZ6kY33Afk8aqnBY0LQJGDFH/WoPLBC0QSG/S8iHWLIwK4JJaqDih+hp6u2p3yfeLqg
         r/KcsWSJ00blfl0T2GFcNtnAU8dW9MA54poS8auuIi6wcpBJken9cpS1GG9OjUaP7IHB
         81uYh4uY1BriT0/ez5kzs2u7ZfQViylGYpKnrKbL7/WMl/Bd5HuR8vE79EO/5zXEjxp/
         lB/oTRRbcrI3KVD0S182rdqFMrohVbf7IMGvoYD0YSyxDyDuB/aGBOQF0bd4vjq8RVH0
         Ifkg==
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
Subject: [PATCH 4.4 33/97] xen-netfront: Fix hang on device removal
Date: Sun, 22 Apr 2018 15:53:11 +0200
Message-Id: <20180422135307.198967865@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455501364355262?=
X-GMAIL-MSGID: =?utf-8?q?1598456191329135276?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2024,7 +2024,10 @@ static void netback_changed(struct xenbu
 	case XenbusStateInitialised:
 	case XenbusStateReconfiguring:
 	case XenbusStateReconfigured:
+		break;
+
 	case XenbusStateUnknown:
+		wake_up_all(&module_unload_q);
 		break;
 
 	case XenbusStateInitWait:
@@ -2155,7 +2158,9 @@ static int xennet_remove(struct xenbus_d
 		xenbus_switch_state(dev, XenbusStateClosing);
 		wait_event(module_unload_q,
 			   xenbus_read_driver_state(dev->otherend) ==
-			   XenbusStateClosing);
+			   XenbusStateClosing ||
+			   xenbus_read_driver_state(dev->otherend) ==
+			   XenbusStateUnknown);
 
 		xenbus_switch_state(dev, XenbusStateClosed);
 		wait_event(module_unload_q,
