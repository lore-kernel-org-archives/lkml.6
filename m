Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5A0C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B51D2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761854;
	bh=MTue32hDEd6wQ+rR2I90uV7S9JJ6ymkIG8MK6InGS2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r01SATFrKRN1DpEKXmffDQtzXFbdUsuUYgBXY25uF3DW6kTTLt8ZUyAsUzNaPnkTz
	 4DEQ1iXHFJxJ22dAl7+cD7jcLG3ng+7aQi+jONDve+kQ25TDVNc/v4zXNRMwUEP1TI
	 zHz26yxNUU2pFC7il9zaDypFW655S6ziVfAIsHiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbfA2Lhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:37:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:54132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbfA2Lh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:37:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C630320844;
        Tue, 29 Jan 2019 11:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761848;
        bh=MTue32hDEd6wQ+rR2I90uV7S9JJ6ymkIG8MK6InGS2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nGBfrugnK8PoJZxP7PzEC5aJ6R1oabYeDW9sfZ3PKT05EyZrR4nqpNGGlz77RxcsZ
         yilv1wU0D4qQVQNL8yKiYYjjsOOT+b1FtJk7xTbxIrOdO8rH8dWkRf5+Ot1tbjdyFi
         TB58Amavroc7yTmcpenm/p1OxtpZdel4kjjS0+rM=
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
Subject: [PATCH 4.20 021/117] tcp: allow MSG_ZEROCOPY transmission also in CLOSE_WAIT state
Date:   Tue, 29 Jan 2019 12:34:32 +0100
Message-Id: <20190129113208.714803911@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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


