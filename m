Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92B9C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AE5208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxSiimQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AE5208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeH0W5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbeH0W5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:57:33 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0ABC208A5;
        Mon, 27 Aug 2018 19:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535396980;
        bh=uhLMjjJIiGJLhG0mj7Ib7Y+QjtU9Sm+UmmoZbJih4J0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=TxSiimQJfxMaVH/+iO+Yq8DkOREmoS3JdsYHVFgxhRTrd30KhG/NG6sQhR3zgSqbK
         UkjwxHuFk3TdV8LaX2PujZBKb6k8XZyTTr5K6M00TlGEK0tzcdZqldTdyA2B1MSfgg
         yhkjzRqh80AHnMKBllEiRXpfYkehn8h7if2Ma2uE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Songjun Wu <songjun.wu@linux.intel.com>,
        chuanhua.lei@linux.intel.com, hua.ma@linux.intel.com,
        qi-ming.wu@intel.com, yixin zhu <yixin.zhu@linux.intel.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <571d2d40-8728-fa7c-5d89-73d2a7b6293b@linux.intel.com>
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-3-songjun.wu@linux.intel.com>
 <153370742214.220756.2039365625963765922@swboyd.mtv.corp.google.com>
 <571d2d40-8728-fa7c-5d89-73d2a7b6293b@linux.intel.com>
Message-ID: <153539697928.129321.2605078315090527674@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 02/18] clk: intel: Add clock driver for Intel MIPS SoCs
Date:   Mon, 27 Aug 2018 12:09:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting yixin zhu (2018-08-08 01:52:20)
> On 8/8/2018 1:50 PM, Stephen Boyd wrote:
> > Quoting Songjun Wu (2018-08-02 20:02:21)
> >> +       struct clk *clk;
> >> +       int idx;
> >> +
> >> +       for (idx =3D 0; idx < nr_clks; idx++, osc++) {
> >> +               if (!osc->dt_freq ||
> >> +                   of_property_read_u32(ctx->np, osc->dt_freq, &freq))
> >> +                       freq =3D osc->def_rate;
> >> +
> >> +               clk =3D clk_register_fixed_rate(NULL, osc->name, NULL,=
 0, freq);
> > Should come from DT itself.
> Yes. It can be defined as fixed-clock node in device tree.
> Do you mean it should be defined in device tree and driver reference it =

> via device tree?

Yes the oscillator should be in DT and then the DT node here can call
clk_get() or just hardcode the parent name to be what it knows it is.
Eventually we'd like to be able to move away from string names for
hierarchy descriptions but that's far off. To get there, we would need
DT nodes for clock controllers to indicate their clk parents with the
clocks and clock-names properties. So for the oscillator, DT would
define it and then the driver would eventually have a way to specify
that some parent is index 5 or clock name "foo" and then the clk core
could figure out the linkage. I haven't written that code yet, but I'll
probably do it soon if nobody beats me to it.

> >> +/**
> >> + * struct intel_clk_provider
> >> + * @map: regmap type base address for register.
> >> + * @np: device node
> >> + * @clk_data: array of hw clocks and clk number.
> >> + */
> >> +struct intel_clk_provider {
> >> +       struct regmap           *map;
> >> +       struct device_node      *np;
> >> +       struct clk_onecell_data clk_data;
> > Please register clk_hw pointers instead of clk pointers with the of
> > provider APIs.
> Sorry.=C2=A0 I'm not sure I understand you correctly.
> If only registering clk_hw pointer,=C2=A0 not registering of_provider API=
, then
> how to reference it in the user drivers ?
> Could you please give me more hints ?

Clk provider drivers shouldn't be using clk pointers directly. Usually
when that happens something is wrong. So new clk drivers should register
clk_hw pointers and pretty much only deal with clk_hw pointers instead
of struct clk pointers. You still register an of_provider, but that
provider hands out clk_hw pointers so that clk provider drivers aren't
tempted to use struct clk pointers.

> =

> =

> >
> >> + */
> >> +struct intel_pll_clk {
> >> +       unsigned int            id;
> >> +       const char              *name;
> >> +       const char              *const *parent_names;
> >> +       u8                      num_parents;
> > Can the PLL have multiple parents?
> Yes. But not in this platform.
> The define here make it easy to expand to support new platform.
> =


Ok, so it has a mux inside.

> =

> >> +       unsigned int                    id;
> >> +       enum intel_clk_type             type;
> >> +       const char                      *name;
> >> +       const char                      *const *parent_names;
> >> +       u8                              num_parents;
> >> +       unsigned long                   flags;
> >> +       unsigned int                    mux_off;
> >> +       u8                              mux_shift;
> >> +       u8                              mux_width;
> >> +       unsigned long                   mux_flags;
> >> +       unsigned int                    mux_val;
> >> +       unsigned int                    div_off;
> >> +       u8                              div_shift;
> >> +       u8                              div_width;
> >> +       unsigned long                   div_flags;
> >> +       unsigned int                    div_val;
> >> +       const struct clk_div_table      *div_table;
> >> +       unsigned int                    gate_off;
> >> +       u8                              gate_shift;
> >> +       unsigned long                   gate_flags;
> >> +       unsigned int                    gate_val;
> >> +       unsigned int                    mult;
> >> +       unsigned int                    div;
> >> +};
> >> +
> >> +/* clock flags definition */
> >> +#define CLOCK_FLAG_VAL_INIT    BIT(16)
> >> +#define GATE_CLK_HW            BIT(17)
> >> +#define GATE_CLK_SW            BIT(18)
> >> +#define GATE_CLK_VT            BIT(19)
> > What does VT mean? Virtual?
> Yes. VT means virtual here.
> Will change to GATE_CLK_VIRT.
> =


Is it a hardware concept? Or virtualization with hypervisor?

> >
> >> +}
> >> +
> >> +CLK_OF_DECLARE(intel_grx500_cgu, "intel,grx500-cgu", grx500_clk_init);
> > Any reason a platform driver can't be used instead of CLK_OF_DECLARE()?
> It provides CPU clock which is used in early boot stage.
> =


Ok. What is the CPU clock doing in early boot stage? Some sort of timer
frequency? If the driver can be split into two pieces, one to handle the
really early stuff that must be in place to get timers up and running
and the other to register the rest of the clks that aren't critical from
a regular platform driver it would be good. That's preferred model if
something is super critical.

