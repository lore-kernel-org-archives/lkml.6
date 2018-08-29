Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B637C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56BC2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKV2Ca0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56BC2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeH3Bh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:37:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbeH3Bh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:37:26 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7548820671
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 21:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535578715;
        bh=GyVgBkcH/Ta86DhFyy7PBW/NRSBEkJqLHpn49jacN+4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=vKV2Ca0gA0ciKor0OKx0j4vqOdrbVTn8+8uzMVE5tau3MJ3sKfjZBY6637lCRcajm
         brwdFigrLfWxYEE5eoh3EHq+4oubU/eneqEZJj+VvaWFbLxoWIGMd8bgbQT8adTsOb
         VU/PNpIqWiy6aRTV3tGccq0sRJO9gU9QyImELIaA=
Received: by mail-wr1-f44.google.com with SMTP id n2-v6so6141612wrw.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 14:38:35 -0700 (PDT)
X-Gm-Message-State: APzg51A0efel/ihFkgF9CfnK58q5AzLj7pS+4csg5VVSljnbSrUv5WsR
        KWo2yPGIO4RKYlEd18HwLzeqpUkZnYZb399/xxw5JA==
X-Google-Smtp-Source: ANB0VdZars6Fr6m2Atl8eGMUyPuM55CqNL74sFVHdKgmKtHOqh5B9oLOyzWVCJf7xn9sZHj7bzI5vxeV1ERHxBIqoT4=
X-Received: by 2002:adf:f112:: with SMTP id r18-v6mr5475864wro.29.1535578713916;
 Wed, 29 Aug 2018 14:38:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Wed, 29 Aug 2018 14:38:13 -0700 (PDT)
In-Reply-To: <A7F037E7-6FA1-418D-A8D9-E8752663EF86@vmware.com>
References: <20180829081147.184610-1-namit@vmware.com> <20180829081147.184610-3-namit@vmware.com>
 <20180829184925.64caee4dadf705080373f84f@kernel.org> <CALCETrWF5XQndPikmBgo9t1UWKS7T0K2kFGOpzX-tavFVis5_Q@mail.gmail.com>
 <A7F037E7-6FA1-418D-A8D9-E8752663EF86@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 29 Aug 2018 14:38:13 -0700
X-Gmail-Original-Message-ID: <CALCETrW3WnhRQ+R9-TEwaKZbupq_WoazT+7UqbLD=zmWML7MNQ@mail.gmail.com>
Message-ID: <CALCETrW3WnhRQ+R9-TEwaKZbupq_WoazT+7UqbLD=zmWML7MNQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] x86/mm: temporary mm struct
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 9:54 AM, Nadav Amit <namit@vmware.com> wrote:
> at 8:41 AM, Andy Lutomirski <luto@kernel.org> wrote:
>
>> On Wed, Aug 29, 2018 at 2:49 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>> On Wed, 29 Aug 2018 01:11:43 -0700
>>> Nadav Amit <namit@vmware.com> wrote:
>>>
>>>> From: Andy Lutomirski <luto@kernel.org>
>>>>
>>>> Sometimes we want to set a temporary page-table entries (PTEs) in one of
>>>> the cores, without allowing other cores to use - even speculatively -
>>>> these mappings. There are two benefits for doing so:
>>>>
>>>> (1) Security: if sensitive PTEs are set, temporary mm prevents their use
>>>> in other cores. This hardens the security as it prevents exploding a
>>>> dangling pointer to overwrite sensitive data using the sensitive PTE.
>>>>
>>>> (2) Avoiding TLB shootdowns: the PTEs do not need to be flushed in
>>>> remote page-tables.
>>>>
>>>> To do so a temporary mm_struct can be used. Mappings which are private
>>>> for this mm can be set in the userspace part of the address-space.
>>>> During the whole time in which the temporary mm is loaded, interrupts
>>>> must be disabled.
>>>>
>>>> The first use-case for temporary PTEs, which will follow, is for poking
>>>> the kernel text.
>>>>
>>>> [ Commit message was written by Nadav ]
>>>>
>>>> Cc: Andy Lutomirski <luto@kernel.org>
>>>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>>>> Cc: Kees Cook <keescook@chromium.org>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Signed-off-by: Nadav Amit <namit@vmware.com>
>>>> ---
>>>> arch/x86/include/asm/mmu_context.h | 20 ++++++++++++++++++++
>>>> 1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
>>>> index eeeb9289c764..96afc8c0cf15 100644
>>>> --- a/arch/x86/include/asm/mmu_context.h
>>>> +++ b/arch/x86/include/asm/mmu_context.h
>>>> @@ -338,4 +338,24 @@ static inline unsigned long __get_current_cr3_fast(void)
>>>>      return cr3;
>>>> }
>>>>
>>>> +typedef struct {
>>>> +     struct mm_struct *prev;
>>>> +} temporary_mm_state_t;
>>>> +
>>>> +static inline temporary_mm_state_t use_temporary_mm(struct mm_struct *mm)
>>>> +{
>>>> +     temporary_mm_state_t state;
>>>> +
>>>> +     lockdep_assert_irqs_disabled();
>>>> +     state.prev = this_cpu_read(cpu_tlbstate.loaded_mm);
>>>> +     switch_mm_irqs_off(NULL, mm, current);
>>>> +     return state;
>>>> +}
>>>
>>> Hmm, why don't we return mm_struct *prev directly?
>>
>> I did it this way to make it easier to add future debugging stuff
>> later.  Also, when I first wrote this, I stashed the old CR3 instead
>> of the old mm_struct, and it seemed like callers should be insulated
>> from details like this.
>
> Andy, please let me know if you want me to change it somehow, and please
> provide your signed-off-by.
>

I'm happy with it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
