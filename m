Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A920DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5502147D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5502147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbeK0VSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:18:55 -0500
Received: from www62.your-server.de ([213.133.104.62]:40670 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeK0VSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:18:55 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gRaUc-0006vr-Hd; Tue, 27 Nov 2018 11:21:22 +0100
Received: from [178.197.249.21] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gRaUc-000TbQ-8q; Tue, 27 Nov 2018 11:21:22 +0100
Subject: Re: [PATCH v9 RESEND 0/4] KASLR feature to randomize each loadable
 module
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "jeyu@kernel.org" <jeyu@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        alexei.starovoitov@gmail.com, netdev@vger.kernel.org
References: <20181120232312.30037-1-rick.p.edgecombe@intel.com>
 <20181126153611.GA17169@linux-8ccs>
 <54dafdec825859afc85a3bd651f9e850e57a59dc.camel@intel.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <76b6ffbc-8c44-75ab-382b-ad281c20c2bf@iogearbox.net>
Date:   Tue, 27 Nov 2018 11:21:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <54dafdec825859afc85a3bd651f9e850e57a59dc.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25157/Tue Nov 27 07:17:39 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/2018 01:19 AM, Edgecombe, Rick P wrote:
> On Mon, 2018-11-26 at 16:36 +0100, Jessica Yu wrote:
>> +++ Rick Edgecombe [20/11/18 15:23 -0800]:
> [snip]
>> Hi Rick!
>>
>> Sorry for the delay. I'd like to take a step back and ask some broader
>> questions -
>>
>> - Is the end goal of this patchset to randomize loading kernel modules, or
>> most/all
>>    executable kernel memory allocations, including bpf, kprobes, etc?
> Thanks for taking a look!
> 
> It started with the goal of just randomizing modules (hence the name), but I
> think there is maybe value in randomizing the placement of all runtime added
> executable code. Beyond just trying to make executable code placement less
> deterministic in general, today all of the usages have the property of starting
> with RW permissions and then becoming RO executable, so there is the benefit of
> narrowing the chances a bug could successfully write to it during the RW window.
> 
>> - It seems that a lot of complexity and heuristics are introduced just to
>>    accommodate the potential fragmentation that can happen when the module
>> vmalloc
>>    space starts to get fragmented with bpf filters. I'm partial to the idea of
>>    splitting or having bpf own its own vmalloc space, similar to what Ard is
>> already
>>    implementing for arm64.
>>
>>    So a question for the bpf and x86 folks, is having a dedicated vmalloc
>> region
>>    (as well as a seperate bpf_alloc api) for bpf feasible or desirable on
>> x86_64?
> I actually did some prototyping and testing on this. It seems there would be
> some slowdown from the required changes to the JITed code to support calling
> back from the vmalloc region into the kernel, and so module space would still be
> the preferred region.

Yes, any runtime slow-down would be no-go as BPF sits in the middle of critical
networking fast-path and e.g. on XDP or tc layer and is used in load-balancing,
firewalling, DDoS protection scenarios, some recent examples in [0-3].

  [0] http://vger.kernel.org/lpc-networking2018.html#session-10
  [1] http://vger.kernel.org/lpc-networking2018.html#session-15
  [2] https://blog.cloudflare.com/how-to-drop-10-million-packets/
  [3] http://vger.kernel.org/lpc-bpf2018.html#session-1

>>    If bpf filters need to be within 2 GB of the core kernel, would it make
>> sense
>>    to carve out a portion of the current module region for bpf
>> filters?  According
>>    to Documentation/x86/x86_64/mm.txt, the module region is ~1.5 GB. I am
>> doubtful
>>    that any real system will actually have 1.5 GB worth of kernel modules
>> loaded.
>>    Is there a specific reason why that much space is dedicated to kernel
>> modules,
>>    and would it be feasible to split that region cleanly with bpf?
> Hopefully someone from BPF side of things will chime in, but my understanding
> was that they would like even more space than today if possible and so they may
> not like the reduced space.

I wouldn't mind of the region is split as Jessica suggests but in a way where
there would be _no_ runtime regressions for BPF. This might also allow to have
more flexibility in sizing the area dedicated for BPF in future, and could
potentially be done in similar way as Ard was proposing recently [4].

  [4] https://patchwork.ozlabs.org/project/netdev/list/?series=77779

> Also with KASLR on x86 its actually only 1GB, so it would only be 500MB per
> section (assuming kprobes, etc would share the non-module region, so just two
> sections).
> 
>> - If bpf gets its own dedicated vmalloc space, and we stick to the single task
>>    of randomizing *just* kernel modules, could the vmalloc optimizations and
>> the
>>    "backup" area be dropped? The benefits of the vmalloc optimizations seem to
>>    only be noticeable when we get to thousands of module_alloc allocations -
>>    again, a concern caused by bpf filters sharing the same space with kernel
>>    modules.
> I think the backup area may still be needed, for example if you have 200 modules
> evenly spaced inside 500MB there is only average ~2.5MB gap between them. So a
> late added large module could still get blocked.
> 
>>    So tldr, it seems to me that the concern of fragmentation, the vmalloc
>>    optimizations, and the main purpose of the backup area - basically, the
>> more
>>    complex parts of this patchset - stems squarely from the fact that bpf
>> filters
>>    share the same space as modules on x86. If we were to focus on randomizing
>>    *just* kernel modules, and if bpf and modules had their own dedicated
>> regions,
>>    then I *think* the concrete use cases for the backup area and the vmalloc
>>    optimizations (if we're strictly considering just kernel modules) would
>>    mostly disappear (please correct me if I'm in the wrong here). Then
>> tackling the
>>    randomization of bpf allocations could potentially be a separate task on
>> its own.
> Yes it seems then the vmalloc optimizations could be dropped then, but I don't
> think the backup area could be. Also the entropy would go down since there would
> be less possible positions and we would reduce the space available to BPF. So
> there are some downsides just to remove the vmalloc piece.
> 
> Is your concern that vmalloc optimizations might regress something else? There
> is a middle ground vmalloc optimization where only the try_purge flag is plumbed
> through. The flag was most of the performance gained and with just that piece it
> should not change any behavior for the non-modules flows. Would that be more
> acceptable?
> 
>> Thanks!
>>
>> Jessica
>>
> [snip]
> 

