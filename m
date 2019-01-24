Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B729C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B83217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359544;
	bh=sCev6suz9vcsmWH9sBB/GqDcf4WjFzWVWB/XydwTwC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o+3lzS4b8P3CB0zfgw5K4J2L/U2zNcELfj168xu0cMNrEgy9g6TzXU8oMef2Un3qr
	 moLBujVLTrcHo93sQ3s3VG2qLyVqgOd7MCbqDadbVyL12tYxX50xTmF1Uvg66lgS+E
	 vQNOcXp441SoSXjzaorD/UgdwRp9gYzdMJzgSxC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732970AbfAXTjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:39:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:39184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732441AbfAXTjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:39:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0075520663;
        Thu, 24 Jan 2019 19:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358740;
        bh=sCev6suz9vcsmWH9sBB/GqDcf4WjFzWVWB/XydwTwC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2FP7XJdm9WmcqXWT08y6Vye6et42YOAaqEmXZ/YB8tM487W38W2hwxQjkaWUxdhEQ
         P7JpsMp4TKMAYe+T28HRyvALHCt2KN4DIdU6CP7kEtPE/GNjQAGuRPGnF3NjPMT/+k
         LXvFTSJwNR7gHr5jpjW050bL9fuhRflioMCGzHog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Arthur Gautier <baloo@gandi.net>
Subject: [PATCH 4.20 010/127] netlink: fixup regression in RTM_GETADDR
Date:   Thu, 24 Jan 2019 20:19:16 +0100
Message-Id: <20190124190212.556578081@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arthur Gautier <baloo@gandi.net>

[ Upstream commit 7c1e8a3817c55d73b27cc29b84075999c8894179 ]

This commit fixes a regression in AF_INET/RTM_GETADDR and
AF_INET6/RTM_GETADDR.

Before this commit, the kernel would stop dumping addresses once the first
skb was full and end the stream with NLMSG_DONE(-EMSGSIZE). The error
shouldn't be sent back to netlink_dump so the callback is kept alive. The
userspace is expected to call back with a new empty skb.

Changes from V1:
 - The error is not handled in netlink_dump anymore but rather in
   inet_dump_ifaddr and inet6_dump_addr directly as suggested by
   David Ahern.

Fixes: d7e38611b81e ("net/ipv4: Put target net when address dump fails due to bad attributes")
Fixes: 242afaa6968c ("net/ipv6: Put target net when address dump fails due to bad attributes")

Cc: David Ahern <dsahern@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Arthur Gautier <baloo@gandi.net>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/devinet.c  |    2 +-
 net/ipv6/addrconf.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1826,7 +1826,7 @@ put_tgt_net:
 	if (fillargs.netnsid >= 0)
 		put_net(tgt_net);
 
-	return err < 0 ? err : skb->len;
+	return skb->len ? : err;
 }
 
 static void rtmsg_ifa(int event, struct in_ifaddr *ifa, struct nlmsghdr *nlh,
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5154,7 +5154,7 @@ put_tgt_net:
 	if (fillargs.netnsid >= 0)
 		put_net(tgt_net);
 
-	return err < 0 ? err : skb->len;
+	return skb->len ? : err;
 }
 
 static int inet6_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)


