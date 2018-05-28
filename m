Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031991AbeE1KS5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:18:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031903AbeE1KSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:18:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maximilian Wilhelm <max@sdn.clinic>,
        Matthias Schiffer <mschiffer@universe-factory.net>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 108/268] batman-adv: invalidate checksum on fragment reassembly
Date: Mon, 28 May 2018 12:01:22 +0200
Message-Id: <20180528100214.428111909@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Schiffer <mschiffer@universe-factory.net>

[ Upstream commit 3bf2a09da956b43ecfaa630a2ef9a477f991a46a ]

A more sophisticated implementation could try to combine fragment checksums
when all fragments have CHECKSUM_COMPLETE and are split at even offsets.
For now, we just set ip_summed to CHECKSUM_NONE to avoid "hw csum failure"
warnings in the kernel log when fragmented frames are received. In
consequence, skb_pull_rcsum() can be replaced with skb_pull().

Note that in usual setups, packets don't reach batman-adv with
CHECKSUM_COMPLETE (I assume NICs bail out of checksumming when they see
batadv's ethtype?), which is why the log messages do not occur on every
system using batman-adv. I could reproduce this issue by stacking
batman-adv on top of a VXLAN interface.

Fixes: 610bfc6bc99b ("batman-adv: Receive fragmented packets and merge")
Tested-by: Maximilian Wilhelm <max@sdn.clinic>
Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/fragmentation.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -278,7 +278,8 @@ batadv_frag_merge_packets(struct hlist_h
 	/* Move the existing MAC header to just before the payload. (Override
 	 * the fragment header.)
 	 */
-	skb_pull_rcsum(skb_out, hdr_size);
+	skb_pull(skb_out, hdr_size);
+	skb_out->ip_summed = CHECKSUM_NONE;
 	memmove(skb_out->data - ETH_HLEN, skb_mac_header(skb_out), ETH_HLEN);
 	skb_set_mac_header(skb_out, -ETH_HLEN);
 	skb_reset_network_header(skb_out);
