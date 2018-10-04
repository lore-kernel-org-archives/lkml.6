Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A279C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D252084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D252084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeJEC2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:28:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41763 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeJEC2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:28:09 -0400
Received: from hanvin-mobl2.amr.corp.intel.com (jfdmzpr05-ext.jf.intel.com [134.134.139.74])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w94JXC5N2860076
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 4 Oct 2018 12:33:13 -0700
Subject: Re: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-5-namit@vmware.com> <20181004075755.GA3353@gmail.com>
 <20181004083333.GA9802@gmail.com>
 <10D29A50-C352-4407-A824-0C3C06CD8592@zytor.com>
 <A5DED74C-A95A-48D8-AF68-39E23696385F@vmware.com>
 <36D6F606-6922-4057-B1F8-2B30993962AE@zytor.com>
 <20181004091651.GB21151@gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <df1bddc1-e71b-dbd8-a24f-01a46d462a79@zytor.com>
Date:   Thu, 4 Oct 2018 12:33:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181004091651.GB21151@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/18 02:16, Ingo Molnar wrote:
> 
> * hpa@zytor.com <hpa@zytor.com> wrote:
> 
>> Ingo: I wasn't talking necessarily about the specifics of each bit, but rather the general 
>> concept about being able to use macros in inlines...
> 
> Ok, agreed about that part - and some of the patches did improve readability.
> 
> Also, the 275 lines macros.s is a lot nicer than the 4,200 lines macros.S.
> 
> Also, I'm not against using workarounds when the benefits are larger than the costs, but I am 
> against *hiding* the fact that these are workarounds and that for some of them there are costs.
> 

Agreed, of course.

>> I can send you something I have been working on in the background, but have been holding off 
>> on because of this, in the morning my time.
> 
> BTW., I have applied most of the series to tip:x86/kbuild already, and will push them out later 
> today after some testing. I didn't apply the final 3 patches as they have dependencies, but 
> applied the basics and fixed up the changelogs.
> 
> So you can rely on this.
> 

Wonderful.

Here is the horrible code I mentioned yesterday.  This is about
implementing the immediate-patching framework that Linus and others have
discussed (it helps both performance and kernel hardening):

Warning: this stuff can cause serious damage to your eyes, and this is a
just a small chunk of the whole mess; and relying on gas macros, as
brain damaged as they are, really is much, much cleaner than not:

	http://www.zytor.com/~hpa/foo.S

	-hpa



