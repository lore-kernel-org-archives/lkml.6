Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2323C5CFC2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95AC320864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95AC320864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935666AbeFRIUT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:20:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55042 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935637AbeFRIUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:20:17 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5A3C1C84;
        Mon, 18 Jun 2018 08:20:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Agustin Vega-Frias <agustinv@codeaurora.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 095/279] perf pmu: Fix core PMU alias list for X86 platform
Date:   Mon, 18 Jun 2018 10:11:20 +0200
Message-Id: <20180618080612.733313790@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit 292c34c10249c64a70def442f0d977bf9d466ed7 ]

When counting uncore event with alias, core event is mistakenly
involved, for example:

  perf stat --no-merge -e "unc_m_cas_count.all" -C0  sleep 1

  Performance counter stats for 'CPU(s) 0':

                 0      unc_m_cas_count.all [uncore_imc_4]
                 0      unc_m_cas_count.all [uncore_imc_2]
                 0      unc_m_cas_count.all [uncore_imc_0]
           153,640      unc_m_cas_count.all [cpu]
                 0      unc_m_cas_count.all [uncore_imc_5]
            25,026      unc_m_cas_count.all [uncore_imc_3]
                 0      unc_m_cas_count.all [uncore_imc_1]

       1.001447890 seconds time elapsed

The reason is that current implementation doesn't check PMU name of a
event when adding its alias into the alias list for core PMU. The
uncore event aliases are mistakenly added.

This bug was introduced in:
  commit 14b22ae028de ("perf pmu: Add helper function is_pmu_core to
  detect PMU CORE devices")

Checking the PMU name for all PMUs on X86 and other architectures except
ARM.
There is no behavior change for ARM.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will.deacon@arm.com>
Fixes: 14b22ae028de ("perf pmu: Add helper function is_pmu_core to detect PMU CORE devices")
Link: http://lkml.kernel.org/r/1524594014-79243-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/pmu.c |   20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -539,9 +539,10 @@ static bool pmu_is_uncore(const char *na
 
 /*
  *  PMU CORE devices have different name other than cpu in sysfs on some
- *  platforms. looking for possible sysfs files to identify as core device.
+ *  platforms.
+ *  Looking for possible sysfs files to identify the arm core device.
  */
-static int is_pmu_core(const char *name)
+static int is_arm_pmu_core(const char *name)
 {
 	struct stat st;
 	char path[PATH_MAX];
@@ -550,12 +551,6 @@ static int is_pmu_core(const char *name)
 	if (!sysfs)
 		return 0;
 
-	/* Look for cpu sysfs (x86 and others) */
-	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/cpu", sysfs);
-	if ((stat(path, &st) == 0) &&
-			(strncmp(name, "cpu", strlen("cpu")) == 0))
-		return 1;
-
 	/* Look for cpu sysfs (specific to arm) */
 	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/cpus",
 				sysfs, name);
@@ -651,6 +646,7 @@ static void pmu_add_cpu_aliases(struct l
 	struct pmu_events_map *map;
 	struct pmu_event *pe;
 	const char *name = pmu->name;
+	const char *pname;
 
 	map = perf_pmu__find_map(pmu);
 	if (!map)
@@ -669,11 +665,9 @@ static void pmu_add_cpu_aliases(struct l
 			break;
 		}
 
-		if (!is_pmu_core(name)) {
-			/* check for uncore devices */
-			if (pe->pmu == NULL)
-				continue;
-			if (strncmp(pe->pmu, name, strlen(pe->pmu)))
+		if (!is_arm_pmu_core(name)) {
+			pname = pe->pmu ? pe->pmu : "cpu";
+			if (strncmp(pname, name, strlen(pname)))
 				continue;
 		}
 


