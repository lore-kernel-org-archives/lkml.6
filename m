Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4119318-1520452960-2-6929985616747839514
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
    t=1520452959; b=IrlsVQhAhyD21dnOEA9QPAvOuapcIm8NSs2vwQvhjn+hvw0
    qX7S2naQNs4H36rNrPnfyCG04CZgVRV1d8UIXge7uJmMoVW/2yyMHnmej3HGrelU
    X8G8S1z90zjDdnp6DuOkjaPyScpLJ5p2zY39vblnpl12GX8gmmJxMsl7rpXum9+s
    D/amb8ABjORu+slfyyf5L33hxLTsfPlqEIh82sSCDsrZ0BSfaVpASflM5RosMxEt
    gOG1AWI5mVmcnXxEVzYJXX2sD+6SwZhKGl1P0MXfPw/iVnaG2dly8sY/YCEt8m95
    eVYFsWIO1jscx3shmphaJ5DNLSnPq3tx/w5AfsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452959; bh=wqJGbrehhhDK5QPi5CmszP87Xu
    hxKTEQg3XhdjlTdhA=; b=doBamqRL1FX2w+FNhWrOWBrOcDnGqlDpV4Sr574IKA
    Bq5QEJwKMtmOmb+3BuJ8BgU1EOIoaykX23Kpy24eo5IQHVSUuvurpqCdB3jeTYK+
    kCyQdiX/knpmL5ZQelpTNU31eo81KQYdLc5Jsz9Sv/o9qfMHF5v0WE+O4IZzlNmR
    WeJFzkCbIf+P15tnpM/BBvWsJMXzJDIA5PYLk8Ha8JeYkol8Tdwlwo45s2GBV3O0
    0mAefPtPHstVX6uKSHY0bYKNFQgfcilc2m+aJghQaYhZ6zAq3d2iC/U8IWwZrKgc
    F+PqWLdK8g/Z+lmZ4IQkTOT04ZpK+tBV1DwbxLIZ4J2Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
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
        id S934815AbeCGUB7 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 15:01:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44776 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754753AbeCGTqu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:50 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Soheil Hassas Yeganeh <soheil@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 071/110] tcp: purge write queue upon RST
Date: Wed,  7 Mar 2018 11:38:54 -0800
Message-Id: <20180307191048.728849569@linuxfoundation.org>
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

From: Soheil Hassas Yeganeh <soheil@google.com>


[ Upstream commit a27fd7a8ed3856faaf5a2ff1c8c5f00c0667aaa0 ]

When the connection is reset, there is no point in
keeping the packets on the write queue until the connection
is closed.

RFC 793 (page 70) and RFC 793-bis (page 64) both suggest
purging the write queue upon RST:
https://tools.ietf.org/html/draft-ietf-tcpm-rfc793bis-07

Moreover, this is essential for a correct MSG_ZEROCOPY
implementation, because userspace cannot call close(fd)
before receiving zerocopy signals even when the connection
is reset.

Fixes: f214f915e7db ("tcp: enable MSG_ZEROCOPY")
Signed-off-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4011,6 +4011,7 @@ void tcp_reset(struct sock *sk)
 	/* This barrier is coupled with smp_rmb() in tcp_poll() */
 	smp_wmb();
 
+	tcp_write_queue_purge(sk);
 	tcp_done(sk);
 
 	if (!sock_flag(sk, SOCK_DEAD))
