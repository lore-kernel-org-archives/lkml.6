Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD09FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3DA21473
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3DA21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeHWL0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:26:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41782 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeHWL0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:26:42 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C3286BB6;
        Thu, 23 Aug 2018 07:58:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Govindarajulu Varadarajan <gvaradar@cisco.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 15/79] enic: initialize enic->rfs_h.lock in enic_probe
Date:   Thu, 23 Aug 2018 09:52:51 +0200
Message-Id: <20180823074919.713777328@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074918.641878835@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Govindarajulu Varadarajan <gvaradar@cisco.com>

[ Upstream commit 3256d29fc7aecdf99feb1cb9475ed2252769a8a7 ]

lockdep spotted that we are using rfs_h.lock in enic_get_rxnfc() without
initializing. rfs_h.lock is initialized in enic_open(). But ethtool_ops
can be called when interface is down.

Move enic_rfs_flw_tbl_init to enic_probe.

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 18 PID: 1189 Comm: ethtool Not tainted 4.17.0-rc7-devel+ #27
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-20171110_100015-anatol 04/01/2014
Call Trace:
dump_stack+0x85/0xc0
register_lock_class+0x550/0x560
? __handle_mm_fault+0xa8b/0x1100
__lock_acquire+0x81/0x670
lock_acquire+0xb9/0x1e0
?  enic_get_rxnfc+0x139/0x2b0 [enic]
_raw_spin_lock_bh+0x38/0x80
? enic_get_rxnfc+0x139/0x2b0 [enic]
enic_get_rxnfc+0x139/0x2b0 [enic]
ethtool_get_rxnfc+0x8d/0x1c0
dev_ethtool+0x16c8/0x2400
? __mutex_lock+0x64d/0xa00
? dev_load+0x6a/0x150
dev_ioctl+0x253/0x4b0
sock_do_ioctl+0x9a/0x130
sock_ioctl+0x1af/0x350
do_vfs_ioctl+0x8e/0x670
? syscall_trace_enter+0x1e2/0x380
ksys_ioctl+0x60/0x90
__x64_sys_ioctl+0x16/0x20
do_syscall_64+0x5a/0x170
entry_SYSCALL_64_after_hwframe+0x49/0xbe

Signed-off-by: Govindarajulu Varadarajan <gvaradar@cisco.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cisco/enic/enic_clsf.c |    3 +--
 drivers/net/ethernet/cisco/enic/enic_main.c |    3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/cisco/enic/enic_clsf.c
+++ b/drivers/net/ethernet/cisco/enic/enic_clsf.c
@@ -78,7 +78,6 @@ void enic_rfs_flw_tbl_init(struct enic *
 	enic->rfs_h.max = enic->config.num_arfs;
 	enic->rfs_h.free = enic->rfs_h.max;
 	enic->rfs_h.toclean = 0;
-	enic_rfs_timer_start(enic);
 }
 
 void enic_rfs_flw_tbl_free(struct enic *enic)
@@ -87,7 +86,6 @@ void enic_rfs_flw_tbl_free(struct enic *
 
 	enic_rfs_timer_stop(enic);
 	spin_lock_bh(&enic->rfs_h.lock);
-	enic->rfs_h.free = 0;
 	for (i = 0; i < (1 << ENIC_RFS_FLW_BITSHIFT); i++) {
 		struct hlist_head *hhead;
 		struct hlist_node *tmp;
@@ -98,6 +96,7 @@ void enic_rfs_flw_tbl_free(struct enic *
 			enic_delfltr(enic, n->fltr_id);
 			hlist_del(&n->node);
 			kfree(n);
+			enic->rfs_h.free++;
 		}
 	}
 	spin_unlock_bh(&enic->rfs_h.lock);
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1760,7 +1760,7 @@ static int enic_open(struct net_device *
 		vnic_intr_unmask(&enic->intr[i]);
 
 	enic_notify_timer_start(enic);
-	enic_rfs_flw_tbl_init(enic);
+	enic_rfs_timer_start(enic);
 
 	return 0;
 
@@ -2694,6 +2694,7 @@ static int enic_probe(struct pci_dev *pd
 	enic->notify_timer.function = enic_notify_timer;
 	enic->notify_timer.data = (unsigned long)enic;
 
+	enic_rfs_flw_tbl_init(enic);
 	enic_set_rx_coal_setting(enic);
 	INIT_WORK(&enic->reset, enic_reset);
 	INIT_WORK(&enic->tx_hang_reset, enic_tx_hang_reset);


