Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A25C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDC7217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866277;
	bh=ilF82cGwSKdFGuAppMt94XoZhOBEVrzPQPGsYBIJe2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xn2W6khU/dC3+FLNrqHyMTTZ5NEBVFG5NrDEo1PSLWub04sgjCo+rgtEJOG0ISQY7
	 +3FsvUrbZBl2jKVYBWF4UMbfuYIBJyOPlgYIvgJICUlcE1Hfc4hsxX3DxuGNMEhGDy
	 QXnksfQfwd72AGWgH+K2CCxNm0gTk+G9OtMLDomM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbfAGNEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:04:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:52166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731198AbfAGNEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:04:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B831821736;
        Mon,  7 Jan 2019 13:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866271;
        bh=ilF82cGwSKdFGuAppMt94XoZhOBEVrzPQPGsYBIJe2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nMyd2+op38aOO1Ub4I1b1VjQPUEXGJpliPhRk2e45Er9bqyUbd2mmaPNWAj+/qoNn
         A/5yPop948Pba2nmQJ96ecQTmegf8pCJN3pd5JqZMdFsx1qlD0FpuTwW9T8wiwdMlC
         RGupM9QH0HxQ+KCNGvbCI5lCMKXp6TSRPyjuljkU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shawn Bohrer <sbohrer@cloudflare.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Mauricio Faria de Oliveira <mfo@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 084/101] netfilter: nf_conncount: dont skip eviction when age is negative
Date:   Mon,  7 Jan 2019 13:33:12 +0100
Message-Id: <20190107105337.538883836@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 4cd273bb91b3001f623f516ec726c49754571b1a upstream.

(not in Linus's tree now, but in nf.git + linux-next.git already.)

age is signed integer, so result can be negative when the timestamps
have a large delta.  In this case we want to discard the entry.

Instead of using age >= 2 || age < 0, just make it unsigned.

Fixes: b36e4523d4d56 ("netfilter: nf_conncount: fix garbage collection confirm race")
Reviewed-by: Shawn Bohrer <sbohrer@cloudflare.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

[mfo: backport: use older file name, nf_conncount.c -> xt_connlimit.c]
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/xt_connlimit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/xt_connlimit.c b/net/netfilter/xt_connlimit.c
index 913b86ef3a8d..b1646c24a632 100644
--- a/net/netfilter/xt_connlimit.c
+++ b/net/netfilter/xt_connlimit.c
@@ -141,7 +141,7 @@ find_or_evict(struct net *net, struct xt_connlimit_conn *conn)
 	const struct nf_conntrack_tuple_hash *found;
 	unsigned long a, b;
 	int cpu = raw_smp_processor_id();
-	__s32 age;
+	u32 age;
 
 	found = nf_conntrack_find_get(net, &conn->zone, &conn->tuple);
 	if (found)
-- 
2.19.1



