Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EAAC43612
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 00:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4B42173B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 00:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbeLZAoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 19:44:09 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:57326 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbeLZAoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 19:44:01 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 9897229525; Tue, 25 Dec 2018 19:43:56 -0500 (EST)
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org
Message-Id: <6db46da0ad072e50de32721e2dce9387aa58f4ab.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v8 16/25] powerpc: Add missing ppc_md.nvram_size for CHRP and
 PowerMac
Date:   Wed, 26 Dec 2018 11:37:59 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the nvram_size() function to those PowerPC platforms that don't already
have one: CHRP and PowerMac. This means that the ppc_md.nvram_size()
function can be used to implement arch_nvram_ops.get_size()

Since we are addressing inconsistencies here, also rename chrp_nvram_read
and chrp_nvram_write, which break the naming convention used across
PowerPC platforms for NVRAM accessor functions.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Stan Johnson <userm57@yahoo.com>
---
 arch/powerpc/platforms/chrp/nvram.c     | 14 ++++++++++----
 arch/powerpc/platforms/powermac/nvram.c |  9 +++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/chrp/nvram.c b/arch/powerpc/platforms/chrp/nvram.c
index 791b86398e1d..6ec2901d2aa4 100644
--- a/arch/powerpc/platforms/chrp/nvram.c
+++ b/arch/powerpc/platforms/chrp/nvram.c
@@ -24,7 +24,7 @@ static unsigned int nvram_size;
 static unsigned char nvram_buf[4];
 static DEFINE_SPINLOCK(nvram_lock);
 
-static unsigned char chrp_nvram_read(int addr)
+static unsigned char chrp_nvram_read_byte(int addr)
 {
 	unsigned int done;
 	unsigned long flags;
@@ -46,7 +46,7 @@ static unsigned char chrp_nvram_read(int addr)
 	return ret;
 }
 
-static void chrp_nvram_write(int addr, unsigned char val)
+static void chrp_nvram_write_byte(int addr, unsigned char val)
 {
 	unsigned int done;
 	unsigned long flags;
@@ -64,6 +64,11 @@ static void chrp_nvram_write(int addr, unsigned char val)
 	spin_unlock_irqrestore(&nvram_lock, flags);
 }
 
+static ssize_t chrp_nvram_size(void)
+{
+	return nvram_size;
+}
+
 void __init chrp_nvram_init(void)
 {
 	struct device_node *nvram;
@@ -85,8 +90,9 @@ void __init chrp_nvram_init(void)
 	printk(KERN_INFO "CHRP nvram contains %u bytes\n", nvram_size);
 	of_node_put(nvram);
 
-	ppc_md.nvram_read_val = chrp_nvram_read;
-	ppc_md.nvram_write_val = chrp_nvram_write;
+	ppc_md.nvram_read_val  = chrp_nvram_read_byte;
+	ppc_md.nvram_write_val = chrp_nvram_write_byte;
+	ppc_md.nvram_size      = chrp_nvram_size;
 
 	return;
 }
diff --git a/arch/powerpc/platforms/powermac/nvram.c b/arch/powerpc/platforms/powermac/nvram.c
index ae54d7fe68f3..9360cdc408c1 100644
--- a/arch/powerpc/platforms/powermac/nvram.c
+++ b/arch/powerpc/platforms/powermac/nvram.c
@@ -147,6 +147,11 @@ static ssize_t core99_nvram_size(void)
 static volatile unsigned char __iomem *nvram_addr;
 static int nvram_mult;
 
+static ssize_t ppc32_nvram_size(void)
+{
+	return NVRAM_SIZE;
+}
+
 static unsigned char direct_nvram_read_byte(int addr)
 {
 	return in_8(&nvram_data[(addr & (NVRAM_SIZE - 1)) * nvram_mult]);
@@ -590,21 +595,25 @@ int __init pmac_nvram_init(void)
 		nvram_mult = 1;
 		ppc_md.nvram_read_val	= direct_nvram_read_byte;
 		ppc_md.nvram_write_val	= direct_nvram_write_byte;
+		ppc_md.nvram_size	= ppc32_nvram_size;
 	} else if (nvram_naddrs == 1) {
 		nvram_data = ioremap(r1.start, s1);
 		nvram_mult = (s1 + NVRAM_SIZE - 1) / NVRAM_SIZE;
 		ppc_md.nvram_read_val	= direct_nvram_read_byte;
 		ppc_md.nvram_write_val	= direct_nvram_write_byte;
+		ppc_md.nvram_size	= ppc32_nvram_size;
 	} else if (nvram_naddrs == 2) {
 		nvram_addr = ioremap(r1.start, s1);
 		nvram_data = ioremap(r2.start, s2);
 		ppc_md.nvram_read_val	= indirect_nvram_read_byte;
 		ppc_md.nvram_write_val	= indirect_nvram_write_byte;
+		ppc_md.nvram_size	= ppc32_nvram_size;
 	} else if (nvram_naddrs == 0 && sys_ctrler == SYS_CTRLER_PMU) {
 #ifdef CONFIG_ADB_PMU
 		nvram_naddrs = -1;
 		ppc_md.nvram_read_val	= pmu_nvram_read_byte;
 		ppc_md.nvram_write_val	= pmu_nvram_write_byte;
+		ppc_md.nvram_size	= ppc32_nvram_size;
 #endif /* CONFIG_ADB_PMU */
 	} else {
 		printk(KERN_ERR "Incompatible type of NVRAM\n");
-- 
2.19.2

