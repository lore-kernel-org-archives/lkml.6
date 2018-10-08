Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1AFC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E0F204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnHh5Uhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E0F204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbeJICE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:04:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbeJICEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:04:23 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64D652087D;
        Mon,  8 Oct 2018 18:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024675;
        bh=xoPIBr4+KQgPkxE50+BG05moma7QiJ5taCPucP6Ni6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tnHh5UhdUfgMTdVYDB6S6W2eejEXRfenKwNALsua30HgnQrWWZfJIEoROL7XTj1vC
         EUIDQVwmsU7XPljhQ0HmmndheGOwBzdJsxrkCjuoUNWmqXPkew3C+WoG3RoNVcQZhj
         nGplMSuB+KIdebMeEEW8D45UyVXN0G7JHMeQe/d4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 094/168] netfilter: kconfig: nat related expression depend on nftables core
Date:   Mon,  8 Oct 2018 20:31:14 +0200
Message-Id: <20181008175623.633527345@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit e0758412208960be9de11e6d2350c81ffd88410f ]

NF_TABLES_IPV4 is now boolean so it is possible to set

NF_TABLES=m
NF_TABLES_IPV4=y
NFT_CHAIN_NAT_IPV4=y

which causes:
nft_chain_nat_ipv4.c:(.text+0x6d): undefined reference to `nft_do_chain'

Wrap NFT_CHAIN_NAT_IPV4 and related nat expressions with NF_TABLES to
restore the dependency.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: 02c7b25e5f54 ("netfilter: nf_tables: build-in filter chain type")
Signed-off-by: Florian Westphal <fw@strlen.de>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/netfilter/Kconfig |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/net/ipv4/netfilter/Kconfig
+++ b/net/ipv4/netfilter/Kconfig
@@ -122,6 +122,10 @@ config NF_NAT_IPV4
 
 if NF_NAT_IPV4
 
+config NF_NAT_MASQUERADE_IPV4
+	bool
+
+if NF_TABLES
 config NFT_CHAIN_NAT_IPV4
 	depends on NF_TABLES_IPV4
 	tristate "IPv4 nf_tables nat chain support"
@@ -131,9 +135,6 @@ config NFT_CHAIN_NAT_IPV4
 	  packet transformations such as the source, destination address and
 	  source and destination ports.
 
-config NF_NAT_MASQUERADE_IPV4
-	bool
-
 config NFT_MASQ_IPV4
 	tristate "IPv4 masquerading support for nf_tables"
 	depends on NF_TABLES_IPV4
@@ -151,6 +152,7 @@ config NFT_REDIR_IPV4
 	help
 	  This is the expression that provides IPv4 redirect support for
 	  nf_tables.
+endif # NF_TABLES
 
 config NF_NAT_SNMP_BASIC
 	tristate "Basic SNMP-ALG support"


