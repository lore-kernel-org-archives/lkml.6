Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D24C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A91B2148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A91B2148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbeIXSYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:24:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56376 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732118AbeIXSYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:24:13 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E91B2107E;
        Mon, 24 Sep 2018 12:22:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Enrico Scholz <enrico.scholz@sigma-chemnitz.de>,
        Jan Luebbe <jlu@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 127/173] gpu: ipu-v3: csi: pass back mbus_code_to_bus_cfg error codes
Date:   Mon, 24 Sep 2018 13:52:41 +0200
Message-Id: <20180924113125.190073212@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>

[ Upstream commit d36d0e6309dd8137cf438cbb680e72eb63c81425 ]

mbus_code_to_bus_cfg() can fail on unknown mbus codes; pass back the
error to the caller.

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
[p.zabel@pengutronix.de - renamed rc to ret for consistency]
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/ipu-v3/ipu-csi.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

--- a/drivers/gpu/ipu-v3/ipu-csi.c
+++ b/drivers/gpu/ipu-v3/ipu-csi.c
@@ -316,13 +316,17 @@ static int mbus_code_to_bus_cfg(struct i
 /*
  * Fill a CSI bus config struct from mbus_config and mbus_framefmt.
  */
-static void fill_csi_bus_cfg(struct ipu_csi_bus_config *csicfg,
+static int fill_csi_bus_cfg(struct ipu_csi_bus_config *csicfg,
 				 struct v4l2_mbus_config *mbus_cfg,
 				 struct v4l2_mbus_framefmt *mbus_fmt)
 {
+	int ret;
+
 	memset(csicfg, 0, sizeof(*csicfg));
 
-	mbus_code_to_bus_cfg(csicfg, mbus_fmt->code);
+	ret = mbus_code_to_bus_cfg(csicfg, mbus_fmt->code);
+	if (ret < 0)
+		return ret;
 
 	switch (mbus_cfg->type) {
 	case V4L2_MBUS_PARALLEL:
@@ -353,6 +357,8 @@ static void fill_csi_bus_cfg(struct ipu_
 		/* will never get here, keep compiler quiet */
 		break;
 	}
+
+	return 0;
 }
 
 int ipu_csi_init_interface(struct ipu_csi *csi,
@@ -362,8 +368,11 @@ int ipu_csi_init_interface(struct ipu_cs
 	struct ipu_csi_bus_config cfg;
 	unsigned long flags;
 	u32 width, height, data = 0;
+	int ret;
 
-	fill_csi_bus_cfg(&cfg, mbus_cfg, mbus_fmt);
+	ret = fill_csi_bus_cfg(&cfg, mbus_cfg, mbus_fmt);
+	if (ret < 0)
+		return ret;
 
 	/* set default sensor frame width and height */
 	width = mbus_fmt->width;
@@ -584,11 +593,14 @@ int ipu_csi_set_mipi_datatype(struct ipu
 	struct ipu_csi_bus_config cfg;
 	unsigned long flags;
 	u32 temp;
+	int ret;
 
 	if (vc > 3)
 		return -EINVAL;
 
-	mbus_code_to_bus_cfg(&cfg, mbus_fmt->code);
+	ret = mbus_code_to_bus_cfg(&cfg, mbus_fmt->code);
+	if (ret < 0)
+		return ret;
 
 	spin_lock_irqsave(&csi->lock, flags);
 


