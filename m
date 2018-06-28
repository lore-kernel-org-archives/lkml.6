Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04E4C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527F62794F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527F62794F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754609AbeF1UmP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:42:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52521 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754313AbeF1UmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:42:13 -0400
Received: from wld62.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w5SKdqXh2677659
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 28 Jun 2018 13:39:53 -0700
Date:   Thu, 28 Jun 2018 13:39:45 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CALCETrWkHsptX=z8bPGwYEVwqG8Hz2=ybkym=-EBq1qeC2ycZw@mail.gmail.com>
References: <20180621211754.12757-1-h.peter.anvin@intel.com> <20180621211754.12757-2-h.peter.anvin@intel.com> <CALCETrWerhEUMw+JS4p5MVEopiMnUjbUtX58Ci7UYfYT=Y5Cvw@mail.gmail.com> <408ed97a-c64d-c523-c403-4e066d1f34c3@intel.com> <FB113DE3-5841-49B2-A11E-CE785EF0C763@amacapital.net> <CALCETrX30hRA_8OJ4uv4GQDf_Tu+DNRhgbo5XF60kTyH9+4G=Q@mail.gmail.com> <27F6CB18-8E20-487B-B55B-1DAEF9DF9E2C@zytor.com> <CALCETrWkHsptX=z8bPGwYEVwqG8Hz2=ybkym=-EBq1qeC2ycZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3 1/7] x86/ldt: refresh %fs and %gs in refresh_ldt_segments()
To:     Andy Lutomirski <luto@kernel.org>
CC:     "H. Peter Anvin" <h.peter.anvin@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>
From:   hpa@zytor.com
Message-ID: <7017735A-6579-42B0-B0DF-F43D0C32D055@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 28, 2018 1:33:24 PM PDT, Andy Lutomirski <luto@kernel.org> wrote:
>On Wed, Jun 27, 2018 at 11:22 AM,  <hpa@zytor.com> wrote:
>> On June 27, 2018 11:19:12 AM PDT, Andy Lutomirski <luto@kernel.org>
>wrote:
>>>On Fri, Jun 22, 2018 at 11:47 AM, Andy Lutomirski
><luto@amacapital.net>
>>>wrote:
>>>>
>>>>
>>>>
>>>>> On Jun 22, 2018, at 11:29 AM, H. Peter Anvin
>>><h.peter.anvin@intel.com> wrote:
>>>>>
>>>>>> On 06/22/18 07:24, Andy Lutomirski wrote:
>>>>>>
>>>>>> That RPL3 part is false.  The following program does:
>>>>>>
>>>>>> #include <stdio.h>
>>>>>>
>>>>>> int main()
>>>>>> {
>>>>>>    unsigned short sel;
>>>>>>    asm volatile ("mov %%ss, %0" : "=rm" (sel));
>>>>>>    sel &= ~3;
>>>>>>    printf("Will write 0x%hx to GS\n", sel);
>>>>>>    asm volatile ("mov %0, %%gs" :: "rm" (sel & ~3));
>>>>>>    asm volatile ("mov %%gs, %0" : "=rm" (sel));
>>>>>>    printf("GS = 0x%hx\n", sel);
>>>>>>    return 0;
>>>>>> }
>>>>>>
>>>>>> prints:
>>>>>>
>>>>>> Will write 0x28 to GS
>>>>>> GS = 0x28
>>>>>>
>>>>>> The x86 architecture is *insane*.
>>>>>>
>>>>>> Other than that, this patch seems generally sensible.  But my
>>>>>> objection that it's incorrect with FSGSBASE enabled for %fs and
>%gs
>>>>>> still applies.
>>>>>>
>>>>>
>>>>> Ugh, you're right... I misremembered.  The CPL simply overrides
>the
>>>RPL
>>>>> rather than trapping.
>>>>>
>>>>> We still need to give legacy applications which have zero idea
>about
>>>the
>>>>> separate bases that apply only to 64-bit mode a way to DTRT.
>>>Requiring
>>>>> these old crufty applications to do something new is not an
>option.
>>>>
>>>>>
>>>>> As ugly as it is, I'm thinking the Right Thing is to simply make
>it
>>>a
>>>>> part of the Linux ABI that if the FS or GS selector registers
>point
>>>into
>>>>> the LDT then we will requalify them; if a 64-bit app does that
>then
>>>they
>>>>> get that behavior.  This isn't something that will happen
>>>>> asynchronously, and if a 64-bit process loads an LDT value into FS
>>>or
>>>>> GS, they are considered to have opted in to that behavior.
>>>>
>>>> But the old and crusty apps don’t depend on requalification because
>>>we never used to do it.
>>>>
>>>> I’m not convinced we ever need to refresh the base. In fact, we
>could
>>>start preserving the base of LDT-referencing FS/GS across context
>>>switches even without FSGSBASE at some minor performance cost, but I
>>>don’t really see the point. I still think my proposed semantics are
>>>easy to implement and preserve the ABI even if they have the sad
>>>property that the FSGSBASE behavior and the non-FSGSBASE behavior end
>>>up different.
>>>>
>>>
>>>There's another reasonable solution: do exactly what your patch does,
>>>minus the bugs.  We would need to get the RPL != 3 case right (easy)
>>>and the case where there's a non-running thread using the selector in
>>>question.  The latter is probably best handled by adding a flag to
>>>thread_struct that says "fsbase needs reloading from the descriptor
>>>table" and only applies if the selector is in the LDT or TLS area. 
>Or
>>>we could hijack a high bit in the selector.  Then we'd need to update
>>>everything that uses the fields.
>>
>> Obviously fix the bugs.
>>
>> How would you control this bit?
>
>Sorry, I was wrong in my previous email.  Let me try this again:
>
>Notwithstanding the RPL thing, the reason I don't like your patch as
>is, and the reason I didn't write a similar patch myself, is that it
>will behave nondeterministically on an FSGSBASE kernel.  Suppose there
>are two threads, A and B, that share an mm.  A has %fs == 0x7 and
>FSBASE = 0.  The LDT has the base for entry 0 set to 0.
>
>Now thread B calls modify_ldt to change the base for entry 0 to 1.
>
>The Obviously Sane (tm) behavior is for task A's FSBASE to
>asynchronously change to 1.  This is the only deterministic behavior
>that is even possible on a 32-bit kernel, and it's the only
>not-totally-nutty behavior that is possible on a 64-bit non-FSGSBASE
>kernel, and it's still perfectly reasonable for FSGSBASE.  The problem
>is that it's not so easly to implement.
>
>With your patch, on an FSGSBASE kernel, we get the desired behavior if
>thread A is running while thread B calls modify_ldt().  But we get
>different behavior if thread A is stopped -- thread A's FSBASE will
>remain set to 0.
>
>With that in mind, my email was otherwise garbage, and the magic "bit"
>idea was total crap.
>
>I can see three vaguely credible ways to implement this.
>
>1. thread B walks all threads on the system, notices that thread A has
>the same mm, and asynchronously fixes it up.  The locking is a bit
>tricky, and the performance isn't exactly great.  Maybe that's okay.
>
>2. We finally add an efficient way to find all threads that share an
>mm and do (1) but faster.
>
>3. We add enough bookkeeping to thread_struct so that, the next time
>thread A runs or has ptrace try to read its FSBASE, we notice that
>FSBASE is stale and fix it up.
>
>(3) will perform the best, but the implementation is probably nasty.
>If we want modify_ldt() to only reset the base for the modified
>records, we probably need a version number for each of the 8192
>possible LDT entries stored in ldt_struct (which will double its size,
>but so what?).  Then we need thread_struct to store the version number
>of the LDT entries that fsindex and gsindex refer to.  Now we make
>sure that every code path that reads fsbase or gsbase first calls some
>revalidate_fs_and_gs() function that will reset the bases and maybe
>even the selectors if needed.  Getting the locking right on that last
>bit is possibly a bit tricky, since we may need the LDT lock to be
>held across the revalidation *and* whatever subsequent code actually
>reads the values.
>
>I think that (3) is the nicest solution, but it would need to be
>implemeted.
>
>What do you think?

Ok, now I grok what you're getting at, and I do agree with your problem statement. I think I can figure this out.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
