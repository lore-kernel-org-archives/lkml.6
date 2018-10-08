Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABB2C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7122089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7122089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeJICYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:24:20 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58376 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbeJICYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:24:19 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 240C420DCD; Mon,  8 Oct 2018 21:11:04 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id BD35F20CFE;
        Mon,  8 Oct 2018 21:10:53 +0200 (CEST)
Date:   Mon, 8 Oct 2018 21:10:53 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     linux-mtd@lists.infradead.org, marek.vasut@gmail.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Message-ID: <20181008211053.71171cff@bbrezillon>
In-Reply-To: <1538997103-11152-2-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1538997103-11152-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1538997103-11152-2-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 Oct 2018 16:41:39 +0530
Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> +/* Registers used by the driver */
> +#define FSPI_MCR0			0x00
> +#define FSPI_MCR0_AHB_TIMEOUT_MASK	GENMASK(31, 24)
> +#define FSPI_MCR0_IP_TIMEOUT_MASK	GENMASK(23, 16)

You never mask the IP_TIMEOUT val, so you don't need a _MASK macro
here. Just define

#define FSPI_MCR0_IP_TIMEOUT(x)		((x) < 16)

The same goes for any field that you don't need to mask.

The only case you might need a mask def is when you have the following
pattern:

	val = readl(reg);
	val &= ~XXXX_MASK;
	val |= XXXX(new_field_val);
	writel(val, reg);

> +#define FSPI_MCR0_LEARN_EN_MASK		BIT(15)
> +#define FSPI_MCR0_SCRFRUN_EN_MASK	BIT(14)
> +#define FSPI_MCR0_OCTCOMB_EN_MASK	BIT(13)

Drop the _MASK suffix for any single-bit field:

#define FSPI_MCR0_OCTCOMB_EN		BIT(13)
