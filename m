Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790E3C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443F520672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443F520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbeLJTDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:03:37 -0500
Received: from gateway23.websitewelcome.com ([192.185.49.184]:28498 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbeLJTDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:03:36 -0500
X-Greylist: delayed 1325 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Dec 2018 14:03:36 EST
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id C6EBEEB2F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 12:41:30 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id WQUkgRsvvkBj6WQUkgLv27; Mon, 10 Dec 2018 12:41:30 -0600
X-Authority-Reason: nr=8
Received: from [189.250.70.203] (port=36268 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gWQUj-001EIf-23; Mon, 10 Dec 2018 12:41:30 -0600
Date:   Mon, 10 Dec 2018 12:41:24 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ipv4: Fix potential Spectre v1 vulnerability
Message-ID: <20181210184124.GA24497@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.70.203
X-Source-L: No
X-Exim-ID: 1gWQUj-001EIf-23
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.70.203]:36268
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vr.vifi is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

net/ipv4/ipmr.c:1616 ipmr_ioctl() warn: potential spectre issue 'mrt->vif_table' [r] (local cap)
net/ipv4/ipmr.c:1690 ipmr_compat_ioctl() warn: potential spectre issue 'mrt->vif_table' [r] (local cap)

Fix this by sanitizing vr.vifi before using it to index mrt->vif_table'

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/ipv4/ipmr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index ea04e38f56e9..8c03fb05d3e6 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -69,6 +69,8 @@
 #include <net/nexthop.h>
 #include <net/switchdev.h>
 
+#include <linux/nospec.h>
+
 struct ipmr_rule {
 	struct fib_rule		common;
 };
@@ -1612,6 +1614,7 @@ int ipmr_ioctl(struct sock *sk, int cmd, void __user *arg)
 			return -EFAULT;
 		if (vr.vifi >= mrt->maxvif)
 			return -EINVAL;
+		vr.vifi = array_index_nospec(vr.vifi, mrt->maxvif);
 		read_lock(&mrt_lock);
 		vif = &mrt->vif_table[vr.vifi];
 		if (VIF_EXISTS(mrt, vr.vifi)) {
@@ -1686,6 +1689,7 @@ int ipmr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 			return -EFAULT;
 		if (vr.vifi >= mrt->maxvif)
 			return -EINVAL;
+		vr.vifi = array_index_nospec(vr.vifi, mrt->maxvif);
 		read_lock(&mrt_lock);
 		vif = &mrt->vif_table[vr.vifi];
 		if (VIF_EXISTS(mrt, vr.vifi)) {
-- 
2.17.1

