Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeEMOTY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 10:19:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36949 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeEMOTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 10:19:23 -0400
Date: Sun, 13 May 2018 07:19:18 -0700
From: tip-bot for David Wang <tipbot@zytor.com>
Message-ID: <tip-a2aa578fec8c29436bce5e6c15e1e31729d539a3@git.kernel.org>
Cc: tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        davidwang@zhaoxin.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, davidwang@zhaoxin.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1525314766-18910-4-git-send-email-davidwang@zhaoxin.com>
References: <1525314766-18910-4-git-send-email-davidwang@zhaoxin.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/Centaur: Report correct CPU/cache topology
Git-Commit-ID: a2aa578fec8c29436bce5e6c15e1e31729d539a3
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

Commit-ID:  a2aa578fec8c29436bce5e6c15e1e31729d539a3
Gitweb:     https://git.kernel.org/tip/a2aa578fec8c29436bce5e6c15e1e31729d539a3
Author:     David Wang <davidwang@zhaoxin.com>
AuthorDate: Thu, 3 May 2018 10:32:46 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 13 May 2018 16:14:24 +0200

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
