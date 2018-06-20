Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8189EC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377DF20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A0JZ8o2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377DF20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754178AbeFTNWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:22:20 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38084 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753880AbeFTNWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:22:14 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5KDEQwr172130;
        Wed, 20 Jun 2018 13:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=IhgAW8LQRUqP4svfxeXbuO79AzIghxFRGKUSpof6u+M=;
 b=A0JZ8o2XTYw6MR18AydyMJy+BLOZviDNK1olhf285S1TBOdHl5Uq6v5Z8o5/Seg7ehmY
 DBOalEhJo353m5CNm7yGGF4kywK8UFoY/TvjhRbXhW3VpfckkTorDNzNT1csmdCBuwy+
 fTScYUsIn7w0e4eZL42O1zOODnPvVOq0JzGEanZouYzphcGbFfRXxP93d9ek3vOVhkFf
 GpGamXzyYSLvierCdj8Rs3ensFa37YXTbeAwbarqJP9yBajhNI1Zb6GcLIzBFzWj11aR
 mIZdm19sqwjKyPu11TWl8e4cY5wuD1y98C2FGb1nTMzKfY05mcUopkG0kMCUnjKL4dw+ iQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2jmr2mmkax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 13:22:08 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5KDM72u032336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 13:22:08 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5KDM7kN029690;
        Wed, 20 Jun 2018 13:22:07 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 06:22:06 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        keith.busch@intel.com, josef@toxicpanda.com, ulf.hansson@linaro.org
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] nbd: use __blk_mq_complete_request in timeout path
Date:   Wed, 20 Jun 2018 21:22:41 +0800
Message-Id: <1529500964-28429-3-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=855
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To regain the capability to prevent normal completion path from
entering a timeout request, blk_mq_mark_rq_complete is introduced
in blk_mq_complete_request. Have to use __blk_mq_complete_request
in timeout path to complete a timeout request.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 3b7083b..d7e533a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -354,7 +354,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	sock_shutdown(nbd);
 	nbd_config_put(nbd);
 done:
-	blk_mq_complete_request(req);
+	__blk_mq_complete_request(req);
 	return BLK_EH_DONE;
 }
 
-- 
2.7.4

