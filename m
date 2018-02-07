Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754729AbeBGQwx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 11:52:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54760 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754622AbeBGQwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 11:52:50 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7986760790
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Wed, 7 Feb 2018 16:52:48 +0000
From: Lina Iyer <ilina@codeaurora.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        asathyak@codeaurora.org
Subject: Re: [PATCH v4 1/2] drivers: irqchip: pdc: Add PDC interrupt
 controller for QCOM SoCs
Message-ID: <20180207165248.GC16153@codeaurora.org>
References: <20180207154958.13421-1-ilina@codeaurora.org>
 <20180207154958.13421-2-ilina@codeaurora.org>
 <e2b8a487-1635-5053-6079-2b9ae00a9468@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e2b8a487-1635-5053-6079-2b9ae00a9468@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07 2018 at 16:43 +0000, Marc Zyngier wrote:
>On 07/02/18 15:49, Lina Iyer wrote:
>> From : Archana Sathyakumar <asathyak@codeaurora.org>
>>
>> The Power Domain Controller (PDC) on QTI SoCs like SDM845 houses an
>> interrupt controller along with other domain control functions to handle
>> interrupt related functions like handle falling edge or active low which
>> are not detected at the GIC and handle wakeup interrupts.
>>
>> The interrupt controller is on an always-on domain for the purpose of
>> waking up the processor. Only a subset of the processor's interrupts are
>> routed through the PDC to the GIC. The PDC powers on the processors'
>> domain, when in low power mode and replays pending interrupts so the GIC
>> may wake up the processor.
>>
>> Signed-off-by: Archana Sathyakumar <asathyak@codeaurora.org>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---

>> +	parent_hwirq = get_parent_hwirq(hwirq);
>
>Now that you return a well known value on error, how about testing it
>and erroring out instead of propagating it to the parent?
>
Hmm.. Okay.

>> +	region = kcalloc(n, sizeof(*region), GFP_KERNEL);
>> +	if (!region)
>> +		return -ENOMEM;
>> +
>> +	ret = of_property_read_u32_array(np, "qcom,pdc-ranges", region, n);
>> +	if (ret)
>> +		goto fail;
>> +
>> +	pdc_region_cnt = n / 3;
>> +	pdc_region = kcalloc(pdc_region_cnt, sizeof(*pdc_region), GFP_KERNEL);
>> +	if (!pdc_region) {
>> +		pdc_region_cnt = 0;
>> +		ret = -ENOMEM;
>> +		goto fail;
>> +	}
>> +
>> +	for (n = 0; n < pdc_region_cnt; n++, region += 3) {
>> +		pdc_region[n].pin_base    = region[0];
>> +		pdc_region[n].parent_base = region[1];
>> +		pdc_region[n].cnt         = region[2];
>
>Here's an alternative version that doesn't require any bounce buffer:
>
>	for (n = 0; n < pdc_region_cnt; n++) {
>		ret = of_property_read_u32_index(np, "qcom,pdc-ranges",
>				 n * 3 + 0, &pdc_region[n].pin_base);
>		if (ret)
>			goto fail;
>		ret = of_property_read_u32_index(np, "qcom,pdc-ranges",
>				 n * 3 + 1, &pdc_region[n].parent_base);
>		if (ret)
>			goto fail;
>		ret = of_property_read_u32_index(np, "qcom,pdc-ranges",
>				 n * 3 + 2, &pdc_region[n].cnt);
>		if (ret)
>			goto fail;
>	}
>
>And you can get rid of "region" altogether, because...
>
>> +	}
>> +
>> +fail:
>> +	kfree(region);
>
>... now that once you've incremented "region" in your for() loop, this
>kfree isn't going to do what you think it does.
>
Sure.

>> +	return ret;
>> +}
>> +
>> +static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
>> +{
>> +	struct irq_domain *parent_domain, *pdc_domain;
>> +	int ret;
>> +
>> +	pdc_base = of_iomap(node, 0);
>> +	if (!pdc_base) {
>> +		pr_err("%pOF: unable to map PDC registers\n", node->full_name);
>
>The whole point of the %pOF specifier is that you don't pass the
>full_name field, but just the node itself. This is why I pointed you to
>commit ce4fecf1fe15 so that you could see how it is used...
>
Oops. I had seen the commit earlier, hence I didn't pay close attention
this time. Sorry, my bad.

Thanks,
Lina
