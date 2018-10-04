Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8352DC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4644D2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4644D2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbeJDPz0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:55:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47819 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbeJDPz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:55:26 -0400
Received: from wld62.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w9492vxA2684371
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 4 Oct 2018 02:02:58 -0700
Date:   Thu, 04 Oct 2018 02:02:51 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <A5DED74C-A95A-48D8-AF68-39E23696385F@vmware.com>
References: <20181003213100.189959-1-namit@vmware.com> <20181003213100.189959-5-namit@vmware.com> <20181004075755.GA3353@gmail.com> <20181004083333.GA9802@gmail.com> <10D29A50-C352-4407-A824-0C3C06CD8592@zytor.com> <A5DED74C-A95A-48D8-AF68-39E23696385F@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
To:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>
From:   hpa@zytor.com
Message-ID: <36D6F606-6922-4057-B1F8-2B30993962AE@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 4, 2018 1:56:37 AM PDT, Nadav Amit <namit@vmware.com> wrote:
>at 1:40 AM, hpa@zytor.com wrote:
>
>> On October 4, 2018 1:33:33 AM PDT, Ingo Molnar <mingo@kernel.org>
>wrote:
>>> * Ingo Molnar <mingo@kernel.org> wrote:
>>> 
>>>> I'm also somewhat annoyed at the fact that this series carries a
>>> boatload
>>>> of reviewed-by's and acked-by's, yet none of those reviewers found
>it
>>>> important to point out the large chasm that is gaping between
>>> description
>>>> and reality.
>>> 
>>> Another problem I just realized is that we now include
>>> arch/x86/kernel/macros.S in every 
>>> translation pass when building the kernel, right?
>>> 
>>> But arch/x86/kernel/macros.S expands to a pretty large hiearchy of
>>> header files:
>>> 
>>> $ make arch/x86/kernel/macros.s
>>> 
>>> $ cat $(grep include arch/x86/kernel/macros.s | cut -d\" -f2 | sort
>|
>>> uniq) | wc -l
>>> 4128
>>> 
>>> That's 4,100 extra lines of code to be preprocessed for every
>>> translation unit, of
>>> which there are tens of thousands. More if other pieces of code get
>>> macrofied in
>>> this fasion in the future.
>>> 
>>> If we assume that a typical distribution kernel build has ~20,000
>>> translation units
>>> then this change adds 82,560,000 more lines to be preprocessed, just
>to
>>> work around
>>> a stupid GCC bug?
>>> 
>>> I'm totally unhappy about that. Can we do this without adding
>macros.S?
>>> 
>>> It's also a pretty stupidly central file anyway that moves source
>code
>>> away
>>> from where it's used.
>>> 
>>> Thanks,
>>> 
>>> 	Ingo
>> 
>> It's not just for working around a stupid GCC bug, but it also has a
>huge
>> potential for cleaning up the inline asm in general.
>> 
>> I would like to know if there is an actual number for the build
>overhead
>> (an actual benchmark); I have asked for that once already.
>
>I can run some tests. (@hpa: I thought you asked about the -pipe
>overhead;
>perhaps I misunderstood).
>
>I guess you regard to the preprocessing of the assembler. Note that the
>C 
>preprocessing of macros.S obviously happens only once. That’s the
>reason
>I assumed it’s not that expensive.
>
>Anyhow, I remember that we discussed at some point doing something like
>‘asm(“.include XXX.s”)’ and somebody said it is not good, but I don’t
>remember why and don’t see any reason it is so. Unless I am missing
>something, I think it is possible to take each individual header and
>preprocess the assembly part of into a separate .s file. Then we can
>put in
>the C part of the header ‘asm(".include XXX.s”)’.
>
>What do you think?

Ingo: I wasn't talking necessarily about the specifics of each bit, but rather the general concept about being able to use macros in inlines... I can send you something I have been working on in the background, but have been holding off on because of this, in the morning my time.

But that's no excuse for not doing it right.

Global asm() statements are problematic because there is no guarantee where in the assembly source they will end up. You'd almost need to intercept the assembly output, move all the includes to the top, and then process...
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
