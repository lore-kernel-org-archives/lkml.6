Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1143BECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CD320856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CD320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbeGWMyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:54:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47166 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387900AbeGWMyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:54:15 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6NBmugZ051031
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 07:53:24 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kde18h862-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 07:53:23 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Mon, 23 Jul 2018 12:53:22 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Jul 2018 12:53:19 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6NBrHfG34996430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jul 2018 11:53:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFEA04C04E;
        Mon, 23 Jul 2018 14:53:33 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78EF54C044;
        Mon, 23 Jul 2018 14:53:33 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 23 Jul 2018 14:53:33 +0100 (BST)
From:   Ursula Braun <ubraun@linux.ibm.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        raspl@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/5] net/smc: provide smc mode in smc_diag.c
Date:   Mon, 23 Jul 2018 13:53:08 +0200
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180723115312.54694-1-ubraun@linux.ibm.com>
References: <20180723115312.54694-1-ubraun@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072311-0028-0000-0000-000002DEF8CE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072311-0029-0000-0000-00002396D8EE
Message-Id: <20180723115312.54694-2-ubraun@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-23_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807230139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Karsten Graul <kgraul@linux.ibm.com>

Rename field diag_fallback into diag_mode and set the smc mode of a
connection explicitly.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 include/uapi/linux/smc_diag.h | 9 ++++++++-
 net/smc/smc_diag.c            | 7 ++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/smc_diag.h b/include/uapi/linux/smc_diag.h
index 92be255e534c..48ae3ee22b2d 100644
--- a/include/uapi/linux/smc_diag.h
+++ b/include/uapi/linux/smc_diag.h
@@ -20,7 +20,7 @@ struct smc_diag_req {
 struct smc_diag_msg {
 	__u8	diag_family;
 	__u8	diag_state;
-	__u8	diag_fallback;
+	__u8	diag_mode;
 	__u8	diag_shutdown;
 	struct inet_diag_sockid id;
 
@@ -28,6 +28,13 @@ struct smc_diag_msg {
 	__u64	diag_inode;
 };
 
+/* Mode of a connection */
+enum {
+	SMC_DIAG_MODE_SMCR,
+	SMC_DIAG_MODE_FALLBACK_TCP,
+	SMC_DIAG_MODE_SMCD,
+};
+
 /* Extensions */
 
 enum {
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index 6d83eef1b743..d772cd10297e 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -91,7 +91,12 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 	r = nlmsg_data(nlh);
 	smc_diag_msg_common_fill(r, sk);
 	r->diag_state = sk->sk_state;
-	r->diag_fallback = smc->use_fallback;
+	if (smc->use_fallback)
+		r->diag_mode = SMC_DIAG_MODE_FALLBACK_TCP;
+	else if (smc->conn.lgr && smc->conn.lgr->is_smcd)
+		r->diag_mode = SMC_DIAG_MODE_SMCD;
+	else
+		r->diag_mode = SMC_DIAG_MODE_SMCR;
 	user_ns = sk_user_ns(NETLINK_CB(cb->skb).sk);
 	if (smc_diag_msg_attrs_fill(sk, skb, r, user_ns))
 		goto errout;
-- 
2.16.4

