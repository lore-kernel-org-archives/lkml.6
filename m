Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9950C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD26A25A4C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD26A25A4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933679AbeGASco (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:32:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60830 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933542AbeGAQQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:16:40 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CC1FEACC;
        Sun,  1 Jul 2018 16:16:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Wei Wang <weiwan@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Gilbert <benjamin.gilbert@coreos.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 008/105] tcp: do not overshoot window_clamp in tcp_rcv_space_adjust()
Date:   Sun,  1 Jul 2018 18:01:18 +0200
Message-Id: <20180701153150.091573267@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153149.382300170@linuxfoundation.org>
References: <20180701153149.382300170@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

commit 02db55718d53f9d426cee504c27fb768e9ed4ffe upstream.

While rcvbuf is properly clamped by tcp_rmem[2], rcvwin
is left to a potentially too big value.

It has no serious effect, since :
1) tcp_grow_window() has very strict checks.
2) window_clamp can be mangled by user space to any value anyway.

tcp_init_buffer_space() and companions use tcp_full_space(),
we use tcp_win_from_space() to avoid reloading sk->sk_rcvbuf

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Wei Wang <weiwan@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Benjamin Gilbert <benjamin.gilbert@coreos.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/tcp_input.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -612,7 +612,7 @@ void tcp_rcv_space_adjust(struct sock *s
 			sk->sk_rcvbuf = rcvbuf;
 
 			/* Make the window clamp follow along.  */
-			tp->window_clamp = rcvwin;
+			tp->window_clamp = tcp_win_from_space(rcvbuf);
 		}
 	}
 	tp->rcvq_space.space = copied;


