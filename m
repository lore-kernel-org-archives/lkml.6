Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082B7C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C055420892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791318;
	bh=v8XUgI5o8c1lU2DWjRU91qEZzbypVrHvmAz3mFz3u4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PcpCFBEuEnh67FjOhpP48iuTNa2Tmefr0T8q/F+MDIVRhnAvIPFcVGn63qfPXb4s8
	 9z5WAiNtY44NgXIRnGKSunepLxhP3L7liIQJ3ixkaSwfxLP797G//OS4VzwOFSWEsC
	 /jNtZsEdevh9iUhoSDAfnZ+AeFtFTWFpmMv0aCvw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C055420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbeLNMDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:03:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730210AbeLNMDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:03:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC97A2145D;
        Fri, 14 Dec 2018 12:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788986;
        bh=v8XUgI5o8c1lU2DWjRU91qEZzbypVrHvmAz3mFz3u4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HEWAyA3f9OSKKuBaxaZl3+cC0g5SHouM8hSmvqbW9y07DfsgS/A1q+WBhhrBzW00A
         eGAYsxjKxDI2XPjWjjRpXiCqJxCT8we6f27bL0RJoZ2yzbv1RACqRlKQXey9iAQ0tD
         1fiqAIDi+TYSvnjUGrhtXzmt0ahFFPqP5/fLSHvg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Popa <pashinho1990@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 017/142] virtio-net: keep vnet header zeroed after processing XDP
Date:   Fri, 14 Dec 2018 12:58:22 +0100
Message-Id: <20181214115747.738748353@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

From: Jason Wang <jasowang@redhat.com>

[ Upstream commit 436c9453a1ac0944b82870ef2e0d9be956b396d9 ]

We copy vnet header unconditionally in page_to_skb() this is wrong
since XDP may modify the packet data. So let's keep a zeroed vnet
header for not confusing the conversion between vnet header and skb
metadata.

In the future, we should able to detect whether or not the packet was
modified and keep using the vnet header when packet was not touched.

Fixes: f600b6905015 ("virtio_net: Add XDP support")
Reported-by: Pavel Popa <pashinho1990@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -365,7 +365,8 @@ static unsigned int mergeable_ctx_to_tru
 static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 				   struct receive_queue *rq,
 				   struct page *page, unsigned int offset,
-				   unsigned int len, unsigned int truesize)
+				   unsigned int len, unsigned int truesize,
+				   bool hdr_valid)
 {
 	struct sk_buff *skb;
 	struct virtio_net_hdr_mrg_rxbuf *hdr;
@@ -387,7 +388,8 @@ static struct sk_buff *page_to_skb(struc
 	else
 		hdr_padded_len = sizeof(struct padded_vnet_hdr);
 
-	memcpy(hdr, p, hdr_len);
+	if (hdr_valid)
+		memcpy(hdr, p, hdr_len);
 
 	len -= hdr_len;
 	offset += hdr_padded_len;
@@ -739,7 +741,8 @@ static struct sk_buff *receive_big(struc
 				   struct virtnet_rq_stats *stats)
 {
 	struct page *page = buf;
-	struct sk_buff *skb = page_to_skb(vi, rq, page, 0, len, PAGE_SIZE);
+	struct sk_buff *skb = page_to_skb(vi, rq, page, 0, len,
+					  PAGE_SIZE, true);
 
 	stats->bytes += len - vi->hdr_len;
 	if (unlikely(!skb))
@@ -842,7 +845,8 @@ static struct sk_buff *receive_mergeable
 				rcu_read_unlock();
 				put_page(page);
 				head_skb = page_to_skb(vi, rq, xdp_page,
-						       offset, len, PAGE_SIZE);
+						       offset, len,
+						       PAGE_SIZE, false);
 				return head_skb;
 			}
 			break;
@@ -898,7 +902,7 @@ static struct sk_buff *receive_mergeable
 		goto err_skb;
 	}
 
-	head_skb = page_to_skb(vi, rq, page, offset, len, truesize);
+	head_skb = page_to_skb(vi, rq, page, offset, len, truesize, !xdp_prog);
 	curr_skb = head_skb;
 
 	if (unlikely(!curr_skb))


