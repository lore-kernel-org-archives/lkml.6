Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95611C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5028E213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5028E213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbeJLXLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:11:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47363 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729112AbeJLXLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:11:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 712A28B296;
        Fri, 12 Oct 2018 15:38:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A5CACDBDF;
        Fri, 12 Oct 2018 15:38:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net] rxrpc: Fix incorrect conditional on IPV6
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     kbuild-all@01.org, Arnd Bergmann <arnd@arndb.de>,
        Arnd Bergmann <arnd@arndb.de>, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 12 Oct 2018 16:38:36 +0100
Message-ID: <153935871685.8157.12127765977392104630.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 12 Oct 2018 15:38:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The udpv6_encap_enable() function is part of the ipv6 code, and if that is
configured as a loadable module and rxrpc is built in then a build failure
will occur because the conditional check is wrong:

  net/rxrpc/local_object.o: In function `rxrpc_lookup_local':
  local_object.c:(.text+0x2688): undefined reference to `udpv6_encap_enable'

Use the correct config symbol (CONFIG_AF_RXRPC_IPV6) in the conditional
check rather than CONFIG_IPV6 as that will do the right thing.

Fixes: 5271953cad31 ("rxrpc: Use the UDP encap_rcv hook")
Reported-by: kbuild-all@01.org
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---

 net/rxrpc/local_object.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index cad0691c2bb4..0906e51d3cfb 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -139,7 +139,7 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 	udp_sk(usk)->gro_complete = NULL;
 
 	udp_encap_enable();
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_AF_RXRPC_IPV6)
 	if (local->srx.transport.family == AF_INET6)
 		udpv6_encap_enable();
 #endif

