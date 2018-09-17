Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5656FECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187702146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187702146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732938AbeIREnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:43:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51096 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbeIREnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:43:45 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0E03A707;
        Mon, 17 Sep 2018 23:14:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brad Love <brad@nextdimension.cc>,
        Michael Ira Krufky <mkrufky@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 137/158] media: em28xx: Fix dual transport stream operation
Date:   Tue, 18 Sep 2018 00:42:47 +0200
Message-Id: <20180917211717.481554245@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brad Love <brad@nextdimension.cc>

[ Upstream commit a7853c257a3ea0907467a1750ff45de4d9ba1915 ]

Addresses the following, which introduced a regression itself:

Commit 509f89652f83 ("media: em28xx: fix a regression with HVR-950")

The regression fix breaks dual transport stream support. Currently,
when a tuner starts streaming it sets alt mode on the USB interface.
The problem is, in a dual tuner model, both tuners share the same
USB interface, so when the second tuner becomes active and sets alt
mode on the interface it kills streaming on the other port.

This patch addresses the regression by only setting alt mode
on the USB interface during em28xx_start_streaming, if the
device is not a dual tuner model. This allows all older and
single tuner devices to explicitly set alt mode during stream
startup. Testers report both isoc and bulk DualHD models work
correctly with the alt mode set only once, in em28xx_dvb_init.

Fixes: 509f89652f83 ("media: em28xx: fix a regression with HVR-950")
Signed-off-by: Brad Love <brad@nextdimension.cc>
Signed-off-by: Michael Ira Krufky <mkrufky@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/em28xx/em28xx-dvb.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/media/usb/em28xx/em28xx-dvb.c
+++ b/drivers/media/usb/em28xx/em28xx-dvb.c
@@ -218,7 +218,9 @@ static int em28xx_start_streaming(struct
 		dvb_alt = dev->dvb_alt_isoc;
 	}
 
-	usb_set_interface(udev, dev->ifnum, dvb_alt);
+	if (!dev->board.has_dual_ts)
+		usb_set_interface(udev, dev->ifnum, dvb_alt);
+
 	rc = em28xx_set_mode(dev, EM28XX_DIGITAL_MODE);
 	if (rc < 0)
 		return rc;


