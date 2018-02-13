Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934969AbeBMQoI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:44:08 -0500
Received: from gateway22.websitewelcome.com ([192.185.46.131]:36670 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934779AbeBMQoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:44:07 -0500
Date: Tue, 13 Feb 2018 10:44:04 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] x86/microcode/intel: Use 64-bit arithmetic instead of 32-bit
Message-ID: <20180213164404.GA11664@embeddedor.com>
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
X-Exim-ID: 1eldgb-0013xh-UM
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.175.4.238]:35024
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suffix ULL to constant 1024 in order to give the compiler complete
information about the proper arithmetic to use. Notice that this
constant is used in a context that expects an expression of type
u64 (64 bits, unsigned).

The expression c->x86_cache_size * 1024 is currently being evaluated
using 32-bit arithmetic.

Addresses-Coverity-ID: 1464429
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
 
-- 
2.7.4
