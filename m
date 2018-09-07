Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A06EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3B22075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3B22075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbeIHC2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:28:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57994 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbeIHC2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:28:00 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A90D8F36;
        Fri,  7 Sep 2018 21:45:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yiwen Jiang <jiangyiwen@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jun Piao <piaojun@huawei.com>,
        Dominique Martinet <dominique.martinet@cea.fr>
Subject: [PATCH 3.18 04/29] 9p/virtio: fix off-by-one error in sg list bounds check
Date:   Fri,  7 Sep 2018 23:10:25 +0200
Message-Id: <20180907210909.893770166@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210909.523240901@linuxfoundation.org>
References: <20180907210909.523240901@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -192,7 +192,7 @@ static int pack_sg_list(struct scatterli
 		s = rest_of_page(data);
 		if (s > count)
 			s = count;
-		BUG_ON(index > limit);
+		BUG_ON(index >= limit);
 		/* Make sure we don't terminate early. */
 		sg_unmark_end(&sg[index]);
 		sg_set_buf(&sg[index++], data, s);
@@ -238,6 +238,7 @@ pack_sg_list_p(struct scatterlist *sg, i
 		s = rest_of_page(data);
 		if (s > count)
 			s = count;
+		BUG_ON(index >= limit);
 		/* Make sure we don't terminate early. */
 		sg_unmark_end(&sg[index]);
 		sg_set_page(&sg[index++], pdata[i++], s, data_off);


