Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B15CECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7DE2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7DE2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbeGROBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:01:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731249AbeGROBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:01:00 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6IDJQKi056560
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 09:23:05 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ka3xm6q91-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 09:23:05 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Wed, 18 Jul 2018 14:23:02 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Jul 2018 14:22:59 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6IDMvQa37683248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Jul 2018 13:22:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 048F1A4051;
        Wed, 18 Jul 2018 16:23:15 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B92CBA4053;
        Wed, 18 Jul 2018 16:23:14 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 18 Jul 2018 16:23:14 +0100 (BST)
From:   Ursula Braun <ubraun@linux.ibm.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        raspl@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH net 1/3] net/smc: optimize consumer cursor updates
Date:   Wed, 18 Jul 2018 15:22:49 +0200
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180718132251.7222-1-ubraun@linux.ibm.com>
References: <20180718132251.7222-1-ubraun@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18071813-0028-0000-0000-000002DD1B85
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071813-0029-0000-0000-00002394E4C9
Message-Id: <20180718132251.7222-2-ubraun@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-18_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=651 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807180150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ursula Braun <ursula.braun@linux.ibm.com>

The SMC protocol requires to send a separate consumer cursor update,
if it cannot be piggybacked to updates of the producer cursor.
Currently the decision to send a separate consumer cursor update
just considers the amount of data already received by the socket
program. It does not consider the amount of data already arrived, but
not yet consumed by the receiver. Basing the decision on the
difference between already confirmed and already arrived data
(instead of difference between already confirmed and already consumed
data), may lead to a somewhat earlier consumer cursor update send in
fast unidirectional traffic scenarios, and thus to better throughput.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
---
 net/smc/smc_tx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index cee666400752..f82886b7d1d8 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -495,7 +495,8 @@ void smc_tx_work(struct work_struct *work)
 
 void smc_tx_consumer_update(struct smc_connection *conn, bool force)
 {
-	union smc_host_cursor cfed, cons;
+	union smc_host_cursor cfed, cons, prod;
+	int sender_free = conn->rmb_desc->len;
 	int to_confirm;
 
 	smc_curs_write(&cons,
@@ -505,11 +506,18 @@ void smc_tx_consumer_update(struct smc_connection *conn, bool force)
 		       smc_curs_read(&conn->rx_curs_confirmed, conn),
 		       conn);
 	to_confirm = smc_curs_diff(conn->rmb_desc->len, &cfed, &cons);
+	if (to_confirm > conn->rmbe_update_limit) {
+		smc_curs_write(&prod,
+			       smc_curs_read(&conn->local_rx_ctrl.prod, conn),
+			       conn);
+		sender_free = conn->rmb_desc->len -
+			      smc_curs_diff(conn->rmb_desc->len, &prod, &cfed);
+	}
 
 	if (conn->local_rx_ctrl.prod_flags.cons_curs_upd_req ||
 	    force ||
 	    ((to_confirm > conn->rmbe_update_limit) &&
-	     ((to_confirm > (conn->rmb_desc->len / 2)) ||
+	     ((sender_free <= (conn->rmb_desc->len / 2)) ||
 	      conn->local_rx_ctrl.prod_flags.write_blocked))) {
 		if ((smc_cdc_get_slot_and_msg_send(conn) < 0) &&
 		    conn->alert_token_local) { /* connection healthy */
-- 
2.16.4

