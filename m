Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01B6C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 04:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C50820869
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 04:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R4WYV/Re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C50820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeIEIgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 04:36:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51492 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbeIEIgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 04:36:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8544vJs098718;
        Wed, 5 Sep 2018 04:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=Q97UbCcsf/sL6JSkiboLDBMfD309kI6fmxZzgEyYaKA=;
 b=R4WYV/ReS4DhAd1o5rNJZEGOaV+ecWodhRB1a6m3K47yaX1qy3cTfGhdm1hBa9tiYRTr
 JvmVs2I6R2qQ7ot9GxZ85Mo+eN23pIxSNuK+xBb/2leE04Y/EjM4H/OWRA49YEWcS1o2
 yGZzVs4H/ZMgKQ8jo/C38xV0eCT+GId2rxflg0hvWT/AdwCcrRp2wo/WJHHjUTFzzSkL
 zcKKht6uENsnXw13C/VYwOaSmHGmpAg3QVsAMjESF6dJpLmaUc79fD28CETm6CDZ15Bl
 Ik2RHOuA9nOW0Ty5qqLBVgPUQ1WsL40hlD2c0rF8N6xRoyi9gjqF9nCqDTZd17OItAnC sw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2m7kdqgyx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Sep 2018 04:08:15 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8548EDR022271
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Sep 2018 04:08:14 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8548EBs032204;
        Wed, 5 Sep 2018 04:08:14 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Sep 2018 04:08:13 +0000
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk, ming.lei@redhat.com, bart.vanassche@wdc.com,
        sagi@grimberg.me, keith.busch@intel.com, jthumshirn@suse.de,
        jsmart2021@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 0/3] Introduce a light-weight queue close feature
Date:   Wed,  5 Sep 2018 12:09:43 +0800
Message-Id: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9006 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=601
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809050042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all

As we know, queue freeze is used to stop new IO comming in and drain
the request queue. And the draining queue here is necessary, because
queue freeze kills the percpu-ref q_usage_counter and need to drain
the q_usage_counter before switch it back to percpu mode. This could
be a trouble when we just want to prevent new IO.

In nvme-pci, nvme_dev_disable freezes queues to prevent new IO.
nvme_reset_work will unfreeze and wait to drain the queues. However,
if IO timeout at the moment, no body could do recovery as nvme_reset_work
is waiting. We will encounter IO hang.

So introduce a light-weight queue close feature in this patch set
which could prevent new IO and needn't drain the queue.

The 1st patch introduces a queue_gate into request queue and migrate
preempt only from queue flags on it.

The 2nd patch introduces queue close feature.

The 3rd patch apply the queue close in nvme-pci to avoid the IO hang
issue above.

Jianchao Wang (3)
blk-core: migrate preempt-only mode to queue_gate
blk-core: introduce queue close feature
nvme-pci: use queue close instead of queue freeze

 block/blk-core.c         | 82 +++++++++++++++++++++++++++++++++---------------
 block/blk-mq-debugfs.c   |  1 -
 block/blk.h              |  5 +++
 drivers/nvme/host/core.c | 22 +++++++++++++
 drivers/nvme/host/nvme.h |  3 ++
 drivers/nvme/host/pci.c  | 27 ++++++++--------
 drivers/scsi/scsi_lib.c  | 10 ------
 include/linux/blkdev.h   |  7 +++--
 8 files changed, 104 insertions(+), 53 deletions(-)


Thanks
Jianchao
