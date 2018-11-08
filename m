Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F00C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5AF206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgvzkbQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5AF206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbeKIIAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:00:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728654AbeKIHnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:03 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 713AF2146E;
        Thu,  8 Nov 2018 22:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714733;
        bh=vtJcwblbaqe+etY5HSVN7ECvwrlqO8mUJ6Oqgy8zG0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SgvzkbQtkhwUdAFrdVkhp12LTVp+9MCYp5rIV15zXKeohu/MaStL3Kw45g3htq/kP
         HOTMdciDamBzvYSksYBwlz4i9SBPdrSw+NyceBCL2oKbQJaa4woJxtSBWXq6K+FtPt
         /3l6aiRjlVo3tBCVQDdx/uqjg3eHxXtlBUMvcGMQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 093/171] ipv6: fix cleanup ordering for ip6_mr failure
Date:   Thu,  8 Nov 2018 13:51:03 -0800
Message-Id: <20181108215134.185170918@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
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
@@ -1045,11 +1045,11 @@ netfilter_fail:
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



