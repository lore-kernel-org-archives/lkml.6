Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC6AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49AF20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eviaLpmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49AF20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754088AbeFTNWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:22:16 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38018 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751340AbeFTNWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:22:09 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5KDEbMB172287;
        Wed, 20 Jun 2018 13:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2017-10-26;
 bh=E6Ex6l7W5KSwQZk37j/4OkLvZY5+Z2MBczXe9EUbs+I=;
 b=eviaLpmrjQ6FeZadTyQdEZX/nXjhCwNXMJD/ZzNV/x1ZvCRKxeRdAbmK13ITK5svto8s
 SaI62KdaKghFCrwaLHGnYTfGYN2Y0Of+P8ZA5l9A4++w66l/FUfV+xsZ85j845NvoUoP
 /ayHu3HlPKsesxqOIT7vxw1oibGq86bFna+bp8MXGZ6Rnbh+mCV2ZcSyZyL5aVuGdWsA
 K01VY+aGSVDOXQvQ0C4ivjeSdXHbko/7+TI0TIGOq5FHvfmCDn8CuX+DhNuXZnApAGnr
 KqbpLMTqg60h8eWt5MrYc8SlzAxIBbxlD1o6Ptc6r7xpVuRf4rC+glhdI3jOjdeLFQMh 3g== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2jmr2mmkaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 13:22:01 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5KDM1Kr031749
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 13:22:01 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5KDM1Q9023890;
        Wed, 20 Jun 2018 13:22:01 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 06:22:00 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        keith.busch@intel.com, josef@toxicpanda.com, ulf.hansson@linaro.org
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5]stop normal completion path entering a timeout req
Date:   Wed, 20 Jun 2018 21:22:39 +0800
Message-Id: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=269
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all

scsi timeout and error handler are based on an assumption that normal
completion mustn't do anything on an timeout request. After 12f5b931
(blk-mq: Remove generation seqeunce), we lost this. __blk_mq_complete
request could ensure a request won't be completed twice, but it can
still complete a timeout request.
scsi (even other drivers) have been working on this assumption for many
years, it is dangerous to discard it suddenly. This patch set is to regain this.

1st patch
 - introduce blk_mq_mark_rq_complete in blk_mq_check_expired and blk_mq_complete_request
   to avoid the race between them.
 - blk_mq_complete_request cannot complete a timeout request anymore, so have to export
   __blk_mq_complete_request for LLDD timeout path
2nd ~ 5th patches
  replace the blk_mq_complete_request to __blk_mq_complete_request.

Jianchao Wang(5)
blk-mq: prevent normal completion from entering a timeout request
nbd: use __blk_mq_complete_request in timeout path
null_blk: use __blk_mq_complete_request in timeout path
mmc: use __blk_mq_complete_request in timeout path
nvme: use __blk_mq_complete_request in timeout path

 block/blk-mq.c             | 22 +++++++++++++++-------
 drivers/block/nbd.c        |  2 +-
 drivers/block/null_blk.c   |  2 +-
 drivers/mmc/core/queue.c   |  2 +-
 drivers/nvme/host/pci.c    |  8 ++++++++
 drivers/nvme/host/rdma.c   |  1 +
 drivers/nvme/target/loop.c |  1 +
 include/linux/blk-mq.h     |  1 +
 include/linux/blkdev.h     |  6 ++++++

Thanks
Jianchao
