Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C478C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 22:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158DD218FF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 22:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ejR5jGNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733312AbfBPWeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 17:34:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46474 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfBPWeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 17:34:13 -0500
Received: from zn.tnic (p200300EC2BDE140040174BB645983752.dip0.t-ipconnect.de [IPv6:2003:ec:2bde:1400:4017:4bb6:4598:3752])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CEADA1EC023E;
        Sat, 16 Feb 2019 23:34:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550356452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=S3mYY+xG8vaVB5kPnOavViXAi8Y44JweyLuOLfy8v2g=;
        b=ejR5jGNpv5zQQ2UGFNfPe4dap6OpXKgkPryn0HPSAPoHX8NGr7rcHncFH8jfYdK9DaIZNI
        U0pkeOO+yFkS970SkK77JQfACV/WgOfW/lAbEX5Ok6oLYrsqvAd68GDEJntW447Q5TqAD6
        5+NwVVB3nq3MFdEo4yqxagp6MM7tK0o=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andrea Claudi <aclaudi@redhat.com>, coreteam@netfilter.org,
        Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Julian Anastasov <ja@ssi.bg>, Li Shuang <shuali@redhat.com>,
        netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Simon Horman <horms@verge.net.au>
Subject: [PATCH] netfilter/ipvs: Fix unused variable warning
Date:   Sat, 16 Feb 2019 23:33:58 +0100
Message-Id: <20190216223358.30711-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Move the local variable 'ret' into the IP_VS_IPV6 ifdef so that the
unused variable warning doesn't fire for randconfig builds with
CONFIG_IP_VS_IPV6 disabled.

Fixes: 098e13f5b21d ("ipvs: fix dependency on nf_defrag_ipv6")
Cc: Andrea Claudi <aclaudi@redhat.com>
Cc: coreteam@netfilter.org
Cc: Florian Westphal <fw@strlen.de>
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Cc: Julian Anastasov <ja@ssi.bg>
Cc: Li Shuang <shuali@redhat.com>
Cc: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Simon Horman <horms@verge.net.au>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 net/netfilter/ipvs/ip_vs_ctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 86afacb07e5f..ac8d848d7624 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -896,12 +896,13 @@ ip_vs_new_dest(struct ip_vs_service *svc, struct ip_vs_dest_user_kern *udest,
 {
 	struct ip_vs_dest *dest;
 	unsigned int atype, i;
-	int ret = 0;
 
 	EnterFunction(2);
 
 #ifdef CONFIG_IP_VS_IPV6
 	if (udest->af == AF_INET6) {
+		int ret;
+
 		atype = ipv6_addr_type(&udest->addr.in6);
 		if ((!(atype & IPV6_ADDR_UNICAST) ||
 			atype & IPV6_ADDR_LINKLOCAL) &&
-- 
2.19.1

