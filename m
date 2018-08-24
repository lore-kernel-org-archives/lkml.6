Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AA2C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 02:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9992A2156B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 02:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9992A2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tomt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbeHXGFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 02:05:36 -0400
Received: from mail1.ugh.no ([178.79.162.34]:52850 "EHLO mail1.ugh.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbeHXGFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 02:05:36 -0400
X-Greylist: delayed 609 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Aug 2018 02:05:35 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail1.ugh.no (Postfix) with ESMTP id 958152491DE;
        Fri, 24 Aug 2018 04:22:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at catastrophix.ugh.no
Received: from mail1.ugh.no ([127.0.0.1])
        by localhost (catastrophix.ugh.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zJgaxJQIVhg1; Fri, 24 Aug 2018 04:22:58 +0200 (CEST)
Received: from [10.255.99.10] (unknown [185.176.245.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: andre@tomt.net)
        by mail.ugh.no (Postfix) with ESMTPSA id C56542491DD;
        Fri, 24 Aug 2018 04:22:57 +0200 (CEST)
Subject: Re: [PATCH] x86/speculation/l1tf: fix off-by-one error when warning
 that system has too much RAM
To:     Andi Kleen <ak@linux.intel.com>, Vlastimil Babka <vbabka@suse.cz>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>, stable@vger.kernel.org,
        Christopher Snowhill <kode54@gmail.com>,
        George Anchev <studio@anchev.net>
References: <20180823134418.17008-1-vbabka@suse.cz>
 <20180823154437.GC12066@tassilo.jf.intel.com>
From:   Andre Tomt <andre@tomt.net>
Message-ID: <0fa72221-2272-4489-d9d3-0f68cb874087@tomt.net>
Date:   Fri, 24 Aug 2018 04:22:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180823154437.GC12066@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. aug. 2018 17:44, Andi Kleen wrote:
> On Thu, Aug 23, 2018 at 03:44:18PM +0200, Vlastimil Babka wrote:
>> Two users have reported [1] that they have an "extremely unlikely" system
>> with more than MAX_PA/2 memory and L1TF mitigation is not effective. In fact
>> it's a CPU with 36bits phys limit (64GB) and 32GB memory, but due to holes
>> in the e820 map, the main region is almost 500MB over the 32GB limit:
> 
> Ah I see it's a client part with very large DIMMs and someone being
> very brave and using that much memory without ECC.

FYI; It is also happening on Xeon E3v2 (Ivy Bridge generation) w/ 32GB 
of ECC RAM here, a low-end server part that officially supports up to 32GB.

> [    0.000000] microcode: microcode updated early to revision 0x20, date = 2018-04-10
> [    0.029728] L1TF: System has more than MAX_PA/2 memory. L1TF mitigation not effective.
> [    1.063155] microcode: sig=0x306a9, pf=0x2, revision=0x20


> processor	: 7
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 58
> model name	: Intel(R) Xeon(R) CPU E3-1230 V2 @ 3.30GHz
> stepping	: 9
> microcode	: 0x20
> cpu MHz		: 3500.044
> cache size	: 8192 KB
> physical id	: 0
> siblings	: 8
> core id		: 3
> cpu cores	: 4
> apicid		: 7
> initial apicid	: 7
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 13
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm cpuid_fault epb pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms xsaveopt dtherm ida arat pln pts flush_l1d
> bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf
> bogomips	: 6602.15
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 36 bits physical, 48 bits virtual
> power management:


