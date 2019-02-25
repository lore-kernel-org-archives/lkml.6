Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89888C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5798C213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130059;
	bh=lLDQq5lxecYGj/Rlu60X5CwhQpAzTJWgcnTKXlj45bY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NSHWSMvlc4AJx+N4pCetStcreFPgpG/aZ2Dk3GXzYu1ToqEyKKkCIi+Jc7Cf8zS0i
	 HMOUEOgJ4MNAwQpjtRFwFQ+R0hIJxZu+FHHx8bzgIRUSHfNRQQlDu22e4Y5OMIZQ1k
	 mLo6aiPI2rtQm9biV0iQrXNBRQTzuog3lDWfetxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfBYV0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:26:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:60948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729280AbfBYV0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:26:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ABDE20C01;
        Mon, 25 Feb 2019 21:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129994;
        bh=lLDQq5lxecYGj/Rlu60X5CwhQpAzTJWgcnTKXlj45bY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D/bn3y297U0k8kRGitBCTQ/9GB73AoVMPlyrwY/smW9eREqefOIxZkR8DJrMGSbF4
         gP/hB2eaMJTEav7zLgCWE6VCGnh4OlPEaugQozKnyVzD+1RIt3qIbGX19qwzCtRXQK
         w+bOnZzlut8oQD7uzu1bXtKvEwqmlcsQxRF98Lu4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 132/152] net: validate untrusted gso packets without csum offload
Date:   Mon, 25 Feb 2019 22:12:04 +0100
Message-Id: <20190225195052.632340543@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

From: Willem de Bruijn <willemb@google.com>

commit d5be7f632bad0f489879eed0ff4b99bd7fe0b74c upstream.

Syzkaller again found a path to a kernel crash through bad gso input.
By building an excessively large packet to cause an skb field to wrap.

If VIRTIO_NET_HDR_F_NEEDS_CSUM was set this would have been dropped in
skb_partial_csum_set.

GSO packets that do not set checksum offload are suspicious and rare.
Most callers of virtio_net_hdr_to_skb already pass them to
skb_probe_transport_header.

Move that test forward, change it to detect parse failure and drop
packets on failure as those cleary are not one of the legitimate
VIRTIO_NET_HDR_GSO types.

Fixes: bfd5f4a3d605 ("packet: Add GSO/csum offload support.")
Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/skbuff.h     |    2 +-
 include/linux/virtio_net.h |    9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2392,7 +2392,7 @@ static inline void skb_probe_transport_h
 
 	if (skb_flow_dissect_flow_keys_basic(skb, &keys, NULL, 0, 0, 0, 0))
 		skb_set_transport_header(skb, keys.control.thoff);
-	else
+	else if (offset_hint >= 0)
 		skb_set_transport_header(skb, offset_hint);
 }
 
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -57,6 +57,15 @@ static inline int virtio_net_hdr_to_skb(
 
 		if (!skb_partial_csum_set(skb, start, off))
 			return -EINVAL;
+	} else {
+		/* gso packets without NEEDS_CSUM do not set transport_offset.
+		 * probe and drop if does not match one of the above types.
+		 */
+		if (gso_type) {
+			skb_probe_transport_header(skb, -1);
+			if (!skb_transport_header_was_set(skb))
+				return -EINVAL;
+		}
 	}
 
 	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {


