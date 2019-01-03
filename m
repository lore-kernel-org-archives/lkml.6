Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26187C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87F621479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Vft3GXKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbfACNWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:22:39 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:49628 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfACNWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:22:39 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 424625C0096;
        Thu,  3 Jan 2019 14:22:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1546521757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ggRgkjLBaQu5jsNSiFvkh+541Jo2GKcqHj4ha4H/WBg=;
        b=Vft3GXKo+PAdnTIgX6h6kGM4C3l7yAmQnwl1ZQpCuQf4LxU34ouCwvTcnmxRrZaO31vbNB
        M0AZ6+UIVVi/QYVg6TzmQD/zAt5IPgw6PlAqiBhPaGh3jOHHa6bQ4xQHk9tP8eUarnhu+C
        6jPTTMr9w+Z8ksEAvMJI+pd6WNuYs6c=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 03 Jan 2019 14:22:37 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org,
        linux-arm-kernel-bounces@lists.infradead.org
Subject: Re: [PATCH] irqchip/gic-v3: use __init where appropriate
In-Reply-To: <5c4d154b-037d-25a0-7dad-7d2c80a252f9@arm.com>
References: <478402dd50e3237b14f4d0b41cd945de92de1756.1546092851.git.stefan@agner.ch>
 <5c4d154b-037d-25a0-7dad-7d2c80a252f9@arm.com>
Message-ID: <b31642dbb148d999acf8744e7da1f65b@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.01.2019 12:08, Marc Zyngier wrote:
> Hi Stephan,
> 
> On 29/12/2018 14:14, Stefan Agner wrote:
>> Compiling with section mismatch debugging enabled prints the
>> following warning:
>>   WARNING: vmlinux.o(.text+0xffa1b8): Section mismatch in reference from
>>   the function gic_smp_init() to the function .init.text:set_smp_cross_call()
>>
>> Avoid this warning by adding __init to gic_smp_init(). While add it,
>> also add it where appropriate.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  drivers/irqchip/irq-gic-v3.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index 0868a9d81c3c..3b33c94041e5 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -768,7 +768,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>>  	isb();
>>  }
>>
>> -static void gic_smp_init(void)
>> +static void __init gic_smp_init(void)
>>  {
>>  	set_smp_cross_call(gic_raise_softirq);
>>  	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
>> @@ -848,7 +848,7 @@ static struct notifier_block gic_cpu_pm_notifier_block = {
>>  	.notifier_call = gic_cpu_pm_notifier,
>>  };
>>
>> -static void gic_cpu_pm_init(void)
>> +static void __init gic_cpu_pm_init(void)
>>  {
>>  	cpu_pm_register_notifier(&gic_cpu_pm_notifier_block);
>>  }
>>
> 
> Interesting. I don't see this warning at all. How do you trigger this?

I noticed that it suddenly disappeared again too. I used some crazy
configurations while doing tests with LLVM/Clang, I think it was with
allyesconfig.

--
Stefan

> 
> Thanks,
> 
> 	M.
