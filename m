Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39679ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003D820856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003D820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388219AbeGWMyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:54:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54528 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388194AbeGWMyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:54:18 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6NBmvxf146968
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 07:53:27 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kdbqgy09b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 07:53:27 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Mon, 23 Jul 2018 12:53:25 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Jul 2018 12:53:23 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6NBrMIC40370382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jul 2018 11:53:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36E1E4C040;
        Mon, 23 Jul 2018 14:53:38 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5C8A4C04A;
        Mon, 23 Jul 2018 14:53:37 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 23 Jul 2018 14:53:37 +0100 (BST)
From:   Ursula Braun <ubraun@linux.ibm.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        raspl@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/5] net/smc: use DECLARE_BITMAP for rtokens_used_mask
Date:   Mon, 23 Jul 2018 13:53:11 +0200
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180723115312.54694-1-ubraun@linux.ibm.com>
References: <20180723115312.54694-1-ubraun@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072311-0012-0000-0000-0000028D8C49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072311-0013-0000-0000-000020BF67B0
Message-Id: <20180723115312.54694-5-ubraun@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-23_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=817 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807230139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ursula Braun <ursula.braun@de.ibm.com>

Link group field tokens_used_mask is a bitmap. Use macro
DECLARE_BITMAP for its definition.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 8807865483bb..1e8974c50550 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -192,8 +192,7 @@ struct smc_link_group {
 			struct smc_rtoken	rtokens[SMC_RMBS_PER_LGR_MAX]
 						[SMC_LINKS_PER_LGR_MAX];
 						/* remote addr/key pairs */
-			unsigned long		rtokens_used_mask[BITS_TO_LONGS
-							(SMC_RMBS_PER_LGR_MAX)];
+			DECLARE_BITMAP(rtokens_used_mask, SMC_RMBS_PER_LGR_MAX);
 						/* used rtoken elements */
 		};
 		struct { /* SMC-D */
-- 
2.16.4

