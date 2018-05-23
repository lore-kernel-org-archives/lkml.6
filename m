Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754094AbeEWGct (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 02:32:49 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58746 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754040AbeEWGco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 02:32:44 -0400
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: osandov@osandov.com, holger@applied-asynchrony.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/2] block: kyber: make kyber more friendly with merging
Date: Wed, 23 May 2018 14:33:20 +0800
Message-Id: <1527057202-2802-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8901 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=831
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805230062
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens

This is the second version patchset to make the kyber io scheduler more firendly
with merging.

Most of time, kyber io scheduler will not leave any requests in ctx rq_list,
this is because even if tokens of one domain is used up, kyber will try to
dispatch requests from other domain and flush the rq_list there. So there is not
any change to do merge.

To improve this, setup kyber_ctx_queue (kcq) which is similar with blk_mq_ctx but has
rq_list for every domain, and build mapping between kcq and khd as ctx and hctx.
Then we could merge, insert and dispatch on rq_list of different domains separately.
At the same time, only flush the rq_list of kcq after get domain token
successfully, then the requests could be left in the rq_list of that domain and 
maybe merged with following io. In my local test on NVMe card, the sequential io
performance could be improved a lot, especially on high workload. More details
please refer to the second patch.

Changes V1 to V2:
 - Add patch from Jens which abstract out the blk-mq-sched rq list iteration bio
 merge helper interface and rebase the patch based on it.
 - merge bio_sched_domain and rq_sched_domain to avoid the duplicated code.
 - allocate kcqs per khd

Jens Axboe (1)
0001-blk-mq-abstract-out-blk-mq-sched-rq-list-iteration-b.patch

Jianchao Wang (1)
0002-block-kyber-make-kyber-more-friendly-with-merging.patch

 block/blk-mq-sched.c   |  34 ++++++---
 block/kyber-iosched.c  | 197 ++++++++++++++++++++++++++++++++++++++++---------
 include/linux/blk-mq.h |   3 +-
 3 files changed, 188 insertions(+), 46 deletions(-)


Thanks
Jianchao
