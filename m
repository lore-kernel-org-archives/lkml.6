Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57970C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D7620857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6mNW75p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D7620857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbeKIIJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:09:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:56444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729625AbeKIHhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:45 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 630EE2146D;
        Thu,  8 Nov 2018 22:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714417;
        bh=0BpoAWH5QQ6lybM2pJ3Tw7jjLe6Zp8Fl/jEBUHeLnmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6mNW75pvPfgn1lwNkUtgVnh9eAM8xFS/eHPD7fAk2Jgg3uzh8H0Mv/PMnLA31ibo
         TClLYbK70owfbDUAZVfKrY5gO6UMCDPGqF2BXpaXrmVAjtI+Zk4/Tm1Ij1scu5mkf9
         Xy7t25F0l/ShJ9cyTPykYFNkqPEd55GOjt6zoPZA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vladis Dronov <vdronov@redhat.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 040/114] [media] usbvision: revert commit 588afcc1
Date:   Thu,  8 Nov 2018 13:50:55 -0800
Message-Id: <20181108215104.742216131@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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



