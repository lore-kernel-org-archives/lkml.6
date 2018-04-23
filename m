Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932567AbeDWWIN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 18:08:13 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44312 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932498AbeDWWIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 18:08:12 -0400
X-Google-Smtp-Source: AIpwx49QGE/dlmMa6lSuZVMNKrG0e9VVOLfWFgnEDwk1W1xHmDMa41VeUERvOP1CGKrtf7dJZjNuGw==
Date: Mon, 23 Apr 2018 15:08:10 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Apr 2018 14:47:53 PDT (-0700)
Subject: Re: [PATCH] RISC-V: Load modules within relative jump range of the kernel text.
In-Reply-To: <87lgdfieqj.fsf@xps13.shealevy.com>
CC: linux-riscv@lists.infradead.org, albert@sifive.com,
        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@sifive.com>
To: shea@shealevy.com
Message-ID: <mhng-0a2f9574-9b23-4f26-ae76-18ed7f2c8533@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Apr 2018 05:53:56 PDT (-0700), shea@shealevy.com wrote:
> Hi Palmer,
>
> Shea Levy <shea@shealevy.com> writes:
>
>> Signed-off-by: Shea Levy <shea@shealevy.com>
>> ---
>>
>> Note that this patch worked in my old modules patchset and seems to be
>> working now, but my kernel boot locks up on top of
>> riscv-for-linus-4.17-mw0 and I don't know if it's due to this patch or
>> something else that's changed in the mean time.
>>
>> ---
>>  arch/riscv/include/asm/pgtable.h |  9 +++++++++
>>  arch/riscv/kernel/module.c       | 11 +++++++++++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>> index 16301966d65b..b08ded13364a 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -25,6 +25,7 @@
>>  #include <asm/page.h>
>>  #include <asm/tlbflush.h>
>>  #include <linux/mm_types.h>
>> +#include <linux/sizes.h>
>>  
>>  #ifdef CONFIG_64BIT
>>  #include <asm/pgtable-64.h>
>> @@ -425,6 +426,14 @@ static inline void pgtable_cache_init(void)
>>  #define TASK_SIZE VMALLOC_START
>>  #endif
>>  
>> +/*
>> + * The module space lives between the addresses given by TASK_SIZE
>> + * and PAGE_OFFSET - it must be within 2G of the kernel text.
>> + */
>> +#define MODULES_SIZE		(SZ_128M)
>> +#define MODULES_VADDR		(PAGE_OFFSET - MODULES_SIZE)
>> +#define MODULES_END		(VMALLOC_END)
>> +
>>  #include <asm-generic/pgtable.h>
>>  
>>  #endif /* !__ASSEMBLY__ */
>> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
>> index 5dddba301d0a..1b382c7de095 100644
>> --- a/arch/riscv/kernel/module.c
>> +++ b/arch/riscv/kernel/module.c
>> @@ -16,6 +16,8 @@
>>  #include <linux/err.h>
>>  #include <linux/errno.h>
>>  #include <linux/moduleloader.h>
>> +#include <linux/vmalloc.h>
>> +#include <asm/pgtable.h>
>>  
>>  static int apply_r_riscv_64_rela(struct module *me, u32 *location, Elf_Addr v)
>>  {
>> @@ -382,3 +384,12 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
>>  
>>  	return 0;
>>  }
>> +
>> +void *module_alloc(unsigned long size)
>> +{
>> +	return __vmalloc_node_range(size, 1, MODULES_VADDR,
>> +				    MODULES_END, GFP_KERNEL,
>> +				    PAGE_KERNEL_EXEC, 0,
>> +				    NUMA_NO_NODE,
>> +				    __builtin_return_address(0));
>> +}
>> -- 
>> 2.16.2
>
> Any thoughts on this?

The concept looks good, but does this actually keep the modules within 2GiB of 
the text if PAGE_OFFSET is large?
