Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE51C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 00:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED52324A2D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 00:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e0leHNBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED52324A2D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934426AbeFWAJK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 20:09:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56616 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934067AbeFWAJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 20:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tPzwcgAWIsq5TLb4xL++0RO8jrnoI3vNaDhab0GzmTA=; b=e0leHNBQ80jDsJTztj/dvAHGkj
        T/J8prVPNHo9ib8wwktJq/AL2LJD1vNzA3VMAg2Vqn343ChTsdJ7rlv1em6XOaAyAWL55Hp9fmfHd
        RdGM7Pm+548kwW587HLkLocdwMKsQwQX9215zvMWkD3AmNGuco/NMpzi9LdjHRAnIM8U+JlJDUXSU
        KnOTt5Gmeyzi7RbyPVwEfWlaA1FmJg2rL3+eXrC2VtzM0YZfYXbODWDug8P8zWnfeL4TOR3PNcJHx
        CzGuo86rilnhvylrl5PMZ3l/2WBj6vnKfta3aK8rMaNaSASZYWYYYDi3TYCWgYmk0Z782VCAGLDHE
        XfOM7uxw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWW6u-0004AQ-Qf; Sat, 23 Jun 2018 00:09:01 +0000
Subject: Re: [PATCH 3/3] irqchip: RISC-V Local Interrupt Controller Driver
To:     Palmer Dabbelt <palmer@sifive.com>, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     aou@eecs.berkeley.edu, shorne@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Michael Clark <mjc@sifive.com>
References: <20180622232006.12158-1-palmer@sifive.com>
 <20180622232006.12158-4-palmer@sifive.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1d55b6ee-2fa4-269b-4166-ffd36646f61f@infradead.org>
Date:   Fri, 22 Jun 2018 17:08:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622232006.12158-4-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22/2018 04:20 PM, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@dabbelt.com>
> 
> This patch adds a driver that manages the local interrupts on each
> RISC-V hart, as specifiec by the RISC-V supervisor level ISA manual.
> The local interrupt controller manages software interrupts, timer
> interrupts, and hardware interrupts (which are routed via the
> platform level interrupt controller).  Per-hart local interrupt
> controllers are found on all RISC-V systems.
> 
> CC: Michael Clark <mjc@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>  drivers/irqchip/Kconfig          |  13 +++
>  drivers/irqchip/Makefile         |   1 +
>  drivers/irqchip/irq-riscv-intc.c | 215 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 229 insertions(+)
>  create mode 100644 drivers/irqchip/irq-riscv-intc.c
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index e9233db16e03..bf7fc86673b1 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -372,3 +372,16 @@ config QCOM_PDC
>  	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
>  
>  endmenu
> +
> +config RISCV_INTC
> +	#bool "RISC-V Interrupt Controller"

Hi,
What does the leading '#' do?


> +	depends on RISCV
> +	default y
> +	help
> +	   This enables support for the local interrupt controller found in
> +	   standard RISC-V systems.  The local interrupt controller handles
> +	   timer interrupts, software interrupts, and hardware interrupts.
> +	   Without a local interrupt controller the system will be unable to
> +	   handle any interrupts, including those passed via the PLIC.
> +
> +	   If you don't know what to do here, say Y.
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 15f268f646bf..74e333cc274c 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -87,3 +87,4 @@ obj-$(CONFIG_MESON_IRQ_GPIO)		+= irq-meson-gpio.o
>  obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
>  obj-$(CONFIG_NDS32)			+= irq-ativic32.o
>  obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
> +obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o


-- 
~Randy
