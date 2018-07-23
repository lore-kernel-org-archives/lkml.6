Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB66ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B36820854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B36820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388534AbeGWN2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:28:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45366 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388522AbeGWN2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:28:03 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 02BCFAEF;
        Mon, 23 Jul 2018 12:27:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Patrick Talbert <ptalbert@redhat.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 41/63] net: Dont copy pfmemalloc flag in __copy_skb_header()
Date:   Mon, 23 Jul 2018 14:24:47 +0200
Message-Id: <20180723122447.929810607@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Brivio <sbrivio@redhat.com>

[ Upstream commit 8b7008620b8452728cadead460a36f64ed78c460 ]

The pfmemalloc flag indicates that the skb was allocated from
the PFMEMALLOC reserves, and the flag is currently copied on skb
copy and clone.

However, an skb copied from an skb flagged with pfmemalloc
wasn't necessarily allocated from PFMEMALLOC reserves, and on
the other hand an skb allocated that way might be copied from an
skb that wasn't.

So we should not copy the flag on skb copy, and rather decide
whether to allow an skb to be associated with sockets unrelated
to page reclaim depending only on how it was allocated.

Move the pfmemalloc flag before headers_start[0] using an
existing 1-bit hole, so that __copy_skb_header() doesn't copy
it.

When cloning, we'll now take care of this flag explicitly,
contravening to the warning comment of __skb_clone().

While at it, restore the newline usage introduced by commit
b19372273164 ("net: reorganize sk_buff for faster
__copy_skb_header()") to visually separate bytes used in
bitfields after headers_start[0], that was gone after commit
a9e419dc7be6 ("netfilter: merge ctinfo into nfct pointer storage
area"), and describe the pfmemalloc flag in the kernel-doc
structure comment.

This doesn't change the size of sk_buff or cacheline boundaries,
but consolidates the 15 bits hole before tc_index into a 2 bytes
hole before csum, that could now be filled more easily.

Reported-by: Patrick Talbert <ptalbert@redhat.com>
Fixes: c93bdd0e03e8 ("netvm: allow skb allocation to use PFMEMALLOC reserves")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/skbuff.h |   10 +++++-----
 net/core/skbuff.c      |    2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)

--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -628,6 +628,7 @@ typedef unsigned char *sk_buff_data_t;
  *	@hash: the packet hash
  *	@queue_mapping: Queue mapping for multiqueue devices
  *	@xmit_more: More SKBs are pending for this queue
+ *	@pfmemalloc: skbuff was allocated from PFMEMALLOC reserves
  *	@ndisc_nodetype: router type (from link layer)
  *	@ooo_okay: allow the mapping of a socket to a queue to be changed
  *	@l4_hash: indicate hash is a canonical 4-tuple hash over transport
@@ -733,7 +734,7 @@ struct sk_buff {
 				peeked:1,
 				head_frag:1,
 				xmit_more:1,
-				__unused:1; /* one bit hole */
+				pfmemalloc:1;
 
 	/* fields enclosed in headers_start/headers_end are copied
 	 * using a single memcpy() in __copy_skb_header()
@@ -752,31 +753,30 @@ struct sk_buff {
 
 	__u8			__pkt_type_offset[0];
 	__u8			pkt_type:3;
-	__u8			pfmemalloc:1;
 	__u8			ignore_df:1;
-
 	__u8			nf_trace:1;
 	__u8			ip_summed:2;
 	__u8			ooo_okay:1;
+
 	__u8			l4_hash:1;
 	__u8			sw_hash:1;
 	__u8			wifi_acked_valid:1;
 	__u8			wifi_acked:1;
-
 	__u8			no_fcs:1;
 	/* Indicates the inner headers are valid in the skbuff. */
 	__u8			encapsulation:1;
 	__u8			encap_hdr_csum:1;
 	__u8			csum_valid:1;
+
 	__u8			csum_complete_sw:1;
 	__u8			csum_level:2;
 	__u8			csum_not_inet:1;
-
 	__u8			dst_pending_confirm:1;
 #ifdef CONFIG_IPV6_NDISC_NODETYPE
 	__u8			ndisc_nodetype:2;
 #endif
 	__u8			ipvs_property:1;
+
 	__u8			inner_protocol_type:1;
 	__u8			remcsum_offload:1;
 #ifdef CONFIG_NET_SWITCHDEV
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -858,6 +858,8 @@ static struct sk_buff *__skb_clone(struc
 	n->cloned = 1;
 	n->nohdr = 0;
 	n->peeked = 0;
+	if (skb->pfmemalloc)
+		n->pfmemalloc = 1;
 	n->destructor = NULL;
 	C(tail);
 	C(end);


