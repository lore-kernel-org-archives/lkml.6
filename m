Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7931C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9605720657
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550955939;
	bh=j1QP8BCY7+yqCoQrihYp7GDZo7mkIehk3g838IRGUn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D8JaEJCxJ7sDxJvJQyYfe//AOizx1jQvrYMz026nZCTgUq5kFbVw2Z7CkAcysK/+/
	 WZxQwY/sYe2lLi5R/LihfM4U3gnVZ3v9jbbLoH5gpyz3W8VGxV56A7suJnYwQ+RS3b
	 FNIpoFOUURqh/VvJe70BTNKTcMkW4tRMFng9NXKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfBWVFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:05:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728420AbfBWVFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:05:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA8C320675;
        Sat, 23 Feb 2019 21:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955934;
        bh=j1QP8BCY7+yqCoQrihYp7GDZo7mkIehk3g838IRGUn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VtYfceVtb3ulm0+HhJcUfLBtWmdmcSnAKj8zcJeFWvTJux6A69lxbqz0t40P4w67f
         qjQZlRVDS2GitMFSM9+BAg+rUhXEfTTgE6M6u5uzcg8Kc1uJKkPgFEnoeR61k10B1a
         s4j/XgsF4+v+3aWt3bR97hjw2hLYPj4nBbQL1t1I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 43/72] qed: Fix bug in tx promiscuous mode settings
Date:   Sat, 23 Feb 2019 16:03:53 -0500
Message-Id: <20190223210422.199966-43-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manish Chopra <manishc@marvell.com>

[ Upstream commit 9e71a15d8b5bbce25c637f7f8833cd3f45b65646 ]

When running tx switched traffic between VNICs
created via a bridge(to which VFs are added),
adapter drops the unicast packets in tx flow due to
VNIC's ucast mac being unknown to it. But VF interfaces
being in promiscuous mode should have caused adapter
to accept all the unknown ucast packets. Later, it
was found that driver doesn't really configure tx
promiscuous mode settings to accept all unknown unicast macs.

This patch fixes tx promiscuous mode settings to accept all
unknown/unmatched unicast macs and works out the scenario.

Signed-off-by: Manish Chopra <manishc@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_l2.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.c b/drivers/net/ethernet/qlogic/qed/qed_l2.c
index 67c02ea939062..b8baa6fcef8e3 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.c
@@ -609,6 +609,10 @@ qed_sp_update_accept_mode(struct qed_hwfn *p_hwfn,
 			  (!!(accept_filter & QED_ACCEPT_MCAST_MATCHED) &&
 			   !!(accept_filter & QED_ACCEPT_MCAST_UNMATCHED)));
 
+		SET_FIELD(state, ETH_VPORT_TX_MODE_UCAST_ACCEPT_ALL,
+			  (!!(accept_filter & QED_ACCEPT_UCAST_MATCHED) &&
+			   !!(accept_filter & QED_ACCEPT_UCAST_UNMATCHED)));
+
 		SET_FIELD(state, ETH_VPORT_TX_MODE_BCAST_ACCEPT_ALL,
 			  !!(accept_filter & QED_ACCEPT_BCAST));
 
@@ -2688,7 +2692,8 @@ static int qed_configure_filter_rx_mode(struct qed_dev *cdev,
 	if (type == QED_FILTER_RX_MODE_TYPE_PROMISC) {
 		accept_flags.rx_accept_filter |= QED_ACCEPT_UCAST_UNMATCHED |
 						 QED_ACCEPT_MCAST_UNMATCHED;
-		accept_flags.tx_accept_filter |= QED_ACCEPT_MCAST_UNMATCHED;
+		accept_flags.tx_accept_filter |= QED_ACCEPT_UCAST_UNMATCHED |
+						 QED_ACCEPT_MCAST_UNMATCHED;
 	} else if (type == QED_FILTER_RX_MODE_TYPE_MULTI_PROMISC) {
 		accept_flags.rx_accept_filter |= QED_ACCEPT_MCAST_UNMATCHED;
 		accept_flags.tx_accept_filter |= QED_ACCEPT_MCAST_UNMATCHED;
-- 
2.19.1

