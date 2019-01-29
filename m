Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257EBC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E319E20880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763351;
	bh=w3k7zFYXaW8li8/Mb7uHIquxYTI77lkXCWRXTgjrqos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0rk+1MSj+TORhOEYYmpvhzBcUuByfcsW4YpWcSnNp2ahupaMbV51FkDeM15+r/woe
	 KYkaNsr6KtvU3uqJMuDWQa2F9W30NR+tX1xH23f0ON0foHYIPgaYfLm6ZBfVzXlwzK
	 ZUDRhTIzEFtO3cGodk/TPDP11GLPqRR6j6V1JB80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfA2Lol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:44:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730603AbfA2Log (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:44:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 913F32083B;
        Tue, 29 Jan 2019 11:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762276;
        bh=w3k7zFYXaW8li8/Mb7uHIquxYTI77lkXCWRXTgjrqos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A5QTqAqiNlljAOYjqA9TLZuxXLr2ZU7qQgDTWK8dNtMJ2KarEJJzJd4++DZgO5jvA
         iJIAbW2mqJ6Mt7Jc8pBoIs0gn0u9C079594Np7zIt2AtE6EyPaXPutg0Oecyar3v4V
         NPyLeQDJ83qKYQPhAnUs1D3himPCRHlkgZODJLzI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christian Lamparter <chunkeey@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: [PATCH 4.19 024/103] USB: leds: fix regression in usbport led trigger
Date:   Tue, 29 Jan 2019 12:35:01 +0100
Message-Id: <20190129113201.033832816@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Lamparter <chunkeey@gmail.com>

commit 91f7d2e89868fcac0e750a28230fdb1ad4512137 upstream.

The patch "usb: simplify usbport trigger" together with "leds: triggers:
add device attribute support" caused an regression for the usbport
trigger. it will no longer enumerate any active usb hub ports under the
"ports" directory in the sysfs class directory, if the usb host drivers
are fully initialized before the usbport trigger was loaded.

The reason is that the usbport driver tries to register the sysfs
entries during the activate() callback. And this will fail with -2 /
ENOENT because the patch "leds: triggers: add device attribute support"
made it so that the sysfs "ports" group was only being added after the
activate() callback succeeded.

This version of the patch reverts parts of the "usb: simplify usbport
trigger" patch and restores usbport trigger's functionality.

Fixes: 6f7b0bad8839 ("usb: simplify usbport trigger")
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Cc: stable <stable@vger.kernel.org>
Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/ledtrig-usbport.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

--- a/drivers/usb/core/ledtrig-usbport.c
+++ b/drivers/usb/core/ledtrig-usbport.c
@@ -119,11 +119,6 @@ static const struct attribute_group port
 	.attrs = ports_attrs,
 };
 
-static const struct attribute_group *ports_groups[] = {
-	&ports_group,
-	NULL
-};
-
 /***************************************
  * Adding & removing ports
  ***************************************/
@@ -307,6 +302,7 @@ static int usbport_trig_notify(struct no
 static int usbport_trig_activate(struct led_classdev *led_cdev)
 {
 	struct usbport_trig_data *usbport_data;
+	int err;
 
 	usbport_data = kzalloc(sizeof(*usbport_data), GFP_KERNEL);
 	if (!usbport_data)
@@ -315,6 +311,9 @@ static int usbport_trig_activate(struct
 
 	/* List of ports */
 	INIT_LIST_HEAD(&usbport_data->ports);
+	err = sysfs_create_group(&led_cdev->dev->kobj, &ports_group);
+	if (err)
+		goto err_free;
 	usb_for_each_dev(usbport_data, usbport_trig_add_usb_dev_ports);
 	usbport_trig_update_count(usbport_data);
 
@@ -322,8 +321,11 @@ static int usbport_trig_activate(struct
 	usbport_data->nb.notifier_call = usbport_trig_notify;
 	led_set_trigger_data(led_cdev, usbport_data);
 	usb_register_notify(&usbport_data->nb);
-
 	return 0;
+
+err_free:
+	kfree(usbport_data);
+	return err;
 }
 
 static void usbport_trig_deactivate(struct led_classdev *led_cdev)
@@ -335,6 +337,8 @@ static void usbport_trig_deactivate(stru
 		usbport_trig_remove_port(usbport_data, port);
 	}
 
+	sysfs_remove_group(&led_cdev->dev->kobj, &ports_group);
+
 	usb_unregister_notify(&usbport_data->nb);
 
 	kfree(usbport_data);
@@ -344,7 +348,6 @@ static struct led_trigger usbport_led_tr
 	.name     = "usbport",
 	.activate = usbport_trig_activate,
 	.deactivate = usbport_trig_deactivate,
-	.groups = ports_groups,
 };
 
 static int __init usbport_trig_init(void)


