Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D6DC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F99214AE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789078;
	bh=MEYWtgx3xk8MXukF4jf1bvKXyRPrDZwFe3M51638ABg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GRvSes+buSirFHUWLs/mO/8yq1QkSMCBiuOR3Ax5t1yzbQq0w/WWQLXjwsxhhao8u
	 utudatuMggIAKqWSxV2O9oEDvom1wm3MfsmHO45264/VRwg+NSwClv4XKA6VAZ2ndp
	 HsFK+PFghr4kNgGnuwQqcglEgoMQ2AyIEXkLaLRc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F99214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbeLNMEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:04:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:49260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729989AbeLNMEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:04:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64F3D214AC;
        Fri, 14 Dec 2018 12:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789072;
        bh=MEYWtgx3xk8MXukF4jf1bvKXyRPrDZwFe3M51638ABg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZRwNNqLZq+rlp/km3G9NNRK3Cu4U30ht4J2LybjX4QvVILixB3rT9XrE04PVR1D+c
         2QsuPRZwEPHnio87PFd84nlk6PV2xel048sKLbkbFhJyXi6JV7xS9xpTVV4zwKgakw
         jM55N0k4fRQCky++NFJrdBvELgrQq7JKrnPHdkkg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Shuang <shuali@redhat.com>,
        Xin Long <lucien.xin@gmail.com>, Julian Anastasov <ja@ssi.bg>,
        Simon Horman <horms@verge.net.au>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 084/142] ipvs: call ip_vs_dst_notifier earlier than ipv6_dev_notf
Date:   Fri, 14 Dec 2018 12:59:29 +0100
Message-Id: <20181214115750.420939160@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

[ Upstream commit 2a31e4bd9ad255ee40809b5c798c4b1c2b09703b ]

ip_vs_dst_event is supposed to clean up all dst used in ipvs'
destinations when a net dev is going down. But it works only
when the dst's dev is the same as the dev from the event.

Now with the same priority but late registration,
ip_vs_dst_notifier is always called later than ipv6_dev_notf
where the dst's dev is set to lo for NETDEV_DOWN event.

As the dst's dev lo is not the same as the dev from the event
in ip_vs_dst_event, ip_vs_dst_notifier doesn't actually work.
Also as these dst have to wait for dest_trash_timer to clean
them up. It would cause some non-permanent kernel warnings:

  unregister_netdevice: waiting for br0 to become free. Usage count = 3

To fix it, call ip_vs_dst_notifier earlier than ipv6_dev_notf
by increasing its priority to ADDRCONF_NOTIFY_PRIORITY + 5.

Note that for ipv4 route fib_netdev_notifier doesn't set dst's
dev to lo in NETDEV_DOWN event, so this fix is only needed when
IP_VS_IPV6 is defined.

Fixes: 7a4f0761fce3 ("IPVS: init and cleanup restructuring")
Reported-by: Li Shuang <shuali@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Julian Anastasov <ja@ssi.bg>
Acked-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipvs/ip_vs_ctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 62eefea48973..518364f4abcc 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -3980,6 +3980,9 @@ static void __net_exit ip_vs_control_net_cleanup_sysctl(struct netns_ipvs *ipvs)
 
 static struct notifier_block ip_vs_dst_notifier = {
 	.notifier_call = ip_vs_dst_event,
+#ifdef CONFIG_IP_VS_IPV6
+	.priority = ADDRCONF_NOTIFY_PRIORITY + 5,
+#endif
 };
 
 int __net_init ip_vs_control_net_init(struct netns_ipvs *ipvs)
-- 
2.19.1



