Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7424C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7596D207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="wngdutup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7596D207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeJZEA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:00:28 -0400
Received: from smtp.aristanetworks.com ([52.0.43.43]:34342 "EHLO
        usvae2-clmxp01.aristanetworks.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725725AbeJZEA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:00:28 -0400
X-Greylist: delayed 615 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Oct 2018 00:00:27 EDT
Received: from usvae2-clmxp01.aristanetworks.com (localhost [127.0.0.1])
        by usvae2-clmxp01.aristanetworks.com (Postfix) with ESMTP id 0433930A135F;
        Thu, 25 Oct 2018 12:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1540494970;
        bh=yPDNJSXAYgPD/xU3Ryxmt57scouPVAKI6EyRuwRZ4RQ=;
        h=From:To:Cc:Subject:Date;
        b=wngdutuph9iRn05Igx0rmBh20xeUpkAN22CVN6jnj7XKK/c689SZA42uv0+R5o1sh
         icS6tIHLu9M/E5iOlOHBRKrLiVm3yHv8Voyh2RwK339Md62iVsZGTC88whM0Ub+Mej
         F8eUoQWpT5ErRVZH+jTe2gE/KqHUU+p4XYLwUqg/FI6yRYrBk1jDP0zNCIa5lSsyFO
         lrShjn3CcnK8PYj5oEG9chmZb96hcnpCOLq+uxrNsiTCtt7adHQ2Sm6qcQww1GyesT
         fcldwY9tL05WVRdV8ZCsZkIVaBQ/2VRMUDJ0dj2pz54/kzZQk6QxWXMr1hTXQUnbJA
         G7o5HHaEZVbzA==
Received: from vasilykh-thinkpad-x1.sjc.aristanetworks.com (unknown [10.80.8.45])
        by usvae2-clmxp01.aristanetworks.com (Postfix) with ESMTP id 3D06530A135A;
        Thu, 25 Oct 2018 12:16:08 -0700 (PDT)
From:   Vasily Khoruzhick <vasilykh@arista.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>
Cc:     Vasily Khoruzhick <vasilykh@arista.com>, stable@vger.kernel.org
Subject: [PATCH v2] netfilter: conntrack: fix calculation of next bucket number in early_drop
Date:   Thu, 25 Oct 2018 12:15:43 -0700
Message-Id: <20181025191543.15061-1-vasilykh@arista.com>
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
v2: move 'bucket' outside of the loop

 net/netfilter/nf_conntrack_core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index ca1168d67fac..e92e749aff53 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -1073,19 +1073,22 @@ static unsigned int early_drop_list(struct net *net,
 	return drops;
 }
 
-static noinline int early_drop(struct net *net, unsigned int _hash)
+static noinline int early_drop(struct net *net, unsigned int hash)
 {
-	unsigned int i;
+	unsigned int i, bucket;
 
 	for (i = 0; i < NF_CT_EVICTION_RANGE; i++) {
 		struct hlist_nulls_head *ct_hash;
-		unsigned int hash, hsize, drops;
+		unsigned int hsize, drops;
 
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

