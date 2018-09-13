Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2BCC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E512620854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E512620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbeIMTEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:04:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33912 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbeIMTEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:04:30 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 711C6D1A;
        Thu, 13 Sep 2018 13:54:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tariq Toukan <tariqt@mellanox.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 066/197] net/xdp: Fix suspicious RCU usage warning
Date:   Thu, 13 Sep 2018 15:30:15 +0200
Message-Id: <20180913131844.162508679@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tariq Toukan <tariqt@mellanox.com>

[ Upstream commit 21b172ee11b6ec260bd7e6a27b11a8a8d392fce5 ]

Fix the warning below by calling rhashtable_lookup_fast.
Also, make some code movements for better quality and human
readability.

[  342.450870] WARNING: suspicious RCU usage
[  342.455856] 4.18.0-rc2+ #17 Tainted: G           O
[  342.462210] -----------------------------
[  342.467202] ./include/linux/rhashtable.h:481 suspicious rcu_dereference_check() usage!
[  342.476568]
[  342.476568] other info that might help us debug this:
[  342.476568]
[  342.486978]
[  342.486978] rcu_scheduler_active = 2, debug_locks = 1
[  342.495211] 4 locks held by modprobe/3934:
[  342.500265]  #0: 00000000e23116b2 (mlx5_intf_mutex){+.+.}, at:
mlx5_unregister_interface+0x18/0x90 [mlx5_core]
[  342.511953]  #1: 00000000ca16db96 (rtnl_mutex){+.+.}, at: unregister_netdev+0xe/0x20
[  342.521109]  #2: 00000000a46e2c4b (&priv->state_lock){+.+.}, at: mlx5e_close+0x29/0x60
[mlx5_core]
[  342.531642]  #3: 0000000060c5bde3 (mem_id_lock){+.+.}, at: xdp_rxq_info_unreg+0x93/0x6b0
[  342.541206]
[  342.541206] stack backtrace:
[  342.547075] CPU: 12 PID: 3934 Comm: modprobe Tainted: G           O      4.18.0-rc2+ #17
[  342.556621] Hardware name: Dell Inc. PowerEdge R730/0H21J3, BIOS 1.5.4 10/002/2015
[  342.565606] Call Trace:
[  342.568861]  dump_stack+0x78/0xb3
[  342.573086]  xdp_rxq_info_unreg+0x3f5/0x6b0
[  342.578285]  ? __call_rcu+0x220/0x300
[  342.582911]  mlx5e_free_rq+0x38/0xc0 [mlx5_core]
[  342.588602]  mlx5e_close_channel+0x20/0x120 [mlx5_core]
[  342.594976]  mlx5e_close_channels+0x26/0x40 [mlx5_core]
[  342.601345]  mlx5e_close_locked+0x44/0x50 [mlx5_core]
[  342.607519]  mlx5e_close+0x42/0x60 [mlx5_core]
[  342.613005]  __dev_close_many+0xb1/0x120
[  342.617911]  dev_close_many+0xa2/0x170
[  342.622622]  rollback_registered_many+0x148/0x460
[  342.628401]  ? __lock_acquire+0x48d/0x11b0
[  342.633498]  ? unregister_netdev+0xe/0x20
[  342.638495]  rollback_registered+0x56/0x90
[  342.643588]  unregister_netdevice_queue+0x7e/0x100
[  342.649461]  unregister_netdev+0x18/0x20
[  342.654362]  mlx5e_remove+0x2a/0x50 [mlx5_core]
[  342.659944]  mlx5_remove_device+0xe5/0x110 [mlx5_core]
[  342.666208]  mlx5_unregister_interface+0x39/0x90 [mlx5_core]
[  342.673038]  cleanup+0x5/0xbfc [mlx5_core]
[  342.678094]  __x64_sys_delete_module+0x16b/0x240
[  342.683725]  ? do_syscall_64+0x1c/0x210
[  342.688476]  do_syscall_64+0x5a/0x210
[  342.693025]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: 8d5d88527587 ("xdp: rhashtable with allocator ID to pointer mapping")
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/xdp.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -95,23 +95,15 @@ static void __xdp_rxq_info_unreg_mem_mod
 {
 	struct xdp_mem_allocator *xa;
 	int id = xdp_rxq->mem.id;
-	int err;
 
 	if (id == 0)
 		return;
 
 	mutex_lock(&mem_id_lock);
 
-	xa = rhashtable_lookup(mem_id_ht, &id, mem_id_rht_params);
-	if (!xa) {
-		mutex_unlock(&mem_id_lock);
-		return;
-	}
-
-	err = rhashtable_remove_fast(mem_id_ht, &xa->node, mem_id_rht_params);
-	WARN_ON(err);
-
-	call_rcu(&xa->rcu, __xdp_mem_allocator_rcu_free);
+	xa = rhashtable_lookup_fast(mem_id_ht, &id, mem_id_rht_params);
+	if (xa && !rhashtable_remove_fast(mem_id_ht, &xa->node, mem_id_rht_params))
+		call_rcu(&xa->rcu, __xdp_mem_allocator_rcu_free);
 
 	mutex_unlock(&mem_id_lock);
 }


