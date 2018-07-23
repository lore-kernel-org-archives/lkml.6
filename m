Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE95ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A8420880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A8420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388265AbeGWMyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:54:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388229AbeGWMyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:54:21 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6NBmvkc074453
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 07:53:29 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kdauf12c7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 07:53:29 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Mon, 23 Jul 2018 12:53:27 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Jul 2018 12:53:25 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6NBrNc237879974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jul 2018 11:53:23 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AAE64C050;
        Mon, 23 Jul 2018 14:53:39 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 460904C040;
        Mon, 23 Jul 2018 14:53:39 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 23 Jul 2018 14:53:39 +0100 (BST)
From:   Ursula Braun <ubraun@linux.ibm.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        raspl@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/5] net/smc: remove local variable page in smc_rx_splice()
Date:   Mon, 23 Jul 2018 13:53:12 +0200
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180723115312.54694-1-ubraun@linux.ibm.com>
References: <20180723115312.54694-1-ubraun@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072311-4275-0000-0000-0000029C629C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072311-4276-0000-0000-000037A494D4
Message-Id: <20180723115312.54694-6-ubraun@linux.ibm.com>
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

From: Ursula Braun <ursula.braun@de.ibm.com>

The page map address is already stored in the RMB descriptor.
There is no need to derive it from the cpu_addr value.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_rx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index c99c987097b1..bbcf0fe4ae10 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -155,10 +155,8 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
 	struct splice_pipe_desc spd;
 	struct partial_page partial;
 	struct smc_spd_priv *priv;
-	struct page *page;
 	int bytes;
 
-	page = virt_to_page(smc->conn.rmb_desc->cpu_addr);
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -170,7 +168,7 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
 
 	spd.nr_pages_max = 1;
 	spd.nr_pages = 1;
-	spd.pages = &page;
+	spd.pages = &smc->conn.rmb_desc->pages;
 	spd.partial = &partial;
 	spd.ops = &smc_pipe_ops;
 	spd.spd_release = smc_rx_spd_release;
-- 
2.16.4

