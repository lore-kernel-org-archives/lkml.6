Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2978C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF8120862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF8120862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732932AbeHAT4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:56:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50270 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405745AbeHATIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:36 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C36C1114A;
        Wed,  1 Aug 2018 17:05:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brad Love <brad@nextdimension.cc>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 227/336] media: em28xx: fix a regression with HVR-950
Date:   Wed,  1 Aug 2018 18:49:22 +0200
Message-Id: <20180801165037.757950162@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

[ Upstream commit 509f89652f83e834b3ef7a083e2eeac812b055f0 ]

Commit be7fd3c3a8c5 ("media: em28xx: Hauppauge DualHD second tuner
functionality") removed the logic with sets the alternate for the DVB
device. Without setting the right alternate, the device won't be
able to submit URBs, and userspace fails with -EMSGSIZE:

	ERROR     DMX_SET_PES_FILTER failed (PID = 0x2000): 90 Message too long

Tested with Hauppauge HVR-950 model A1C0.

Fixes: be7fd3c3a8c5 ("media: em28xx: Hauppauge DualHD second tuner functionality")

Cc: Brad Love <brad@nextdimension.cc>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/em28xx/em28xx-dvb.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/media/usb/em28xx/em28xx-dvb.c
+++ b/drivers/media/usb/em28xx/em28xx-dvb.c
@@ -199,6 +199,7 @@ static int em28xx_start_streaming(struct
 	int rc;
 	struct em28xx_i2c_bus *i2c_bus = dvb->adapter.priv;
 	struct em28xx *dev = i2c_bus->dev;
+	struct usb_device *udev = interface_to_usbdev(dev->intf);
 	int dvb_max_packet_size, packet_multiplier, dvb_alt;
 
 	if (dev->dvb_xfer_bulk) {
@@ -217,6 +218,7 @@ static int em28xx_start_streaming(struct
 		dvb_alt = dev->dvb_alt_isoc;
 	}
 
+	usb_set_interface(udev, dev->ifnum, dvb_alt);
 	rc = em28xx_set_mode(dev, EM28XX_DIGITAL_MODE);
 	if (rc < 0)
 		return rc;


