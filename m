Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520453080-2-4749827038978113950
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
    t=1520453079; b=XoeTnpVoDpNOUn4Bg+CmPP3NnBVa2De38JoblRLd5z6kbVk
    ZYVwKKc+5D3k0WZtIIygtRF1uwAaS3/7tC/a/dwUBN2PC+uomB4Ik4zmFR8oAc9/
    PujctwOovRoQOHp+Wacr4PPtnFx3515zns9tJr5B4APOAWeowFNSzqeO19XTB0Fy
    Up/HQlLsRz8dFIc7o62zPzc48AHWPJPH+b2ibKauqMEUAA0vDo3tmprgTzx5/rLD
    BtdCL8i8mcEGHC9pHMDdAjGU4Nr0dMoL+JfOW7a73gAVlq8ITEv+SNXMN1fi13Fr
    AuBonhh0znJtRUdeujHlghd2vGkECUJnQoROf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520453079; bh=3Er53ybPz1O0Qta4FTdRF2KpnP
    DGxZTy58ZO2X8eQmM=; b=bQPTQrf2iOn13cvBJqD7Pkva2abKptT51mEUF98KEb
    U1SQsAIOB+9apG5CRLway+6Wq/Fs3jDUmPl/LzCq0WjQ1gjZOkiZgQG0bmt7hZC4
    Hsu1kBhMpTR1/zT6JQOiBvt6bN5gid/tDmb7uj3ZDZLPIWVkmX0VJ3DY2xaq38SF
    pBv3QOZ2mRLhGx3zMcE8bGHCGxQLBoWDoTvMKFYA+IKTwIEV1gCxcMphrkJ53uco
    cwhvTMr35kvBNldhGhp+aTo904rvUSV/4Ib27vMKjYtWgb+dDGV0bTZYO+8QLiw4
    bFKrdi+j4MQAzmK4E36YkHoAW2EyvcI8Tp6xLSTPFlBQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S934950AbeCGUEV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 15:04:21 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44596 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965528AbeCGTqZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:25 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Teodor Milkov <tm@del.bg>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 061/110] tcp: revert F-RTO extension to detect more spurious timeouts
Date: Wed,  7 Mar 2018 11:38:44 -0800
Message-Id: <20180307191047.384165827@linuxfoundation.org>
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


[ Upstream commit fc68e171d376c322e6777a3d7ac2f0278b68b17f ]

This reverts commit 89fe18e44f7ee5ab1c90d0dff5835acee7751427.

While the patch could detect more spurious timeouts, it could cause
poor TCP performance on broken middle-boxes that modifies TCP packets
(e.g. receive window, SACK options). Since the performance gain is
much smaller compared to the potential loss. The best solution is
to fully revert the change.

Fixes: 89fe18e44f7e ("tcp: extend F-RTO to catch more spurious timeouts")
Reported-by: Teodor Milkov <tm@del.bg>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |   30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1947,6 +1947,7 @@ void tcp_enter_loss(struct sock *sk)
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct net *net = sock_net(sk);
 	struct sk_buff *skb;
+	bool new_recovery = icsk->icsk_ca_state < TCP_CA_Recovery;
 	bool is_reneg;			/* is receiver reneging on SACKs? */
 	bool mark_lost;
 
@@ -2009,15 +2010,12 @@ void tcp_enter_loss(struct sock *sk)
 	tp->high_seq = tp->snd_nxt;
 	tcp_ecn_queue_cwr(tp);
 
-	/* F-RTO RFC5682 sec 3.1 step 1 mandates to disable F-RTO
-	 * if a previous recovery is underway, otherwise it may incorrectly
-	 * call a timeout spurious if some previously retransmitted packets
-	 * are s/acked (sec 3.2). We do not apply that retriction since
-	 * retransmitted skbs are permanently tagged with TCPCB_EVER_RETRANS
-	 * so FLAG_ORIG_SACK_ACKED is always correct. But we do disable F-RTO
-	 * on PTMU discovery to avoid sending new data.
+	/* F-RTO RFC5682 sec 3.1 step 1: retransmit SND.UNA if no previous
+	 * loss recovery is underway except recurring timeout(s) on
+	 * the same SND.UNA (sec 3.2). Disable F-RTO on path MTU probing
 	 */
 	tp->frto = sysctl_tcp_frto &&
+		   (new_recovery || icsk->icsk_retransmits) &&
 		   !inet_csk(sk)->icsk_mtup.probe_size;
 }
 
@@ -2696,18 +2694,14 @@ static void tcp_process_loss(struct sock
 	    tcp_try_undo_loss(sk, false))
 		return;
 
-	/* The ACK (s)acks some never-retransmitted data meaning not all
-	 * the data packets before the timeout were lost. Therefore we
-	 * undo the congestion window and state. This is essentially
-	 * the operation in F-RTO (RFC5682 section 3.1 step 3.b). Since
-	 * a retransmitted skb is permantly marked, we can apply such an
-	 * operation even if F-RTO was not used.
-	 */
-	if ((flag & FLAG_ORIG_SACK_ACKED) &&
-	    tcp_try_undo_loss(sk, tp->undo_marker))
-		return;
-
 	if (tp->frto) { /* F-RTO RFC5682 sec 3.1 (sack enhanced version). */
+		/* Step 3.b. A timeout is spurious if not all data are
+		 * lost, i.e., never-retransmitted data are (s)acked.
+		 */
+		if ((flag & FLAG_ORIG_SACK_ACKED) &&
+		    tcp_try_undo_loss(sk, true))
+			return;
+
 		if (after(tp->snd_nxt, tp->high_seq)) {
 			if (flag & FLAG_DATA_SACKED || is_dupack)
 				tp->frto = 0; /* Step 3.a. loss was real */
