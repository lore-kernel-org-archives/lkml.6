Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08BFECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD8D20676
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD8D20676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbeIXX1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:27:20 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46826 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeIXX1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:27:20 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B65F220731; Mon, 24 Sep 2018 19:24:06 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7065720379;
        Mon, 24 Sep 2018 19:23:56 +0200 (CEST)
Date:   Mon, 24 Sep 2018 19:23:56 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     <christophe.kerello@st.com>
Cc:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 2/3] mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND flash
 controller driver
Message-ID: <20180924192356.5f2e56fd@bbrezillon>
In-Reply-To: <1537199260-7280-3-git-send-email-christophe.kerello@st.com>
References: <1537199260-7280-1-git-send-email-christophe.kerello@st.com>
        <1537199260-7280-3-git-send-email-christophe.kerello@st.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Mon, 17 Sep 2018 17:47:39 +0200
<christophe.kerello@st.com> wrote:

> +struct stm32_fmc2 {
> +	struct nand_chip chip;
> +	struct device *dev;
> +	void __iomem *io_base;
> +	void __iomem *data_base[FMC2_MAX_CE];
> +	void __iomem *cmd_base[FMC2_MAX_CE];
> +	void __iomem *addr_base[FMC2_MAX_CE];
> +	phys_addr_t io_phys_addr;
> +	phys_addr_t data_phys_addr[FMC2_MAX_CE];
> +	struct clk *clk;
> +
> +	struct dma_chan *dma_tx_ch;
> +	struct dma_chan *dma_rx_ch;
> +	struct dma_chan *dma_ecc_ch;
> +	struct sg_table dma_data_sg;
> +	struct sg_table dma_ecc_sg;
> +	u8 *ecc_buf;
> +	int dma_ecc_len;
> +
> +	struct completion complete;
> +	struct completion dma_data_complete;
> +	struct completion dma_ecc_complete;
> +
> +	struct stm32_fmc2_timings timings;
> +	u8 cs_assigned;
> +	int cs_sel;
> +	int ncs;
> +	int cs_used[FMC2_MAX_CE];
> +};

Can we have a clear separation between the NAND controller and NAND
chip structures. I know you only support a single chip per-controller
right now, but I prefer to have things clearly separated from the
beginning. 

Regards,

Boris
