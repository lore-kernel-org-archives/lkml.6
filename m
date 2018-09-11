Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B45C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A1B20867
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HNKiD8nl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A1B20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeIKOpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:45:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41146 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbeIKOpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:45:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8B9i4bK100967;
        Tue, 11 Sep 2018 09:46:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=4LbR/sX69unGzWiUoLY4b7Tntd8bT+BWvRmy5boPvfQ=;
 b=HNKiD8nlYVK7WdKZTWVvkBqfBgqqcCmCVTaocz3dnfke+V59y1Yi8j93wG9YEjg5Rmpk
 XfNx86mI2T5Bie7jTD+itiz6u0XB23lqGJurFj24iD7VrzC8AWzbihw4wexR39KVdEo2
 GQS8oCfEqtii4WTxYQDsh5mHiBRRYbSNf9pqJT8XGJYr6m7ARKrdSj2q1B3nBnFvcc3B
 nUnhTB0dqraP83utVviAWUkwpJfQ0Xw3wdc749eq6heZQZYLkkcQ9FDMgLuP2Cp555lw
 XH1TyCwQguADB62U72S0Srs8blcfDctnQI3LbfZ2qWebC7TxhOTL6j2IATd8Yrw3zEZe sg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2mc6cpjye6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 09:46:48 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8B9kltb022963
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 09:46:48 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8B9kgou002249;
        Tue, 11 Sep 2018 09:46:42 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Sep 2018 02:46:42 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk, ming.lei@redhat.com, bart.vanassche@wdc.com,
        sagi@grimberg.me, keith.busch@intel.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [RFC PATCH 0/4] blk-mq: introduce bio retrieve mechanism
Date:   Tue, 11 Sep 2018 17:48:10 +0800
Message-Id: <1536659294-2321-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9012 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=703
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809110102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

This patchset introduces a new bio retrieve mechanism. It  will
flush all the requests on queue, take the bios down from them and
end them, then the bios will be submied again later. Then we could
avoid:
 - fail requests on the dying hw queues
 - depend on storage device to drain the queue
This 1st case could be fatal for filesystem and the 2nd case could
cause IO hang in nvme_reset_work.

The 1st patch introduces this feature.
The 2nd patch apply it in the updating nr_hw_queues
The 3rd patch unquiesces the queues after updating nr_hw_queues
The 4th patch discards the cq_vector checking in nvme_queue_rq

Jianchao Wang(4)
blk-mq: introduce bio retrieve mechanism
blk-mq: retrieve bios before update nr_hw_queues
nvme-pci: unquiesce queues after update nr_hw_queues
nvme-pci: discard the cq_vector checking in nvme_queue_rq


 block/blk-mq-sched.c    | 78 +++++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq.c          | 50 ++++++++++++++++++++++++++++++-
 drivers/nvme/host/pci.c | 13 +++------
 include/linux/blk-mq.h  |  4 +++
 include/linux/blkdev.h  |  2 ++
 5 files changed, 137 insertions(+), 10 deletions(-)

Thanks
Jianchao
