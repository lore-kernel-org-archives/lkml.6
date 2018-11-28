Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86D7C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725A9208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="weKcujjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725A9208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbeK2JBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:01:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:52786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbeK2JBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:01:17 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DABA20832;
        Wed, 28 Nov 2018 21:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543442292;
        bh=0hPw90dQyou6Z4SH5BdGUH9IQ2gVsc2hd/xhOIXIVNU=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=weKcujjMNNWlcnlsnvNSIUV4T3zCo8QA+ZLJvd8w35ur1Uo9kUaOl90z6xKARSpLn
         XuTwLDUEukXzfBXfUCZ8EqadmeMJ6xHm9Xxqyy0g0UdLVwM1CjGuHEMUOo8jMX4WhC
         SAXn5TkuuXE9yIE6KiaiAShU659it5zTPRmDfS1I=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <87y39tufwe.fsf@bootlin.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20180922181709.13007-1-gregory.clement@bootlin.com>
 <20180922181709.13007-4-gregory.clement@bootlin.com>
 <153980089252.5275.819540708953283855@swboyd.mtv.corp.google.com>
 <87y39tufwe.fsf@bootlin.com>
Message-ID: <154344229160.88331.11927813448117578247@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 3/6] clk: mvebu: add CPU clock driver for Armada 7K/8K
Date:   Wed, 28 Nov 2018 13:58:11 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gregory CLEMENT (2018-11-15 15:22:59)
>  On mer., oct. 17 2018, Stephen Boyd <sboyd@kernel.org> wrote:
> =

> > Quoting Gregory CLEMENT (2018-09-22 11:17:06)
> >> + * @cluster: Cluster clock controller index
> >> + * @clk_name: Cluster clock controller name
> >> + * @dev : Cluster clock device
> >> + * @hw: HW specific structure of Cluster clock controller
> >> + * @pll_cr_base: CA72MP2 Register base (Device Sample at Reset regist=
er)
> >> + */
> >> +struct ap_cpu_clk {
> >> +       int cluster;
> >
> > unsigned?
> =

> I don't expect to have so many clusters that a signed int would be too
> short :)
> =

> Actually I used int to let the compiler choose what ever he wants.
> =

> But if you really want I can use a unsigned int

It's not just about opening up a wider range of values. It's also about
being more explicit with the type by indicating a negative value is
impossible/doesn't make sense for the code. So yes please, change it to
unsigned int.

> =

> >
> >> +       const char *clk_name;
> >> +       struct device *dev;
> >> +       struct clk_hw hw;
> >> +       struct regmap *pll_cr_base;
> >> +};
> >> +
> >> +static struct clk **cluster_clks;
> >> +static struct clk_onecell_data clk_data;
> >
> > Can you give these some better names that are ap_cpu specific? Grepping
> > for clk_data will make lots of hits otherwise because they're so
> > generic.
> =

> OK I will try to be more creative ;)

Thanks.

> >> +                          BIT(AP806_PLL_CR_0_CPU_CLK_RELOAD_RATIO_OFF=
SET),
> >> +                          BIT(AP806_PLL_CR_0_CPU_CLK_RELOAD_RATIO_OFF=
SET));
> >> +
> >> +
> >> +       /* 4. Wait for stabilizing CPU Clock */
> >> +       do {
> >> +               regmap_read(clk->pll_cr_base,
> >> +                           AP806_CA72MP2_0_PLL_SR_REG_OFFSET,
> >> +                           &reg);
> >> +       } while (!(reg & BIT(clk->cluster * AP806_CA72MP2_0_PLL_RATIO_=
STATE)));
> >
> > Use regmap_read_poll_timeout() API here and give some large timeout
> > value so that we don't get stuck waiting here forever?
> =

> Indeed regmap_read_poll_timeout() seems a nice improvement
> =

> >
> >> +
> >> +       /* 5. Clear Reload ratio */
> >
> > I'm not sure we really need these comments. They're just saying what the
> > code is doing, so they don't add much value.
> =

> Actually, these 5 steps directly come from the datasheet.

Ok, still doesn't mean we need to copy the datasheet into code comments
though.

> =

> >
> >> +       regmap_update_bits(clk->pll_cr_base, cpu_ratio_reg,
> >> +                          BIT(AP806_PLL_CR_0_CPU_CLK_RELOAD_RATIO_OFF=
SET), 0);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +
> >> +static long ap_cpu_clk_round_rate(struct clk_hw *hw, unsigned long ra=
te,
> >> +                                unsigned long *parent_rate)
> >> +{
> >> +       int divider =3D *parent_rate / rate;
> >> +
> >> +       if (divider > APN806_MAX_DIVIDER)
> >> +               divider =3D APN806_MAX_DIVIDER;
> >
> >       divider =3D min(divider, APN806_MAX_DIVIDER);
> =

> OK
> >
> >> +
> >> +       return *parent_rate / divider;
> >> +}
> >> +
> >> +static const struct clk_ops ap_cpu_clk_ops =3D {
> >> +       .recalc_rate    =3D ap_cpu_clk_recalc_rate,
> >> +       .round_rate     =3D ap_cpu_clk_round_rate,
> >> +       .set_rate       =3D ap_cpu_clk_set_rate,
> >> +};
> >> +
> >> +static int ap_cpu_clock_probe(struct platform_device *pdev)
> >> +{
> >> +       int ret, nclusters =3D 0, cluster_index =3D 0;
> >> +       struct device *dev =3D &pdev->dev;
> >> +       struct device_node *dn, *np =3D dev->of_node;
> >> +       struct ap_cpu_clk *ap_cpu_clk;
> >> +       struct regmap *regmap;
> >> +
> >> +       regmap =3D syscon_node_to_regmap(np->parent);
> >
> > Can we just call dev_get_remap() on pdev->dev.parent?
> =

> we could do regmap =3D dev_get_regmap(pdev->dev.parent, NULL); instead of
> this line. But is it really better?

It allows us to ignore 'syscon' in this driver and drop the include of
that header file? =


> =

> >
> >> +       if (IS_ERR(regmap)) {
> >> +               pr_err("cannot get pll_cr_base regmap\n");
> >> +               return PTR_ERR(regmap);
> >> +       }
> >> +
> >> +       /*
> >> +        * AP806 has 4 cpus and DFS for AP806 is controlled per
> >> +        * cluster (2 CPUs per cluster), cpu0 and cpu1 are fixed to
> >> +        * cluster0 while cpu2 and cpu3 are fixed to cluster1 whether
> >> +        * they are enabled or not.  Since cpu0 is the boot cpu, then
> >> +        * cluster0 must exist.  If cpu2 or cpu3 is enabled, cluster1
> >> +        * will exist and the cluster number is 2; otherwise the
> >> +        * cluster number is 1.
> >> +        */
> >> +       nclusters =3D 1;
> >> +       for_each_node_by_type(dn, "cpu") {
> >
> > Isn't there some sort of for_each_cpu_node() API that can be used
> > here?
> =

> Not when I wrote the code but since v4.20-rc1 we have
> for_each_of_cpu_node(). So I am going to use it now.

Awesome!

> >
> >> +               cluster_index >>=3D APN806_CLUSTER_NUM_OFFSET;
> >> +
> >> +               /* Initialize once for one cluster */
> >> +               if (cluster_clks[cluster_index])
> >> +                       continue;
> >> +
> >> +               parent =3D of_clk_get(np, cluster_index);
> >> +               if (IS_ERR(parent)) {
> >> +                       dev_err(dev, "Could not get the clock parent\n=
");
> >> +                       return -EINVAL;
> >> +               }
> >> +               parent_name =3D  __clk_get_name(parent);
> >> +               clk_name[12] +=3D cluster_index;
> >> +               ap_cpu_clk[cluster_index].clk_name =3D
> >> +                       ap_cp_unique_name(dev, np->parent, clk_name);
> >> +               ap_cpu_clk[cluster_index].cluster =3D cluster_index;
> >> +               ap_cpu_clk[cluster_index].pll_cr_base =3D regmap;
> >> +               ap_cpu_clk[cluster_index].hw.init =3D &init;
> >> +               ap_cpu_clk[cluster_index].dev =3D dev;
> >> +
> >> +               init.name =3D ap_cpu_clk[cluster_index].clk_name;
> >> +               init.ops =3D &ap_cpu_clk_ops;
> >> +               init.num_parents =3D 1;
> >> +               init.parent_names =3D &parent_name;
> >> +               init.flags =3D CLK_GET_RATE_NOCACHE;
> >
> > Can you add a comment why we need NOCACHE here? It isn't clear why this
> > is important.
> =

> I think there was the idea that the clock rate could be modified by
> something else that the clk driver, but now I am not sure it is the
> case. I will check it and either add a comment or just remove it.

Ok.

