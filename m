Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECABC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CC82146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CC82146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbeIRTTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:19:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729979AbeIRTTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:19:31 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8IDd8hS090490
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 09:46:50 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mk0t0db70-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 09:46:49 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Tue, 18 Sep 2018 14:46:47 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Sep 2018 14:46:44 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8IDkhJu47972582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Sep 2018 13:46:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0A6711C04C;
        Tue, 18 Sep 2018 16:46:28 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7446011C06E;
        Tue, 18 Sep 2018 16:46:28 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 18 Sep 2018 16:46:28 +0100 (BST)
From:   Ursula Braun <ubraun@linux.ibm.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        raspl@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH net 2/5] net/smc: remove duplicate mutex_unlock
Date:   Tue, 18 Sep 2018 15:46:35 +0200
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180918134638.90271-1-ubraun@linux.ibm.com>
References: <20180918134638.90271-1-ubraun@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18091813-4275-0000-0000-000002BBDBCA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091813-4276-0000-0000-000037C525C7
Message-Id: <20180918134638.90271-3-ubraun@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-18_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809180139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a failing smc_listen_rdma_finish() smc_listen_decline() is
called. If fallback is possible, the new socket is already enqueued
to be accepted in smc_listen_decline(). Avoid enqueuing a second time
afterwards in this case, otherwise the smc_create_lgr_pending lock
is released twice:
[  373.463976] WARNING: bad unlock balance detected!
[  373.463978] 4.18.0-rc7+ #123 Tainted: G           O
[  373.463979] -------------------------------------
[  373.463980] kworker/1:1/30 is trying to release lock (smc_create_lgr_pending) at:
[  373.463990] [<000003ff801205fc>] smc_listen_work+0x22c/0x5d0 [smc]
[  373.463991] but there are no more locks to release!
[  373.463991]
other info that might help us debug this:
[  373.463993] 2 locks held by kworker/1:1/30:
[  373.463994]  #0: 00000000772cbaed ((wq_completion)"events"){+.+.}, at: process_one_work+0x1ec/0x6b0
[  373.464000]  #1: 000000003ad0894a ((work_completion)(&new_smc->smc_listen_work)){+.+.}, at: process_one_work+0x1ec/0x6b0
[  373.464003]
stack backtrace:
[  373.464005] CPU: 1 PID: 30 Comm: kworker/1:1 Kdump: loaded Tainted: G           O      4.18.0-rc7uschi+ #123
[  373.464007] Hardware name: IBM 2827 H43 738 (LPAR)
[  373.464010] Workqueue: events smc_listen_work [smc]
[  373.464011] Call Trace:
[  373.464015] ([<0000000000114100>] show_stack+0x60/0xd8)
[  373.464019]  [<0000000000a8c9bc>] dump_stack+0x9c/0xd8
[  373.464021]  [<00000000001dcaf8>] print_unlock_imbalance_bug+0xf8/0x108
[  373.464022]  [<00000000001e045c>] lock_release+0x114/0x4f8
[  373.464025]  [<0000000000aa87fa>] __mutex_unlock_slowpath+0x4a/0x300
[  373.464027]  [<000003ff801205fc>] smc_listen_work+0x22c/0x5d0 [smc]
[  373.464029]  [<0000000000197a68>] process_one_work+0x2a8/0x6b0
[  373.464030]  [<0000000000197ec2>] worker_thread+0x52/0x410
[  373.464033]  [<000000000019fd0e>] kthread+0x15e/0x178
[  373.464035]  [<0000000000aaf58a>] kernel_thread_starter+0x6/0xc
[  373.464052]  [<0000000000aaf584>] kernel_thread_starter+0x0/0xc
[  373.464054] INFO: lockdep is turned off.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 9c3976bcde46..5c6d30eb4a71 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1153,9 +1153,9 @@ static int smc_listen_rdma_reg(struct smc_sock *new_smc, int local_contact)
 }
 
 /* listen worker: finish RDMA setup */
-static void smc_listen_rdma_finish(struct smc_sock *new_smc,
-				   struct smc_clc_msg_accept_confirm *cclc,
-				   int local_contact)
+static int smc_listen_rdma_finish(struct smc_sock *new_smc,
+				  struct smc_clc_msg_accept_confirm *cclc,
+				  int local_contact)
 {
 	struct smc_link *link = &new_smc->conn.lgr->lnk[SMC_SINGLE_LINK];
 	int reason_code = 0;
@@ -1178,11 +1178,12 @@ static void smc_listen_rdma_finish(struct smc_sock *new_smc,
 		if (reason_code)
 			goto decline;
 	}
-	return;
+	return 0;
 
 decline:
 	mutex_unlock(&smc_create_lgr_pending);
 	smc_listen_decline(new_smc, reason_code, local_contact);
+	return reason_code;
 }
 
 /* setup for RDMA connection of server */
@@ -1279,8 +1280,10 @@ static void smc_listen_work(struct work_struct *work)
 	}
 
 	/* finish worker */
-	if (!ism_supported)
-		smc_listen_rdma_finish(new_smc, &cclc, local_contact);
+	if (!ism_supported) {
+		if (smc_listen_rdma_finish(new_smc, &cclc, local_contact))
+			return;
+	}
 	smc_conn_save_peer_info(new_smc, &cclc);
 	mutex_unlock(&smc_create_lgr_pending);
 	smc_listen_out_connected(new_smc);
-- 
2.16.4

