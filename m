Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70052C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D4C2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdlEa7XG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D4C2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbeHBJxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:53:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55385 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729926AbeHBJxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:53:09 -0400
Received: by mail-wm0-f67.google.com with SMTP id f21-v6so1391260wmc.5;
        Thu, 02 Aug 2018 01:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+oVOA8rSjzQOGZsp54l01s2gIMGGJLTjJofSv7qQF08=;
        b=VdlEa7XGdGHR1yc/ipRxLP1ePtjldriJUqePB7Ewor1D5IllesmSWg97VPlgEI4DkD
         6wcFH8m7CB43uD859A6GIv05Bx82hXpdfIzfpoyLEZ9b41EaYzuYXTK7kPZ/s8xSbGVv
         NKYvj1wlGbf2NLzB5D1Yt2sokm00LMVTpgCooBoEi1mvVi/sWdjkJ/AtisgJ5vvtEM7j
         qztmpRcZd16KZ1cwYcN+M8prnKhJGPK7EV+o+4+rX6UdTBBuU24menQXYr0kzDoEoH4j
         QxPTznN8636JJMsuEr1+dxVPyf3N/Mh9un+Amv1vUmH2F1a96FOlw/QGLNwPjvVb8Ano
         34SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+oVOA8rSjzQOGZsp54l01s2gIMGGJLTjJofSv7qQF08=;
        b=KvyHL/LVKizHQ3W7r3sCnnV+isFGKK6uWPXa/OSrl6rrr3RNo3VN9XvuYoEkqravma
         AI3cPcQ24KhEma1uBxs4ef2Q3go2UzumSCe6UqMsAerqYO0Wd28Tjhz7HGiq0UckkIoU
         Z+sYrafDpoIARW8keth8MqmitVlXszRPNAXTs6HOl01sYHS9oN51gEGwAss1loD5FWU2
         Qk77nRst4V/SuuhOF9AOluBwS7y1OEYGW/TWrIljFBz8LhPkjz5KpNhBTpYqPfHRW+Wj
         Yi2KHQmHFurueQA2YxzxTw3ltUH3okLNnYf8YFrWs2ydeQb4WyMXPlmWrKFzrzl0JQPn
         6rCg==
X-Gm-Message-State: AOUpUlEOJXQAcA4LXDWaKXDKRblVdeoy+iAlKtDGHEKIjHicRIa6A0dJ
        davQFMHrgoLut6Nji4FLR7E=
X-Google-Smtp-Source: AAOMgpfsXIYkErEEhBIBTfk7F9yJeUpJX7SeQa8KKXwSdGixpnKVnh2DP2haRPQhrqcusr2kVTSLgw==
X-Received: by 2002:a1c:36aa:: with SMTP id y42-v6mr1116916wmh.159.1533196990808;
        Thu, 02 Aug 2018 01:03:10 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e137-v6sm1691449wma.20.2018.08.02.01.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 01:03:09 -0700 (PDT)
Date:   Thu, 2 Aug 2018 10:03:06 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jan Glauber <jan.glauber@cavium.com>,
        Jayachandran C <jnair@caviumnetworks.com>,
        Jiri Olsa <jolsa@redhat.com>, Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Mark Rutland <mark.rutland@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Mike Leach <mike.leach@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Robert Richter <robert.richter@cavium.com>,
        Robert Walker <robert.walker@arm.com>, rodia@autistici.org,
        Sandipan Das <sandipan@linux.ibm.com>,
        Stefan Liebler <stli@linux.ibm.com>,
        Sunil K Pandey <sunil.k.pandey@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Vadim Lomovtsev <vadim.lomovtsev@cavium.com>,
        Wang Nan <wangnan0@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/21] perf/core improvements and fixes
Message-ID: <20180802080306.GA30142@gmail.com>
References: <20180801213648.4814-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, contains a recently merged
> tip/perf/urgent,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit c2586cfbb905939b79b49a9121fb0a59a5668fd6:
> 
>   Merge remote-tracking branch 'tip/perf/urgent' into perf/core (2018-07-31 09:55:45 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.19-20180801
> 
> for you to fetch changes up to b912885ab75c7c8aa841c615108afd755d0b97f8:
> 
>   perf trace: Do not require --no-syscalls to suppress strace like output (2018-08-01 16:20:28 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf trace: (Arnaldo Carvalho de Melo)
> 
> - Do not require --no-syscalls to suppress strace like output, i.e.
> 
>      # perf trace -e sched:*switch
> 
>   will show just sched:sched_switch events, not strace-like formatted
>   syscall events, use --syscalls to get the previous behaviour.
> 
>   If instead:
> 
>      # perf trace
> 
>   is used, i.e. no events specified, then --syscalls is implied and
>   system wide strace like formatting will be applied to all syscalls.
> 
>   The behaviour when just a syscall subset is used with '-e' is unchanged:
> 
>      # perf trace -e *sleep,sched:*switch
> 
>   will work as before: just the 'nanosleep' syscall will be strace-like
>   formatted plus the sched:sched_switch tracepoint event, system wide.
> 
> - Allow string table generators to use a default header dir, allowing
>   use of them without parameters to see the table it generates on
>   stdout, e.g.:
> 
>     $ tools/perf/trace/beauty/kvm_ioctl.sh
>     static const char *kvm_ioctl_cmds[] = {
>         [0x00] = "GET_API_VERSION",
>         [0x01] = "CREATE_VM",
>         [0x02] = "GET_MSR_INDEX_LIST",
>         [0x03] = "CHECK_EXTENSION",
> <BIG SNIP>
>         [0xe0] = "CREATE_DEVICE",
>         [0xe1] = "SET_DEVICE_ATTR",
>         [0xe2] = "GET_DEVICE_ATTR",
>         [0xe3] = "HAS_DEVICE_ATTR",
>     };
>     $
> 
>   See 'ls tools/perf/trace/beauty/*.sh' to see the available string
>   table generators.
> 
> - Add a generator for IPPROTO_ socket's protocol constants.
> 
> perf record: (Kan Liang)
> 
> - Fix error out while applying initial delay and using LBR, due to
>   the use of a PERF_TYPE_SOFTWARE/PERF_COUNT_SW_DUMMY event to track
>   PERF_RECORD_MMAP events while waiting for the initial delay. Such
>   events fail when configured asking PERF_SAMPLE_BRANCH_STACK in
>   perf_event_attr.sample_type.
> 
> perf c2c: (Jiri Olsa)
> 
> - Fix report crash for empty browser, when processing a perf.data file
>   without events of interest, either because not asked for in
>   'perf record' or because the workload didn't triggered such events.
> 
> perf list: (Michael Petlan)
> 
> - Align metric group description format with PMU event description.
> 
> perf tests: (Sandipan Das)
> 
> - Fix indexing when invoking subtests, which caused BPF tests to
>   get results for the next test in the list, with the last one
>   reporting a failure.
> 
> eBPF:
> 
> - Fix installation directory for header files included from eBPF proggies,
>   avoiding clashing with relative paths used to build other software projects
>   such as glibc. (Thomas Richter)
> 
> - Show better message when failing to load an object. (Arnaldo Carvalho de Melo)
> 
> General: (Christophe Leroy)
> 
> - Allow overriding MAX_NR_CPUS at compile time, to make the tooling
>   usable in systems with less memory, in time this has to be changed
>   to properly allocate based on _NPROCESSORS_ONLN.
> 
> Architecture specific:
> 
> - Update arm64's ThunderX2 implementation defined pmu core events (Ganapatrao Kulkarni)
> 
> - Fix complex event name parsing in 'perf test' for PowerPC, where the 'umask' event
>   modifier isn't present. (Sandipan Das)
> 
> CoreSight ARM hardware tracing: (Leo Yan)
> 
> - Fix start tracing packet handling.
> 
> - Support dummy address value for CS_ETM_TRACE_ON packet.
> 
> - Generate branch sample when receiving a CS_ETM_TRACE_ON packet.
> 
> - Generate branch sample for CS_ETM_TRACE_ON packet.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (9):
>       perf trace beauty: Default header_dir to cwd to work without parms
>       tools include uapi: Grab a copy of linux/in.h
>       perf beauty: Add a generator for IPPROTO_ socket's protocol constants
>       perf trace beauty: Do not print NULL strarray entries
>       perf trace beauty: Add beautifiers for 'socket''s 'protocol' arg
>       perf trace: Beautify the AF_INET & AF_INET6 'socket' syscall 'protocol' args
>       perf bpf: Show better message when failing to load an object
>       perf bpf: Include uapi/linux/bpf.h from the 'perf trace' script's bpf.h
>       perf trace: Do not require --no-syscalls to suppress strace like output
> 
> Christophe Leroy (1):
>       perf tools: Allow overriding MAX_NR_CPUS at compile time
> 
> Ganapatrao Kulkarni (1):
>       perf vendor events arm64: Update ThunderX2 implementation defined pmu core events
> 
> Jiri Olsa (1):
>       perf c2c report: Fix crash for empty browser
> 
> Kan Liang (1):
>       perf evlist: Fix error out while applying initial delay and LBR
> 
> Leo Yan (4):
>       perf cs-etm: Fix start tracing packet handling
>       perf cs-etm: Support dummy address value for CS_ETM_TRACE_ON packet
>       perf cs-etm: Generate branch sample when receiving a CS_ETM_TRACE_ON packet
>       perf cs-etm: Generate branch sample for CS_ETM_TRACE_ON packet
> 
> Michael Petlan (1):
>       perf list: Unify metric group description format with PMU event description
> 
> Sandipan Das (2):
>       perf tests: Fix complex event name parsing
>       perf tests: Fix indexing when invoking subtests
> 
> Thomas Richter (1):
>       perf build: Fix installation directory for eBPF
> 
>  tools/include/uapi/linux/in.h                      | 301 +++++++++++++++++++++
>  tools/perf/Makefile.config                         |   4 +-
>  tools/perf/Makefile.perf                           |  10 +
>  tools/perf/builtin-c2c.c                           |   3 +
>  tools/perf/builtin-trace.c                         |  19 +-
>  tools/perf/check-headers.sh                        |   1 +
>  tools/perf/include/bpf/bpf.h                       |   3 +
>  tools/perf/perf.h                                  |   2 +
>  .../arch/arm64/cavium/thunderx2/core-imp-def.json  |  87 +++++-
>  tools/perf/tests/builtin-test.c                    |   4 +-
>  tools/perf/tests/parse-events.c                    |   2 +-
>  tools/perf/trace/beauty/Build                      |   1 +
>  tools/perf/trace/beauty/beauty.h                   |   3 +
>  tools/perf/trace/beauty/drm_ioctl.sh               |   9 +-
>  tools/perf/trace/beauty/kcmp_type.sh               |   2 +-
>  tools/perf/trace/beauty/kvm_ioctl.sh               |   4 +-
>  tools/perf/trace/beauty/madvise_behavior.sh        |   2 +-
>  tools/perf/trace/beauty/perf_ioctl.sh              |   2 +-
>  .../perf/trace/beauty/pkey_alloc_access_rights.sh  |   2 +-
>  tools/perf/trace/beauty/sndrv_ctl_ioctl.sh         |   4 +-
>  tools/perf/trace/beauty/sndrv_pcm_ioctl.sh         |   4 +-
>  tools/perf/trace/beauty/socket.c                   |  28 ++
>  tools/perf/trace/beauty/socket_ipproto.sh          |  11 +
>  tools/perf/trace/beauty/vhost_virtio_ioctl.sh      |   6 +-
>  tools/perf/util/bpf-loader.c                       |   4 +-
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |   1 +
>  tools/perf/util/cs-etm.c                           |  68 ++++-
>  tools/perf/util/evsel.c                            |  14 +
>  tools/perf/util/metricgroup.c                      |   4 +-
>  29 files changed, 556 insertions(+), 49 deletions(-)
>  create mode 100644 tools/include/uapi/linux/in.h
>  create mode 100644 tools/perf/trace/beauty/socket.c
>  create mode 100755 tools/perf/trace/beauty/socket_ipproto.sh

Pulled, thanks a lot Arnaldo!

	Ingo
