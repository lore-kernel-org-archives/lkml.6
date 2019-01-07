Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49007C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DB52147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864446;
	bh=J8kPKhkdjZxP526+ZWcTxR88dMiqS/bxql/wH69bMXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w3doxwMOexpgDONZVo7cOcZKlPLQM7/sqU7p7W1h10exvRDw3868FivR1uNzF6AQF
	 8F3E6RcSM+q0ysZVew4Mcgl2PrajB3xqlWLMePwUHCQ3rPfCTVzLeZaBYS/otXS1b4
	 QHUMToX7agL6fWQMHMyf5rm3nNGUhaRe4vTv1ZrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfAGMeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:34:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfAGMeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:34:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B5E420859;
        Mon,  7 Jan 2019 12:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864442;
        bh=J8kPKhkdjZxP526+ZWcTxR88dMiqS/bxql/wH69bMXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y/1wUg+l9xdXYTS4NyD86KU1bxehEfzFy3RCEGVO1ik3mDnzBoIZFP/8NB51jpjpx
         1T0TTRnynr38nSEN8WkEzTSMNkFKwlZTiJ+fHPjculTDhnbR8PmL1HBowrNrIqzTyc
         JJKVCXjmVSU3RYA9yjQ5Yo5GKV3kkuIacYgYIP6k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ivan Mironov <mironov.ivan@gmail.com>,
        Sudarsana Kalluru <Sudarsana.Kalluru@cavium.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 004/145] bnx2x: Fix NULL pointer dereference in bnx2x_del_all_vlans() on some hw
Date:   Mon,  7 Jan 2019 13:30:41 +0100
Message-Id: <20190107104437.873173296@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Mironov <mironov.ivan@gmail.com>

[ Upstream commit 38355a5f9a22bfa5bd5b1bb79805aca39fa53729 ]

This happened when I tried to boot normal Fedora 29 system with latest
available kernel (from fedora rawhide, plus some unrelated custom
patches):

	BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
	PGD 0 P4D 0
	Oops: 0010 [#1] SMP PTI
	CPU: 6 PID: 1422 Comm: libvirtd Tainted: G          I       4.20.0-0.rc7.git3.hpsa2.1.fc29.x86_64 #1
	Hardware name: HP ProLiant BL460c G6, BIOS I24 05/21/2018
	RIP: 0010:          (null)
	Code: Bad RIP value.
	RSP: 0018:ffffa47ccdc9fbe0 EFLAGS: 00010246
	RAX: 0000000000000000 RBX: 00000000000003e8 RCX: ffffa47ccdc9fbf8
	RDX: ffffa47ccdc9fc00 RSI: ffff97d9ee7b01f8 RDI: ffff97d9f0150b80
	RBP: ffff97d9f0150b80 R08: 0000000000000000 R09: 0000000000000000
	R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
	R13: ffff97d9ef1e53e8 R14: 0000000000000009 R15: ffff97d9f0ac6730
	FS:  00007f4d224ef700(0000) GS:ffff97d9fa200000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: ffffffffffffffd6 CR3: 00000011ece52006 CR4: 00000000000206e0
	Call Trace:
	 ? bnx2x_chip_cleanup+0x195/0x610 [bnx2x]
	 ? bnx2x_nic_unload+0x1e2/0x8f0 [bnx2x]
	 ? bnx2x_reload_if_running+0x24/0x40 [bnx2x]
	 ? bnx2x_set_features+0x79/0xa0 [bnx2x]
	 ? __netdev_update_features+0x244/0x9e0
	 ? netlink_broadcast_filtered+0x136/0x4b0
	 ? netdev_update_features+0x22/0x60
	 ? dev_disable_lro+0x1c/0xe0
	 ? devinet_sysctl_forward+0x1c6/0x211
	 ? proc_sys_call_handler+0xab/0x100
	 ? __vfs_write+0x36/0x1a0
	 ? rcu_read_lock_sched_held+0x79/0x80
	 ? rcu_sync_lockdep_assert+0x2e/0x60
	 ? __sb_start_write+0x14c/0x1b0
	 ? vfs_write+0x159/0x1c0
	 ? vfs_write+0xba/0x1c0
	 ? ksys_write+0x52/0xc0
	 ? do_syscall_64+0x60/0x1f0
	 ? entry_SYSCALL_64_after_hwframe+0x49/0xbe

After some investigation I figured out that recently added cleanup code
tries to call VLAN filtering de-initialization function which exist only
for newer hardware. Corresponding function pointer is not
set (== 0) for older hardware, namely these chips:

	#define CHIP_NUM_57710			0x164e
	#define CHIP_NUM_57711			0x164f
	#define CHIP_NUM_57711E			0x1650

And I have one of those in my test system:

	Broadcom Inc. and subsidiaries NetXtreme II BCM57711E 10-Gigabit PCIe [14e4:1650]

Function bnx2x_init_vlan_mac_fp_objs() from
drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h decides whether to
initialize relevant pointers in bnx2x_sp_objs.vlan_obj or not.

This regression was introduced after v4.20-rc7, and still exists in v4.20
release.

Fixes: 04f05230c5c13 ("bnx2x: Remove configured vlans as part of unload sequence.")
Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
Acked-by: Sudarsana Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -9360,10 +9360,16 @@ void bnx2x_chip_cleanup(struct bnx2x *bp
 		BNX2X_ERR("Failed to schedule DEL commands for UC MACs list: %d\n",
 			  rc);
 
-	/* Remove all currently configured VLANs */
-	rc = bnx2x_del_all_vlans(bp);
-	if (rc < 0)
-		BNX2X_ERR("Failed to delete all VLANs\n");
+	/* The whole *vlan_obj structure may be not initialized if VLAN
+	 * filtering offload is not supported by hardware. Currently this is
+	 * true for all hardware covered by CHIP_IS_E1x().
+	 */
+	if (!CHIP_IS_E1x(bp)) {
+		/* Remove all currently configured VLANs */
+		rc = bnx2x_del_all_vlans(bp);
+		if (rc < 0)
+			BNX2X_ERR("Failed to delete all VLANs\n");
+	}
 
 	/* Disable LLH */
 	if (!CHIP_IS_E1(bp))


