Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6FAECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008972054F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ET3v4Dfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008972054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeJYWns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:43:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727699AbeJYWnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:43:37 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD52920848;
        Thu, 25 Oct 2018 14:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476642;
        bh=l6mP9jJgyseYTWZ+SV/QD9/p7wZ9QMHdNbfROInuc34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ET3v4DfvcUZFuKXyjCnWFGN+XIhYQSxQrXkcENtt2t4dFC7JdFfzLw+SIZRWNGuWP
         n4RcBPjA5NhhTqL7lc3Y7wjNVv8I7fFStTC4axHdd2F0KoNFzHkBeP5n0sercNi64T
         9RJJpFsbBFjKfe8rtrHiW/CdVNd3k4rmLjrDbMWg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Doron Roberts-Kedes <doronrk@fb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 7/8] tls: Fix improper revert in zerocopy_from_iter
Date:   Thu, 25 Oct 2018 10:10:28 -0400
Message-Id: <20181025141029.213274-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141029.213274-1-sashal@kernel.org>
References: <20181025141029.213274-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doron Roberts-Kedes <doronrk@fb.com>

[ Upstream commit 2da19ed3e4a87db16c0f69039da9f17a9596c350 ]

The current code is problematic because the iov_iter is reverted and
never advanced in the non-error case. This patch skips the revert in the
non-error case. This patch also fixes the amount by which the iov_iter
is reverted. Currently, iov_iter is reverted by size, which can be
greater than the amount by which the iter was actually advanced.
Instead, only revert by the amount that the iter was advanced.

Fixes: 4718799817c5 ("tls: Fix zerocopy_from_iter iov handling")
Signed-off-by: Doron Roberts-Kedes <doronrk@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_sw.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9fab8e5a4a5b..994ddc7ec9b1 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -286,7 +286,7 @@ static int zerocopy_from_iter(struct sock *sk, struct iov_iter *from,
 			      int length, int *pages_used,
 			      unsigned int *size_used,
 			      struct scatterlist *to, int to_max_pages,
-			      bool charge, bool revert)
+			      bool charge)
 {
 	struct page *pages[MAX_SKB_FRAGS];
 
@@ -335,10 +335,10 @@ static int zerocopy_from_iter(struct sock *sk, struct iov_iter *from,
 	}
 
 out:
+	if (rc)
+		iov_iter_revert(from, size - *size_used);
 	*size_used = size;
 	*pages_used = num_elem;
-	if (revert)
-		iov_iter_revert(from, size);
 
 	return rc;
 }
@@ -440,7 +440,7 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 				&ctx->sg_plaintext_size,
 				ctx->sg_plaintext_data,
 				ARRAY_SIZE(ctx->sg_plaintext_data),
-				true, false);
+				true);
 			if (ret)
 				goto fallback_to_reg_send;
 
@@ -453,8 +453,6 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 
 			copied -= try_to_copy;
 fallback_to_reg_send:
-			iov_iter_revert(&msg->msg_iter,
-					ctx->sg_plaintext_size - orig_size);
 			trim_sg(sk, ctx->sg_plaintext_data,
 				&ctx->sg_plaintext_num_elem,
 				&ctx->sg_plaintext_size,
@@ -828,7 +826,7 @@ int tls_sw_recvmsg(struct sock *sk,
 				err = zerocopy_from_iter(sk, &msg->msg_iter,
 							 to_copy, &pages,
 							 &chunk, &sgin[1],
-							 MAX_SKB_FRAGS,	false, true);
+							 MAX_SKB_FRAGS,	false);
 				if (err < 0)
 					goto fallback_to_reg_recv;
 
-- 
2.17.1

