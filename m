Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98780C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5722C22528
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzxc1zLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5722C22528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388190AbeKOI3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:29:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:36110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbeKOI3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:29:16 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 476C622526;
        Wed, 14 Nov 2018 22:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234252;
        bh=+o49EspfuXdTJ+FcF11g8aK9UzURLz+7wHniHPfaM/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lzxc1zLPrtu8H54I5lA+sjqUx5E8syy027SoeDYQUI539pVfXQddZUlCO3BsRoa7V
         7alTEKBII7AWLM0IvYXRiqu+888REoV+uN5PVQwqUjAcYrwRfTqDQU0j67JMGRuujA
         DwfBElIiG+6xZZ2DD7g++EZQPAO9tcuRgL7LssEE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: [PATCH AUTOSEL 4.18 15/59] netfilter: ipset: Correct rcu_dereference() call in ip_set_put_comment()
Date:   Wed, 14 Nov 2018 17:22:47 -0500
Message-Id: <20181114222335.99339-15-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222335.99339-1-sashal@kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>

[ Upstream commit 17b8b74c0f8dbf9b9e3301f9ca5b65dd1c079951 ]

The function is called when rcu_read_lock() is held and not
when rcu_read_lock_bh() is held.

Signed-off-by: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netfilter/ipset/ip_set_comment.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/netfilter/ipset/ip_set_comment.h b/include/linux/netfilter/ipset/ip_set_comment.h
index 8e2bab1e8e90..70877f8de7e9 100644
--- a/include/linux/netfilter/ipset/ip_set_comment.h
+++ b/include/linux/netfilter/ipset/ip_set_comment.h
@@ -43,11 +43,11 @@ ip_set_init_comment(struct ip_set *set, struct ip_set_comment *comment,
 	rcu_assign_pointer(comment->c, c);
 }
 
-/* Used only when dumping a set, protected by rcu_read_lock_bh() */
+/* Used only when dumping a set, protected by rcu_read_lock() */
 static inline int
 ip_set_put_comment(struct sk_buff *skb, const struct ip_set_comment *comment)
 {
-	struct ip_set_comment_rcu *c = rcu_dereference_bh(comment->c);
+	struct ip_set_comment_rcu *c = rcu_dereference(comment->c);
 
 	if (!c)
 		return 0;
-- 
2.17.1

