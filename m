Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9219C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0AD20883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975937;
	bh=zevY3+wAu88LBB6jMPWZ5VmI1l7UZQyK2sFYdci0kjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cZ27JBh5aJfROjVNdhcH/gjGMUKZcP3gUTnnPtms8+8V1cHUsqqr55l6SmJW188vu
	 wRHZnYz9FzBC43XC8aMLLano0uKkfY4gWyOA1p18jajEdYCBfzCDgVRTTDaBmCT3c6
	 6pVFKnqCQBv4BAuZ67adga1buA0TWYbJ2N6ZD8+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbfAHTcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:32:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:40596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730434AbfAHTcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:32:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 555EB2176F;
        Tue,  8 Jan 2019 19:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975931;
        bh=zevY3+wAu88LBB6jMPWZ5VmI1l7UZQyK2sFYdci0kjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jI0IXJWxWcYF/71v6WKnmGPkJnYXULCnUUdUzn3gOyer5R9uDtMKUn7DjAXpH5T96
         l8IuC8rSyuodlMeXolc26t/OR5q900FRP663xEkAdp+PsromleeYlE28QLMGHJI6iy
         6OBCvbKBQ8I5SY5JbMfqKqUPJn1X4TCoNsGsBkPg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Junxiao Bi <junxiao.bi@oracle.com>, Jun Piao <piaojun@huawei.com>,
        Mark Fasheh <mfasheh@versity.com>,
        Joel Becker <jlbec@evilplan.org>,
        Changwei Ge <ge.changwei@h3c.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 93/97] ocfs2: fix panic due to unrecovered local alloc
Date:   Tue,  8 Jan 2019 14:29:42 -0500
Message-Id: <20190108192949.122407-93-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junxiao Bi <junxiao.bi@oracle.com>

[ Upstream commit 532e1e54c8140188e192348c790317921cb2dc1c ]

mount.ocfs2 ignore the inconsistent error that journal is clean but
local alloc is unrecovered.  After mount, local alloc not empty, then
reserver cluster didn't alloc a new local alloc window, reserveration
map is empty(ocfs2_reservation_map.m_bitmap_len = 0), that triggered the
following panic.

This issue was reported at

  https://oss.oracle.com/pipermail/ocfs2-devel/2015-May/010854.html

and was advised to fixed during mount.  But this is a very unusual
inconsistent state, usually journal dirty flag should be cleared at the
last stage of umount until every other things go right.  We may need do
further debug to check that.  Any way to avoid possible futher
corruption, mount should be abort and fsck should be run.

  (mount.ocfs2,1765,1):ocfs2_load_local_alloc:353 ERROR: Local alloc hasn't been recovered!
  found = 6518, set = 6518, taken = 8192, off = 15912372
  ocfs2: Mounting device (202,64) on (node 0, slot 3) with ordered data mode.
  o2dlm: Joining domain 89CEAC63CC4F4D03AC185B44E0EE0F3F ( 0 1 2 3 4 5 6 8 ) 8 nodes
  ocfs2: Mounting device (202,80) on (node 0, slot 3) with ordered data mode.
  o2hb: Region 89CEAC63CC4F4D03AC185B44E0EE0F3F (xvdf) is now a quorum device
  o2net: Accepted connection from node yvwsoa17p (num 7) at 172.22.77.88:7777
  o2dlm: Node 7 joins domain 64FE421C8C984E6D96ED12C55FEE2435 ( 0 1 2 3 4 5 6 7 8 ) 9 nodes
  o2dlm: Node 7 joins domain 89CEAC63CC4F4D03AC185B44E0EE0F3F ( 0 1 2 3 4 5 6 7 8 ) 9 nodes
  ------------[ cut here ]------------
  kernel BUG at fs/ocfs2/reservations.c:507!
  invalid opcode: 0000 [#1] SMP
  Modules linked in: ocfs2 rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs fscache lockd grace ocfs2_dlmfs ocfs2_stack_o2cb ocfs2_dlm ocfs2_nodemanager ocfs2_stackglue configfs sunrpc ipt_REJECT nf_reject_ipv4 nf_conntrack_ipv4 nf_defrag_ipv4 iptable_filter ip_tables ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables ib_ipoib rdma_ucm ib_ucm ib_uverbs ib_umad rdma_cm ib_cm iw_cm ib_sa ib_mad ib_core ib_addr ipv6 ovmapi ppdev parport_pc parport xen_netfront fb_sys_fops sysimgblt sysfillrect syscopyarea acpi_cpufreq pcspkr i2c_piix4 i2c_core sg ext4 jbd2 mbcache2 sr_mod cdrom xen_blkfront pata_acpi ata_generic ata_piix floppy dm_mirror dm_region_hash dm_log dm_mod
  CPU: 0 PID: 4349 Comm: startWebLogic.s Not tainted 4.1.12-124.19.2.el6uek.x86_64 #2
  Hardware name: Xen HVM domU, BIOS 4.4.4OVM 09/06/2018
  task: ffff8803fb04e200 ti: ffff8800ea4d8000 task.ti: ffff8800ea4d8000
  RIP: 0010:[<ffffffffa05e96a8>]  [<ffffffffa05e96a8>] __ocfs2_resv_find_window+0x498/0x760 [ocfs2]
  Call Trace:
    ocfs2_resmap_resv_bits+0x10d/0x400 [ocfs2]
    ocfs2_claim_local_alloc_bits+0xd0/0x640 [ocfs2]
    __ocfs2_claim_clusters+0x178/0x360 [ocfs2]
    ocfs2_claim_clusters+0x1f/0x30 [ocfs2]
    ocfs2_convert_inline_data_to_extents+0x634/0xa60 [ocfs2]
    ocfs2_write_begin_nolock+0x1c6/0x1da0 [ocfs2]
    ocfs2_write_begin+0x13e/0x230 [ocfs2]
    generic_perform_write+0xbf/0x1c0
    __generic_file_write_iter+0x19c/0x1d0
    ocfs2_file_write_iter+0x589/0x1360 [ocfs2]
    __vfs_write+0xb8/0x110
    vfs_write+0xa9/0x1b0
    SyS_write+0x46/0xb0
    system_call_fastpath+0x18/0xd7
  Code: ff ff 8b 75 b8 39 75 b0 8b 45 c8 89 45 98 0f 84 e5 fe ff ff 45 8b 74 24 18 41 8b 54 24 1c e9 56 fc ff ff 85 c0 0f 85 48 ff ff ff <0f> 0b 48 8b 05 cf c3 de ff 48 ba 00 00 00 00 00 00 00 10 48 85
  RIP   __ocfs2_resv_find_window+0x498/0x760 [ocfs2]
   RSP <ffff8800ea4db668>
  ---[ end trace 566f07529f2edf3c ]---
  Kernel panic - not syncing: Fatal exception
  Kernel Offset: disabled

Link: http://lkml.kernel.org/r/20181121020023.3034-2-junxiao.bi@oracle.com
Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
Reviewed-by: Yiwen Jiang <jiangyiwen@huawei.com>
Acked-by: Joseph Qi <jiangqi903@gmail.com>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Mark Fasheh <mfasheh@versity.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Changwei Ge <ge.changwei@h3c.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/localalloc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
index 7642b6712c39..30208233f65b 100644
--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -345,13 +345,18 @@ int ocfs2_load_local_alloc(struct ocfs2_super *osb)
 	if (num_used
 	    || alloc->id1.bitmap1.i_used
 	    || alloc->id1.bitmap1.i_total
-	    || la->la_bm_off)
-		mlog(ML_ERROR, "Local alloc hasn't been recovered!\n"
+	    || la->la_bm_off) {
+		mlog(ML_ERROR, "inconsistent detected, clean journal with"
+		     " unrecovered local alloc, please run fsck.ocfs2!\n"
 		     "found = %u, set = %u, taken = %u, off = %u\n",
 		     num_used, le32_to_cpu(alloc->id1.bitmap1.i_used),
 		     le32_to_cpu(alloc->id1.bitmap1.i_total),
 		     OCFS2_LOCAL_ALLOC(alloc)->la_bm_off);
 
+		status = -EINVAL;
+		goto bail;
+	}
+
 	osb->local_alloc_bh = alloc_bh;
 	osb->local_alloc_state = OCFS2_LA_ENABLED;
 
-- 
2.19.1

