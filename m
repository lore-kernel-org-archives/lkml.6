Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id TwSdB7PzG1sTZwAAmS7hNA
	; Sat, 09 Jun 2018 15:35:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B5786608BF; Sat,  9 Jun 2018 15:35:33 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GibFu6/u"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 27080608B8;
	Sat,  9 Jun 2018 15:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27080608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933068AbeFIPfb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:35:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932783AbeFIPf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:35:27 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A2E6208A3;
        Sat,  9 Jun 2018 15:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558526;
        bh=hhGinPM0qWJzceoDQdEcahjBbuxqmzXNKU9kSC3Rt1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GibFu6/uofDQE6pPfDA3DcdEOltppoZqj3XnyIY2hoj7zvlFcAyc+UkeoO5rNDnaD
         8Mgs1NDFSPBjNsKdKEu+xx9UiAUhZeC8+LLdNnCIc0BwQVtHGDhLIkDLpSP4FceGWn
         4Ec62we16+DT40x576dTGEkQFsy5n1h4zJQVC4pQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, DaeRyong Jeong <threeearcat@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 14/41] ipv4: remove warning in ip_recv_error
Date: Sat,  9 Jun 2018 17:29:46 +0200
Message-Id: <20180609152927.205702978@linuxfoundation.org>
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
@@ -511,8 +511,6 @@ int ip_recv_error(struct sock *sk, struc
 	int err;
 	int copied;
 
-	WARN_ON_ONCE(sk->sk_family == AF_INET6);
-
 	err = -EAGAIN;
 	skb = sock_dequeue_err_skb(sk);
 	if (!skb)
