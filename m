Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49J5SobyOTTKmTu+zR8PqL4NlZE3WwJ/3el4olP6T3n92YWp/LETEmSsI5ddtsj5OR7IG/b
ARC-Seal: i=1; a=rsa-sha256; t=1524405957; cv=none;
        d=google.com; s=arc-20160816;
        b=ZFBp8uf3Lm1VnTTsCIyt0QYPSqYGQnFuBwqRBVRU19x0LfyMFZBPAgc4Ys3o9INubD
         8nuWvf7L9Gcv4ctawfn8n+oe6wlUlRtn6bNP8J82p0nGGCJnfBcu3fSQ+8R5lp09EGMv
         /4fVzAKC6QRsM1aLaZIlHWn1pWPZWzn7zD5vAMxFpFndFhsUsB3DIYRtNGowqWdXJmIf
         nVWiQuENsGmNT+1WPPrjkzTv2XZBMi3D+N1hhNB/C91eMOGFDF7rJQrQEDTFYZy/OrXt
         BcOvlgUs6imRJu8foQcdBz/ZsA+WAq6TccCtMBnJoN/KBnQO+0sNEd62uk00c/OsrJru
         Mzzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=N0PDp5eskfjo9gejp7TrFetrtESojRy2FcXoIbK4eTU=;
        b=fCTXn6pRXWl2Z7o06eICh1TfLAJADXIb7PsFhowgY4zuljq4u28csQ9byPFeS9KxkM
         9A1PyaL9cBk9xhbgZVJNHIb4fyde3hOaVIA2jlytDpy/eNLiqipCAK566gSlNeRHAdZF
         YCUi3rBEn990SbPQQEC0L6FfCmLA5iLrP8rlC+nyVCn/9kUZutVxeQyaoI44rSHgBG+5
         +6zj7W2YosK8GzrCGIOP6UGdxbNLWDy1ZOyBcD/DtF2zplVB2k154mVU3RDiYUVE35M5
         DRHTx2S5Wrb83P6EkEzhtPVr9xvkg5V2CIceir//BxXzhFbY0cuK0l/TgiQdUKjJFqfS
         rHdw==
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
Subject: [PATCH 4.14 033/164] xen-netfront: Fix hang on device removal
Date: Sun, 22 Apr 2018 15:51:40 +0200
Message-Id: <20180422135136.765606258@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455501364355262?=
X-GMAIL-MSGID: =?utf-8?q?1598455501364355262?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2008,7 +2008,10 @@ static void netback_changed(struct xenbu
 	case XenbusStateInitialised:
 	case XenbusStateReconfiguring:
 	case XenbusStateReconfigured:
+		break;
+
 	case XenbusStateUnknown:
+		wake_up_all(&module_unload_q);
 		break;
 
 	case XenbusStateInitWait:
@@ -2139,7 +2142,9 @@ static int xennet_remove(struct xenbus_d
 		xenbus_switch_state(dev, XenbusStateClosing);
 		wait_event(module_unload_q,
 			   xenbus_read_driver_state(dev->otherend) ==
-			   XenbusStateClosing);
+			   XenbusStateClosing ||
+			   xenbus_read_driver_state(dev->otherend) ==
+			   XenbusStateUnknown);
 
 		xenbus_switch_state(dev, XenbusStateClosed);
 		wait_event(module_unload_q,
