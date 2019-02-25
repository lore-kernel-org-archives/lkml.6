Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E108CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABED62183F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129549;
	bh=wqokgowiVGdzsbkn64yBe9bHnSWf4BydwJslPfNlAYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rHQy8zXGV6D0acFUmxNy6hEv6x1S7eio5p1pT2kxxqLTkQZVKPwqoEI6dPDn2Dyup
	 JX/q/BEwKA5efN+OLLE48NITBBd1P1/JiB8s7wY2tdVMs/0FLSai4kR7lK2yesnJ/c
	 hQO4OYw4AsuERaNOP2LL5UCE4fIX+DbuEJhxwWhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbfBYVTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:19:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730228AbfBYVTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:19:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED0472183F;
        Mon, 25 Feb 2019 21:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129542;
        bh=wqokgowiVGdzsbkn64yBe9bHnSWf4BydwJslPfNlAYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mcj6MCIl8DuhGEqkYCPvlzJKwjoMeD3swV7jHfnM+t0gpslFIvMrQK4JpQll/zAx3
         sA50YW2WvAEnFV1e4E6n7CGISvkvvSP2dBeBMc2uqVfGlhKi3Ol0kc+/cYwdm31EjR
         ms6CwlpvLp5kd7W26jQF2zaStqvVzz41sBG/5zk0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 64/71] net: avoid false positives in untrusted gso validation
Date:   Mon, 25 Feb 2019 22:12:06 +0100
Message-Id: <20190225195039.487628698@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
References: <20190225195034.555044862@linuxfoundation.org>
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

From: Willem de Bruijn <willemb@google.com>

commit 9e8db5913264d3967b93c765a6a9e464d9c473db upstream.

GSO packets with vnet_hdr must conform to a small set of gso_types.
The below commit uses flow dissection to drop packets that do not.

But it has false positives when the skb is not fully initialized.
Dissection needs skb->protocol and skb->network_header.

Infer skb->protocol from gso_type as the two must agree.
SKB_GSO_UDP can use both ipv4 and ipv6, so try both.

Exclude callers for which network header offset is not known.

Fixes: d5be7f632bad ("net: validate untrusted gso packets without csum offload")
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/virtio_net.h |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -61,10 +61,20 @@ static inline int virtio_net_hdr_to_skb(
 		/* gso packets without NEEDS_CSUM do not set transport_offset.
 		 * probe and drop if does not match one of the above types.
 		 */
-		if (gso_type) {
+		if (gso_type && skb->network_header) {
+			if (!skb->protocol)
+				virtio_net_hdr_set_proto(skb, hdr);
+retry:
 			skb_probe_transport_header(skb, -1);
-			if (!skb_transport_header_was_set(skb))
+			if (!skb_transport_header_was_set(skb)) {
+				/* UFO does not specify ipv4 or 6: try both */
+				if (gso_type & SKB_GSO_UDP &&
+				    skb->protocol == htons(ETH_P_IP)) {
+					skb->protocol = htons(ETH_P_IPV6);
+					goto retry;
+				}
 				return -EINVAL;
+			}
 		}
 	}
 


