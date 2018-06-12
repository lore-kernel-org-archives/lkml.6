Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A2D16C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59ACD208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnN6A54W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59ACD208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934547AbeFLQrS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:47:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934035AbeFLQrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:47:13 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BC3C208B0;
        Tue, 12 Jun 2018 16:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822032;
        bh=3EhHpiK/lv67v19sdL0BiC3tBbpuddMhXgNmFiBdXpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YnN6A54W/zE/hVlJQ40al8XnqNVq9x1CyoQ/YBGadXLk38zXvqey/g7OrLy6VZxWg
         G8+rPv6EVGOYq3aMhmv7wI/qfKtoxVO1sefGiqXJUR0y8U7gxhJt4iut9+6hUjV8sQ
         3BXp/GH5BBI6Sn84BaEUt9N2naWv8vRQVBKoNNYI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, DaeRyong Jeong <threeearcat@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 12/31] ipv4: remove warning in ip_recv_error
Date:   Tue, 12 Jun 2018 18:46:15 +0200
Message-Id: <20180612164621.284507980@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164620.797338191@linuxfoundation.org>
References: <20180612164620.797338191@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 730c54d59403658a62af6517338fa8d4922c1b28 ]

A precondition check in ip_recv_error triggered on an otherwise benign
race. Remove the warning.

The warning triggers when passing an ipv6 socket to this ipv4 error
handling function. RaceFuzzer was able to trigger it due to a race
in setsockopt IPV6_ADDRFORM.

  ---
  CPU0
    do_ipv6_setsockopt
      sk->sk_socket->ops = &inet_dgram_ops;

  ---
  CPU1
    sk->sk_prot->recvmsg
      udp_recvmsg
        ip_recv_error
          WARN_ON_ONCE(sk->sk_family == AF_INET6);

  ---
  CPU0
    do_ipv6_setsockopt
      sk->sk_family = PF_INET;

This socket option converts a v6 socket that is connected to a v4 peer
to an v4 socket. It updates the socket on the fly, changing fields in
sk as well as other structs. This is inherently non-atomic. It races
with the lockless udp_recvmsg path.

No other code makes an assumption that these fields are updated
atomically. It is benign here, too, as ip_recv_error cares only about
the protocol of the skbs enqueued on the error queue, for which
sk_family is not a precise predictor (thanks to another isue with
IPV6_ADDRFORM).

Link: http://lkml.kernel.org/r/20180518120826.GA19515@dragonet.kaist.ac.kr
Fixes: 7ce875e5ecb8 ("ipv4: warn once on passing AF_INET6 socket to ip_recv_error")
Reported-by: DaeRyong Jeong <threeearcat@gmail.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_sockglue.c |    2 --
 1 file changed, 2 deletions(-)

--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -503,8 +503,6 @@ int ip_recv_error(struct sock *sk, struc
 	int err;
 	int copied;
 
-	WARN_ON_ONCE(sk->sk_family == AF_INET6);
-
 	err = -EAGAIN;
 	skb = sock_dequeue_err_skb(sk);
 	if (!skb)


