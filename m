Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AC3C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE69323E0D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hJwiYr08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE69323E0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbeFVHKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:10:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56476 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeFVHKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:10:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5M79PQd049572;
        Fri, 22 Jun 2018 07:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2017-10-26;
 bh=8t9N+GooV91tX9yP5yUigIabP9g7G/kXNZ2LeuGc4R4=;
 b=hJwiYr08sUCJJ39t/Znu9VAwSp8M1w9gdUl0Lpt674IMAsFa8/g13Y7mcK09GSA/U1QV
 F3qSIMn4j+rk3supfPMp69984lL2bvcPoI8oyWIsW3mwtSrGaGs+iz09YGbMB9LPpQYD
 h8ZD5rwgfCy1Niziz2mwhJp/AFboo1mA4NikiYeemZwT1hbNxGQno0J4KMl4xfgwKYil
 y5yz4YnVKiDvchsMG+d2Y1Utbl5Trc4Bx0C8ErFjXpDbcZpD2ViNMwGBEysVtxTQAXDu
 PCy2NzMHqrOhhMwJp2Ho8RElsVNwEZH7CeUjhLqcmrOqU/dsZauv1vQX63xpdcJlHqA7 Rw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2jrp8hrrn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jun 2018 07:10:28 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5M7ARLb008693
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jun 2018 07:10:27 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5M7AQcq011501;
        Fri, 22 Jun 2018 07:10:27 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Jun 2018 00:10:26 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     bart.vanassche@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] block: fix the lock inversion caused by kobject_del under sysfs_lock
Date:   Fri, 22 Jun 2018 15:11:17 +0800
Message-Id: <1529651480-1734-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8931 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=648
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806220081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens

Currently, the kobject_del for sysfs mq and hctx entry is invoked
under q->sysfs_lock. lock inversion will came up when someone try
to access the sysfs entries concurrently. The scenario is as below:
  hold q->sysfs_lock    access mq,hctx sysfs entries
  kobject_del
  __kernfs_remove          kernfs_get_active
    kernfs_drain
     wait kn->active       require q->sysfs_lock

To avoid this issue, kobject_del for mq and hctx sysfs entries
mustn't be inovked under sysfs_lock. These patch set is to achieve this.

1st patch introduces blk_queue_registered to test QUEUE_FLAG_REGISTERED
2nd patch remove blk_mq_register_dev which is usesless.
3rd patch fix the issue by changing the sync method, please refer to the
comment.

Jianchao Wang (3)
block: add helper interface blk_queue_registered
blk-mq: cleanup blk_mq_register_dev
block: fix the lock inversion caused by kobject_del under sysfs_lock


 block/blk-mq-sysfs.c   | 80 +++++++++++++++++++++++++++++++-------------------
 block/blk-mq.h         |  3 ++
 block/blk-sysfs.c      | 43 ++++++++++++++-------------
 block/blk-wbt.c        |  4 ---
 block/elevator.c       |  5 ++--
 include/linux/blk-mq.h |  3 --
 include/linux/blkdev.h |  4 ++-
 7 files changed, 82 insertions(+), 60 deletions(-)

Thanks
Jianchao
