Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5379EC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93BE2170A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93BE2170A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeHCIpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:45:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726833AbeHCIpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:45:51 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A0593B408BD4F;
        Fri,  3 Aug 2018 14:50:56 +0800 (CST)
Received: from [127.0.0.1] (10.177.16.168) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Fri, 3 Aug 2018
 14:50:56 +0800
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>, <netdev@vger.kernel.org>
From:   jiangyiwen <jiangyiwen@huawei.com>
Subject: [V9fs-developer] [PATCH] net/9p: avoid request size exceed to the
 virtqueue number in the zero copy
Message-ID: <5B63FB4D.1050703@huawei.com>
Date:   Fri, 3 Aug 2018 14:50:53 +0800
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

Unfortunately, when the address(input and response headers) are not
at page boundary, it will need two extra entry in the zero copy, or
else it will cause sg array out of bounds.

To avoid the problem, we should subtract two pages for maxsize.

Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
---
 net/9p/trans_virtio.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 6265d1d..63591b2 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -754,11 +754,12 @@ static void p9_virtio_remove(struct virtio_device *vdev)
 	.cancel = p9_virtio_cancel,
 	/*
 	 * We leave one entry for input and one entry for response
-	 * headers. We also skip one more entry to accomodate, address
-	 * that are not at page boundary, that can result in an extra
-	 * page in zero copy.
+	 * headers. We also skip three more entrys to accomodate
+	 * (input + response headers + data pages), address
+	 * that are not at page boundary, that can result in
+	 * an extra page in zero copy.
 	 */
-	.maxsize = PAGE_SIZE * (VIRTQUEUE_NUM - 3),
+	.maxsize = PAGE_SIZE * (VIRTQUEUE_NUM - 5),
 	.def = 1,
 	.owner = THIS_MODULE,
 };
-- 
1.8.3.1

