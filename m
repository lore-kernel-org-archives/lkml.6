Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC9DC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFF120861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfAWJEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:04:52 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37716 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfAWJEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:04:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 785EAA78;
        Wed, 23 Jan 2019 01:04:50 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53A3D3F6A8;
        Wed, 23 Jan 2019 01:04:48 -0800 (PST)
Subject: Re: [PATCH v9 11/26] efi: Let architectures decide the flags that
 should be saved/restored
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-12-git-send-email-julien.thierry@arm.com>
 <CAKv+Gu8w1cgrqpoL2n2Q=Jbjt_ZruF=oH0-cDyy-LuJUo8YBEA@mail.gmail.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <29fd5a40-e5ad-b430-c28b-57120f7dc312@arm.com>
Date:   Wed, 23 Jan 2019 09:04:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8w1cgrqpoL2n2Q=Jbjt_ZruF=oH0-cDyy-LuJUo8YBEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/01/2019 15:42, Ard Biesheuvel wrote:
> On Mon, 21 Jan 2019 at 16:34, Julien Thierry <julien.thierry@arm.com> wrote:
>>
>> Currently, irqflags are saved before calling runtime services and
>> checked for mismatch on return.
>>
>> Provide a pair of overridable macros to save and restore (if needed) the
>> state that need to be preserved on return from a runtime service.
>> This allows to check for flags that are not necesarly related to
>> irqflags.
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: linux-efi@vger.kernel.org
>> ---
>>  drivers/firmware/efi/runtime-wrappers.c | 17 +++++++++++++++--
>>  include/linux/efi.h                     |  5 +++--
>>  2 files changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
>> index 8903b9c..2f4b68b 100644
>> --- a/drivers/firmware/efi/runtime-wrappers.c
>> +++ b/drivers/firmware/efi/runtime-wrappers.c
>> @@ -89,11 +89,24 @@
>>         efi_rts_work.status;                                            \
>>  })
>>
>> +#ifndef arch_efi_save_flags
>> +#define arch_efi_save_flags(state_flags)       local_save_flags(state_flags)
>> +#define arch_efi_restore_flags(state_flags)    local_irq_restore(state_flags)
>> +#endif
>> +
>> +inline unsigned long efi_call_virt_save_flags(void)
> 
> If you drop the 'inline' here,
> 

Sure, I'll drop it in the next version.

> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 

Thanks,

Julien

>> +{
>> +       unsigned long flags;
>> +
>> +       arch_efi_save_flags(flags);
>> +       return flags;
>> +}
>> +
>>  void efi_call_virt_check_flags(unsigned long flags, const char *call)
>>  {
>>         unsigned long cur_flags, mismatch;
>>
>> -       local_save_flags(cur_flags);
>> +       cur_flags = efi_call_virt_save_flags();
>>
>>         mismatch = flags ^ cur_flags;
>>         if (!WARN_ON_ONCE(mismatch & ARCH_EFI_IRQ_FLAGS_MASK))
>> @@ -102,7 +115,7 @@ void efi_call_virt_check_flags(unsigned long flags, const char *call)
>>         add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_NOW_UNRELIABLE);
>>         pr_err_ratelimited(FW_BUG "IRQ flags corrupted (0x%08lx=>0x%08lx) by EFI %s\n",
>>                            flags, cur_flags, call);
>> -       local_irq_restore(flags);
>> +       arch_efi_restore_flags(flags);
>>  }
>>
>>  /*
>> diff --git a/include/linux/efi.h b/include/linux/efi.h
>> index 45ff763..bd80b7e 100644
>> --- a/include/linux/efi.h
>> +++ b/include/linux/efi.h
>> @@ -1607,6 +1607,7 @@ efi_status_t efi_setup_gop(efi_system_table_t *sys_table_arg,
>>
>>  bool efi_runtime_disabled(void);
>>  extern void efi_call_virt_check_flags(unsigned long flags, const char *call);
>> +extern unsigned long efi_call_virt_save_flags(void);
>>
>>  enum efi_secureboot_mode {
>>         efi_secureboot_mode_unset,
>> @@ -1652,7 +1653,7 @@ enum efi_secureboot_mode {
>>                                                                         \
>>         arch_efi_call_virt_setup();                                     \
>>                                                                         \
>> -       local_save_flags(__flags);                                      \
>> +       __flags = efi_call_virt_save_flags();                           \
>>         __s = arch_efi_call_virt(p, f, args);                           \
>>         efi_call_virt_check_flags(__flags, __stringify(f));             \
>>                                                                         \
>> @@ -1667,7 +1668,7 @@ enum efi_secureboot_mode {
>>                                                                         \
>>         arch_efi_call_virt_setup();                                     \
>>                                                                         \
>> -       local_save_flags(__flags);                                      \
>> +       __flags = efi_call_virt_save_flags();                           \
>>         arch_efi_call_virt(p, f, args);                                 \
>>         efi_call_virt_check_flags(__flags, __stringify(f));             \
>>                                                                         \
>> --
>> 1.9.1
>>

-- 
Julien Thierry
