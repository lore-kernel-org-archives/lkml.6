Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FDEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD84222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191581;
	bh=TdL6yxTa+oPYd+nGvaqWX9pSi6zg5Q4kqznm0zbrZaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yvqpm4jNSGM6/0gkTOEKLxq101HMcHWBDtL75w5AWaYmQEa/t++J2ef3VrTSzulmJ
	 k22U95D3ATMsVFXRHKGrJPTsZ5lfO6xH+6AFLynA7vJkMXUEDaOmBwj8MOUq81FVdp
	 M6txAmY1hXp1BcY/MZRvrjKvUqU87s/PJnfFYlHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388363AbfBOAqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:46:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388327AbfBOAqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:46:17 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7664B222D0;
        Fri, 15 Feb 2019 00:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191576;
        bh=TdL6yxTa+oPYd+nGvaqWX9pSi6zg5Q4kqznm0zbrZaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IzxTD/3k0Lgjtq+sWHE6LjmWrYCGE1PV5Qn7JprL+/aHfZDkCI2d5hyaVqCoW4XCo
         JQ0fVWbPBfqh0iQ1HqTpaaO3wfUQkteY6vZ+MQ0GqhxFe30HGusreGdjaT055FIwAY
         nBrYpsiBo4pyw34gc7blIwB0HEVcWz+WKzxkhBRs=
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
Subject: [PATCH 06/43] perf vendor events power8: Branch_prediction, latency, bus_stats, instruction_mix & instruction_stats metrics
Date:   Thu, 14 Feb 2019 21:45:02 -0300
Message-Id: <20190215004539.23571-7-acme@kernel.org>
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

POWER8 metrics are not well publicized.  Some are here:

  https://www.ibm.com/support/knowledgecenter/en/SSFK5S_2.2.0/com.ibm.cluster.pedev.v2r2.pedev100.doc/bl7ug_derivedmetricspower8.htm

This patch is for metric groups:
- branch_prediction
- latency
- bus_stats
- instruction_mix
- instruction_stats_percent_per_ref

Signed-off-by: Paul Clarke <pc@us.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Carl Love <cel@us.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20190207175314.31813-4-pc@us.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arch/powerpc/power8/metrics.json          | 492 ++++++++++++++++++
 1 file changed, 492 insertions(+)

diff --git a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
index 9a6ec8aadffd..d8b710e12377 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
@@ -1,4 +1,100 @@
 [
+    {
+        "BriefDescription": "% of finished branches that were treated as BC+8",
+        "MetricExpr": "PM_BR_BC_8_CONV / PM_BRU_FIN * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "bc_8_branch_ratio_percent"
+    },
+    {
+        "BriefDescription": "% of finished branches that were pairable but not treated as BC+8",
+        "MetricExpr": "PM_BR_BC_8 / PM_BRU_FIN * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "bc_8_not_converted_branch_ratio_percent"
+    },
+    {
+        "BriefDescription": "Percent of mispredicted branches out of all predicted (correctly and incorrectly) branches that completed",
+        "MetricExpr": "PM_BR_MPRED_CMPL / (PM_BR_PRED_BR0 + PM_BR_PRED_BR1) * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "br_misprediction_percent"
+    },
+    {
+        "BriefDescription": "% of Branch miss predictions per instruction",
+        "MetricExpr": "PM_BR_MPRED_CMPL / PM_RUN_INST_CMPL * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "branch_mispredict_rate_percent"
+    },
+    {
+        "BriefDescription": "Count cache branch misprediction per instruction",
+        "MetricExpr": "PM_BR_MPRED_CCACHE / PM_RUN_INST_CMPL * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "ccache_mispredict_rate_percent"
+    },
+    {
+        "BriefDescription": "Percent of count catch mispredictions out of all completed branches that required count cache predictionn",
+        "MetricExpr": "PM_BR_MPRED_CCACHE / (PM_BR_PRED_CCACHE_BR0 + PM_BR_PRED_CCACHE_BR1) * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "ccache_misprediction_percent"
+    },
+    {
+        "BriefDescription": "CR MisPredictions per Instruction",
+        "MetricExpr": "PM_BR_MPRED_CR / PM_RUN_INST_CMPL * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "cr_mispredict_rate_percent"
+    },
+    {
+        "BriefDescription": "Link stack branch misprediction",
+        "MetricExpr": "(PM_BR_MPRED_TA - PM_BR_MPRED_CCACHE) / PM_RUN_INST_CMPL * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "lstack_mispredict_rate_percent"
+    },
+    {
+        "BriefDescription": "Percent of link stack mispredictions out of all completed branches that required link stack prediction",
+        "MetricExpr": "(PM_BR_MPRED_TA - PM_BR_MPRED_CCACHE) / (PM_BR_PRED_LSTACK_BR0 + PM_BR_PRED_LSTACK_BR1) * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "lstack_misprediction_percent"
+    },
+    {
+        "BriefDescription": "TA MisPredictions per Instruction",
+        "MetricExpr": "PM_BR_MPRED_TA / PM_RUN_INST_CMPL * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "ta_mispredict_rate_percent"
+    },
+    {
+        "BriefDescription": "Percent of target address mispredictions out of all completed branches that required address prediction",
+        "MetricExpr": "PM_BR_MPRED_TA / (PM_BR_PRED_CCACHE_BR0 + PM_BR_PRED_CCACHE_BR1 + PM_BR_PRED_LSTACK_BR0 + PM_BR_PRED_LSTACK_BR1) * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "ta_misprediction_percent"
+    },
+    {
+        "BriefDescription": "Percent of branches completed that were taken",
+        "MetricExpr": "PM_BR_TAKEN_CMPL * 100 / PM_BR_CMPL",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "taken_branches_percent"
+    },
+    {
+        "BriefDescription": "Percent of chip+group+sys pumps that were incorrectly predicted",
+        "MetricExpr": "PM_PUMP_MPRED * 100 / (PM_PUMP_CPRED + PM_PUMP_MPRED)",
+        "MetricGroup": "bus_stats",
+        "MetricName": "any_pump_mpred_percent"
+    },
+    {
+        "BriefDescription": "Percent of chip pumps that were correctly predicted as chip pumps the first time",
+        "MetricExpr": "PM_CHIP_PUMP_CPRED * 100 / PM_L2_CHIP_PUMP",
+        "MetricGroup": "bus_stats",
+        "MetricName": "chip_pump_cpred_percent"
+    },
+    {
+        "BriefDescription": "Percent of group pumps that were correctly predicted as group pumps the first time",
+        "MetricExpr": "PM_GRP_PUMP_CPRED * 100 / PM_L2_GROUP_PUMP",
+        "MetricGroup": "bus_stats",
+        "MetricName": "group_pump_cpred_percent"
+    },
+    {
+        "BriefDescription": "Percent of system pumps that were correctly predicted as group pumps the first time",
+        "MetricExpr": "PM_SYS_PUMP_CPRED * 100 / PM_L2_GROUP_PUMP",
+        "MetricGroup": "bus_stats",
+        "MetricName": "sys_pump_cpred_percent"
+    },
     {
         "BriefDescription": "Cycles stalled due to CRU or BRU operations",
         "MetricExpr": "PM_CMPLU_STALL_BRU_CRU / PM_RUN_INST_CMPL",
@@ -842,6 +938,180 @@
         "MetricGroup": "instruction_misses_percent_per_inst",
         "MetricName": "l1_inst_miss_rate_percent"
     },
+    {
+        "BriefDescription": "% Branches per instruction",
+        "MetricExpr": "PM_BRU_FIN / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_mix",
+        "MetricName": "branches_per_inst"
+    },
+    {
+        "BriefDescription": "Total Fixed point operations",
+        "MetricExpr": "(PM_FXU0_FIN + PM_FXU1_FIN)/PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_mix",
+        "MetricName": "fixed_per_inst"
+    },
+    {
+        "BriefDescription": "FXU0 balance",
+        "MetricExpr": "PM_FXU0_FIN / (PM_FXU0_FIN + PM_FXU1_FIN)",
+        "MetricGroup": "instruction_mix",
+        "MetricName": "fxu0_balance"
+    },
+    {
+        "BriefDescription": "Fraction of cycles that FXU0 is in use",
+        "MetricExpr": "PM_FXU0_FIN / PM_RUN_CYC",
+        "MetricGroup": "instruction_mix",
+        "MetricName": "fxu0_fin"
+    },
+    {
+        "BriefDescription": "FXU0 only Busy",
+        "MetricExpr": "PM_FXU0_BUSY_FXU1_IDLE / PM_CYC",
+        "MetricGroup": "instruction_mix",
+        "MetricName": "fxu0_only_busy"
+    },
+    {
+        "BriefDescription": "Fraction of cycles that FXU1 is in use",
+        "MetricExpr": "PM_FXU1_FIN / PM_RUN_CYC",
+        "MetricGroup": "instruction_mix",
+        "MetricName": "fxu1_fin"
+    },
+    {
+        "BriefDescription": "FXU1 only Busy",
+        "MetricExpr": "PM_FXU1_BUSY_FXU0_IDLE / PM_CYC",
+        "MetricGroup": "instruction_mix",
+        "MetricName": "fxu1_only_busy"
+    },
+    {
+        "BriefDescription": "Both FXU Busy",
+        "MetricExpr": "PM_FXU_BUSY / PM_CYC",
+        "MetricGroup": "instruction_mix",
+        "MetricName": "fxu_both_busy"
+    },
+    {
+        "BriefDescription": "Both FXU Idle",
+        "MetricExpr": "PM_FXU_IDLE / PM_CYC",
+        "MetricGroup": "instruction_mix",
+        "MetricName": "fxu_both_idle"
+    },
+    {
+        "BriefDescription": "PCT instruction loads",
+        "MetricExpr": "PM_LD_REF_L1 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_mix",
+        "MetricName": "loads_per_inst"
+    },
+    {
+        "BriefDescription": "PCT instruction stores",
+        "MetricExpr": "PM_ST_FIN  / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_mix",
+        "MetricName": "stores_per_inst"
+    },
+    {
+        "BriefDescription": "Icache Fetchs per Icache Miss",
+        "MetricExpr": "(PM_L1_ICACHE_MISS - PM_IC_PREF_WRITE) / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "icache_miss_reload"
+    },
+    {
+        "BriefDescription": "% of ICache reloads due to prefetch",
+        "MetricExpr": "PM_IC_PREF_WRITE * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "icache_pref_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Distant L2 or L3 (Modified)",
+        "MetricExpr": "PM_INST_FROM_DL2L3_MOD * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_dl2l3_mod_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Distant L2 or L3 (Shared)",
+        "MetricExpr": "PM_INST_FROM_DL2L3_SHR * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_dl2l3_shr_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Distant L4",
+        "MetricExpr": "PM_INST_FROM_DL4 * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_dl4_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Distant Memory",
+        "MetricExpr": "PM_INST_FROM_DMEM * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_dmem_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Private L2, other core",
+        "MetricExpr": "PM_INST_FROM_L21_MOD * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_l21_mod_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Private L2, other core",
+        "MetricExpr": "PM_INST_FROM_L21_SHR * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_l21_shr_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from L2",
+        "MetricExpr": "PM_INST_FROM_L2 * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_l2_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Private L3, other core",
+        "MetricExpr": "PM_INST_FROM_L31_MOD * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_l31_mod_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Private L3, other core",
+        "MetricExpr": "PM_INST_FROM_L31_SHR * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_l31_shr_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from L3",
+        "MetricExpr": "PM_INST_FROM_L3 * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_l3_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Local L4",
+        "MetricExpr": "PM_INST_FROM_LL4 * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_ll4_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Local Memory",
+        "MetricExpr": "PM_INST_FROM_LMEM * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_lmem_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Remote L2 or L3 (Modified)",
+        "MetricExpr": "PM_INST_FROM_RL2L3_MOD * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_rl2l3_mod_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Remote L2 or L3 (Shared)",
+        "MetricExpr": "PM_INST_FROM_RL2L3_SHR * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_rl2l3_shr_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Remote L4",
+        "MetricExpr": "PM_INST_FROM_RL4 * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_rl4_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Remote Memory",
+        "MetricExpr": "PM_INST_FROM_RMEM * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_rmem_percent"
+    },
     {
         "BriefDescription": "Average number of stores that gather in the store buffer before being sent to an L2 RC machine",
         "MetricExpr": "PM_ST_CMPL / (PM_L2_ST / 2)",
@@ -860,6 +1130,228 @@
         "MetricGroup": "l2_stats",
         "MetricName": "l2_store_miss_ratio_percent"
     },
+    {
+        "BriefDescription": "average L1 miss latency using marked events",
+        "MetricExpr": "PM_MRK_LD_MISS_L1_CYC  /  PM_MRK_LD_MISS_L1",
+        "MetricGroup": "latency",
+        "MetricName": "average_dl1miss_latency"
+    },
+    {
+        "BriefDescription": "Average icache miss latency",
+        "MetricExpr": "(PM_IC_DEMAND_CYC /  PM_IC_DEMAND_REQ)",
+        "MetricGroup": "latency",
+        "MetricName": "average_il1_miss_latency"
+    },
+    {
+        "BriefDescription": "average service time for SYNC",
+        "MetricExpr": "PM_LSU_SRQ_SYNC_CYC / PM_LSU_SRQ_SYNC",
+        "MetricGroup": "latency",
+        "MetricName": "average_sync_cyc"
+    },
+    {
+        "BriefDescription": "Cycles LMQ slot0 was active on an average",
+        "MetricExpr": "PM_LSU_LMQ_S0_VALID  / PM_LSU_LMQ_S0_ALLOC",
+        "MetricGroup": "latency",
+        "MetricName": "avg_lmq_life_time"
+    },
+    {
+        "BriefDescription": "Average number of cycles LRQ stays active for one load.  Slot 0 is VALID ONLY FOR EVEN THREADS",
+        "MetricExpr": "PM_LSU_LRQ_S0_VALID  / PM_LSU_LRQ_S0_ALLOC",
+        "MetricGroup": "latency",
+        "MetricName": "avg_lrq_life_time_even"
+    },
+    {
+        "BriefDescription": "Average number of cycles LRQ stays active for one load.  Slot 43 is valid ONLY FOR ODD THREADS",
+        "MetricExpr": "PM_LSU_LRQ_S43_VALID  / PM_LSU_LRQ_S43_ALLOC",
+        "MetricGroup": "latency",
+        "MetricName": "avg_lrq_life_time_odd"
+    },
+    {
+        "BriefDescription": "Average number of cycles SRQ stays active for one load.  Slot 0 is VALID ONLY FOR EVEN THREADS",
+        "MetricExpr": "PM_LSU_SRQ_S0_VALID  / PM_LSU_SRQ_S0_ALLOC",
+        "MetricGroup": "latency",
+        "MetricName": "avg_srq_life_time_even"
+    },
+    {
+        "BriefDescription": "Average number of cycles SRQ stays active for one load.  Slot 39 is valid ONLY FOR ODD THREADS",
+        "MetricExpr": "PM_LSU_SRQ_S39_VALID  / PM_LSU_SRQ_S39_ALLOC",
+        "MetricGroup": "latency",
+        "MetricName": "avg_srq_life_time_odd"
+    },
+    {
+        "BriefDescription": "Marked background kill latency, measured in L2",
+        "MetricExpr": "PM_MRK_FAB_RSP_BKILL_CYC / PM_MRK_FAB_RSP_BKILL",
+        "MetricGroup": "latency",
+        "MetricName": "bkill_latency"
+    },
+    {
+        "BriefDescription": "Marked dclaim latency, measured in L2",
+        "MetricExpr": "PM_MRK_FAB_RSP_DCLAIM_CYC / PM_MRK_FAB_RSP_DCLAIM",
+        "MetricGroup": "latency",
+        "MetricName": "dclaim_latency"
+    },
+    {
+        "BriefDescription": "Marked L2L3 remote Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_DL2L3_MOD_CYC/ PM_MRK_DATA_FROM_DL2L3_MOD",
+        "MetricGroup": "latency",
+        "MetricName": "dl2l3_mod_latency"
+    },
+    {
+        "BriefDescription": "Marked L2L3 distant Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_DL2L3_SHR_CYC/ PM_MRK_DATA_FROM_DL2L3_SHR",
+        "MetricGroup": "latency",
+        "MetricName": "dl2l3_shr_latency"
+    },
+    {
+        "BriefDescription": "Distant L4 average load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_DL4_CYC/ PM_MRK_DATA_FROM_DL4",
+        "MetricGroup": "latency",
+        "MetricName": "dl4_latency"
+    },
+    {
+        "BriefDescription": "Marked Dmem Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_DMEM_CYC/ PM_MRK_DATA_FROM_DMEM",
+        "MetricGroup": "latency",
+        "MetricName": "dmem_latency"
+    },
+    {
+        "BriefDescription": "estimated exposed miss latency for dL1 misses, ie load miss when we were NTC",
+        "MetricExpr": "PM_MRK_LD_MISS_EXPOSED_CYC  /  PM_MRK_LD_MISS_EXPOSED",
+        "MetricGroup": "latency",
+        "MetricName": "exposed_dl1miss_latency"
+    },
+    {
+        "BriefDescription": "Average load latency for all marked demand loads that came from L2.1 in the M state",
+        "MetricExpr": "PM_MRK_DATA_FROM_L21_MOD_CYC/ PM_MRK_DATA_FROM_L21_MOD",
+        "MetricGroup": "latency",
+        "MetricName": "l21_mod_latency"
+    },
+    {
+        "BriefDescription": "Average load latency for all marked demand loads that came from L2.1 in the S state",
+        "MetricExpr": "PM_MRK_DATA_FROM_L21_SHR_CYC/ PM_MRK_DATA_FROM_L21_SHR",
+        "MetricGroup": "latency",
+        "MetricName": "l21_shr_latency"
+    },
+    {
+        "BriefDescription": "Average load latency for all marked demand loads that came from the L2 and suffered a conflict at RC machine dispatch time due to load-hit-store",
+        "MetricExpr": "PM_MRK_DATA_FROM_L2_DISP_CONFLICT_LDHITST_CYC/ PM_MRK_DATA_FROM_L2_DISP_CONFLICT_LDHITST",
+        "MetricGroup": "latency",
+        "MetricName": "l2_disp_conflict_ldhitst_latency"
+    },
+    {
+        "BriefDescription": "Average load latency for all marked demand loads that came from the L2 and suffered a conflict at RC machine dispatch time NOT due load-hit-store",
+        "MetricExpr": "PM_MRK_DATA_FROM_L2_DISP_CONFLICT_OTHER_CYC/ PM_MRK_DATA_FROM_L2_DISP_CONFLICT_OTHER",
+        "MetricGroup": "latency",
+        "MetricName": "l2_disp_conflict_other_latency"
+    },
+    {
+        "BriefDescription": "Average load latency for all marked demand loads that came from the L2",
+        "MetricExpr": "PM_MRK_DATA_FROM_L2_CYC/ PM_MRK_DATA_FROM_L2",
+        "MetricGroup": "latency",
+        "MetricName": "l2_latency"
+    },
+    {
+        "BriefDescription": "Average load latency for all marked demand loads that were satisfied by lines prefetched into the L3.  This information is forwarded from the L3",
+        "MetricExpr": "PM_MRK_DATA_FROM_L2_MEPF_CYC/ PM_MRK_DATA_FROM_L2",
+        "MetricGroup": "latency",
+        "MetricName": "l2_mepf_latency"
+    },
+    {
+        "BriefDescription": "Average load latency for all marked demand loads that came from the L2 and suffered no conflicts",
+        "MetricExpr": "PM_MRK_DATA_FROM_L2_NO_CONFLICT_CYC/ PM_MRK_DATA_FROM_L2",
+        "MetricGroup": "latency",
+        "MetricName": "l2_no_conflict_latency"
+    },
+    {
+        "BriefDescription": "Average load latency for all marked demand loads that came from the L3 and beyond",
+        "MetricExpr": "PM_MRK_DATA_FROM_L2MISS_CYC/ PM_MRK_DATA_FROM_L2MISS",
+        "MetricGroup": "latency",
+        "MetricName": "l2miss_latency"
+    },
+    {
+        "BriefDescription": "Marked L31 Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_L31_MOD_CYC/ PM_MRK_DATA_FROM_L31_MOD",
+        "MetricGroup": "latency",
+        "MetricName": "l31_mod_latency"
+    },
+    {
+        "BriefDescription": "Marked L31 Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_L31_SHR_CYC/ PM_MRK_DATA_FROM_L31_SHR",
+        "MetricGroup": "latency",
+        "MetricName": "l31_shr_latency"
+    },
+    {
+        "BriefDescription": "Average load latency for all marked demand loads that came from the L3",
+        "MetricExpr": "PM_MRK_DATA_FROM_L3_CYC/ PM_MRK_DATA_FROM_L3",
+        "MetricGroup": "latency",
+        "MetricName": "l3_latency"
+    },
+    {
+        "BriefDescription": "Average load latency for all marked demand loads that came from the L3 and suffered no conflicts",
+        "MetricExpr": "PM_MRK_DATA_FROM_L3_NO_CONFLICT_CYC/ PM_MRK_DATA_FROM_L2",
+        "MetricGroup": "latency",
+        "MetricName": "l3_no_conflict_latency"
+    },
+    {
+        "BriefDescription": "Average load latency for all marked demand loads that come from beyond the L3",
+        "MetricExpr": "PM_MRK_DATA_FROM_L3MISS_CYC/ PM_MRK_DATA_FROM_L3MISS",
+        "MetricGroup": "latency",
+        "MetricName": "l3miss_latency"
+    },
+    {
+        "BriefDescription": "Average latency for marked reloads that hit in the L3 on the MEPF state.  i.e. lines that were prefetched into the L3",
+        "MetricExpr": "PM_MRK_DATA_FROM_L3_MEPF_CYC/ PM_MRK_DATA_FROM_L3_MEPF",
+        "MetricGroup": "latency",
+        "MetricName": "l3pref_latency"
+    },
+    {
+        "BriefDescription": "Local L4 average load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_LL4_CYC/ PM_MRK_DATA_FROM_LL4",
+        "MetricGroup": "latency",
+        "MetricName": "ll4_latency"
+    },
+    {
+        "BriefDescription": "Marked Lmem Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_LMEM_CYC/ PM_MRK_DATA_FROM_LMEM",
+        "MetricGroup": "latency",
+        "MetricName": "lmem_latency"
+    },
+    {
+        "BriefDescription": "Latency for marked reloads that hit in the L2 or L3 of any other core on a different chip",
+        "MetricExpr": "PM_MRK_DATA_FROM_OFF_CHIP_CACHE_CYC/ PM_MRK_DATA_FROM_OFF_CHIP_CACHE",
+        "MetricGroup": "latency",
+        "MetricName": "off_chip_cache_latency"
+    },
+    {
+        "BriefDescription": "Latency for marked reloads that hit in the L2 or L3 of any other core on the same chip",
+        "MetricExpr": "PM_MRK_DATA_FROM_ON_CHIP_CACHE_CYC/ PM_MRK_DATA_FROM_ON_CHIP_CACHE",
+        "MetricGroup": "latency",
+        "MetricName": "on_chip_cache_latency"
+    },
+    {
+        "BriefDescription": "Marked L2L3 remote Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_RL2L3_MOD_CYC/ PM_MRK_DATA_FROM_RL2L3_MOD",
+        "MetricGroup": "latency",
+        "MetricName": "rl2l3_mod_latency"
+    },
+    {
+        "BriefDescription": "Marked L2L3 remote Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_RL2L3_SHR_CYC/ PM_MRK_DATA_FROM_RL2L3_SHR",
+        "MetricGroup": "latency",
+        "MetricName": "rl2l3_shr_latency"
+    },
+    {
+        "BriefDescription": "Remote L4 average load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_RL4_CYC/ PM_MRK_DATA_FROM_RL4",
+        "MetricGroup": "latency",
+        "MetricName": "rl4_latency"
+    },
+    {
+        "BriefDescription": "Marked Rmem Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_RMEM_CYC/ PM_MRK_DATA_FROM_RMEM",
+        "MetricGroup": "latency",
+        "MetricName": "rmem_latency"
+    },
     {
         "BriefDescription": "ERAT miss reject ratio",
         "MetricExpr": "PM_LSU_REJECT_ERAT_MISS * 100  / PM_RUN_INST_CMPL",
-- 
2.19.1

