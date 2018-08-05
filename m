Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D25C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 17:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483A6218C1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 17:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483A6218C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbeHETed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 15:34:33 -0400
Received: from foss.arm.com ([217.140.101.70]:58586 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbeHETed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 15:34:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7459C7A9;
        Sun,  5 Aug 2018 10:29:15 -0700 (PDT)
Received: from why.lan (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 280AC3F2EA;
        Sun,  5 Aug 2018 10:29:13 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: analogix_dp: Downgrade "Link Training" messages to dev_dbg
Date:   Sun,  5 Aug 2018 18:28:57 +0100
Message-Id: <20180805172857.2517-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Analogix DP bridge driver is pretty verbose, and outputs
things like

[  619.414067] rockchip-dp ff970000.edp: Link Training Clock Recovery success
[  619.429233] rockchip-dp ff970000.edp: Link Training success!

each time the display gets unblanked. While it is good to know
that the device is behaving correctly, users already know that
because they can see some video output.

Let's keep these messages for cases where we need to actually
debug the driver (we have dynamic debug to enable them at runtime
if need be), and let's keep the kernel quiet otherwise.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 2bcbfadb6ac5..0d715a375ff9 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -554,7 +554,7 @@ static int analogix_dp_process_clock_recovery(struct analogix_dp_device *dp)
 		if (retval < 0)
 			return retval;
 
-		dev_info(dp->dev, "Link Training Clock Recovery success\n");
+		dev_dbg(dp->dev, "Link Training Clock Recovery success\n");
 		dp->link_train.lt_state = EQUALIZER_TRAINING;
 	} else {
 		for (lane = 0; lane < lane_count; lane++) {
@@ -634,7 +634,7 @@ static int analogix_dp_process_equalizer_training(struct analogix_dp_device *dp)
 		if (retval < 0)
 			return retval;
 
-		dev_info(dp->dev, "Link Training success!\n");
+		dev_dbg(dp->dev, "Link Training success!\n");
 		analogix_dp_get_link_bandwidth(dp, &reg);
 		dp->link_train.link_rate = reg;
 		dev_dbg(dp->dev, "final bandwidth = %.2x\n",
-- 
2.14.2

