Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A998BECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1782152F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FQACT33o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1782152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732427AbeITP7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:59:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39808 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732386AbeITP7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:59:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8KAElB6101811;
        Thu, 20 Sep 2018 10:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=k0YYcOTAshlZS+iJ74UVfkcpxEThRuemmV4FagmPDAU=;
 b=FQACT33o2G5Koi9kGq1HVWCL2f1ebf4nn63y9uHfM46bDvBTUgILwL7fb0hxzcXzqZZN
 CSSXRNtM6bIb/SFLO0SolEpEJm41lG2r450ypXCJ9UKi7reYqgHcnvxW5+3Tfy6ArA0g
 pMk7G3MEWgK5tpmPuyOW5cuRDREklbMBhMGNfGrKp992YBHw3mWF37iP8RVwKCqs1CF6
 LaBn/h0liJrbnCZUeHOkUKyqDRGMA26DrtVom5ME5gFTkVdki311hnV9oOu+qnlO+QHK
 4Kp47URrt3oTCCOYpQvnGlGH/5N98uIU3RhNBr0rJcht6Bk+sl6Mxl8zL6rS6j5eN4Dy vQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2mgsgu1udf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Sep 2018 10:16:29 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8KAGTBF021138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Sep 2018 10:16:29 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8KAGSHJ005443;
        Thu, 20 Sep 2018 10:16:28 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Sep 2018 03:16:28 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk, tj@kernel.org, kent.overstreet@gmail.com,
        ming.lei@redhat.com, bart.vanassche@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] blk-mq: rework queue freeze and preempt-only
Date:   Thu, 20 Sep 2018 18:18:20 +0800
Message-Id: <1537438703-25217-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9021 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=677
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809200105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

The current queue freeze depending on percpu_ref_kil/reinit has a limit that
we have drain the requests before unfreeze the queue.

Let's rework the queue freeze feature as following:
1. introduce __percpu_ref_get_many.
   It is same with original percpu_ref_get_many, but just need callers to provide
   sched rcu critical section. We will put the __percpu_ref_get_many and our own
   condition checking under rcu_read_lock_sched. With this new helper interface,
   we could save an extra rcu_read_lock_sched.
2. rework the blk_queue_enter as:
   
   rcu_read_lock_sched()
   if condition check true
     __percpu_ref_get_many(&q->q_usage_counter, 1)
   else
     goto wait
   rcu_read_unlock_sched()
3. use percpu_ref_switch_to_atomic/percpu to switch mode directly.

Then we could unfreeze the queue w/o draining requests.
In addition, preempt-only mode code could be simplified.

Jianchao Wang (3)
percpu_ref: add a new helper interface
blk-core: rework the queue freeze
block, scsi: rework the preempt only mode

d16c830226a0ac15cb5947479030b
 block/blk-core.c                | 58 ++++++++++++++++++++++++++--------------------------------
 block/blk-mq-debugfs.c          |  1 -
 block/blk-mq.c                  |  8 ++++++--
 block/blk.h                     |  5 +++++
 drivers/scsi/scsi_lib.c         | 12 ++++--------
 include/linux/blkdev.h          |  5 ++---
 include/linux/percpu-refcount.h | 23 +++++++++++++++++------
 7 files changed, 60 insertions(+), 52 deletions(-)

Thanks
Jianchao 
