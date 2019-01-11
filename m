Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FC0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E6520872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218577;
	bh=0df8mst4aDEg5lGfbYbCLfRQX863W0K7YAXJmT1tWYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gMd2TTAaeYlL/hcHYSiX7+V1k+U1o/xPTUu4tcgaQ/7N40j29aaD4VA/fuD9kmyQE
	 ZrajAweooLZw9zaNlZP2HJ4Jjcd2QxXH6EpfAjOdYDGgMAPZGi41PgPDgv6ZMi5Lxg
	 lluoDB0upmpyz/7gEx0KL0oy0/fjM52TGbgn1C/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390642AbfAKO4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:56:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390262AbfAKOgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:36:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 200CB2184B;
        Fri, 11 Jan 2019 14:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217359;
        bh=0df8mst4aDEg5lGfbYbCLfRQX863W0K7YAXJmT1tWYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rBsxSUhXzlhIGNBteebw0BLNipE7jA0XwJDFSv1YhFMiqDQq6hgol4dxrLkf1iuw+
         UmOKOkhMVWgWc+Q5jyC1a0By7R4X9Gq96+dzyIpxEMw/yeTKcZ1suQ1b9na9I0ehjM
         eIyTDuMQfCaiUKIlXSXkmFymPmOpnk0++zdEAiJI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 033/148] netfilter: ipset: do not call ipset_nest_end after nla_nest_cancel
Date:   Fri, 11 Jan 2019 15:13:31 +0100
Message-Id: <20190111131115.624367432@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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
index 4eef55da0878..8da228da53ae 100644
--- a/net/netfilter/ipset/ip_set_list_set.c
+++ b/net/netfilter/ipset/ip_set_list_set.c
@@ -531,8 +531,8 @@ list_set_list(const struct ip_set *set,
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



