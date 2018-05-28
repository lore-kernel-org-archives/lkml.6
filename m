Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165301AbeE1NTv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:19:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163326AbeE1Kte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:49:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 188/496] xfrm: Fix ESN sequence number handling for IPsec GSO packets.
Date: Mon, 28 May 2018 11:59:33 +0200
Message-Id: <20180528100327.877774625@linuxfoundation.org>
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

From: Steffen Klassert <steffen.klassert@secunet.com>

[ Upstream commit b8b549eec8187ac1b12075d69a2d84d89b5e811a ]

When IPsec offloading was introduced, we accidentally incremented
the sequence number counter on the xfrm_state by one packet
too much in the ESN case. This leads to a sequence number gap of
one packet after each GSO packet. Fix this by setting the sequence
number to the correct value.

Fixes: d7dbefc45cf5 ("xfrm: Add xfrm_replay_overflow functions for offloading")
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_replay.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/xfrm/xfrm_replay.c
+++ b/net/xfrm/xfrm_replay.c
@@ -658,7 +658,7 @@ static int xfrm_replay_overflow_offload_
 		} else {
 			XFRM_SKB_CB(skb)->seq.output.low = oseq + 1;
 			XFRM_SKB_CB(skb)->seq.output.hi = oseq_hi;
-			xo->seq.low = oseq = oseq + 1;
+			xo->seq.low = oseq + 1;
 			xo->seq.hi = oseq_hi;
 			oseq += skb_shinfo(skb)->gso_segs;
 		}
