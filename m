Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518184373-5-10442050559958249234
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
    t=1518184373; b=S+IikNmbdWbcOu0rkYZxgqjT9RIvLMU7DnIGol/jaFDMKGB
    d0WjBYhfTzARf3LRUwCm66yfgnevVko/Hz6oPh3ChhKj30tZmZo8T1WPWeqhnYai
    lP6I7IEtzcVhkezB6I7R+OeWGaVF7c6NsSsEeGaEqe7WrEvlsL13uHZM1iCVYdlz
    M24PJrcgThTYKtE8o9G/WHhZoZV833v2hyUVbYzgWB69+oqXjb7q8PaaPAng3ITm
    h6uZ8gJ9M+4s7o1+gc7LdK8Pt+8IorAuTUpQTHMNzvO+YrXj5nigOqfskOGVmDuh
    XRvpms3jzDBxZ+zh005H/huLlgyCkVrXnnufWAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184373; bh=hI+308x+y5NM9k2SUQ5AkHRyuQ
    0QyetEYxWn7yNVBfw=; b=n6PGYbBi4vC0IdzV89EX12Ze5UCxVtBbpLvLZCBuHc
    i1b/Anliqqg4vYtqFtgJdtuYGLSgl7nFYuEOBBhNh2zn0DBrgW6l0MUrJwkzSB6t
    l4Fll9moorm/tSB9OWlJysmoxL/cqjEgMlqiHotn0re8ESc10uYkHa3RmPtqI3oG
    njBmr38vqPsske6q1AZBVaVW4jzsZ9I9FUi6IuUJkJut/Nxj/WQrQQYh9CUwTsTN
    oEywSDqAu/VF6UMdDgEAfFUmKwObfmU2z6A0l/V2iTZuO3n/VpkWCPV2pbb9BJr2
    R1QpZIXHMufn8gA4Q0/ubdKBjJaePy7vZLgiqtFlxEgg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753731AbeBINqE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:46:04 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52412 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753707AbeBINqC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:46:02 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 09/22] tcp: release sk_frag.page in tcp_disconnect
Date: Fri,  9 Feb 2018 14:39:58 +0100
Message-Id: <20180209133934.727817804@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133934.024795822@linuxfoundation.org>
References: <20180209133934.024795822@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2379,6 +2379,12 @@ int tcp_disconnect(struct sock *sk, int
 
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
