Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E08DECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 11:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C933F214C1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 11:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C933F214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbeIWRcG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 13:32:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39926 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbeIWRcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 13:32:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2742A207CF; Sun, 23 Sep 2018 13:34:53 +0200 (CEST)
Received: from xps13 (AToulouse-657-1-1019-69.w90-11.abo.wanadoo.fr [90.11.225.69])
        by mail.bootlin.com (Postfix) with ESMTPSA id 51F4120723;
        Sun, 23 Sep 2018 13:34:52 +0200 (CEST)
Date:   Sun, 23 Sep 2018 13:34:51 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     <christophe.kerello@st.com>
Cc:     <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 2/3] mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND flash
 controller driver
Message-ID: <20180923133451.78c95cef@xps13>
In-Reply-To: <1537199260-7280-3-git-send-email-christophe.kerello@st.com>
References: <1537199260-7280-1-git-send-email-christophe.kerello@st.com>
        <1537199260-7280-3-git-send-email-christophe.kerello@st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

<christophe.kerello@st.com> wrote on Mon, 17 Sep 2018 17:47:39 +0200:

> From: Christophe Kerello <christophe.kerello@st.com>
> 
> The driver adds the support for the STMicroelectronics FMC2 NAND
> Controller found on STM32MP SOCs.
> 
> This patch is based on FMC2 command sequencer.
> The purpose of the command sequencer is to facilitate the programming
> and the reading of NAND flash pages with the ECC and to free the CPU
> of sequencing tasks.
> It requires one DMA channel for write and two DMA channels for read
> operations.
> 
> Only NAND_ECC_HW mode is actually supported.
> The driver supports a maximum 8k page size.
> The following ECC strength and step size are currently supported:
>  - nand-ecc-strength = <8>, nand-ecc-step-size = <512> (BCH8)
>  - nand-ecc-strength = <4>, nand-ecc-step-size = <512> (BCH4)
>  - nand-ecc-strength = <1>, nand-ecc-step-size = <512> (Extended ecc
>    based on HAMMING)
> 
> This patch has been tested on Micron MT29F8G08ABACAH4 and
> MT29F8G16ABACAH4
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> ---


[...]

> +/* NAND callbacks setup */
> +static void stm32_fmc2_nand_callbacks_setup(struct stm32_fmc2 *fmc2)
> +{
> +	struct nand_chip *chip = &fmc2->chip;
> +
> +	/* Specific callbacks to read/write a page */
> +	chip->ecc.correct = stm32_fmc2_ham_correct;
> +	chip->ecc.write_page = stm32_fmc2_sequencer_write_page;
> +	chip->ecc.read_page = stm32_fmc2_sequencer_read_page;
> +	chip->ecc.write_page_raw = stm32_fmc2_sequencer_write_page_raw;
> +	chip->ecc.read_page_raw = stm32_fmc2_sequencer_read_page_raw;

Are you sure all the tests in mtd-utils are successful?


Thanks,
Miquèl
