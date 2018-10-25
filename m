Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CB4C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A5C20883
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnAbmayU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A5C20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbeJYWuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:50:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729096AbeJYWum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:50:42 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B8F520840;
        Thu, 25 Oct 2018 14:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477065;
        bh=vHZeUB+S17KjwHiSZyIVA1ZchRkxFml+/Y1s0EE7+tE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bnAbmayUYfM6diPuhLg3QbzCvxw+W6wUqS4TS/NL+zauZ9eKNidXNVWs6BT1iD3WJ
         IGLuLtIasSdVuJdDTzcwwOoYJf60jaYH7nDQIIU1IZ1421rGEWz9zy+UYjoTfJ6jy1
         U/4kjErVoewGHrVmBr3I3T3OMoaU8o8jXgiB2oS4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladis Dronov <vdronov@redhat.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 22/65] [media] usbvision: revert commit 588afcc1
Date:   Thu, 25 Oct 2018 10:16:22 -0400
Message-Id: <20181025141705.213937-22-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladis Dronov <vdronov@redhat.com>

[ Upstream commit d5468d7afaa9c9e961e150f0455a14a9f4872a98 ]

Commit 588afcc1c0e4 ("[media] usbvision fix overflow of interfaces
array")' should be reverted, because:

* "!dev->actconfig->interface[ifnum]" won't catch a case where the value
is not NULL but some garbage. This way the system may crash later with
GPF.

* "(ifnum >= USB_MAXINTERFACES)" does not cover all the error
conditions. "ifnum" should be compared to "dev->actconfig->
desc.bNumInterfaces", i.e. compared to the number of "struct
usb_interface" kzalloc()-ed, not to USB_MAXINTERFACES.

* There is a "struct usb_device" leak in this error path, as there is
usb_get_dev(), but no usb_put_dev() on this path.

* There is a bug of the same type several lines below with number of
endpoints. The code is accessing hard-coded second endpoint
("interface->endpoint[1].desc") which may not exist. It would be great
to handle this in the same patch too.

* All the concerns above are resolved by already-accepted commit fa52bd50
("[media] usbvision: fix crash on detecting device with invalid
configuration")

* Mailing list message:
http://www.spinics.net/lists/linux-media/msg94832.html

Signed-off-by: Vladis Dronov <vdronov@redhat.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Cc: <stable@vger.kernel.org>      # for v4.5
Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/usbvision/usbvision-video.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/media/usb/usbvision/usbvision-video.c b/drivers/media/usb/usbvision/usbvision-video.c
index cafc34938a79..91d709efef7a 100644
--- a/drivers/media/usb/usbvision/usbvision-video.c
+++ b/drivers/media/usb/usbvision/usbvision-video.c
@@ -1461,13 +1461,6 @@ static int usbvision_probe(struct usb_interface *intf,
 	printk(KERN_INFO "%s: %s found\n", __func__,
 				usbvision_device_data[model].model_string);
 
-	/*
-	 * this is a security check.
-	 * an exploit using an incorrect bInterfaceNumber is known
-	 */
-	if (ifnum >= USB_MAXINTERFACES || !dev->actconfig->interface[ifnum])
-		return -ENODEV;
-
 	if (usbvision_device_data[model].interface >= 0)
 		interface = &dev->actconfig->interface[usbvision_device_data[model].interface]->altsetting[0];
 	else if (ifnum < dev->actconfig->desc.bNumInterfaces)
-- 
2.17.1

