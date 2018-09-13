Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3AFC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C0D204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C0D204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbeIMTHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:07:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34410 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731329AbeIMTHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:07:19 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D392CD0E;
        Thu, 13 Sep 2018 13:57:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg Edwards <gedwards@ddn.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 101/197] block: bvec_nr_vecs() returns value for wrong slab
Date:   Thu, 13 Sep 2018 15:30:50 +0200
Message-Id: <20180913131845.587435113@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -156,7 +156,7 @@ out:
 
 unsigned int bvec_nr_vecs(unsigned short idx)
 {
-	return bvec_slabs[idx].nr_vecs;
+	return bvec_slabs[--idx].nr_vecs;
 }
 
 void bvec_free(mempool_t *pool, struct bio_vec *bv, unsigned int idx)


