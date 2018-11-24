Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32502C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 12:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6F920865
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 12:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6F920865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeKXXEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 18:04:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35272 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeKXXEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 18:04:14 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gQWql-0003Oi-Qr; Sat, 24 Nov 2018 12:15:51 +0000
From:   Colin King <colin.king@canonical.com>
To:     Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S . Miller" <davem@davemloft.net>,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: bridge: check for a null p->dev before dereferencing it
Date:   Sat, 24 Nov 2018 12:15:51 +0000
Message-Id: <20181124121551.6942-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A recent change added a null check on p->dev after p->dev was being
dereferenced by the ns_capable check on p->dev.  Fix this by performing
the p->dev sanity check before it is dereferenced.

Detected by CoverityScan, CID#751490 ("Dereference before null check")

Fixes: a5f3ea54f3cc ("net: bridge: add support for raw sysfs port options")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/bridge/br_sysfs_if.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 7c87a2fe5248..aab8aa17cccf 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -314,15 +314,15 @@ static ssize_t brport_store(struct kobject *kobj,
 	unsigned long val;
 	char *endp;
 
+	if (!p->dev || !p->br)
+		return -EINVAL;
+
 	if (!ns_capable(dev_net(p->dev)->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
 
 	if (!rtnl_trylock())
 		return restart_syscall();
 
-	if (!p->dev || !p->br)
-		goto out_unlock;
-
 	if (brport_attr->store_raw) {
 		char *buf_copy;
 
-- 
2.19.1

