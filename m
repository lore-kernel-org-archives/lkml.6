Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935017AbeE2PVA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:21:00 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42447 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754977AbeE2PU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:20:56 -0400
X-Google-Smtp-Source: AB8JxZpk2uU20nWO63TzSi5roaf4s3sn/VfC6TvWFX2idKp6ViwCQKcFU7FglEHhcW0KlcXCjJo83H6gJWAOCK6Kw/Q=
MIME-Version: 1.0
In-Reply-To: <20180529150455.17300-5-peron.clem@gmail.com>
References: <20180529150455.17300-1-peron.clem@gmail.com> <20180529150455.17300-5-peron.clem@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 29 May 2018 12:20:55 -0300
Message-ID: <CAOMZO5AMK=vn7NCiQs-Ps-q=UyBro1J_+P4rTooU7nmHK20TjQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] clocksource: add driver for i.MX EPIT timer
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Colin Didier <colin.didier@devialet.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Cl=C3=A9ment_Peron?= <clement.peron@devialet.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4TFL4MX000919

On Tue, May 29, 2018 at 12:04 PM, Clément Péron <peron.clem@gmail.com> wrote:

> +static int __init epit_timer_init(struct device_node *np)
> +{
> +       struct epit_timer *epittm;
> +       struct clk *clk_ipg;
> +       int ret;
> +
> +       epittm = kzalloc(sizeof(*epittm), GFP_KERNEL);
> +       if (!epittm)
> +               return -ENOMEM;
> +
> +       epittm->base = of_iomap(np, 0);
> +       if (!epittm->base) {
> +               ret = -ENXIO;
> +               goto out_kfree;
> +       }
> +
> +       epittm->irq = irq_of_parse_and_map(np, 0);
> +       if (!epittm->irq) {
> +               ret = -EINVAL;
> +               goto out_kfree;

You should jump to out_iounmap and call of_iounmap().

> +       }
> +
> +       clk_ipg = of_clk_get_by_name(np, "ipg");
> +       if (IS_ERR(clk_ipg)) {
> +               pr_err("i.MX EPIT: unable to get clk_ipg\n");
> +               ret = PTR_ERR(clk_ipg);
> +               goto out_kfree;
> +       }
> +       clk_prepare_enable(clk_ipg);

clk_prepare_enable() may fail, so better check its return value and
propagate it in the case of error.

> +
> +       epittm->clk_per = of_clk_get_by_name(np, "per");
> +       if (IS_ERR(epittm->clk_per)) {
> +               pr_err("i.MX EPIT: unable to get clk_per\n");
> +               ret = PTR_ERR(epittm->clk_per);
> +               goto out_clk_ipg_disable;
> +       }
> +       clk_prepare_enable(epittm->clk_per);

Ditto.

> +
> +       /*
> +        * Initialise to a known state (all timers off, and timing reset)
> +        */

For a single line of comment you could simply write:

/* bla bla */
