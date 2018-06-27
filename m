Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0709AC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A556625914
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A556625914
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965631AbeF0Uqc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 16:46:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965010AbeF0Uqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 16:46:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 793A04075757;
        Wed, 27 Jun 2018 20:46:30 +0000 (UTC)
Received: from krava (ovpn-204-52.brq.redhat.com [10.40.204.52])
        by smtp.corp.redhat.com (Postfix) with SMTP id 403ED1C672;
        Wed, 27 Jun 2018 20:46:25 +0000 (UTC)
Date:   Wed, 27 Jun 2018 22:46:25 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Tvrtko Ursulin <tursulin@ursulin.net>
Cc:     linux-kernel@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        x86@kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC 0/4] perf: Per PMU access controls (paranoid setting)
Message-ID: <20180627204625.GD18152@krava>
References: <20180626153642.5587-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626153642.5587-1-tvrtko.ursulin@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 27 Jun 2018 20:46:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 27 Jun 2018 20:46:30 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 04:36:38PM +0100, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> 
> For situations where sysadmins might want to allow different level of
> access control for different PMUs, we start creating per-PMU
> perf_event_paranoid controls in sysfs.
> 
> These work in equivalent fashion as the existing perf_event_paranoid
> sysctl, which now becomes the parent control for each PMU.
> 
> On PMU registration the global/parent value will be inherited by each PMU,
> as it will be propagated to all registered PMUs when the sysctl is
> updated.
> 
> At any later point individual PMU access controls, located in
> <sysfs>/device/<pmu-name>/perf_event_paranoid, can be adjusted to achieve
> fine grained access control.
> 
> Discussion from previous posting:
> https://lkml.org/lkml/2018/5/21/156
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: x86@kernel.org
> 
> Tvrtko Ursulin (4):
>   perf: Move some access checks later in perf_event_open
>   perf: Pass pmu pointer to perf_paranoid_* helpers
>   perf: Allow per PMU access control
>   perf Documentation: Document the per PMU perf_event_paranoid interface

I think we'll need some perf tool changes for this

apart from the hint/docs, that checks/display paranoid value,
I think we need some changes in arch related code like below
(untested)

jirka


---
diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 2f595cd73da6..a5437f100ab9 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -69,7 +69,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
 	struct perf_evsel *evsel, *cs_etm_evsel = NULL;
 	const struct cpu_map *cpus = evlist->cpus;
-	bool privileged = (geteuid() == 0 || perf_event_paranoid() < 0);
+	bool privileged = (geteuid() == 0 || cs_etm_pmu->paranoid < 0);
 
 	ptr->evlist = evlist;
 	ptr->snapshot_mode = opts->auxtrace_snapshot_mode;
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 1120e39c1b00..89d3d27ed8be 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -65,7 +65,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 			container_of(itr, struct arm_spe_recording, itr);
 	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
 	struct perf_evsel *evsel, *arm_spe_evsel = NULL;
-	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
+	bool privileged = geteuid() == 0 || arm_spe_pmu->paranoid < 0;
 	struct perf_evsel *tracking_evsel;
 	int err;
 
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 781df40b2966..c97e6556c8e7 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -116,7 +116,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 	struct perf_pmu *intel_bts_pmu = btsr->intel_bts_pmu;
 	struct perf_evsel *evsel, *intel_bts_evsel = NULL;
 	const struct cpu_map *cpus = evlist->cpus;
-	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
+	bool privileged = geteuid() == 0 || intel_bts_pmu->paranoid < 0;
 
 	btsr->evlist = evlist;
 	btsr->snapshot_mode = opts->auxtrace_snapshot_mode;
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index db0ba8caf5a2..ffbe5f7f1c57 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -555,7 +555,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	bool have_timing_info, need_immediate = false;
 	struct perf_evsel *evsel, *intel_pt_evsel = NULL;
 	const struct cpu_map *cpus = evlist->cpus;
-	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
+	bool privileged = geteuid() == 0 || intel_pt_pmu->paranoid < 0;
 	u64 tsc_bit;
 	int err;
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d2fb597c9a8c..f2a91305a8b6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -450,6 +450,20 @@ static int pmu_type(const char *name, __u32 *type)
 	return ret;
 }
 
+static int pmu_paranoid(const char *name)
+{
+	char path[PATH_MAX];
+	int paranoid;
+
+	snprintf(path, PATH_MAX,
+                 EVENT_SOURCE_DEVICE_PATH "%s/perf_event_paranoid", name);
+
+	if (!sysfs__read_int(EVENT_SOURCE_DEVICE_PATH, &paranoid))
+		return paranoid;
+
+	return perf_event_paranoid();
+}
+
 /* Add all pmus in sysfs to pmu list: */
 static void pmu_read_sysfs(void)
 {
@@ -736,6 +750,7 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	pmu->name = strdup(name);
 	pmu->type = type;
 	pmu->is_uncore = pmu_is_uncore(name);
+	pmu->paranoid = pmu_paranoid(name);
 	pmu_add_cpu_aliases(&aliases, pmu);
 
 	INIT_LIST_HEAD(&pmu->format);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 76fecec7b3f9..1f00c8bbdb90 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -30,6 +30,7 @@ struct perf_pmu {
 	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
 	struct list_head list;    /* ELEM */
 	int (*set_drv_config)	(struct perf_evsel_config_term *term);
+	int paranoid;
 };
 
 struct perf_pmu_info {
