Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DEFC43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A5A2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A5A2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbeKLGGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:06:24 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53240 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729587AbeKLGGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:06:24 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsx-0000lK-8W; Sun, 11 Nov 2018 19:59:07 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsU-0001dd-Ed; Sun, 11 Nov 2018 19:58:38 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Leon Romanovsky" <leonro@mellanox.com>,
        "Noa Osherovich" <noaos@mellanox.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        "syzkaller" <syzkaller@googlegroups.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.961415026@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 199/366] RDMA/uverbs: Fix slab-out-of-bounds in
 ib_uverbs_ex_create_flow
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

From: Leon Romanovsky <leonro@mellanox.com>

commit 4fae7f170416f970e5655f7e945ce69286b1c4ff upstream.

The check of cmd.flow_attr.size should check into account the size of the
reserved field (2 bytes), otherwise user can provide a size which will
cause a slab-out-of-bounds warning below.

==================================================================
BUG: KASAN: slab-out-of-bounds in ib_uverbs_ex_create_flow+0x1740/0x1d00
Read of size 2 at addr ffff880068dff1a6 by task syz-executor775/269

CPU: 0 PID: 269 Comm: syz-executor775 Not tainted 4.18.0-rc1+ #245
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.11.0-0-g63451fca13-prebuilt.qemu-project.org 04/01/2014
Call Trace:
 dump_stack+0xef/0x17e
 print_address_description+0x83/0x3b0
 kasan_report+0x18d/0x4d0
 ib_uverbs_ex_create_flow+0x1740/0x1d00
 ib_uverbs_write+0x923/0x1010
 __vfs_write+0x10d/0x720
 vfs_write+0x1b0/0x550
 ksys_write+0xc6/0x1a0
 do_syscall_64+0xa7/0x590
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x433899
Code: fd ff 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 89
f7 48 89 d6 48 89 ca 4d 89 c2 4d
89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 3b 91 fd ff c3 66
2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc2724db58 EFLAGS: 00000217 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000020006880 RCX: 0000000000433899
RDX: 00000000000000e0 RSI: 0000000020002480 RDI: 0000000000000003
RBP: 00000000006d7018 R08: 00000000004002f8 R09: 00000000004002f8
R10: 00000000004002f8 R11: 0000000000000217 R12: 0000000000000000

R13: 000000000040cd20 R14: 000000000040cdb0 R15: 0000000000000006

Allocated by task 269:
 kasan_kmalloc+0xa0/0xd0
 __kmalloc+0x1a9/0x510
 ib_uverbs_ex_create_flow+0x26c/0x1d00
 ib_uverbs_write+0x923/0x1010
 __vfs_write+0x10d/0x720
 vfs_write+0x1b0/0x550
 ksys_write+0xc6/0x1a0
 do_syscall_64+0xa7/0x590
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 0:
 __kasan_slab_free+0x12e/0x180
 kfree+0x159/0x630
 detach_buf+0x559/0x7a0
 virtqueue_get_buf_ctx+0x3cc/0xab0
 virtblk_done+0x1eb/0x3d0
 vring_interrupt+0x16d/0x2b0
 __handle_irq_event_percpu+0x10a/0x980
 handle_irq_event_percpu+0x77/0x190
 handle_irq_event+0xc6/0x1a0
 handle_edge_irq+0x211/0xd80
 handle_irq+0x3d/0x60
 do_IRQ+0x9b/0x220

The buggy address belongs to the object at ffff880068dff180
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 38 bytes inside of
 64-byte region [ffff880068dff180, ffff880068dff1c0)
The buggy address belongs to the page:
page:ffffea0001a37fc0 count:1 mapcount:0 mapping:ffff88006c401780
index:0x0
flags: 0x4000000000000100(slab)
raw: 4000000000000100 ffffea0001a31100 0000001100000011 ffff88006c401780
raw: 0000000000000000 00000000802a002a 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff880068dff080: fb fb fb fb fc fc fc fc fb fb fb fb fb fb fb fb
 ffff880068dff100: fc fc fc fc fb fb fb fb fb fb fb fb fc fc fc fc
>ffff880068dff180: 00 00 00 00 07 fc fc fc fc fc fc fc fb fb fb fb
                               ^
 ffff880068dff200: fb fb fb fb fc fc fc fc 00 00 00 00 00 00 fc fc
 ffff880068dff280: fc fc fc fc 00 00 00 00 00 00 00 00 fc fc fc fc
==================================================================

Fixes: f88482743872 ("IB/core: clarify overflow/underflow checks on ib_create/destroy_flow")
Cc: syzkaller <syzkaller@googlegroups.com>
Reported-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/core/uverbs_cmd.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2674,8 +2674,8 @@ int ib_uverbs_ex_create_flow(struct ib_u
 	struct ib_uverbs_flow_attr	  *kern_flow_attr;
 	struct ib_flow_attr		  *flow_attr;
 	struct ib_qp			  *qp;
+	struct ib_uverbs_flow_spec_hdr	  *kern_spec;
 	int err = 0;
-	void *kern_spec;
 	void *ib_spec;
 	int i;
 
@@ -2717,8 +2717,8 @@ int ib_uverbs_ex_create_flow(struct ib_u
 		if (!kern_flow_attr)
 			return -ENOMEM;
 
-		memcpy(kern_flow_attr, &cmd.flow_attr, sizeof(*kern_flow_attr));
-		err = ib_copy_from_udata(kern_flow_attr + 1, ucore,
+		*kern_flow_attr = cmd.flow_attr;
+		err = ib_copy_from_udata(&kern_flow_attr->flow_specs, ucore,
 					 cmd.flow_attr.size);
 		if (err)
 			goto err_free_attr;
@@ -2758,19 +2758,21 @@ int ib_uverbs_ex_create_flow(struct ib_u
 	flow_attr->flags = kern_flow_attr->flags;
 	flow_attr->size = sizeof(*flow_attr);
 
-	kern_spec = kern_flow_attr + 1;
+	kern_spec = kern_flow_attr->flow_specs;
 	ib_spec = flow_attr + 1;
 	for (i = 0; i < flow_attr->num_of_specs &&
-	     cmd.flow_attr.size > offsetof(struct ib_uverbs_flow_spec, reserved) &&
-	     cmd.flow_attr.size >=
-	     ((struct ib_uverbs_flow_spec *)kern_spec)->size; i++) {
-		err = kern_spec_to_ib_spec(kern_spec, ib_spec);
+			cmd.flow_attr.size > sizeof(*kern_spec) &&
+			cmd.flow_attr.size >= kern_spec->size;
+	     i++) {
+		err = kern_spec_to_ib_spec(
+				(struct ib_uverbs_flow_spec *)kern_spec,
+				ib_spec);
 		if (err)
 			goto err_free;
 		flow_attr->size +=
 			((union ib_flow_spec *) ib_spec)->size;
-		cmd.flow_attr.size -= ((struct ib_uverbs_flow_spec *)kern_spec)->size;
-		kern_spec += ((struct ib_uverbs_flow_spec *) kern_spec)->size;
+		cmd.flow_attr.size -= kern_spec->size;
+		kern_spec = ((void *)kern_spec) + kern_spec->size;
 		ib_spec += ((union ib_flow_spec *) ib_spec)->size;
 	}
 	if (cmd.flow_attr.size || (i != flow_attr->num_of_specs)) {

