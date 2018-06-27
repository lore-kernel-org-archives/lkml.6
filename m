Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9014CC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5304125A57
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5304125A57
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965837AbeF0SXG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 14:23:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41601 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752686AbeF0SXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 14:23:05 -0400
Received: from [IPv6:2607:fb90:a499:54e8:9c2f:b614:be0b:6380] ([172.58.33.215])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w5RIMMV22169628
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 27 Jun 2018 11:22:58 -0700
Date:   Wed, 27 Jun 2018 11:22:14 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CALCETrX30hRA_8OJ4uv4GQDf_Tu+DNRhgbo5XF60kTyH9+4G=Q@mail.gmail.com>
References: <20180621211754.12757-1-h.peter.anvin@intel.com> <20180621211754.12757-2-h.peter.anvin@intel.com> <CALCETrWerhEUMw+JS4p5MVEopiMnUjbUtX58Ci7UYfYT=Y5Cvw@mail.gmail.com> <408ed97a-c64d-c523-c403-4e066d1f34c3@intel.com> <FB113DE3-5841-49B2-A11E-CE785EF0C763@amacapital.net> <CALCETrX30hRA_8OJ4uv4GQDf_Tu+DNRhgbo5XF60kTyH9+4G=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3 1/7] x86/ldt: refresh %fs and %gs in refresh_ldt_segments()
To:     Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <h.peter.anvin@intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>
From:   hpa@zytor.com
Message-ID: <27F6CB18-8E20-487B-B55B-1DAEF9DF9E2C@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 27, 2018 11:19:12 AM PDT, Andy Lutomirski <luto@kernel.org> wrote:
>On Fri, Jun 22, 2018 at 11:47 AM, Andy Lutomirski <luto@amacapital.net>
>wrote:
>>
>>
>>
>>> On Jun 22, 2018, at 11:29 AM, H. Peter Anvin
><h.peter.anvin@intel.com> wrote:
>>>
>>>> On 06/22/18 07:24, Andy Lutomirski wrote:
>>>>
>>>> That RPL3 part is false.  The following program does:
>>>>
>>>> #include <stdio.h>
>>>>
>>>> int main()
>>>> {
>>>>    unsigned short sel;
>>>>    asm volatile ("mov %%ss, %0" : "=rm" (sel));
>>>>    sel &= ~3;
>>>>    printf("Will write 0x%hx to GS\n", sel);
>>>>    asm volatile ("mov %0, %%gs" :: "rm" (sel & ~3));
>>>>    asm volatile ("mov %%gs, %0" : "=rm" (sel));
>>>>    printf("GS = 0x%hx\n", sel);
>>>>    return 0;
>>>> }
>>>>
>>>> prints:
>>>>
>>>> Will write 0x28 to GS
>>>> GS = 0x28
>>>>
>>>> The x86 architecture is *insane*.
>>>>
>>>> Other than that, this patch seems generally sensible.  But my
>>>> objection that it's incorrect with FSGSBASE enabled for %fs and %gs
>>>> still applies.
>>>>
>>>
>>> Ugh, you're right... I misremembered.  The CPL simply overrides the
>RPL
>>> rather than trapping.
>>>
>>> We still need to give legacy applications which have zero idea about
>the
>>> separate bases that apply only to 64-bit mode a way to DTRT. 
>Requiring
>>> these old crufty applications to do something new is not an option.
>>
>>>
>>> As ugly as it is, I'm thinking the Right Thing is to simply make it
>a
>>> part of the Linux ABI that if the FS or GS selector registers point
>into
>>> the LDT then we will requalify them; if a 64-bit app does that then
>they
>>> get that behavior.  This isn't something that will happen
>>> asynchronously, and if a 64-bit process loads an LDT value into FS
>or
>>> GS, they are considered to have opted in to that behavior.
>>
>> But the old and crusty apps don’t depend on requalification because
>we never used to do it.
>>
>> I’m not convinced we ever need to refresh the base. In fact, we could
>start preserving the base of LDT-referencing FS/GS across context
>switches even without FSGSBASE at some minor performance cost, but I
>don’t really see the point. I still think my proposed semantics are
>easy to implement and preserve the ABI even if they have the sad
>property that the FSGSBASE behavior and the non-FSGSBASE behavior end
>up different.
>>
>
>There's another reasonable solution: do exactly what your patch does,
>minus the bugs.  We would need to get the RPL != 3 case right (easy)
>and the case where there's a non-running thread using the selector in
>question.  The latter is probably best handled by adding a flag to
>thread_struct that says "fsbase needs reloading from the descriptor
>table" and only applies if the selector is in the LDT or TLS area.  Or
>we could hijack a high bit in the selector.  Then we'd need to update
>everything that uses the fields.

Obviously fix the bugs.

How would you control this bit?
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
