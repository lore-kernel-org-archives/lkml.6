Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C26C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C1020855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C1020855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeIHG7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 02:59:21 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:36876
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726355AbeIHG7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 02:59:20 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id ySldfkWjQ4ToEySldfAViN; Fri, 07 Sep 2018 19:14:33 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1fySld-0005EO-OY; Fri, 07 Sep 2018 19:14:33 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v3 10/16] CIFS: SMBD: Do not call ib_dereg_mr on invalidated memory registration
Date:   Sat,  8 Sep 2018 02:13:42 +0000
Message-Id: <20180908021348.19956-11-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908021348.19956-1-longli@linuxonhyperv.com>
References: <20180908021348.19956-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfEF7PbYxj4if/KW8L18SBQbmKh/DkP9wtJCZsTm/SLV6sLBKb+N3av9OkWDfiSQiS3JKiHwIkgEUzcZkZQOgLSNO/Pc0dJyzmSRHU1oQ5eN8+L025UTc
 nNmgjYFz3KqYtOombI42dIOhgQbr/3ssekJyjOL/z2QZEZKP2KD6mNy9Z+ACZboRP9a0RdRrssM26V5i0CoEihdDzWhqPVrTnf0N+Zy9sbesu4QSMSqU1DvF
 R/VrUWNWbcNeHOQO2ckrtk3MPY82MxQW3+cKkIfTgCfEK6Tfaln89J1z2cD5ZfgG2yDC8vP3ylaAHaH45RVyceYN671wYJi3aNcoUk7Io7PwlKCtzuz32Kb2
 +/NH2xwb1hT+BiOODVz/3NMix2GCRSNar7I/P5RJjPzAFWfays7gD/eVW267KsCdng2P8Ffk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

It is not necessary to deregister a memory registration after it has been
successfully invalidated.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/smbdirect.c | 82 ++++++++++++++++++++++++++---------------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index ba53c52..b470cd0 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -2296,50 +2296,50 @@ static void smbd_mr_recovery_work(struct work_struct *work)
 	int rc;
 
 	list_for_each_entry(smbdirect_mr, &info->mr_list, list) {
-		if (smbdirect_mr->state == MR_INVALIDATED ||
-			smbdirect_mr->state == MR_ERROR) {
-
-			if (smbdirect_mr->state == MR_INVALIDATED) {
-				ib_dma_unmap_sg(
-					info->id->device, smbdirect_mr->sgl,
-					smbdirect_mr->sgl_count,
-					smbdirect_mr->dir);
-				smbdirect_mr->state = MR_READY;
-			} else if (smbdirect_mr->state == MR_ERROR) {
-
-				/* recover this MR entry */
-				rc = ib_dereg_mr(smbdirect_mr->mr);
-				if (rc) {
-					log_rdma_mr(ERR,
-						"ib_dereg_mr failed rc=%x\n",
-						rc);
-					smbd_disconnect_rdma_connection(info);
-				}
+		if (smbdirect_mr->state == MR_INVALIDATED)
+			ib_dma_unmap_sg(
+				info->id->device, smbdirect_mr->sgl,
+				smbdirect_mr->sgl_count,
+				smbdirect_mr->dir);
+		else if (smbdirect_mr->state == MR_ERROR) {
+
+			/* recover this MR entry */
+			rc = ib_dereg_mr(smbdirect_mr->mr);
+			if (rc) {
+				log_rdma_mr(ERR,
+					"ib_dereg_mr failed rc=%x\n",
+					rc);
+				smbd_disconnect_rdma_connection(info);
+				continue;
+			}
 
-				smbdirect_mr->mr = ib_alloc_mr(
-					info->pd, info->mr_type,
+			smbdirect_mr->mr = ib_alloc_mr(
+				info->pd, info->mr_type,
+				info->max_frmr_depth);
+			if (IS_ERR(smbdirect_mr->mr)) {
+				log_rdma_mr(ERR,
+					"ib_alloc_mr failed mr_type=%x "
+					"max_frmr_depth=%x\n",
+					info->mr_type,
 					info->max_frmr_depth);
-				if (IS_ERR(smbdirect_mr->mr)) {
-					log_rdma_mr(ERR,
-						"ib_alloc_mr failed mr_type=%x "
-						"max_frmr_depth=%x\n",
-						info->mr_type,
-						info->max_frmr_depth);
-					smbd_disconnect_rdma_connection(info);
-				}
-
-				smbdirect_mr->state = MR_READY;
+				smbd_disconnect_rdma_connection(info);
+				continue;
 			}
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
+		} else
+			/* This MR is being used, don't recover it */
+			continue;
+
+		smbdirect_mr->state = MR_READY;
+
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

