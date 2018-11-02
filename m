Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FF4C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563C52084C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1k3NdGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563C52084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbeKCEEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:04:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbeKCEEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:04:07 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2000C20848;
        Fri,  2 Nov 2018 18:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184951;
        bh=6vFBngH1gqCzEZecaKEruQNFHBZ/Lok5hkQOI4KPUeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S1k3NdGZFxySRTKtry2oezhlPlTCUqg//VbUnW/Ac8Mza3MIMH7YzmCneSekHnMH/
         G2ZlkLqw0Gs67qdhlAa2H/ogPo8hFW3fKVFU0hs+EhtV0a9eHtZ8d3c/CnE5C1umbp
         mTv+SZcP3DyHri3ACgbmMaJaZQdKiB0Rl1uPQgJI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dimitris Michailidis <dmichail@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 138/143] net: fix pskb_trim_rcsum_slow() with odd trim offset
Date:   Fri,  2 Nov 2018 19:35:23 +0100
Message-Id: <20181102182908.759651111@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dimitris Michailidis <dmichail@google.com>

[ Upstream commit d55bef5059dd057bd077155375c581b49d25be7e ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/skbuff.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1843,8 +1843,9 @@ int pskb_trim_rcsum_slow(struct sk_buff
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


