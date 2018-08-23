Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C49C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3E520839
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3E520839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388005AbeHWMVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:21:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51912 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbeHWMVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:21:44 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 766C4C74;
        Thu, 23 Aug 2018 08:53:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Watson <davejwatson@fb.com>,
        Doron Roberts-Kedes <doronrk@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 176/324] tls: fix skb_to_sgvec returning unhandled error.
Date:   Thu, 23 Aug 2018 09:54:02 +0200
Message-Id: <20180823075005.016382914@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Doron Roberts-Kedes <doronrk@fb.com>

[ Upstream commit 52ee6ef36ee10dd493cf2067311e56ca8015eb8d ]

The current code does not inspect the return value of skb_to_sgvec. This
can cause a nullptr kernel panic when the malformed sgvec is passed into
the crypto request.

Checking the return value of skb_to_sgvec and skipping decryption if it
is negative fixes this problem.

Fixes: c46234ebb4d1 ("tls: RX path for ktls")
Acked-by: Dave Watson <davejwatson@fb.com>
Signed-off-by: Doron Roberts-Kedes <doronrk@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_sw.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -705,6 +705,10 @@ static int decrypt_skb(struct sock *sk,
 	nsg = skb_to_sgvec(skb, &sgin[1],
 			   rxm->offset + tls_ctx->rx.prepend_size,
 			   rxm->full_len - tls_ctx->rx.prepend_size);
+	if (nsg < 0) {
+		ret = nsg;
+		goto out;
+	}
 
 	tls_make_aad(ctx->rx_aad_ciphertext,
 		     rxm->full_len - tls_ctx->rx.overhead_size,
@@ -716,6 +720,7 @@ static int decrypt_skb(struct sock *sk,
 				rxm->full_len - tls_ctx->rx.overhead_size,
 				skb, sk->sk_allocation);
 
+out:
 	if (sgin != &sgin_arr[0])
 		kfree(sgin);
 


