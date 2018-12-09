Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9EDC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C5B20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C5B20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeLIWAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:00:10 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36006 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726698AbeLIVzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:35 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72x-0002iZ-ID; Sun, 09 Dec 2018 21:55:31 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72j-0003bD-1S; Sun, 09 Dec 2018 21:55:17 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Joel Becker" <jlbec@evilplan.org>,
        "Changwei Ge" <ge.changwei@h3c.com>,
        "Junxiao Bi" <junxiao.bi@oracle.com>,
        "Joseph Qi" <jiangqi903@gmail.com>,
        "Mark Fasheh" <mark@fasheh.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.112649231@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 260/328] ocfs2: fix ocfs2 read block panic
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Junxiao Bi <junxiao.bi@oracle.com>

commit 234b69e3e089d850a98e7b3145bd00e9b52b1111 upstream.

While reading block, it is possible that io error return due to underlying
storage issue, in this case, BH_NeedsValidate was left in the buffer head.
Then when reading the very block next time, if it was already linked into
journal, that will trigger the following panic.

[203748.702517] kernel BUG at fs/ocfs2/buffer_head_io.c:342!
[203748.702533] invalid opcode: 0000 [#1] SMP
[203748.702561] Modules linked in: ocfs2 ocfs2_dlmfs ocfs2_stack_o2cb ocfs2_dlm ocfs2_nodemanager ocfs2_stackglue configfs sunrpc dm_switch dm_queue_length dm_multipath bonding be2iscsi iscsi_boot_sysfs bnx2i cnic uio cxgb4i iw_cxgb4 cxgb4 cxgb3i libcxgbi iw_cxgb3 cxgb3 mdio ib_iser rdma_cm ib_cm iw_cm ib_sa ib_mad ib_core ib_addr ipv6 iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi ipmi_devintf iTCO_wdt iTCO_vendor_support dcdbas ipmi_ssif i2c_core ipmi_si ipmi_msghandler acpi_pad pcspkr sb_edac edac_core lpc_ich mfd_core shpchp sg tg3 ptp pps_core ext4 jbd2 mbcache2 sr_mod cdrom sd_mod ahci libahci megaraid_sas wmi dm_mirror dm_region_hash dm_log dm_mod
[203748.703024] CPU: 7 PID: 38369 Comm: touch Not tainted 4.1.12-124.18.6.el6uek.x86_64 #2
[203748.703045] Hardware name: Dell Inc. PowerEdge R620/0PXXHP, BIOS 2.5.2 01/28/2015
[203748.703067] task: ffff880768139c00 ti: ffff88006ff48000 task.ti: ffff88006ff48000
[203748.703088] RIP: 0010:[<ffffffffa05e9f09>]  [<ffffffffa05e9f09>] ocfs2_read_blocks+0x669/0x7f0 [ocfs2]
[203748.703130] RSP: 0018:ffff88006ff4b818  EFLAGS: 00010206
[203748.703389] RAX: 0000000008620029 RBX: ffff88006ff4b910 RCX: 0000000000000000
[203748.703885] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 00000000023079fe
[203748.704382] RBP: ffff88006ff4b8d8 R08: 0000000000000000 R09: ffff8807578c25b0
[203748.704877] R10: 000000000f637376 R11: 000000003030322e R12: 0000000000000000
[203748.705373] R13: ffff88006ff4b910 R14: ffff880732fe38f0 R15: 0000000000000000
[203748.705871] FS:  00007f401992c700(0000) GS:ffff880bfebc0000(0000) knlGS:0000000000000000
[203748.706370] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[203748.706627] CR2: 00007f4019252440 CR3: 00000000a621e000 CR4: 0000000000060670
[203748.707124] Stack:
[203748.707371]  ffff88006ff4b828 ffffffffa0609f52 ffff88006ff4b838 0000000000000001
[203748.707885]  0000000000000000 0000000000000000 ffff880bf67c3800 ffffffffa05eca00
[203748.708399]  00000000023079ff ffffffff81c58b80 0000000000000000 0000000000000000
[203748.708915] Call Trace:
[203748.709175]  [<ffffffffa0609f52>] ? ocfs2_inode_cache_io_unlock+0x12/0x20 [ocfs2]
[203748.709680]  [<ffffffffa05eca00>] ? ocfs2_empty_dir_filldir+0x80/0x80 [ocfs2]
[203748.710185]  [<ffffffffa05ec0cb>] ocfs2_read_dir_block_direct+0x3b/0x200 [ocfs2]
[203748.710691]  [<ffffffffa05f0fbf>] ocfs2_prepare_dx_dir_for_insert.isra.57+0x19f/0xf60 [ocfs2]
[203748.711204]  [<ffffffffa065660f>] ? ocfs2_metadata_cache_io_unlock+0x1f/0x30 [ocfs2]
[203748.711716]  [<ffffffffa05f4f3a>] ocfs2_prepare_dir_for_insert+0x13a/0x890 [ocfs2]
[203748.712227]  [<ffffffffa05f442e>] ? ocfs2_check_dir_for_entry+0x8e/0x140 [ocfs2]
[203748.712737]  [<ffffffffa061b2f2>] ocfs2_mknod+0x4b2/0x1370 [ocfs2]
[203748.713003]  [<ffffffffa061c385>] ocfs2_create+0x65/0x170 [ocfs2]
[203748.713263]  [<ffffffff8121714b>] vfs_create+0xdb/0x150
[203748.713518]  [<ffffffff8121b225>] do_last+0x815/0x1210
[203748.713772]  [<ffffffff812192e9>] ? path_init+0xb9/0x450
[203748.714123]  [<ffffffff8121bca0>] path_openat+0x80/0x600
[203748.714378]  [<ffffffff811bcd45>] ? handle_pte_fault+0xd15/0x1620
[203748.714634]  [<ffffffff8121d7ba>] do_filp_open+0x3a/0xb0
[203748.714888]  [<ffffffff8122a767>] ? __alloc_fd+0xa7/0x130
[203748.715143]  [<ffffffff81209ffc>] do_sys_open+0x12c/0x220
[203748.715403]  [<ffffffff81026ddb>] ? syscall_trace_enter_phase1+0x11b/0x180
[203748.715668]  [<ffffffff816f0c9f>] ? system_call_after_swapgs+0xe9/0x190
[203748.715928]  [<ffffffff8120a10e>] SyS_open+0x1e/0x20
[203748.716184]  [<ffffffff816f0d5e>] system_call_fastpath+0x18/0xd7
[203748.716440] Code: 00 00 48 8b 7b 08 48 83 c3 10 45 89 f8 44 89 e1 44 89 f2 4c 89 ee e8 07 06 11 e1 48 8b 03 48 85 c0 75 df 8b 5d c8 e9 4d fa ff ff <0f> 0b 48 8b 7d a0 e8 dc c6 06 00 48 b8 00 00 00 00 00 00 00 10
[203748.717505] RIP  [<ffffffffa05e9f09>] ocfs2_read_blocks+0x669/0x7f0 [ocfs2]
[203748.717775]  RSP <ffff88006ff4b818>

Joesph ever reported a similar panic.
Link: https://oss.oracle.com/pipermail/ocfs2-devel/2013-May/008931.html

Link: http://lkml.kernel.org/r/20180912063207.29484-1-junxiao.bi@oracle.com
Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Joseph Qi <jiangqi903@gmail.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Changwei Ge <ge.changwei@h3c.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ocfs2/buffer_head_io.c | 1 +
 1 file changed, 1 insertion(+)

--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -330,6 +330,7 @@ int ocfs2_read_blocks(struct ocfs2_cachi
 				 * for this bh as it's not marked locally
 				 * uptodate. */
 				status = -EIO;
+				clear_buffer_needs_validate(bh);
 				put_bh(bh);
 				bhs[i] = NULL;
 				continue;

