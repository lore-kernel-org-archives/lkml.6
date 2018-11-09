Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E38FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EDC20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h6PkiK7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EDC20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbeKJAzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:55:46 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36543 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbeKJAzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:55:46 -0500
Received: by mail-it1-f193.google.com with SMTP id w7-v6so3715941itd.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 07:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QmEOCZhKoy4tMYvrz4DsulhuUxwi7kZKfWHrSbAKPsY=;
        b=h6PkiK7uJATjFMAioiq1SOdVFad8kUSj7BiEsR5IOgT/GlVzhm7NbSlFLNBmePuckV
         R5Iq7/W+UPfV6M0RKNpSHQdg+nh6Y8QaYu7e0G+mSRPYJQGTSKFvnxarwb2bnEZvuxpC
         XcTdtdgq476dsCYw2fYLwV3BIc3TR2nAjoJSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QmEOCZhKoy4tMYvrz4DsulhuUxwi7kZKfWHrSbAKPsY=;
        b=ZVelGXAwO6aiIktaSF3LpTd7X3rICog1Fr+15FM1MCkGno90mFmIqACpZ05KH49pXE
         DbCnI+D0hRvebEQ92K5HZ839QSk0RXbRomN3IlyQirryFHEi2Z76OthO7f1Qrq4MMIb+
         Dd5Wf/uEdzUA9NmxEmRfQEtL7kudgYLTrn6XTgSpRw2Puk7oGZeL86HBQx8Zk9wNl90Q
         Pqmn/mg543IQx84IVL3SOU9ZA+N7p6YA2Ymj/guwA2XWl1U0+AY1X9miavYpCe5Cf6SA
         am2CstC137adPd8G8k6TOPwLOfrnwicm1r6sAa9C+jkpN16o39COIvRAwdNaECaYfE2+
         jujQ==
X-Gm-Message-State: AGRZ1gKq41+6cTWjm84D+qGEp5X7ALBA7FrWH+Es9pV881JDEO/smWqW
        b0qRxXVK6YCFoFrsqDWOHCsY84diNiPAhrn6dQ5NOg==
X-Google-Smtp-Source: AJdET5fpylLbcAtUxE/QkoKHwnJLz4SyodegVxyf8NX/2XD/jMGs5NCb2tdExYqerNwrZN1HfJHs/pRDZdF2z7C0wYU=
X-Received: by 2002:a02:8449:: with SMTP id l9-v6mr8480077jah.130.1541776486303;
 Fri, 09 Nov 2018 07:14:46 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Fri, 9 Nov 2018 07:14:45 -0800 (PST)
In-Reply-To: <20181109151028.faifw66enzye32gg@treble>
References: <cover.1541711457.git.jpoimboe@redhat.com> <3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com>
 <CAKv+Gu9bMkFEx_GxH3uLm0gveQurp7ELDi6C5NvpugufPFMbRA@mail.gmail.com> <20181109151028.faifw66enzye32gg@treble>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 9 Nov 2018 16:14:45 +0100
Message-ID: <CAKv+Gu_J1b30+pMNRF0icEpyew4TM_VP3ShG=4HkLnk=fRL9zg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] static_call: Add static call infrastructure
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 November 2018 at 16:10, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Fri, Nov 09, 2018 at 02:39:17PM +0100, Ard Biesheuvel wrote:
>> > +       for (site = start; site < stop; site++) {
>> > +               struct static_call_key *key = static_call_key(site);
>> > +               unsigned long addr = static_call_addr(site);
>> > +
>> > +               if (list_empty(&key->site_mods)) {
>> > +                       struct static_call_mod *mod;
>> > +
>> > +                       mod = kzalloc(sizeof(*mod), GFP_KERNEL);
>> > +                       if (!mod) {
>> > +                               WARN(1, "Failed to allocate memory for static calls");
>> > +                               return;
>> > +                       }
>> > +
>> > +                       mod->sites = site;
>> > +                       list_add_tail(&mod->list, &key->site_mods);
>> > +
>> > +                       /*
>> > +                        * The trampoline should no longer be used.  Poison it
>> > +                        * it with a BUG() to catch any stray callers.
>> > +                        */
>> > +                       arch_static_call_poison_tramp(addr);
>>
>> This patches the wrong thing: the trampoline is at key->func not addr.
>
> If you look at the x86 implementation, it actually does poison the
> trampoline.
>
> The address of the trampoline isn't actually known here.  key->func
> isn't the trampoline address; it's the destination func address.
>
> So instead I passed the address of the call instruction.  The arch code
> then reads the instruction to find the callee (the trampoline).
>
> The code is a bit confusing.  To make it more obvious, maybe we should
> add another arch function to read the call destination.  Then this code
> can pass that into arch_static_call_poison_tramp().
>

Ah right, so I am basically missing a dereference in my
arch_static_call_poison_tramp() code if this breaks.

>> However, patching it here means we poison it before all users are
>> patched. I added this on top
>>
>> diff --git a/kernel/static_call.c b/kernel/static_call.c
>> index 599ebc6fc4f1..d9562329bec6 100644
>> --- a/kernel/static_call.c
>> +++ b/kernel/static_call.c
>> @@ -248,6 +248,7 @@ static void __init static_call_init(void)
>>         struct static_call_site *start = __start_static_call_sites;
>>         struct static_call_site *stop  = __stop_static_call_sites;
>>         struct static_call_site *site;
>> +       struct static_call_key *prev_key = NULL;
>>
>>         if (start == stop) {
>>                 pr_warn("WARNING: empty static call table\n");
>> @@ -279,7 +280,9 @@ static void __init static_call_init(void)
>>                          * The trampoline should no longer be used.  Poison it
>>                          * it with a BUG() to catch any stray callers.
>>                          */
>> -                       arch_static_call_poison_tramp(addr);
>> +                       if (prev_key)
>> +
>> arch_static_call_poison_tramp((unsigned long)prev_key->func);
>> +                       prev_key = key;
>>                 }
>>
>>                 arch_static_call_transform(addr, key->func);
>
> While it does indeed poison the trampoline before all users are patched,
> I had been thinking that it didn't really matter because this is before
> the other CPUs have been booted.
>
> But I believe interrupts are enabled at this point during the boot, so
> it would indeed be wise to poison it afterwards, in case an irq handler
> makes a static call.
>

And kmalloc(GFP_KERNEL) itself could cascade into lots of other code as well.
