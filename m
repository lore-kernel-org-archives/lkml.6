Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03403C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7CF208FA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zirHAH50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7CF208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbeHTKdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 06:33:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60730 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeHTKdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 06:33:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7K7E9GY108609;
        Mon, 20 Aug 2018 07:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=ZhGezPwQbcBcR2YEiJBbHVNL9Miim4behu6QiemIVo0=;
 b=zirHAH500qjyVNmpoYCTkQpU70D00Jxg9+RdTNscFFcb3R2seVNhEHBLosG+YMvCYYDJ
 eDlsKs+5UnhFskw/KQWdVxe6ToKBQ6XeigI6e/62FP8jrGjlBq92TSAr32q7Skkig7iW
 NiSvPRQ5L/95GLFCACPpqQaYQXwV3aC7Au255Zi0bgzer8obwpQP26cw50qe0PwIKGaG
 PYtio+z6jk6gNlOV13cvghhFj4kYIVPjgzIwJQwynYeL5BaNS0srEt4YX9qAFpPl9MCJ
 ME94oelQLQPyoMpqN6Hc4HccPgkSIj9ao7zCI2Wam00sRLFFLm+nuZP9YCYO8raRuH9e wg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2kxavtcnnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Aug 2018 07:18:31 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7K7IU19018889
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Aug 2018 07:18:30 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7K7IUl9030669;
        Mon, 20 Aug 2018 07:18:30 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Aug 2018 00:18:29 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     tom.leiming@gmail.com, bart.vanassche@wdc.com,
        keith.busch@linux.intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/2] fixes for the updating nr_hw_queues
Date:   Mon, 20 Aug 2018 15:20:04 +0800
Message-Id: <1534749606-7311-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8990 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=848
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808200079
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

V3:
 - move the rcu and q_usage_counter checking into blk_mq_queue_tag_busy_iter
   as suggestion of Ming.
 - Add more comment about the __module_get in 1st patch.
 - Add Ming's Reviewd-by on 1st patch.

V2:
 - remove blk_mq_sched_init/exit_hctx in patch 1.
 - use q_usage_counter instead of adding new member suggested by
   Ming in patch 2.
 - comment modification.

Jianchao Wang(2)
blk-mq: init hctx sched after update ctx and hctx
blk-mq: sync the update nr_hw_queues with

 block/blk-mq-sched.c   | 44 --------------------------------------------
 block/blk-mq-sched.h   |  5 -----
 block/blk-mq-tag.c     | 14 +++++++++++++-
 block/blk-mq.c         | 43 +++++++++++++++++++++++++++++++++++--------
 block/blk.h            |  2 ++
 block/elevator.c       | 20 ++++++++++++--------
 include/linux/blkdev.h |  3 +++
 7 files changed, 65 insertions(+), 66 deletions(-)

Thanks
Jianchao
