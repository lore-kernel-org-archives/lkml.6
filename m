Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43C4ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B8420854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B8420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbeGWN1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:27:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45326 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387882AbeGWN1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:27:51 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B18E0AEF;
        Mon, 23 Jul 2018 12:26:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Herbert <tom@herbertland.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 38/63] ipv6: ila: select CONFIG_DST_CACHE
Date:   Mon, 23 Jul 2018 14:24:44 +0200
Message-Id: <20180723122447.822705565@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 83ed7d1fe2d2d4a11b30660dec20168bb473d9c1 ]

My randconfig builds came across an old missing dependency for ILA:

ERROR: "dst_cache_set_ip6" [net/ipv6/ila/ila.ko] undefined!
ERROR: "dst_cache_get" [net/ipv6/ila/ila.ko] undefined!
ERROR: "dst_cache_init" [net/ipv6/ila/ila.ko] undefined!
ERROR: "dst_cache_destroy" [net/ipv6/ila/ila.ko] undefined!

We almost never run into this by accident because randconfig builds
end up selecting DST_CACHE from some other tunnel protocol, and this
one appears to be the only one missing the explicit 'select'.

>From all I can tell, this problem first appeared in linux-4.9
when dst_cache support got added to ILA.

Fixes: 79ff2fc31e0f ("ila: Cache a route to translated address")
Cc: Tom Herbert <tom@herbertland.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv6/Kconfig
+++ b/net/ipv6/Kconfig
@@ -108,6 +108,7 @@ config IPV6_MIP6
 config IPV6_ILA
 	tristate "IPv6: Identifier Locator Addressing (ILA)"
 	depends on NETFILTER
+	select DST_CACHE
 	select LWTUNNEL
 	---help---
 	  Support for IPv6 Identifier Locator Addressing (ILA).


