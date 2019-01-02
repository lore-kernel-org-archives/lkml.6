Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF20C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B77214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfABWTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 17:19:41 -0500
Received: from foss.arm.com ([217.140.101.70]:38014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbfABWTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 17:19:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D15A1EBD;
        Wed,  2 Jan 2019 14:19:40 -0800 (PST)
Received: from [192.168.100.243] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B55A3F5D4;
        Wed,  2 Jan 2019 14:19:40 -0800 (PST)
Subject: Re: [PATCH 4/6] arm64: add sysfs vulnerability show for spectre v2
To:     Julien Thierry <julien.thierry@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, dave.martin@arm.com,
        shankerd@codeaurora.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, ykaukab@suse.de
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
 <20181206234408.1287689-5-jeremy.linton@arm.com>
 <6c572de0-da38-c273-82ed-bafb86bbfa7a@arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <9c7f25d2-f34a-5b10-e3da-2f4346aa9b44@arm.com>
Date:   Wed, 2 Jan 2019 16:19:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6c572de0-da38-c273-82ed-bafb86bbfa7a@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/13/2018 05:09 AM, Julien Thierry wrote:
> 
> 
> On 06/12/2018 23:44, Jeremy Linton wrote:
>> Add code to track whether all the cores in the machine are
>> vulnerable, and whether all the vulnerable cores have been
>> mitigated.
>>
>> Once we have that information we can add the sysfs stub and
>> provide an accurate view of what is known about the machine.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/kernel/cpu_errata.c | 72 +++++++++++++++++++++++++++++++---
>>   1 file changed, 67 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
>> index 559ecdee6fd2..6505c93d507e 100644
>> --- a/arch/arm64/kernel/cpu_errata.c
>> +++ b/arch/arm64/kernel/cpu_errata.c
> 
> [...]
> 
>> @@ -766,4 +812,20 @@ ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr,
>>   	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
>>   }
>>   
>> +ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
>> +		char *buf)
>> +{
>> +	switch (__spectrev2_safe) {
>> +	case A64_SV2_SAFE:
>> +		return sprintf(buf, "Not affected\n");
>> +	case A64_SV2_UNSAFE:
>> +		if (__hardenbp_enab == A64_HBP_MIT)
>> +			return sprintf(buf,
>> +				"Mitigation: Branch predictor hardening\n");
>> +		return sprintf(buf, "Vulnerable\n");
>> +	default:
>> +		return sprintf(buf, "Unknown\n");
>> +	}
> 
> Again I see that we are going to display "Unknown" when the mitigation
> is not built in.
> 
> Couldn't we make that CONFIG_GENERIC_CPU_,gation is not implemented? It's
> just checking the list of MIDRs.


Before I re-post, its probably worth pointing out that the 
spectrev2_safe isn't set the same as the meltdown safe flag (which 
reflects a whitelist or cpu_good flag) where the unknown/unsafe 
condition is currently the same.

spectrev2_safe is a white/black list with a black list of known 
vulnerable cores, plus cores with csv2 set indicating they are good. 
This means the unset condition conceptually covers, the check being 
disabled, as well as the core not being one of either known bad or known 
good cores. Meaning you still need a dedicated "unknown" state because 
the final state isn't unknown simply because the mitigation is not 
compiled in.

