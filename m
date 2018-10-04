Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5F3C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976C521473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976C521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeJDPcq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:32:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54133 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbeJDPcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:32:46 -0400
Received: from wld62.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w948eQ8f2678722
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 4 Oct 2018 01:40:27 -0700
Date:   Thu, 04 Oct 2018 01:40:20 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20181004083333.GA9802@gmail.com>
References: <20181003213100.189959-1-namit@vmware.com> <20181003213100.189959-5-namit@vmware.com> <20181004075755.GA3353@gmail.com> <20181004083333.GA9802@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
To:     Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>
CC:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>
From:   hpa@zytor.com
Message-ID: <10D29A50-C352-4407-A824-0C3C06CD8592@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 4, 2018 1:33:33 AM PDT, Ingo Molnar <mingo@kernel.org> wrote:
>
>* Ingo Molnar <mingo@kernel.org> wrote:
>
>> I'm also somewhat annoyed at the fact that this series carries a
>boatload
>> of reviewed-by's and acked-by's, yet none of those reviewers found it
>> important to point out the large chasm that is gaping between
>description
>> and reality.
>
>Another problem I just realized is that we now include
>arch/x86/kernel/macros.S in every 
>translation pass when building the kernel, right?
>
>But arch/x86/kernel/macros.S expands to a pretty large hiearchy of
>header files:
>
>  $ make arch/x86/kernel/macros.s
>
>$ cat $(grep include arch/x86/kernel/macros.s | cut -d\" -f2 | sort |
>uniq) | wc -l
>  4128
>
>That's 4,100 extra lines of code to be preprocessed for every
>translation unit, of
>which there are tens of thousands. More if other pieces of code get
>macrofied in
>this fasion in the future.
>
>If we assume that a typical distribution kernel build has ~20,000
>translation units
>then this change adds 82,560,000 more lines to be preprocessed, just to
>work around
>a stupid GCC bug?
>
>I'm totally unhappy about that. Can we do this without adding macros.S?
>
>It's also a pretty stupidly central file anyway that moves source code
>away
>from where it's used.
>
>Thanks,
>
>	Ingo

It's not just for working around a stupid GCC bug, but it also has a huge potential for cleaning up the inline asm in general.

I would like to know if there is an actual number for the build overhead (an actual benchmark); I have asked for that once already.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
