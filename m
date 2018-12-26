Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ACFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79124214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864306;
	bh=QGteJWSrHL1z6/QPlHywpe09nL7K0eij3pQPEi7E7BQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PvkjlzGayW8pT++gdw06Ei9Yy2/nEnf7PhNUEW+UMUmRgU6yF9gQSxrhuuh2igRkS
	 aFjVXsF3cNnu+QPYWVObmvKGax4KNC94lDINw6IKiwaxzbyjrTKXf+A50aQkDLLs41
	 cZF1db09Ok1DoHngjkg24ZeDtv7RiCMu8gEkjV1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbeLZWki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:40:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbeLZWkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:40:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 666C82054F;
        Wed, 26 Dec 2018 22:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864032;
        bh=QGteJWSrHL1z6/QPlHywpe09nL7K0eij3pQPEi7E7BQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wWoOVu4SEUwXDPDQg5wI6XER23m2A2W0ysFS20jG8nsAeKkmg7ge0mh7Lnut3DQ+o
         gBgP3o0vnceEV0OVV9eDbjef69Nw+YV3szeTieLrwMlO2EjWn/QuHIgpAh7BUFlQlP
         5igcQDthr14QCkFFM0gi4r4af0oBGcuywrZaKs9Y=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pan Bian <bianpan2016@163.com>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 22/59] netfilter: ipset: do not call ipset_nest_end after nla_nest_cancel
Date:   Wed, 26 Dec 2018 17:38:02 -0500
Message-Id: <20181226223839.150262-22-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 708abf74dd87f8640871b814faa195fb5970b0e3 ]

In the error handling block, nla_nest_cancel(skb, atd) is called to
cancel the nest operation. But then, ipset_nest_end(skb, atd) is
unexpected called to end the nest operation. This patch calls the
ipset_nest_end only on the branch that nla_nest_cancel is not called.

Fixes: 45040978c899 ("netfilter: ipset: Fix set:list type crash when flush/dump set in parallel")
Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipset/ip_set_list_set.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/ipset/ip_set_list_set.c b/net/netfilter/ipset/ip_set_list_set.c
index 75d52aed6fdb..e563921e6af5 100644
--- a/net/netfilter/ipset/ip_set_list_set.c
+++ b/net/netfilter/ipset/ip_set_list_set.c
@@ -542,8 +542,8 @@ list_set_list(const struct ip_set *set,
 		ret = -EMSGSIZE;
 	} else {
 		cb->args[IPSET_CB_ARG0] = i;
+		ipset_nest_end(skb, atd);
 	}
-	ipset_nest_end(skb, atd);
 out:
 	rcu_read_unlock();
 	return ret;
-- 
2.19.1

