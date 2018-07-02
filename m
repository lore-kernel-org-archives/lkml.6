Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475CCC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7FD20C03
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7FD20C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752508AbeGBPV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:21:28 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:33862 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752241AbeGBPV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:21:26 -0400
Received: from localhost.localdomain ([127.0.0.1]:33942 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993883AbeGBPVYjH4YN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:21:24 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id w62FKUpZ439160;
        Mon, 2 Jul 2018 17:20:30 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id w62FKTBa439158;
        Mon, 2 Jul 2018 17:20:29 +0200
Date:   Mon, 2 Jul 2018 17:20:29 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Remove no-op cast in show_regs()
Message-ID: <20180702152029.GA437552@linux-mips.org>
References: <20180622180703.18324-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622180703.18324-1-paul.burton@mips.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 11:07:03AM -0700, Paul Burton wrote:

> In show_regs() we have a regs argument of type struct pt_regs *, and we
> explicitly cast it to that same type as part of calling __show_regs().
> 
> Casting regs to the same type that it is declared as does nothing at
> all, so remove the useless cast.

Good catch but there's no dump_stack() in v4.18-rc3 so this doesn't apply.
That's trivial to patch up but since pointless casts are one of my pet
peeve I used a semantic patch from a dark local repository to hunt down a
few more.

@identitycast@
type T;
T *A;
@@
-	(T *) A
+	A

Julia, I guess this isn't bulletproof but maybe something similar should
be considered for scripts/coccinelle?

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/kernel/relocate.c           |  2 +-
 arch/mips/kernel/traps.c              |  2 +-
 arch/mips/loongson64/loongson-3/smp.c | 10 +++++-----
 arch/mips/pmcs-msp71xx/msp_usb.c      |  4 ++--
 arch/mips/sgi-ip22/ip28-berr.c        |  2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kernel/relocate.c b/arch/mips/kernel/relocate.c
index cbf4cc0b0b6c..ae7d9cf2c849 100644
--- a/arch/mips/kernel/relocate.c
+++ b/arch/mips/kernel/relocate.c
@@ -146,7 +146,7 @@ int __init do_relocations(void *kbase_old, void *kbase_new, long offset)
 			break;
 
 		type = (*r >> 24) & 0xff;
-		loc_orig = (void *)(kbase_old + ((*r & 0x00ffffff) << 2));
+		loc_orig = (kbase_old + ((*r & 0x00ffffff) << 2));
 		loc_new = RELOCATED(loc_orig);
 
 		if (reloc_handlers_rel[type] == NULL) {
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index d67fa74622ee..2935aa608d2f 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -350,7 +350,7 @@ static void __show_regs(const struct pt_regs *regs)
  */
 void show_regs(struct pt_regs *regs)
 {
-	__show_regs((struct pt_regs *)regs);
+	__show_regs(regs);
 }
 
 void show_registers(struct pt_regs *regs)
diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
index 8501109bb0f0..e231c2cb4a64 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -349,7 +349,7 @@ static void loongson3_smp_finish(void)
 	write_c0_compare(read_c0_count() + mips_hpt_frequency/HZ);
 	local_irq_enable();
 	loongson3_ipi_write64(0,
-			(void *)(ipi_mailbox_buf[cpu_logical_map(cpu)]+0x0));
+			(ipi_mailbox_buf[cpu_logical_map(cpu)] + 0x0));
 	pr_info("CPU#%d finished, CP0_ST=%x\n",
 			smp_processor_id(), read_c0_status());
 }
@@ -416,13 +416,13 @@ static int loongson3_boot_secondary(int cpu, struct task_struct *idle)
 			cpu, startargs[0], startargs[1], startargs[2]);
 
 	loongson3_ipi_write64(startargs[3],
-			(void *)(ipi_mailbox_buf[cpu_logical_map(cpu)]+0x18));
+			(ipi_mailbox_buf[cpu_logical_map(cpu)] + 0x18));
 	loongson3_ipi_write64(startargs[2],
-			(void *)(ipi_mailbox_buf[cpu_logical_map(cpu)]+0x10));
+			(ipi_mailbox_buf[cpu_logical_map(cpu)] + 0x10));
 	loongson3_ipi_write64(startargs[1],
-			(void *)(ipi_mailbox_buf[cpu_logical_map(cpu)]+0x8));
+			(ipi_mailbox_buf[cpu_logical_map(cpu)] + 0x8));
 	loongson3_ipi_write64(startargs[0],
-			(void *)(ipi_mailbox_buf[cpu_logical_map(cpu)]+0x0));
+			(ipi_mailbox_buf[cpu_logical_map(cpu)] + 0x0));
 	return 0;
 }
 
diff --git a/arch/mips/pmcs-msp71xx/msp_usb.c b/arch/mips/pmcs-msp71xx/msp_usb.c
index c87c5f810cd1..d38ac70b5a2e 100644
--- a/arch/mips/pmcs-msp71xx/msp_usb.c
+++ b/arch/mips/pmcs-msp71xx/msp_usb.c
@@ -133,13 +133,13 @@ static int __init msp_usb_setup(void)
 	 * "D" for device-mode.	 If it works for Ethernet, why not USB...
 	 *  -- hammtrev, 2007/03/22
 	 */
-	snprintf((char *)&envstr[0], sizeof(envstr), "usbmode");
+	snprintf(&envstr[0], sizeof(envstr), "usbmode");
 
 	/* set default host mode */
 	val = 1;
 
 	/* get environment string */
-	strp = prom_getenv((char *)&envstr[0]);
+	strp = prom_getenv(&envstr[0]);
 	if (strp) {
 		/* compare string */
 		if (!strcmp(strp, "device"))
diff --git a/arch/mips/sgi-ip22/ip28-berr.c b/arch/mips/sgi-ip22/ip28-berr.c
index 2ed8e4990b7a..082541d33161 100644
--- a/arch/mips/sgi-ip22/ip28-berr.c
+++ b/arch/mips/sgi-ip22/ip28-berr.c
@@ -464,7 +464,7 @@ void ip22_be_interrupt(int irq)
 		die_if_kernel("Oops", regs);
 		force_sig(SIGBUS, current);
 	} else if (debug_be_interrupt)
-		show_regs((struct pt_regs *)regs);
+		show_regs(regs);
 }
 
 static int ip28_be_handler(struct pt_regs *regs, int is_fixup)
