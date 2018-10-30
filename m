Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2572C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1E420838
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fY5Unkm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1E420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbeJ3WVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbeJ3WVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:21:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 340A120870;
        Tue, 30 Oct 2018 13:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906102;
        bh=msx8zzhP1UKXqsQAxYGUYuwCb5LPgkpPtXJ6VfXdEYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fY5Unkm++dCf8g80clFKutzKZGND89GbwKrHlqUk9B1geh7QCB7noLb35VnnCS/nV
         Yt5HyGzpgJh++sBaA/duvDoTBofqaeyNWY/UjwakXF86of9DgGoDa4oXjsjUoIEzZm
         4pg43NE7CEbhrfOG9v21neNBgYVxQJDMy8uE3Sbw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dimitris Michailidis <dmichail@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 32/33] net: fix pskb_trim_rcsum_slow() with odd trim offset
Date:   Tue, 30 Oct 2018 09:26:56 -0400
Message-Id: <20181030132657.217970-32-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132657.217970-1-sashal@kernel.org>
References: <20181030132657.217970-1-sashal@kernel.org>
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
index 3680912f056a..c45916b91a9c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1845,8 +1845,9 @@ int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigned int len)
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

