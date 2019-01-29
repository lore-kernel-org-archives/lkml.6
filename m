Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5C8C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2D820882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762321;
	bh=Av0LwW1BjuR+CzB2uVnU4va8U189UKLRSLLd/XobdXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nYwKR8YbfqJiG6b9N3jPtVniMfjhhSI92HSzWho0lS8bZhwIVJP/T9wgwz4lKPf+v
	 vsmQxsz/72JqjNg7l8KGHaOv6hvDwDmnhJrAYe/tjzGFsnNoRR2Xvc/l6NXKKjB2BV
	 JNYn/HlM/6vQHsl55N6mEfJlSeNYPwLsIbg+gtJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbfA2LpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:45:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730697AbfA2LpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:45:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02D332086C;
        Tue, 29 Jan 2019 11:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762314;
        bh=Av0LwW1BjuR+CzB2uVnU4va8U189UKLRSLLd/XobdXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SXECffK97m+jmHpBNDkn0r0h9SV1ZXTUvU7emVjietkLC53YHqYDgC/S9kaNpDQ+o
         BFeLRqxNFSya8w/lZQ+kNGZm0iQj8U9ZQPp/6gaeXOlvONs5cx2R1ebcepVyViOFga
         g0nhluEeNJugNpc0+57uY91exIeU1Bxx2utko44k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marek Majkowski <marek@cloudflare.com>,
        Willem de Bruijn <willemb@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Alexey Kodanev <alexey.kodanev@oracle.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 021/103] tcp: allow MSG_ZEROCOPY transmission also in CLOSE_WAIT state
Date:   Tue, 29 Jan 2019 12:34:58 +0100
Message-Id: <20190129113200.817463872@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

[ Upstream commit 13d7f46386e060df31b727c9975e38306fa51e7a ]

TCP transmission with MSG_ZEROCOPY fails if the peer closes its end of
the connection and so transitions this socket to CLOSE_WAIT state.

Transmission in close wait state is acceptable. Other similar tests in
the stack (e.g., in FastOpen) accept both states. Relax this test, too.

Link: https://www.mail-archive.com/netdev@vger.kernel.org/msg276886.html
Link: https://www.mail-archive.com/netdev@vger.kernel.org/msg227390.html
Fixes: f214f915e7db ("tcp: enable MSG_ZEROCOPY")
Reported-by: Marek Majkowski <marek@cloudflare.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
CC: Yuchung Cheng <ycheng@google.com>
CC: Neal Cardwell <ncardwell@google.com>
CC: Soheil Hassas Yeganeh <soheil@google.com>
CC: Alexey Kodanev <alexey.kodanev@oracle.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1186,7 +1186,7 @@ int tcp_sendmsg_locked(struct sock *sk,
 	flags = msg->msg_flags;
 
 	if (flags & MSG_ZEROCOPY && size && sock_flag(sk, SOCK_ZEROCOPY)) {
-		if (sk->sk_state != TCP_ESTABLISHED) {
+		if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
 			err = -EINVAL;
 			goto out_err;
 		}


