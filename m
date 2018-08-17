Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8A2C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085BE20852
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0zkKVvUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085BE20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbeHQGzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 02:55:37 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60704 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbeHQGzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 02:55:37 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7H3muFs124587;
        Fri, 17 Aug 2018 03:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=HBXZteOn3R7CuYN54xc5nlLjbRbupbNyrcvISv3A5/A=;
 b=0zkKVvUnih0qMa/Mt2j2WOWGDjey1vv7CLjo37BBx51v+f6b1Xs8xI7vcSDNIKEaJF7h
 yNbYqaTqvvcjd7oe1UdSVmtZB0M6ATNy38Xk9U4YkGwhDrdol7H+/yrYv7C9WZ/5x7ja
 OWNqyrmS3Hs5WfdHirkvE9R6JBpmYerfHPh13jaBeGTVlLOUSo5ciJIOQaYcUsLay5ie
 +3gKHZR7OaVOxs/VWvy/E/p9vZQnKZWKvkWDvazU3a86EcF8mu0L2O4CEQ7jGmptz0az
 zaT7GssY8PEG6RfFp/iZAZsXSEhLdRUKIh4aNzBoBgz9u7fwug3+y0wR0lmdnvv4iE7w /A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2ksnaddnm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Aug 2018 03:52:49 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7H3qm4u014935
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Aug 2018 03:52:48 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7H3qlCg019330;
        Fri, 17 Aug 2018 03:52:47 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Aug 2018 20:52:46 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     tom.leiming@gmail.com, bart.vanassche@wdc.com,
        keith.busch@linux.intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/2] fixes for the updating nr_hw_queues
Date:   Fri, 17 Aug 2018 11:54:01 +0800
Message-Id: <1534478043-7170-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8987 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=777
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808170040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens

Two fixes for updating nr_hw_queues.

The first patch fixes the following scenario:
io scheduler (kyber) depends on the mapping between ctx and hctx.
When update nr_hw_queues, io scheduler's init_hctx will be
invoked before the mapping is adapted correctly, this would cause
panic in kyber.

The second patch fixes the following scenario:
part_in_flight/rw will invoke blk_mq_in_flight/rw to account the
inflight requests. It will access the queue_hw_ctx and nr_hw_queues
w/o any protection. When updating nr_hw_queues and blk_mq_in_flight
/rw occur concurrently, panic comes up.


V2:
 - remove blk_mq_sched_init/exit_hctx in patch 1.
 - use q_usage_counter instead of adding new member suggested by
   Ming in patch 2.
 - comment modification.

Jianchao Wang(2)
blk-mq: init hctx sched after update ctx and hctx mapping
blk-mq: sync the update nr_hw_queues with part_in_flight

 block/blk-mq-sched.c   | 44 ----------------------------------
 block/blk-mq-sched.h   |  5 ----
 block/blk-mq.c         | 65 +++++++++++++++++++++++++++++++++++++++++++-------
 block/blk.h            |  2 ++
 block/elevator.c       | 20 +++++++++-------
 include/linux/blkdev.h |  3 +++
 6 files changed, 74 insertions(+), 65 deletions(-)

Thanks
Jianchao
