Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520453082-2-6067509905100673222
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520453081; b=TZx79AIS8gUeHfzC0QJ3eM6FHybmw2qqTX+L1jv9jz81rhs
    OGYUBkK2lAGImk6zf2OPrXn7BmPh6UKsxmXhtsGh1A1z2Rc0Mb6R+0F9hmZYG4XG
    bM+qLvvdk2spZEBiyI1RQam02/gkt0kgWbBlexZGosBaXFczms1uqFQfBSPSieC4
    AqR/I0rgoVcGd8Lac0Yz4805wEk8UKLZflnzelVWyp55BCf7DOjkxJqOX8tTbWsD
    ++jZrGJN4Ev5v8HcEHy71ju2Y6VosXenDD9/dAiSgD6ilQKo114MX6e4hppPGWJC
    GdDMcSNo8GOtJIpCxgQaPtC8NA4blafT7wYWczQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520453081; bh=Z4DTuwlFekou0ka4yyh1dNyyHX
    J1pmwoVuXjQ0uwEUY=; b=iUDXy4aNY2pPHqYZ30i8u2LvysHMkz49DZjAGfY4yl
    mVrfzGU6ra8up0axgxB2E6rawR+alcVJYz/UUvs0AV5OeYNgVlmhhI6Hza8hrJFU
    PDi7MBoyqhb/71wa6hCq4kxP6fuhJKH5JkTYjwyFoSt7ygfgj/0HJSuRC6dg4u8/
    n+fBuG/bmD7aF+I8HKgzniuDKE3R5xWcTUNcvugGKcL+rRg6VucBBDfLAC8DZ4Hc
    uSDkmibrGuLJPWo0VaiPvY5NSk9gZzJKBHRKVWXF3HIp0kYnHsImhM8epL2UEvHz
    skNq2iUc4Cx3h1zfCXnkdxsONNjSbrKT0aFc1cAUqwNA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964912AbeCGUEj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 15:04:39 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44564 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965465AbeCGTqX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:23 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Teodor Milkov <tm@del.bg>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 060/110] tcp: revert F-RTO middle-box workaround
Date: Wed,  7 Mar 2018 11:38:43 -0800
Message-Id: <20180307191047.255266311@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuchung Cheng <ycheng@google.com>


[ Upstream commit d4131f09770d9b7471c9da65e6ecd2477746ac5c ]

This reverts commit cc663f4d4c97b7297fb45135ab23cfd508b35a77. While fixing
some broken middle-boxes that modifies receive window fields, it does not
address middle-boxes that strip off SACK options. The best solution is
to fully revert this patch and the root F-RTO enhancement.

Fixes: cc663f4d4c97 ("tcp: restrict F-RTO to work-around broken middle-boxes")
Reported-by: Teodor Milkov <tm@del.bg>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1947,7 +1947,6 @@ void tcp_enter_loss(struct sock *sk)
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct net *net = sock_net(sk);
 	struct sk_buff *skb;
-	bool new_recovery = icsk->icsk_ca_state < TCP_CA_Recovery;
 	bool is_reneg;			/* is receiver reneging on SACKs? */
 	bool mark_lost;
 
@@ -2010,17 +2009,15 @@ void tcp_enter_loss(struct sock *sk)
 	tp->high_seq = tp->snd_nxt;
 	tcp_ecn_queue_cwr(tp);
 
-	/* F-RTO RFC5682 sec 3.1 step 1: retransmit SND.UNA if no previous
-	 * loss recovery is underway except recurring timeout(s) on
-	 * the same SND.UNA (sec 3.2). Disable F-RTO on path MTU probing
-	 *
-	 * In theory F-RTO can be used repeatedly during loss recovery.
-	 * In practice this interacts badly with broken middle-boxes that
-	 * falsely raise the receive window, which results in repeated
-	 * timeouts and stop-and-go behavior.
+	/* F-RTO RFC5682 sec 3.1 step 1 mandates to disable F-RTO
+	 * if a previous recovery is underway, otherwise it may incorrectly
+	 * call a timeout spurious if some previously retransmitted packets
+	 * are s/acked (sec 3.2). We do not apply that retriction since
+	 * retransmitted skbs are permanently tagged with TCPCB_EVER_RETRANS
+	 * so FLAG_ORIG_SACK_ACKED is always correct. But we do disable F-RTO
+	 * on PTMU discovery to avoid sending new data.
 	 */
 	tp->frto = sysctl_tcp_frto &&
-		   (new_recovery || icsk->icsk_retransmits) &&
 		   !inet_csk(sk)->icsk_mtup.probe_size;
 }
 
