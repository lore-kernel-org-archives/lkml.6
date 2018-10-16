Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B66C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029752089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzTLUhIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029752089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731973AbeJQBQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:16:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:16:48 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 255B0204EC;
        Tue, 16 Oct 2018 17:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710722;
        bh=UkcKJUFDKgeh8ygd4qM4YRLO02Rjz67L+pMZnmu96tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SzTLUhIFPNkiyqCylu58GyngiRquSCwkY3ruijmL/i9VlkgI4J7mjEs8MzX+gZEjX
         DjlaANEXKZmsoRgEKXEX/0qKsUxTEOU5+yiAnK5HVoOrt7FfRL18np8QCRUDqOQf3k
         H3GDG2u6RuTpPUhceK6dOtuySOhyMhCQ5MiPwbxo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Nikolay Borisov <kernel@kyup.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 48/71] ipv6: export ip6 fragments sysctl to unprivileged users
Date:   Tue, 16 Oct 2018 19:09:45 +0200
Message-Id: <20181016170541.783944414@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

IPv4 was changed in commit 52a773d645e9 ("net: Export ip fragment
sysctl to unprivileged users")

The only sysctl that is not per-netns is not used :
ip6frag_secret_interval

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Nikolay Borisov <kernel@kyup.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 18dcbe12fe9fca0ab825f7eff993060525ac2503)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/reassembly.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -643,10 +643,6 @@ static int __net_init ip6_frags_ns_sysct
 		table[1].data = &net->ipv6.frags.low_thresh;
 		table[1].extra2 = &net->ipv6.frags.high_thresh;
 		table[2].data = &net->ipv6.frags.timeout;
-
-		/* Don't export sysctls to unprivileged users */
-		if (net->user_ns != &init_user_ns)
-			table[0].procname = NULL;
 	}
 
 	hdr = register_net_sysctl(net, "net/ipv6", table);


