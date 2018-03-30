Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753266AbeC3PjD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 11:39:03 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.24]:33280 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753176AbeC3PjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 11:39:00 -0400
Date: Fri, 30 Mar 2018 10:38:58 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] IB/ocrdma_hw: Remove redundant checks and goto labels
Message-ID: <20180330153858.GA14385@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f1w7H-000CvL-6R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.145.54.187]:34692
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check on return values and goto label mbx_err are unnecessary.

Addresses-Coverity-ID: 1271151 ("Identical code for different branches")
Addresses-Coverity-ID: 1268788 ("Identical code for different branches")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma_hw.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_hw.c b/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
index 9904918..90cf772 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
@@ -2014,7 +2014,7 @@ static int ocrdma_mbx_reg_mr_cont(struct ocrdma_dev *dev,
 				  struct ocrdma_hw_mr *hwmr, u32 pbl_cnt,
 				  u32 pbl_offset, u32 last)
 {
-	int status = -ENOMEM;
+	int status;
 	int i;
 	struct ocrdma_reg_nsmr_cont *cmd;
 
@@ -2033,9 +2033,7 @@ static int ocrdma_mbx_reg_mr_cont(struct ocrdma_dev *dev,
 		    upper_32_bits(hwmr->pbl_table[i + pbl_offset].pa);
 	}
 	status = ocrdma_mbx_cmd(dev, (struct ocrdma_mqe *)cmd);
-	if (status)
-		goto mbx_err;
-mbx_err:
+
 	kfree(cmd);
 	return status;
 }
@@ -3133,12 +3131,12 @@ static int ocrdma_create_eqs(struct ocrdma_dev *dev)
 static int ocrdma_mbx_modify_eqd(struct ocrdma_dev *dev, struct ocrdma_eq *eq,
 				 int num)
 {
-	int i, status = -ENOMEM;
+	int i, status;
 	struct ocrdma_modify_eqd_req *cmd;
 
 	cmd = ocrdma_init_emb_mqe(OCRDMA_CMD_MODIFY_EQ_DELAY, sizeof(*cmd));
 	if (!cmd)
-		return status;
+		return -ENOMEM;
 
 	ocrdma_init_mch(&cmd->cmd.req, OCRDMA_CMD_MODIFY_EQ_DELAY,
 			OCRDMA_SUBSYS_COMMON, sizeof(*cmd));
@@ -3151,9 +3149,7 @@ static int ocrdma_mbx_modify_eqd(struct ocrdma_dev *dev, struct ocrdma_eq *eq,
 				(eq[i].aic_obj.prev_eqd * 65)/100;
 	}
 	status = ocrdma_mbx_cmd(dev, (struct ocrdma_mqe *)cmd);
-	if (status)
-		goto mbx_err;
-mbx_err:
+
 	kfree(cmd);
 	return status;
 }
-- 
2.7.4
