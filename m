Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565A6ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D0520C01
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D0520C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbeGPMYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:24:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36396 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729245AbeGPMYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:24:09 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6GBsf5V033446
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 07:57:03 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k8racpn6r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 07:57:02 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Mon, 16 Jul 2018 12:57:01 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Jul 2018 12:56:57 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6GButCn40108098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jul 2018 11:56:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DCC252057;
        Mon, 16 Jul 2018 14:57:14 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id EAA4252050;
        Mon, 16 Jul 2018 14:57:13 +0100 (BST)
From:   Ursula Braun <ubraun@linux.ibm.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        raspl@linux.ibm.com, linux-kernel@vger.kernel.org,
        eric.dumazet@gmail.com, lifeasageek@gmail.com, sbrivio@redhat.com
Subject: [PATCH net V2 1/1] net/smc: take sock lock in smc_ioctl()
Date:   Mon, 16 Jul 2018 13:56:52 +0200
X-Mailer: git-send-email 2.16.4
X-TM-AS-GCONF: 00
x-cbid: 18071611-0028-0000-0000-000002DC1ABB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071611-0029-0000-0000-00002393D7B7
Message-Id: <20180716115652.72331-1-ubraun@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=751 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807160140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ursula Braun <ursula.braun@linux.ibm.com>

SMC ioctl processing requires the sock lock to work properly in
all thinkable scenarios.
Problem has been found with RaceFuzzer and fixes:
   KASAN: null-ptr-deref Read in smc_ioctl

Reported-by: Byoungyoung Lee <lifeasageek@gmail.com>
Reported-by: syzbot+35b2c5aa76fd398b9fd4@syzkaller.appspotmail.com
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 5334157f5065..c12a7fc18f56 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1524,10 +1524,13 @@ static int smc_ioctl(struct socket *sock, unsigned int cmd,
 			return -EBADF;
 		return smc->clcsock->ops->ioctl(smc->clcsock, cmd, arg);
 	}
+	lock_sock(&smc->sk);
 	switch (cmd) {
 	case SIOCINQ: /* same as FIONREAD */
-		if (smc->sk.sk_state == SMC_LISTEN)
+		if (smc->sk.sk_state == SMC_LISTEN) {
+			release_sock(&smc->sk);
 			return -EINVAL;
+		}
 		if (smc->sk.sk_state == SMC_INIT ||
 		    smc->sk.sk_state == SMC_CLOSED)
 			answ = 0;
@@ -1536,8 +1539,10 @@ static int smc_ioctl(struct socket *sock, unsigned int cmd,
 		break;
 	case SIOCOUTQ:
 		/* output queue size (not send + not acked) */
-		if (smc->sk.sk_state == SMC_LISTEN)
+		if (smc->sk.sk_state == SMC_LISTEN) {
+			release_sock(&smc->sk);
 			return -EINVAL;
+		}
 		if (smc->sk.sk_state == SMC_INIT ||
 		    smc->sk.sk_state == SMC_CLOSED)
 			answ = 0;
@@ -1547,8 +1552,10 @@ static int smc_ioctl(struct socket *sock, unsigned int cmd,
 		break;
 	case SIOCOUTQNSD:
 		/* output queue size (not send only) */
-		if (smc->sk.sk_state == SMC_LISTEN)
+		if (smc->sk.sk_state == SMC_LISTEN) {
+			release_sock(&smc->sk);
 			return -EINVAL;
+		}
 		if (smc->sk.sk_state == SMC_INIT ||
 		    smc->sk.sk_state == SMC_CLOSED)
 			answ = 0;
@@ -1556,8 +1563,10 @@ static int smc_ioctl(struct socket *sock, unsigned int cmd,
 			answ = smc_tx_prepared_sends(&smc->conn);
 		break;
 	case SIOCATMARK:
-		if (smc->sk.sk_state == SMC_LISTEN)
+		if (smc->sk.sk_state == SMC_LISTEN) {
+			release_sock(&smc->sk);
 			return -EINVAL;
+		}
 		if (smc->sk.sk_state == SMC_INIT ||
 		    smc->sk.sk_state == SMC_CLOSED) {
 			answ = 0;
@@ -1573,8 +1582,10 @@ static int smc_ioctl(struct socket *sock, unsigned int cmd,
 		}
 		break;
 	default:
+		release_sock(&smc->sk);
 		return -ENOIOCTLCMD;
 	}
+	release_sock(&smc->sk);
 
 	return put_user(answ, (int __user *)arg);
 }
-- 
2.16.4

