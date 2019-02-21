Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF2BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC2320855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="zbQju4YH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfBUAXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:23:06 -0500
Received: from mx.aristanetworks.com ([162.210.129.12]:34220 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbfBUAXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:23:06 -0500
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id DB0A7FE3;
        Wed, 20 Feb 2019 16:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1550708585;
        bh=TpqENjqzJ1bZhC+C9lOt0GgQRxNUc8AfzoJbNHuvoaQ=;
        h=Date:From:To:Cc:Subject;
        b=zbQju4YHO79ALTPyl9V0HsTe/BBqtvWTL9IX83zLD7GHsRNc4f6B5aZL/kUtf5EgV
         SX9tn8g8gl5xluoMlfP+4IKtcji7sRsyAPWHPeoM6FpkSc6l3MnnikPNTVnYavnQI/
         lM8knTKQGbtlHqrfisD0n4Y+O7EFrsRR4S0SyudFP2jUOMPwdn0TD1TrMqJNaJ7/Wt
         uX9XQANx+OUf1sPZCmacKmYE9lIssvzR95nrP7lYZuzRJypt8rhaYHYDkQ8Ox8Vx30
         mMaX+NSZvVG6U4YScdSb9ygUS3344oCOyWhLL0vdNlPz/JB7wKxC9rD3aBh5beSe1/
         ctrIUt7bS06bQ==
Received: from us178.sjc.aristanetworks.com (us178.sjc.aristanetworks.com [172.25.226.4])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id D8B4AFE2;
        Wed, 20 Feb 2019 16:23:05 -0800 (PST)
Received: by us178.sjc.aristanetworks.com (Postfix, from userid 10432)
        id 2C3A777C0111; Wed, 20 Feb 2019 16:23:04 -0800 (PST)
Date:   Wed, 20 Feb 2019 16:23:04 -0800
From:   Kalash Nainwal <kalash@arista.com>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        kalash@arista.com
Subject: [PATCH] Set rtm_table to RT_TABLE_COMPAT for ipv6 for tables > 255
Message-ID: <20190221002304.GA24732@us178.sjc.aristanetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set rtm_table to RT_TABLE_COMPAT for ipv6 for tables > 255 to
keep legacy software happy. This is similar to what was done for
ipv4 in commit 709772e6e065 ("net: Fix routing tables with
id > 255 for legacy software").

Signed-off-by: Kalash Nainwal <kalash@arista.com>
---
 net/ipv6/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 964491cf3672..77c07b2943f5 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4649,7 +4649,7 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 		table = rt->fib6_table->tb6_id;
 	else
 		table = RT6_TABLE_UNSPEC;
-	rtm->rtm_table = table;
+	rtm->rtm_table = table < 256 ? table : RT_TABLE_COMPAT;
 	if (nla_put_u32(skb, RTA_TABLE, table))
 		goto nla_put_failure;
 
-- 
2.19.1

