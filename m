Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935698AbeE3GHP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 02:07:15 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36140 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934498AbeE3GHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 02:07:12 -0400
X-Google-Smtp-Source: ADUXVKLWOxAtmj0s2MfkhK00SXr6eUgcCFjYRWN05YNob024+G5uTGqC7yRsmGRHKM81VAzQjmXZwA7me7Cw8RZaZVY=
MIME-Version: 1.0
In-Reply-To: <20180530055815.GB6463@gmail.com>
References: <20180529133622.26982-1-nixiaoming@huawei.com> <20180530055815.GB6463@gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 30 May 2018 08:07:10 +0200
Message-ID: <CAKv+Gu-FvWoDbMV2veh8BzW7ihbvaw-cd+rK5x_TLq0UC99FNg@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86:add missing CONFIG_STRICT_KERNEL_RWX for mark_rodata_ro
To: Ingo Molnar <mingo@kernel.org>
Cc: nixiaoming <nixiaoming@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        zhang.jia@linux.alibaba.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 May 2018 at 07:58, Ingo Molnar <mingo@kernel.org> wrote:
>
> * nixiaoming <nixiaoming@huawei.com> wrote:
>
>> mark_rodata_ro is only called by the function mark_readonly
>> when CONFIG_STRICT_KERNEL_RWX=y
>>
>> if CONFIG_STRICT_KERNEL_RWX is not set
>> a compile warning may be triggered: unused function
>>
>> Signed-off-by: nixiaoming <nixiaoming@huawei.com>
>> ---
>>  arch/x86/mm/init_32.c | 2 ++
>>  arch/x86/mm/init_64.c | 2 ++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
>> index c893c6a..121c567 100644
>> --- a/arch/x86/mm/init_32.c
>> +++ b/arch/x86/mm/init_32.c
>> @@ -920,6 +920,7 @@ static void mark_nxdata_nx(void)
>>       set_pages_nx(virt_to_page(start), size >> PAGE_SHIFT);
>>  }
>>
>> +#ifdef CONFIG_STRICT_KERNEL_RWX
>>  void mark_rodata_ro(void)
>>  {
>>       unsigned long start = PFN_ALIGN(_text);
>> @@ -957,3 +958,4 @@ void mark_rodata_ro(void)
>>       if (__supported_pte_mask & _PAGE_NX)
>>               debug_checkwx();
>>  }
>> +#endif /*end of CONFIG_STRICT_KERNEL_RWX*/
>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>> index 0a40060..1b7a1a7 100644
>> --- a/arch/x86/mm/init_64.c
>> +++ b/arch/x86/mm/init_64.c
>> @@ -1245,6 +1245,7 @@ void set_kernel_text_ro(void)
>>       set_memory_ro(start, (end - start) >> PAGE_SHIFT);
>>  }
>>
>> +#ifdef CONFIG_STRICT_KERNEL_RWX
>>  void mark_rodata_ro(void)
>>  {
>>       unsigned long start = PFN_ALIGN(_text);
>> @@ -1298,6 +1299,7 @@ void mark_rodata_ro(void)
>>        */
>>       pti_clone_kernel_text();
>>  }
>> +#endif
>
> NAK, this is very ugly and the changelog doesn't appear to be true: the build
> warning does not trigger in the default build, correct?
>

I don't see how the build warning could trigger at all, given that
mark_rodata_ro() has external linkage.
