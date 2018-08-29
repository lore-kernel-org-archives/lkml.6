Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05802C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37EF204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckSluf2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37EF204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbeH2Tiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728979AbeH2Tiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:38:54 -0400
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EADCD20657
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 15:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535557283;
        bh=J606gdsmgQKnwfuPsG1tL/3EsYA8BWhdz7evHDIlJcQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ckSluf2LGBfreaLXx42jcWHBBoGoGN7F5JgQaiJ31gMmPNsrmFI9IelDu3NWsgEdj
         sazTPwSH9PNXLpT3I5qFnvYFgA4yUozYg+iItjZ1yjuVovS2R8/4NfRybo4bopgEGb
         0TS+95wSeT6D8DLEK/2TxR5deYJuLz9G3uzm8CS4=
Received: by mail-wm0-f54.google.com with SMTP id b19-v6so5768184wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 08:41:22 -0700 (PDT)
X-Gm-Message-State: APzg51Aw5/GTna6FHSfW850CRw88SzYt2WS7iff952Hdu5Y2bRdXZJgW
        BoB6EwUM6bfElSKp38cNnY91zjAQvzBnTIdgCdT7SQ==
X-Google-Smtp-Source: ANB0VdZJxmrxnvY/MFfqj1pgGI+XJn0R9LEk5TEMSasswMfHxZpsGV4VjLvz37T2PKr9R1Q2oSoQCF2phlc8BunQxJY=
X-Received: by 2002:a1c:8313:: with SMTP id f19-v6mr4376166wmd.144.1535557281428;
 Wed, 29 Aug 2018 08:41:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Wed, 29 Aug 2018 08:41:00 -0700 (PDT)
In-Reply-To: <20180829184925.64caee4dadf705080373f84f@kernel.org>
References: <20180829081147.184610-1-namit@vmware.com> <20180829081147.184610-3-namit@vmware.com>
 <20180829184925.64caee4dadf705080373f84f@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 29 Aug 2018 08:41:00 -0700
X-Gmail-Original-Message-ID: <CALCETrWF5XQndPikmBgo9t1UWKS7T0K2kFGOpzX-tavFVis5_Q@mail.gmail.com>
Message-ID: <CALCETrWF5XQndPikmBgo9t1UWKS7T0K2kFGOpzX-tavFVis5_Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] x86/mm: temporary mm struct
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 2:49 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> On Wed, 29 Aug 2018 01:11:43 -0700
> Nadav Amit <namit@vmware.com> wrote:
>
>> From: Andy Lutomirski <luto@kernel.org>
>>
>> Sometimes we want to set a temporary page-table entries (PTEs) in one of
>> the cores, without allowing other cores to use - even speculatively -
>> these mappings. There are two benefits for doing so:
>>
>> (1) Security: if sensitive PTEs are set, temporary mm prevents their use
>> in other cores. This hardens the security as it prevents exploding a
>> dangling pointer to overwrite sensitive data using the sensitive PTE.
>>
>> (2) Avoiding TLB shootdowns: the PTEs do not need to be flushed in
>> remote page-tables.
>>
>> To do so a temporary mm_struct can be used. Mappings which are private
>> for this mm can be set in the userspace part of the address-space.
>> During the whole time in which the temporary mm is loaded, interrupts
>> must be disabled.
>>
>> The first use-case for temporary PTEs, which will follow, is for poking
>> the kernel text.
>>
>> [ Commit message was written by Nadav ]
>>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> ---
>>  arch/x86/include/asm/mmu_context.h | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
>> index eeeb9289c764..96afc8c0cf15 100644
>> --- a/arch/x86/include/asm/mmu_context.h
>> +++ b/arch/x86/include/asm/mmu_context.h
>> @@ -338,4 +338,24 @@ static inline unsigned long __get_current_cr3_fast(void)
>>       return cr3;
>>  }
>>
>> +typedef struct {
>> +     struct mm_struct *prev;
>> +} temporary_mm_state_t;
>> +
>> +static inline temporary_mm_state_t use_temporary_mm(struct mm_struct *mm)
>> +{
>> +     temporary_mm_state_t state;
>> +
>> +     lockdep_assert_irqs_disabled();
>> +     state.prev = this_cpu_read(cpu_tlbstate.loaded_mm);
>> +     switch_mm_irqs_off(NULL, mm, current);
>> +     return state;
>> +}
>
> Hmm, why don't we return mm_struct *prev directly?

I did it this way to make it easier to add future debugging stuff
later.  Also, when I first wrote this, I stashed the old CR3 instead
of the old mm_struct, and it seemed like callers should be insulated
from details like this.
