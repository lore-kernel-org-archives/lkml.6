Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5810C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 03:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA8A2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 03:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="FSWrgCyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA8A2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbeJYM1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 08:27:49 -0400
Received: from mx.aristanetworks.com ([162.210.129.12]:25236 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726465AbeJYM1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 08:27:49 -0400
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Oct 2018 08:27:48 EDT
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 6829B5D36;
        Wed, 24 Oct 2018 20:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1540439343;
        bh=04R3P1Aq6Gl2ea80/fIVyBQKUWuHwCQcNKrRYpZe5CE=;
        h=From:To:Cc:Subject:Date;
        b=FSWrgCyS/kl7kBJI1IMk71fXtkH6RFu2f32UXl5zAb8BBttqP/Wmb77/a0tLZ3a53
         ByV38dpXFDZXK84D9j8sAr/iP2xKbYXycHIZdo31VEh70a+UNpQ51qrayOOhUu5+sT
         fMR8ie77RB3uO6MzXVWr4XblaYTIb9aaNLVtGXsMuO1dodhOcxGlVgHTkcYsg50kKP
         Z6yUVHVoiQtPli5m1Viu1DgaMeoMMdFW/15Lv1zZfjWEqw0qIrii4DsmnweHn9UVZ0
         TIZaqk1N2InxpE578t/eRcXnHlWHxGpSVz6BKzDI+oVCpQ7Ld0oGjxa4QwfGS7kAje
         mRQsTH7rHVIWQ==
Received: from vasilykh-thinkpad-x1.aristanetworks.com (unknown [10.95.91.89])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 0BDE15418;
        Wed, 24 Oct 2018 20:49:03 -0700 (PDT)
From:   Vasily Khoruzhick <vasilykh@arista.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>
Cc:     Vasily Khoruzhick <vasilykh@arista.com>, stable@vger.kernel.org
Subject: [PATCH] netfilter: conntrack: fix calculation of next bucket number in early_drop
Date:   Wed, 24 Oct 2018 20:48:53 -0700
Message-Id: <20181025034853.23573-1-vasilykh@arista.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there's no entry to drop in bucket that corresponds to the hash,
early_drop() should look for it in other buckets. But since it increments
hash instead of bucket number, it actually looks in the same bucket 8
times: hsize is 16k by default (14 bits) and hash is 32-bit value, so
reciprocal_scale(hash, hsize) returns the same value for hash..hash+7 in
most cases.

Fix it by increasing bucket number instead of hash and rename _hash
to bucket to avoid future confusion.

Fixes: 3e86638e9a0b ("netfilter: conntrack: consider ct netns in early_drop logic")
Cc: <stable@vger.kernel.org> # v4.7+
Signed-off-by: Vasily Khoruzhick <vasilykh@arista.com>
---
 net/netfilter/nf_conntrack_core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index ca1168d67fac..a04af246b184 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -1073,19 +1073,22 @@ static unsigned int early_drop_list(struct net *net,
 	return drops;
 }
 
-static noinline int early_drop(struct net *net, unsigned int _hash)
+static noinline int early_drop(struct net *net, unsigned int hash)
 {
 	unsigned int i;
 
 	for (i = 0; i < NF_CT_EVICTION_RANGE; i++) {
 		struct hlist_nulls_head *ct_hash;
-		unsigned int hash, hsize, drops;
+		unsigned int bucket, hsize, drops;
 
 		rcu_read_lock();
 		nf_conntrack_get_ht(&ct_hash, &hsize);
-		hash = reciprocal_scale(_hash++, hsize);
+		if (!i)
+			bucket = reciprocal_scale(hash, hsize);
+		else
+			bucket = (bucket + 1) % hsize;
 
-		drops = early_drop_list(net, &ct_hash[hash]);
+		drops = early_drop_list(net, &ct_hash[bucket]);
 		rcu_read_unlock();
 
 		if (drops) {
-- 
2.19.1

