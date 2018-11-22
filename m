Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B359C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EFD20864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EFD20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392903AbeKVTAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:00:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbeKVTAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:00:17 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 012D49F733;
        Thu, 22 Nov 2018 08:21:55 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-69.pek2.redhat.com [10.72.12.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 539511054FD3;
        Thu, 22 Nov 2018 08:21:47 +0000 (UTC)
Subject: Re: [PATCH 1/2 v7] resource: add the new I/O resource descriptor
 'IORES_DESC_RESERVED'
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-kernel@vger.kernel.org, bhe@redhat.com, x86@kernel.org,
        kexec@lists.infradead.org, mingo@redhat.com, bp@alien8.de,
        tglx@linutronix.de, akpm@linux-foundation.org
References: <20181115095529.21220-1-lijiang@redhat.com>
 <20181115095529.21220-2-lijiang@redhat.com>
 <20181122074202.GA8524@dhcp-128-65.nay.redhat.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <1f37d5c8-b919-8163-942a-660e7e7a964d@redhat.com>
Date:   Thu, 22 Nov 2018 16:21:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181122074202.GA8524@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 22 Nov 2018 08:21:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年11月22日 15:42, Dave Young 写道:
> On 11/15/18 at 05:55pm, Lianbo Jiang wrote:
>> The upstream kernel can not accurately add the e820 reserved type to
>> kdump krenel e820 table.
>>
>> Kdump uses walk_iomem_res_desc() to iterate io resources, then adds
>> the matched resource ranges to the e820 table for kdump kernel. But,
>> when convert the e820 type into the iores descriptor, several e820
>> types are converted to 'IORES_DESC_NONE' in this function e820_type
>> _to_iores_desc(). So the walk_iomem_res_desc() will get unnecessary
>> types(such as E820_TYPE_RAM/E820_TYPE_UNUSABLE/E820_TYPE_KERN) when
>> walk through io resources by the descriptor 'IORES_DESC_NONE'.
>>
>> This patch adds the new I/O resource descriptor 'IORES_DESC_RESERVED'
>> for the iomem resources search interfaces. It is helpful to exactly
>> match the reserved resource ranges when walking through iomem resources.
>>
>> Suggested-by: Dave Young <dyoung@redhat.com>
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> ---
>> Changes since v5:
>> 1. Improve the patch log
>>
>> Changes since v6:
>> 1. Modify this patch, and add the new I/O resource descriptor
>>    'IORES_DESC_RESERVED' for the iomem resources search interfaces.
>> 2. Improve patch log.
>>
>>  arch/x86/kernel/e820.c | 2 +-
>>  include/linux/ioport.h | 1 +
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>> index 50895c2f937d..57fafdafb860 100644
>> --- a/arch/x86/kernel/e820.c
>> +++ b/arch/x86/kernel/e820.c
>> @@ -1048,10 +1048,10 @@ static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)
>>  	case E820_TYPE_NVS:		return IORES_DESC_ACPI_NV_STORAGE;
>>  	case E820_TYPE_PMEM:		return IORES_DESC_PERSISTENT_MEMORY;
>>  	case E820_TYPE_PRAM:		return IORES_DESC_PERSISTENT_MEMORY_LEGACY;
>> +	case E820_TYPE_RESERVED:	return IORES_DESC_RESERVED;
>>  	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
>>  	case E820_TYPE_RAM:		/* Fall-through: */
>>  	case E820_TYPE_UNUSABLE:	/* Fall-through: */
>> -	case E820_TYPE_RESERVED:	/* Fall-through: */
>>  	default:			return IORES_DESC_NONE;
>>  	}
>>  }
>> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>> index da0ebaec25f0..6ed59de48bd5 100644
>> --- a/include/linux/ioport.h
>> +++ b/include/linux/ioport.h
>> @@ -133,6 +133,7 @@ enum {
>>  	IORES_DESC_PERSISTENT_MEMORY_LEGACY	= 5,
>>  	IORES_DESC_DEVICE_PRIVATE_MEMORY	= 6,
>>  	IORES_DESC_DEVICE_PUBLIC_MEMORY		= 7,
>> +	IORES_DESC_RESERVED			= 8,
>>  };
> 
> There more works for a new iores desc. Originally IORES_DESC_NONE
> is assumed to include reserved e820 type so all code path relates to
> IORES_DESC_NONE should be carefully checked and ensure they still work after
> your changes.
> 

Thanks for your reminder.

I'm checking it, and also will resend v7 later. Please ignore this patch.

Regards,
Lianbo

>>  
>>  /* helpers to define resources */
>> -- 
>> 2.17.1
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
> 
> Thanks
> Dave
> 
