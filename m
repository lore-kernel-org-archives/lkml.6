Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E00ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB2321534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB2321534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388625AbeIUDF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:05:27 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:35140
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726128AbeIUDF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:05:26 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id 36Lig3H2Ysezk36Lig9Yi9; Thu, 20 Sep 2018 14:18:58 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1g36Li-0003ar-Nz; Thu, 20 Sep 2018 14:18:58 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [PATCH V3 (resend) 2/7] CIFS: SMBD: Do not call ib_dereg_mr on invalidated memory registration
Date:   Thu, 20 Sep 2018 21:18:39 +0000
Message-Id: <20180920211842.13721-2-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920211842.13721-1-longli@linuxonhyperv.com>
References: <20180920211842.13721-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfBFMXqz19nF4hviKOGzw+qm5LuMEs2ONWqHupdIE0M0pcXT4980zayk7qN2ZlyetNbD4AdG5AO14Fook1Niue1433YKh9E483qgi/8bTYl3/spBrsS5x
 oWpudpyYkAseCxlNKoWkB+S9VF/LG61+V52vMyMtFMcfBWUn6ZqqOY1dy5JCylMNRpnblaC4mv8YnDVESfNK+QvbxnmaL9hwVs/qf+8RY4vAY6htUdFL3tmo
 oScCE5L0TeYxrVQ0zvIKySuesgVs42HMBfOd9tnIzkbnfr9iN3Z9yWOzNkp1FVfSgOc/Z/BUIMPejfslkggx1Mpp8X7p/MSSAo3INGCn1cykyV+apQN15Euq
 B5ZEh4tW05Ie9JDT9wSxZ7bH4Q0eotjQUStpR7HKDalPhhx5SEf1x9eT1/AnKFAqex9iTJGz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

It is not necessary to deregister a memory registration after it has been
successfully invalidated.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/smbdirect.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 5fdb9a5..5e28236 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -2295,8 +2295,12 @@ static void smbd_mr_recovery_work(struct work_struct *work)
 	int rc;
 
 	list_for_each_entry(smbdirect_mr, &info->mr_list, list) {
-		if (smbdirect_mr->state == MR_INVALIDATED ||
-			smbdirect_mr->state == MR_ERROR) {
+		if (smbdirect_mr->state == MR_INVALIDATED)
+			ib_dma_unmap_sg(
+				info->id->device, smbdirect_mr->sgl,
+				smbdirect_mr->sgl_count,
+				smbdirect_mr->dir);
+		else if (smbdirect_mr->state == MR_ERROR) {
 
 			/* recover this MR entry */
 			rc = ib_dereg_mr(smbdirect_mr->mr);
@@ -2320,25 +2324,21 @@ static void smbd_mr_recovery_work(struct work_struct *work)
 				smbd_disconnect_rdma_connection(info);
 				continue;
 			}
+		} else
+			/* This MR is being used, don't recover it */
+			continue;
 
-			if (smbdirect_mr->state == MR_INVALIDATED)
-				ib_dma_unmap_sg(
-					info->id->device, smbdirect_mr->sgl,
-					smbdirect_mr->sgl_count,
-					smbdirect_mr->dir);
-
-			smbdirect_mr->state = MR_READY;
+		smbdirect_mr->state = MR_READY;
 
-			/* smbdirect_mr->state is updated by this function
-			 * and is read and updated by I/O issuing CPUs trying
-			 * to get a MR, the call to atomic_inc_return
-			 * implicates a memory barrier and guarantees this
-			 * value is updated before waking up any calls to
-			 * get_mr() from the I/O issuing CPUs
-			 */
-			if (atomic_inc_return(&info->mr_ready_count) == 1)
-				wake_up_interruptible(&info->wait_mr);
-		}
+		/* smbdirect_mr->state is updated by this function
+		 * and is read and updated by I/O issuing CPUs trying
+		 * to get a MR, the call to atomic_inc_return
+		 * implicates a memory barrier and guarantees this
+		 * value is updated before waking up any calls to
+		 * get_mr() from the I/O issuing CPUs
+		 */
+		if (atomic_inc_return(&info->mr_ready_count) == 1)
+			wake_up_interruptible(&info->wait_mr);
 	}
 }
 
-- 
2.7.4

