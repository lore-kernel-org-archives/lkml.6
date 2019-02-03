Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B6BC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0315920855
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TQndOTfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfBCIvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 03:51:20 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:10972 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfBCIvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 03:51:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549183879; x=1580719879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=uvIHv4YRB8ADXpT53jyv+XRLLwWBOTOF3+b4NWRgMFQ=;
  b=TQndOTfv/M0Zc03Rf7V+61D62qREJnjNs401K/690hft8QmXQuZVOjbm
   DHEjmwwbCIt8cDK6kaZNIH0RvMtuciuhoNidiUJ6D5KNjsrH/2lajTBqn
   FyG7UvC6uwgOzfqDr6gBNGgPIzXzA0nLzTZhSYQ6bE8soAFRzgCO+Qcoa
   y9kkdUq+m91Ie4ewtWfwUwmQv/3kwDA9fW+I/1C4EHk0knjFfW2/ggmJi
   c1wOHgHGjx/cz6x4xt+704roQygaGFmEb6BPx6xdl2EPEaO1SWMDphALv
   2RhFBgAu6alREO75NR5iiikv7eoKEg3ausLTRfeWAMhoNgnSUcGVtf6CO
   g==;
X-IronPort-AV: E=Sophos;i="5.56,555,1539619200"; 
   d="scan'208";a="102183788"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2019 16:51:19 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 03 Feb 2019 00:30:10 -0800
Received: from kfae422988.sdcorp.global.sandisk.com ([10.0.230.227])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Feb 2019 00:51:16 -0800
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 2/3] mmc: core: Indicate SD specs higher than 4.0
Date:   Sun,  3 Feb 2019 10:50:27 +0200
Message-Id: <1549183828-17316-3-git-send-email-avri.altman@wdc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549183828-17316-1-git-send-email-avri.altman@wdc.com>
References: <1549183828-17316-1-git-send-email-avri.altman@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SD specs version 4.x and 5.x have a dedicated slices in the SCR register.
Higher versions will rely on a combination of the existing fields.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/sd.c    | 5 +++++
 include/linux/mmc/card.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index d0d9f90..44f4cbc 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -209,6 +209,11 @@ static int mmc_decode_scr(struct mmc_card *card)
 		/* Check if Physical Layer Spec v3.0 is supported */
 		scr->sda_spec3 = UNSTUFF_BITS(resp, 47, 1);
 
+	if (scr->sda_spec3) {
+		scr->sda_spec4 = UNSTUFF_BITS(resp, 42, 1);
+		scr->sda_specx = UNSTUFF_BITS(resp, 38, 4);
+	}
+
 	if (UNSTUFF_BITS(resp, 55, 1))
 		card->erased_byte = 0xFF;
 	else
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 447648b..919e644 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -133,6 +133,8 @@ struct mmc_ext_csd {
 struct sd_scr {
 	unsigned char		sda_vsn;
 	unsigned char		sda_spec3;
+	unsigned char		sda_spec4;
+	unsigned char		sda_specx;
 	unsigned char		bus_widths;
 #define SD_SCR_BUS_WIDTH_1	(1<<0)
 #define SD_SCR_BUS_WIDTH_4	(1<<2)
-- 
1.9.1

