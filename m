Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D226C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603B02084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vWbRKuNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603B02084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbeKCDtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:49:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728699AbeKCDtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:49:46 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E69CE20847;
        Fri,  2 Nov 2018 18:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184094;
        bh=T0Cvw3CTx04Sz3I68wvAJL7BE6zDc+t3Oup5IF86UT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vWbRKuNMBSYqPR84glI+bj6oS99PoDrMW6FwERzt02GahA+/5ZEAFrnpGBSnmHBRz
         LYwIoNB8oe+2VAiliHZ6a9wusG6jRZY1nst5+X41HEeoQL+MUJcnLj1YCv0uflI41i
         r9+5QCoGHoSUv5gcnmGgjY089mx51A/A0qpAZiuU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doron Roberts-Kedes <doronrk@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 077/150] tls: Fix improper revert in zerocopy_from_iter
Date:   Fri,  2 Nov 2018 19:33:59 +0100
Message-Id: <20181102182908.947474377@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
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
@@ -440,7 +440,7 @@ alloc_encrypted:
 				&ctx->sg_plaintext_size,
 				ctx->sg_plaintext_data,
 				ARRAY_SIZE(ctx->sg_plaintext_data),
-				true, false);
+				true);
 			if (ret)
 				goto fallback_to_reg_send;
 
@@ -453,8 +453,6 @@ alloc_encrypted:
 
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



