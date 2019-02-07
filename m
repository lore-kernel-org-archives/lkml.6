Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2379C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E562080A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539859;
	bh=i1a7MoRb9G6dWfmh4oa0sPO8Elk5wvKoOJOdDQSYk8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hp0ygWtyyzs7On7hBiYn0MyNz7HJNA99x5W/G3keNOfE1YFMoIVzF0wCMrqTAOPo8
	 oFKX6NlJKFnwl/MkagkYatI3Juw0oPbwBlHw2OMHYyz+/mvqcZGxyLfGyIcqmwGdVA
	 rxmqNiA9TcNQyfCLcPEZF4eLr708YNwGUj65n31o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfBGLoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:44:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:34754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfBGLoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:44:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30EC02080F;
        Thu,  7 Feb 2019 11:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539848;
        bh=i1a7MoRb9G6dWfmh4oa0sPO8Elk5wvKoOJOdDQSYk8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n/LeSV5uXv4vMq1mCSrrpFa/NkmaUUbdcNT1EckiN6J7zwhmzTSyyqLRTrAd1pzbL
         w2fOIH1HfcDsN2z+z18PD5sKQrgAzVcyRW+5ZZmxZHGEsccUF6YKg8mA9tP/OuCgbx
         /hP3gDlddOE12r0SbnmEY16OP6l8aBBYCMFqhbIs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 25/34] net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are friends
Date:   Thu,  7 Feb 2019 12:42:07 +0100
Message-Id: <20190207113026.543590357@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207113025.552605181@linuxfoundation.org>
References: <20190207113025.552605181@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 88078d98d1bb085d72af8437707279e203524fa5 upstream.

After working on IP defragmentation lately, I found that some large
packets defeat CHECKSUM_COMPLETE optimization because of NIC adding
zero paddings on the last (small) fragment.

While removing the padding with pskb_trim_rcsum(), we set skb->ip_summed
to CHECKSUM_NONE, forcing a full csum validation, even if all prior
fragments had CHECKSUM_COMPLETE set.

We can instead compute the checksum of the part we are trimming,
usually smaller than the part we keep.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/skbuff.h |    5 ++---
 net/core/skbuff.c      |   14 ++++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2796,6 +2796,7 @@ static inline unsigned char *skb_push_rc
 	return skb->data;
 }
 
+int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigned int len);
 /**
  *	pskb_trim_rcsum - trim received skb and update checksum
  *	@skb: buffer to trim
@@ -2810,9 +2811,7 @@ static inline int pskb_trim_rcsum(struct
 {
 	if (likely(len >= skb->len))
 		return 0;
-	if (skb->ip_summed == CHECKSUM_COMPLETE)
-		skb->ip_summed = CHECKSUM_NONE;
-	return __pskb_trim(skb, len);
+	return pskb_trim_rcsum_slow(skb, len);
 }
 
 #define rb_to_skb(rb) rb_entry_safe(rb, struct sk_buff, rbnode)
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1502,6 +1502,20 @@ done:
 }
 EXPORT_SYMBOL(___pskb_trim);
 
+/* Note : use pskb_trim_rcsum() instead of calling this directly
+ */
+int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigned int len)
+{
+	if (skb->ip_summed == CHECKSUM_COMPLETE) {
+		int delta = skb->len - len;
+
+		skb->csum = csum_sub(skb->csum,
+				     skb_checksum(skb, len, delta, 0));
+	}
+	return __pskb_trim(skb, len);
+}
+EXPORT_SYMBOL(pskb_trim_rcsum_slow);
+
 /**
  *	__pskb_pull_tail - advance tail of skb header
  *	@skb: buffer to reallocate


