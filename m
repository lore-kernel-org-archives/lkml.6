Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1EFC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8DA240BE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8DA240BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754338AbeGESvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:51:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39193 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753831AbeGESvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:51:22 -0400
Received: from 2.general.tyhicks.us.vpn ([10.172.64.53] helo=sec.l.tihix.com)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1fb9L4-0000Y5-C0; Thu, 05 Jul 2018 18:50:46 +0000
From:   Tyler Hicks <tyhicks@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Vasiliy Kulikov <segoon@openwall.com>, netdev@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ipv4: Return EINVAL when ping_group_range sysctl doesn't map to user ns
Date:   Thu,  5 Jul 2018 18:49:23 +0000
Message-Id: <1530816563-4478-1-git-send-email-tyhicks@canonical.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The low and high values of the net.ipv4.ping_group_range sysctl were
being silently forced to the default disabled state when a write to the
sysctl contained GIDs that didn't map to the associated user namespace.
Confusingly, the sysctl's write operation would return success and then
a subsequent read of the sysctl would indicate that the low and high
values are the overflowgid.

This patch changes the behavior by clearly returning an error when the
sysctl write operation receives a GID range that doesn't map to the
associated user namespace. In such a situation, the previous value of
the sysctl is preserved and that range will be returned in a subsequent
read of the sysctl.

Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---

This patch stems from triaging the following report from a LXD user:

  https://discuss.linuxcontainers.org/t/setting-net-ipv4-ping-group-range-inside-an-lxd-container/2162

 net/ipv4/sysctl_net_ipv4.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index af0a857d8352..5fa335fd3852 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -189,8 +189,9 @@ static int ipv4_ping_group_range(struct ctl_table *table, int write,
 	if (write && ret == 0) {
 		low = make_kgid(user_ns, urange[0]);
 		high = make_kgid(user_ns, urange[1]);
-		if (!gid_valid(low) || !gid_valid(high) ||
-		    (urange[1] < urange[0]) || gid_lt(high, low)) {
+		if (!gid_valid(low) || !gid_valid(high))
+			return -EINVAL;
+		if (urange[1] < urange[0] || gid_lt(high, low)) {
 			low = make_kgid(&init_user_ns, 1);
 			high = make_kgid(&init_user_ns, 0);
 		}
-- 
2.7.4

