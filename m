Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2179907-1518719917-2-2411891541855084579
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518719916; b=OK59g8tWYZtTDb3OR03FrLNrMEl6+QqaF8HshpWXnLsbAia
    0k/C+lmoq4950EXlHavaujJAQdKwGNtc0cqPslnxymVQ2TBpemYxShuPj21INxV+
    oDhYZv2ywOknuk3k/0oOkNr9sS3Gz5UlOmMAJ3bKG70vXcrbhkK0jvpS/VlvZgwC
    exsa8orEwxdZLLkcaaXPCm8sf4GXPy0bPQxQE6gNqOClmKb3HMsAojzOlfmVB06c
    6IjlhsAawNfMXhljdVh7Q1ERM/Zjxmcu3WEtzc6lyoBE5TVdhRCezcpL1/NJaXrG
    O0Iz8DQaPLBngsYGENOVNYVzC/X3QxssqYRAaJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518719916; bh=ToNvXaAJsg4taOadS/bDj7S4CH
    ujlR0hpUOMUEtDTo8=; b=iXtAxi7jJTzbTy2nxYqBDpZk4sVpWvZRn26u9COecA
    LI5uw4kOEKpuChMzHQtHTA8G0wBXZO+QZK+PqXE4wSzektcWA1XnGJB1ut60cafN
    KWeaZT1XI8y2LMnxYYDA/d6USFG1G7oXxZr8CQTUxEvOwtNbPWArz9GDUmmI4GVS
    TSpeixa+kEkxy+6iSmSLoQLpdlRSNcNeUSbVkiKKM8sqQqieISAfr76Xs0Vv1VvI
    8RbxuHN6aB2gPou/RoYziiIrtHMlndF0hkTe4bGiz4MT4QdqUkHs6hPBxYYLN8pV
    oN5Nb3nYqs9E7YVhJYWTNa8AzJxx+MgppFsp8Aiq9J3w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162878AbeBOSiT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:38:19 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51738 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162744AbeBOPX4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:23:56 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mohamed Ghannam <simo.ghannam@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 051/108] dccp: CVE-2017-8824: use-after-free in DCCP code
Date: Thu, 15 Feb 2018 16:16:48 +0100
Message-Id: <20180215151229.539031748@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mohamed Ghannam <simo.ghannam@gmail.com>

commit 69c64866ce072dea1d1e59a0d61e0f66c0dffb76 upstream.

Whenever the sock object is in DCCP_CLOSED state,
dccp_disconnect() must free dccps_hc_tx_ccid and
dccps_hc_rx_ccid and set to NULL.

Signed-off-by: Mohamed Ghannam <simo.ghannam@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/dccp/proto.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -259,6 +259,7 @@ int dccp_disconnect(struct sock *sk, int
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct inet_sock *inet = inet_sk(sk);
+	struct dccp_sock *dp = dccp_sk(sk);
 	int err = 0;
 	const int old_state = sk->sk_state;
 
@@ -278,6 +279,10 @@ int dccp_disconnect(struct sock *sk, int
 		sk->sk_err = ECONNRESET;
 
 	dccp_clear_xmit_timers(sk);
+	ccid_hc_rx_delete(dp->dccps_hc_rx_ccid, sk);
+	ccid_hc_tx_delete(dp->dccps_hc_tx_ccid, sk);
+	dp->dccps_hc_rx_ccid = NULL;
+	dp->dccps_hc_tx_ccid = NULL;
 
 	__skb_queue_purge(&sk->sk_receive_queue);
 	__skb_queue_purge(&sk->sk_write_queue);
