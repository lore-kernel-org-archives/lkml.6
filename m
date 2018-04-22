Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/fuNOF9ARM6k6ZWRp/Pw1rVYi7u5nnAJhruPa6ZNLz9qFfXp5EYb3FkHN7lieT3vAXuQuH
ARC-Seal: i=1; a=rsa-sha256; t=1524406286; cv=none;
        d=google.com; s=arc-20160816;
        b=hhcJlvsbEfQBYdt6R60pbSM0HusFM+CrlkWVHupj0xAEAOcfJEVkMdvA/LNW/jjVRE
         GWvB/zC2eaISwpKivM89J4nFmTprJmh6ecodxFzBVGhaW60o+AA13rGSwx9QP/Imkl/E
         br5fmHBgP2zDdVJWwptmRjLdbvh+KVbP+QRxLgUTzK32ugfswNqEQLvTgLF689viTNLo
         lpHjoOd+RDuuR0Tl/iGKsRSpM9qIfQkL8sVV9fyXah87K1okK0YEQXyhBNB71QkYBJEt
         lKbJFQqMZtUJE6n8Ceusj7Sozu8BAKZYxYkJll8uLY2enLo3FGucDgzBLJLW9r9vBggl
         JTiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1ocXqAOC6GYXRP0dOul5+a+5P22Aw15Oa/GWm3ithxY=;
        b=t48ITfnlvHqr2v6FthfuE2lgvgzn2hnjwKoS6Dyl/z2cPEZcVsSDM3JcjC+8mJLD5x
         cJyno0dkyuBSWh9WR5r2E9REKfyr0GY5Vc4e460HcNPNJ3YhOJ5avdS35/UZO8iIkpZD
         YRSlwYhdpDRguYkuujYBbjlM5kUqAGFxsJM3KaTW1IHQRoSzOTB7WKRCr95z0gvWiHpR
         RJe/7C83gmngXM5LuLZESouHkxKQ5AfglVIpyWVUEX84GYqsuYjK6mn0v3xZLHt2trDo
         lNevvHR2ZuJKmX9VriDKnp1reFnde+r6zvPhOJNkNimCf0ed80g4j3NldO4D+4fz0nIS
         ZuTw==
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
Subject: [PATCH 4.9 16/95] xen-netfront: Fix hang on device removal
Date: Sun, 22 Apr 2018 15:52:45 +0200
Message-Id: <20180422135211.106716057@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455501364355262?=
X-GMAIL-MSGID: =?utf-8?q?1598455846995064718?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2038,7 +2038,10 @@ static void netback_changed(struct xenbu
 	case XenbusStateInitialised:
 	case XenbusStateReconfiguring:
 	case XenbusStateReconfigured:
+		break;
+
 	case XenbusStateUnknown:
+		wake_up_all(&module_unload_q);
 		break;
 
 	case XenbusStateInitWait:
@@ -2169,7 +2172,9 @@ static int xennet_remove(struct xenbus_d
 		xenbus_switch_state(dev, XenbusStateClosing);
 		wait_event(module_unload_q,
 			   xenbus_read_driver_state(dev->otherend) ==
-			   XenbusStateClosing);
+			   XenbusStateClosing ||
+			   xenbus_read_driver_state(dev->otherend) ==
+			   XenbusStateUnknown);
 
 		xenbus_switch_state(dev, XenbusStateClosed);
 		wait_event(module_unload_q,
