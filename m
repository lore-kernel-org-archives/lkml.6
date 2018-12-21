Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2EFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E3E21927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391939AbeLUVGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 16:06:19 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:50652 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388454AbeLUVGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 16:06:18 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@breakpoint.cc>)
        id 1gaRzr-0005sr-3R; Fri, 21 Dec 2018 22:06:15 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netdev@vger.kernel.org>
Cc:     linux@roeck-us.net, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, Florian Westphal <fw@strlen.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH net-next] staging: octeon: fix build failure with XFRM enabled
Date:   Fri, 21 Dec 2018 21:57:26 +0100
Message-Id: <20181221205726.2924-1-fw@strlen.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skb->sp doesn't exist anymore in the next-next tree, so mips defconfig
no longer builds.  Use helper instead to reset the secpath.

Not even compile tested.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 4165079ba328d ("net: switch secpath to use skb extension infrastructure")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 Greg, David:

 The patch will not break build for a tree that lacks the 'Fixes'
 commit, so this can also go in via staging tree.
 OTOH, net-next build is broken for mips/octeon, so I think in
 this case net-next might make more sense?

diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index df3441b815bb..317c9720467c 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -359,8 +359,7 @@ int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 	dst_release(skb_dst(skb));
 	skb_dst_set(skb, NULL);
 #ifdef CONFIG_XFRM
-	secpath_put(skb->sp);
-	skb->sp = NULL;
+	secpath_reset(skb);
 #endif
 	nf_reset(skb);
 
-- 
2.19.2

