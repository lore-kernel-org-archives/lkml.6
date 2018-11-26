Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EBCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7D42089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TWPEmLFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7D42089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbeKZVge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:36:34 -0500
Received: from m12-11.163.com ([220.181.12.11]:59725 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbeKZVgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=eFhC6ly3YeGr5f1y+9
        JdQzvSGr7kMTcjQbQn5uq7z00=; b=TWPEmLFhQvVf6oEdODi0Mwa1/c/UAqjFVd
        ZO1hmt/0viTycDV8oH8Dga8cuXBqsOCC1DAj/Syh8EnrvWLX8UbqooVLgDx/w6pW
        p8P5MjAnhceEJMtjCUtUmUM3INfyRpFmgzOybEwdE7+DgkDBX56oFVVdWyvvdxby
        GoxfJ8nJY=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp7 (Coremail) with SMTP id C8CowAB3MpEDzvtbwzoECA--.47616S3;
        Mon, 26 Nov 2018 18:42:13 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Stefano Brivio <sbrivio@redhat.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] netfilter: ipset: do not call ipset_nest_end after nla_nest_cancel
Date:   Mon, 26 Nov 2018 18:42:10 +0800
Message-Id: <1543228930-103509-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: C8CowAB3MpEDzvtbwzoECA--.47616S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZryxuw4xCFW3ur4rZFW8Zwb_yoWDXFb_Ja
        4kta40kF1rKFZaga1UAayxZr4xtw1fJFyxJFyIq39Fvwn8G34qka4vqFsxZr15G3y2kry7
        KrnYgry5t3yYvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUneMKJUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiDgULclXlpmxgBQAAst
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the error handling block, nla_nest_cancel(skb, atd) is called to
cancel the nest operation. But then, ipset_nest_end(skb, atd) is
unexpected called to end the nest operation. This patch calls the
ipset_nest_end only on the branch that nla_nest_cancel is
not called.

Fixes: 45040978c89("netfilter: ipset: Fix set:list type crash when
flush/dump set in parallel")

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 net/netfilter/ipset/ip_set_list_set.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/ipset/ip_set_list_set.c b/net/netfilter/ipset/ip_set_list_set.c
index 4eef55d..8da228d 100644
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
2.7.4


