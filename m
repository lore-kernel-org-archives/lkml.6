Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1297C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788EB214C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789487;
	bh=tlGw/gKX/Z45HCNDkh1wKKQMHpLIn883WBI3UM2d9vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DIlgK28s+9HqRYTCkOw8V36KEVzzwobj2y4jCv+DR2cp541tcthyioxqxjDcwsN8m
	 6LyB7d83yF4nhAeYtVsbavyUaN9efgzvllnnZQToErt5D882pEWDyPQjZ5JU54V9xv
	 CBMx6jISwVSuS/kNgnhrNAPKX7C8dvTF+yXGW1No=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788EB214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbeLNML0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:11:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:58030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731768AbeLNMLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:11:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ACCE2147D;
        Fri, 14 Dec 2018 12:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789482;
        bh=tlGw/gKX/Z45HCNDkh1wKKQMHpLIn883WBI3UM2d9vM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3m44encEcGUph48G47ElENz4EJb996ebFTpHT++aotTBmQQmvDhaawGYmSaV6FqS
         0nfwZKVsyQWzTD0dS/ZbldwS+Re6ziRsIHHDF6xm+1KGTwXiCUVSojGbx8Q49oTyHE
         VFL6hBjQrSjyU7YBuyrauf3zWGyuGfELq+9UqzyU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 10/51] neighbour: Avoid writing before skb->head in neigh_hh_output()
Date:   Fri, 14 Dec 2018 13:00:12 +0100
Message-Id: <20181214115714.246127730@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115713.244259772@linuxfoundation.org>
References: <20181214115713.244259772@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Brivio <sbrivio@redhat.com>

[ Upstream commit e6ac64d4c4d095085d7dd71cbd05704ac99829b2 ]

While skb_push() makes the kernel panic if the skb headroom is less than
the unaligned hardware header size, it will proceed normally in case we
copy more than that because of alignment, and we'll silently corrupt
adjacent slabs.

In the case fixed by the previous patch,
"ipv6: Check available headroom in ip6_xmit() even without options", we
end up in neigh_hh_output() with 14 bytes headroom, 14 bytes hardware
header and write 16 bytes, starting 2 bytes before the allocated buffer.

Always check we're not writing before skb->head and, if the headroom is
not enough, warn and drop the packet.

v2:
 - instead of panicking with BUG_ON(), WARN_ON_ONCE() and drop the packet
   (Eric Dumazet)
 - if we avoid the panic, though, we need to explicitly check the headroom
   before the memcpy(), otherwise we'll have corrupted slabs on a running
   kernel, after we warn
 - use __skb_push() instead of skb_push(), as the headroom check is
   already implemented here explicitly (Eric Dumazet)

Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/neighbour.h |   28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -448,6 +448,7 @@ static inline int neigh_hh_bridge(struct
 
 static inline int neigh_hh_output(const struct hh_cache *hh, struct sk_buff *skb)
 {
+	unsigned int hh_alen = 0;
 	unsigned int seq;
 	int hh_len;
 
@@ -455,16 +456,33 @@ static inline int neigh_hh_output(const
 		seq = read_seqbegin(&hh->hh_lock);
 		hh_len = hh->hh_len;
 		if (likely(hh_len <= HH_DATA_MOD)) {
-			/* this is inlined by gcc */
-			memcpy(skb->data - HH_DATA_MOD, hh->hh_data, HH_DATA_MOD);
+			hh_alen = HH_DATA_MOD;
+
+			/* skb_push() would proceed silently if we have room for
+			 * the unaligned size but not for the aligned size:
+			 * check headroom explicitly.
+			 */
+			if (likely(skb_headroom(skb) >= HH_DATA_MOD)) {
+				/* this is inlined by gcc */
+				memcpy(skb->data - HH_DATA_MOD, hh->hh_data,
+				       HH_DATA_MOD);
+			}
 		} else {
-			int hh_alen = HH_DATA_ALIGN(hh_len);
+			hh_alen = HH_DATA_ALIGN(hh_len);
 
-			memcpy(skb->data - hh_alen, hh->hh_data, hh_alen);
+			if (likely(skb_headroom(skb) >= hh_alen)) {
+				memcpy(skb->data - hh_alen, hh->hh_data,
+				       hh_alen);
+			}
 		}
 	} while (read_seqretry(&hh->hh_lock, seq));
 
-	skb_push(skb, hh_len);
+	if (WARN_ON_ONCE(skb_headroom(skb) < hh_alen)) {
+		kfree_skb(skb);
+		return NET_XMIT_DROP;
+	}
+
+	__skb_push(skb, hh_len);
 	return dev_queue_xmit(skb);
 }
 


