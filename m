Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2827ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB512146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB512146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbeIRTTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:19:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729973AbeIRTTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:19:33 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8IDdiWL012946
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 09:46:52 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mk1234kf9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 09:46:52 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Tue, 18 Sep 2018 14:46:49 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Sep 2018 14:46:46 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8IDki0D59703390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Sep 2018 13:46:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1499111C04C;
        Tue, 18 Sep 2018 16:46:30 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C461711C052;
        Tue, 18 Sep 2018 16:46:29 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 18 Sep 2018 16:46:29 +0100 (BST)
From:   Ursula Braun <ubraun@linux.ibm.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        raspl@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH net 3/5] net/smc: enable fallback for connection abort in state INIT
Date:   Tue, 18 Sep 2018 15:46:36 +0200
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180918134638.90271-1-ubraun@linux.ibm.com>
References: <20180918134638.90271-1-ubraun@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18091813-0008-0000-0000-00000272DBA6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091813-0009-0000-0000-000021DB3090
Message-Id: <20180918134638.90271-4-ubraun@linux.ibm.com>
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

If a linkgroup is terminated abnormally already due to failing
LLC CONFIRM LINK or LLC ADD LINK, fallback to TCP is still possible.
In this case do not switch to state SMC_PEERABORTWAIT and do not set
sk_err.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_close.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index ac961dfb1ea1..ea2b87f29469 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -100,15 +100,14 @@ static void smc_close_active_abort(struct smc_sock *smc)
 	struct smc_cdc_conn_state_flags *txflags =
 		&smc->conn.local_tx_ctrl.conn_state_flags;
 
-	sk->sk_err = ECONNABORTED;
-	if (smc->clcsock && smc->clcsock->sk) {
-		smc->clcsock->sk->sk_err = ECONNABORTED;
-		smc->clcsock->sk->sk_state_change(smc->clcsock->sk);
+	if (sk->sk_state != SMC_INIT && smc->clcsock && smc->clcsock->sk) {
+		sk->sk_err = ECONNABORTED;
+		if (smc->clcsock && smc->clcsock->sk) {
+			smc->clcsock->sk->sk_err = ECONNABORTED;
+			smc->clcsock->sk->sk_state_change(smc->clcsock->sk);
+		}
 	}
 	switch (sk->sk_state) {
-	case SMC_INIT:
-		sk->sk_state = SMC_PEERABORTWAIT;
-		break;
 	case SMC_ACTIVE:
 		sk->sk_state = SMC_PEERABORTWAIT;
 		release_sock(sk);
@@ -143,6 +142,7 @@ static void smc_close_active_abort(struct smc_sock *smc)
 	case SMC_PEERFINCLOSEWAIT:
 		sock_put(sk); /* passive closing */
 		break;
+	case SMC_INIT:
 	case SMC_PEERABORTWAIT:
 	case SMC_CLOSED:
 		break;
-- 
2.16.4

