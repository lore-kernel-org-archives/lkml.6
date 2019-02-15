Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18FBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9985521927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391223AbfBOQE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:04:58 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34476 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfBOQE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:04:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A70F3EBD;
        Fri, 15 Feb 2019 08:04:57 -0800 (PST)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 077F83F557;
        Fri, 15 Feb 2019 08:04:56 -0800 (PST)
Subject: Re: [RFC 2/3] arm_pmu: acpi: spe: Add initial MADT/SPE probing
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        robert.moore@intel.com, erik.schmauss@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org
References: <20190209004718.3292087-1-jeremy.linton@arm.com>
 <20190209004718.3292087-3-jeremy.linton@arm.com>
 <20190214171125.GG2475@fuggles.cambridge.arm.com>
 <c740a06e-d5d3-3e42-d19b-fbfea02ac0e7@arm.com>
 <20190215150015.GA6803@fuggles.cambridge.arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <09cbaf45-d514-3cb3-4bab-744491462338@arm.com>
Date:   Fri, 15 Feb 2019 10:04:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215150015.GA6803@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/15/19 9:00 AM, Will Deacon wrote:
> On Thu, Feb 14, 2019 at 12:03:57PM -0600, Jeremy Linton wrote:
>> On 2/14/19 11:11 AM, Will Deacon wrote:
>>> On Fri, Feb 08, 2019 at 06:47:17PM -0600, Jeremy Linton wrote:
>>>> +/*
>>>> + * For lack of a better place, hook the normal PMU MADT walk
>>>> + * and create a SPE device if we detect a recent MADT with
>>>> + * a homogeneous PPI mapping.
>>>> + */
>>>> +static int arm_spe_acpi_parse_irqs(void)
>>>> +{
>>>> +	int cpu, ret, irq;
>>>> +	u16 gsi = 0;
>>>> +	bool first = true;
>>>> +
>>>> +	struct acpi_madt_generic_interrupt *gicc;
>>>> +
>>>> +	/*
>>>> +	 * sanity check all the GICC tables for the same interrupt number
>>>> +	 * for now we only support homogeneous ACPI/SPE machines.
>>>> +	 */
>>>> +	for_each_possible_cpu(cpu) {
>>>> +		gicc = acpi_cpu_get_madt_gicc(cpu);
>>>> +
>>>> +		if (gicc->header.length < ACPI_MADT_GICC_SPE)
>>>> +			return -ENODEV;
>>>> +
>>>> +		if (first) {
>>>> +			gsi = gicc->spe_overflow_interrupt;
>>>> +			if (!gsi)
>>>> +				return -ENODEV;
>>>> +			first = false;
>>>> +		} else if (gsi != gicc->spe_overflow_interrupt) {
>>>> +			pr_warn("ACPI: SPE must have homogeneous interrupts\n");
>>>> +			return -EINVAL;
>>>> +		}
>>>
>>> Unfortunately, I don't think this is sufficient to detect a homogeneous
>>> system: we'll have to check the MIDRs instead, which is nasty. I would
>>> personally be in favour of enforcing homogeneity for ACPI systems when we
>>> bring up secondary CPUs, but I suspect others would disagree.
>>
>> Given that all the SPE capable machines i'm aware of at the moment are
>> homogeneous, are we ok with just doing an online CPU MIDR check for now, and
>> cleaning that up if/when someone builds a machine and complains?
> 
> Yeah, I think we added a new bit to the PPTT to tell you that the machine is
> homogenous, so just check that first and bail if it's not set.

Yes of course, 100% better plan. Although its probably going to have to 
be more of a case of walking all the possible cores and assuring they 
have the same flag level (similar to how the socket flag is handled). Of 
course that information is useful enough it should probably just be done 
as part of the normal cpu topology walk. Then the people who have to 
back port these patches end up with a big dependent set... <chuckle>


