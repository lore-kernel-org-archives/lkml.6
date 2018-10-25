Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CF5ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A972086D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiYML2bu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A972086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbeJYWs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbeJYWsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:55 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F5FB2086D;
        Thu, 25 Oct 2018 14:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476958;
        bh=W1qnUrLTwmzQkmX2FdGZ2pBJbNn8wkLInXajz+xyM2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WiYML2bumWcAdEv2Mxdq5exfcvCLH+Fgjmu8+1Heqjl9JUEvRAFFz0oqRPN7oO31S
         8wUorLaB40o1dCkOfLiUm4iwf6Q+9drx+MR6XLPL7J4pDcsIulmAUfbfD+qohgmcrr
         9TSqrghxT5MdRnTbOadCmrKWGJy/YrenV1CYr+ds=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sabrina Dubroca <sd@queasysnail.net>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 64/98] ipv6: fix cleanup ordering for ip6_mr failure
Date:   Thu, 25 Oct 2018 10:13:49 -0400
Message-Id: <20181025141423.213774-64-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit afe49de44c27a89e8e9631c44b5ffadf6ace65e2 ]

Commit 15e668070a64 ("ipv6: reorder icmpv6_init() and ip6_mr_init()")
moved the cleanup label for ipmr_fail, but should have changed the
contents of the cleanup labels as well. Now we can end up cleaning up
icmpv6 even though it hasn't been initialized (jump to icmp_fail or
ipmr_fail).

Simply undo things in the reverse order of their initialization.

Example of panic (triggered by faking a failure of icmpv6_init):

    kasan: GPF could be caused by NULL-ptr deref or user memory access
    general protection fault: 0000 [#1] PREEMPT SMP KASAN PTI
    [...]
    RIP: 0010:__list_del_entry_valid+0x79/0x160
    [...]
    Call Trace:
     ? lock_release+0x8a0/0x8a0
     unregister_pernet_operations+0xd4/0x560
     ? ops_free_list+0x480/0x480
     ? down_write+0x91/0x130
     ? unregister_pernet_subsys+0x15/0x30
     ? down_read+0x1b0/0x1b0
     ? up_read+0x110/0x110
     ? kmem_cache_create_usercopy+0x1b4/0x240
     unregister_pernet_subsys+0x1d/0x30
     icmpv6_cleanup+0x1d/0x30
     inet6_init+0x1b5/0x23f

Fixes: 15e668070a64 ("ipv6: reorder icmpv6_init() and ip6_mr_init()")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/af_inet6.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 421379014995..f7b425615c12 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -1045,11 +1045,11 @@ static int __init inet6_init(void)
 igmp_fail:
 	ndisc_cleanup();
 ndisc_fail:
-	ip6_mr_cleanup();
+	icmpv6_cleanup();
 icmp_fail:
-	unregister_pernet_subsys(&inet6_net_ops);
+	ip6_mr_cleanup();
 ipmr_fail:
-	icmpv6_cleanup();
+	unregister_pernet_subsys(&inet6_net_ops);
 register_pernet_fail:
 	sock_unregister(PF_INET6);
 	rtnl_unregister_all(PF_INET6);
-- 
2.17.1

