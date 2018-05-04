Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbeEDULx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 16:11:53 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:33144 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbeEDULv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 16:11:51 -0400
X-IronPort-AV: E=Sophos;i="5.49,363,1520899200";
   d="scan'208";a="677670960"
From: "van der Linden, Frank" <fllinden@amazon.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "jgross@suse.com" <jgross@suse.com>
Subject: [PATCH 1/1] x86/xen: Reset VCPU0 info pointer after shared_info remap
Thread-Topic: [PATCH 1/1] x86/xen: Reset VCPU0 info pointer after shared_info
 remap
Thread-Index: AQHT4+Qi8Y/Xj7e/qEORkG6cypvfEg==
Date: Fri, 4 May 2018 20:11:48 +0000
Message-ID: <C508E5F5-024E-4F71-A91E-7BB0BE046F5D@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.148]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C217AC964F9C4409F86E98BB544D4F3@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w44KBxbZ010347

This patch fixes crashes during boot for HVM guests on older (pre HVM
vector callback) Xen versions. Without this, current kernels will always
fail to boot on those Xen versions.

Sample stack trace:

   BUG: unable to handle kernel paging request at ffffffffff200000
   IP: __xen_evtchn_do_upcall+0x1e/0x80
   PGD 1e0e067 P4D 1e0e067 PUD 1e10067 PMD 235c067 PTE 0
    Oops: 0002 [#1] SMP PTI
   Modules linked in:
   CPU: 0 PID: 512 Comm: kworker/u2:0 Not tainted 4.14.33-52.13.amzn1.x86_64 #1
   Hardware name: Xen HVM domU, BIOS 3.4.3.amazon 11/11/2016
   task: ffff88002531d700 task.stack: ffffc90000480000
   RIP: 0010:__xen_evtchn_do_upcall+0x1e/0x80
   RSP: 0000:ffff880025403ef0 EFLAGS: 00010046
   RAX: ffffffff813cc760 RBX: ffffffffff200000 RCX: ffffc90000483ef0
   RDX: ffff880020540a00 RSI: ffff880023c78000 RDI: 000000000000001c
   RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
   R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
   R13: ffff880025403f5c R14: 0000000000000000 R15: 0000000000000000
   FS:  0000000000000000(0000) GS:ffff880025400000(0000) knlGS:0000000000000000
   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   CR2: ffffffffff200000 CR3: 0000000001e0a000 CR4: 00000000000006f0
    Call Trace:
   <IRQ>
   do_hvm_evtchn_intr+0xa/0x10
   __handle_irq_event_percpu+0x43/0x1a0
   handle_irq_event_percpu+0x20/0x50
   handle_irq_event+0x39/0x60
   handle_fasteoi_irq+0x80/0x140
   handle_irq+0xaf/0x120
   do_IRQ+0x41/0xd0
   common_interrupt+0x7d/0x7d
   </IRQ>

During boot, the HYPERVISOR_shared_info page gets remapped to make it work
with KASLR. This means that any pointer derived from it needs to be
adjusted.

The only value that this applies to is the vcpu_info pointer for VCPU 0.
For PV and HVM with the callback vector feature, this gets done via the
smp_ops prepare_boot_cpu callback. Older Xen versions do not support the
HVM callback vector, so there is no Xen-specific smp_ops set up in that
scenario. So, the vcpu_info pointer for VCPU 0 never gets set to the proper
value, and the first reference of it will be bad. Fix this by resetting it
immediately after the remap.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
Reviewed-by: Eduardo Valentin <eduval@amazon.com>
Reviewed-by: Alakesh Haloi <alakeshh@amazon.com>
Reviewed-by: Vallish Vaidyeshwara <vallish@amazon.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: xen-devel@lists.xenproject.org
---
 arch/x86/xen/enlighten_hvm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 6b424da1ce75..c78b3e8fb2e5 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -71,6 +71,19 @@ static void __init xen_hvm_init_mem_mapping(void)
 {
 	early_memunmap(HYPERVISOR_shared_info, PAGE_SIZE);
 	HYPERVISOR_shared_info = __va(PFN_PHYS(shared_info_pfn));
+
+	/*
+	 * The virtual address of the shared_info page has changed, so
+	 * the vcpu_info pointer for VCPU 0 is now stale.
+	 *
+	 * The prepare_boot_cpu callback will re-initialize it via
+	 * xen_vcpu_setup, but we can't rely on that to be called for
+	 * old Xen versions (xen_have_vector_callback == 0).
+	 *
+	 * It is, in any case, bad to have a stale vcpu_info pointer
+	 * so reset it now.
+	 */
+	xen_vcpu_info_reset(0);
 }
 
 static void __init init_hvm_pv_info(void)
-- 
2.14.3
