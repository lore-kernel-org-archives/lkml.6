Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CECFC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5680420661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5680420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeLIWJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:09:32 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37430 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727045AbeLIWJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:09:30 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73F-0002ir-H9; Sun, 09 Dec 2018 21:55:49 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72d-0003Ns-9S; Sun, 09 Dec 2018 21:55:11 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Jun Piao" <piaojun@huawei.com>,
        "jiangyiwen" <jiangyiwen@huawei.com>,
        "Dominique Martinet" <dominique.martinet@cea.fr>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.29353745@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 132/328] 9p/virtio: fix off-by-one error in sg list
 bounds check
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/9p/trans_virtio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -193,7 +193,7 @@ static int pack_sg_list(struct scatterli
 		s = rest_of_page(data);
 		if (s > count)
 			s = count;
-		BUG_ON(index > limit);
+		BUG_ON(index >= limit);
 		/* Make sure we don't terminate early. */
 		sg_unmark_end(&sg[index]);
 		sg_set_buf(&sg[index++], data, s);
@@ -239,6 +239,7 @@ pack_sg_list_p(struct scatterlist *sg, i
 		s = rest_of_page(data);
 		if (s > count)
 			s = count;
+		BUG_ON(index >= limit);
 		/* Make sure we don't terminate early. */
 		sg_unmark_end(&sg[index]);
 		sg_set_page(&sg[index++], pdata[i++], s, data_off);

