Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697A0C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323F720880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763049;
	bh=4hZ0ycmlpMFT6CraoddwKQMRkvPOy56l0a2YYxYqJ30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UG2pzAvhwraItSUoTFneg9sfJ5Rr2QXOrK3ddQS8zNF9SycVJAeU48lubwrF/Hv4T
	 ycWV2BYAqYg/NVmmKmJbeq+vH6bT+F8hyPg9Uyu0ZVr1r4j/0aCddwiGeQO/fDo6Is
	 VGhqsQ1puG2UpzoGfHFJcx6mHarztj1P8Su+gqyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbfA2L51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:57:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730957AbfA2LtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:49:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 945B42086C;
        Tue, 29 Jan 2019 11:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762540;
        bh=4hZ0ycmlpMFT6CraoddwKQMRkvPOy56l0a2YYxYqJ30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E9e/gj6mJhdfb7oDI/o9hHuC0W+0RYh6/CXYtNuIlczuxAMyqpcAfoGNY9HBYzsEh
         iak+ylAjZxufDr8/CRsCaGK/IXAVX26TIUK5oTWPviFmJKA8GhIaXMxsSTx6UiN1W3
         LvLO7A5am2Ozfr+NlYh2NLK9eVQBE241AFTBPfTk=
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
Subject: [PATCH 4.14 09/68] tcp: allow MSG_ZEROCOPY transmission also in CLOSE_WAIT state
Date:   Tue, 29 Jan 2019 12:35:31 +0100
Message-Id: <20190129113132.406064331@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1178,7 +1178,7 @@ int tcp_sendmsg_locked(struct sock *sk,
 	flags = msg->msg_flags;
 
 	if (flags & MSG_ZEROCOPY && size && sock_flag(sk, SOCK_ZEROCOPY)) {
-		if (sk->sk_state != TCP_ESTABLISHED) {
+		if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
 			err = -EINVAL;
 			goto out_err;
 		}


