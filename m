Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091FFC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88C2205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88C2205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbeLFIKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:10:25 -0500
Received: from 5.mo68.mail-out.ovh.net ([46.105.62.179]:46197 "EHLO
        5.mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbeLFIKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:10:25 -0500
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Dec 2018 03:10:24 EST
Received: from player794.ha.ovh.net (unknown [10.109.159.224])
        by mo68.mail-out.ovh.net (Postfix) with ESMTP id 9CAF6108F30
        for <linux-kernel@vger.kernel.org>; Thu,  6 Dec 2018 08:54:08 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player794.ha.ovh.net (Postfix) with ESMTPSA id 34E1A8CF98C;
        Thu,  6 Dec 2018 07:54:04 +0000 (UTC)
Subject: [PATCH] radix tree: Don't return internal entries on lookup
From:   Greg Kurz <groug@kaod.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>, Josef Bacik <jbacik@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date:   Thu, 06 Dec 2018 08:54:03 +0100
Message-ID: <154408284374.405977.5950625525821388567.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15393303528984648057
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtkedrudefiedguddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 66ee620f06f9 ("idr: Permit any valid kernel pointer to
be stored") changed the radix tree lookup so that it stops when
reaching the bottom of the tree. But radix_tree_descend() may have
changed the node variable to point to an internal entry which then
gets returned to the caller and bad things may happen.

For example, the OCXL driver can easily crash when running tests
that cause radix_tree_lookup() to return RADIX_TREE_RETRY at some
point instead of NULL or a valid pointer, as shown below:

Unable to handle kernel paging request for data at address 0x00000406
Faulting instruction address: 0xc0000000006f6ca0
Oops: Kernel access of bad area, sig: 7 [#1]
LE SMP NR_CPUS=2048 NUMA PowerNV
Modules linked in:
CPU: 10 PID: 0 Comm: swapper/10 Not tainted 4.20.0-rc5-fxb-dirty #1
NIP:  c0000000006f6ca0 LR: c0000000006f6c90 CTR: c0000000006f6b80
REGS: c0000007bff23a80 TRAP: 0300   Not tainted  (4.20.0-rc5-fxb-dirty)
MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 48004422  XER: 20040000
CFAR: c000000000aebbe4 DAR: 0000000000000406 DSISR: 00080000 IRQMASK: 1
GPR00: c000000712ff0a38 c0000007bff23d10 c000000001025a00 0000000000000406
GPR04: 0000000000000000 0000000000000000 0000000000000000 c0000007182f8d70
GPR08: 0000000000000406 c0000007182f8d98 00000000004d0008 fffffffffffffffd
GPR12: 0000000000000040 c0000007bfff4200 c0000000047d7f90 000000000a205200
GPR16: 0000000000000000 0000000000000001 0000000000000008 c000000000044480
GPR20: c000000001060174 0000000000000001 0000000000000002 0000000000000001
GPR24: 0000000000000097 c00000002d613000 00007fff92230000 10000000020000b4
GPR28: c00000002d800000 0000000000000000 000000004d000800 c000000712ff0a00
NIP [c0000000006f6ca0] xsl_fault_handler+0x120/0x310
LR [c0000000006f6c90] xsl_fault_handler+0x110/0x310
Call Trace:
[c0000007bff23d10] [c0000000006f6d7c] xsl_fault_handler+0x1fc/0x310 (unreliable)
[c0000007bff23da0] [c000000000164e8c] __handle_irq_event_percpu+0x9c/0x2f0
[c0000007bff23e60] [c000000000165124] handle_irq_event_percpu+0x44/0xc0
[c0000007bff23ea0] [c000000000165204] handle_irq_event+0x64/0xb0
[c0000007bff23ed0] [c00000000016af68] handle_fasteoi_irq+0xd8/0x230
[c0000007bff23f00] [c00000000016356c] generic_handle_irq+0x4c/0x70
[c0000007bff23f20] [c00000000001a394] __do_irq+0xa4/0x210
[c0000007bff23f90] [c00000000002e3f4] call_do_irq+0x14/0x24
[c0000000047d7a30] [c00000000001a59c] do_IRQ+0x9c/0x130
[c0000000047d7a80] [c000000000009ce4] h_virt_irq_common+0x124/0x130
--- interrupt: ea1 at snooze_loop+0x138/0x280
    LR = snooze_loop+0x260/0x280
[c0000000047d7d80] [c0000000010600b0] cpu_idle_force_poll+0x0/0x8 (unreliable)
[c0000000047d7dc0] [c000000000904b98] cpuidle_enter_state+0xa8/0x4c0
[c0000000047d7e30] [c00000000012c3dc] call_cpuidle+0x4c/0x80
[c0000000047d7e50] [c00000000012c98c] do_idle+0x2cc/0x370
[c0000000047d7ec0] [c00000000012cc88] cpu_startup_entry+0x38/0x40
[c0000000047d7ef0] [c000000000046b54] start_secondary+0x664/0x670
[c0000000047d7f90] [c00000000000ac70] start_secondary_prolog+0x10/0x14
Instruction dump:
418201c8 7ba93e24 7fa4eb78 387f0030 fbc10080 7f9c4a14 83dc003c 483f4fed
60000000 7c681b79 41820058 57cac03e <e9280000> 53ca421e 53ca463e 7d4707b4
---[ end trace d17a5522f20aacd2 ]---

Kernel panic - not syncing: Aiee, killing interrupt handler!

Code is:

static irqreturn_t xsl_fault_handler(int irq, void *data)
{
	...
	rcu_read_lock();
	pe_data = radix_tree_lookup(&spa->pe_tree, pe_handle);
	if (!pe_data) {
		...
	}
	WARN_ON(pe_data->mm->context.id != pid);

pe_data is equal to R3 which is the return value of radix_tree_lookup(),
ie, 0x406 == RADIX_TREE_RETRY.

Fix this by not breaking out of the loop if the node points to an internal
entry.

Fixes: 66ee620f06f9 ("idr: Permit any valid kernel pointer to be stored")
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 lib/radix-tree.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 1106bb6aa01e..462a71962a0e 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -789,7 +789,7 @@ void *__radix_tree_lookup(const struct radix_tree_root *root,
 		parent = entry_to_node(node);
 		offset = radix_tree_descend(parent, &node, index);
 		slot = parent->slots + offset;
-		if (parent->shift == 0)
+		if (!radix_tree_is_internal_node(node) && parent->shift == 0)
 			break;
 	}
 

