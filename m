Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7FAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A5E206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A5E206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391570AbeKVMRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:17:31 -0500
Received: from mga03.intel.com ([134.134.136.65]:58032 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391560AbeKVMRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:17:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 17:40:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,263,1539673200"; 
   d="scan'208";a="93937920"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga008.jf.intel.com with ESMTP; 21 Nov 2018 17:40:27 -0800
Subject: Re: [PATCH v3 2/2] proc: add /proc/<pid>/arch_state
To:     Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, ak@linux.intel.com,
        tim.c.chen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org
References: <1542236407-4323-1-git-send-email-aubrey.li@intel.com>
 <1542236407-4323-2-git-send-email-aubrey.li@intel.com>
 <20181119173904.GC2131@hirez.programming.kicks-ass.net>
 <c62acf67-2529-15b1-5325-e0265b0f613d@linux.intel.com>
 <20181121081936.GH2131@hirez.programming.kicks-ass.net>
 <20181121095350.GC2149@hirez.programming.kicks-ass.net>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <7098dd35-3d7b-57c9-c450-10eee577c199@linux.intel.com>
Date:   Thu, 22 Nov 2018 09:40:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20181121095350.GC2149@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/21 17:53, Peter Zijlstra wrote:
> On Wed, Nov 21, 2018 at 09:19:36AM +0100, Peter Zijlstra wrote:
>> On Wed, Nov 21, 2018 at 09:39:00AM +0800, Li, Aubrey wrote:
>>>> Also; you were going to shop around with the other architectures to see
>>>> what they want/need for this interface. I see nothing on that.
>>>>
>>> I'm open for your suggestion, :)
>>
>> Well, we have linux-arch and the various maintainers are also listed in
>> MAINTAINERS. Go forth and ask..
> 
> Ok, so I googled a wee bit (you could have too).
> 
> There's not that many architectures that build big hot chips
> (powerpc,x86,arm64,s390) (mips, sparc64 and ia64 are pretty dead I
> think, although the Fujitsu Sparc M10 X+/X SIMD looked like it could be
> 'fun').
> 
> Of those, powerpc altivec doesn't seem to be very wide, but you'd have
> to ask the power folks. Same for s390 z13.
> 
> The Fujitsu/ARM64-SVE stuff looks like it can be big and hot.
> 
> And RISC-V has was vector extention, but I don't think anybody is
> actually building big hot versions of that just yet.
> 
Thanks Peter. Add more maintainers here.

On some x86 architectures, the tasks using simd instruction(AVX512 particularly)
need to be dealt with specially against the tasks not using simd instruction.
I proposed an interface to expose such CPU specific information for the user
space tools to apply different scheduling policies.

The interface can be refined to be the format as /proc/<pid>/status. Not sure
if it's useful to any other architectures.

Welcome any comments.

Thanks,
-Aubrey


