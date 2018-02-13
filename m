Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965575AbeBMTWO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 14:22:14 -0500
Received: from gateway21.websitewelcome.com ([192.185.46.109]:47341 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965508AbeBMTWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 14:22:11 -0500
Date: Tue, 13 Feb 2018 13:22:08 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] x86/kernel/cpu: Change type of x86_cache_size variable to
 unsigned int
Message-ID: <20180213192208.GA26414@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.4.238
X-Source-L: No
X-Exim-ID: 1elg9Z-003Ymz-MK
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.175.4.238]:37410
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, x86_cache_size is of type int, which makes no sense as we
will never have a valid cache size equal or less than 0. So instead of
initializing this variable to -1, it can perfectly be initialized to 0
and use it as an unsigned variable instead.

Addresses-Coverity-ID: 1464429
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 arch/x86/include/asm/processor.h      | 2 +-
 arch/x86/kernel/cpu/common.c          | 2 +-
 arch/x86/kernel/cpu/microcode/intel.c | 2 +-
 arch/x86/kernel/cpu/proc.c            | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 23fdaf4..c4d66aa 100644
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
index d63f4b57..a37fd00 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1184,7 +1184,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	int i;
 
 	c->loops_per_jiffy = loops_per_jiffy;
-	c->x86_cache_size = -1;
+	c->x86_cache_size = 0;
 	c->x86_vendor = X86_VENDOR_UNKNOWN;
 	c->x86_model = c->x86_mask = 0;	/* So far unknown... */
 	c->x86_vendor_id[0] = '\0'; /* Unset */
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index f7c55b0..e5edb92 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -982,7 +982,7 @@ static struct microcode_ops microcode_intel_ops = {
 
 static int __init calc_llc_size_per_core(struct cpuinfo_x86 *c)
 {
-	u64 llc_size = c->x86_cache_size * 1024;
+	u64 llc_size = c->x86_cache_size * 1024ULL;
 
 	do_div(llc_size, c->x86_max_cores);
 
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index e7eceda..f3da3bb 100644
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
-- 
2.7.4
