Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8440ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3A62151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZTCdQz62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3A62151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeJQQ7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:59:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46468 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbeJQQ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:59:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9H8x5Qx068727;
        Wed, 17 Oct 2018 09:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=y7rKbbJdqQCdGCoY1rQMiXNazzJMR6aKmUNiKWKlilc=;
 b=ZTCdQz62RqBk9evuWTB8Woi9uhBjlw9Zduss5nB5fW5L+eA0l0fy9N5O52iA3tL6R0Q+
 ++3EjV2v3O0UhtMpsUQ9s96ZAPVcrkgYZEzgkXTBwJBAKfR9AjJPKJrpPEDx3DQ76bQp
 avNz+Z5aI285lYRbTkPADm18josUI5um0DGvhyu9kfIl92XerrVx6LDn45NNbj7C14wf
 UxDwfmvet3+jsjcvRV53FS4Nlri6Zhbc4TqozHeBeEArWfugp1sKHH5KC0+eweNz1jry
 7Ua34ibyLxJhU+atUn4TK/Clio+hVNNIbol19FSAty/RzOXuHYzAlmeuCHEjN753+Ko6 /g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2n39brdgyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Oct 2018 09:05:01 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9H950Gb013026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Oct 2018 09:05:00 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9H94xAA024720;
        Wed, 17 Oct 2018 09:05:00 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Oct 2018 02:04:59 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, keith.busch@linux.intel.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/3] blk-mq: introduce bio retrieve mechanism
Date:   Wed, 17 Oct 2018 17:07:09 +0800
Message-Id: <1539767232-9389-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9048 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=618
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810170082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jenss

This patchset introduces a new bio retrieve mechanism. It will
flush all the requests, take the bios down from them and end them,
then submit the bios again later. Then we could
avoid:
 - fail requests on the dying hw queues, this could be fatal for
   filesystem.
 - depend on storage device to drain the queue before update hw queues.
   this could introduce hung into nvme_reset_work.

The 1st patch introduce the bio retrieve mechanism
The 2nd patch apply the bio retrieve mechanism in updating hw queues
The 3rd patch unquiesces the queues after updating hw queues in nvme_reset_work

V2:
 - clear BIO_QUEUE_ENTERED of requeued bios (1/3)
 - sync bio_requeue_work in blk_cleanup_queue (1/3)
 - discard the unnecessary synchronize_sched (2/3)
 - discard the 4th patch which is wrong
 - some misc comment changes

Jianchao Wang(3)
blk-mq: introduce bio retrieve mechanism
blk-mq: retrieve bios before update nr_hw_queues
nvme-pci: unquiesce queues after update hw queues


 block/blk-core.c        |  2 ++
 block/blk-mq-sched.c    | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq.c          | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/pci.c |  4 ++--
 include/linux/blk-mq.h  |  4 ++++
 include/linux/blkdev.h  |  2 ++
 6 files changed, 144 insertions(+), 3 deletions(-)

Thanks
Jianchao
