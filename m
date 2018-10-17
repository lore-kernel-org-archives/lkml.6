Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741FDECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F2B2148E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0RAmgjFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F2B2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbeJRC3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:29:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbeJRC3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:29:10 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C68021476;
        Wed, 17 Oct 2018 18:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539801134;
        bh=6jz7+gJ/Q97AzpykflWof4gbC1TERmI3QHYKYdh0zQg=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=0RAmgjFUCXo+ZbXkL+D+y84OoM0QOSKtmg+uqgaHZl3t139eKLBaEo573zYrptYsa
         Vj189uuILFi8t9YKNwMoUrlveW4saCY/y85gQIBYZxDSoDMBVVv7LmztLLS5vZ8uCs
         /p0tLQOyQKxWVWlN9xCZe6v7gmCbw7f971sdrUOQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180922181709.13007-3-gregory.clement@bootlin.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20180922181709.13007-1-gregory.clement@bootlin.com>
 <20180922181709.13007-3-gregory.clement@bootlin.com>
Message-ID: <153980113358.5275.6784587664499905114@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/6] clk: mvebu: add helper file for Armada AP and CP clocks
Date:   Wed, 17 Oct 2018 11:32:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gregory CLEMENT (2018-09-22 11:17:05)
> diff --git a/drivers/clk/mvebu/armada_ap_cp_helper.c b/drivers/clk/mvebu/=
armada_ap_cp_helper.c
> new file mode 100644
> index 000000000000..5f2457719b10
> --- /dev/null
> +++ b/drivers/clk/mvebu/armada_ap_cp_helper.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Marvell Armada AP and CP110 helper
> + *
> + * Copyright (C) 2018 Marvell
> + *
> + * Gregory Clement <gregory.clement@bootlin.com>
> + *
> + */
> +
> +#include "armada_ap_cp_helper.h"
> +#include <linux/device.h>
> +
> +char *ap_cp_unique_name(struct device *dev, struct device_node *np,
> +                       const char *name)
> +{
> +       const __be32 *reg;
> +       u64 addr;
> +
> +       /* Do not create a name if there is no clock */
> +       if (!name)
> +               return NULL;
> +
> +       reg =3D of_get_property(np, "reg", NULL);
> +       addr =3D of_translate_address(np, reg);
> +       return devm_kasprintf(dev, GFP_KERNEL, "%llx-%s",
> +                             (unsigned long long)addr, name);

We probably don't want to leak physical addresses into debugfs, but I
guess this is how it's already been, so maybe something in the future
should change this for security purposes.

> +}
> diff --git a/drivers/clk/mvebu/armada_ap_cp_helper.h b/drivers/clk/mvebu/=
armada_ap_cp_helper.h
> new file mode 100644
> index 000000000000..23aa29f3fcf7
> --- /dev/null
> +++ b/drivers/clk/mvebu/armada_ap_cp_helper.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __ARMADA_AP_CP_HELPER_H
> +#define __ARMADA_AP_CP_HELPER_H
> +
> +#include <linux/of.h>
> +#include <linux/of_address.h>

Drop these includes? And forward declare =


struct device;
struct device_node;

> +
> +char *ap_cp_unique_name(struct device *dev, struct device_node *np,
> +                       const char *name);
> +#endif
