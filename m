Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DD1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A545E20578
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130598;
	bh=pbuCiey77CUQhBpIiKiSp3qhd6AHi7qSX8Y42FI1hGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i7Pp4PViCM/SII+neVY1N4f8BwEunMbamj5v3DJx5eF1uyMvWRkrNnFhwkEB/FvrU
	 50/tUxdYTvMScjLr7xpJ47Mw/jOPWF1o2wWRbKOvDLRMvUlS27mOOk7I3oHnwo6tsu
	 WpQQAZ5/WFj7UP0HDhX8cVdNK38LX+u/KnNbnup4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733208AbfBYVgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:36:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732760AbfBYVgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:36:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B1902184E;
        Mon, 25 Feb 2019 21:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130593;
        bh=pbuCiey77CUQhBpIiKiSp3qhd6AHi7qSX8Y42FI1hGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Be+BvCchRXMPrN4l95SJuM3JESIHDmKWeVG66DLTIRDHJG1c7pHZ54y1/aBCxmPz4
         Yel8e5qA9SfF8n4XhITcPtGfqDOWLLqn8ZA5Xp/x9r94c9ZlU/36FEXIE6Tv3+SULH
         bEBZGUfGGyceEs/Us8/2MpRTSf5VvLd+/premXzE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 169/183] net: avoid false positives in untrusted gso validation
Date:   Mon, 25 Feb 2019 22:12:22 +0100
Message-Id: <20190225195123.648041193@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
 


