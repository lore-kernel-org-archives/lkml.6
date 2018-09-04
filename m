Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E64C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 03:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C13720869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 03:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C13720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeIDH2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:28:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:11453 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbeIDH2v (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:28:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 20:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,327,1531810800"; 
   d="scan'208";a="87370933"
Received: from skl.sh.intel.com ([10.239.161.125])
  by orsmga001.jf.intel.com with ESMTP; 03 Sep 2018 20:05:46 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        eranian@google.com, kan.liang@intel.com, jolsa@kernel.org
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2] perf/x86/intel/uncore: Provide alias for IIO free-running boxes on SKX
Date:   Tue,  4 Sep 2018 18:58:17 +0800
Message-Id: <1536058697-22003-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Skylake Server, Linux has supported a number of free running
counters that collect counts of IO clocks/Bandwidth/Utilization.

For example, to collect the inbound bandwidth,

root@skx /sys/devices# ls | grep uncore_iio
uncore_iio_0
uncore_iio_1
uncore_iio_2
uncore_iio_3
uncore_iio_4
uncore_iio_5
uncore_iio_free_running_0
uncore_iio_free_running_1
uncore_iio_free_running_2
uncore_iio_free_running_3
uncore_iio_free_running_4
uncore_iio_free_running_5

root@skx /sys/devices# perf stat -a -e uncore_iio_free_running_2/bw_in_port0/
^C
 Performance counter stats for 'system wide':

            153.19 MiB  uncore_iio_free_running_2/bw_in_port0/

       8.037701069 seconds time elapsed

While it's hard for user to understanding what the box the
uncore_iio_free_running_N means.

This patch provides aliases for the boxes. With this patch,
for example,

root@skx /sys/devices# ls | grep uncore_iio
uncore_iio_0
uncore_iio_1
uncore_iio_2
uncore_iio_3
uncore_iio_4
uncore_iio_5
uncore_iio_cbdma
uncore_iio_mcp0
uncore_iio_mcp1
uncore_iio_pcie0
uncore_iio_pcie1
uncore_iio_pcie2

root@skx ~# perf stat -a -e uncore_iio_pcie1/bw_in_port0/
^C
 Performance counter stats for 'system wide':

            153.12 MiB  uncore_iio_pcie1/bw_in_port0/

       8.469790720 seconds time elapsed

v2:
---
Previously, it used braces around initialized string. For example,
{ "iio_cbdma" }.

The braces around scalar initializer would cause the build warning.
In v2, it removes the braces.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 arch/x86/events/intel/uncore.c       |  9 +++++++--
 arch/x86/events/intel/uncore.h       |  1 +
 arch/x86/events/intel/uncore_snbep.c | 10 ++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 27a4614..6c6615f 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -812,8 +812,13 @@ static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
 		else
 			sprintf(pmu->name, "uncore");
 	} else {
-		sprintf(pmu->name, "uncore_%s_%d", pmu->type->name,
-			pmu->pmu_idx);
+		if (pmu->type->alias && pmu->pmu_idx < pmu->type->num_boxes) {
+			sprintf(pmu->name, "uncore_%s",
+				pmu->type->alias[pmu->pmu_idx]);
+		} else {
+			sprintf(pmu->name, "uncore_%s_%d", pmu->type->name,
+				pmu->pmu_idx);
+		}
 	}
 
 	ret = perf_pmu_register(&pmu->pmu, pmu->name, -1);
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index e17ab88..db9fd9a 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -44,6 +44,7 @@ struct freerunning_counters;
 
 struct intel_uncore_type {
 	const char *name;
+	const char **alias;
 	int num_counters;
 	int num_boxes;
 	int perf_ctr_bits;
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 51d7c11..75f14a3 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3596,8 +3596,18 @@ static const struct attribute_group skx_uncore_iio_freerunning_format_group = {
 	.attrs = skx_uncore_iio_freerunning_formats_attr,
 };
 
+static const char *skx_uncore_iio_free_running_aliases[] = {
+	"iio_cbdma",
+	"iio_pcie0",
+	"iio_pcie1",
+	"iio_pcie2",
+	"iio_mcp0",
+	"iio_mcp1",
+};
+
 static struct intel_uncore_type skx_uncore_iio_free_running = {
 	.name			= "iio_free_running",
+	.alias			= skx_uncore_iio_free_running_aliases,
 	.num_counters		= 17,
 	.num_boxes		= 6,
 	.num_freerunning_types	= SKX_IIO_FREERUNNING_TYPE_MAX,
-- 
2.7.4

