Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754590AbeBNIiH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 03:38:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54293 "EHLO
        terminus.zytor.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751427AbeBNIiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 03:38:05 -0500
Date: Wed, 14 Feb 2018 00:37:24 -0800
From: "tip-bot for Gustavo A. R. Silva" <tipbot@zytor.com>
Message-ID: <tip-0bfa9f1c5d3d290461f554520b8f24316ec971e0@git.kernel.org>
Cc: hpa@zytor.com, tglx@linutronix.de, garsilva@embeddedor.com,
        linux-kernel@vger.kernel.org, bp@alien8.de,
        torvalds@linux-foundation.org, mingo@kernel.org, peterz@infradead.org
Reply-To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        bp@alien8.de, garsilva@embeddedor.com, hpa@zytor.com,
        tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org
In-Reply-To: <20180213192208.GA26414@embeddedor.com>
References: <20180213192208.GA26414@embeddedor.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/cpu: Change type of x86_cache_size variable to
 unsigned int
Git-Commit-ID: 0bfa9f1c5d3d290461f554520b8f24316ec971e0
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

Commit-ID:  0bfa9f1c5d3d290461f554520b8f24316ec971e0
Gitweb:     https://git.kernel.org/tip/0bfa9f1c5d3d290461f554520b8f24316ec971e0
Author:     Gustavo A. R. Silva <garsilva@embeddedor.com>
AuthorDate: Tue, 13 Feb 2018 13:22:08 -0600
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 14 Feb 2018 09:14:44 +0100

x86/cpu: Change type of x86_cache_size variable to unsigned int

Currently, x86_cache_size is of type int, which makes no sense as we
will never have a valid cache size equal or less than 0. So instead of
initializing this variable to -1, it can perfectly be initialized to 0
and use it as an unsigned variable instead.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Addresses-Coverity-ID: 1464429
Link: http://lkml.kernel.org/r/20180213192208.GA26414@embeddedor.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/processor.h      | 2 +-
 arch/x86/kernel/cpu/common.c          | 2 +-
 arch/x86/kernel/cpu/microcode/intel.c | 2 +-
 arch/x86/kernel/cpu/proc.c            | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index b7c8583..44c2c4e 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -109,7 +109,7 @@ struct cpuinfo_x86 {
 	char			x86_vendor_id[16];
 	char			x86_model_id[64];
 	/* in KB - valid for CPUS which support this call: */
-	int			x86_cache_size;
+	unsigned int		x86_cache_size;
 	int			x86_cache_alignment;	/* In bytes */
 	/* Cache QoS architectural values: */
 	int			x86_cache_max_rmid;	/* max index */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a7d8df6..824aee0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1184,7 +1184,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	int i;
 
 	c->loops_per_jiffy = loops_per_jiffy;
-	c->x86_cache_size = -1;
+	c->x86_cache_size = 0;
 	c->x86_vendor = X86_VENDOR_UNKNOWN;
 	c->x86_model = c->x86_stepping = 0;	/* So far unknown... */
 	c->x86_vendor_id[0] = '\0'; /* Unset */
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index b94279b..a15db2b 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -982,7 +982,7 @@ static struct microcode_ops microcode_intel_ops = {
 
 static int __init calc_llc_size_per_core(struct cpuinfo_x86 *c)
 {
-	u64 llc_size = c->x86_cache_size * 1024;
+	u64 llc_size = c->x86_cache_size * 1024ULL;
 
 	do_div(llc_size, c->x86_max_cores);
 
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index ee4cc38..2c8522a 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -91,8 +91,8 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	}
 
 	/* Cache size */
-	if (c->x86_cache_size >= 0)
-		seq_printf(m, "cache size\t: %d KB\n", c->x86_cache_size);
+	if (c->x86_cache_size)
+		seq_printf(m, "cache size\t: %u KB\n", c->x86_cache_size);
 
 	show_cpuinfo_core(m, c, cpu);
 	show_cpuinfo_misc(m, c);
