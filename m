Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3893CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A332080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A332080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbeKLGDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:03:25 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52782 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727144AbeKLGDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:03:24 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvtD-0000oO-Kr; Sun, 11 Nov 2018 19:59:23 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsO-0001Ob-Ai; Sun, 11 Nov 2018 19:58:32 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Joerg Roedel" <jroedel@suse.de>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "Dmitry Safonov" <dima@arista.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Ingo Molnar" <mingo@kernel.org>, iommu@lists.linux-foundation.org,
        "Alex Williamson" <alex.williamson@redhat.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.163594241@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 032/366] iommu/vt-d: Ratelimit each dmar fault printing
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Safonov <dima@arista.com>

commit 6c50d79f66382d78918a768374839d6d1b606d3f upstream.

There is a ratelimit for printing, but it's incremented each time the
cpu recives dmar fault interrupt. While one interrupt may signal about
*many* faults.
So, measuring the impact it turns out that reading/clearing one fault
takes < 1 usec, and printing info about the fault takes ~170 msec.

Having in mind that maximum number of fault recording registers per
remapping hardware unit is 256.. IRQ handler may run for (170*256) msec.
And as fault-serving loop runs without a time limit, during servicing
new faults may occur..

Ratelimit each fault printing rather than each irq printing.

Fixes: commit c43fce4eebae ("iommu/vt-d: Ratelimit fault handler")

BUG: spinlock lockup suspected on CPU#0, CliShell/9903
 lock: 0xffffffff81a47440, .magic: dead4ead, .owner: kworker/u16:2/8915, .owner_cpu: 6
CPU: 0 PID: 9903 Comm: CliShell
Call Trace:$\n'
[..] dump_stack+0x65/0x83$\n'
[..] spin_dump+0x8f/0x94$\n'
[..] do_raw_spin_lock+0x123/0x170$\n'
[..] _raw_spin_lock_irqsave+0x32/0x3a$\n'
[..] uart_chars_in_buffer+0x20/0x4d$\n'
[..] tty_chars_in_buffer+0x18/0x1d$\n'
[..] n_tty_poll+0x1cb/0x1f2$\n'
[..] tty_poll+0x5e/0x76$\n'
[..] do_select+0x363/0x629$\n'
[..] compat_core_sys_select+0x19e/0x239$\n'
[..] compat_SyS_select+0x98/0xc0$\n'
[..] sysenter_dispatch+0x7/0x25$\n'
[..]
NMI backtrace for cpu 6
CPU: 6 PID: 8915 Comm: kworker/u16:2
Workqueue: dmar_fault dmar_fault_work
Call Trace:$\n'
[..] wait_for_xmitr+0x26/0x8f$\n'
[..] serial8250_console_putchar+0x1c/0x2c$\n'
[..] uart_console_write+0x40/0x4b$\n'
[..] serial8250_console_write+0xe6/0x13f$\n'
[..] call_console_drivers.constprop.13+0xce/0x103$\n'
[..] console_unlock+0x1f8/0x39b$\n'
[..] vprintk_emit+0x39e/0x3e6$\n'
[..] printk+0x4d/0x4f$\n'
[..] dmar_fault+0x1a8/0x1fc$\n'
[..] dmar_fault_work+0x15/0x17$\n'
[..] process_one_work+0x1e8/0x3a9$\n'
[..] worker_thread+0x25d/0x345$\n'
[..] kthread+0xea/0xf2$\n'
[..] ret_from_fork+0x58/0x90$\n'

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/iommu/dmar.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1483,17 +1483,13 @@ irqreturn_t dmar_fault(int irq, void *de
 	int reg, fault_index;
 	u32 fault_status;
 	unsigned long flag;
-	bool ratelimited;
 	static DEFINE_RATELIMIT_STATE(rs,
 				      DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
 
-	/* Disable printing, simply clear the fault when ratelimited */
-	ratelimited = !__ratelimit(&rs);
-
 	raw_spin_lock_irqsave(&iommu->register_lock, flag);
 	fault_status = readl(iommu->reg + DMAR_FSTS_REG);
-	if (fault_status && !ratelimited)
+	if (fault_status && __ratelimit(&rs))
 		pr_err("DRHD: handling fault status reg %x\n", fault_status);
 
 	/* TBD: ignore advanced fault log currently */
@@ -1503,6 +1499,8 @@ irqreturn_t dmar_fault(int irq, void *de
 	fault_index = dma_fsts_fault_record_index(fault_status);
 	reg = cap_fault_reg_offset(iommu->cap);
 	while (1) {
+		/* Disable printing, simply clear the fault when ratelimited */
+		bool ratelimited = !__ratelimit(&rs);
 		u8 fault_reason;
 		u16 source_id;
 		u64 guest_addr;

