Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DFBC282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBC520823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rJhenRbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbfBFL3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:29:05 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13332 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfBFL3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:29:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549452563; x=1580988563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=gm13DbN1xZZTrIdgUQj2siWrVeO32meXm3sCV1CaE5M=;
  b=rJhenRbL/L0SrUT5W4+enwAF6a6hAFGepZowf6xplx9AyCnP3pQSWLO6
   7akJ1hyFTK6vPeRJIPuO8z2p/GItzZJPlpavbCOB1hqiSrWmBwauLcvAE
   5kQVoKMO38stQH8vtEai0q+RMXWEyfzeOBOnH3yD2eK+5qAzqA2OygtB7
   S4LDVkwlLWNZZG4U78Txjo3kX8jHi/X2euyYXvXtxM48JOocgOjpnR0jl
   g/7S+9JSTUNsjlY8iyyAjzqkEqW9IgzCRBBTkqc0Wb/sIxlvbUiGt46aq
   HhPa3M97qoITG3PPc6SR62+S38koKkUOdSjnAPrsTjhAoRfLPMKm9M/5d
   w==;
X-IronPort-AV: E=Sophos;i="5.56,564,1539619200"; 
   d="scan'208";a="198777078"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2019 19:29:22 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 06 Feb 2019 03:09:50 -0800
Received: from kfae422988.sdcorp.global.sandisk.com ([10.0.230.227])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2019 03:29:01 -0800
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 2/3] mmc: core: Indicate SD specs higher than 4.0
Date:   Wed,  6 Feb 2019 13:28:06 +0200
Message-Id: <1549452487-17193-3-git-send-email-avri.altman@wdc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549452487-17193-1-git-send-email-avri.altman@wdc.com>
References: <1549452487-17193-1-git-send-email-avri.altman@wdc.com>
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
index bd48b28..c2db94d 100644
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
index 8f429b6..d791813f 100644
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

