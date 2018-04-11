Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752304AbeDKHdU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 03:33:20 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52440 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbeDKHdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 03:33:19 -0400
X-Google-Smtp-Source: AIpwx49jbo6DCsoRlplIg1whekf6P4s1JCsqwkTbXsCRyg0Kby1XnQgpoTw7s2dbunXAfx2Ncq78Hg==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: faisal.latif@intel.com, shiraz.saleem@intel.com, dledford@redhat.com,
        sean.hefty@intel.com, hal.rosenstock@gmail.com
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 3/3] infiniband: i40iw: Replace GFP_ATOMIC with GFP_KERNEL in i40iw_l2param_change
Date: Wed, 11 Apr 2018 15:33:06 +0800
Message-Id: <1523431986-3596-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i40iw_l2param_change() is never called in atomic context.

i40iw_make_listen_node() is only set as ".l2_param_change" 
in struct i40e_client_ops, and this function pointer is not called 
in atomic context.

Despite never getting called from atomic context,
i40iw_l2param_change() calls kzalloc() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/infiniband/hw/i40iw/i40iw_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
index 27590ae..b86bda8 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_main.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
@@ -1737,7 +1737,7 @@ static void i40iw_l2param_change(struct i40e_info *ldev, struct i40e_client *cli
 		return;
 
 
-	work = kzalloc(sizeof(*work), GFP_ATOMIC);
+	work = kzalloc(sizeof(*work), GFP_KERNEL);
 	if (!work)
 		return;
 
-- 
1.9.1
