Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804437-2-12911086438115437050
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
    t=1521804437; b=s0fe90n13RKMOW7K4YghuMZdytmPIO94fvFxkEHW71puUOq
    rSglCcMl8ub+zrwcs6wwkBOo1dubo59ncT+eyoJosp/z0WEOsrpcpAa1sUZrus8W
    R4ArI8clsc43cpj1RdAB3nKqVpqf49hfeRlRgVVUpJmNLlbAbDkU+G+Cg0WzDxfm
    kNxZBqt95Y1RAAFqBtWNaXLE1HackM4wFpjRk74d0HGsHnENl3yuB45RbW0PT5dP
    RMhbTeC2GNRNWhdWnw2M4mZ2/CldKF4BizAbQGtaHuIGdxadoKY8voqDP5v951bT
    fuOA0JlgmPkIXCnzuUXwwx1GEu1yF4HO99JzPuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804437; bh=UYz11cAR1L9awToJFCGo+npoY2
    xmktCsY74El4j1ysc=; b=JaA+FQttIyBbFCnuUc6hyl+W82xuMfaoyBGOMseDGg
    5w/7sn81gAiA2ZlE9K47B/brpn2l81gOQvNAkOWz+taHBT/xxuwKUTT3LRT8uoZa
    HIeigCjf/dLrbHFjixrleRpeobJijLhTswUDa+JGoIZpdg4T8nTP8uvZwvpWkGD9
    BR9wWsGdgLvV8QpLUCKF3xWGN46yWOFrwnBc8QE1+l0HpSUId6WQXCfDep4JyGQ/
    9qvBhnmzAd1DToQCqDUPCf67IoPIgcbj5rUFcMj8fxVXelPuVN9+xqdFsin0+srL
    tLP6RFpGypjnxP2/o8Pv/7b8brAbme1rj6+uYQW7278A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
        id S932359AbeCWKHL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:07:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41124 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932312AbeCWKHJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:07:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 070/177] xprtrdma: Cancel refresh worker during buffer shutdown
Date: Fri, 23 Mar 2018 10:53:18 +0100
Message-Id: <20180323094208.416457072@linuxfoundation.org>
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

From: Chuck Lever <chuck.lever@oracle.com>


[ Upstream commit 9378b274e1eb6925db315e345f48850d2d5d9789 ]

Trying to create MRs while the transport is being torn down can
cause a crash.

Fixes: e2ac236c0b65 ("xprtrdma: Allocate MRs on demand")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sunrpc/xprtrdma/verbs.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1054,6 +1054,7 @@ void
 rpcrdma_buffer_destroy(struct rpcrdma_buffer *buf)
 {
 	cancel_delayed_work_sync(&buf->rb_recovery_worker);
+	cancel_delayed_work_sync(&buf->rb_refresh_worker);
 
 	while (!list_empty(&buf->rb_recv_bufs)) {
 		struct rpcrdma_rep *rep;
