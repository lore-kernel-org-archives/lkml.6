Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 39C85C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEB2208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDwjaQnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEB2208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934892AbeFLRBt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:01:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934959AbeFLQxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:53:05 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 652E7208B4;
        Tue, 12 Jun 2018 16:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822384;
        bh=fcGfxoI4frL1ZcFZZGFYIFQp/M2dUnd5lUVM98PycJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IDwjaQnE8+eyEwtQ4MUH+ybfewLtu99vPs3Av7CNKyzLbq8I5qqWZXt2pZFoAR+Bp
         OjAa1PVv+s6ZCqO9KNSza7Y+/L64RDjKlGv3K2LujPT5SzU51BYwdV+z3+6ATn68cT
         OJv+JjIuaZzQa9OT0aj8eJOoHfzitH292IpBxh74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tariq Toukan <tariqt@mellanox.com>,
        Willem de Bruijn <willemb@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 18/24] packet: fix reserve calculation
Date:   Tue, 12 Jun 2018 18:52:02 +0200
Message-Id: <20180612164817.509369173@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164816.587001852@linuxfoundation.org>
References: <20180612164816.587001852@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 9aad13b087ab0a588cd68259de618f100053360e ]

Commit b84bbaf7a6c8 ("packet: in packet_snd start writing at link
layer allocation") ensures that packet_snd always starts writing
the link layer header in reserved headroom allocated for this
purpose.

This is needed because packets may be shorter than hard_header_len,
in which case the space up to hard_header_len may be zeroed. But
that necessary padding is not accounted for in skb->len.

The fix, however, is buggy. It calls skb_push, which grows skb->len
when moving skb->data back. But in this case packet length should not
change.

Instead, call skb_reserve, which moves both skb->data and skb->tail
back, without changing length.

Fixes: b84bbaf7a6c8 ("packet: in packet_snd start writing at link layer allocation")
Reported-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2779,7 +2779,7 @@ static int packet_snd(struct socket *soc
 		if (unlikely(offset < 0))
 			goto out_free;
 	} else if (reserve) {
-		skb_push(skb, reserve);
+		skb_reserve(skb, -reserve);
 	}
 
 	/* Returns -EFAULT on error */


