Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EDCECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02192083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02192083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388836AbeIXSno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:43:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59186 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729543AbeIXSnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:43:43 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 42F7B109E;
        Mon, 24 Sep 2018 12:41:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 181/235] mmc: sdhci-of-esdhc: set proper dma mask for ls104x chips
Date:   Mon, 24 Sep 2018 13:52:47 +0200
Message-Id: <20180924113122.725579060@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

[ Upstream commit 5552d7ad596c3fea953f40fef74170ce0760c04d ]

SDHCI controller in ls1043a and ls1046a generate 40-bit wide addresses
when doing DMA. Make sure that the corresponding dma mask is correctly
configured.

Context: when enabling smmu on these chips the following problem is
encountered: the smmu input address size is 48 bits so the dma mappings
for sdhci end up 48-bit wide. However, on these chips sdhci only use
40-bits of that address size when doing dma.
So you end up with a 48-bit address translation in smmu but the device
generates transactions with clipped 40-bit addresses, thus smmu context
faults are triggered. Setting up the correct dma mask fixes this
situation.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-of-esdhc.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -22,6 +22,7 @@
 #include <linux/sys_soc.h>
 #include <linux/clk.h>
 #include <linux/ktime.h>
+#include <linux/dma-mapping.h>
 #include <linux/mmc/host.h>
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
@@ -427,6 +428,11 @@ static void esdhc_of_adma_workaround(str
 static int esdhc_of_enable_dma(struct sdhci_host *host)
 {
 	u32 value;
+	struct device *dev = mmc_dev(host->mmc);
+
+	if (of_device_is_compatible(dev->of_node, "fsl,ls1043a-esdhc") ||
+	    of_device_is_compatible(dev->of_node, "fsl,ls1046a-esdhc"))
+		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
 
 	value = sdhci_readl(host, ESDHC_DMA_SYSCTL);
 	value |= ESDHC_DMA_SNOOP;


