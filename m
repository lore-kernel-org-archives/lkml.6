Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521804698-2-5704229352660472048
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
    t=1521804698; b=Jl17DeZLzJtjPQnMfeCw0bVLhP0DNmW4kuFEwHRsjvLdDHQ
    DNHg99XUQ4LECYIDdeVa0VcrGi5bwVfif58uWKJBnfp7P92+08vlg7i1UKiLQzY4
    7moHfuTiNwFmnL3Q9z8ZP/y6RD8lnzcPltXNmmeDFXzEqfbLcERXtsdC5PCXs2kN
    HwH+iHPkJ33fTPe6yYTSRGFwzMI2d178xEdq4RAZRgmeshEsynlmLbJHm4qDQVHM
    YWwbbWZ4cmDXG4c0iXLuQ48HQd2vm3uyaVHxxFRLmQBOBcqxNUnhEpHZwKkRXxoM
    fywFcbp7fY6rLOfqGIcBZcLehiDEY3pO1ljJKXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804698; bh=IfW/SXp98FvHFz+5UYMIMIN2ea
    Ff9oA/kUxeAcHy1pk=; b=Fops+4q3qckYXzVKOVCrabmxOdF96j6mmlw+Y+2sZ5
    SANO5ugCkhmoOg2ZkSrPZqKfJIJoIjWlxmUxEtUmTTyfQLVCGPCL9ds/EEMMH9JI
    i0pzvwsy+ILq88/41V2mXOcGo1e7tmzbChN6tfakb35IQivsKom5to3RhCb5q+8N
    JrO6XdhtaKClUbLFoRokLG6PJfJ0fOKNhgIWTpvRr4DuKMW9kdF2C6ghZ6I40GYR
    cP76ImNrbUXg72opwPGEnZP0mFZQ82BUWZgFN7qn8NRM9VRAaRFZGX6ILBucNdbP
    KHmZkDNDqz+YyKGBZrL/2ZM2aIs6X9iOf2+SAKebj1oQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbeCWLbY (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:31:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40668 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755159AbeCWKGH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:06:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 041/177] tcp: remove poll() flakes with FastOpen
Date: Fri, 23 Mar 2018 10:52:49 +0100
Message-Id: <20180323094206.991719112@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit 0f9fa831aecfc297b7b45d4f046759bcefcf87f0 ]

When using TCP FastOpen for an active session, we send one wakeup event
from tcp_finish_connect(), right before the data eventually contained in
the received SYNACK is queued to sk->sk_receive_queue.

This means that depending on machine load or luck, poll() users
might receive POLLOUT events instead of POLLIN|POLLOUT

To fix this, we need to move the call to sk->sk_state_change()
after the (optional) call to tcp_rcv_fastopen_synack()

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5606,10 +5606,6 @@ void tcp_finish_connect(struct sock *sk,
 	else
 		tp->pred_flags = 0;
 
-	if (!sock_flag(sk, SOCK_DEAD)) {
-		sk->sk_state_change(sk);
-		sk_wake_async(sk, SOCK_WAKE_IO, POLL_OUT);
-	}
 }
 
 static bool tcp_rcv_fastopen_synack(struct sock *sk, struct sk_buff *synack,
@@ -5678,6 +5674,7 @@ static int tcp_rcv_synsent_state_process
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_fastopen_cookie foc = { .len = -1 };
 	int saved_clamp = tp->rx_opt.mss_clamp;
+	bool fastopen_fail;
 
 	tcp_parse_options(skb, &tp->rx_opt, 0, &foc);
 	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
@@ -5781,10 +5778,15 @@ static int tcp_rcv_synsent_state_process
 
 		tcp_finish_connect(sk, skb);
 
-		if ((tp->syn_fastopen || tp->syn_data) &&
-		    tcp_rcv_fastopen_synack(sk, skb, &foc))
-			return -1;
+		fastopen_fail = (tp->syn_fastopen || tp->syn_data) &&
+				tcp_rcv_fastopen_synack(sk, skb, &foc);
 
+		if (!sock_flag(sk, SOCK_DEAD)) {
+			sk->sk_state_change(sk);
+			sk_wake_async(sk, SOCK_WAKE_IO, POLL_OUT);
+		}
+		if (fastopen_fail)
+			return -1;
 		if (sk->sk_write_pending ||
 		    icsk->icsk_accept_queue.rskq_defer_accept ||
 		    icsk->icsk_ack.pingpong) {
