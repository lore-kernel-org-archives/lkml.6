Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78C8C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDFB20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDFB20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeJPBXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:23:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:10068 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbeJPBXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:23:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 10:37:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,385,1534834800"; 
   d="scan'208";a="88528370"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Oct 2018 10:37:25 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org,
        viresh.kumar@linaro.org, robert.moore@intel.com,
        erik.schmauss@intel.com
Cc:     juri.lelli@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, devel@acpica.org,
        pprakash@codeaurora.org, george.cherian@cavium.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 1/3] ACPI / CPPC: Add support for guaranteed performance
Date:   Mon, 15 Oct 2018 10:37:19 -0700
Message-Id: <20181015173721.66147-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181015173721.66147-1-srinivas.pandruvada@linux.intel.com>
References: <20181015173721.66147-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Continuous Performance Control Package can have guaranteed performance
field. Add support to read guaranteed performance.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/cppc_acpi.c | 8 ++++++--
 include/acpi/cppc_acpi.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index d9ce4b162e2c..217a782c3e55 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1061,9 +1061,9 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 {
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
 	struct cpc_register_resource *highest_reg, *lowest_reg,
-		*lowest_non_linear_reg, *nominal_reg,
+		*lowest_non_linear_reg, *nominal_reg, *guaranteed_reg,
 		*low_freq_reg = NULL, *nom_freq_reg = NULL;
-	u64 high, low, nom, min_nonlinear, low_f = 0, nom_f = 0;
+	u64 high, low, guaranteed, nom, min_nonlinear, low_f = 0, nom_f = 0;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
 	int ret = 0, regs_in_pcc = 0;
@@ -1079,6 +1079,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	nominal_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
 	low_freq_reg = &cpc_desc->cpc_regs[LOWEST_FREQ];
 	nom_freq_reg = &cpc_desc->cpc_regs[NOMINAL_FREQ];
+	guaranteed_reg = &cpc_desc->cpc_regs[GUARANTEED_PERF];
 
 	/* Are any of the regs PCC ?*/
 	if (CPC_IN_PCC(highest_reg) || CPC_IN_PCC(lowest_reg) ||
@@ -1107,6 +1108,9 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	cpc_read(cpunum, nominal_reg, &nom);
 	perf_caps->nominal_perf = nom;
 
+	cpc_read(cpunum, guaranteed_reg, &guaranteed);
+	perf_caps->guaranteed_perf = guaranteed;
+
 	cpc_read(cpunum, lowest_non_linear_reg, &min_nonlinear);
 	perf_caps->lowest_nonlinear_perf = min_nonlinear;
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 8e0b8250a139..cf59e6210d27 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -104,6 +104,7 @@ enum cppc_regs {
  * today.
  */
 struct cppc_perf_caps {
+	u32 guaranteed_perf;
 	u32 highest_perf;
 	u32 nominal_perf;
 	u32 lowest_perf;
-- 
2.17.1

