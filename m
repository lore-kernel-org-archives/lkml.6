Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E0EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F01420873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F01420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbeK0VBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:01:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730371AbeK0VBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:01:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F52D3086267;
        Tue, 27 Nov 2018 10:04:23 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B87F3174A8;
        Tue, 27 Nov 2018 10:04:05 +0000 (UTC)
Subject: Re: [PATCH 1/2 RESEND v7] resource: add the new I/O resource
 descriptor 'IORES_DESC_RESERVED'
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-ia64@vger.kernel.org, linux-efi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, ard.biesheuvel@linaro.org,
        tony.luck@intel.com, fenghua.yu@intel.com, dyoung@redhat.com,
        bhe@redhat.com
References: <20181124051223.19994-1-lijiang@redhat.com>
 <20181124051223.19994-2-lijiang@redhat.com>
 <ae405fe9-94fd-3fb7-decd-c7821cf95b7d@intel.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <460c5552-a48e-3523-275a-7f94d0f08f9b@redhat.com>
Date:   Tue, 27 Nov 2018 18:04:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ae405fe9-94fd-3fb7-decd-c7821cf95b7d@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 27 Nov 2018 10:04:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年11月27日 04:52, Dave Hansen 写道:
> On 11/23/18 9:12 PM, Lianbo Jiang wrote:
>> The upstream kernel can not accurately add the e820 reserved type to> kdump krenel e820 table.
> 
> 	^ kernel
> 
>> Kdump uses walk_iomem_res_desc() to iterate io resources, then adds
>> the matched resource ranges to the e820 table for kdump kernel. But,
>> when convert the e820 type to the iores descriptor, several e820
>> types are converted to 'IORES_DESC_NONE' in this function e820_type
>> _to_iores_desc(). So the walk_iomem_res_desc() will get the redundant
>> types(such as E820_TYPE_RAM/E820_TYPE_UNUSABLE/E820_TYPE_KERN) when
>> walk through io resources with the descriptor 'IORES_DESC_NONE'.
> 
> Let me see if I understand.
> 
> When doing kexec, the old kernel makes a new e820 table for the new
> kernel.  The old kernel constructs the new e820 table from
> 'iomem_resource'.  But, when creating the 'iomem_resource' tree,
> reserved areas like E820_TYPE_RESERVED are not properly passed through.
>  This causes problems like described in the next patch.
> 

When doing kexec_file_load, the old kernel need to pass the e820 reserved ranges
to the kdump kernel. But kernel can not exactly match the e820 reserved ranges when
walking through the iomem resources with the descriptor 'IORES_DESC_NONE', because
the descriptor 'IORES_DESC_NONE' contains four e820 types, such as 'E820_TYPE_RAM',
'E820_TYPE_UNUSABLE', 'E820_TYPE_RESERVED_KERN', 'E820_TYPE_RESERVED'. It may pass
these four types to the kdump kernel, this is not desired result.

Please refer to this function e820_type_to_iores_desc(). (arch/x86/kernel/e820.c)

>> This patch adds the new I/O resource descriptor 'IORES_DESC_RESERVED'
>> for the iomem resources search interfaces. It is helpful to exactly
>> match the reserved resource ranges when walking through iomem resources.
> 
> It's more than that, though.  You're specifically storing the reserved
> area(s) when we see them come through the firmware.
> 
>> Furthermore, in order to make it still work after the new descriptor
>> is added, these codes originally related to 'IORES_DESC_NONE' have
>> been updated.
> 
> It would be nice to explain why they needed to be updated and what
> breaks if they are not.
> 

If these code paths have not been updated, the reserved regions descriptor is still marked
as the 'IORES_DESC_NONE' instead of 'IORES_DESC_RESERVED', this is not correct and it is 
also easily confused.

And also cause some errors, such as the following function __ioremap_check_desc_other().

>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>> index 5378d10f1d31..91b6112e7489 100644
>> --- a/arch/x86/mm/ioremap.c
>> +++ b/arch/x86/mm/ioremap.c
>> @@ -83,7 +83,14 @@ static bool __ioremap_check_ram(struct resource *res)
>>  
>>  static int __ioremap_check_desc_other(struct resource *res)
>>  {
>> -	return (res->desc != IORES_DESC_NONE);
>> +	/*
>> +	 * The E820_TYPE_RESERVED was converted to the IORES_DESC_NONE
>> +	 * before the new IORES_DESC_RESERVED is added, so it contained
>> +	 * the e820 reserved type. In order to make it still work for
>> +	 * SEV, here keep it the same as before.
>> +	 */
>> +	return ((res->desc != IORES_DESC_NONE) ||
>> +		(res->desc != IORES_DESC_RESERVED));
>>  }
> 
> After reading the changelog and the comment, I still have no idea why
> this hunk is here.  Could you try to explain a bit more?
> 
> 

Thanks for your comment.

What happens if we don't modify this functions __ioremap_check_desc_other()?
-When SEV is active, it might map these reserved regions with the encryption mask. That is incorrect.
Therefore, keep it the same as before in order to make it still work for the SEV case.

**BTW**:
In this function __ioremap_check_desc_other(), it should use the '&&' operator instead of
the '||' operator. I made a mistake in this function(sorry for this), i will improve this
function in patch v8 and post again like this:

static int __ioremap_check_desc_other(struct resource *res)
{
    return ((res->desc != IORES_DESC_NONE) &&
            (res->desc != IORES_DESC_RESERVED));
}


Regards,
Lianbo
