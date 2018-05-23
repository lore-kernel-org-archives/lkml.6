Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933956AbeEWSBH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 14:01:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:50942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933460AbeEWSA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 14:00:58 -0400
From: Michal Suchanek <msuchanek@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Balbir Singh <bsingharora@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Breno Leitao <leitao@debian.org>,
        Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc/xmon: Also setup debugger hooks when single-stepping
Date: Wed, 23 May 2018 20:00:54 +0200
Message-Id: <20180523180054.9937-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When single-stepping kernel code from xmon without a debug hook enabled
the kernel crashes. This can happen when kernel starts with xmon on
crash disabled but xmon is entered using sysrq.

Call force_enable_xmon when single-stepping in xmon to install the xmon
debug hooks.

Fixes: e1368d0c9edb ("powerpc/xmon: Setup debugger hooks when first
break-point is set")

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/xmon/xmon.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

v2: calling force_enable_xmon in do_step is sufficient

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index a0842f1ff72c..252df9741d20 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -778,6 +778,16 @@ static int xmon_fault_handler(struct pt_regs *regs)
 	return 0;
 }
 
+/* Force enable xmon if not already enabled */
+static inline void force_enable_xmon(void)
+{
+	/* Enable xmon hooks if needed */
+	if (!xmon_on) {
+		printf("xmon: Enabling debugger hooks\n");
+		xmon_on = 1;
+	}
+}
+
 static struct bpt *at_breakpoint(unsigned long pc)
 {
 	int i;
@@ -1094,6 +1104,7 @@ static int do_step(struct pt_regs *regs)
 	unsigned int instr;
 	int stepped;
 
+	force_enable_xmon();
 	/* check we are in 64-bit kernel mode, translation enabled */
 	if ((regs->msr & (MSR_64BIT|MSR_PR|MSR_IR)) == (MSR_64BIT|MSR_IR)) {
 		if (mread(regs->nip, &instr, 4) == 4) {
@@ -1268,16 +1279,6 @@ static long check_bp_loc(unsigned long addr)
 	return 1;
 }
 
-/* Force enable xmon if not already enabled */
-static inline void force_enable_xmon(void)
-{
-	/* Enable xmon hooks if needed */
-	if (!xmon_on) {
-		printf("xmon: Enabling debugger hooks\n");
-		xmon_on = 1;
-	}
-}
-
 static char *breakpoint_help_string =
     "Breakpoint command usage:\n"
     "b                show breakpoints\n"
-- 
2.13.6
