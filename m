Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79E5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA9E2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfBUTBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:01:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41779 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfBUTBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:01:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 457BC3082AC3;
        Thu, 21 Feb 2019 19:01:18 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5370F5D71B;
        Thu, 21 Feb 2019 19:01:16 +0000 (UTC)
Subject: Re: [PATCH] x86/fpu: Parse comma separated list passed in clearcpuid
To:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-doc@vger.kernel.org
References: <20190221131225.22063-1-prarit@redhat.com>
 <20190221133745.GP32494@hirez.programming.kicks-ass.net>
 <20190221185806.GC16922@tassilo.jf.intel.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <a5d47668-3948-43f5-7327-2247e901ef35@redhat.com>
Date:   Thu, 21 Feb 2019 14:01:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221185806.GC16922@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 21 Feb 2019 19:01:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/19 1:58 PM, Andi Kleen wrote:
> On Thu, Feb 21, 2019 at 02:37:45PM +0100, Peter Zijlstra wrote:
>> On Thu, Feb 21, 2019 at 08:12:25AM -0500, Prarit Bhargava wrote:
>>> Users cannot disable multiple CPU features with the kernel parameter
>>> clearcpuid=.  For example, "clearcpuid=154 clearcpuid=227" only disables
>>> CPUID bit 154.
>>>
>>> Previous to commit 0c2a3913d6f5 ("x86/fpu: Parse clearcpuid= as early XSAVE
>>> argument") it was possible to pass multiple clearcpuid options as kernel
>>> parameters using individual entries.  With the new code it isn't easy to
>>> replicate exactly that behaviour but a comma separated list can be easily
>>> implemented, eg) "clearcpuid=154,227"
>>>
>>> Make the clearcpuid parse a comma-separated list of values instead of only
>>> a single value.
>>
>> So I think the feature is broken as is; because it doesn't clear the
>> CPUID bits for userspace.
> 
> Usually it's enough to make the kernel stop using something. I used it many 
> times for this.
> 
> People who want to affect user space usually run VMs anyways.

Disabling AVX and/or AVX512, SMT and SMX are all use cases.  Andi is correct --
this is to stop the kernel from using the feature.  The Documentation is clear
on that:

Also note that user programs calling CPUID directly
or using the feature without checking anything
will still see it. This just prevents it from
being used by the kernel or shown in /proc/cpuinfo.

P.

> 
> -Andi
> 
