Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbeDKHdC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 03:33:02 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44968 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbeDKHdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 03:33:00 -0400
X-Google-Smtp-Source: AIpwx4/kIftf+zIW1WZq7hHD9TBSfmyKKgHIm3b3YWmyYt58ee2lE2U80rgZQ0kHhrA1G++vS3JUgw==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: faisal.latif@intel.com, shiraz.saleem@intel.com, dledford@redhat.com,
        sean.hefty@intel.com, hal.rosenstock@gmail.com
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/3] infiniband: i40iw: Replace GFP_ATOMIC with GFP_KERNEL in i40iw_make_listen_node
Date: Wed, 11 Apr 2018 15:32:48 +0800
Message-Id: <1523431968-3552-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i40iw_make_listen_node() is never called in atomic context.

i40iw_make_listen_node() is only called by i40iw_create_listen, which is 
set as ".create_listen" in struct iw_cm_verbs.

Despite never getting called from atomic context,
i40iw_make_listen_node() calls kzalloc() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/infiniband/hw/i40iw/i40iw_cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
index 5230dd3..d021399 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -2834,7 +2834,7 @@ static struct i40iw_cm_listener *i40iw_make_listen_node(
 
 	if (!listener) {
 		/* create a CM listen node (1/2 node to compare incoming traffic to) */
-		listener = kzalloc(sizeof(*listener), GFP_ATOMIC);
+		listener = kzalloc(sizeof(*listener), GFP_KERNEL);
 		if (!listener)
 			return NULL;
 		cm_core->stats_listen_nodes_created++;
-- 
1.9.1
