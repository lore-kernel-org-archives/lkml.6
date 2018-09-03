Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8117C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1672054F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1672054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeICLpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 07:45:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34464 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726004AbeICLp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 07:45:29 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w837OYfR100790
        for <linux-kernel@vger.kernel.org>; Mon, 3 Sep 2018 03:26:37 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m8xvm419u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 03:26:37 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ivan@de.ibm.com>;
        Mon, 3 Sep 2018 08:26:35 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 3 Sep 2018 08:26:33 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w837QWPx30539862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Sep 2018 07:26:32 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59024AE056;
        Mon,  3 Sep 2018 10:25:57 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C6D8AE04D;
        Mon,  3 Sep 2018 10:25:57 +0100 (BST)
Received: from d06ml001.portsmouth.uk.ibm.com (unknown [9.149.76.127])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  3 Sep 2018 10:25:57 +0100 (BST)
Received: from localhost.localdomain ([9.145.12.146])
          by d06ml001.portsmouth.uk.ibm.com (IBM Domino Release 9.0.1FP10HF192)
          with ESMTP id 2018090308263099-2918 ;
          Mon, 3 Sep 2018 08:26:30 +0100 
From:   Ivan Mikhaylov <ivan@de.ibm.com>
To:     netdev@vger.kernel.org
Cc:     "David Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        "Christian Lamparter" <chunkeey@gmail.com>
Subject: [PATCH v2] net/ibm/emac: wrong emac_calc_base call was used by typo
Date:   Mon, 3 Sep 2018 10:26:28 +0300
X-Mailer: git-send-email 2.15.1
X-MIMETrack: Itemize by SMTP Server on D06ML001/06/M/IBM(Release 9.0.1FP10HF192 | April
 16, 2018) at 03/09/2018 08:26:31,
        Serialize by Router on D06ML001/06/M/IBM(Release 9.0.1FP10HF192 | April 16, 2018) at
 03/09/2018 08:26:31,
        Serialize complete at 03/09/2018 08:26:31
X-TNEFEvaluated: 1
X-TM-AS-GCONF: 00
x-cbid: 18090307-0008-0000-0000-0000026B3C1B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090307-0009-0000-0000-000021D34B1F
Message-Id: <20180903072628.19986-1-ivan@de.ibm.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=998 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809030081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__emac_calc_base_mr1 was used instead of __emac4_calc_base_mr1
by copy-paste mistake for emac4syn.

Fixes: 45d6e545505fd32edb812f085be7de45b6a5c0af ("net/ibm/emac: add 8192 rx/tx fifo size")
Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
---
 drivers/net/ethernet/ibm/emac/core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 354c098..3726646 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -494,9 +494,6 @@ static u32 __emac_calc_base_mr1(struct emac_instance *dev, int tx_size, int rx_s
 	case 16384:
 		ret |= EMAC_MR1_RFS_16K;
 		break;
-	case 8192:
-		ret |= EMAC4_MR1_RFS_8K;
-		break;
 	case 4096:
 		ret |= EMAC_MR1_RFS_4K;
 		break;
@@ -537,6 +534,9 @@ static u32 __emac4_calc_base_mr1(struct emac_instance *dev, int tx_size, int rx_
 	case 16384:
 		ret |= EMAC4_MR1_RFS_16K;
 		break;
+	case 8192:
+		ret |= EMAC4_MR1_RFS_8K;
+		break;
 	case 4096:
 		ret |= EMAC4_MR1_RFS_4K;
 		break;
--
1.7.1

