Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754205AbeBLQsk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:48:40 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53198 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754096AbeBLQsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:48:35 -0500
X-Google-Smtp-Source: AH8x227A2YRDK4AYxbxjUriHheS34w4sFqAxGW5KkeznkrJdVGVtZLa4EPLjWYMXPMEbcTPGq3lBzg==
From: Dmitry Safonov <dima@arista.com>
To: linux-kernel@vger.kernel.org
Cc: 0x7f454c46@gmail.com, Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org
Subject: [PATCHv2 6/6] iommu/intel: Ratelimit each dmar fault printing
Date: Mon, 12 Feb 2018 16:48:25 +0000
Message-Id: <20180212164825.22421-7-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180212164825.22421-1-dima@arista.com>
References: <20180212164825.22421-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a ratelimit for printing, but it's incremented each time the
cpu recives dmar fault interrupt. While one interrupt may signal about
*many* faults. And delayed to wq dmar fault work might receive even
more faults to clean, than it was earlier.

Ratelimit each fault printing rather than each time the wq is scheduled.

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

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/iommu/dmar.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 37a1147a7592..7df69f410589 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1640,17 +1640,14 @@ void dmar_serve_faults(struct intel_iommu *iommu)
 	int reg, fault_index;
 	u32 fault_status;
 	unsigned long flag;
-	bool ratelimited;
 	static DEFINE_RATELIMIT_STATE(rs,
 				      DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
 
-	/* Disable printing, simply clear the fault when ratelimited */
-	ratelimited = !__ratelimit(&rs);
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flag);
 	fault_status = readl(iommu->reg + DMAR_FSTS_REG);
-	if (fault_status && !ratelimited)
+	if (fault_status && __ratelimit(&rs))
 		pr_err("DRHD: handling fault status reg %x\n", fault_status);
 
 	/* TBD: ignore advanced fault log currently */
@@ -1660,6 +1657,8 @@ void dmar_serve_faults(struct intel_iommu *iommu)
 	fault_index = dma_fsts_fault_record_index(fault_status);
 	reg = cap_fault_reg_offset(iommu->cap);
 	while (1) {
+		/* Disable printing, simply clear the fault when ratelimited */
+		bool ratelimited = __ratelimit(&rs);
 		u8 fault_reason;
 		u16 source_id;
 		u64 guest_addr;
-- 
2.13.6
