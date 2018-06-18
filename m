Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E1BC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6A120852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6A120852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936903AbeFRJKu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:10:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33664 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966608AbeFRIaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:30:20 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 137D8C83;
        Mon, 18 Jun 2018 08:30:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 033/189] netfilter: nf_tables: NAT chain and extensions require NF_TABLES
Date:   Mon, 18 Jun 2018 10:12:09 +0200
Message-Id: <20180618081210.611237885@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 39f2ff0816e5421476c2bc538b68b4bb0708a78e ]

Move these options inside the scope of the 'if' NF_TABLES and
NF_TABLES_IPV6 dependencies. This patch fixes:

   net/ipv6/netfilter/nft_chain_nat_ipv6.o: In function `nft_nat_do_chain':
>> net/ipv6/netfilter/nft_chain_nat_ipv6.c:37: undefined reference to `nft_do_chain'
   net/ipv6/netfilter/nft_chain_nat_ipv6.o: In function `nft_chain_nat_ipv6_exit':
>> net/ipv6/netfilter/nft_chain_nat_ipv6.c:94: undefined reference to `nft_unregister_chain_type'
   net/ipv6/netfilter/nft_chain_nat_ipv6.o: In function `nft_chain_nat_ipv6_init':
>> net/ipv6/netfilter/nft_chain_nat_ipv6.c:87: undefined reference to `nft_register_chain_type'

that happens with:

CONFIG_NF_TABLES=m
CONFIG_NFT_CHAIN_NAT_IPV6=y

Fixes: 02c7b25e5f54 ("netfilter: nf_tables: build-in filter chain type")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/netfilter/Kconfig |   55 ++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

--- a/net/ipv6/netfilter/Kconfig
+++ b/net/ipv6/netfilter/Kconfig
@@ -48,6 +48,34 @@ config NFT_CHAIN_ROUTE_IPV6
 	  fields such as the source, destination, flowlabel, hop-limit and
 	  the packet mark.
 
+if NF_NAT_IPV6
+
+config NFT_CHAIN_NAT_IPV6
+	tristate "IPv6 nf_tables nat chain support"
+	help
+	  This option enables the "nat" chain for IPv6 in nf_tables. This
+	  chain type is used to perform Network Address Translation (NAT)
+	  packet transformations such as the source, destination address and
+	  source and destination ports.
+
+config NFT_MASQ_IPV6
+	tristate "IPv6 masquerade support for nf_tables"
+	depends on NFT_MASQ
+	select NF_NAT_MASQUERADE_IPV6
+	help
+	  This is the expression that provides IPv4 masquerading support for
+	  nf_tables.
+
+config NFT_REDIR_IPV6
+	tristate "IPv6 redirect support for nf_tables"
+	depends on NFT_REDIR
+	select NF_NAT_REDIRECT
+	help
+	  This is the expression that provides IPv4 redirect support for
+	  nf_tables.
+
+endif # NF_NAT_IPV6
+
 config NFT_REJECT_IPV6
 	select NF_REJECT_IPV6
 	default NFT_REJECT
@@ -99,39 +127,12 @@ config NF_NAT_IPV6
 
 if NF_NAT_IPV6
 
-config NFT_CHAIN_NAT_IPV6
-	depends on NF_TABLES_IPV6
-	tristate "IPv6 nf_tables nat chain support"
-	help
-	  This option enables the "nat" chain for IPv6 in nf_tables. This
-	  chain type is used to perform Network Address Translation (NAT)
-	  packet transformations such as the source, destination address and
-	  source and destination ports.
-
 config NF_NAT_MASQUERADE_IPV6
 	tristate "IPv6 masquerade support"
 	help
 	  This is the kernel functionality to provide NAT in the masquerade
 	  flavour (automatic source address selection) for IPv6.
 
-config NFT_MASQ_IPV6
-	tristate "IPv6 masquerade support for nf_tables"
-	depends on NF_TABLES_IPV6
-	depends on NFT_MASQ
-	select NF_NAT_MASQUERADE_IPV6
-	help
-	  This is the expression that provides IPv4 masquerading support for
-	  nf_tables.
-
-config NFT_REDIR_IPV6
-	tristate "IPv6 redirect support for nf_tables"
-	depends on NF_TABLES_IPV6
-	depends on NFT_REDIR
-	select NF_NAT_REDIRECT
-	help
-	  This is the expression that provides IPv4 redirect support for
-	  nf_tables.
-
 endif # NF_NAT_IPV6
 
 config IP6_NF_IPTABLES


