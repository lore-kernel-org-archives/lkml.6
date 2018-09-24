Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0910ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964542083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964542083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388902AbeIXSoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:44:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59286 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387712AbeIXSoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:44:11 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8FA51109A;
        Mon, 24 Sep 2018 12:42:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Boris Pismenny <borisp@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 187/235] tls: Fix zerocopy_from_iter iov handling
Date:   Mon, 24 Sep 2018 13:52:53 +0200
Message-Id: <20180924113123.208656314@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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

From: Boris Pismenny <borisp@mellanox.com>

[ Upstream commit 4718799817c5a30ae723eda21f3a6c7d8701b1a4 ]

zerocopy_from_iter iterates over the message, but it doesn't revert the
updates made by the iov iteration. This patch fixes it. Now, the iov can
be used after calling zerocopy_from_iter.

Fixes: 3c4d75591 ("tls: kernel TLS support")
Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_sw.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -286,7 +286,7 @@ static int zerocopy_from_iter(struct soc
 			      int length, int *pages_used,
 			      unsigned int *size_used,
 			      struct scatterlist *to, int to_max_pages,
-			      bool charge)
+			      bool charge, bool revert)
 {
 	struct page *pages[MAX_SKB_FRAGS];
 
@@ -337,6 +337,8 @@ static int zerocopy_from_iter(struct soc
 out:
 	*size_used = size;
 	*pages_used = num_elem;
+	if (revert)
+		iov_iter_revert(from, size);
 
 	return rc;
 }
@@ -438,7 +440,7 @@ alloc_encrypted:
 				&ctx->sg_plaintext_size,
 				ctx->sg_plaintext_data,
 				ARRAY_SIZE(ctx->sg_plaintext_data),
-				true);
+				true, false);
 			if (ret)
 				goto fallback_to_reg_send;
 
@@ -826,7 +828,7 @@ int tls_sw_recvmsg(struct sock *sk,
 				err = zerocopy_from_iter(sk, &msg->msg_iter,
 							 to_copy, &pages,
 							 &chunk, &sgin[1],
-							 MAX_SKB_FRAGS,	false);
+							 MAX_SKB_FRAGS,	false, true);
 				if (err < 0)
 					goto fallback_to_reg_recv;
 


