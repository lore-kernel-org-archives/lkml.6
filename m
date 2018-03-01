Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163456AbeCAXi7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:38:59 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52056 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163368AbeCAXhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:37:35 -0500
X-Google-Smtp-Source: AG47ELv1Ia6M5uP4C0J12hXevvznGx6ZekPs/Xaxk/+Bk7Vb8PMxSoEsE1Pg+U8fcr8anYBVDYER7Q==
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 4/5] fm10k: use seq_open_data()
Date: Fri,  2 Mar 2018 00:37:23 +0100
Message-Id: <20180301233724.20440-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180301233724.20440-1-linux@rasmusvillemoes.dk>
References: <20180301233724.20440-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the code slightly by having seq_open_data do the ->private assignment.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c b/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
index 14df09e2d964..acf034feb8fa 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
@@ -132,20 +132,13 @@ static int fm10k_dbg_desc_open(struct inode *inode, struct file *filep)
 	struct fm10k_ring *ring = inode->i_private;
 	struct fm10k_q_vector *q_vector = ring->q_vector;
 	const struct seq_operations *desc_seq_ops;
-	int err;
 
 	if (ring < q_vector->rx.ring)
 		desc_seq_ops = &fm10k_dbg_tx_desc_seq_ops;
 	else
 		desc_seq_ops = &fm10k_dbg_rx_desc_seq_ops;
 
-	err = seq_open(filep, desc_seq_ops);
-	if (err)
-		return err;
-
-	((struct seq_file *)filep->private_data)->private = ring;
-
-	return 0;
+	return seq_open_data(filep, desc_seq_ops, ring);
 }
 
 static const struct file_operations fm10k_dbg_desc_fops = {
-- 
2.15.1
