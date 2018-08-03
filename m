Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1450AC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 04:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE3221711
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 04:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE3221711
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeHCGGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 02:06:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36467 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726256AbeHCGGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 02:06:03 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0D4ED9737305E;
        Fri,  3 Aug 2018 12:11:39 +0800 (CST)
Received: from [127.0.0.1] (10.177.16.168) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Fri, 3 Aug 2018
 12:11:36 +0800
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>, <netdev@vger.kernel.org>
From:   jiangyiwen <jiangyiwen@huawei.com>
Subject: [V9fs-developer] [PATCH] net/9p: Modify the problem of BUG_ON
 judgment
Message-ID: <5B63D5F6.6080109@huawei.com>
Date:   Fri, 3 Aug 2018 12:11:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.16.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the value of limit is VIRTQUEUE_NUM, if index is equal to
limit, it will cause sg array out of bounds, so correct the judgement
of BUG_ON.

Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
---
 net/9p/trans_virtio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 6265d1d..08264ba 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -191,7 +191,7 @@ static int pack_sg_list(struct scatterlist *sg, int start,
 		s = rest_of_page(data);
 		if (s > count)
 			s = count;
-		BUG_ON(index > limit);
+		BUG_ON(index >= limit);
 		/* Make sure we don't terminate early. */
 		sg_unmark_end(&sg[index]);
 		sg_set_buf(&sg[index++], data, s);
@@ -236,6 +236,7 @@ static int p9_virtio_cancel(struct p9_client *client, struct p9_req_t *req)
 		s = PAGE_SIZE - data_off;
 		if (s > count)
 			s = count;
+		BUG_ON(index >= limit);
 		/* Make sure we don't terminate early. */
 		sg_unmark_end(&sg[index]);
 		sg_set_page(&sg[index++], pdata[i++], s, data_off);
-- 
1.8.3.1

