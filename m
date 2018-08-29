Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAF5C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769B52086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769B52086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeH2Kvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:51:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:49454 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbeH2Kvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:51:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 23:56:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,301,1531810800"; 
   d="scan'208";a="85383511"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 28 Aug 2018 23:56:27 -0700
Received: from [10.226.39.0] (zhuyixin-mobl.gar.corp.intel.com [10.226.39.0])
        by linux.intel.com (Postfix) with ESMTP id E38BF580146;
        Tue, 28 Aug 2018 23:56:23 -0700 (PDT)
Subject: Re: [PATCH v2 02/18] clk: intel: Add clock driver for Intel MIPS SoCs
To:     Stephen Boyd <sboyd@kernel.org>,
        Songjun Wu <songjun.wu@linux.intel.com>,
        chuanhua.lei@linux.intel.com, hua.ma@linux.intel.com,
        qi-ming.wu@intel.com
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-3-songjun.wu@linux.intel.com>
 <153370742214.220756.2039365625963765922@swboyd.mtv.corp.google.com>
 <571d2d40-8728-fa7c-5d89-73d2a7b6293b@linux.intel.com>
 <153539697928.129321.2605078315090527674@swboyd.mtv.corp.google.com>
From:   "Zhu, Yi Xin" <yixin.zhu@linux.intel.com>
Message-ID: <75f8313b-42e6-e741-196d-af27ad1e4f9b@linux.intel.com>
Date:   Wed, 29 Aug 2018 14:56:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <153539697928.129321.2605078315090527674@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/28/2018 3:09 AM, Stephen Boyd wrote:
> Quoting yixin zhu (2018-08-08 01:52:20)
>> On 8/8/2018 1:50 PM, Stephen Boyd wrote:
>>> Quoting Songjun Wu (2018-08-02 20:02:21)
>>>> +       struct clk *clk;
>>>> +       int idx;
>>>> +
>>>> +       for (idx = 0; idx < nr_clks; idx++, osc++) {
>>>> +               if (!osc->dt_freq ||
>>>> +                   of_property_read_u32(ctx->np, osc->dt_freq, &freq))
>>>> +                       freq = osc->def_rate;
>>>> +
>>>> +               clk = clk_register_fixed_rate(NULL, osc->name, NULL, 0, freq);
>>> Should come from DT itself.
>> Yes. It can be defined as fixed-clock node in device tree.
>> Do you mean it should be defined in device tree and driver reference it
>> via device tree?
> Yes the oscillator should be in DT and then the DT node here can call
> clk_get() or just hardcode the parent name to be what it knows it is.
> Eventually we'd like to be able to move away from string names for
> hierarchy descriptions but that's far off. To get there, we would need
> DT nodes for clock controllers to indicate their clk parents with the
> clocks and clock-names properties. So for the oscillator, DT would
> define it and then the driver would eventually have a way to specify
> that some parent is index 5 or clock name "foo" and then the clk core
> could figure out the linkage. I haven't written that code yet, but I'll
> probably do it soon if nobody beats me to it.

Thanks.  Will update.


>
>>>> +/**
>>>> + * struct intel_clk_provider
>>>> + * @map: regmap type base address for register.
>>>> + * @np: device node
>>>> + * @clk_data: array of hw clocks and clk number.
>>>> + */
>>>> +struct intel_clk_provider {
>>>> +       struct regmap           *map;
>>>> +       struct device_node      *np;
>>>> +       struct clk_onecell_data clk_data;
>>> Please register clk_hw pointers instead of clk pointers with the of
>>> provider APIs.
>> Sorry.  I'm not sure I understand you correctly.
>> If only registering clk_hw pointer,  not registering of_provider API, then
>> how to reference it in the user drivers ?
>> Could you please give me more hints ?
> Clk provider drivers shouldn't be using clk pointers directly. Usually
> when that happens something is wrong. So new clk drivers should register
> clk_hw pointers and pretty much only deal with clk_hw pointers instead
> of struct clk pointers. You still register an of_provider, but that
> provider hands out clk_hw pointers so that clk provider drivers aren't
> tempted to use struct clk pointers.

Understood.  Will update to use clk_hw_onecell_data and change the 
registration accordingly.


>>
>>>> + */
>>>> +struct intel_pll_clk {
>>>> +       unsigned int            id;
>>>> +       const char              *name;
>>>> +       const char              *const *parent_names;
>>>> +       u8                      num_parents;
>>> Can the PLL have multiple parents?
>> Yes. But not in this platform.
>> The define here make it easy to expand to support new platform.
>>
> Ok, so it has a mux inside.
>
>>>> +       unsigned int                    id;
>>>> +       enum intel_clk_type             type;
>>>> +       const char                      *name;
>>>> +       const char                      *const *parent_names;
>>>> +       u8                              num_parents;
>>>> +       unsigned long                   flags;
>>>> +       unsigned int                    mux_off;
>>>> +       u8                              mux_shift;
>>>> +       u8                              mux_width;
>>>> +       unsigned long                   mux_flags;
>>>> +       unsigned int                    mux_val;
>>>> +       unsigned int                    div_off;
>>>> +       u8                              div_shift;
>>>> +       u8                              div_width;
>>>> +       unsigned long                   div_flags;
>>>> +       unsigned int                    div_val;
>>>> +       const struct clk_div_table      *div_table;
>>>> +       unsigned int                    gate_off;
>>>> +       u8                              gate_shift;
>>>> +       unsigned long                   gate_flags;
>>>> +       unsigned int                    gate_val;
>>>> +       unsigned int                    mult;
>>>> +       unsigned int                    div;
>>>> +};
>>>> +
>>>> +/* clock flags definition */
>>>> +#define CLOCK_FLAG_VAL_INIT    BIT(16)
>>>> +#define GATE_CLK_HW            BIT(17)
>>>> +#define GATE_CLK_SW            BIT(18)
>>>> +#define GATE_CLK_VT            BIT(19)
>>> What does VT mean? Virtual?
>> Yes. VT means virtual here.
>> Will change to GATE_CLK_VIRT.
>>
> Is it a hardware concept? Or virtualization with hypervisor?

Some peripheral drivers want to use same code cross platforms.

But not all platforms provide HW gate clock.  So in this case, clock 
driver creates

a virtual gate clock to make it work if no HW gate clock in the SoC.


>
>>>> +}
>>>> +
>>>> +CLK_OF_DECLARE(intel_grx500_cgu, "intel,grx500-cgu", grx500_clk_init);
>>> Any reason a platform driver can't be used instead of CLK_OF_DECLARE()?
>> It provides CPU clock which is used in early boot stage.
>>
> Ok. What is the CPU clock doing in early boot stage? Some sort of timer
> frequency? If the driver can be split into two pieces, one to handle the
> really early stuff that must be in place to get timers up and running
> and the other to register the rest of the clks that aren't critical from
> a regular platform driver it would be good. That's preferred model if
> something is super critical.

Yes, CPU clock is providing CPU frequency in the early boot stage.

Will put the non-critical clocks in the platform driver.


>
