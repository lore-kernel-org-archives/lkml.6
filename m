Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pKz0I1F/G1vlHwAAmS7hNA
	; Sat, 09 Jun 2018 07:18:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7AFE8608B8; Sat,  9 Jun 2018 07:18:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 067AC6032D;
	Sat,  9 Jun 2018 07:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 067AC6032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753201AbeFIHSi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 03:18:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50875 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753019AbeFIHSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 03:18:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4D16A207C0; Sat,  9 Jun 2018 09:18:34 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id BD53C20702;
        Sat,  9 Jun 2018 09:18:33 +0200 (CEST)
Date: Sat, 9 Jun 2018 09:18:33 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Stefan Agner <stefan@agner.ch>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, dev@lynxeye.de,
        miquel.raynal@bootlin.com, richard@nod.at, marcel@ziswiler.com,
        krzk@kernel.org, digetx@gmail.com, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, linux-mtd@lists.infradead.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
Message-ID: <20180609091833.1a20db07@bbrezillon>
In-Reply-To: <20180531221637.6017-5-stefan@agner.ch>
References: <20180531221637.6017-1-stefan@agner.ch>
        <20180531221637.6017-5-stefan@agner.ch>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Jun 2018 00:16:35 +0200
Stefan Agner <stefan@agner.ch> wrote:

> +
> +static int tegra_nand_chips_init(struct device *dev,
> +				 struct tegra_nand_controller *ctrl)
> +{
> +	struct device_node *np = dev->of_node;
> +	struct device_node *np_nand;
> +	int nchips = of_get_child_count(np);
> +	struct tegra_nand_chip *nand;
> +	struct mtd_info *mtd;
> +	struct nand_chip *chip;
> +	unsigned long config, bch_config = 0;
> +	int bits_per_step;
> +	int ret;
> +
> +	if (nchips != 1) {
> +		dev_err(dev, "Currently only one NAND chip supported\n");
> +		return -EINVAL;
> +	}
> +
> +	np_nand = of_get_next_child(np, NULL);
> +
> +	nand = devm_kzalloc(dev, sizeof(*nand), GFP_KERNEL);
> +	if (!nand)
> +		return -ENOMEM;
> +
> +	nand->wp_gpio = devm_gpiod_get_optional(dev, "wp", GPIOD_OUT_LOW);
> +
> +	if (IS_ERR(nand->wp_gpio)) {
> +		ret = PTR_ERR(nand->wp_gpio);
> +		dev_err(dev, "Failed to request WP GPIO: %d\n", ret);
> +		return ret;
> +	}
> +

You should retrieve the value of reg and store it somewhere in
tegra_nand_chip. ->select_chip() is passed a chip_CE id, and it has to
be converted into a ctrl_CE id. Right now you're assuming that ctrl_CE0
always drives chip_CE0, but that's not necessarily the case.

Also, you don't support multi-CE chips, so you should check the number
of entries in reg and fail if it's not 1.
