Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F08EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FC820675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blMUPvSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeLQGKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 01:10:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41574 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeLQGKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 01:10:52 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so5814921pfi.8;
        Sun, 16 Dec 2018 22:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rrPidn3rCN1gHde9WS6H9hYiiDsvp4RLivG2flEdvlk=;
        b=blMUPvSBlOZ4uFE5q1H1udAJXgg0w04eMD/g7rD+4LvQbtI7zu7TZ8rG0IqmjV/q8q
         ZVy4+xDbjkyeQE41oUgHl2YGGn9dWfjClBlvR9E0iDaP4yUCk6qBhxjsbY4wzCzjzKYc
         4wBzA3Vb7B/xhbZ61NI/wn7ETuzHUx3/KU15i97JE7eFLuqeDX3ygo3VZ52EYjkC412k
         wPGE7/sekte3m8ShHd5jqGeFPCFGm+tZTHRQ3SmEL2UMsfaJ9RpwTsLd2OEnkhAAYIIn
         AmSnA2/5SVPPFVvw9Csfg+6e51SGcS+rg8AGrvNpdLvOpPF3bhAl/zeyQzH1ECaWXBk9
         ILfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rrPidn3rCN1gHde9WS6H9hYiiDsvp4RLivG2flEdvlk=;
        b=OSU3f3RkUo06d+1pXSMEGBpSbwrcJUHQrGyIEgXPH1mptJ81BYmI+e3D7FLhPCqzAf
         64tBR7cK7tbIm96gPagm7Elsg4mE7FqaIfcEdHVqgcPEmGFW/L9TJHAgbxWRBRzUJBIv
         STmx7NaqZe5PAD5GKyvBb0ZdA/K5xm4zupk2U1B1fuVg5rt/MY3D7QqUbCk61bGjIa4V
         /KfvitU/gXgQLKpPr19UywL8Q3QPURhmsrFDa4D7x3lUgoT41pGqUzhbo2W44gE6YUrg
         Be8SDd07YISaMTNKyayMYb2rrcBI/KszEQLO/YMHnIcpGYJgdgIABwdhwIrhuXYwxFKm
         NPCA==
X-Gm-Message-State: AA+aEWbUMzKYbLHc7RHt0EelYQZBUSmNBzde/ay+gcXPSDUyeeZ6a0OL
        +wSTLqmwcNd5lHKvmrFOfvD5dO81gQE=
X-Google-Smtp-Source: AFSGD/VBrF1y/JA5yAviHXPjqhhISt4mZ0VXMNkqDt7X7Uyv134ivoJ9Q4wF1uD+YHo7dbrl3bOiOQ==
X-Received: by 2002:a63:451a:: with SMTP id s26mr11234997pga.150.1545027051210;
        Sun, 16 Dec 2018 22:10:51 -0800 (PST)
Received: from localhost (27-32-189-129.static.tpgi.com.au. [27.32.189.129])
        by smtp.gmail.com with ESMTPSA id v184sm16680890pfb.182.2018.12.16.22.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 22:10:50 -0800 (PST)
From:   Andrew Worsley <amworsley@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bin Liu <b-liu@ti.com>, Benson Leung <bleung@chromium.org>,
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     Andrew Worsley <amworsley@gmail.com>
Subject: [PATCH] Prevent race condition between USB authorisation and USB discovery events
Date:   Mon, 17 Dec 2018 17:10:33 +1100
Message-Id: <20181217061036.24143-1-amworsley@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A sysfs driven USB authorisation change can trigger a usb_set_configuration
while a hub_event worker thread is running. This can result in a USB device
being disabled just after it was configured and bringing down all the
devices and impacting hardware and user processes that were established on
top of this these interfaces. In some cases the USB disable never completed
and the whole system hung.

At my work I had an occasional hang due to this race condition. Roughly 1
in 50 boots had the race occurrence and 1 in 4 of those resulted in a hang.
This patch fixed the problem and I had no problems (spurious disables
or hangs) in 750+ boots.

Signed-off-by: Andrew Worsley <amworsley@gmail.com>
---
 drivers/usb/core/hub.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index f76b2e0aba9d..dabd07aa8602 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -51,6 +51,9 @@ static DEFINE_SPINLOCK(device_state_lock);
 static struct workqueue_struct *hub_wq;
 static void hub_event(struct work_struct *work);
 
+/* synchronize hub_event and authorize_device operations */
+DEFINE_MUTEX(usb_authorize_mutex);
+
 /* synchronize hub-port add/remove and peering operations */
 DEFINE_MUTEX(usb_port_peer_mutex);
 
@@ -2538,6 +2541,7 @@ int usb_new_device(struct usb_device *udev)
  */
 int usb_deauthorize_device(struct usb_device *usb_dev)
 {
+	mutex_lock(&usb_authorize_mutex);
 	usb_lock_device(usb_dev);
 	if (usb_dev->authorized == 0)
 		goto out_unauthorized;
@@ -2547,6 +2551,7 @@ int usb_deauthorize_device(struct usb_device *usb_dev)
 
 out_unauthorized:
 	usb_unlock_device(usb_dev);
+	mutex_unlock(&usb_authorize_mutex);
 	return 0;
 }
 
@@ -2555,6 +2560,7 @@ int usb_authorize_device(struct usb_device *usb_dev)
 {
 	int result = 0, c;
 
+	mutex_lock(&usb_authorize_mutex);
 	usb_lock_device(usb_dev);
 	if (usb_dev->authorized == 1)
 		goto out_authorized;
@@ -2596,6 +2602,7 @@ int usb_authorize_device(struct usb_device *usb_dev)
 error_autoresume:
 out_authorized:
 	usb_unlock_device(usb_dev);	/* complements locktree */
+	mutex_unlock(&usb_authorize_mutex);
 	return result;
 }
 
@@ -5320,6 +5327,7 @@ static void hub_event(struct work_struct *work)
 	hub_dev = hub->intfdev;
 	intf = to_usb_interface(hub_dev);
 
+	mutex_lock(&usb_authorize_mutex);
 	dev_dbg(hub_dev, "state %d ports %d chg %04x evt %04x\n",
 			hdev->state, hdev->maxchild,
 			/* NOTE: expects max 15 ports... */
@@ -5422,6 +5430,7 @@ static void hub_event(struct work_struct *work)
 	usb_autopm_put_interface_no_suspend(intf);
 out_hdev_lock:
 	usb_unlock_device(hdev);
+	mutex_unlock(&usb_authorize_mutex);
 
 	/* Balance the stuff in kick_hub_wq() and allow autosuspend */
 	usb_autopm_put_interface(intf);
-- 
2.19.2

