Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753262AbeDJNRm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:17:42 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37122 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752753AbeDJNRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:17:41 -0400
X-Google-Smtp-Source: AIpwx4/SjhuWRM17d7w1a4O5kEWu/K1hvy4ga5Mr7Jnvo1iESHLwsmR6lpDZH6v4PAknRmh8kko7zw==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/2] ntb: ntb_transport: Replace GFP_ATOMIC with GFP_KERNEL in ntb_transport_setup_qp_mw
Date: Tue, 10 Apr 2018 21:17:29 +0800
Message-Id: <1523366249-31692-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ntb_transport_setup_qp_mw() is never called in atomic context.

ntb_transport_setup_qp_mw() is only called by ntb_transport_link_work(), 
which is set as a parameter of INIT_DELAYED_WORK() 
in ntb_transport_probe().

Despite never getting called from atomic context,
ntb_transport_setup_qp_mw() calls kzalloc_node() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/ntb/ntb_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f58d8e3..08c9157 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -639,7 +639,7 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 	 */
 	node = dev_to_node(&ndev->dev);
 	for (i = qp->rx_alloc_entry; i < qp->rx_max_entry; i++) {
-		entry = kzalloc_node(sizeof(*entry), GFP_ATOMIC, node);
+		entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
 		if (!entry)
 			return -ENOMEM;
 
-- 
1.9.1
