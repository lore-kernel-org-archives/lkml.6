Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753908AbeEWFy7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 01:54:59 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35602 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeEWFy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 01:54:57 -0400
X-Google-Smtp-Source: AB8JxZqwist897bRwZXoXO9YtuBbJJJ8gw/0tSvg8GsZd8gIuoyA7Km4Pk4Eet0CIImOAQt/1DkdXw==
Date: Wed, 23 May 2018 11:24:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Taniya Das <tdas@codeaurora.org>
Cc: skannan@codeaurora.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, robh@kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org,
        amit.kucheria@linaro.org
Subject: Re: [PATCH v2 2/2] cpufreq: qcom-fw: Add support for QCOM cpufreq FW
 driver
Message-ID: <20180523055453.uzsbm2ub4stgthzg@vireshk-i7>
References: <1526751291-17873-1-git-send-email-tdas@codeaurora.org>
 <1526751291-17873-3-git-send-email-tdas@codeaurora.org>
 <20180521090113.qo2lrafjrh2xi6va@vireshk-i7>
 <0fccdc1880c912102548a85008482fa0@codeaurora.org>
 <bf5b09d3-4d97-5357-3fb2-926227bb7229@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf5b09d3-4d97-5357-3fb2-926227bb7229@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-05-18, 16:13, Taniya Das wrote:
> On 5/22/2018 12:36 AM, skannan@codeaurora.org wrote:
> > On 2018-05-21 02:01, Viresh Kumar wrote:
> > > On 19-05-18, 23:04, Taniya Das wrote:

> > > > +    /* Make sure the write goes through before proceeding */
> > > > +    mb();
> > > 
> > > Btw what happens right after this is done ? Are we guaranteed that the
> > > frequency is updated in the hardware after this ? What about enabling
> > > fast-switch for your platform ? Look at drivers/cpufreq/scmi-cpufreq.c
> > > to see how that is done.
> > 
> > Yeah, I don't think this is needed really.
> > 
> 
> Just want to make sure it doesn't really sit in the write buffer before
> return.

As per Saravana you will be dropping it now, right ?

> > > > +    index = readl_relaxed(c->perf_base);
> > > > +    index = min(index, LUT_MAX_ENTRIES - 1);
> > > 
> > > Will the hardware ever read a value over 39 here ?
> > 
> > The register could be initialized to whatever before the kernel is
> > brought up. Don't want to depend on it being correct to avoid out of
> > bounds access that could leak data.

Fair enough.

> > > > +static int qcom_read_lut(struct platform_device *pdev,
> > > > +             struct cpufreq_qcom *c)
> > > > +{
> > > > +    struct device *dev = &pdev->dev;
> > > > +    u32 data, src, lval, i, core_count, prev_cc;
> > > > +
> > > > +    c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
> > > > +                sizeof(*c->table), GFP_KERNEL);
> > > > +    if (!c->table)
> > > > +        return -ENOMEM;
> > > > +
> > > > +    for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> > > > +        data = readl_relaxed(c->lut_base + i * LUT_ROW_SIZE);
> > > > +        src = ((data & GENMASK(31, 30)) >> 30);
> > > > +        lval = (data & GENMASK(7, 0));
> > > > +        core_count = CORE_COUNT_VAL(data);
> > > > +
> > > > +        if (!src)
> > > > +            c->table[i].frequency = INIT_RATE / 1000;
> > > > +        else
> > > > +            c->table[i].frequency = XO_RATE * lval / 1000;
> > > > +
> > > > +        c->table[i].driver_data = c->table[i].frequency;
> > > 
> > > Why do you need to use driver_data here? Why can't you simple use
> > > frequency field in the below conditional expressions ?
> > > 
> 
> The frequency field would be marked INVALID in case the core count does not
> match and the frequency data would be lost.
> 
> > > > +
> > > > +        dev_dbg(dev, "index=%d freq=%d, core_count %d\n",
> > > > +            i, c->table[i].frequency, core_count);
> > > > +
> > > > +        if (core_count != c->max_cores)
> > > > +            c->table[i].frequency = CPUFREQ_ENTRY_INVALID;
> > > > +
> > > > +        /*
> > > > +         * Two of the same frequencies with the same core counts means
> > > > +         * end of table.
> > > > +         */
> > > > +        if (i > 0 && c->table[i - 1].driver_data ==
> > > > +            c->table[i].driver_data && prev_cc == core_count) {
> > > > +            struct cpufreq_frequency_table *prev = &c->table[i - 1];
> > > > +
> > > > +            if (prev->frequency == CPUFREQ_ENTRY_INVALID) {
> > > 
> > > There can only be a single boost frequency at max ?
> > 
> > As of now, yes. If that changes, we'll change this code later.
> > 
> > > > +                prev->flags = CPUFREQ_BOOST_FREQ;
> > > > +                prev->frequency = prev->driver_data;
> > > 
> > > Okay you are using driver_data as a local variable to keep this value
> > > safe which you might have overwritten. Maybe use a simple variable
> > > prev_freq for this. It would be much more readable in that case and
> > > you wouldn't end up abusing the driver_data field.
> > > 
> 
> Please correct me, currently the driver_data is not used by cpufreq core and
> that was the reason to use it. In case you still think it is not a good way
> to handle it, I would try to handle it differently.

Yeah, the driver data will not be used by cpufreq core, but I think
the code would be far more readable if you use a local variable like
prev_freq instead.

> > > > +            }
> > > > +
> > > > +            break;
> > > > +        }
> > > > +        prev_cc = core_count;
> > > > +    }
> > > > +    c->table[i].frequency = CPUFREQ_TABLE_END;
> > > 
> > > Wouldn't you end up writing on c->table[40].frequency here if there
> > > are 40 frequency value present ?
> > 
> > Yeah, the loop condition needs to be fixed.
> > 
> 
> The table allocation is done for 'LUT_MAX_ENTRIES + 1'.
> Yes in case we have all [0-39] (i.e 40 entries) read from the hardware,
> would store the same and mark the 40th index as table end. Please correct if
> I missed something in your comment.

Ahh, you are right. I misread it.

-- 
viresh
