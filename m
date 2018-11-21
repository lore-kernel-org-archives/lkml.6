Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA41C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745EB214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhKHQpEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745EB214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbeKVFmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:42:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730172AbeKVFmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:42:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 577A2214D9;
        Wed, 21 Nov 2018 19:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827202;
        bh=v8ACeI8bqYs+cqgcAzqGQI+vGd5wrdatGYKA9tw+Pfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhKHQpEP6TwM+hren4VqHuIe6A3OQNpw4mDXy8D9GR9TXRlofrUiD6hAHCrDEPyeg
         4MYQwKzl02rtbQITm6JyKj908tvDHFnIu5wpg4Kjk82j2an3L3zICqR7j+LJR9hYmP
         Vp+7tMDoRsaF7KANQJ+p/wStKrokusHPPsz6+X0c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Shuang <shuali@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 04/42] ipv6: fix a dst leak when removing its exception
Date:   Wed, 21 Nov 2018 20:05:40 +0100
Message-Id: <20181121183148.133221399@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 761f60261b4401aa368d71d431b4c218af0efcee ]

These is no need to hold dst before calling rt6_remove_exception_rt().
The call to dst_hold_safe() in ip6_link_failure() was for ip6_del_rt(),
which has been removed in Commit 93531c674315 ("net/ipv6: separate
handling of FIB entries from dst based routes"). Otherwise, it will
cause a dst leak.

This patch is to simply remove the dst_hold_safe() call before calling
rt6_remove_exception_rt() and also do the same in ip6_del_cached_rt().
It's safe, because the removal of the exception that holds its dst's
refcnt is protected by rt6_exception_lock.

Fixes: 93531c674315 ("net/ipv6: separate handling of FIB entries from dst based routes")
Fixes: 23fb93a4d3f1 ("net/ipv6: Cleanup exception and cache route handling")
Reported-by: Li Shuang <shuali@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2263,8 +2263,7 @@ static void ip6_link_failure(struct sk_b
 	if (rt) {
 		rcu_read_lock();
 		if (rt->rt6i_flags & RTF_CACHE) {
-			if (dst_hold_safe(&rt->dst))
-				rt6_remove_exception_rt(rt);
+			rt6_remove_exception_rt(rt);
 		} else {
 			struct fib6_info *from;
 			struct fib6_node *fn;
@@ -3266,8 +3265,8 @@ static int ip6_del_cached_rt(struct rt6_
 	if (cfg->fc_flags & RTF_GATEWAY &&
 	    !ipv6_addr_equal(&cfg->fc_gateway, &rt->rt6i_gateway))
 		goto out;
-	if (dst_hold_safe(&rt->dst))
-		rc = rt6_remove_exception_rt(rt);
+
+	rc = rt6_remove_exception_rt(rt);
 out:
 	return rc;
 }


