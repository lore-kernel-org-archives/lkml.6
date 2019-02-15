Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E70C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53180222E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191572;
	bh=iESVCTfjmOAVW2/GAmSXmivh0d2stbHK9PfF6UuuBdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iG3Q16/OrrKRuc12lulBG3TdpmUY8GsxHZH0g8p1m6T52UtsOIlxR1n70ogcBNEVB
	 yYG+xw9SKPZs2BCWkgJq8EBF24Dv2I3ELS2Q8KBDdglfzqbKylbx1YY2c2LPjKU7bY
	 7VtoRvns5ZG5LTck3xAQnI7KgKuNX6CUwcyzUyE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfBOAqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:46:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730375AbfBOAqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:46:08 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C11921B68;
        Fri, 15 Feb 2019 00:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191567;
        bh=iESVCTfjmOAVW2/GAmSXmivh0d2stbHK9PfF6UuuBdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vsleGozuDi9+tSIcgPVdF/FG6IXxkP0j52ZCTrBpeQbY7ymlH7kVCMctVWNq6xyV0
         1AyQ6/qRv08tEjvqxePnX5xsUG8S7skrFB1cVB5SR3loYNfFbFTP0q903nVno+PC15
         FO/BjLoI3vuhCtogtEnEIWTfsf6vlkpoygiDRqus=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Paul Clarke <pc@us.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Carl Love <cel@us.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/43] perf vendor events power8: Cpi_breakdown & estimated_dcache_miss_cpi metrics
Date:   Thu, 14 Feb 2019 21:45:00 -0300
Message-Id: <20190215004539.23571-5-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Clarke <pc@us.ibm.com>

POWER8 metrics are not well publicized.

Some are here:

  https://www.ibm.com/support/knowledgecenter/en/SSFK5S_2.2.0/com.ibm.cluster.pedev.v2r2.pedev100.doc/bl7ug_derivedmetricspower8.htm

This patch is for metric groups:
- cpi_breakdown
- estimated_dcache_miss_cpi

Signed-off-by: Paul Clarke <pc@us.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Carl Love <cel@us.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20190207175314.31813-2-pc@us.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arch/powerpc/power8/metrics.json          | 461 ++++++++++++++++++
 1 file changed, 461 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power8/metrics.json

diff --git a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
new file mode 100644
index 000000000000..377b76226c08
--- /dev/null
+++ b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
@@ -0,0 +1,461 @@
+[
+    {
+        "BriefDescription": "Cycles stalled due to CRU or BRU operations",
+        "MetricExpr": "PM_CMPLU_STALL_BRU_CRU / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "bru_cru_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled due to ISU Branch Operations",
+        "MetricExpr": "PM_CMPLU_STALL_BRU / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "bru_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles in which a Group Completed",
+        "MetricExpr": "PM_GRP_CMPL / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "completion_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by CO queue full",
+        "MetricExpr": "PM_CMPLU_STALL_COQ_FULL / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "coq_full_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled due to CRU Operations",
+        "MetricExpr": "(PM_CMPLU_STALL_BRU_CRU - PM_CMPLU_STALL_BRU) / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "cru_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by flushes",
+        "MetricExpr": "PM_CMPLU_STALL_FLUSH / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "flush_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by FXU Multi-Cycle Instructions",
+        "MetricExpr": "PM_CMPLU_STALL_FXLONG / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "fxu_multi_cyc_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by FXU",
+        "MetricExpr": "PM_CMPLU_STALL_FXU / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "fxu_stall_cpi"
+    },
+    {
+        "BriefDescription": "Other cycles stalled by FXU",
+        "MetricExpr": "(PM_CMPLU_STALL_FXU / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_FXLONG / PM_RUN_INST_CMPL)",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "fxu_stall_other_cpi"
+    },
+    {
+        "BriefDescription": "Cycles GCT empty due to Branch Mispredicts",
+        "MetricExpr": "PM_GCT_NOSLOT_BR_MPRED / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_br_mpred_cpi"
+    },
+    {
+        "BriefDescription": "Cycles GCT empty due to Branch Mispredicts and Icache Misses",
+        "MetricExpr": "PM_GCT_NOSLOT_BR_MPRED_ICMISS / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_br_mpred_ic_miss_cpi"
+    },
+    {
+        "BriefDescription": "GCT empty cycles",
+        "MetricExpr": "PM_GCT_NOSLOT_CYC / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_cpi"
+    },
+    {
+        "BriefDescription": "Cycles GCT empty where dispatch was held",
+        "MetricExpr": "(PM_GCT_NOSLOT_DISP_HELD_MAP + PM_GCT_NOSLOT_DISP_HELD_SRQ + PM_GCT_NOSLOT_DISP_HELD_ISSQ + PM_GCT_NOSLOT_DISP_HELD_OTHER) / PM_RUN_INST_CMPL)",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_disp_held_cpi"
+    },
+    {
+        "BriefDescription": "Cycles GCT empty where dispatch was held due to issue queue",
+        "MetricExpr": "PM_GCT_NOSLOT_DISP_HELD_ISSQ / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_disp_held_issq_cpi"
+    },
+    {
+        "BriefDescription": "Cycles GCT empty where dispatch was held due to maps",
+        "MetricExpr": "PM_GCT_NOSLOT_DISP_HELD_MAP / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_disp_held_map_cpi"
+    },
+    {
+        "BriefDescription": "Cycles GCT empty where dispatch was held due to syncs and other effects",
+        "MetricExpr": "PM_GCT_NOSLOT_DISP_HELD_OTHER / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_disp_held_other_cpi"
+    },
+    {
+        "BriefDescription": "Cycles GCT empty where dispatch was held due to SRQ",
+        "MetricExpr": "PM_GCT_NOSLOT_DISP_HELD_SRQ / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_disp_held_srq_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by GCT empty due to Icache misses",
+        "MetricExpr": "PM_GCT_NOSLOT_IC_MISS  / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_ic_miss_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by GCT empty due to Icache misses that resolve in the local L2 or L3",
+        "MetricExpr": "(PM_GCT_NOSLOT_IC_MISS - PM_GCT_NOSLOT_IC_L3MISS) / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_ic_miss_l2l3_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by GCT empty due to Icache misses that resolve off-chip",
+        "MetricExpr": "PM_GCT_NOSLOT_IC_L3MISS / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_ic_miss_l3miss_cpi"
+    },
+    {
+        "BriefDescription": "Other GCT empty cycles",
+        "MetricExpr": "(PM_GCT_NOSLOT_CYC / PM_RUN_INST_CMPL) - (PM_GCT_NOSLOT_IC_MISS  / PM_RUN_INST_CMPL) - (PM_GCT_NOSLOT_BR_MPRED / PM_RUN_INST_CMPL) - (PM_GCT_NOSLOT_BR_MPRED_ICMISS / PM_RUN_INST_CMPL) - ((PM_GCT_NOSLOT_DISP_HELD_MAP / PM_RUN_INST_CMPL) + (PM_GCT_NOSLOT_DISP_HELD_SRQ / PM_RUN_INST_CMPL) + (PM_GCT_NOSLOT_DISP_HELD_ISSQ / PM_RUN_INST_CMPL) + (PM_GCT_NOSLOT_DISP_HELD_OTHER / PM_RUN_INST_CMPL))",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "gct_empty_other_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by heavyweight syncs",
+        "MetricExpr": "PM_CMPLU_STALL_HWSYNC  / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "hwsync_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by LSU",
+        "MetricExpr": "PM_CMPLU_STALL_LSU / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by D-Cache Misses",
+        "MetricExpr": "PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_dcache_miss_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by D-Cache Misses that resolved in distant interventions and memory",
+        "MetricExpr": "(PM_CMPLU_STALL_DMISS_L3MISS - PM_CMPLU_STALL_DMISS_LMEM - PM_CMPLU_STALL_DMISS_L21_L31 - PM_CMPLU_STALL_DMISS_REMOTE) / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_dcache_miss_distant_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by D-Cache Misses that resolved in remote or distant caches",
+        "MetricExpr": "PM_CMPLU_STALL_DMISS_L21_L31 / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_dcache_miss_l21l31_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by D-Cache Misses that resolved in the local L2 or L3, where there was a conflict",
+        "MetricExpr": "PM_CMPLU_STALL_DMISS_L2L3_CONFLICT / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_dcache_miss_l2l3_conflict_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by D-Cache Misses that resolved in the local L2 or L3",
+        "MetricExpr": "PM_CMPLU_STALL_DMISS_L2L3 / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_dcache_miss_l2l3_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by D-Cache Misses that resolved in the local L2 or L3, where there was no conflict",
+        "MetricExpr": "(PM_CMPLU_STALL_DMISS_L2L3 - PM_CMPLU_STALL_DMISS_L2L3_CONFLICT) / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_dcache_miss_l2l3_noconflict_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by D-Cache Misses that resolved in other core's caches or memory",
+        "MetricExpr": "PM_CMPLU_STALL_DMISS_L3MISS / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_dcache_miss_l3miss_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by D-Cache Misses that resolved in local memory or local L4",
+        "MetricExpr": "PM_CMPLU_STALL_DMISS_LMEM / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_dcache_miss_lmem_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by D-Cache Misses that resolved in remote interventions and memory",
+        "MetricExpr": "PM_CMPLU_STALL_DMISS_REMOTE / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_dcache_miss_remote_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by ERAT Translation rejects",
+        "MetricExpr": "PM_CMPLU_STALL_ERAT_MISS / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_erat_miss_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by LSU load finishes",
+        "MetricExpr": "PM_CMPLU_STALL_LOAD_FINISH / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_ld_fin_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by LHS rejects",
+        "MetricExpr": "PM_CMPLU_STALL_REJECT_LHS / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_lhs_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by LMQ Full rejects",
+        "MetricExpr": "PM_CMPLU_STALL_REJ_LMQ_FULL / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_lmq_full_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by Other LSU Operations",
+        "MetricExpr": "(PM_CMPLU_STALL_LSU / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_REJECT / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_STORE / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_LOAD_FINISH / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_ST_FWD / PM_RUN_INST_CMPL)",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_other_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by LSU Rejects",
+        "MetricExpr": "PM_CMPLU_STALL_REJECT / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_reject_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by Other LSU Rejects",
+        "MetricExpr": "(PM_CMPLU_STALL_REJECT / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_REJECT_LHS / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_ERAT_MISS / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_REJ_LMQ_FULL / PM_RUN_INST_CMPL)",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_reject_other_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by LSU store forwarding",
+        "MetricExpr": "PM_CMPLU_STALL_ST_FWD / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_st_fwd_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by LSU Stores",
+        "MetricExpr": "PM_CMPLU_STALL_STORE / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_store_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by lightweight syncs",
+        "MetricExpr": "PM_CMPLU_STALL_LWSYNC / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lwsync_stall_cpi"
+    },
+    {
+        "MetricExpr": "PM_CMPLU_STALL_MEM_ECC_DELAY / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "mem_ecc_delay_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by nops (nothing next to finish)",
+        "MetricExpr": "PM_CMPLU_STALL_NO_NTF / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "no_ntf_stall_cpi"
+    },
+    {
+        "MetricExpr": "PM_NTCG_ALL_FIN / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "ntcg_all_fin_cpi"
+    },
+    {
+        "MetricExpr": "PM_CMPLU_STALL_NTCG_FLUSH / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "ntcg_flush_cpi"
+    },
+    {
+        "BriefDescription": "Other thread block stall cycles",
+        "MetricExpr": "(PM_CMPLU_STALL_THRD - PM_CMPLU_STALL_LWSYNC - PM_CMPLU_STALL_HWSYNC - PM_CMPLU_STALL_MEM_ECC_DELAY - PM_CMPLU_STALL_FLUSH - PM_CMPLU_STALL_COQ_FULL)  / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "other_block_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles unaccounted for",
+        "MetricExpr": "(PM_RUN_CYC / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL / PM_RUN_INST_CMPL) - (PM_GCT_NOSLOT_CYC / PM_RUN_INST_CMPL) - (PM_NTCG_ALL_FIN / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_THRD / PM_RUN_INST_CMPL) -  (PM_GRP_CMPL / PM_RUN_INST_CMPL)",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "other_cpi"
+    },
+    {
+        "BriefDescription": "Stall cycles unaccounted for",
+        "MetricExpr": "(PM_CMPLU_STALL / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_BRU_CRU / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_FXU / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_VSU / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_LSU / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_NTCG_FLUSH / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_NO_NTF / PM_RUN_INST_CMPL)",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "other_stall_cpi"
+    },
+    {
+        "BriefDescription": "Run cycles per run instruction",
+        "MetricExpr": "PM_RUN_CYC / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "run_cpi"
+    },
+    {
+        "BriefDescription": "Completion Stall Cycles",
+        "MetricExpr": "PM_CMPLU_STALL / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles a thread was blocked",
+        "MetricExpr": "PM_CMPLU_STALL_THRD / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "thread_block_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by VSU",
+        "MetricExpr": "PM_CMPLU_STALL_VSU / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "vsu_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by other VSU Operations",
+        "MetricExpr": "(PM_CMPLU_STALL_VSU - PM_CMPLU_STALL_VECTOR - PM_CMPLU_STALL_SCALAR) / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "vsu_stall_other_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by VSU Scalar Operations",
+        "MetricExpr": "PM_CMPLU_STALL_SCALAR / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "vsu_stall_scalar_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by VSU Scalar Long Operations",
+        "MetricExpr": "PM_CMPLU_STALL_SCALAR_LONG / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "vsu_stall_scalar_long_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by Other VSU Scalar Operations",
+        "MetricExpr": "(PM_CMPLU_STALL_SCALAR / PM_RUN_INST_CMPL) - (PM_CMPLU_STALL_SCALAR_LONG / PM_RUN_INST_CMPL)",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "vsu_stall_scalar_other_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by VSU Vector Operations",
+        "MetricExpr": "PM_CMPLU_STALL_VECTOR / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "vsu_stall_vector_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by VSU Vector Long Operations",
+        "MetricExpr": "PM_CMPLU_STALL_VECTOR_LONG / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "vsu_stall_vector_long_cpi"
+    },
+    {
+        "BriefDescription": "Cycles stalled by other VSU Vector Operations",
+        "MetricExpr": "(PM_CMPLU_STALL_VECTOR - PM_CMPLU_STALL_VECTOR_LONG) / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "vsu_stall_vector_other_cpi"
+    },
+    {
+        "BriefDescription": "dL1 miss portion of CPI",
+        "MetricExpr": "( (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)/  (PM_RUN_CYC / PM_RUN_INST_CMPL))  * 100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "dcache_miss_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl2l3 distant MOD miss rates with measured DL2L3 MOD latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_DL2L3_MOD / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_DL2L3_MOD_CYC/ PM_MRK_DATA_FROM_DL2L3_MOD)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "dl2l3_mod_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl2l3 distant SHR miss rates with measured DL2L3 SHR latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_DL2L3_SHR / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_DL2L3_SHR_CYC/ PM_MRK_DATA_FROM_DL2L3_SHR)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "dl2l3_shr_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of distant L4 miss rates with measured DL4 latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_DL4 / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_DL4_CYC/ PM_MRK_DATA_FROM_DL4)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "dl4_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of distant memory miss rates with measured DMEM latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_DMEM / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_DMEM_CYC/ PM_MRK_DATA_FROM_DMEM)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "dmem_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl21 MOD miss rates with measured L21 MOD latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_L21_MOD / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_L21_MOD_CYC/ PM_MRK_DATA_FROM_L21_MOD)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "l21_mod_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl21 SHR miss rates with measured L21 SHR latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_L21_SHR / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_L21_SHR_CYC/ PM_MRK_DATA_FROM_L21_SHR)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "l21_shr_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl2 miss rates with measured L2 latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_L2  / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_L2_CYC/ PM_MRK_DATA_FROM_L2)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL) ) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "l2_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl31 MOD miss rates with measured L31 MOD latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_L31_MOD / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_L31_MOD_CYC/ PM_MRK_DATA_FROM_L31_MOD)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "l31_mod_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl31 SHR miss rates with measured L31 SHR latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_L31_SHR / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_L31_SHR_CYC/ PM_MRK_DATA_FROM_L31_SHR)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "l31_shr_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl3 miss rates with measured L3 latency as a % of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_L3  / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_L3_CYC/ PM_MRK_DATA_FROM_L3)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) * 100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "l3_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of Local L4 miss rates with measured LL4 latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_LL4 / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_LL4_CYC/ PM_MRK_DATA_FROM_LL4)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "ll4_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of Local memory miss rates with measured LMEM latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_LMEM / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_LMEM_CYC/ PM_MRK_DATA_FROM_LMEM)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "lmem_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl2l3 remote MOD miss rates with measured RL2L3 MOD latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_RL2L3_MOD / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_RL2L3_MOD_CYC/ PM_MRK_DATA_FROM_RL2L3_MOD)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "rl2l3_mod_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl2l3 shared miss rates with measured RL2L3 SHR latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_RL2L3_SHR / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_RL2L3_SHR_CYC/ PM_MRK_DATA_FROM_RL2L3_SHR)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) * 100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "rl2l3_shr_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of remote L4 miss rates with measured RL4 latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_RL4 / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_RL4_CYC/ PM_MRK_DATA_FROM_RL4)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "rl4_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of remote memory miss rates with measured RMEM latency as a %of dcache miss cpi",
+        "MetricExpr": "(((PM_DATA_FROM_RMEM / PM_RUN_INST_CMPL) * (PM_MRK_DATA_FROM_RMEM_CYC/ PM_MRK_DATA_FROM_RMEM)) / (PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL)) *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "rmem_cpi_percent"
+    }
+]
-- 
2.19.1

