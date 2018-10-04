Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BE7C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 23:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE352147D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 23:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE352147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeJEGHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 02:07:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58473 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbeJEGHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 02:07:41 -0400
Received: from hanvin-mobl2.amr.corp.intel.com (jfdmzpr05-ext.jf.intel.com [134.134.139.74])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w94NBkai2918104
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 4 Oct 2018 16:11:47 -0700
Subject: Re: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-5-namit@vmware.com> <20181004075755.GA3353@gmail.com>
 <20181004083333.GA9802@gmail.com>
 <10D29A50-C352-4407-A824-0C3C06CD8592@zytor.com>
 <A5DED74C-A95A-48D8-AF68-39E23696385F@vmware.com>
 <36D6F606-6922-4057-B1F8-2B30993962AE@zytor.com>
 <20181004091651.GB21151@gmail.com>
 <df1bddc1-e71b-dbd8-a24f-01a46d462a79@zytor.com>
 <CALCETrUm255shi0ba8j+ZJhkxv9HdDJ9A70U1T28bEHEMQi+8Q@mail.gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <e21dbc13-40e5-61e0-4aa1-5bfe47fa6415@zytor.com>
Date:   Thu, 4 Oct 2018 16:11:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CALCETrUm255shi0ba8j+ZJhkxv9HdDJ9A70U1T28bEHEMQi+8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/18 13:29, Andy Lutomirski wrote:
>>
>> Wonderful.
>>
>> Here is the horrible code I mentioned yesterday.  This is about
>> implementing the immediate-patching framework that Linus and others have
>> discussed (it helps both performance and kernel hardening):
>>
> 
> I'm wondering if a production version should look more like:
> 
> patch_point:
> mov $whatever, [target]
> .pushsection ".immediate_patches"
> .quad .Lpatch_point
> .popsection
> 
> and let objtool parse the resulting assembled output and emit an entry
> in some table mapping patch_point to the actual address and size of
> the immediate to be patched.
> 

Putting the generation of the ersatz code in objtool is an interesting
idea, although I'm wondering if these macros, as awful as they are,
wouldn't have generic applicability (what they do is they allow the cold
branch of an asm to push temporaries to the stack rather than having to
have gcc clobber them.)

I'll think about it.

	-hpa
