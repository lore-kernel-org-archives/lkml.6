Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632D9C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6F024112
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6F024112
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753713AbeGEOPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:15:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753353AbeGEOPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:15:40 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65EEQ1t047389
        for <linux-kernel@vger.kernel.org>; Thu, 5 Jul 2018 10:15:39 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k1kpr3t8u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 10:15:39 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Thu, 5 Jul 2018 15:15:37 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Jul 2018 15:15:34 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w65EFWD436962422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Jul 2018 14:15:32 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 566D011C066;
        Thu,  5 Jul 2018 17:15:57 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1117A11C064;
        Thu,  5 Jul 2018 17:15:57 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  5 Jul 2018 17:15:57 +0100 (BST)
From:   Ursula Braun <ubraun@linux.ibm.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        raspl@linux.ibm.com, linux-kernel@vger.kernel.org,
        ebiggers3@gmail.com
Subject: [PATCH net 1/1] net/smc: reduce sock_put() for fallback sockets
Date:   Thu,  5 Jul 2018 16:15:30 +0200
X-Mailer: git-send-email 2.16.4
X-TM-AS-GCONF: 00
x-cbid: 18070514-4275-0000-0000-000002957F40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070514-4276-0000-0000-0000379D0898
Message-Id: <20180705141530.72728-1-ubraun@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=573 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807050164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smc_release() calls a sock_put() for smc fallback sockets to cover
the passive closing sock_hold() in __smc_connect() and
smc_tcp_listen_work(). This does not make sense for sockets in state
SMC_LISTEN and SMC_INIT.
An SMC socket stays in state SMC_INIT if connect fails. The sock_put
in smc_connect_abort() does not cover all failures. Move it into
smc_connect_decline_fallback().

Fixes: ee9dfbef02d18 ("net/smc: handle sockopts forcing fallback")
Reported-by: syzbot+3a0748c8f2f210c0ef9b@syzkaller.appspotmail.com
Reported-by: syzbot+9e60d2428a42049a592a@syzkaller.appspotmail.com
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c    | 15 ++++++++++-----
 net/smc/smc_close.c |  2 ++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index e017b6a4452b..5334157f5065 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -147,7 +147,8 @@ static int smc_release(struct socket *sock)
 		smc->clcsock = NULL;
 	}
 	if (smc->use_fallback) {
-		sock_put(sk); /* passive closing */
+		if (sk->sk_state != SMC_LISTEN && sk->sk_state != SMC_INIT)
+			sock_put(sk); /* passive closing */
 		sk->sk_state = SMC_CLOSED;
 		sk->sk_state_change(sk);
 	}
@@ -417,12 +418,18 @@ static int smc_connect_decline_fallback(struct smc_sock *smc, int reason_code)
 {
 	int rc;
 
-	if (reason_code < 0) /* error, fallback is not possible */
+	if (reason_code < 0) { /* error, fallback is not possible */
+		if (smc->sk.sk_state == SMC_INIT)
+			sock_put(&smc->sk); /* passive closing */
 		return reason_code;
+	}
 	if (reason_code != SMC_CLC_DECL_REPLY) {
 		rc = smc_clc_send_decline(smc, reason_code);
-		if (rc < 0)
+		if (rc < 0) {
+			if (smc->sk.sk_state == SMC_INIT)
+				sock_put(&smc->sk); /* passive closing */
 			return rc;
+		}
 	}
 	return smc_connect_fallback(smc);
 }
@@ -435,8 +442,6 @@ static int smc_connect_abort(struct smc_sock *smc, int reason_code,
 		smc_lgr_forget(smc->conn.lgr);
 	mutex_unlock(&smc_create_lgr_pending);
 	smc_conn_free(&smc->conn);
-	if (reason_code < 0 && smc->sk.sk_state == SMC_INIT)
-		sock_put(&smc->sk); /* passive closing */
 	return reason_code;
 }
 
diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index fa41d9881741..ac961dfb1ea1 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -107,6 +107,8 @@ static void smc_close_active_abort(struct smc_sock *smc)
 	}
 	switch (sk->sk_state) {
 	case SMC_INIT:
+		sk->sk_state = SMC_PEERABORTWAIT;
+		break;
 	case SMC_ACTIVE:
 		sk->sk_state = SMC_PEERABORTWAIT;
 		release_sock(sk);
-- 
2.16.4

