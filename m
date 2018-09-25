Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22EBC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 01:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDBB2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 01:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDBB2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeIYHJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 03:09:43 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:10503 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725954AbeIYHJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 03:09:43 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="45299933"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Sep 2018 09:04:46 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 5D3CF4B6EC97;
        Tue, 25 Sep 2018 09:04:46 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 25 Sep 2018 09:04:50 +0800
Date:   Tue, 25 Sep 2018 09:04:11 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Kees Cook <keescook@chromium.org>
CC:     linux-efi <linux-efi@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v7 3/3] x86/boot/KASLR: Limit kaslr to choosing the
 immovable memory
Message-ID: <20180925010411.GA12561@localhost.localdomain>
References: <20180913104629.5179-1-fanc.fnst@cn.fujitsu.com>
 <20180913104629.5179-4-fanc.fnst@cn.fujitsu.com>
 <CAGXu5jK13F7EY--zAVWq-=P2-Lt7n-K05ctL-vH7S=rcWKQoOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAGXu5jK13F7EY--zAVWq-=P2-Lt7n-K05ctL-vH7S=rcWKQoOw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 5D3CF4B6EC97.AF018
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 08:48:53AM -0700, Kees Cook wrote:
>On Thu, Sep 13, 2018 at 3:46 AM, Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>> +#ifdef CONFIG_MEMORY_HOTREMOVE
>> +       /*
>> +        * If immovable memory found, filter the intersection between
>> +        * immovable memory and region to slots_count.
>> +        * Otherwise, go on old code.
>> +        */
>> +       for (i = 0; i < num_immovable_mem; i++) {
>> +               struct mem_vector entry;
>> +               unsigned long long start, end, entry_end, region_end;
>> +
>> +               start = immovable_mem[i].start;
>> +               end = start + immovable_mem[i].size;
>> +               region_end = region->start + region->size;
>> +
>> +               entry.start = clamp(region->start, start, end);
>> +               entry_end = clamp(region_end, start, end);
>> +
>> +               if (entry.start + image_size < entry_end) {
>
>Can this logic be rewritten to use the existing mem_overlaps() check
>instead? I think that would make it much more readable.
>

Sure, I will reuse mem_overlaps() instead of this logical.

>Otherwise, yes, this all looks fine.

Thank you for the review.

Thanks,
Chao Fan

>
>-Kees
>
>> +                       entry.size = entry_end - entry.start;
>> +                       slots_count(&entry, minimum, image_size);
>> +
>> +                       if (slot_area_index == MAX_SLOT_AREA) {
>> +                               debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
>> +                               return 1;
>> +                       }
>> +               }
>> +       }
>> +       return 0;
>> +#endif
>> +}
>> +
>>  #ifdef CONFIG_EFI
>>  /*
>>   * Returns true if mirror region found (and must have been processed
>> @@ -720,11 +775,8 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
>>
>>                 region.start = md->phys_addr;
>>                 region.size = md->num_pages << EFI_PAGE_SHIFT;
>> -               process_mem_region(&region, minimum, image_size);
>> -               if (slot_area_index == MAX_SLOT_AREA) {
>> -                       debug_putstr("Aborted EFI scan (slot_areas full)!\n");
>> +               if (process_mem_region(&region, minimum, image_size))
>>                         break;
>> -               }
>>         }
>>         return true;
>>  }
>> @@ -751,11 +803,8 @@ static void process_e820_entries(unsigned long minimum,
>>                         continue;
>>                 region.start = entry->addr;
>>                 region.size = entry->size;
>> -               process_mem_region(&region, minimum, image_size);
>> -               if (slot_area_index == MAX_SLOT_AREA) {
>> -                       debug_putstr("Aborted e820 scan (slot_areas full)!\n");
>> +               if (process_mem_region(&region, minimum, image_size))
>>                         break;
>> -               }
>>         }
>>  }
>>
>> --
>> 2.17.1
>>
>>
>>
>
>
>
>-- 
>Kees Cook
>Pixel Security
>
>


