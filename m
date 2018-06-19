Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117D3C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6232083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FNtQAG+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6232083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756414AbeFSIyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:54:15 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46188 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937343AbeFSIyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:54:10 -0400
Received: by mail-pg0-f67.google.com with SMTP id d2-v6so8848558pga.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 01:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TP2omIkbIENQcFAsPhUGTsvE8TyQ3CTLSKEF3DR9094=;
        b=FNtQAG+xWAxWRezjR0FikqYunMcbiaRm/z4rFyyXS2YTO/Vl2JNLFGYeX+zgf6vfCH
         VXvuH5smyV59nFMOymX06XUAbnAJPYAlVVVeTHCYQA1/9F8WtvD8tUMIbvlHsa5ZLHWk
         kDoO6wVh2XvIh7RJ3U2BKAD1hbiYfCfsE0r+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TP2omIkbIENQcFAsPhUGTsvE8TyQ3CTLSKEF3DR9094=;
        b=FAgjDJ0Xjhuq65zaqjToIHVEuZOwXjKmAT2vIgKnyxoDRMitBGJ1Js2Wbv5Cs9o3pw
         bqvC7T/goN4UffzF183wanm0TuNPoEb4rpOz9x2/+4XtRjN69ANLgUdvymb/IGA+7Z/X
         vZ2DcCE3t97oJ8lV3KRknhLdWV90cVon+7jySIJ5DfQOlkAKY8VscqSKC35CM4hjA8wv
         H/BY+Lagy1e640ZfgBiUuA+CDEt0l5iVg9YPnWIXqXKxRDi7/duXBhWtRtzLMThXpwCG
         SZRkAi2JBoSOVTvBZFgbvMWXxZ9+D/f1/8tQZ7xpi8exipREeBF9wAllyBDw8XACgZMG
         YvqQ==
X-Gm-Message-State: APt69E1fEokoKL1m2f8db1CFVe7fE/wEhvseNNIJChVhE4qQhujBvlsy
        kGWz7GcOb5Ir2iO3i2yuj/KiaA==
X-Google-Smtp-Source: ADUXVKIPJeK88RWpHLTJs5C3Pr98oS/oh10fiZNMRteW7TLfe968r3TG/+AdUU0O8MzDo0vYP68jqw==
X-Received: by 2002:a65:5c42:: with SMTP id v2-v6mr14240053pgr.224.1529398450280;
        Tue, 19 Jun 2018 01:54:10 -0700 (PDT)
Received: from localhost ([122.171.103.96])
        by smtp.gmail.com with ESMTPSA id a23-v6sm30553455pfj.117.2018.06.19.01.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 01:54:09 -0700 (PDT)
Date:   Tue, 19 Jun 2018 14:24:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, robh@kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, skannan@codeaurora.org
Subject: Re: [PATCH 2/2] cpufreq: qcom-fw: Add support for QCOM cpufreq FW
 driver
Message-ID: <20180619085407.nmos7tix77vnaqre@vireshk-i7>
References: <1528109194-16864-1-git-send-email-tdas@codeaurora.org>
 <1528109194-16864-3-git-send-email-tdas@codeaurora.org>
 <20180606060119.yzl24vhqff6btvrk@vireshk-i7>
 <3cd5944b-d2ca-e7d7-f315-c3e5f230701b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cd5944b-d2ca-e7d7-f315-c3e5f230701b@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for being late..

On 07-06-18, 12:48, Taniya Das wrote:
> On 6/6/2018 11:31 AM, Viresh Kumar wrote:
> > On 04-06-18, 16:16, Taniya Das wrote:

> > > +static struct cpufreq_driver cpufreq_qcom_fw_driver = {
> > > +	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> > > +			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
> > > +	.verify		= cpufreq_generic_frequency_table_verify,
> > > +	.target_index	= qcom_cpufreq_fw_target_index,
> > > +	.get		= qcom_cpufreq_fw_get,
> > > +	.init		= qcom_cpufreq_fw_cpu_init,
> > 
> > What about CPU hotplug ? We can still do that, right ? So what will happen if
> > all CPUs of a freq-domain are removed (hence cpufreq policy is removed) and then
> > someone calls qcom_cpufreq_fw_get() ? You should really work on cpufreq_policy
> > there to get 'c'.
> > 
> 
> You want the _get to do something as below.
> Please correct me if my understanding is wrong.
> ....
> 
>  policy = cpufreq_cpu_get_raw(cpu);
>  if (!policy)
>     return 0;
> 
>  c = policy->driver_data;
> 
>  index = readl_relaxed(c->perf_base);
>  index = min(index, LUT_MAX_ENTRIES - 1);
> 
>  return c->table[index].frequency;
> 
> ....

Right.

> > > +static int qcom_read_lut(struct platform_device *pdev,
> > > +			 struct cpufreq_qcom *c)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	u32 data, src, lval, i, core_count, prev_cc, prev_freq, cur_freq;
> > > +
> > > +	c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
> > > +				sizeof(*c->table), GFP_KERNEL);
> > > +	if (!c->table)
> > > +		return -ENOMEM;
> > > +
> > > +	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> > > +		data = readl_relaxed(c->lut_base + i * LUT_ROW_SIZE);
> > > +		src = ((data & GENMASK(31, 30)) >> 30);
> > > +		lval = (data & GENMASK(7, 0));
> > > +		core_count = CORE_COUNT_VAL(data);
> > > +
> > > +		if (!src)
> > > +			c->table[i].frequency = INIT_RATE / 1000;
> > > +		else
> > > +			c->table[i].frequency = XO_RATE * lval / 1000;
> > > +
> > > +		cur_freq = c->table[i].frequency;
> > > +
> > > +		dev_dbg(dev, "index=%d freq=%d, core_count %d\n",
> > > +			i, c->table[i].frequency, core_count);
> > > +
> > > +		if (core_count != c->max_cores)
> > > +			cur_freq = CPUFREQ_ENTRY_INVALID;
> > > +
> > > +		/*
> > > +		 * Two of the same frequencies with the same core counts means
> > > +		 * end of table.
> > > +		 */
> > > +		if (i > 0 && c->table[i - 1].frequency ==
> > > +		   c->table[i].frequency && prev_cc == core_count) {
> > > +			struct cpufreq_frequency_table *prev = &c->table[i - 1];
> > > +
> > > +			if (prev_freq == CPUFREQ_ENTRY_INVALID)
> > > +				prev->flags = CPUFREQ_BOOST_FREQ;
> > > +			break;
> > > +		}
> > > +		prev_cc = core_count;
> > > +		prev_freq = cur_freq;
> > > +	}
> > > +
> > > +	c->table[i].frequency = CPUFREQ_TABLE_END;
> > > +
> > > +	return 0;
> > > +}
> > 
> > Looks like there are many problems here.
> > - You are assigning prev_freq with cur_freq (which may be uninitialized local
> >    variable here).
> > - In this version, you never write CPUFREQ_ENTRY_INVALID to table[i].frequency,
> >    which looks wrong as well.
> > 
> 
> - The code to detect boost, would only enter for i > 0 and the prev_freq
> would be initialized with the cur_freq.
> - In the case where the core_count != max_cores, the cur_freq is marked
> INVALID, and when both prev_freq == cur_freq && prev_cc && cur_cc match,
> that is the time the prev table flags need to be updated. Marking the
> table[i].frequency as INVALID is not required as cur_freq is already marked
> with the same. Please correct me if you think otherwise.

Yeah but the value of cur_freq isn't written to the table entries now. This
wasn't the case in the earlier version. Have a look at that one.

-- 
viresh
