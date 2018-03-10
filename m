Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1720711-1520641344-2-4648374699244544733
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
    t=1520641344; b=mwzGS9rEAemeR81b/QNydUsZCOnKy1aHvWQcPJnRzyWjNBl
    MgwPnhlj9tWJDbAo0r9AcGynFopqw+BckAWAsRqMC7RYFimadhY88G+S6YAoAXaR
    y/45/3RGyIM/QdDcmjapVlCRObX+hLXoR3aXWGBBAMpXLdUtR0dWKuWyESWsiNEM
    7r1GTciNtvicz0KsnpPuQMTCjHTDOcLibJ73+SPP2uPTHBwBfKIQVQVfM0PYcpUK
    QSnSeBMIx5TKuLaUBlk8J21BgVBhXf97fiq6/r+CZCsCDmy5rgdBJOE2413mocPD
    pXFYmT+V6FA4JlRroFblErfOGr2IuEKbH+BsghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520641344; bh=QDzTNO4wsF3IIOXbXDcoT1BB0M
    An/aQ5LnQsvJQXjds=; b=G4zBxIOG169KUz4SujuLVNq5oWlCBPziLURpzkjm0l
    uWKkRMQ/OmpSTOSevMltMQVY+c1ciANfCFLRuCV2nEs9NuS+v6of7+1udzQaiUsN
    sten7oksc5eX/BqqNnAJF1RsX4WjKhJ+yjnE9XMI12g88hv9o0otG/RWv2rCAyJw
    itudMt9YycWUjG9fcmGZBxx5SFAL9znmZYt8mFbqJIYfkhaPEX9HPs2EriKRn/Ex
    Ioa/TlSpyGrH2k+1qElL2JaPiLQaLAI62HWj2o7UaBD0MwP2C/tPWlscdZgHcQ4O
    /XAnPfBMypzuoy8HwQMqWjOUl8hP2k7tPMV7jA0j9R1g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S1751849AbeCJAWT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:22:19 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39958 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933852AbeCJAWR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:22:17 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 46/65] rxrpc: Fix send in rxrpc_send_data_packet()
Date: Fri,  9 Mar 2018 16:18:46 -0800
Message-Id: <20180310001828.632814746@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
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

From: David Howells <dhowells@redhat.com>


[ Upstream commit 93c62c45ed5fad1b87e3a45835b251cd68de9c46 ]

All the kernel_sendmsg() calls in rxrpc_send_data_packet() need to send
both parts of the iov[] buffer, but one of them does not.  Fix it so that
it does.

Without this, short IPv6 rxrpc DATA packets may be seen that have the rxrpc
header included, but no payload.

Fixes: 5a924b8951f8 ("rxrpc: Don't store the rxrpc header in the Tx queue sk_buffs")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/output.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -391,7 +391,7 @@ send_fragmentable:
 					(char *)&opt, sizeof(opt));
 		if (ret == 0) {
 			ret = kernel_sendmsg(conn->params.local->socket, &msg,
-					     iov, 1, iov[0].iov_len);
+					     iov, 2, len);
 
 			opt = IPV6_PMTUDISC_DO;
 			kernel_setsockopt(conn->params.local->socket,
