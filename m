Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECB1C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7888C20854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Gyl0oqkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfAVI74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:59:56 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:53718 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfAVI7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:59:55 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 65AFE5C1869;
        Tue, 22 Jan 2019 09:59:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1548147592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=34pKV0yV+V0SIokoQwQR8ivL4IXCi+WSHju/feFhZrA=;
        b=Gyl0oqkSEjjq1B6MJpa5CuCjmGB5RPr+eLz42q8smIbpo4WD36JZHjgayX1m9DSKva/4eN
        jobvgw7VDNNchrWwMQBEia0QlovN+3iFcwavGNokfQFITx8FoyKncSPaGba5bwD/UkkrCp
        pw6HK1ygUtoDSOe/OELozVT99Zq1Vfo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 22 Jan 2019 09:59:49 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     will.deacon@arm.com, shawnguo@kernel.org, l.stach@pengutronix.de,
        kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: handle multiple CPUs with single interrupts
In-Reply-To: <20190121172325.GD47506@lakrids.cambridge.arm.com>
References: <20190121144111.22716-1-stefan@agner.ch>
 <20190121172325.GD47506@lakrids.cambridge.arm.com>
Message-ID: <730dcd70a60efc0756570153b6ea84d2@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.01.2019 18:23, Mark Rutland wrote:
> Hi Stefan,
> 
> On Mon, Jan 21, 2019 at 03:41:11PM +0100, Stefan Agner wrote:
>> Currently, if only a single interrupt is available, the code assigns
>> this single interrupt to the first CPU. All other CPUs are left
>> unsupported. This allows to use perf events only on processes using
>> the first CPU. This is not obvious to the user.
>>
>> Instead, disable interrupts but support all CPUs. This allows to use
>> the PMU on all CPUs for all events other than sampling events which do
>> require interrupt support.
> 
> Even for non-sampling events we use the overflow interrupt to ensure
> that we don't lose count across overflows, and without that interrupt,
> we cannot guarantee that the results are accurate.
> 
> For example:
> 
> 	Program counter to 0
> 	Start program
> 	< counter overflows, no interrupt >
> 	< counter overflows, no interrupt >
> 	Stop program
> 	Counter reads as 5
> 
> 
> ... which we cannot distinguish from:
> 
> 	Program counter to 0
> 	Start program
> 	< counter overflows, no interrupt >
> 	< counter overflows, no interrupt >
> 	< counter overflows, no interrupt >
> 	< counter overflows, no interrupt >
> 	< counter overflows, no interrupt >
> 	< counter overflows, no interrupt >
> 	Stop program
> 	Counter reads as 5
> 
> ... and thus cannot provide any reasonable confidence in results.

Oh ok I see, this is not what we want at all!

Currently we register that one IRQ for CPU0. So what happens today is:

 	Program counter to 0
 	Start program
        < program scheduled on CPU0 >
 	< counter overflows, interrupt >
        < program scheduled on CPU1 >
 	< counter overflows, no interrupt >
 	< counter overflows, no interrupt >
 	Stop program
 	Counter reads as 5

Which is off too...

I could also reproduce this by manually moving the process between
CPU0/1...

We probably should not probe the driver at all then? It seems rather
unwise to provide users PMU data which might be plain wrong.

> 
> In theory, we could use a hrtimer to periodically refresh the events to
> prevent this, but this would need to be set at some very high frequency
> to account for the fastest potential counter, and would significantly
> degrade performance.
> 
> I don't think that's going to be reliable, and given that, I don't think
> that we can support muxed IRQs in this way.

Is it possible to get the overflow interrupts as well as read the PMU
counters for another CPU?

If not, I assume the interrupt bounce mechanism from ux500 is the only
way?

--
Stefan

> 
> Thanks,
> Mark.
> 
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>> This has been observed and tested on a i.MX 6DualLite, but is probably
>> valid for i.MX 6Quad as well.
>>
>> It seems that ux500 once had support for single IRQ on a SMP system,
>> however this got removed with:
>> Commit 2b05f6ae1ee5 ("ARM: ux500: remove PMU IRQ bouncer")
>>
>> I noticed that with this patch I get an error when trying to use perf stat:
>>   # perf top
>>   Error:
>>   cycles: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
>>
>> Without this patch perf top seems to work, but it seems not to use any
>> sampling events (?):
>>   # perf top
>> PerfTop:    7215 irqs/sec  kernel:100.0%  exact:  0.0% [4000Hz cpu-clock:pppH], (all, 2 CPUs)
>> ....
>>
>> Also starting perf top and explicitly selecting cpu-clock seems to work
>> and show the same data as before this change.
>>   # perf top -e cpu-clock:pppH
>> PerfTop:    7214 irqs/sec  kernel:100.0%  exact:  0.0% [4000Hz cpu-clock:pppH], (all, 2 CPUs)
>>
>> It seems that perf top falls back to cpu-clock in the old case, but not
>> once sampling events are not supported...
>>
>> --
>> Stefan
>>
>>
>>  drivers/perf/arm_pmu_platform.c | 19 +++++++++++--------
>>  1 file changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
>> index 933bd8410fc2..80b991417b6e 100644
>> --- a/drivers/perf/arm_pmu_platform.c
>> +++ b/drivers/perf/arm_pmu_platform.c
>> @@ -105,23 +105,26 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
>>  		return num_irqs;
>>  	}
>>
>> +	if (num_irqs == 1) {
>> +		int irq = platform_get_irq(pdev, 0);
>> +		if (irq && irq_is_percpu_devid(irq))
>> +			return pmu_parse_percpu_irq(pmu, irq);
>> +	}
>> +
>>  	/*
>>  	 * In this case we have no idea which CPUs are covered by the PMU.
>>  	 * To match our prior behaviour, we assume all CPUs in this case.
>> +	 * Multiple CPUs with a single PMU irq are currently not handled.
>> +	 * Rather than supporting only the first CPU, support all CPUs but
>> +	 * without interrupt capability.
>>  	 */
>> -	if (num_irqs == 0) {
>> -		pr_warn("no irqs for PMU, sampling events not supported\n");
>> +	if (num_irqs == 0 || (nr_cpu_ids > 1 && num_irqs == 1)) {
>> +		pr_info("No per CPU irqs for PMU, sampling events not supported\n");
>>  		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
>>  		cpumask_setall(&pmu->supported_cpus);
>>  		return 0;
>>  	}
>>
>> -	if (num_irqs == 1) {
>> -		int irq = platform_get_irq(pdev, 0);
>> -		if (irq && irq_is_percpu_devid(irq))
>> -			return pmu_parse_percpu_irq(pmu, irq);
>> -	}
>> -
>>  	if (nr_cpu_ids != 1 && !pmu_has_irq_affinity(pdev->dev.of_node)) {
>>  		pr_warn("no interrupt-affinity property for %pOF, guessing.\n",
>>  			pdev->dev.of_node);
>> --
>> 2.20.1
>>
