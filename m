Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC54DC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844612147D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789136;
	bh=NoK2tOOk1n4tVWlp0Fv91uPMElk6mDLcQ9u+eY4fK8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TD0g87fqrmOrBjcsGb3ZRfE/sSlBokEP+JYzu6QXirCNSnQomsNcQEv5fUJw5Mg5V
	 Bw+xnA+31fwQiHWk/JWFkDGpavMhQUE9j2RLqL/lDhFlllrbLc2d/bRN2a1sVhNSi0
	 6pjN0n/IbWYhK9EGfESjWUg74F+SxLjAasYzU+Zk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844612147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbeLNMFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:05:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730700AbeLNMF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:05:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62B6721479;
        Fri, 14 Dec 2018 12:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789127;
        bh=NoK2tOOk1n4tVWlp0Fv91uPMElk6mDLcQ9u+eY4fK8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tTQAMXgvCEcWasJ6qCuJsqPVVHUZ0I45TRRFwDheg1sx6wkRjnLugh8dPeWhSIsrd
         pi9T1MRPuAzqClNN8Ied8Q0fBFGYF2PHtiraSE2v6rjfzX7OQF2gNEi6+1P2JjT9bg
         cA5uk+JNcA/Qlkpe0hc5GqawBH7KwZsiapu1sxfI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kiran Kumar Modukuri <kiran.modukuri@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 105/142] fscache: Fix race in fscache_op_complete() due to split atomic_sub & read
Date:   Fri, 14 Dec 2018 12:59:50 +0100
Message-Id: <20181214115751.256280164@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3f2b7b9035107d6096ea438ea3d97dcf0481b6d2 ]

The code in fscache_retrieval_complete is using atomic_sub followed by an
atomic_read:

        atomic_sub(n_pages, &op->n_pages);
        if (atomic_read(&op->n_pages) <= 0)
                fscache_op_complete(&op->op, true);

This causes two threads doing a decrement of n_pages to race with each
other seeing the op->refcount 0 at same time - and they end up calling
fscache_op_complete() in both the threads leading to an assertion failure.

Fix this by using atomic_sub_return_relaxed() instead of two calls.  Note
that I'm using 'relaxed' rather than, say, 'release' as there aren't
multiple variables that appear to need ordering across the release.

The oops looks something like:

FS-Cache: Assertion failed
FS-Cache: 0 > 0 is false
...
kernel BUG at /usr/src/linux-4.4.0/fs/fscache/operation.c:449!
...
Workqueue: fscache_operation fscache_op_work_func [fscache]
...
RIP: 0010:[<ffffffffc037eacd>] fscache_op_complete+0x10d/0x180 [fscache]
...
Call Trace:
 [<ffffffffc1464cf9>] cachefiles_read_copier+0x3a9/0x410 [cachefiles]
 [<ffffffffc037e272>] fscache_op_work_func+0x22/0x50 [fscache]
 [<ffffffff81096da0>] process_one_work+0x150/0x3f0
 [<ffffffff8109751a>] worker_thread+0x11a/0x470
 [<ffffffff81808e59>] ? __schedule+0x359/0x980
 [<ffffffff81097400>] ? rescuer_thread+0x310/0x310
 [<ffffffff8109cdd6>] kthread+0xd6/0xf0
 [<ffffffff8109cd00>] ? kthread_park+0x60/0x60
 [<ffffffff8180d0cf>] ret_from_fork+0x3f/0x70
 [<ffffffff8109cd00>] ? kthread_park+0x60/0x60

This seen this in 4.4.x kernels and the same bug affects fscache in latest
upstreams kernels.

Fixes: 1bb4b7f98f36 ("FS-Cache: The retrieval remaining-pages counter needs to be atomic_t")
Signed-off-by: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/fscache-cache.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 34cf0fdd7dc7..610815e3f1aa 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -196,8 +196,7 @@ static inline void fscache_enqueue_retrieval(struct fscache_retrieval *op)
 static inline void fscache_retrieval_complete(struct fscache_retrieval *op,
 					      int n_pages)
 {
-	atomic_sub(n_pages, &op->n_pages);
-	if (atomic_read(&op->n_pages) <= 0)
+	if (atomic_sub_return_relaxed(n_pages, &op->n_pages) <= 0)
 		fscache_op_complete(&op->op, false);
 }
 
-- 
2.19.1



