Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB2CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0872120843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="piRPp5ab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0872120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeIDSHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 14:07:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbeIDSHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 14:07:36 -0400
Received: from jouet.infradead.org (unknown [189.40.103.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A283A2077C;
        Tue,  4 Sep 2018 13:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536068544;
        bh=251mbuOpdC8kdpNzBwzK2uvHGdrb/MhCsB+QHh51gJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=piRPp5ab6LlcUYZWK5SRAWNHmR0EhcvicA8+R18hmavcptXRyQqtST7vpRuZjWmvF
         NprUUnobfcGbKZW7gYQAOgtZ3IQr8WRmohXMXa0E5KwFzfik9hN8zCFhgepTzzoRj3
         cGwz8pyOG1E6mb2hTheOTCQqj9OToEDjWjhyoITs=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 4BB8A141FFC; Tue,  4 Sep 2018 10:42:18 -0300 (-03)
Date:   Tue, 4 Sep 2018 10:42:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC] perf tool improvement requests
Message-ID: <20180904134218.GA5364@kernel.org>
References: <CABPqkBT0kEMOnTw1-E1kezCvtWNSws7dp2qzCWKVmjGPOEga8Q@mail.gmail.com>
 <20180904071049.GY24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904071049.GY24124@hirez.programming.kicks-ass.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 04, 2018 at 09:10:49AM +0200, Peter Zijlstra escreveu:
> On Mon, Sep 03, 2018 at 07:45:48PM -0700, Stephane Eranian wrote:
> > A few weeks ago, you had asked if I had more requests for the perf tool.
 
> I have one long standing one; that is IP based data structure
> annotation.
 
> When we get an exact IP (using PEBS) and were sampling a data related
> event (say L1 misses), we can get the data type from the instruction
> itself; that is, through DWARF. We _know_ what type (structure::member)
> is read/written to.
 
> I would love to get that in a pahole style output.
 
> Better yet, when you measure both hits and misses, you can get a
> structure usage overview, and see what lines are used lots and what
> members inside that line are rarely used. Ideal information for data
> structure layout optimization.
 
> 1000x more useful than that c2c crap.
 
> Can we please get that?

So, use 'c2c record' to get the samples:

[root@jouet ~]# perf c2c record
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 5.152 MB perf.data (4555 samples) ]

Events collected:

[root@jouet ~]# perf evlist -v
cpu/mem-loads,ldlat=30/P: type: 4, size: 112, config: 0x1cd, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|ID|CPU|PERIOD|DATA_SRC|WEIGHT|PHYS_ADDR, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3, mmap_data: 1, sample_id_all: 1, mmap2: 1, comm_exec: 1, { bp_addr, config1 }: 0x1f
cpu/mem-stores/P: type: 4, size: 112, config: 0x82d0, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|ID|CPU|PERIOD|DATA_SRC|WEIGHT|PHYS_ADDR, read_format: ID, disabled: 1, inherit: 1, freq: 1, precise_ip: 3, sample_id_all: 1

	Then we'll get a 'annotate --hits' option (just cooked up, will
polish) that will show the name of the function, info about it globally,
i.e.  what annotate already produced, we may get this in CSV for better
post processing consumption:

[root@jouet ~]# perf annotate --hits kmem_cache_alloc
Samples: 20  of event 'cpu/mem-loads,ldlat=30/P', 4000 Hz, Event count (approx.): 875, [percent: local period]
kmem_cache_alloc() /usr/lib/debug/lib/modules/4.17.17-100.fc27.x86_64/vmlinux
  4.91   15:   mov    gfp_allowed_mask,%ebx
  2.51   51:   mov    (%r15),%r8
 17.14   54:   mov    %gs:0x8(%r8),%rdx
  6.51   61:   cmpq   $0x0,0x10(%r8)
 17.14   66:   mov    (%r8),%r14
  6.29   78:   mov    0x20(%r15),%ebx
  5.71   7c:   mov    (%r15),%rdi
 29.49   85:   xor    0x138(%r15),%rbx
  2.86   9d:   lea    (%rdi),%rsi
  3.43   d7:   pop    %rbx    
  2.29   dc:   pop    %r12    
  1.71   ed:   testb  $0x4,0xb(%rbp)
[root@jouet ~]#

	Then I need to get the DW_AT_location stuff parsed in pahole, so
that with those offsets (second column, ending with :) with hits (first
column, there its local period, but we can ask for some specific metric
[1]), I'll be able to figure out what DW_TAG_variable or
DW_TAG_formal_parameter is living there at that time, get the offset
from the decoded instruction, say that xor, 0x138 offset from the type
for %r15 at that offset (85) from kmem_cache_alloc, right?

In a first milestone we'd have something like:

	perf annotate --hits function | pahole --annotate -C task_struct

	perf annotate --hits | pahole --annotate

Would show all structs with hits, for all functions with hits.

Other options would show which struct has more hits, etc.

- Arnaldo

[1]

[root@jouet ~]# perf annotate -h local

 Usage: perf annotate [<options>]

        --percent-type <local-period>
                          Set percent type local/global-period/hits

[root@jouet ~]# 

- Arnaldo
