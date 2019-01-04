Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC09C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704D721872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oQrwc2ct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfADRoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:44:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47728 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfADRoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K+r0Z+v02xjmU2y/PKLsxPYaN5hiG7cdr1EQnfCpDbQ=; b=oQrwc2ctnKcd+10xGSBfLoERB
        ccXEEZgUA8zQbMbqhgdFfEeE7O7zE5eOwguJcCj7LuZErdmodsosqLV9OAPFOnOOPM2burH+Cw39L
        WWA9qNR8fd4NMdYvJDs8edddd4yr6DR/9niZjYfSik3svnmQU3MV+xv44Gszrdosz5yls4FZjhiv9
        NXGG8LEgw/q6hq5bOipfIp5/tTkelSqwtHXgY7IicL9rUAqPlCEthWyFDGw+sgvtLzlPZIcjQk8oj
        cjCnolxDZLctlXx2xREpmDRE8TifQWKhiQbtDwUnMeR7OhjmKXKIfzWI3x4tjJxQeKneXarI+yxG3
        bH1YiQLzA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gfTVi-0002SE-R8; Fri, 04 Jan 2019 17:43:54 +0000
Date:   Fri, 4 Jan 2019 09:43:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mmc: sdhci: Properly set DMA mask
Message-ID: <20190104174354.GA18110@infradead.org>
References: <20190104104753.3383-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104104753.3383-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	u64 dma_mask = dma_get_mask(dev);

This is not a driver API.  I think what you want is
dma_get_required_mask to query the mask.  But in that case
you still need to always actually set a mask in the driver as well.

Something like this patch:

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a22e11a65658..36c61778d8f3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3500,6 +3500,13 @@ static int sdhci_set_dma_mask(struct sdhci_host *host)
 	struct device *dev = mmc_dev(mmc);
 	int ret = -EINVAL;
 
+	/*
+	 * Systems that can't address more than 32-bits do not need to use
+	 * 64-bit addressing mode, even if the device supports it.
+	 */
+	if (dma_get_required_mask(dev) <= DMA_BIT_MASK(32))
+		host->flags &= ~SDHCI_USE_64_BIT_DMA;
+
 	if (host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA)
 		host->flags &= ~SDHCI_USE_64_BIT_DMA;
 
