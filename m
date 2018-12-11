Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5B0C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42802146D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543664;
	bh=xHhrCzyfT6ZtX+sAjguLtrnTkvE9T9hjF5K0vpSdgNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZO4OJguVqN382z055+4JSVkTb3IY7py0T9DZ1+Tx9TGNFtgMWtn8fl+jJBqlsW3Na
	 Cku2N6JqJ/mUoHaqxbsKmLY865S2TfCtAojqPc12Rcdn2vzAGmVK5iif8S/yBnWpd8
	 qq5RoHVc0T3YxZM6rPgPZhmsCxUqQzoYmDPLglqU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42802146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbeLKPyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:54:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729442AbeLKPyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:54:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88C342146D;
        Tue, 11 Dec 2018 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543660;
        bh=xHhrCzyfT6ZtX+sAjguLtrnTkvE9T9hjF5K0vpSdgNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yT0JALS5+wg/7iVdotFqOT2YnZZLc+HrmwKoaV7fVgnOHm3ZbYFF5aytMQ4XhW65u
         B0R7/eYDBPTssj//Kkcuj/FeZIjF6rrOPNr7+ytyHwH2dl0Bs8nlB27N35iNLNcx+y
         7RuwwCIICoYepf9AcY+/X/JhtHb+zcdW8+di8nT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Weinelt <martin@darmstadt.freifunk.net>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <sashal@kernel.org>,
        =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH 4.19 015/118] batman-adv: Expand merged fragment buffer for full packet
Date:   Tue, 11 Dec 2018 16:40:34 +0100
Message-Id: <20181211151644.844257463@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



