Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE818C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC8D2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC8D2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbeLGKSV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:18:21 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50384 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbeLGKSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:18:21 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2026920CC5; Fri,  7 Dec 2018 11:18:19 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id B4FA72073D;
        Fri,  7 Dec 2018 11:18:08 +0100 (CET)
Date:   Fri, 7 Dec 2018 11:18:08 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [ v3 2/3] mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND flash
 controller driver
Message-ID: <20181207111808.144fc3f0@xps13>
In-Reply-To: <1543509663-26128-3-git-send-email-christophe.kerello@st.com>
References: <1543509663-26128-1-git-send-email-christophe.kerello@st.com>
        <1543509663-26128-3-git-send-email-christophe.kerello@st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Christophe Kerello <christophe.kerello@st.com> wrote on Thu, 29 Nov
2018 17:41:02 +0100:

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
>  - nand-ecc-strength = <1>, nand-ecc-step-size = <512> (Extended ECC
>    based on Hamming)
> 
> This patch has been tested on Micron MT29F8G08ABACAH4 and
> MT29F8G16ABACAH4
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> ---

The driver look's good to me. However, Boris contributed new
cleanups that I would like you to take into account before doing
another 'deep' review. Please rebase on top of nand/next and have
a look at the followingcommits. For the ->select_chip() hook, it
should not be exposed anymore and switches should be handled
locally by the driver (you have examples).

7a08dbaedd36 mtd: rawnand: Move ->setup_data_interface() to nand_controller_ops
f2abfeb2078b mtd: rawnand: Move the ->exec_op() method to nand_controller_ops
7d6c37e90cf9 mtd: rawnand: Deprecate the ->select_chip() hook
1770022ffa85 mtd: rawnand: ams-delta: Stop implementing ->select_chip()
653c57c7da08 mtd: rawnand: vf610: Stop implementing ->select_chip()
2ace451cae22 mtd: rawnand: tegra: Stop implementing ->select_chip()
b25251414f6e mtd: rawnand: marvell: Stop implementing ->select_chip()
550b9fc4e3af mtd: rawnand: fsmc: Stop implementing ->select_chip()
02b4a52604a4 mtd: rawnand: Make ->select_chip() optional when ->exec_op() is implemented
ae2294b10b0f mtd: rawnand: Pass the CS line to be selected in struct nand_operation
1d0178593d14 mtd: rawnand: Add nand_[de]select_target() helpers

While at it, could you also address Linus W. comments.

Thanks,
Miquèl
