Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A657C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA6020645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA6020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbeIHCLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:11:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48870 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbeIHCLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:11:45 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D3307ACC;
        Fri,  7 Sep 2018 21:28:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yiwen Jiang <jiangyiwen@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jun Piao <piaojun@huawei.com>,
        Dominique Martinet <dominique.martinet@cea.fr>
Subject: [PATCH 4.14 26/89] 9p/virtio: fix off-by-one error in sg list bounds check
Date:   Fri,  7 Sep 2018 23:09:20 +0200
Message-Id: <20180907210855.638387819@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210852.341064285@linuxfoundation.org>
References: <20180907210852.341064285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: jiangyiwen <jiangyiwen@huawei.com>

commit 23cba9cbde0bba05d772b335fe5f66aa82b9ad19 upstream.

Because the value of limit is VIRTQUEUE_NUM, if index is equal to
limit, it will cause sg array out of bounds, so correct the judgement
of BUG_ON.

Link: http://lkml.kernel.org/r/5B63D5F6.6080109@huawei.com
Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
Reported-By: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Jun Piao <piaojun@huawei.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/9p/trans_virtio.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -189,7 +189,7 @@ static int pack_sg_list(struct scatterli
 		s = rest_of_page(data);
 		if (s > count)
 			s = count;
-		BUG_ON(index > limit);
+		BUG_ON(index >= limit);
 		/* Make sure we don't terminate early. */
 		sg_unmark_end(&sg[index]);
 		sg_set_buf(&sg[index++], data, s);
@@ -234,6 +234,7 @@ pack_sg_list_p(struct scatterlist *sg, i
 		s = PAGE_SIZE - data_off;
 		if (s > count)
 			s = count;
+		BUG_ON(index >= limit);
 		/* Make sure we don't terminate early. */
 		sg_unmark_end(&sg[index]);
 		sg_set_page(&sg[index++], pdata[i++], s, data_off);


