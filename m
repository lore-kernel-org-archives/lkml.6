Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DBCC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF7C21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF7C21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeJDQKE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:10:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54973 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbeJDQKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:10:03 -0400
Received: from wld62.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w949HVsR2688988
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 4 Oct 2018 02:17:31 -0700
Date:   Thu, 04 Oct 2018 02:17:24 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20181004091222.GB21864@gmail.com>
References: <20181003213100.189959-1-namit@vmware.com> <20181003213100.189959-5-namit@vmware.com> <20181004075755.GA3353@gmail.com> <20181004083333.GA9802@gmail.com> <10D29A50-C352-4407-A824-0C3C06CD8592@zytor.com> <A5DED74C-A95A-48D8-AF68-39E23696385F@vmware.com> <20181004091222.GB21864@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
To:     Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>
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
Message-ID: <3F2AE080-9F76-441D-A8FA-7AB7B8DF46BD@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 4, 2018 2:12:22 AM PDT, Ingo Molnar <mingo@kernel.org> wrote:
>
>* Nadav Amit <namit@vmware.com> wrote:
>
>> I can run some tests. (@hpa: I thought you asked about the -pipe
>overhead;
>> perhaps I misunderstood).
>
>Well, tests are unlikely to show the overhead of extra lines of this
>magnitude, unless done very carefully, yet the added bloat exists and
>is not even
>mentioned by the changelog, it just says:
>
>Subject: [PATCH v9 02/10] Makefile: Prepare for using macros for inline
>asm
>
>  Using macros for inline assembly improves both readability and
>compilation decisions that are distorted by big assembly blocks that
>use
>  alternative sections. Compile macros.S and use it to assemble all C
>  files. Currently, only x86 will use it.
>
>> I guess you regard to the preprocessing of the assembler. Note that
>the C 
>> preprocessing of macros.S obviously happens only once. That’s the
>reason
>> I assumed it’s not that expensive.
>
>True - so first we build macros.s, and that gets included in every C
>file build, right?
>
>macros.s is smaller: 275 lines only in the distro test build I tried,
>which looks
>a lot better than my first 4,200 lines guesstimate.
>
>> Anyhow, I remember that we discussed at some point doing something
>like
>> ‘asm(“.include XXX.s”)’ and somebody said it is not good, but I don’t
>> remember why and don’t see any reason it is so. Unless I am missing
>> something, I think it is possible to take each individual header and
>> preprocess the assembly part of into a separate .s file. Then we can
>put in
>> the C part of the header ‘asm(".include XXX.s”)’.
>> 
>> What do you think?
>
>Hm, this looks quite complex - macros.s is better I think. Also, 275
>straight assembly lines is 
>a lot better than 4,200.
>
>Another, separate question I wanted to ask: how do we ensure that the
>kernel stays fixed?
>I.e. is there some tooling we can use to actually measure whether
>there's bad inlining decisions 
>done, to detect all these bad patterns that cause bad GCC code
>generation?
>
>Thanks,
>
>	Ingo

The assembly output from GCC is quite volumious; I doubt tacking a few hundred lines on will matter one iota.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
