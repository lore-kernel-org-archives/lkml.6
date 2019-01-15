Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EAFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8741B20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389334AbfAOT2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:28:45 -0500
Received: from muru.com ([72.249.23.125]:33782 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728780AbfAOT2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:28:45 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7246E8022;
        Tue, 15 Jan 2019 19:28:50 +0000 (UTC)
Date:   Tue, 15 Jan 2019 11:28:40 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Belisko Marek <marek.belisko@gmail.com>,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Keerthy <j-keerthy@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org
Subject: Regression in v5.0-rc with regmap-irq level-irq changes
Message-ID: <20190115192840.GK5544@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks like commit 1c2928e3e321 ("regmap: regmap-irq/gpio-max77620: add
level-irq support") caused a regression at least with palmas PMIC where
child interrupt no longer work and we get something like this on
omap5-uevm for example:

genirq: Setting trigger mode 3 for irq 157 failed
(regmap_irq_set_type+0x0/0x15c)
genirq: Setting trigger mode 12 for irq 154 failed
(regmap_irq_set_type+0x0/0x15c)
genirq: Setting trigger mode 8 for irq 149 failed
(regmap_irq_set_type+0x0/0x15c)

These are for child devices like power button, USB and RTC interrupts.
I'd also assume GPIOs might be broken now.

Any ideas what's needed? Some triggering mapping data to palmas.c
driver?

To me it seems the child device interrupt triggering can be whatever
the hardware supports including IRQ_TYPE_NONE for non-configurable
interrupts. Additionally palmas.c supports inverting the SoC
interrupt also.

Not sure if other things are broken now too, it might be worth
grepping the logs at kernelci.org for similar genirq errors above?

Regards,

Tony
