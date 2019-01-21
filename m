Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B673C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369BF2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="dZPHL+ni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfAUJkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:40:02 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:40674 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfAUJkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:40:02 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 04D375C013A;
        Mon, 21 Jan 2019 10:39:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1548063599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dKzpWpIDB0omKf8VnpAO2XxslJMWn9AwfROVElUps2A=;
        b=dZPHL+nii5/fuS4Vnswc4Tr94/ZGVGv0EA9wLsUYRKvIYrM5WCsoMLW6UrgRse6Nl6C2OI
        UIOZTi9GZFMZnUkVoIAm6Isd6zo5JZ1MvGzeEkmPbImpYgG1v+uIy1DTIBLnPJTTF9Fmgi
        zPvWEwdrRd8ZSnB6iwmBcRVg8OCaICc=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date:   Mon, 21 Jan 2019 10:39:58 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Lucas Stach <l.stach@pengutronix.de>, will.deacon@arm.com,
        mark.rutland@arm.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        max.krummenacher@toradex.com, marcel.ziswiler@toradex.com,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, fabio.estevam@nxp.com, dev@pschenker.ch,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] ARM: dts: imx6q: add pmu interrupt-affinity
In-Reply-To: <6e4fe68ec80926b4292ce786c6737182@agner.ch>
References: <20190118135907.2336-1-stefan@agner.ch>
 <1547820733.2626.11.camel@pengutronix.de>
 <6e4fe68ec80926b4292ce786c6737182@agner.ch>
Message-ID: <5f35af2bc4b5c97d69ff9ab1c71da1f7@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding Will/Mark]

On 18.01.2019 16:41, Stefan Agner wrote:
> On 18.01.2019 15:12, Lucas Stach wrote:
>> Am Freitag, den 18.01.2019, 14:59 +0100 schrieb Stefan Agner:
>>> Explicitly specify interrupt affinity to avoid HW perfevents
>>> need to guess. This avoids the following error upon boot:
>>>   hw perfevents: no interrupt-affinity property for /pmu, guessing.
>>>
>> But then it isn't correct either AFAICS. On i.MX6 all the PMU IRQs are
>> ORed together into a single SPI, instead of each core dealing with its
>> own PPI. So pretending that there are more IRQs with affinity to each
>> core isn't the right thing to do, no?
>>
> 
> Oh I see, we only have a single interrupt in the i.MX 6 case.
> 
> I agree, this patches are wrong.
> 
> Hm, but why does hw perf then think it needs to guess? Doesn't seem hard
> to guess right if there is only one choice...
> 
> We probably need to do something like this?
> 
> --- a/drivers/perf/arm_pmu_platform.c
> +++ b/drivers/perf/arm_pmu_platform.c
> @@ -122,7 +122,8 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
>                         return pmu_parse_percpu_irq(pmu, irq);
>         }
>  
> -       if (nr_cpu_ids != 1 && !pmu_has_irq_affinity(pdev->dev.of_node))
> {
> +       if ((nr_cpu_ids != 1 || num_irqs != 1) &&
> +           !pmu_has_irq_affinity(pdev->dev.of_node)) {
>                 pr_warn("no interrupt-affinity property for %pOF,
> guessing.\n",
>                         pdev->dev.of_node);
>         }

Yeah, I see, it was on Friday... if anything, it should be:

-       if (nr_cpu_ids != 1 && !pmu_has_irq_affinity(pdev->dev.of_node))
{
+       if (nr_cpu_ids != 1 && num_irqs != 1 &&
+           !pmu_has_irq_affinity(pdev->dev.of_node)) {

However, I realized that arm_pmu_platform actually currently only
assigns the one IRQ to the first CPU. This leads to perf not working if
a process is scheduled on another CPU then the first.

I could reproduce this. PID 763 is a long running task.

root@colibri-imx6-05051054:~# taskset -p 0x1 763
pid 763's current affinity mask: 3
pid 763's new affinity mask: 1


root@colibri-imx6-05051054:~# perf stat -e cpu-cycles -p 763
^C
 Performance counter stats for process id '763':

           7581021      cpu-cycles

       1.222248490 seconds time elapsed


root@colibri-imx6-05051054:~# taskset -p 0x2 763
pid 763's current affinity mask: 1
pid 763's new affinity mask: 2


root@colibri-imx6-05051054:~# perf stat -e cpu-cycles -p 763
^C
 Performance counter stats for process id '763':

     <not counted>      cpu-cycles                                      
             (0.00%)

       1.050253575 seconds time elapsed

I guess we need to tell the PMU driver that a single IRQ should be used
for all CPUs?

--
Stefan



> 
> 
>> Regards,
>> Lucas
>>
>>> Specifying all four CPUs shows no aversive effects on i.MX 6Dual
>>> SoCs.
>>>
>>> > Signed-off-by: Stefan Agner <stefan@agner.ch>
>>> ---
>>>  arch/arm/boot/dts/imx6q.dtsi | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
>>> index 8381d24eff7d..d2c1977c8b16 100644
>>> --- a/arch/arm/boot/dts/imx6q.dtsi
>>> +++ b/arch/arm/boot/dts/imx6q.dtsi
>>> @@ -537,6 +537,13 @@
>>> >  			<0x28 0x0000000c>; /* DCIC2_MUX_CTL */
>>>  };
>>>  
>>> +&pmu {
>>> > > +	interrupt-affinity = <&{/cpus/cpu@0}>,
>>> > > +			     <&{/cpus/cpu@1}>,
>>> > > +			     <&{/cpus/cpu@2}>,
>>> > > +			     <&{/cpus/cpu@3}>;
>>> +};
>>> +
>>>  &vpu {
>>> >  	compatible = "fsl,imx6q-vpu", "cnm,coda960";
>>>  };
