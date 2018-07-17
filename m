Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB851ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E6620693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E6620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbeGQWj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 18:39:59 -0400
Received: from shelob.surriel.com ([96.67.55.147]:60930 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbeGQWj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 18:39:59 -0400
Received: from [2620:10d:c091:200::1:463b] (helo=[IPv6:2620:10d:c0a3:10fb:4c:7ee9:b6e2:d1d5])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1ffY5k-0005L7-Am; Tue, 17 Jul 2018 18:05:08 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
From:   Rik van Riel <riel@surriel.com>
In-Reply-To: <CALCETrXtpGPm2Hgm3R=p1ezvNQi==jhQWw5ee9K+H2avNNGsUg@mail.gmail.com>
Date:   Tue, 17 Jul 2018 18:05:05 -0400
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <A3FE5372-2418-4D83-A023-36ECE6E6F423@surriel.com>
References: <20180716190337.26133-1-riel@surriel.com>
 <20180716190337.26133-5-riel@surriel.com>
 <CALCETrUMntRe_LYX5wj9YD4xZ+84QExK+ZNb3yxEBDEKa7nePQ@mail.gmail.com>
 <FF977B78-140F-4787-AA57-0EA934017D85@surriel.com>
 <CALCETrXtpGPm2Hgm3R=p1ezvNQi==jhQWw5ee9K+H2avNNGsUg@mail.gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 17, 2018, at 5:29 PM, Andy Lutomirski <luto@kernel.org> wrote:
> 
> On Tue, Jul 17, 2018 at 1:16 PM, Rik van Riel <riel@surriel.com> wrote:
>> Can I skip both the cr4 and let switches when the TLB contents
>> are no longer valid and got reloaded?
>> 
>> If the TLB contents are still valid, either because we never went
>> into lazy TLB mode, or because no invalidates happened while
>> we were lazy, we immediately return.
>> 
>> The cr4 and ldt reloads only happen if the TLB was invalidated
>> while we were in lazy TLB mode.
> 
> Yes, since the only events that would change the LDT or the required
> CR4 value will unconditionally broadcast to every CPU in mm_cpumask
> regardless of whether they're lazy.  The interesting case is that you
> go lazy, you miss an invalidation IPI because you were lazy, then you
> go unlazy, notice the tlb_gen change, and flush.  If this happens, you
> know that you only missed a page table update and not an LDT update or
> a CR4 update, because the latter would have sent the IPI even though
> you were lazy.  So you should skip the CR4 and LDT updates.
> 
> I suppose a different approach would be to fix the issue below and to
> try to track when the LDT actually needs reloading.  But that latter
> part seems a bit complicated for minimal gain.
> 
> (Do you believe me?  If not, please argue back!)
> 
I believe you :)

>>> Hmm.  load_mm_cr4() should bypass itself when mm == &init_mm.  Want to
>>> fix that part or should I?
>> 
>> I would be happy to send in a patch for this, and one for
>> the above optimization you pointed out.
>> 
> 
> Yes please!
> 
There is a third optimization left to do. Currently every time
we switch into lazy tlb mode, we take a refcount on the mm,
even when switching from one kernel thread to another, or
when repeatedly switching between the same mm and kernel
threads.

We could keep that refcount (on a per cpu basis) from the time
we first switch to that mm in lazy tlb mode, to when we switch
the CPU to a different mm.

That would allow us to not bounce the cache line with the
mm_struct reference count on every lazy TLB context switch.

Does that seem like a reasonable optimization?

Am I overlooking anything?

I'll try to get all three optimizations working, and will run them
through some testing here before posting upstream.

