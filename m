Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9C8C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44262089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jxl9eki9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44262089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbeJQBQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:16:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:16:45 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DA7420866;
        Tue, 16 Oct 2018 17:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710719;
        bh=wosc0yvhzjfrKcJItTSpRsOnKIUAFLoqkhojnDQR5bU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jxl9eki9jieGKAjIYnLumR9rn5i+RrwRDJBJTDgUhWn9vMyVcJllNTwQ5BLhyllIl
         kxJ1D/VjzFbkFXnyz1/mnheA1idNRSVAvVmx1e2TAp1FZ/zZJq4TZeoqmAbmBXTaOH
         gozI0Zx9UTDU8M35z7Qgf08DlMbSpRyLInvVhLFk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 65/71] net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are friends
Date:   Tue, 16 Oct 2018 19:10:02 +0200
Message-Id: <20181016170542.658704337@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

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
(cherry picked from commit 88078d98d1bb085d72af8437707279e203524fa5)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/skbuff.h |    5 ++---
 net/core/skbuff.c      |   14 ++++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2954,6 +2954,7 @@ static inline unsigned char *skb_push_rc
 	return skb->data;
 }
 
+int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigned int len);
 /**
  *	pskb_trim_rcsum - trim received skb and update checksum
  *	@skb: buffer to trim
@@ -2967,9 +2968,7 @@ static inline int pskb_trim_rcsum(struct
 {
 	if (likely(len >= skb->len))
 		return 0;
-	if (skb->ip_summed == CHECKSUM_COMPLETE)
-		skb->ip_summed = CHECKSUM_NONE;
-	return __pskb_trim(skb, len);
+	return pskb_trim_rcsum_slow(skb, len);
 }
 
 static inline int __skb_trim_rcsum(struct sk_buff *skb, unsigned int len)
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1578,6 +1578,20 @@ done:
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


