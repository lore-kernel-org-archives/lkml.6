Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8C9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D35B21479
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1OF7CXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D35B21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbeKTDAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:00:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730366AbeKTDAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:00:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15732214C1;
        Mon, 19 Nov 2018 16:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645356;
        bh=nP7/IFVyodYvE7h1GWvYYa7oJLlTcqeIotZYD4KYW3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L1OF7CXp4+/JowghTC6242d5fadiSQALReYuv8sHft+nENeY6YwHfnB9ORUNbdeCN
         J3pYVFvib8uPq8bMveFpxiLBNfbbenPvHFpMPG/Hlgt1NW6traWg6bkYmQ2eF2Rho1
         BD67TnsvE9LB0I0RWoB6x//As7et50bb9vuv/LO0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Khoruzhick <vasilykh@arista.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 105/205] netfilter: conntrack: fix calculation of next bucket number in early_drop
Date:   Mon, 19 Nov 2018 17:26:52 +0100
Message-Id: <20181119162633.855865262@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Khoruzhick <vasilykh@arista.com>

commit f393808dc64149ccd0e5a8427505ba2974a59854 upstream.

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
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_conntrack_core.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -1073,19 +1073,22 @@ static unsigned int early_drop_list(stru
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


