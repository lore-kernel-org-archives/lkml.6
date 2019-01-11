Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF36C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B78C20878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547224022;
	bh=Df64R0ds1gTBKqW6Plh+JWVKE4RS6NsKe7pMORDq+yI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VRn9ZwEIS6Nzq8w3+nXzSwvMdeHrSW7xeyrCh+pe4SItPKIR8O8eZK1h4SM4DtQdS
	 jUr8NZUjX5lJTljjU8w+1VAifMyArk5gw2UboKaDcSbzjzpBoMyB8HOWyfURVgwP3Q
	 LWqPSb3jO7aSOSsxCYMN3Z98hbN+xtFhWsFoweXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388167AbfAKQ1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:27:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:35382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729902AbfAKQ1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:27:00 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7A3020872;
        Fri, 11 Jan 2019 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547224019;
        bh=Df64R0ds1gTBKqW6Plh+JWVKE4RS6NsKe7pMORDq+yI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fqVcD4ncc9QRZcomFiHeEltrkwrk/a7J6M1Xr9KQvsCUyYyQhu7t1fxU9fYRNDOaj
         r7AOtnXbXB0RJWJ6eBWoZWEMm2wUk9cOvRif+2l3/zBkpkXrGWBdw7mZOH0oHFrwbW
         EyWYctDvZxDbFkeXGKld6WZWUBVBRdx91C/FItRA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5A03C41AB5; Fri, 11 Jan 2019 13:26:56 -0300 (-03)
Date:   Fri, 11 Jan 2019 13:26:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        peterz@infradead.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, dsahern@gmail.com
Subject: Re: [PATCH v7 perf, bpf-next 0/8] reveal invisible bpf programs
Message-ID: <20190111162656.GY22483@kernel.org>
References: <20190111001933.4153792-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111001933.4153792-1-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 10, 2019 at 04:19:25PM -0800, Song Liu escreveu:
> This set catches symbol for all bpf programs loaded/unloaded
> before/during/after perf-record run PERF_RECORD_KSYMBOL and
> PERF_RECORD_BPF_EVENT.
> 
> PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT includes key information
> of a bpf program load and unload. They are sent through perf ringbuffer,
> and stored in perf.data. PERF_RECORD_KSYMBOL includes basic information
> for simple profiling. It is ON by default. PERF_RECORD_BPF_EVENT is
> used to gather more information of the bpf program. It is necessary for
> perf-annotate of bpf programs.
> 
> Before this patch, perf-report will not be able to recover symbols of
> bpf programs once the programs are unloaded.
> 
> This is to follow up Alexei's early effort [2] to show bpf programs via
> mmap events.
> 
> Thanks,
> Song
> 
> Changes v6 -> PATCH v7:
> 1. Split "[3/7] introduce PERF_RECORD_BPF_EVENT" into two commits:
>      [3/8] introduce PERF_RECORD_BPF_EVENT
>      [5/8] emit PERF_RECORD_KSYMBOL for BPF program load/unload

Thanks, I'm trying now to build a kernel/tools combo to test this.
 
> Changes v5 -> PATCH v6:
> 1. Reduce len in PERF_RECORD_KSYMBOL from u64 to u32. Use the 32 free bits
>    for ksym_type (u16) and flags (u16).
> 
> Changes v4 -> PATCH v5:
> 1. Fixed build error reported by kbuild test bot.
> 
> Changes v3 -> PATCH v4:
> 1. Split information about bpf program  into PERF_RECORD_KSYMBOL (with
>    name, addr, len); and PERF_RECORD_BPF_EVENT PERF_RECORD_BPF_EVENT
>    (with id, tag);
> 2. Split the implementation in kernel and user space.
> 
> Changes v2 -> PATCH v3:
> 1. Rebase on bpf-next tree, and on top of BPF sub program tag patches [1]
>    for latest information in bpf_prog_info.
> 2. Complete handling and synthesizing PERF_RECORD_BPF_EVENT in perf.
> 
> Changes v1 -> PATCH v2:
> 1. Only 3 of the 5 patches in v1, to focus on ABI first;
> 2. Generate PERF_RECORD_BPF_EVENT per bpf sub program instead of per prog;
> 3. Modify PERF_RECORD_BPF_EVENT with more details (addr, len, name),
>    so that it can be used for basic profiling without calling sys_bpf.
> 
> Changes RFC -> PATCH v1:
> 1. In perf-record, poll vip events in a separate thread;
> 2. Add tag to bpf prog name;
> 3. Small refactorings.
> 
> [1] https://patchwork.ozlabs.org/project/netdev/list/?series=81037
> [2] https://www.spinics.net/lists/netdev/msg524232.html
> 
> Song Liu (8):
>   perf, bpf: Introduce PERF_RECORD_KSYMBOL
>   sync tools/include/uapi/linux/perf_event.h
>   perf, bpf: introduce PERF_RECORD_BPF_EVENT
>   sync tools/include/uapi/linux/perf_event.h
>   perf, bpf: emit PERF_RECORD_KSYMBOL for BPF program load/unload
>   perf util: handle PERF_RECORD_KSYMBOL
>   perf util: handle PERF_RECORD_BPF_EVENT
>   perf tools: synthesize PERF_RECORD_* for loaded BPF programs
> 
>  include/linux/filter.h                |   7 +
>  include/linux/perf_event.h            |  19 +++
>  include/uapi/linux/perf_event.h       |  53 ++++++-
>  kernel/bpf/core.c                     |   2 +-
>  kernel/bpf/syscall.c                  |   2 +
>  kernel/events/core.c                  | 218 ++++++++++++++++++++++++-
>  tools/include/uapi/linux/perf_event.h |  53 ++++++-
>  tools/perf/builtin-record.c           |   7 +
>  tools/perf/perf.h                     |   1 +
>  tools/perf/util/Build                 |   2 +
>  tools/perf/util/bpf-event.c           | 220 ++++++++++++++++++++++++++
>  tools/perf/util/bpf-event.h           |  16 ++
>  tools/perf/util/event.c               |  41 +++++
>  tools/perf/util/event.h               |  36 +++++
>  tools/perf/util/evsel.c               |  19 +++
>  tools/perf/util/evsel.h               |   2 +
>  tools/perf/util/machine.c             |  60 +++++++
>  tools/perf/util/machine.h             |   3 +
>  tools/perf/util/session.c             |   8 +
>  tools/perf/util/tool.h                |   5 +-
>  20 files changed, 769 insertions(+), 5 deletions(-)
>  create mode 100644 tools/perf/util/bpf-event.c
>  create mode 100644 tools/perf/util/bpf-event.h
> 
> --
> 2.17.1

-- 

- Arnaldo
