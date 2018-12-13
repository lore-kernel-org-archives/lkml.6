Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08D2C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F065208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F065208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbeLMKqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:46:34 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58870 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbeLMKqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:46:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A208A78;
        Thu, 13 Dec 2018 02:46:33 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BCB83F6A8;
        Thu, 13 Dec 2018 02:46:31 -0800 (PST)
Subject: Re: [PATCH 2/6] arm64: add sysfs vulnerability show for meltdown
From:   Julien Thierry <julien.thierry@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, dave.martin@arm.com,
        shankerd@codeaurora.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, ykaukab@suse.de
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
 <20181206234408.1287689-3-jeremy.linton@arm.com>
 <d1ad00a8-1b87-f234-aa41-c1f342cb28dc@arm.com>
Message-ID: <af4f1e1e-673d-28e0-909d-f1e85b4d5b45@arm.com>
Date:   Thu, 13 Dec 2018 10:46:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d1ad00a8-1b87-f234-aa41-c1f342cb28dc@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/12/2018 09:23, Julien Thierry wrote:
> Hi Jeremy,
> 
> On 06/12/2018 23:44, Jeremy Linton wrote:
>> Add a simple state machine which will track whether
>> all the online cores in a machine are vulnerable.
>>
>> Once that is done we have a fairly authoritative view
>> of the machine vulnerability, which allows us to make a
>> judgment about machine safety if it hasn't been mitigated.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>  arch/arm64/kernel/cpufeature.c | 31 ++++++++++++++++++++++++++-----
>>  1 file changed, 26 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 242898395f68..bea9adfef7fa 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -905,6 +905,8 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
>>  	return has_cpuid_feature(entry, scope);
>>  }
>>  
>> +static enum { A64_MELT_UNSET, A64_MELT_SAFE, A64_MELT_UNKN } __meltdown_safe = A64_MELT_UNSET;
>> +
> 
> I'm wondering, do we really need that tri state?
> 
> Can't we consider that we are safe an move to unsafe/unkown if any cpu
> during bring up is not in the safe list?
> 
> The only user of this is cpu_show_meltdown, but I don't imagine it'll
> get called before unmap_kernel_at_el0() is called for the boot CPU which
> should initialise that state.
> 
> Or is there another reason for having that UNSET state?
> 

Ok, I think I get the point of the UNSET as #ifndef
CONFIG_UNMAP_KERNEL_AT_EL0 we don't set the state. But does that mean we
always fall in the "Unknown" case when we don't build kpti in? Is that
desirable?

If so, I'd suggest replacing the tri-state with the following change:


>> +
>> +#ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
>> +ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr,
>> +		char *buf)
>> +{
>> +	if (arm64_kernel_unmapped_at_el0())
>> +		return sprintf(buf, "Mitigation: KPTI\n");
>> +

	if (!IS_ENABLED(UNMAP_KERNEL_AT_EL0) || !meltdown_safe)
		sprintf(buf, "Unknown\n");
	else
		sprintf(buf, "Not affected\n");


Thanks,

-- 
Julien Thierry
