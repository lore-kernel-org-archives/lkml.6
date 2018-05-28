Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163275AbeE1Krj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:47:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163256AbeE1Krd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:47:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 111/496] virtio_net: fix XDP code path in receive_small()
Date: Mon, 28 May 2018 11:58:16 +0200
Message-Id: <20180528100324.578570962@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesper Dangaard Brouer <brouer@redhat.com>

[ Upstream commit 95dbe9e7b3720efa5cf83d21f44f6d953f7cf4a2 ]

When configuring virtio_net to use the code path 'receive_small()',
in-order to get correct XDP_REDIRECT support, I discovered TCP packets
would get silently dropped when loading an XDP program action XDP_PASS.

The bug seems to be that receive_small() when XDP is loaded check that
hdr->hdr.flags is zero, which seems wrong as hdr.flags contains the
flags VIRTIO_NET_HDR_F_* :
 #define VIRTIO_NET_HDR_F_NEEDS_CSUM 1 /* Use csum_start, csum_offset */
 #define VIRTIO_NET_HDR_F_DATA_VALID 2 /* Csum is valid */

TCP got dropped as it had the VIRTIO_NET_HDR_F_DATA_VALID flag set.

The flags that are relevant here are the VIRTIO_NET_HDR_GSO_* flags
stored in hdr->hdr.gso_type. Thus, the fix is just check that none of
the gso_type flags have been set.

Fixes: bb91accf2733 ("virtio-net: XDP support for small buffers")
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -513,7 +513,7 @@ static struct sk_buff *receive_small(str
 		void *orig_data;
 		u32 act;
 
-		if (unlikely(hdr->hdr.gso_type || hdr->hdr.flags))
+		if (unlikely(hdr->hdr.gso_type))
 			goto err_xdp;
 
 		if (unlikely(xdp_headroom < virtnet_get_headroom(vi))) {
