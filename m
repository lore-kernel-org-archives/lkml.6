Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180C4C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D801C20660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977500;
	bh=BO7ZNYvt0g9Ws8A977AUJjmcnc5ifS8dxfWtob8J+rQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aGYYQoH5RKTngC3Bb6TGM6/i7Sp/99oYXjP66y88ecRTg6zvvp8vndSS0JMllWafh
	 YuG77phZZdOEtrH2flQyDfzB//E0WXij5m+CzvCky/ZnAMLEnK9C20LpEQpOxNzfTh
	 hn9Seg4CJMDPmw3RAxxbMB0LtdPVCWdzLO9wBH2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfAHT3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:29:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730412AbfAHT3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:29:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FCE0218A1;
        Tue,  8 Jan 2019 19:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975770;
        bh=BO7ZNYvt0g9Ws8A977AUJjmcnc5ifS8dxfWtob8J+rQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aaIREmojIJ/Z6IparhvDsVwhxk8Csu7mY+rupIEH8FHtTA9B2UuoJ9e5/gklOBofv
         Ml/InzDrJq0Hc+3K6YJvN2bV80Ggk99JVmnJLKof9zZpklyvh+POS5dEgs/Kx+YDzT
         iggggWuQEeDzGgN+c+WYdD2NJy9uiXuwf4RSq3NQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ivan Mironov <mironov.ivan@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 111/117] bnx2x: Fix NULL pointer dereference in bnx2x_del_all_vlans() on some hw
Date:   Tue,  8 Jan 2019 14:26:19 -0500
Message-Id: <20190108192628.121270-111-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index b164f705709d..3b5b47e98c73 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -9360,10 +9360,16 @@ void bnx2x_chip_cleanup(struct bnx2x *bp, int unload_mode, bool keep_link)
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
-- 
2.19.1

