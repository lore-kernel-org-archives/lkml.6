Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA43AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9428C21B25
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733006AbfBKSyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:54:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbfBKSyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:54:06 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C3C8680F6D;
        Mon, 11 Feb 2019 18:54:05 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-25.phx2.redhat.com [10.3.112.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B26D19C7B;
        Mon, 11 Feb 2019 18:54:04 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 0B3EE53A7; Mon, 11 Feb 2019 16:54:01 -0200 (BRST)
Date:   Mon, 11 Feb 2019 16:54:00 -0200
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 0/9] perf annotation of BPF programs
Message-ID: <20190211185400.GA2084@redhat.com>
References: <20190209011705.2160185-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209011705.2160185-1-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 11 Feb 2019 18:54:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 08, 2019 at 05:16:56PM -0800, Song Liu escreveu:
> This series enables annotation of BPF programs in perf.
> 
> perf tool gathers information via sys_bpf and (optionally) stores them in
> perf.data as headers.

Jiri, Stephane, this is the patchkit I mentioned in the context of doing
away with perf.data headers and instead package everything as userspace
PERF_RECORD_ metadata events.

Song, please add Jiri and Namhyung in future perf patchkits, they are
listed as perf tools reviewers in MAINTAINANERS and Jiri also is working
on something directly related.

Thanks,

- Arnaldo
 
> Patch 1/9 fixes a minor issue in kernel;
> Patch 2/9 to 4/9 introduce new helper functions and use them in perf and
>      bpftool;
> Patch 5/9 and 6/9 saves information of bpf program in perf_env;
> Patch 7/9 adds --bpf-event options to perf-top;
> Patch 8/9 enables annotation of bpf programs based on information gathered
>      in 5/9 and 6/9;
> Patch 9/9 handles information of short living BPF program that are loaded
>      during perf-record or perf-top.
> 
> Commands tested during developments are perf-top, perf-record, perf-report,
> and perf-annotate.
> 
> ===================== Note on patch dependency  ========================
> This set has dependency in both bpf-next tree and tip/perf/core. Current
> version is developed on bpf-next tree with the following commits
> cherry-picked from tip/perf/core:
> 
> (from 1/10 to 10/10)
> commit 76193a94522f ("perf, bpf: Introduce PERF_RECORD_KSYMBOL")
> commit d764ac646491 ("tools headers uapi: Sync tools/include/uapi/linux/perf_event.h")
> commit 6ee52e2a3fe4 ("perf, bpf: Introduce PERF_RECORD_BPF_EVENT")
> commit df063c83aa2c ("tools headers uapi: Sync tools/include/uapi/linux/perf_event.h")
> commit 9aa0bfa370b2 ("perf tools: Handle PERF_RECORD_KSYMBOL")
> commit 45178a928a4b ("perf tools: Handle PERF_RECORD_BPF_EVENT")
> commit 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded BPF programs")
> commit a40b95bcd30c ("perf top: Synthesize BPF events for pre-existing loaded BPF programs")
> commit 6934058d9fb6 ("bpf: Add module name [bpf] to ksymbols for bpf programs")
> commit 811184fb6977 ("perf bpf: Fix synthesized PERF_RECORD_KSYMBOL/BPF_EVENT")
> ========================================================================
> 
> Song Liu (9):
>   perf, bpf: consider events with attr.bpf_event as side-band events
>   bpf: libbpf: introduce bpf_program__get_prog_info_linear()
>   bpf: bpftool: use bpf_program__get_prog_info_linear() in
>     prog.c:do_dump()
>   perf, bpf: synthesize bpf events with
>     bpf_program__get_prog_info_linear()
>   perf, bpf: save bpf_prog_info in a rbtree in perf_env
>   perf, bpf: save btf in a rbtree in perf_env
>   perf-top: add option --bpf-event
>   perf, bpf: enable annotation of bpf program
>   perf, bpf: save information about short living bpf programs
> 
>  kernel/events/core.c        |   3 +-
>  tools/bpf/bpftool/prog.c    | 266 ++++++---------------------
>  tools/lib/bpf/libbpf.c      | 251 ++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h      |  63 +++++++
>  tools/lib/bpf/libbpf.map    |   3 +
>  tools/perf/Makefile.config  |   2 +-
>  tools/perf/builtin-record.c |  15 +-
>  tools/perf/builtin-top.c    |  15 +-
>  tools/perf/util/annotate.c  | 149 ++++++++++++++-
>  tools/perf/util/bpf-event.c | 351 +++++++++++++++++++++++++++---------
>  tools/perf/util/bpf-event.h |  48 ++++-
>  tools/perf/util/dso.c       |   1 +
>  tools/perf/util/dso.h       |  33 ++--
>  tools/perf/util/env.c       | 148 +++++++++++++++
>  tools/perf/util/env.h       |  12 ++
>  tools/perf/util/evlist.c    |  20 ++
>  tools/perf/util/evlist.h    |   2 +
>  tools/perf/util/header.c    | 231 +++++++++++++++++++++++-
>  tools/perf/util/header.h    |   2 +
>  tools/perf/util/symbol.c    |   1 +
>  20 files changed, 1304 insertions(+), 312 deletions(-)
> 
> --
> 2.17.1
