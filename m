Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeEMMCa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 08:02:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35027 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbeEMMC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 08:02:29 -0400
Date: Sun, 13 May 2018 05:02:23 -0700
From: tip-bot for David Wang <tipbot@zytor.com>
Message-ID: <tip-5a19009043fcffd1591b04a588d53336a66855d5@git.kernel.org>
Cc: mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        davidwang@zhaoxin.com, hpa@zytor.com
Reply-To: hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
        davidwang@zhaoxin.com, linux-kernel@vger.kernel.org
In-Reply-To: <1525314766-18910-4-git-send-email-davidwang@zhaoxin.com>
References: <1525314766-18910-4-git-send-email-davidwang@zhaoxin.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/Centaur: Report correct CPU/cache topology
Git-Commit-ID: 5a19009043fcffd1591b04a588d53336a66855d5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5a19009043fcffd1591b04a588d53336a66855d5
Gitweb:     https://git.kernel.org/tip/5a19009043fcffd1591b04a588d53336a66855d5
Author:     David Wang <davidwang@zhaoxin.com>
AuthorDate: Thu, 3 May 2018 10:32:46 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 13 May 2018 12:06:13 +0200

x86/Centaur: Report correct CPU/cache topology

Centaur CPUs enumerate the cache topology in the same way as Intel CPUs,
but the function is unused so for. The Centaur init code also misses to
initialize x86_info::max_cores, so the CPU topology can't be described
correctly.

Initialize x86_info::max_cores and invoke init_cacheinfo() to make
CPU and cache topology information available and correct.

Signed-off-by: David Wang <davidwang@zhaoxin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: lukelin@viacpu.com
Cc: qiyuanwang@zhaoxin.com
Cc: gregkh@linuxfoundation.org
Cc: brucechang@via-alliance.com
Cc: timguo@zhaoxin.com
Cc: cooperyan@zhaoxin.com
Cc: hpa@zytor.com
Cc: benjaminpan@viatech.com
Link: https://lkml.kernel.org/r/1525314766-18910-4-git-send-email-davidwang@zhaoxin.com

---
 arch/x86/kernel/cpu/centaur.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index 80d5110481ec..c265494234e6 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -160,6 +160,11 @@ static void init_centaur(struct cpuinfo_x86 *c)
 	clear_cpu_cap(c, 0*32+31);
 #endif
 	early_init_centaur(c);
+	init_intel_cacheinfo(c);
+	c->x86_max_cores = detect_num_cpu_cores(c);
+#ifdef CONFIG_X86_32
+	detect_ht(c);
+#endif
 
 	if (c->cpuid_level > 9) {
 		unsigned int eax = cpuid_eax(10);
