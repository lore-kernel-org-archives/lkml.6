Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2241641-1518720581-2-5667996552302162482
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720580; b=bVRCchDgeW30OnGG/rbY/5kgsa7D59HYF4F9exaJVXEcadT
    PybjAN8dWNbUxzhoQyz3zwZjxmEBuIeIdg+ksMntNlxVw0AEyFwi4qQgchavv1g3
    Bvw74Ml6sj99x2E+sN43Lf2zz1ve7WR6InHgJ6ZVUJOZUQeAIpJHKARbLRfA0caL
    WaVx7nFsHxsFvU8r5zaSypinBiJMPYIZznP5bfsAVYGwGUveFJy9Pv/Gp4MyAqVz
    SrjFSTdr57TDB/tIUUqedXtzPVhSWqwRxGTw5PNbw1W86qjuCmL9FC5/A8/J4B6x
    Mvv0AN50QERwOCAd5EPUZYtlOlI17EqDVu4yWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720580; bh=7tMwnhqgUsqDq6FBHsgKqDXm5a
    qxllz+nRJOEusGzaQ=; b=o0JPpJTGA6aH4WeNQESEPe5HhFKSj/8/5TkJ9iF3ab
    z0H9RLC3g8/enWaRn3ifCM/oZfMkzPzftdRFX6iq4vVQ5oMAgr3ge2w5tq+YLkHR
    BySADqRuiC6v30vaws+e9//SCz6zkTv3kCBql8drVqMQdLEMEGR6GtQmyQ9Lk3Yz
    VBWZOj6KAzwDKGC7bJu/VazskqDP1r/vnDSyJBv73ckspqspF6KbdQ4C1MYza0NL
    B7r3fHln2wwBRNnMuuV/2XUJiaruNMDtdZBp9BYnlofnRrtEhvBDj+Ti5wtmnnqU
    lyC3gDuHT708aydgIJElRt+mGkQ4N0wxegTAv8Th6b4A==
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
        id S1162164AbeBOPVs (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:21:48 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49226 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162138AbeBOPVr (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:21:47 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 031/108] tcp: release sk_frag.page in tcp_disconnect
Date: Thu, 15 Feb 2018 16:16:28 +0100
Message-Id: <20180215151226.765366399@linuxfoundation.org>
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

From: Li RongQing <lirongqing@baidu.com>


[ Upstream commit 9b42d55a66d388e4dd5550107df051a9637564fc ]

socket can be disconnected and gets transformed back to a listening
socket, if sk_frag.page is not released, which will be cloned into
a new socket by sk_clone_lock, but the reference count of this page
is increased, lead to a use after free or double free issue

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2276,6 +2276,12 @@ int tcp_disconnect(struct sock *sk, int
 
 	WARN_ON(inet->inet_num && !icsk->icsk_bind_hash);
 
+	if (sk->sk_frag.page) {
+		put_page(sk->sk_frag.page);
+		sk->sk_frag.page = NULL;
+		sk->sk_frag.offset = 0;
+	}
+
 	sk->sk_error_report(sk);
 	return err;
 }
