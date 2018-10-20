Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B074CC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 08:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506AF2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 08:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sp8Vx69S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506AF2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeJTQUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 12:20:20 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:41461 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeJTQUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 12:20:20 -0400
Received: by mail-wr1-f49.google.com with SMTP id q7-v6so11822489wrr.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 01:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bk+20FsqENBUpgu4sZVzZjRHBzt7dZEAXiOFMyaGk6Q=;
        b=sp8Vx69SHG41XWET40+0htfqkTQOn7Ga7qwHThATXJdow+0RGrI4IG3nNuQIkKuzVa
         3jdp06CAnZl3j6CsZSDJsFg9/Iq4S/ok0vNxQ1r95oXj/VKQtkzJpdkavr2kNW0jLJA1
         /XpLUphfGXDX5WuYpcEsi+viLw8u2sEVAnOZOhdg7aQBWt8nDIjfn0GHo3Kcv999H2LO
         mBIMRV61bA5xNl7YR+75R6lHs9QGRp2T+6uVA7E4whvoDPXJ3fmtvOzHn/YFsmk6BgL6
         PZtzkZ2DgNJ7fcu8UPfCedpwJBdWvCAD1XCTG1/hWJOCzWY24poHBpvAARtRKChIs6WG
         +nLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=bk+20FsqENBUpgu4sZVzZjRHBzt7dZEAXiOFMyaGk6Q=;
        b=FpLY1fuJzBbbFqvyAFhcg9v4I1qXSO2yvbKJFI5/iizG3qsplpcLh8tULeh2MuFXhx
         FB9bDqC6BCvyq6MsWuCkYb9zFNWI83LX/7PnPJJym8dEzLOlkqgIt6BYWoMLsbhC/+RM
         g1s0AHerFREd+fmCvGqpK3Mu0/ND9hW10kLGAUUXENxedTE/hJQ5+pjJAY//gu34GF6j
         IdHWvDqX0O/dBIRkVH+JsDdQwZkBEbPe2tMc6VFdj0ra2kFMHITjvetrdFlEaoI48YaQ
         4zVfSARKH1qRGB4DnM0A2h7eTNWIEV4ctESyVYavVSl3aJq4M0s39c/57juY8lLIy6cP
         US/w==
X-Gm-Message-State: ABuFfojI4dotDvuDQ665hR8kz3kFZ0cZNrf27uWMaARCzNUYYDe/uqZh
        dWm2gkT6cZPHQz22LneI1Sk=
X-Google-Smtp-Source: ACcGV634cXUjd2Lalezmnh3js1uWelM23HTyDwYqEoAHQeMl86orwOs3lBcPM36x4u4+dFno7igYCQ==
X-Received: by 2002:adf:f941:: with SMTP id q1-v6mr35571099wrr.151.1540023042723;
        Sat, 20 Oct 2018 01:10:42 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c64-v6sm4039987wma.44.2018.10.20.01.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Oct 2018 01:10:41 -0700 (PDT)
Date:   Sat, 20 Oct 2018 10:10:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20181020081039.GA92090@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: 20e8e72d0fa8e26202932c30d592bade73fdc701 Merge tag 'perf-urgent-for-mingo-4.19-20181017' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

Misc perf tooling fixes.

 Thanks,

	Ingo

------------------>
Arnaldo Carvalho de Melo (3):
      tools arch uapi: Sync the x86 kvm.h copy
      tools headers uapi: Sync kvm.h copy
      perf tools: Stop fallbacking to kallsyms for vdso symbols lookup

David Miller (1):
      perf cpu_map: Align cpu map synthesized events properly.

Jarod Wilson (1):
      perf tools: Fix use of alternatives to find JDIR

Jiri Olsa (5):
      Revert "perf tools: Fix PMU term format max value calculation"
      perf vendor events intel: Fix wrong filter_band* values for uncore events
      perf evsel: Store ids for events with their own cpus perf_event__synthesize_event_update_cpus
      perf tools: Fix tracing_path_mount proper path
      perf tools: Pass build flags to traceevent build

Milian Wolff (1):
      perf report: Don't crash on invalid inline debug information


 tools/arch/x86/include/uapi/asm/kvm.h              |  1 +
 tools/include/uapi/linux/kvm.h                     |  1 +
 tools/lib/api/fs/tracing_path.c                    |  4 ++--
 tools/perf/Makefile.config                         |  2 +-
 tools/perf/Makefile.perf                           |  2 +-
 tools/perf/builtin-report.c                        |  1 +
 .../pmu-events/arch/x86/ivytown/uncore-power.json  | 16 ++++++++--------
 .../pmu-events/arch/x86/jaketown/uncore-power.json | 16 ++++++++--------
 tools/perf/util/event.c                            | 22 +++-------------------
 tools/perf/util/evsel.c                            |  3 +++
 tools/perf/util/pmu.c                              | 13 +++++++------
 tools/perf/util/srcline.c                          |  3 +++
 12 files changed, 39 insertions(+), 45 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index 86299efa804a..fd23d5778ea1 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -377,6 +377,7 @@ struct kvm_sync_regs {
 
 #define KVM_X86_QUIRK_LINT0_REENABLED	(1 << 0)
 #define KVM_X86_QUIRK_CD_NW_CLEARED	(1 << 1)
+#define KVM_X86_QUIRK_LAPIC_MMIO_HOLE	(1 << 2)
 
 #define KVM_STATE_NESTED_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_RUN_PENDING	0x00000002
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 07548de5c988..251be353f950 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -952,6 +952,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_HPAGE_1M 156
 #define KVM_CAP_NESTED_STATE 157
 #define KVM_CAP_ARM_INJECT_SERROR_ESR 158
+#define KVM_CAP_MSR_PLATFORM_INFO 159
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/tools/lib/api/fs/tracing_path.c b/tools/lib/api/fs/tracing_path.c
index 120037496f77..5afb11b30fca 100644
--- a/tools/lib/api/fs/tracing_path.c
+++ b/tools/lib/api/fs/tracing_path.c
@@ -36,7 +36,7 @@ static const char *tracing_path_tracefs_mount(void)
 
 	__tracing_path_set("", mnt);
 
-	return mnt;
+	return tracing_path;
 }
 
 static const char *tracing_path_debugfs_mount(void)
@@ -49,7 +49,7 @@ static const char *tracing_path_debugfs_mount(void)
 
 	__tracing_path_set("tracing/", mnt);
 
-	return mnt;
+	return tracing_path;
 }
 
 const char *tracing_path_mount(void)
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index f6d1a03c7523..e30d20fb482d 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -833,7 +833,7 @@ ifndef NO_JVMTI
     JDIR=$(shell /usr/sbin/update-java-alternatives -l | head -1 | awk '{print $$3}')
   else
     ifneq (,$(wildcard /usr/sbin/alternatives))
-      JDIR=$(shell alternatives --display java | tail -1 | cut -d' ' -f 5 | sed 's%/jre/bin/java.%%g')
+      JDIR=$(shell /usr/sbin/alternatives --display java | tail -1 | cut -d' ' -f 5 | sed 's%/jre/bin/java.%%g')
     endif
   endif
   ifndef JDIR
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5224ade3d5af..0be411695379 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -635,7 +635,7 @@ $(LIBPERF_IN): prepare FORCE
 $(LIB_FILE): $(LIBPERF_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN) $(LIB_OBJS)
 
-LIBTRACEEVENT_FLAGS += plugin_dir=$(plugindir_SQ)
+LIBTRACEEVENT_FLAGS += plugin_dir=$(plugindir_SQ) 'EXTRA_CFLAGS=$(EXTRA_CFLAGS)' 'LDFLAGS=$(LDFLAGS)'
 
 $(LIBTRACEEVENT): FORCE
 	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) $(OUTPUT)libtraceevent.a
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 76e12bcd1765..b2188e623e22 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -981,6 +981,7 @@ int cmd_report(int argc, const char **argv)
 			.id_index	 = perf_event__process_id_index,
 			.auxtrace_info	 = perf_event__process_auxtrace_info,
 			.auxtrace	 = perf_event__process_auxtrace,
+			.event_update	 = perf_event__process_event_update,
 			.feature	 = process_feature_event,
 			.ordered_events	 = true,
 			.ordering_requires_timestamps = true,
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
index d40498f2cb1e..635c09fda1d9 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
@@ -188,7 +188,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xb",
         "EventName": "UNC_P_FREQ_GE_1200MHZ_CYCLES",
-        "Filter": "filter_band0=1200",
+        "Filter": "filter_band0=12",
         "MetricExpr": "(UNC_P_FREQ_GE_1200MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_1200mhz_cycles %",
         "PerPkg": "1",
@@ -199,7 +199,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_P_FREQ_GE_2000MHZ_CYCLES",
-        "Filter": "filter_band1=2000",
+        "Filter": "filter_band1=20",
         "MetricExpr": "(UNC_P_FREQ_GE_2000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_2000mhz_cycles %",
         "PerPkg": "1",
@@ -210,7 +210,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_P_FREQ_GE_3000MHZ_CYCLES",
-        "Filter": "filter_band2=3000",
+        "Filter": "filter_band2=30",
         "MetricExpr": "(UNC_P_FREQ_GE_3000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_3000mhz_cycles %",
         "PerPkg": "1",
@@ -221,7 +221,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xe",
         "EventName": "UNC_P_FREQ_GE_4000MHZ_CYCLES",
-        "Filter": "filter_band3=4000",
+        "Filter": "filter_band3=40",
         "MetricExpr": "(UNC_P_FREQ_GE_4000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_4000mhz_cycles %",
         "PerPkg": "1",
@@ -232,7 +232,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xb",
         "EventName": "UNC_P_FREQ_GE_1200MHZ_TRANSITIONS",
-        "Filter": "edge=1,filter_band0=1200",
+        "Filter": "edge=1,filter_band0=12",
         "MetricExpr": "(UNC_P_FREQ_GE_1200MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_1200mhz_cycles %",
         "PerPkg": "1",
@@ -243,7 +243,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_P_FREQ_GE_2000MHZ_TRANSITIONS",
-        "Filter": "edge=1,filter_band1=2000",
+        "Filter": "edge=1,filter_band1=20",
         "MetricExpr": "(UNC_P_FREQ_GE_2000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_2000mhz_cycles %",
         "PerPkg": "1",
@@ -254,7 +254,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_P_FREQ_GE_3000MHZ_TRANSITIONS",
-        "Filter": "edge=1,filter_band2=4000",
+        "Filter": "edge=1,filter_band2=30",
         "MetricExpr": "(UNC_P_FREQ_GE_3000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_3000mhz_cycles %",
         "PerPkg": "1",
@@ -265,7 +265,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xe",
         "EventName": "UNC_P_FREQ_GE_4000MHZ_TRANSITIONS",
-        "Filter": "edge=1,filter_band3=4000",
+        "Filter": "edge=1,filter_band3=40",
         "MetricExpr": "(UNC_P_FREQ_GE_4000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_4000mhz_cycles %",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
index 16034bfd06dd..8755693d86c6 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
@@ -187,7 +187,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xb",
         "EventName": "UNC_P_FREQ_GE_1200MHZ_CYCLES",
-        "Filter": "filter_band0=1200",
+        "Filter": "filter_band0=12",
         "MetricExpr": "(UNC_P_FREQ_GE_1200MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_1200mhz_cycles %",
         "PerPkg": "1",
@@ -198,7 +198,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_P_FREQ_GE_2000MHZ_CYCLES",
-        "Filter": "filter_band1=2000",
+        "Filter": "filter_band1=20",
         "MetricExpr": "(UNC_P_FREQ_GE_2000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_2000mhz_cycles %",
         "PerPkg": "1",
@@ -209,7 +209,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_P_FREQ_GE_3000MHZ_CYCLES",
-        "Filter": "filter_band2=3000",
+        "Filter": "filter_band2=30",
         "MetricExpr": "(UNC_P_FREQ_GE_3000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_3000mhz_cycles %",
         "PerPkg": "1",
@@ -220,7 +220,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xe",
         "EventName": "UNC_P_FREQ_GE_4000MHZ_CYCLES",
-        "Filter": "filter_band3=4000",
+        "Filter": "filter_band3=40",
         "MetricExpr": "(UNC_P_FREQ_GE_4000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_4000mhz_cycles %",
         "PerPkg": "1",
@@ -231,7 +231,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xb",
         "EventName": "UNC_P_FREQ_GE_1200MHZ_TRANSITIONS",
-        "Filter": "edge=1,filter_band0=1200",
+        "Filter": "edge=1,filter_band0=12",
         "MetricExpr": "(UNC_P_FREQ_GE_1200MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_1200mhz_cycles %",
         "PerPkg": "1",
@@ -242,7 +242,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_P_FREQ_GE_2000MHZ_TRANSITIONS",
-        "Filter": "edge=1,filter_band1=2000",
+        "Filter": "edge=1,filter_band1=20",
         "MetricExpr": "(UNC_P_FREQ_GE_2000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_2000mhz_cycles %",
         "PerPkg": "1",
@@ -253,7 +253,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_P_FREQ_GE_3000MHZ_TRANSITIONS",
-        "Filter": "edge=1,filter_band2=4000",
+        "Filter": "edge=1,filter_band2=30",
         "MetricExpr": "(UNC_P_FREQ_GE_3000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_3000mhz_cycles %",
         "PerPkg": "1",
@@ -264,7 +264,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xe",
         "EventName": "UNC_P_FREQ_GE_4000MHZ_TRANSITIONS",
-        "Filter": "edge=1,filter_band3=4000",
+        "Filter": "edge=1,filter_band3=40",
         "MetricExpr": "(UNC_P_FREQ_GE_4000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_4000mhz_cycles %",
         "PerPkg": "1",
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 0cd42150f712..bc646185f8d9 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1081,6 +1081,7 @@ void *cpu_map_data__alloc(struct cpu_map *map, size_t *size, u16 *type, int *max
 	}
 
 	*size += sizeof(struct cpu_map_data);
+	*size = PERF_ALIGN(*size, sizeof(u64));
 	return zalloc(*size);
 }
 
@@ -1560,26 +1561,9 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 
 		return NULL;
 	}
-try_again:
+
 	al->map = map_groups__find(mg, al->addr);
-	if (al->map == NULL) {
-		/*
-		 * If this is outside of all known maps, and is a negative
-		 * address, try to look it up in the kernel dso, as it might be
-		 * a vsyscall or vdso (which executes in user-mode).
-		 *
-		 * XXX This is nasty, we should have a symbol list in the
-		 * "[vdso]" dso, but for now lets use the old trick of looking
-		 * in the whole kernel symbol list.
-		 */
-		if (cpumode == PERF_RECORD_MISC_USER && machine &&
-		    mg != &machine->kmaps &&
-		    machine__kernel_ip(machine, al->addr)) {
-			mg = &machine->kmaps;
-			load_map = true;
-			goto try_again;
-		}
-	} else {
+	if (al->map != NULL) {
 		/*
 		 * Kernel maps might be changed when loading symbols so loading
 		 * must be done prior to using kernel maps.
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1a61628a1c12..e596ae358c4d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1089,6 +1089,9 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 		attr->exclude_user   = 1;
 	}
 
+	if (evsel->own_cpus)
+		evsel->attr.read_format |= PERF_FORMAT_ID;
+
 	/*
 	 * Apply event specific term settings,
 	 * it overloads any global configuration.
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index afd68524ffa9..7799788f662f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -930,13 +930,14 @@ static void pmu_format_value(unsigned long *format, __u64 value, __u64 *v,
 
 static __u64 pmu_format_max_value(const unsigned long *format)
 {
-	__u64 w = 0;
-	int fbit;
-
-	for_each_set_bit(fbit, format, PERF_PMU_FORMAT_BITS)
-		w |= (1ULL << fbit);
+	int w;
 
-	return w;
+	w = bitmap_weight(format, PERF_PMU_FORMAT_BITS);
+	if (!w)
+		return 0;
+	if (w < 64)
+		return (1ULL << w) - 1;
+	return -1;
 }
 
 /*
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 09d6746e6ec8..e767c4a9d4d2 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -85,6 +85,9 @@ static struct symbol *new_inline_sym(struct dso *dso,
 	struct symbol *inline_sym;
 	char *demangled = NULL;
 
+	if (!funcname)
+		funcname = "??";
+
 	if (dso) {
 		demangled = dso__demangle_sym(dso, 0, funcname);
 		if (demangled)
