Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B51C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240C420854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240C420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbeIMSqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:46:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59356 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeIMSqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:46:30 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 535EECF3;
        Thu, 13 Sep 2018 13:37:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg Edwards <gedwards@ddn.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 39/78] block: bvec_nr_vecs() returns value for wrong slab
Date:   Thu, 13 Sep 2018 15:31:26 +0200
Message-Id: <20180913131809.811762369@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131805.732342940@linuxfoundation.org>
References: <20180913131805.732342940@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Edwards <gedwards@ddn.com>

[ Upstream commit d6c02a9beb67f13d5f14f23e72fa9981e8b84477 ]

In commit ed996a52c868 ("block: simplify and cleanup bvec pool
handling"), the value of the slab index is incremented by one in
bvec_alloc() after the allocation is done to indicate an index value of
0 does not need to be later freed.

bvec_nr_vecs() was not updated accordingly, and thus returns the wrong
value.  Decrement idx before performing the lookup.

Fixes: ed996a52c868 ("block: simplify and cleanup bvec pool handling")
Signed-off-by: Greg Edwards <gedwards@ddn.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/bio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/block/bio.c
+++ b/block/bio.c
@@ -155,7 +155,7 @@ out:
 
 unsigned int bvec_nr_vecs(unsigned short idx)
 {
-	return bvec_slabs[idx].nr_vecs;
+	return bvec_slabs[--idx].nr_vecs;
 }
 
 void bvec_free(mempool_t *pool, struct bio_vec *bv, unsigned int idx)


