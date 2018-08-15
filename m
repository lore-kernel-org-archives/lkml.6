Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9E8C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A37215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="InA33Hz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A37215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbeHOKOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 06:14:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36664 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeHOKOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 06:14:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7F7Nmr5184661;
        Wed, 15 Aug 2018 07:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=qM7A7k/0UYrfhKgReQr5Qa/DDuDuBfPg5nNMs2SEYNw=;
 b=InA33Hz+EF/Qp4M4XpE3iXEneHy0Rl7rj/5CGWxZ63tpFUQJcbzSZUjONhwtRFzlXabH
 rMuTXwtdA5Am6mHYH7VqdujOFrwlKjyO7d3o4F3v8ll3adQap1Ll9Wtqt8R1TM3Vyv/D
 xzhIDlpHpJU6GW4oW9gotPQvcyck23eo/tKbR+lrYB+4nhwDtp9c1iF/mWmsa3ZCqN0j
 0ucysGzzMdKtgrNgrY1TUf1HZbVPE2oasHmlVOc4Zz50E5IW4GMWCxXpuUFwylV1XZCW
 m5Zpe+pzDB1TkrmL3hbZZwoWEY+KcKEJdvL2sGz4jZyMhIxJ2T6tmNOb4szAp9V7n6fJ dA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2ksqrpbdqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Aug 2018 07:23:50 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7F7NnMa002593
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Aug 2018 07:23:49 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7F7Nknc001910;
        Wed, 15 Aug 2018 07:23:48 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Aug 2018 00:23:46 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     tom.leiming@gmail.com, bart.vanassche@wdc.com,
        keith.busch@linux.intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] fixes for the updating nr_hw_queues
Date:   Wed, 15 Aug 2018 15:25:13 +0800
Message-Id: <1534317915-5041-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8985 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=762
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808150081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two fixes for updating nr_hw_queues.

The first patch fixes the following scenario:
Kyber depends on the mapping between cpu and nr_hw_queues. When
update nr_hw_queues, elevator_type->ops.mq.init_hctx will be
invoked before the mapping is adapted correctly, this would cause
panic in kyber.

The second patch fixes the following scenario:
part_in_flight/rw will invoke blk_mq_in_flight/rw to account the
inflight requests. It will access the queue_hw_ctx and nr_hw_queues
w/o any protection. When updating nr_hw_queues and blk_mq_in_flight
/rw occur concurrently, panic comes up.

Jianchao Wang (2)
blk-mq: init hctx sched after update cpu & nr_hw_queues
blk-mq: sync the update nr_hw_queues with part_in_flight

 block/blk-mq.c         | 40 ++++++++++++++++++++++++++++++++--------
 block/blk.h            |  2 ++
 block/elevator.c       | 20 ++++++++++++--------
 block/genhd.c          | 10 ++++++++--
 include/linux/blkdev.h |  4 ++++
 5 files changed, 58 insertions(+), 18 deletions(-)

Thanks
Jianchao
