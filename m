Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54689C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A8B20830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak/zl0Tl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A8B20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388287AbeKGEdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:33:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32961 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730532AbeKGEdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:33:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id u9-v6so4450323wrr.0;
        Tue, 06 Nov 2018 11:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O+6IqHD72gV5Bf0OBmE2esPiaBMOKaAjbiWqp1XWQhM=;
        b=ak/zl0Tlkvgv5UvAUQjfpVkrn3Bxi/4AqYrVnkvpXRU6VQi5Rs/PP3gdEMc0j19MQs
         sSHNG+MsVmvqBabPHQTX8muMaBytPgMwh/jxxZAK53DnrNnaEUVSmJfelVuU77euaO5u
         adnZhZTfdV0aauA0f0hSWtNtZC6uoUSMbINaMu8hHKuFZxdvQNiUfPGjeYzpYgWuW+jx
         tomeRA9jogKbdE4A/kS7EHBgksvVo1VvclyNubLHoIHH/TbZhuZjf0Qa8tFHNFYACoxM
         KzkIrn8o3k1galpRV1KsF1oipKgN6d0rxDxTIMJYd/czZRqNHXWX+5zUz55P98YVCLVz
         XVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=O+6IqHD72gV5Bf0OBmE2esPiaBMOKaAjbiWqp1XWQhM=;
        b=TnUs61pCwPdr/vQlEpFM29WkoZ0kMUMvJdpsz1NlQVGgzVp9sfSZ+Tj4e/3MvXJl0b
         I86/s8xQXlz7eVIreEpSe6J8b/vykL8FyQrUMGD2PgDC9MKomoYcj3d4ZTF6nXrZIdGt
         zWP+SiEoi+hll/XRvdIX6DGClwJ0dsi+HGOO1edoYjVtR0RzcV5gt2QKakoDudbg5d8A
         0uifnwHBt58aD9kXqe5hu0dnaE2TWLclwkJg9RA51ZSfQ2d0tsl6QO+kEZMn9BdPBQTa
         68BkVsUeCT0PYb8kRwQmh8EQQqTiez2ryupWHorI3aww8N0I1gFnjn7uFaz3EZfFe8kF
         VHWg==
X-Gm-Message-State: AGRZ1gKGhtevuFCFZVqS3JgM5rc2q5ibNBlMqjIVjSsfjDbs0R9lQGjJ
        qDN2XTSuyBMItX70KnzXaUg=
X-Google-Smtp-Source: AJdET5dinIjR335JKLT/ADkmmmpBDe2x1AAreAu18J6w6eSPthhE6KJZDUdqLSLAw9jz0ph87ie+FA==
X-Received: by 2002:a5d:4dc2:: with SMTP id f2-v6mr26365147wru.45.1541531194388;
        Tue, 06 Nov 2018 11:06:34 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r198-v6sm3190123wmg.0.2018.11.06.11.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 11:06:33 -0800 (PST)
Date:   Tue, 6 Nov 2018 20:06:30 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        Edward Cree <ecree@solarflare.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Gustavo Romero <gromero@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastien Boisvert <sboisvert@gydle.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Wang Nan <wangnan0@huawei.com>,
        Will Deacon <will.deacon@arm.com>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/18] perf/urgent improvements and fixes
Message-ID: <20181106190630.GA39226@gmail.com>
References: <20181106120612.8262-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, mostly fixes, some late coming
> improvements in non-core areas,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 29995d296e3e9ce4f9767963ecbef143ade26c36:
> 
>   Merge tag 'perf-urgent-for-mingo-4.20-20181031' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2018-10-31 22:53:40 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.20-20181106
> 
> for you to fetch changes up to 8e88c29b351ed4e09dd63f825f1c8260b0cb0ab3:
> 
>   perf tools: Do not zero sample_id_all for group members (2018-11-06 08:29:56 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent improvements and fixes:
> 
> Intel PT sql viewer: (Adrian Hunter)
> 
> - Fall back to /usr/local/lib/libxed.so
> - Add Selected branches report
> - Add help window
> - Fix table find when table re-ordered
> 
> Intel PT debug log (Adrian Hunter)
> 
> - Add more event information
> - Add MTC and CYC timestamps
> 
> perf record: (Andi Kleen)
> 
> - Support weak groups, just like with 'perf stat'
> 
> perf trace: (Arnaldo Carvalho de Melo)
> 
> - Start augmenting raw_syscalls:{sys_enter,sys_exit}: goal is to have a
>   generic, arch independent eBPF kernel component that is programmed with
>   syscall table details, what to copy, how many bytes, pid, arg filters from the
>   userspace via eBPF maps by the 'perf trace' tool that continues to use all its
>   argument beautifiers, just taking advantage of the extra pointer contents.
> 
> JVMTI: (Gustavo Romero)
> 
> - Fix undefined symbol scnprintf in libperf-jvmti.so
> 
> perf top: (Jin Yao)
> 
> - Display the LBR stats in callchain entries
> 
> perf stat: (Thomas Richter)
> 
> - Handle different PMU names with common prefix
> 
> arm64: Will (Deacon)
> 
> - Fix arm64 tools build failure wrt smp_load_{acquire,release}.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (6):
>       perf scripts python: exported-sql-viewer.py: Fall back to /usr/local/lib/libxed.so
>       perf scripts python: exported-sql-viewer.py: Add Selected branches report
>       perf scripts python: exported-sql-viewer.py: Add help window
>       perf scripts python: exported-sql-viewer.py: Fix table find when table re-ordered
>       perf intel-pt: Add more event information to debug log
>       perf intel-pt: Add MTC and CYC timestamps to debug log
> 
> Andi Kleen (2):
>       perf evlist: Move perf_evsel__reset_weak_group into evlist
>       perf record: Support weak groups
> 
> Arnaldo Carvalho de Melo (5):
>       perf examples bpf: Start augmenting raw_syscalls:sys_{start,exit}
>       perf trace: When augmenting raw_syscalls plug raw_syscalls:sys_exit too
>       perf trace: Fix setting of augmented payload when using eBPF + raw_syscalls
>       perf augmented_syscalls: Start collecting pathnames in the BPF program
>       perf beauty: Use SRCARCH, ARCH=x86_64 must map to "x86" to find the headers
> 
> Gustavo Romero (1):
>       perf tools: Fix undefined symbol scnprintf in libperf-jvmti.so
> 
> Jin Yao (1):
>       perf top: Display the LBR stats in callchain entry
> 
> Jiri Olsa (1):
>       perf tools: Do not zero sample_id_all for group members
> 
> Thomas Richter (1):
>       perf stat: Handle different PMU names with common prefix
> 
> Will Deacon (1):
>       tools headers barrier: Fix arm64 tools build failure wrt smp_load_{acquire,release}
> 
>  tools/arch/arm64/include/asm/barrier.h             | 133 +++---
>  tools/perf/Documentation/perf-list.txt             |   1 -
>  tools/perf/Makefile.perf                           |   2 +-
>  tools/perf/builtin-record.c                        |   7 +-
>  tools/perf/builtin-stat.c                          |  28 +-
>  tools/perf/builtin-top.c                           |   3 +
>  tools/perf/builtin-trace.c                         |  34 +-
>  tools/perf/examples/bpf/augmented_raw_syscalls.c   | 131 ++++++
>  tools/perf/jvmti/jvmti_agent.c                     |  49 +-
>  tools/perf/scripts/python/exported-sql-viewer.py   | 493 ++++++++++++++++++++-
>  tools/perf/tests/attr/test-record-group-sampling   |   1 -
>  tools/perf/util/evlist.c                           |  27 ++
>  tools/perf/util/evlist.h                           |   3 +
>  tools/perf/util/evsel.c                            |   1 -
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |   4 +
>  tools/perf/util/intel-pt-decoder/intel-pt-log.c    |   5 +
>  tools/perf/util/intel-pt-decoder/intel-pt-log.h    |   1 +
>  tools/perf/util/intel-pt.c                         |  16 +-
>  tools/perf/util/pmu.c                              |   2 +-
>  19 files changed, 820 insertions(+), 121 deletions(-)
>  create mode 100644 tools/perf/examples/bpf/augmented_raw_syscalls.c

Pulled, thanks a lot Arnaldo!

	Ingo
