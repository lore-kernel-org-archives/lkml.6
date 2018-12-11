Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3C6C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DA12146D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543562;
	bh=aRu6DPjN+jgwiEmnoBctXmhf9QhEcxz829XPXFDEJxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SVOI0cAuZcFdJEk59J4Iez1h/tVYQ2rMuo1ykiMBNQ9+fMw6OMxejL424h/ovNCTW
	 70mc+kAgq1sohe7STxnuz5u3I5TkT2dSVvpFsvyJl52LDlTilehT3RmzktVvmrLdxx
	 xSaWJKGvn59oICkIBxAiYNusjGbvH5ftMSxtY70Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DA12146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbeLKPwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:52:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729282AbeLKPwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:52:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2054E20855;
        Tue, 11 Dec 2018 15:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543554;
        bh=aRu6DPjN+jgwiEmnoBctXmhf9QhEcxz829XPXFDEJxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SGCpBlHVQct49r8QYGdaTV/tXyq+xY9YRANsu1+HO2TogovewLRmpbZeb09S4Anbw
         ZoT/w4duVDacN5lGfhaL5auVbFHDKN+d+DdKkDMyKx9oYPjMd8TObcKy/+Pk2BQfgk
         vfH36ucdft4fgqBLja2KeYnrlfqMqv5l/Xv4yry0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Weinelt <martin@darmstadt.freifunk.net>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <sashal@kernel.org>,
        =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH 4.14 09/67] batman-adv: Expand merged fragment buffer for full packet
Date:   Tue, 11 Dec 2018 16:41:09 +0100
Message-Id: <20181211151630.841137251@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index b6abd19ab23e..c6d37d22bd12 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -274,7 +274,7 @@ batadv_frag_merge_packets(struct hlist_head *chain)
 	kfree(entry);
 
 	packet = (struct batadv_frag_packet *)skb_out->data;
-	size = ntohs(packet->total_size);
+	size = ntohs(packet->total_size) + hdr_size;
 
 	/* Make room for the rest of the fragments. */
 	if (pskb_expand_head(skb_out, 0, size - skb_out->len, GFP_ATOMIC) < 0) {
-- 
2.19.1



