Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC38C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C9621476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rbn5Ew76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C9621476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbeJQBFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:05:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbeJQBFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:05:31 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8521A21476;
        Tue, 16 Oct 2018 17:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710048;
        bh=61HLWmjMG+d5+o8euj8GmgYc80sf5C/sjDUEbVPwqO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rbn5Ew76C5TVF4hmlX3f5AagH4EQrEj9y4kOJOA03WUTvUuptZ6V5WWVMRDeJINJ3
         MJx7WHp1VKRXB9W9EMhlrj2yfBzPMwb1s1tu2H2NWPOXAn557uuYhlTRtg2mkNZVRM
         QMkvRd0KNYMpRPuefSnMRBnIkGdISuXKBd6Ddps4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Akshu Agrawal <akshu.agrawal@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 080/135] ASoC: AMD: Ensure reset bit is cleared before configuring
Date:   Tue, 16 Oct 2018 19:05:10 +0200
Message-Id: <20181016170520.735706587@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
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

From: Akshu Agrawal <akshu.agrawal@amd.com>

[ Upstream commit 2a665dba016d5493c7d826fec82b0cb643b30d42 ]

HW register descriptions says:
"DMA Channel Reset...Software must confirm that this bit is
cleared before reprogramming any of the channel configuration registers."
There could be cases where dma stop errored out leaving dma channel
in reset state. We need to ensure that before the start of another dma,
channel is out of the reset state.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/amd/acp-pcm-dma.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/sizes.h>
 #include <linux/pm_runtime.h>
 
@@ -184,6 +185,24 @@ static void config_dma_descriptor_in_sra
 	acp_reg_write(descr_info->xfer_val, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
 }
 
+static void pre_config_reset(void __iomem *acp_mmio, u16 ch_num)
+{
+	u32 dma_ctrl;
+	int ret;
+
+	/* clear the reset bit */
+	dma_ctrl = acp_reg_read(acp_mmio, mmACP_DMA_CNTL_0 + ch_num);
+	dma_ctrl &= ~ACP_DMA_CNTL_0__DMAChRst_MASK;
+	acp_reg_write(dma_ctrl, acp_mmio, mmACP_DMA_CNTL_0 + ch_num);
+	/* check the reset bit before programming configuration registers */
+	ret = readl_poll_timeout(acp_mmio + ((mmACP_DMA_CNTL_0 + ch_num) * 4),
+				 dma_ctrl,
+				 !(dma_ctrl & ACP_DMA_CNTL_0__DMAChRst_MASK),
+				 100, ACP_DMA_RESET_TIME);
+	if (ret < 0)
+		pr_err("Failed to clear reset of channel : %d\n", ch_num);
+}
+
 /*
  * Initialize the DMA descriptor information for transfer between
  * system memory <-> ACP SRAM
@@ -238,6 +257,7 @@ static void set_acp_sysmem_dma_descripto
 		config_dma_descriptor_in_sram(acp_mmio, dma_dscr_idx,
 					      &dmadscr[i]);
 	}
+	pre_config_reset(acp_mmio, ch);
 	config_acp_dma_channel(acp_mmio, ch,
 			       dma_dscr_idx - 1,
 			       NUM_DSCRS_PER_CHANNEL,
@@ -277,6 +297,7 @@ static void set_acp_to_i2s_dma_descripto
 		config_dma_descriptor_in_sram(acp_mmio, dma_dscr_idx,
 					      &dmadscr[i]);
 	}
+	pre_config_reset(acp_mmio, ch);
 	/* Configure the DMA channel with the above descriptore */
 	config_acp_dma_channel(acp_mmio, ch, dma_dscr_idx - 1,
 			       NUM_DSCRS_PER_CHANNEL,


