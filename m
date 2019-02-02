Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C7AC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 03:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24C920870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 03:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfBBDIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 22:08:32 -0500
Received: from mail5.windriver.com ([192.103.53.11]:47114 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfBBDIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 22:08:32 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x1235Cuh002449
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 1 Feb 2019 19:05:53 -0800
Received: from [128.224.162.152] (128.224.162.152) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.435.0; Fri, 1 Feb 2019
 19:05:10 -0800
Subject: Re: [PATCH 00/10] GICv3 support for kexec/kdump on EFI systems
To:     Marc Zyngier <marc.zyngier@arm.com>, Sun Ted <xulinsun@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
 <CACiNFG5r2Czfy_kXA2PPQa=xdyzq0vUgoQZ=XNME4d_h=O1oBw@mail.gmail.com>
 <b4594318-9ebf-91ce-b845-3fac92ba6476@arm.com>
From:   Xulin Sun <xulin.sun@windriver.com>
Message-ID: <6f209705-dcc9-425b-d65c-db11f45e8096@windriver.com>
Date:   Sat, 2 Feb 2019 11:05:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <b4594318-9ebf-91ce-b845-3fac92ba6476@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2019 05:15 PM, Marc Zyngier wrote:
> Hi Xulin,
>
> On 01/02/2019 06:11, Sun Ted wrote:
>> Hi Marc,
>>
>> Marc Zyngier <marc.zyngier@arm.com <mailto:marc.zyngier@arm.com>> 于2018
>> 年9月22日周六 上午4:03写道：
>>
>>      The GICv3 architecture has the remarkable feature that once LPI tables
>>      have been assigned to redistributors and that LPI delivery is enabled,
>>      there is no guarantee that LPIs can be turned off (and most
>>      implementations do not allow it), nor can it be reprogrammed to use
>>      other tables.
>>
>>      This is a bit of a problem for kexec, where the secondary kernel
>>      completely looses track of the previous allocations. If the secondary
>>      kernel doesn't allocate the tables exactly the same way, no LPIs will
>>      be delivered by the GIC (which continues to use the old tables), and
>>      memory previously allocated for the pending tables will be slowly
>>      corrupted, one bit at a time.
>>
>>      The workaround for this is based on a series[1] by Ard Biesheuvel,
>>      which adds the required infrastructure for memory reservations to be
>>      passed from one kernel to another using an EFI table.
>>
>>      This infrastructure is then used to register the allocation of GIC
>>      tables with EFI, and allow the GIC driver to safely reuse the existing
>>      programming if it detects that the tables have been correctly
>>      registered. On non-EFI systems, there is not much we can do.
>>
>>
>> Sorry to turn this question out again.
>> For others non-EFI systems, just as your said till now we did do
>> anything, right?
> We didn't do anything, because there is nothing we can do.
>
>> I did see the kexec booting failure since re-setting
>> the GICR_CTLR.EnableLPI from "1" to "0" unsuccessful.
>>
>> The  below commit adds the judgement for disabling LPIs, and returned
>> error. Caused "kexec" booting failure.
> And I fully expected this. When I said "we don't do anything", I meant
> "we don't do anything to make LPIs work".
>
>> 6eb486b66a (irqchip/gic-v3: Ensure GICR_CTLR.EnableLPI=0 is observed
>> before enabling).
>>
>> <snip patch>
>>   int its_cpu_init(void)
>>   {
>>          if (!list_empty(&its_nodes)) {
>> -               if (!gic_rdists_supports_plpis()) {
>> -                       pr_info("CPU%d: LPIs not supported\n",
>> smp_processor_id());
>> -                       return -ENXIO;
>> -               }
>> +               int ret;
>> +
>> +               ret = redist_disable_lpis();
>> +               if (ret)
>> +                       return ret;
>> +
> And I maintain that this is the right thing to do. If LPIs are on and
> the memory has not been reserved, it is then likely that this memory is
> now being used by the kernel for something else. The system is thus
> going to see single-bit corruption in some random places.
>
> At that stage, your system is horribly unsafe, and I will not let it
> boot under these conditions. If it was working before, that's because
> you were lucky, and I place no faith in luck.
>
> Now you have two alternatives:
>
> - You switch to an EFI-based firmware. These days, even u-boot has an
> EFI implementation. COnsider doing that if you can.
>
> - If there is no EFI implementation for your SoC, you can pass the
> "irqchip.gicv3_nolpi=1" option to the first kernel. This will keep LPI
> disabled, and you'll be able to kexec a secondary kernel (and get
> working LPIs there). This is what I do on my Chromebook.

Hi Marc,

Thanks for detailed explanation.

Thanks
Xulin
>
> Thanks,
>
> 	M.

