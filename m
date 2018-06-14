Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B3AB7C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693A4208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HK6DBzCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693A4208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964870AbeFNRyt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 13:54:49 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33060 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755214AbeFNRyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 13:54:46 -0400
Received: by mail-wr0-f193.google.com with SMTP id k16-v6so7353093wro.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 10:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aa1wOyPH5DDXJD+3kriT/1UDbdrSNB9P6x2XyROEjzo=;
        b=HK6DBzCWmsRs53rmKCKvdk3cqWX5U6sTKWZFH1QN/Ro1oEwaGlsPcGqOxRs5v7ihK4
         gsBvlgSYg0tSooIW44FufZuGH71OBs+JbpBBggYK3EuqTItgkBnEkNyES5Kl6tlEtUmP
         CytB6covopZQeyAfYWyC+/u1rxO/BSd6YP5EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aa1wOyPH5DDXJD+3kriT/1UDbdrSNB9P6x2XyROEjzo=;
        b=HXA7Xxn2w8r+OnAfEZ+AmFsIzktg4xLN6fQHtBdummqh89o+Uw1W+eQarb5ImoEsax
         TgE7vA4j28hZJN6J7aL+gyCyrBmFBpW/KaCmHwux7wcMBImPzx1/d+6nGvHhrgmC2q5w
         1sTgWh5uJCzfYGzEedWJH20OBpLuKEhfwBQf0HI8kC5Tv5sqnWe+eaC1a5EPqniqlTfA
         IpEJr3VLyujzqYcditImrgWXwygcCVBi2/Eh+ojkR1N4sK04xZEjMTwZb3GYATG2BpLe
         43lf/M6vP/4wlWYFjXQJ7zFezPLaDm+Gs0T4ouqTWoBhruTH5WK3rbPrpEZtI0+BbQi5
         0E9w==
X-Gm-Message-State: APt69E1PmFAptwjUS8UeDOSh50ofNvdgn4WiZlpwsFEXWPyOERoDQd5q
        o5N6VbbyoyGRdHUc18+AzQ0F5w==
X-Google-Smtp-Source: ADUXVKJu11Wm5JrqGugRyNy25g2lt8GPrvrqkgY8Zj8QH8TljQtaKisHx1YmXNqPkvr+gTTG9GQv3A==
X-Received: by 2002:adf:979c:: with SMTP id s28-v6mr3442706wrb.28.1528998885497;
        Thu, 14 Jun 2018 10:54:45 -0700 (PDT)
Received: from [192.168.1.180] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id 74-v6sm8870768wmt.31.2018.06.14.10.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 10:54:44 -0700 (PDT)
Subject: Re: [RFC PATCH] irqchip/gic-v3: Add quirk for msm8996 secured
 registers
To:     Marc Zyngier <marc.zyngier@arm.com>, sudeep.holla@arm.com,
        tglx@linutronix.de, jason@lakedaemon.net
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        sboyd@kernel.org, nicolas.dechesne@linaro.org
References: <20180613114340.32550-1-srinivas.kandagatla@linaro.org>
 <2d866cd1-59a4-befb-b2de-b91f9e56804a@arm.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <98209e4e-96b3-3baf-3f21-a57dc8447850@linaro.org>
Date:   Thu, 14 Jun 2018 18:54:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <2d866cd1-59a4-befb-b2de-b91f9e56804a@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review!

On 13/06/18 13:59, Marc Zyngier wrote:
> On 13/06/18 12:43, Srinivas Kandagatla wrote:
>> Access to GICR_WAKER is restricted on msm8996 SoC. Its been more
> 
> Restricted by what? Firmware? Hypervisor? (most likely the later).
> 
Yes, its the Hypervisor (TZ firmware)

>> than 2 years of wait for this to be fixed in firmware which is
> 
> This surely bodes very well in this day and age, where firmware update
> are becoming just as important as updating your kernel and your
> userspace to fix security problems. I'm impressed.
> 
>> not going anywhere. So add a quirk to not write to this register.
>> With this quirk MSM8996 can atleast boot out of mainline,
> 
> at least
yep.

> 
>> which can help community to work with boards based on MSM8996.
>>
>> Without this patch Qualcomm DB820c board reboots when GICR_WAKER
>> is written to.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/irqchip/irq-gic-v3.c | 32 ++++++++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index 76ea56d779a1..d1bb2c0cce02 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -47,6 +47,8 @@ struct redist_region {
>>   	bool			single_redist;
>>   };
>>   
>> +#define GICV3_FLAGS_WORKAROUND_IW_GICR_WAKER	(1ULL << 0)
> 
> Drop the GICV3 prefix. What does IW means here? Please provide an
I will drop the prefix.

> erratum number for this, and add a description to
> Documentation/arm64/silicon-errata.txt.

Am not sure there is any silicon level errata associated with this, as 
its related to firmware. Any way I will try to dig up the docs to see if 
there is any.

> 
>> +
>>   struct gic_chip_data {
>>   	struct fwnode_handle	*fwnode;
>>   	void __iomem		*dist_base;
>> @@ -55,6 +57,7 @@ struct gic_chip_data {
>>   	struct irq_domain	*domain;
>>   	u64			redist_stride;
>>   	u32			nr_redist_regions;
>> +	u64			flags;
>>   	bool			has_rss;
>>   	unsigned int		irq_nr;
>>   	struct partition_desc	*ppi_descs[16];
>> @@ -139,6 +142,9 @@ static void gic_enable_redist(bool enable)
>>   	u32 count = 1000000;	/* 1s! */
>>   	u32 val;
>>   
>> +	if (gic_data.flags & GICV3_FLAGS_WORKAROUND_IW_GICR_WAKER)
>> +		return;
>> +
>>   	rbase = gic_data_rdist_rd_base();
>>   
>>   	val = readl_relaxed(rbase + GICR_WAKER);
>> @@ -1064,6 +1070,31 @@ static const struct irq_domain_ops partition_domain_ops = {
>>   	.select = gic_irq_domain_select,
>>   };
>>   
>> +static bool __maybe_unused gicv3_enable_quirk_msm8996(void *data)
> 
> All the functions are prefixed with gic, not gicv3. The function name
> should reflect the erratum number.
will fix it in next version.

> 
>> +{
>> +	struct gic_chip_data *d = data;
>> +
>> +	d->flags |= GICV3_FLAGS_WORKAROUND_IW_GICR_WAKER;
>> +
>> +	return true;
>> +}
>> +
>> +static const struct gic_quirk gicv3_quirks[] = {
>> +	{
>> +		.desc	= "GICV3: Qualcomm MSM8996 WAKER IW",
> 
> Please the erratum number in the message. It should read something like:
> 
> 		"GICv3: Qualcomm erratum BIGNUMBERHERE"
> 
>> +		.iidr	= 0x00001070,	/* MSM8996 */
>> +		.mask	= 0x0000ffff,
> 
> Please match the full GICD_IIDR register, not just the implementer and
> the revision. Unless you expect all the QC systems to have the same
> behaviour?
There seems to be more than one SoC that has this issue,  I will dig up 
more info before sending next version.

> 
>> +		.init	= gicv3_enable_quirk_msm8996,
>> +	},
>> +};
>> +
>> +static void gic_v3_enable_quirks(struct gic_chip_data *gic_data)
> 
> gic, not gic_v3.
yep.

Thanks,
srini

> 
>> +{
>> +	u32 iidr = readl_relaxed(gic_data->dist_base + GICD_IIDR);
>> +
>> +	gic_enable_quirks(iidr, gicv3_quirks, gic_data);
>> +}
>> +
>>   static int __init gic_init_bases(void __iomem *dist_base,
>>   				 struct redist_region *rdist_regs,
>>   				 u32 nr_redist_regions,
>> @@ -1126,6 +1157,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
>>   	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
>>   		its_init(handle, &gic_data.rdists, gic_data.domain);
>>   
>> +	gic_v3_enable_quirks(&gic_data);
>>   	gic_smp_init();
>>   	gic_dist_init();
>>   	gic_cpu_init();
>>
> 
> Thanks,
> 
> 	M.
> 
