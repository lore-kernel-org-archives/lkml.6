Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4CFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96A12086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5JdYFJ3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96A12086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbeJLRhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:37:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33222 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbeJLRhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:37:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9CA4N70011775;
        Fri, 12 Oct 2018 10:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=xAH4ivGZ1Npy9GA6UhO408NVyQ4sQxLXleAtCWMOIOw=;
 b=5JdYFJ3Q3hPuy8HccYVl2mHSUGiiIl5S4yzQg6/KjOjIa3Fsl96V/dzr3z5IOIqJnsKs
 Lql+NhY3TPT6AQvU8qrN/4y2mgfYWZWJXCNLvpEzAPFPJU+/HXdDs6P+hofuwJJxVqfJ
 BstQc0TwdplGPUJmdqzKnlSsF0HksE4C/yQg6Q1P83Aq96Nl23TAy4zZeJO8qs97HDhB
 kP84/8UJQwg4HGTRZlzp25aDVJWPkJCyKwUW/4GvigKw+W9HQE1BN9V6ZApwVZX9iWmR
 Pustni1ewEUj9dd/IGgwtcNT97vpE7wuweilh8/gO0tTiHmjKwo76uoGAZPEo2NsC2CZ iw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2mxn0qhqq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Oct 2018 10:05:25 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9CA5PP7015165
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Oct 2018 10:05:25 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9CA5Ofb028483;
        Fri, 12 Oct 2018 10:05:24 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Oct 2018 10:05:24 +0000
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     keith.busch@linux.intel.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/2] blk-mq: some fixes about updating hw queues
Date:   Fri, 12 Oct 2018 18:07:24 +0800
Message-Id: <1539338848-1789-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9043 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=1 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=1 mlxscore=1 mlxlogscore=203
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810120101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens

This patch set fixes some defects during update hw queues.

1st patch refactor the blk-mq debugfs and sysfs register during
blk_mq_update_nr_hw_queues.

2nd patch change the GFP_KERNEL to GFP_NOIO during blk_mq_realloc_hw_ctxs,

3rd patch try to realloc hctx when this hctx is mapped to a different node.

4th patch should be able to fix the panic reported in follwing link
https://marc.info/?l=linux-block&m=153799465603723&w=2

V2:
 - Newly add 2nd and 3rd patch.
 - Use blk_mq_map_queues when __blk_mq_update_nr_hw_queues fallbacks to
   previous nr_hw_queues to avoid driver's .map_queues leak mapping of
   some cpus due the fallback nr_hw_queues.
 - Add Ming's Reviewed-by in 1st patch.


Jianchao Wang[4]
blk-mq: adjust debugfs and sysfs register when
blk-mq: change gfp flags to GFP_NOIO in
blk-mq: realloc hctx when hw queue is mapped to
blk-mq: fallback to previous nr_hw_queues when

 block/blk-core.c  |   2 +-
 block/blk-flush.c |   6 +--
 block/blk-mq.c    | 155 ++++++++++++++++++++++++++++++++++--------------------
 block/blk.h       |   2 +-
 4 files changed, 102 insertions(+), 63 deletions(-)
