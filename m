Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F42DC282C4
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 02:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0799E21939
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 02:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfBJC6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 21:58:17 -0500
Received: from mga07.intel.com ([134.134.136.100]:31724 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbfBJC52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 21:57:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2019 18:57:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,353,1544515200"; 
   d="scan'208";a="319090739"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga005.fm.intel.com with ESMTP; 09 Feb 2019 18:57:27 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Xiaochen Shen" <xiaochen.shen@intel.com>,
        "Arshiya Hayatkhan Pathan" <arshiya.hayatkhan.pathan@intel.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Babu Moger" <babu.moger@amd.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v7 12/13] selftests/resctrl: Disable MBA and MBM tests for AMD
Date:   Sat,  9 Feb 2019 18:50:41 -0800
Message-Id: <1549767042-95827-13-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
References: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Babu Moger <babu.moger@amd.com>

For now, disable MBA and MBM tests for AMD. Deciding test pass/fail
is not clear right now. We can enable when we have some clarity.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c      | 2 +-
 tools/testing/selftests/resctrl/resctrl_tests.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 1a0f77e4f7bf..264bf2325f9e 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -69,7 +69,7 @@ static void show_cache_info(unsigned long sum_llc_perf_miss, int no_of_bits,
 	printf("Allocated cache lines: %lu \t", allocated_cache_lines);
 	printf("Percent diff=%d \t", abs((int)diff_percent));
 
-	if (abs((int)diff_percent) > MAX_DIFF_PERCENT)
+	if (genuine_intel && (abs((int)diff_percent) > MAX_DIFF_PERCENT))
 		printf("Failed\n");
 	else
 		printf("Passed\n");
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 1d9adcfbdb4c..620be40b8c01 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -197,7 +197,7 @@ int main(int argc, char **argv)
 	sprintf(bw_report, "reads");
 	sprintf(bm_type, "fill_buf");
 
-	if (mbm_test) {
+	if (genuine_intel && mbm_test) {
 		printf("\nMBM BW Change Starting..\n");
 		if (!has_ben)
 			sprintf(benchmark_cmd[5], "%s", "mbm");
@@ -207,7 +207,7 @@ int main(int argc, char **argv)
 		mbm_test_cleanup();
 	}
 
-	if (mba_test) {
+	if (genuine_intel && mba_test) {
 		printf("\nMBA Schemata Change Starting..\n");
 		if (!has_ben)
 			sprintf(benchmark_cmd[5], "%s", "mba");
-- 
2.7.4

