Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kfYFLbHzG1sRZwAAmS7hNA
	; Sat, 09 Jun 2018 15:35:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9EB76608C1; Sat,  9 Jun 2018 15:35:13 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/gN+0Js"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0EB97607DC;
	Sat,  9 Jun 2018 15:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EB97607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932997AbeFIPfK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932973AbeFIPfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:35:07 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64FFB208AD;
        Sat,  9 Jun 2018 15:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558507;
        bh=OhNzkdhL/CsMgqH0zx7DQO5HzwKxd6xROdF3rWpAYe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t/gN+0JsSPCHK2F9ENXefDrJIiYTL3Qt2YX8/CsdkhdNSyXUvU2aMeS1QSqxiWP5n
         NT/1y8qnSLKW2VZH9J8DN2iz4lNGc/GZSJLeI6ycius/6Cgb6nCwKe5vIExfyjT0Pk
         Ll3udiYG60sY2Rtq1FkWzwI9GyqyGQkRu6Ry4ohs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tariq Toukan <tariqt@mellanox.com>,
        Willem de Bruijn <willemb@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 24/41] packet: fix reserve calculation
Date: Sat,  9 Jun 2018 17:29:56 +0200
Message-Id: <20180609152927.728707074@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609152926.389750182@linuxfoundation.org>
References: <20180609152926.389750182@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2920,7 +2920,7 @@ static int packet_snd(struct socket *soc
 		if (unlikely(offset < 0))
 			goto out_free;
 	} else if (reserve) {
-		skb_push(skb, reserve);
+		skb_reserve(skb, -reserve);
 	}
 
 	/* Returns -EFAULT on error */
