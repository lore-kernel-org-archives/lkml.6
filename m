Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD211C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9480C213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vVWXyvNX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9480C213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbeHUKc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:32:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44290 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeHUKc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:32:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7L78xGx070774;
        Tue, 21 Aug 2018 07:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=6TIaqKH6ViEFixweGPApxgoBo5j5hF7eaXg01YuXG9Q=;
 b=vVWXyvNX0CW4ZcXIA2nITyUi++sbswhy5X5Jj2PXMOVX5rIPlNwoL+9kxwyc0uudolJZ
 DYGdSEDmgFpHZtooggzOCS+ZIcBMq+nvPe3yVYD19O80tcaGfXPUOenIvGniJDqiVOz+
 Uk0w4VCGtlTm6AANspXre1z1agNEG3/x0gmrjfESRqkG8SibKNyTro0Mw88CUrCqjHZE
 5TUMg/abxjYZNnoPm/ukzwSfTtZDM5uxsvZ/2+euPxf3r1q9iUoiS6BuSaySHqVLFG4X
 pYwxaAlTx3VugEYkH7ZR5Um64MKPsHoLrQZRSooFdq4lZqau0j97EevBgeGN6vuabxr9 3Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2kxavtjjwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Aug 2018 07:13:27 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7L7DPg7029950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Aug 2018 07:13:26 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7L7DOfE014463;
        Tue, 21 Aug 2018 07:13:25 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Aug 2018 00:13:24 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     tom.leiming@gmail.com, bart.vanassche@wdc.com,
        keith.busch@linux.intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/2] fixes for the updating nr_hw_queues
Date:   Tue, 21 Aug 2018 15:15:02 +0800
Message-Id: <1534835704-3607-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8991 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=892
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808210076
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

V4:
 - remove the elv_type in request_queue and introduce blk_mq_qe_pair
   to cache the elevator_type associated with one request_queue. And
   add two new helper interfaces blk_mq_elv_switch_none/back to carry
   out the elevator_type caching and switching work.
 - Add Ming's Reviewd-by on 2nd patch and remove it from 1st patch due
   to the reworking.
 - comment modification.

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

 block/blk-mq-sched.c | 44 --------------------------------------------
 block/blk-mq-sched.h |  5 -----
 block/blk-mq-tag.c   | 14 +++++++++++++-
 block/blk-mq.c       | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 block/blk.h          |  2 ++
 block/elevator.c     | 20 ++++++++++++--------
 6 files changed, 115 insertions(+), 66 deletions(-)

Thanks
Jianchao
