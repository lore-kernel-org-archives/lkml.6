Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF02DC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B1220854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B1220854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbeIMTBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:01:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33290 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbeIMTA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:00:59 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 44D2DD1A;
        Thu, 13 Sep 2018 13:51:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Kodanev <alexey.kodanev@oracle.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 023/197] ipv6: dont get lwtstate twice in ip6_rt_copy_init()
Date:   Thu, 13 Sep 2018 15:29:32 +0200
Message-Id: <20180913131842.489266193@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
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

From: Alexey Kodanev <alexey.kodanev@oracle.com>

[ Upstream commit 93bbadd6e0a2a58e49d265b9b1aa58e621b60a26 ]

Commit 80f1a0f4e0cd ("net/ipv6: Put lwtstate when destroying fib6_info")
partially fixed the kmemleak [1], lwtstate can be copied from fib6_info,
with ip6_rt_copy_init(), and it should be done only once there.

rt->dst.lwtstate is set by ip6_rt_init_dst(), at the start of the function
ip6_rt_copy_init(), so there is no need to get it again at the end.

With this patch, lwtstate also isn't copied from RTF_REJECT routes.

[1]:
unreferenced object 0xffff880b6aaa14e0 (size 64):
  comm "ip", pid 10577, jiffies 4295149341 (age 1273.903s)
  hex dump (first 32 bytes):
    01 00 04 00 04 00 00 00 10 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000018664623>] lwtunnel_build_state+0x1bc/0x420
    [<00000000b73aa29a>] ip6_route_info_create+0x9f7/0x1fd0
    [<00000000ee2c5d1f>] ip6_route_add+0x14/0x70
    [<000000008537b55c>] inet6_rtm_newroute+0xd9/0xe0
    [<000000002acc50f5>] rtnetlink_rcv_msg+0x66f/0x8e0
    [<000000008d9cd381>] netlink_rcv_skb+0x268/0x3b0
    [<000000004c893c76>] netlink_unicast+0x417/0x5a0
    [<00000000f2ab1afb>] netlink_sendmsg+0x70b/0xc30
    [<00000000890ff0aa>] sock_sendmsg+0xb1/0xf0
    [<00000000a2e7b66f>] ___sys_sendmsg+0x659/0x950
    [<000000001e7426c8>] __sys_sendmsg+0xde/0x170
    [<00000000fe411443>] do_syscall_64+0x9f/0x4a0
    [<000000001be7b28b>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
    [<000000006d21f353>] 0xffffffffffffffff

Fixes: 6edb3c96a5f0 ("net/ipv6: Defer initialization of dst to data path")
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    1 -
 1 file changed, 1 deletion(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -996,7 +996,6 @@ static void ip6_rt_copy_init(struct rt6_
 	rt->rt6i_src = ort->fib6_src;
 #endif
 	rt->rt6i_prefsrc = ort->fib6_prefsrc;
-	rt->dst.lwtstate = lwtstate_get(ort->fib6_nh.nh_lwtstate);
 }
 
 static struct fib6_node* fib6_backtrack(struct fib6_node *fn,


