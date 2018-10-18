Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF60BC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDC02145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGTKdkPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDC02145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeJRNni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 09:43:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33203 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbeJRNni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 09:43:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id y140-v6so1032823wmd.0;
        Wed, 17 Oct 2018 22:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zq4kIJzPOriiu7hl0IBA7c6mZnluJjMInxiVkaDwZxI=;
        b=MGTKdkPJTA1FIFQx7OYzI1DTa+gN1o5SvF/6yF9YtBq7nGNNnv3IWRKSzD/AYRp+LO
         kENfEfIkPmgTfqV9tYscvF74K+q2T2SZ2uzUFynK/Db84ukQ6NQlm54Qv4zetb0cOqOC
         ackq57OyFzyjtQEitoiFLwB2ndoCGn/eCycoRmBoIk+8geDFB5jNsUCtNoj0J4pPi2/u
         FdKxU+H+l3MrNdlbTrW8cgcf86RNUsKUxHf/AWqGdtGnZzG6sNJEikczW13qVERV3aKO
         8eL3WzJ2YBtZyLll5IOdef9pMpJwP/BYJQQwn3A8HfdvoTc3wcFgUpiaozzGBxeOhU/K
         bsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zq4kIJzPOriiu7hl0IBA7c6mZnluJjMInxiVkaDwZxI=;
        b=SQIvJxtwGHyX1OcAF0yKxcR5O2/7mddiehiMrx5HxR+0DU9ojHlbaN1l8rZbfL8d61
         nFBReq/jEpyLFwNkhbaoFM+9dtefgD0wtVnkmJf/jUBsUDU9tSn8PjYLfJhnoO3oXRgG
         mwyXRLlX8mXfRlFGPW2DlF/bWZ2nhVE69pP8+TFlNNjOn79ogq/BqoGZ1rK7RYF4qwyW
         Jlo2s4yjaszC6f+6ViPYelm3UMswWTq5ElUgfIkEbjQ+Ru/djv1UFQZWmI49o8iU94PY
         q+BjktwDIgUFWZxvYdpL73DLGyESEt8JmAWBCuZtrI7bkbwhwAtWW9GolDo+n+N7JbmH
         KwNQ==
X-Gm-Message-State: ABuFfojLG6z+p89PXJqoywxN54hrLOX0Pu9rU0aE+yaJcX76tK2aa1oQ
        gVA2M/jQ3nQmodIcwvo3x08=
X-Google-Smtp-Source: ACcGV62SBhDYrYKWoxfd4VpkyU9rRIl6M//Zb+x4FFXK2n8b3GkKEO+OnWhBxIJ+eBcUUHSN/HOENQ==
X-Received: by 2002:a1c:b7c1:: with SMTP id h184-v6mr5966307wmf.33.1539841459106;
        Wed, 17 Oct 2018 22:44:19 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j128-v6sm2525296wmb.43.2018.10.17.22.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 22:44:18 -0700 (PDT)
Date:   Thu, 18 Oct 2018 07:44:15 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Drew Schmitt <dasch@google.com>,
        Hadrien Grasland <grasland@lal.in2p3.fr>,
        "Herton R. Krzesinski" <herton@redhat.com>,
        Jarod Wilson <jarod@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>, linuxarm@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wang Nan <wangnan0@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        William Cohen <wcohen@redhat.com>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/11] perf/urgent fixes
Message-ID: <20181018054415.GA62071@gmail.com>
References: <20181017225501.32150-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017225501.32150-1-acme@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> Best Regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit c1883f10cfe05c707cce46d6999411c50a2413ca:
> 
>   Merge tag 'perf-urgent-for-mingo-4.19-20181005' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2018-10-05 18:14:00 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.19-20181017
> 
> for you to fetch changes up to edeb0c90df3581b821a764052d185df985f8b8dc:
> 
>   perf tools: Stop fallbacking to kallsyms for vdso symbols lookup (2018-10-17 15:56:15 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Stop fallbacking to kallsyms for vDSO symbols lookup, this wasn't
>   being really used and is not valid in arches such as Sparc, where
>   user and kernel space don't share the address space, relying only on
>   cpumode to figure out what DSOs to lookup (Arnaldo Carvalho de Melo)
> 
> - Align cpu map synthesized events properly, fixing SIGBUS in
>   CPUs like Sparc (David Miller)
> 
> - Fix use of alternatives to find JDIR (Jarod Wilson)
> 
> - Store ids for events with their own cpus when synthesizing user
>   level event details (scale, unit, etc) events, fixing a crash
>   when recording a PMU event with a cpumask defined (Jiri Olsa)
> 
> - Fix wrong filter_band* values for uncore Intel vendor events (Jiri Olsa)
> 
> - Fix detection of tracefs path in systems without tracefs, where
>   that path should be the debugfs mountpoint plus "/tracing/" (Jiri Olsa)
> 
> - Pass build flags to traceevent build, allowing using alternative
>   flags in distro packages, RPM, for instance (Jiri Olsa)
> 
> - Fix 'perf report' crash on invalid inline debug information (Milian Wolff)
> 
> - Synch kvm uapi copies (Arnaldo Carvalho de Melo)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (3):
>       tools arch uapi: Sync the x86 kvm.h copy
>       tools headers uapi: Sync kvm.h copy
>       perf tools: Stop fallbacking to kallsyms for vdso symbols lookup
> 
> David Miller (1):
>       perf cpu_map: Align cpu map synthesized events properly.
> 
> Jarod Wilson (1):
>       perf tools: Fix use of alternatives to find JDIR
> 
> Jiri Olsa (5):
>       Revert "perf tools: Fix PMU term format max value calculation"
>       perf vendor events intel: Fix wrong filter_band* values for uncore events
>       perf evsel: Store ids for events with their own cpus perf_event__synthesize_event_update_cpus
>       perf tools: Fix tracing_path_mount proper path
>       perf tools: Pass build flags to traceevent build
> 
> Milian Wolff (1):
>       perf report: Don't crash on invalid inline debug information
> 
>  tools/arch/x86/include/uapi/asm/kvm.h              |  1 +
>  tools/include/uapi/linux/kvm.h                     |  1 +
>  tools/lib/api/fs/tracing_path.c                    |  4 ++--
>  tools/perf/Makefile.config                         |  2 +-
>  tools/perf/Makefile.perf                           |  2 +-
>  tools/perf/builtin-report.c                        |  1 +
>  .../pmu-events/arch/x86/ivytown/uncore-power.json  | 16 ++++++++--------
>  .../pmu-events/arch/x86/jaketown/uncore-power.json | 16 ++++++++--------
>  tools/perf/util/event.c                            | 22 +++-------------------
>  tools/perf/util/evsel.c                            |  3 +++
>  tools/perf/util/pmu.c                              | 13 +++++++------
>  tools/perf/util/srcline.c                          |  3 +++
>  12 files changed, 39 insertions(+), 45 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
