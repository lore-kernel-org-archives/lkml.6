Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CB5C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E491A20868
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfAQWco convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:32:44 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45339 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfAQWcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:32:43 -0500
Received: from wld62.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x0HMW1mP924604
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 17 Jan 2019 14:32:01 -0800
Date:   Thu, 17 Jan 2019 14:31:53 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <B8C39C5A-A669-4F80-9BAE-7C11A4379ECF@gmail.com>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com> <20190117003259.23141-7-rick.p.edgecombe@intel.com> <CALCETrUMAsXoZogEJg7ssv0CO56vzBV2C7VotmWcwNM7iH9Wqw@mail.gmail.com> <CALCETrXQ6uxzB3JvO14sEyMA21RcWCbwicL4nUdPBG8KAunxwg@mail.gmail.com> <B8C39C5A-A669-4F80-9BAE-7C11A4379ECF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 06/17] x86/alternative: use temporary mm for text poking
To:     Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
CC:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
From:   hpa@zytor.com
Message-ID: <7E4A4400-0A2E-4393-B22C-DBD708610BB5@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 17, 2019 1:43:54 PM PST, Nadav Amit <nadav.amit@gmail.com> wrote:
>> On Jan 17, 2019, at 12:47 PM, Andy Lutomirski <luto@kernel.org>
>wrote:
>> 
>> On Thu, Jan 17, 2019 at 12:27 PM Andy Lutomirski <luto@kernel.org>
>wrote:
>>> On Wed, Jan 16, 2019 at 4:33 PM Rick Edgecombe
>>> <rick.p.edgecombe@intel.com> wrote:
>>>> From: Nadav Amit <namit@vmware.com>
>>>> 
>>>> text_poke() can potentially compromise the security as it sets
>temporary
>>>> PTEs in the fixmap. These PTEs might be used to rewrite the kernel
>code
>>>> from other cores accidentally or maliciously, if an attacker gains
>the
>>>> ability to write onto kernel memory.
>>> 
>>> i think this may be sufficient, but barely.
>>> 
>>>> +       pte_clear(poking_mm, poking_addr, ptep);
>>>> +
>>>> +       /*
>>>> +        * __flush_tlb_one_user() performs a redundant TLB flush
>when PTI is on,
>>>> +        * as it also flushes the corresponding "user" address
>spaces, which
>>>> +        * does not exist.
>>>> +        *
>>>> +        * Poking, however, is already very inefficient since it
>does not try to
>>>> +        * batch updates, so we ignore this problem for the time
>being.
>>>> +        *
>>>> +        * Since the PTEs do not exist in other kernel
>address-spaces, we do
>>>> +        * not use __flush_tlb_one_kernel(), which when PTI is on
>would cause
>>>> +        * more unwarranted TLB flushes.
>>>> +        *
>>>> +        * There is a slight anomaly here: the PTE is a
>supervisor-only and
>>>> +        * (potentially) global and we use __flush_tlb_one_user()
>but this
>>>> +        * should be fine.
>>>> +        */
>>>> +       __flush_tlb_one_user(poking_addr);
>>>> +       if (cross_page_boundary) {
>>>> +               pte_clear(poking_mm, poking_addr + PAGE_SIZE, ptep
>+ 1);
>>>> +               __flush_tlb_one_user(poking_addr + PAGE_SIZE);
>>>> +       }
>>> 
>>> In principle, another CPU could still have the old translation. 
>Your
>>> mutex probably makes this impossible, but it makes me nervous.
>>> Ideally you'd use flush_tlb_mm_range(), but I guess you can't do
>that
>>> with IRQs off.  Hmm.  I think you should add an inc_mm_tlb_gen()
>here.
>>> Arguably, if you did that, you could omit the flushes, but maybe
>>> that's silly.
>>> 
>>> If we start getting new users of use_temporary_mm(), we should give
>>> some serious thought to the SMP semantics.
>>> 
>>> Also, you're using PAGE_KERNEL.  Please tell me that the global bit
>>> isn't set in there.
>> 
>> Much better solution: do unuse_temporary_mm() and *then*
>> flush_tlb_mm_range().  This is entirely non-sketchy and should be
>just
>> about optimal, too.
>
>This solution sounds nice and clean. The fact the global-bit was set
>didn’t
>matter before (since __flush_tlb_one_user would get rid of it no matter
>what), but would matter now, so I’ll change it too.
>
>Thanks!
>
>Nadav

You can just disable the global bit at the top level, obviously.

This approach also should make it far easier to do batching if desired.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
