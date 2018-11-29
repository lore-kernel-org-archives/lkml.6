Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C387EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A1E21019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOLqfQfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A1E21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeK2RBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:01:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbeK2RBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:01:43 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E87C20868;
        Thu, 29 Nov 2018 05:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471052;
        bh=UGRHvqXrojXrxtKVC0YS+Dfl6zSWNOfRqQNz8NWxNdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZOLqfQfUBL3sK+4xOb+upWykz2lPSd86CB591u0tJ5nJ1eZz+1YwLYp2c/ppPD5f0
         rmrdbPSofr6KwoiJWXiqx42D97hHFR6DRRTW/qhB8QkePOPb37M5tTNfLtOggbhZ8S
         6Yhgmc7PlfF1X2V5YmsYqjThzvoI51QhUUP3kcmY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 15/68] batman-adv: Expand merged fragment buffer for full packet
Date:   Thu, 29 Nov 2018 00:55:06 -0500
Message-Id: <20181129055559.159228-15-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven@narfation.org>

[ Upstream commit d7d8bbb40a5b1f682ee6589e212934f4c6b8ad60 ]

The complete size ("total_size") of the fragmented packet is stored in the
fragment header and in the size of the fragment chain. When the fragments
are ready for merge, the skbuff's tail of the first fragment is expanded to
have enough room after the data pointer for at least total_size. This means
that it gets expanded by total_size - first_skb->len.

But this is ignoring the fact that after expanding the buffer, the fragment
header is pulled by from this buffer. Assuming that the tailroom of the
buffer was already 0, the buffer after the data pointer of the skbuff is
now only total_size - len(fragment_header) large. When the merge function
is then processing the remaining fragments, the code to copy the data over
to the merged skbuff will cause an skb_over_panic when it tries to actually
put enough data to fill the total_size bytes of the packet.

The size of the skb_pull must therefore also be taken into account when the
buffer's tailroom is expanded.

Fixes: 610bfc6bc99b ("batman-adv: Receive fragmented packets and merge")
Reported-by: Martin Weinelt <martin@darmstadt.freifunk.net>
Co-authored-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/fragmentation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 0fddc17106bd..5b71a289d04f 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -275,7 +275,7 @@ batadv_frag_merge_packets(struct hlist_head *chain)
 	kfree(entry);
 
 	packet = (struct batadv_frag_packet *)skb_out->data;
-	size = ntohs(packet->total_size);
+	size = ntohs(packet->total_size) + hdr_size;
 
 	/* Make room for the rest of the fragments. */
 	if (pskb_expand_head(skb_out, 0, size - skb_out->len, GFP_ATOMIC) < 0) {
-- 
2.17.1

