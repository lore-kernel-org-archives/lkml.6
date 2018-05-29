Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935492AbeE2QAI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 12:00:08 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:41667 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934836AbeE2QAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 12:00:03 -0400
X-Google-Smtp-Source: ADUXVKL5m/0IdYzoh4lbqLGecyqqt8k07fLtjKx/oJC447Fp4FC/UnYaUUdDAav8dTR3CY+wIqZX35jFhgEXVTG4F8o=
MIME-Version: 1.0
References: <20180529150455.17300-1-peron.clem@gmail.com> <20180529150455.17300-5-peron.clem@gmail.com>
 <CAOMZO5AMK=vn7NCiQs-Ps-q=UyBro1J_+P4rTooU7nmHK20TjQ@mail.gmail.com>
In-Reply-To: <CAOMZO5AMK=vn7NCiQs-Ps-q=UyBro1J_+P4rTooU7nmHK20TjQ@mail.gmail.com>
From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date: Tue, 29 May 2018 17:59:51 +0200
Message-ID: <CAJiuCccEyrUfoKV4bh4qamn-MQntcFUdvHiLu2Y8aeQ--HdiDg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] clocksource: add driver for i.MX EPIT timer
To: festevam@gmail.com
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Colin Didier <colin.didier@devialet.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Cl=C3=A9ment_Peron?= <clement.peron@devialet.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4TG0CVc004950

Hi Fabio,
On Tue, 29 May 2018 at 17:20, Fabio Estevam <festevam@gmail.com> wrote:

> On Tue, May 29, 2018 at 12:04 PM, Clément Péron <peron.clem@gmail.com>
wrote:

> > +static int __init epit_timer_init(struct device_node *np)
> > +{
> > +       struct epit_timer *epittm;
> > +       struct clk *clk_ipg;
> > +       int ret;
> > +
> > +       epittm = kzalloc(sizeof(*epittm), GFP_KERNEL);
> > +       if (!epittm)
> > +               return -ENOMEM;
> > +
> > +       epittm->base = of_iomap(np, 0);
> > +       if (!epittm->base) {
> > +               ret = -ENXIO;
> > +               goto out_kfree;
> > +       }
> > +
> > +       epittm->irq = irq_of_parse_and_map(np, 0);
> > +       if (!epittm->irq) {
> > +               ret = -EINVAL;
> > +               goto out_kfree;

> You should jump to out_iounmap and call of_iounmap().

> > +       }
> > +
> > +       clk_ipg = of_clk_get_by_name(np, "ipg");
> > +       if (IS_ERR(clk_ipg)) {
> > +               pr_err("i.MX EPIT: unable to get clk_ipg\n");
> > +               ret = PTR_ERR(clk_ipg);
> > +               goto out_kfree;
> > +       }
> > +       clk_prepare_enable(clk_ipg);

> clk_prepare_enable() may fail, so better check its return value and
> propagate it in the case of error.

> > +
> > +       epittm->clk_per = of_clk_get_by_name(np, "per");
> > +       if (IS_ERR(epittm->clk_per)) {
> > +               pr_err("i.MX EPIT: unable to get clk_per\n");
> > +               ret = PTR_ERR(epittm->clk_per);
> > +               goto out_clk_ipg_disable;
> > +       }
> > +       clk_prepare_enable(epittm->clk_per);

> Ditto.

> > +
> > +       /*
> > +        * Initialise to a known state (all timers off, and timing
reset)
> > +        */

> For a single line of comment you could simply write:

> /* bla bla */

Thanks for the review, i will send a new version

Clement
