Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbeB0SjL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 13:39:11 -0500
Received: from muru.com ([72.249.23.125]:58618 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751518AbeB0SjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 13:39:10 -0500
Date: Tue, 27 Feb 2018 10:39:08 -0800
From: Tony Lindgren <tony@atomide.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] regmap: irq: fix ack-invert
Message-ID: <20180227183908.GF5448@atomide.com>
References: <1519747558-17257-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519747558-17257-1-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tim Harvey <tharvey@gateworks.com> [180227 16:07]:
> When acking irqs we need to take into account the ack-invert case. Without
> this chips that require 0's to ACK interrupts will never clear the interrupt.
> 
> I am working on an mfd driver that will use ack-invert and discovered
> this issue. The only user of ack_invert currently appears to be the
> motorola-cpcap driver. I'm not clear why that driver doesn't appear affected
> so I'm cc'ing those involved with that driver for review and testing.

I gave this a quick try and it fails with cpcap. So yeah, you're right,
it seems we still have the cpcap config wrong.

Things do work with the following patch and your patch for cpcap. So
they should both be applied together as a single patch.

Care to fold in the following change and then repost your patch?

Otherwise we might end up breaking things easily for booting or
bisect or stable. Or else the patch below needs to be applied first
to avoid breaking things.

Regards,

Tony

8< -------
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -100,7 +100,6 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
 		.ack_base = CPCAP_REG_MI1,
 		.mask_base = CPCAP_REG_MIM1,
 		.use_ack = true,
-		.ack_invert = true,
 	},
 	{
 		.name = "cpcap-m2",
@@ -109,7 +108,6 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
 		.ack_base = CPCAP_REG_MI2,
 		.mask_base = CPCAP_REG_MIM2,
 		.use_ack = true,
-		.ack_invert = true,
 	},
 	{
 		.name = "cpcap1-4",
@@ -118,7 +116,6 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
 		.ack_base = CPCAP_REG_INT1,
 		.mask_base = CPCAP_REG_INTM1,
 		.use_ack = true,
-		.ack_invert = true,
 	},
 };
 
