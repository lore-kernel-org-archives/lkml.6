Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95388C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F04E21907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539845;
	bh=C28zICoe2dVahHfh/YL/ZNq/RIFwpoHWQakcrismqKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V0qDwSAOnr7AbHubuncMkumPMxlrD+owlzu6ZoiREHclRpsjTy5LY+PpobvlsOaHz
	 LcV9FAWHe2eza0XH79hKKQPtC+z8NLw8Ul482lzuw/p3yotBvjkc9J+CgBEdwNcOp/
	 y7aNZ1dmzoc/+AvzC8iJlvLh8kH7TrYTZVD6FaoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfBGLoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:44:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbfBGLn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:43:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B63CF21928;
        Thu,  7 Feb 2019 11:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539839;
        bh=C28zICoe2dVahHfh/YL/ZNq/RIFwpoHWQakcrismqKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pVZVc4GNd83JTxZj+6Evx3wEmS+q0dv1qTiE+ED89t97R96fjzSob9av9un9FG2oB
         O+GsPBpQVAI9FHZvrQve7etaTUSZs/6kOQrJUATOEMkJZ1Whg13MoJ12SszKcF40AD
         dIfma2Dd+B/nAS17FS5EcLUdi2KI10yqM1b960+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dimitris Michailidis <dmichail@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 32/34] net: fix pskb_trim_rcsum_slow() with odd trim offset
Date:   Thu,  7 Feb 2019 12:42:14 +0100
Message-Id: <20190207113026.792795469@linuxfoundation.org>
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

From: Dimitris Michailidis <dmichail@google.com>

commit d55bef5059dd057bd077155375c581b49d25be7e upstream.

We've been getting checksum errors involving small UDP packets, usually
59B packets with 1 extra non-zero padding byte. netdev_rx_csum_fault()
has been complaining that HW is providing bad checksums. Turns out the
problem is in pskb_trim_rcsum_slow(), introduced in commit 88078d98d1bb
("net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are friends").

The source of the problem is that when the bytes we are trimming start
at an odd address, as in the case of the 1 padding byte above,
skb_checksum() returns a byte-swapped value. We cannot just combine this
with skb->csum using csum_sub(). We need to use csum_block_sub() here
that takes into account the parity of the start address and handles the
swapping.

Matches existing code in __skb_postpull_rcsum() and esp_remove_trailer().

Fixes: 88078d98d1bb ("net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are friends")
Signed-off-by: Dimitris Michailidis <dmichail@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/skbuff.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1509,8 +1509,9 @@ int pskb_trim_rcsum_slow(struct sk_buff
 	if (skb->ip_summed == CHECKSUM_COMPLETE) {
 		int delta = skb->len - len;
 
-		skb->csum = csum_sub(skb->csum,
-				     skb_checksum(skb, len, delta, 0));
+		skb->csum = csum_block_sub(skb->csum,
+					   skb_checksum(skb, len, delta, 0),
+					   len);
 	}
 	return __pskb_trim(skb, len);
 }


