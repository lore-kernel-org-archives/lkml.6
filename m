Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9849C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9A120652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9A120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeJEQ4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:56:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38312 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbeJEQ4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:56:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0DCC6207F0; Fri,  5 Oct 2018 11:58:20 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id B10DC2074F;
        Fri,  5 Oct 2018 11:58:09 +0200 (CEST)
Date:   Fri, 5 Oct 2018 11:58:09 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     <christophe.kerello@st.com>
Cc:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v2 2/3] mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND
 flash controller driver
Message-ID: <20181005115809.55356782@bbrezillon>
In-Reply-To: <1538732520-2800-3-git-send-email-christophe.kerello@st.com>
References: <1538732520-2800-1-git-send-email-christophe.kerello@st.com>
        <1538732520-2800-3-git-send-email-christophe.kerello@st.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2018 11:41:59 +0200
<christophe.kerello@st.com> wrote:

> +struct stm32_fmc2 {

You should inherit from nand_controller even if the nand_chip already
embeds a dummy nand controller object.

	struct nand_controller base;

> +	struct stm32_fmc2_nand nand;
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
> +	u8 cs_assigned;
> +	int cs_sel;
> +};
