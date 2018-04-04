Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751179AbeDDJxJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 05:53:09 -0400
Received: from zxshcas1.zhaoxin.com ([180.169.121.91]:59221 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750736AbeDDJxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 05:53:07 -0400
From: David Wang <davidwang@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <mingo@kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
        <qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>,
        <lukelin@viacpu.com>, <timguo@zhaoxin.com>,
        David Wang <davidwang@zhaoxin.com>
Subject: [PATCH] x86/centaur: report correct CPU/cache topology
Date: Wed, 4 Apr 2018 17:52:59 +0800
Message-ID: <1522835579-22893-1-git-send-email-davidwang@zhaoxin.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.54]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is used to support multi-core Centaur CPU. After using this
patch, we can get correct CPU topology and correct cache topology.

Signed-off-by: David Wang <davidwang@zhaoxin.com>
---
 arch/x86/kernel/cpu/centaur.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index e5ec0f1..713e4db 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -112,6 +112,19 @@ static void early_init_centaur(struct cpuinfo_x86 *c)
 	}
 }
 
+static int centaur_num_cpu_cores(struct cpuinfo_x86 *c)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	if (c->cpuid_level < 4)
+		return 1;
+	cpuid_count(4, 0, &eax, &ebx, &ecx, &edx);
+	if (eax & 0x1f)
+		return (eax >> 26) + 1;
+	else
+		return 1;
+}
+
 static void init_centaur(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_X86_32
@@ -128,6 +141,13 @@ static void init_centaur(struct cpuinfo_x86 *c)
 	clear_cpu_cap(c, 0*32+31);
 #endif
 	early_init_centaur(c);
+
+	init_intel_cacheinfo(c);
+	c->x86_max_cores = centaur_num_cpu_cores(c);
+#ifdef CONFIG_X86_32
+	detect_ht(c);
+#endif
+
 	switch (c->x86) {
 #ifdef CONFIG_X86_32
 	case 5:
-- 
1.9.1
