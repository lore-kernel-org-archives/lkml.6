Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0309C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A607820856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A607820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbeICW0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:26:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:31017 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727687AbeICW0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:26:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 11:05:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,326,1531810800"; 
   d="scan'208";a="88629500"
Received: from rajneesh-desk.iind.intel.com ([10.223.86.34])
  by orsmga002.jf.intel.com with ESMTP; 03 Sep 2018 11:04:59 -0700
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     dvhart@infradead.org, andy@infradead.org,
        linux-kernel@vger.kernel.org, rajneesh.bhardwaj@intel.com,
        souvik.k.chakravarty@intel.com,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Subject: [PATCH 3/4] platform/x86: intel_pmc_core: Decode Snoop / Non Snoop LTR
Date:   Mon,  3 Sep 2018 23:34:14 +0530
Message-Id: <20180903180415.31575-3-rajneesh.bhardwaj@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180903180415.31575-1-rajneesh.bhardwaj@linux.intel.com>
References: <20180903180415.31575-1-rajneesh.bhardwaj@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LTR values follow PCIE LTR encoding format and can be decoded as per
https://pcisig.com/sites/default/files/specification_documents/ECN_LatencyTolnReporting_14Aug08.pdf

This adds support to translate the raw LTR values as read from the PMC
to meaningful values in nanosecond units of time.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 62 ++++++++++++++++++++++++++-
 drivers/platform/x86/intel_pmc_core.h | 14 ++++++
 2 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index c1330a03523d..ffa912a8a5f5 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -651,16 +651,74 @@ static int pmc_core_slps0_dbg_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_slps0_dbg);
 
+static void get_ltr_scale(u32 *val)
+{
+	/*
+	 * As per PCIE specification supprting document
+	 * ECN_LatencyTolnReporting_14Aug08.pdf the Latency
+	 * Tolerance Reporting data payload is encoded in a
+	 * 3 bit scale and 10 bit value fields. Values are
+	 * multiplied by the indicated scale to yield an absolute time
+	 * value, expressible in a range from 1 nanosecond to
+	 * 2^25*(2^10-1) = 34,326,183,936 nanoseconds.
+	 *
+	 * scale encoding is as follows:
+	 *
+	 * ----------------------------------------------
+	 * |scale factor	|	Multiplier (ns)	|
+	 * ----------------------------------------------
+	 * |	0		|	1		|
+	 * |	1		|	32		|
+	 * |	2		|	1024		|
+	 * |	3		|	32768		|
+	 * |	4		|	1048576		|
+	 * |	5		|	33554432	|
+	 * |	6		|	Invalid		|
+	 * |	7		|	Invalid		|
+	 * ----------------------------------------------
+	 */
+	if (*val > 5) {
+		*val = 0;
+		pr_warn("Invalid LTR scale factor.\n");
+	} else {
+		*val = 1U << (5 * (*val));
+	}
+}
+
 static int pmc_core_ltr_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
 	const struct pmc_bit_map *map = pmcdev->map->ltr_show_sts;
+	u64 decoded_snoop_ltr = 0, decoded_non_snoop_ltr = 0;
+	union ltr_payload ltr_data;
+	u32 scale = 0;
 	int index;
 
 	for (index = 0; map[index].name ; index++) {
-		seq_printf(s, "%-32s\tRAW LTR: 0x%x\n",
+		ltr_data.raw_data = pmc_core_reg_read(pmcdev,
+						      map[index].bit_mask);
+
+		if (ltr_data.bits.non_snoop_req) {
+			scale = ltr_data.bits.non_snoop_scale;
+			get_ltr_scale(&scale);
+			decoded_non_snoop_ltr =
+				ltr_data.bits.non_snoop_val * scale;
+		}
+
+		if (ltr_data.bits.snoop_req) {
+			scale = ltr_data.bits.snoop_scale;
+			get_ltr_scale(&scale);
+			decoded_snoop_ltr =
+				ltr_data.bits.snoop_val * scale;
+		}
+
+		seq_printf(s, "%-24s\tRaw LTR: 0x%-16x\t Non-Snoop LTR (ns): %-16llu\t Snoop LTR (ns): %-16llu\n",
 			   map[index].name,
-			   pmc_core_reg_read(pmcdev, map[index].bit_mask));
+			   ltr_data.raw_data,
+			   decoded_non_snoop_ltr,
+			   decoded_snoop_ltr);
+
+		decoded_snoop_ltr = decoded_non_snoop_ltr = 0;
 	}
 	return 0;
 }
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index 12663c58f122..bbf9a2790548 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -243,4 +243,18 @@ struct pmc_dev {
 	struct mutex lock; /* generic mutex lock for PMC Core */
 };
 
+union ltr_payload {
+	u32 raw_data;
+	struct {
+	u32 snoop_val : 10;
+	u32 snoop_scale : 3;
+	u32 snoop_res : 2;
+	u32 snoop_req : 1;
+	u32 non_snoop_val : 10;
+	u32 non_snoop_scale : 3;
+	u32 non_snoop_res : 2;
+	u32 non_snoop_req : 1;
+	} bits;
+};
+
 #endif /* PMC_CORE_H */
-- 
2.17.1

