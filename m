Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9F489C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555FA208CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555FA208CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935413AbeFMQzq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:55:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:35880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935035AbeFMQzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:55:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AF5C7AC25;
        Wed, 13 Jun 2018 16:55:43 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 0F92DA09E2; Wed, 13 Jun 2018 18:55:43 +0200 (CEST)
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH RESEND] tcp: avoid F-RTO if SACK and timestamps are disabled
To:     netdev@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Ilpo Jarvinen <ilpo.jarvinen@helsinki.fi>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20180613164802.99B89A09E2@unicorn.suse.cz>
References: <20180613164802.99B89A09E2@unicorn.suse.cz>
Message-Id: <20180613165543.0F92DA09E2@unicorn.suse.cz>
Date:   Wed, 13 Jun 2018 18:55:43 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When F-RTO algorithm (RFC 5682) is used on connection without both SACK and
timestamps (either because of (mis)configuration or because the other
endpoint does not advertise them), specific pattern loss can make RTO grow
exponentially until the sender is only able to send one packet per two
minutes (TCP_RTO_MAX).

One way to reproduce is to

  - make sure the connection uses neither SACK nor timestamps
  - let tp->reorder grow enough so that lost packets are retransmitted
    after RTO (rather than when high_seq - snd_una > reorder * MSS)
  - let the data flow stabilize
  - drop multiple sender packets in "every second" pattern
  - either there is no new data to send or acks received in response to new
    data are also window updates (i.e. not dupacks by definition)

In this scenario, the sender keeps cycling between retransmitting first
lost packet (step 1 of RFC 5682), sending new data by (2b) and timing out
again. In this loop, the sender only gets

  (a) acks for retransmitted segments (possibly together with old ones)
  (b) window updates

Without timestamps, neither can be used for RTT estimator and without SACK,
we have no newly sacked segments to estimate RTT either. Therefore each
timeout doubles RTO and without usable RTT samples so that there is nothing
to counter the exponential growth.

While disabling both SACK and timestamps doesn't make any sense, the
resulting behaviour is so pathological that it deserves an improvement.
(Also, both can be disabled on the other side.) Avoid F-RTO algorithm in
case both SACK and timestamps are disabled so that the sender falls back to
traditional slow start retransmission.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 net/ipv4/tcp_input.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 355d3dffd021..ed603f987b72 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2001,7 +2001,8 @@ void tcp_enter_loss(struct sock *sk)
 	 */
 	tp->frto = net->ipv4.sysctl_tcp_frto &&
 		   (new_recovery || icsk->icsk_retransmits) &&
-		   !inet_csk(sk)->icsk_mtup.probe_size;
+		   !inet_csk(sk)->icsk_mtup.probe_size &&
+		   (tcp_is_sack(tp) || tp->rx_opt.tstamp_ok);
 }
 
 /* If ACK arrived pointing to a remembered SACK, it means that our
-- 
2.17.1

