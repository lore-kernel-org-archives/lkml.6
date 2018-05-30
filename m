Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753698AbeE3Rm7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 13:42:59 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44584 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753190AbeE3Rmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 13:42:54 -0400
X-Google-Smtp-Source: ADUXVKJtgMrpuzhez2+eOpuXSdLli/iRjTu6W9zNNbM1KV8XGwjRXNKcTSNAj8LoJRD/Z5vpBEKsrQ==
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 5/6 v2] mtd: rawnand: ams-delta: use GPIO lookup table
Date: Wed, 30 May 2018 19:43:09 +0200
Message-ID: <1543045.tPZatK9yHU@z50>
In-Reply-To: <20180530110500.185b5b7b@bbrezillon>
References: <CAHp75Ved2nw1JKnXT2Jxnw4XLsby1eVJU6cfBjE2sp4LP4Kwmg@mail.gmail.com> <20180525222046.11200-1-jmkrzyszt@gmail.com> <20180530110500.185b5b7b@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 30, 2018 11:05:00 AM CEST Boris Brezillon wrote:
> Hi Janusz,

Hi Boris,

> On Sat, 26 May 2018 00:20:45 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> > ...
> > Changes since v1:
> > - fix handling of devm_gpiod_get_optional() return values - thanks to
> >   Andy Shevchenko.
> 
> Can you put the changelog after the "---" separator so that it does not
> appear in the final commit message?

Yes, sure, sorry for that.

> > +err_gpiod:
> > +	if (err == -ENODEV || err == -ENOENT)
> > +		err = -EPROBE_DEFER;
> 
> Hm, isn't it better to make gpiod_find() return ERR_PTR(-EPROBE_DEFER)
> here [1]? At least, ENOENT should not be turned into EPROBE_DEFER,
> because it's returned when there's no entry matching the requested gpio
> in the lookup table, and deferring the probe won't solve this problem.

ENOENT is also returned when no matching lookup table is found. That may 
happen if consumer dev_name stored in the table differs from dev_name assigned 
to the consumer by its bus, the platform bus in this case. For that reason I 
think the consumer dev_name should be initialized in the table after the 
device is registered, when its actual dev_name can be obtained. If that device 
registration happens after the driver is already registered, e.g., at 
late_initcall, the device is probed before its lookup table is ready. For that 
reason returning EPROBE_DEFER seems better to me even in the ENOENT case.

Thanks,
Janusz
