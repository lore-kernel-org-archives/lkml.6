Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11186C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C984320838
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObSqh7zb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C984320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbeJ3WYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:24:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbeJ3WYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:24:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE98B208A3;
        Tue, 30 Oct 2018 13:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906254;
        bh=MYo69oEdK4CE/XTh61y242H+81KDl3+qHbgTRp0JHmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ObSqh7zb56znyiYT31IZ+TSE4l6YDhUBMfgK3Qo23Gm6BsFbgepSEc5MtdoRuVl7J
         8quS4nLaHUV1UbNnd9j5e2EwBqj5+USyN+mqXoXLdrEKpQlihxL/QdYVhdsu8fGzaT
         Y41CNM94RuGmTk52U+PNGlFBRo3oFXhU5j9r3hY8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dimitris Michailidis <dmichail@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 12/13] net: fix pskb_trim_rcsum_slow() with odd trim offset
Date:   Tue, 30 Oct 2018 09:29:22 -0400
Message-Id: <20181030132923.218124-12-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132923.218124-1-sashal@kernel.org>
References: <20181030132923.218124-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skbuff.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 038ec74fa131..68ecb7d71c2b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1585,8 +1585,9 @@ int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigned int len)
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
-- 
2.17.1

