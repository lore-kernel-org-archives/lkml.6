Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42953C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C6F223F8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C6F223F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933354AbeFUVXV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:23:21 -0400
Received: from www62.your-server.de ([213.133.104.62]:36716 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933162AbeFUVXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:23:20 -0400
Received: from [109.168.64.67] (helo=localhost.localdomain)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fW72x-0003n3-W2; Thu, 21 Jun 2018 23:23:16 +0200
Subject: Re: [PATCH 0/3] KASLR feature to randomize each loadable module
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "jannh@google.com" <jannh@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Accardi, Kristen C" <kristen.c.accardi@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
References: <1529532570-21765-1-git-send-email-rick.p.edgecombe@intel.com>
 <CAGXu5jLt8Zv-p=9J590WFppc3O6LWrAVdi-xtU7r_8f4j0XeRg@mail.gmail.com>
 <CAG48ez2uuQkSS9DLz6j5HbpuxaHMyAVYGMM+xoZEo51N=sHmdg@mail.gmail.com>
 <1529607615.29548.202.camel@intel.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4efbcefe-78fb-b7db-affd-ad86f9e9b0ee@iogearbox.net>
Date:   Thu, 21 Jun 2018 23:23:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1529607615.29548.202.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.3/24683/Thu Jun 21 14:43:55 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21/2018 08:59 PM, Edgecombe, Rick P wrote:
> On Thu, 2018-06-21 at 15:37 +0200, Jann Horn wrote:
>> On Thu, Jun 21, 2018 at 12:34 AM Kees Cook <keescook@chromium.org>
>> wrote:
>>> And most systems have <200 modules, really. I have 113 on a desktop
>>> right now, 63 on a server. So this looks like a trivial win.
>> But note that the eBPF JIT also uses module_alloc(). Every time a BPF
>> program (this includes seccomp filters!) is JIT-compiled by the
>> kernel, another module_alloc() allocation is made. For example, on my
>> desktop machine, I have a bunch of seccomp-sandboxed processes thanks
>> to Chrome. If I enable the net.core.bpf_jit_enable sysctl and open a
>> few Chrome tabs, BPF JIT allocations start showing up between
>> modules:
>>
>> # grep -C1 bpf_jit_binary_alloc /proc/vmallocinfo | cut -d' ' -f 2-
>>   20480 load_module+0x1326/0x2ab0 pages=4 vmalloc N0=4
>>   12288 bpf_jit_binary_alloc+0x32/0x90 pages=2 vmalloc N0=2
>>   20480 load_module+0x1326/0x2ab0 pages=4 vmalloc N0=4
>> --
>>   20480 load_module+0x1326/0x2ab0 pages=4 vmalloc N0=4
>>   12288 bpf_jit_binary_alloc+0x32/0x90 pages=2 vmalloc N0=2
>>   36864 load_module+0x1326/0x2ab0 pages=8 vmalloc N0=8
>> --
>>   20480 load_module+0x1326/0x2ab0 pages=4 vmalloc N0=4
>>   12288 bpf_jit_binary_alloc+0x32/0x90 pages=2 vmalloc N0=2
>>   40960 load_module+0x1326/0x2ab0 pages=9 vmalloc N0=9
>> --
>>   20480 load_module+0x1326/0x2ab0 pages=4 vmalloc N0=4
>>   12288 bpf_jit_binary_alloc+0x32/0x90 pages=2 vmalloc N0=2
>>  253952 load_module+0x1326/0x2ab0 pages=61 vmalloc N0=61
>>
>> If you use Chrome with Site Isolation, you have a few dozen open
>> tabs,
>> and the BPF JIT is enabled, reaching a few hundred allocations might
>> not be that hard.
>>
>> Also: What's the impact on memory usage? Is this going to increase
>> the
>> number of pagetables that need to be allocated by the kernel per
>> module_alloc() by 4K or 8K or so?
> Thanks, it seems it might require some extra memory.  I'll look into it
> to find out exactly how much.
> 
> I didn't include eBFP modules in the randomization estimates, but it
> looks like they are usually smaller than a page.  So with the slight
> leap that the larger normal modules based estimate is the worst case,
> you should still get ~800 modules at 18 bits. After that it will start
> to go down to 10 bits and so in either case it at least won't regress
> the randomness of the existing algorithm.

Assume typically complex (real) programs at around 2.5k BPF insns today.
In our case it's max a handful per net device, thus approx per netns (veth)
which can be few hundreds. Worst case is 4k that BPF allows and then JITs.
There's a BPF kselftest suite you could also run to check on worst case
upper bounds.
