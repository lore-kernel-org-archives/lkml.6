Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B69AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CF220700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760380;
	bh=lLxcMYEpPHePmy4oQqhqiZWVKcQ4ext0BVRPs+2AiSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lZEBdKTaT4v0VKwYHtYx8zr+cOV9h5cRoGpzMX+KDXeIOstoojznYSoBmkf93icCL
	 V2x/coC/qTdWOLXhTOIJDLKKi8KKz6TzrE+gfmKOJYry8nHh7ga8/48t8Szvsdbuux
	 7vpZFCjwTIojc1rORQ9sVToSHXTDKez4H2Xpnplk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbfBUOmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:42:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729469AbfBUOmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:42:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B36F2084F;
        Thu, 21 Feb 2019 14:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760127;
        bh=lLxcMYEpPHePmy4oQqhqiZWVKcQ4ext0BVRPs+2AiSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AX4UUdvw9N49G+alo7tnNIwIRV1al65b2hDsuIJErkmvzkJ54B7qoGYBwRQ3WvJI3
         2xUI+YPw3Qd049/Zq9Qv/M1Dd3pIC2wBjQqkSquAuvP6NRyiWD8Irz5NYfYg6IKYfi
         HFEhdYIHm3bSmFiafCzaE6H5XSaWgW88b/ObIXY0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Wenhao Zhang <zhangwenhao8@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 06/30] net: fix IPv6 prefix route residue
Date:   Thu, 21 Feb 2019 15:35:48 +0100
Message-Id: <20190221125250.883088941@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.543158526@linuxfoundation.org>
References: <20190221125250.543158526@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e75913c93f7cd5f338ab373c34c93a655bd309cb ]

Follow those steps:
 # ip addr add 2001:123::1/32 dev eth0
 # ip addr add 2001:123:456::2/64 dev eth0
 # ip addr del 2001:123::1/32 dev eth0
 # ip addr del 2001:123:456::2/64 dev eth0
and then prefix route of 2001:123::1/32 will still exist.

This is because ipv6_prefix_equal in check_cleanup_prefix_route
func does not check whether two IPv6 addresses have the same
prefix length. If the prefix of one address starts with another
shorter address prefix, even though their prefix lengths are
different, the return value of ipv6_prefix_equal is true.

Here I add a check of whether two addresses have the same prefix
to decide whether their prefixes are equal.

Fixes: 5b84efecb7d9 ("ipv6 addrconf: don't cleanup prefix route for IFA_F_NOPREFIXROUTE")
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Reported-by: Wenhao Zhang <zhangwenhao8@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/addrconf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 3dfc50cd86d68..c57efd5c5b387 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1148,7 +1148,8 @@ check_cleanup_prefix_route(struct inet6_ifaddr *ifp, unsigned long *expires)
 	list_for_each_entry(ifa, &idev->addr_list, if_list) {
 		if (ifa == ifp)
 			continue;
-		if (!ipv6_prefix_equal(&ifa->addr, &ifp->addr,
+		if (ifa->prefix_len != ifp->prefix_len ||
+		    !ipv6_prefix_equal(&ifa->addr, &ifp->addr,
 				       ifp->prefix_len))
 			continue;
 		if (ifa->flags & (IFA_F_PERMANENT | IFA_F_NOPREFIXROUTE))
-- 
2.19.1



