Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92791C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6082199D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6082199D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932782AbeGCIpW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:45:22 -0400
Received: from muru.com ([72.249.23.125]:49960 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754682AbeGCIpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:45:20 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CD89D8047;
        Tue,  3 Jul 2018 08:48:15 +0000 (UTC)
Date:   Tue, 3 Jul 2018 01:45:16 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Belisko Marek <marek.belisko@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Message-ID: <20180703084516.GT112168@atomide.com>
References: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Belisko Marek <marek.belisko@gmail.com> [180620 09:40]:
> Hello,
> 
> I'm trying to fix warning (for omap5 board) produced by recent change
> to avoid using IRQ_TYPE_NONE like:
> [    1.818666] WARNING: CPU: 1 PID: 778 at
> drivers/irqchip/irq-gic.c:1016 gic_irq_domain_translate+0x78/0x100
> [    1.828839] Modules linked in:
> 
> I did look to other commit which did update and without deep knowledge
> I just simply do this small change:
> diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi
> b/arch/arm/boot/dts/omap5-board-common.dtsi
> index 218892b..ab2df8c 100644
> --- a/arch/arm/boot/dts/omap5-board-common.dtsi
> +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
> @@ -393,7 +393,7 @@
> 
>         palmas: palmas@48 {
>                 compatible = "ti,palmas";
> -               interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* IRQ_SYS_1N */
> +               interrupts = <GIC_SPI 7 IRQ_TYPE_HIGH>; /* IRQ_SYS_1N */
>                 reg = <0x48>;
>                 interrupt-controller;
>                 #interrupt-cells = <2>;
> 
> and it looks board boots fine. Only issue is that gpadc driver is not
> working (at least not getting interrupts at all ADC fails with
> timeout). I did look to gpadc driver and driver is not using
> interrupts defined in dts but request interrupt directly from palmas
> mfd module. Any ideas what needs to be changed to have gpadc again
> working with mentioned patch?

Can you try with IRQF_TRIGGER_HIGH added also to the flags to
regmap_add_irq_chip() in drivers/mfd/palmas.c?

Regards,

Tony
