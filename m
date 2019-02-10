Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD92C282C4
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 02:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2773E21929
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 02:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfBJC5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 21:57:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:14882 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfBJC53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 21:57:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2019 18:57:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,353,1544515200"; 
   d="scan'208";a="319090733"
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
Subject: [PATCH v7 10/13] selftests/resctrl: Add vendor detection mechanism
Date:   Sat,  9 Feb 2019 18:50:39 -0800
Message-Id: <1549767042-95827-11-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
References: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Babu Moger <babu.moger@amd.com>

RESCTRL feature is supported both on Intel and AMD now. Some features
are implemented differently. Add vendor detection mechanism. Use the vendor
check where there are differences.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h       | 13 +++++
 tools/testing/selftests/resctrl/resctrl_tests.c | 63 +++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index dadbb3d0cad8..974ec2de5fee 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -63,10 +63,23 @@ struct resctrl_val_param {
 
 };
 
+/**
+ * Results of CPUID operation are stored in this structure.
+ * It consists of 4x32bits IA registers: EAX, EBX, ECX and EDX.
+ */
+struct cpuid_out {
+	uint32_t eax;
+	uint32_t ebx;
+	uint32_t ecx;
+	uint32_t edx;
+};
+
 pid_t bm_pid, ppid;
 extern char cbm_mask[256];
 extern unsigned long long_mask;
 extern char llc_occup_path[1024];
+extern int genuine_intel;
+extern int authentic_amd;
 
 int remount_resctrlfs(bool mum_resctrlfs);
 int get_resource_id(int cpu_no, int *resource_id);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 3959b2b0671a..1d9adcfbdb4c 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -14,6 +14,66 @@
 #define BENCHMARK_ARGS		64
 #define BENCHMARK_ARG_SIZE	64
 
+/**
+ * This variables provides information about the vendor
+ */
+int genuine_intel;
+int authentic_amd;
+
+void lcpuid(const unsigned int leaf, const unsigned int subleaf,
+	    struct cpuid_out *out)
+{
+	if (!out)
+		return;
+
+#ifdef __x86_64__
+	asm volatile("mov %4, %%eax\n\t"
+		     "mov %5, %%ecx\n\t"
+		     "cpuid\n\t"
+		     "mov %%eax, %0\n\t"
+		     "mov %%ebx, %1\n\t"
+		     "mov %%ecx, %2\n\t"
+		     "mov %%edx, %3\n\t"
+		     : "=g" (out->eax), "=g" (out->ebx), "=g" (out->ecx),
+		     "=g" (out->edx)
+		     : "g" (leaf), "g" (subleaf)
+		     : "%eax", "%ebx", "%ecx", "%edx");
+#else
+	asm volatile("push %%ebx\n\t"
+		     "mov %4, %%eax\n\t"
+		     "mov %5, %%ecx\n\t"
+		     "cpuid\n\t"
+		     "mov %%eax, %0\n\t"
+		     "mov %%ebx, %1\n\t"
+		     "mov %%ecx, %2\n\t"
+		     "mov %%edx, %3\n\t"
+		     "pop %%ebx\n\t"
+		     : "=g" (out->eax), "=g" (out->ebx), "=g" (out->ecx),
+		     "=g" (out->edx)
+		     : "g" (leaf), "g" (subleaf)
+		     : "%eax", "%ecx", "%edx");
+#endif
+}
+
+int detect_vendor(void)
+{
+	struct cpuid_out vendor;
+	int ret = 0;
+
+	lcpuid(0x0, 0x0, &vendor);
+	if (vendor.ebx == 0x756e6547 && vendor.edx == 0x49656e69 &&
+	    vendor.ecx == 0x6c65746e) {
+		genuine_intel = 1;
+	} else if (vendor.ebx == 0x68747541 && vendor.edx == 0x69746E65 &&
+		   vendor.ecx ==   0x444D4163) {
+		authentic_amd = 1;
+	} else {
+		ret = -EFAULT;
+	}
+
+	return ret;
+}
+
 static void cmd_help(void)
 {
 	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-t test list] [-n no_of_bits]\n");
@@ -110,6 +170,9 @@ int main(int argc, char **argv)
 		return errno;
 	}
 
+	/* Detect vendor */
+	detect_vendor();
+
 	if (has_ben) {
 		/* Extract benchmark command from command line. */
 		for (i = ben_ind; i < argc; i++) {
-- 
2.7.4

