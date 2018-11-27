Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E163C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FED2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FED2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbeK1DbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:31:07 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41670 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731035AbeK1DbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:31:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2301302F;
        Tue, 27 Nov 2018 08:32:39 -0800 (PST)
Received: from [192.168.100.243] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4A023F59C;
        Tue, 27 Nov 2018 08:32:38 -0800 (PST)
Subject: Re: [PATCH 2/2] arm64: acpi: Prepare for longer MADTs
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, rafael.j.wysocki@intel.com,
        takahiro.akashi@linaro.org, sudeep.holla@arm.com, ahs3@redhat.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181012192937.3819951-1-jeremy.linton@arm.com>
 <20181127150150.GA25270@e107981-ln.cambridge.arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <9cb71380-6546-4c4b-9075-10e21784d476@arm.com>
Date:   Tue, 27 Nov 2018 10:32:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20181127150150.GA25270@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

On 11/27/2018 09:01 AM, Lorenzo Pieralisi wrote:
> On Fri, Oct 12, 2018 at 02:29:37PM -0500, Jeremy Linton wrote:
>> The BAD_MADT_GICC_ENTRY check is a little too strict because
>> it rejects MADT entries that don't match the currently known
>> lengths. We should remove this restriction to avoid problems
>> if the table length changes. Future code which might depend on
>> additional fields should be written to validate those fields
>> before using them, rather than trying to globally check
>> known MADT version lengths.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/include/asm/acpi.h | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Hi Jeremy,
> 
> as mentioned, I added a comment to the macro so that in the future
> we will be able to remember the logic behind it.

It all looks good to me, Thanks!


> 
> I pushed the commit out:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git acpi/madt
> 
> Please have a look, if I hear no objections I shall be sending it to
> Will and Catalin to queue it for v4.21.
> 
> Thanks,
> Lorenzo
> 
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
>> index 709208dfdc8b..4d0946bd485a 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -22,12 +22,12 @@
>>   #include <asm/tlbflush.h>
>>   
>>   /* Macros for consistency checks of the GICC subtable of MADT */
>> -#define ACPI_MADT_GICC_LENGTH	\
>> -	(acpi_gbl_FADT.header.revision < 6 ? 76 : 80)
>> +#define ACPI_MADT_GICC_MIN_LENGTH   ACPI_OFFSET(  \
>> +	struct acpi_madt_generic_interrupt, efficiency_class)
>>   
>>   #define BAD_MADT_GICC_ENTRY(entry, end)					\
>> -	(!(entry) || (entry)->header.length != ACPI_MADT_GICC_LENGTH ||	\
>> -	(unsigned long)(entry) + ACPI_MADT_GICC_LENGTH > (end))
>> +	(!(entry) || (entry)->header.length < ACPI_MADT_GICC_MIN_LENGTH || \
>> +	(unsigned long)(entry) + (entry)->header.length > (end))
>>   
>>   /* Basic configuration for ACPI */
>>   #ifdef	CONFIG_ACPI
>> -- 
>> 2.14.3
>>

