Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7ABECDE5F
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 02:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF3420854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 02:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPm7aeY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF3420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbeGVDqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 23:46:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39387 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbeGVDqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 23:46:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id g2-v6so9790320pgs.6;
        Sat, 21 Jul 2018 19:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IYRsjR4jKEDQTLi8nC7M3MOTAWaxuBv45O7U6CrOcOM=;
        b=iPm7aeY57AC9UWaRPG024O2AB3mLwuMRN9IW9PjfIUTzr9OXHNw8qZC0c4T+6Wbh/+
         50hR7dY78UTEhyGJAhBeW8l2MYO4MnBq0cLNUFgXi5/fgVDIPGTACjje1Pw60PHCcwBu
         Y/ZiShdrE6y8lR1urxZCEqsJARvpwWKTDjiLcsoJFIQJk3RQUKKhwdRpKsq2gy73Bzep
         +TdrN7pQkD0mn4k9XBsQUNjmJBDhT1aSPFmQXSHZpJQdCKHPRm3Aa5ajbAkZeXcub/M/
         xx9YjXNeGhLoGqIJotv65PXWboYwsPBaUilZcet6S1xpx0zK5zXsw/lmXJAzLAXwCyRV
         HinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IYRsjR4jKEDQTLi8nC7M3MOTAWaxuBv45O7U6CrOcOM=;
        b=LVS0DAShL/nT+ea+RJl/d1xyHwSFFxq5qtjuqAsIUhOhymXTJxkp6xR8qLa3p2Foq1
         wruIzZ82BpCt6OfT6+tWJjdHvXkWhIIX/Bu8O5wPQxijeNP06wKNJNcevqSeAGVgB444
         h4jpaJWO4r5tYtc6jncKBM4UEeunO42aprMSE/a94varu5KiI68ckreqM96iPPXkOKlG
         FnfbPPOc8wdtIbpc55mHmvBP7oHgMFA1VjAYE/kWplGiEU08eiKEbwubNoGy3KvWnV8i
         PuM481NhmR4E0nsFtj3CIHrKtXm4qXpUn7T+mxK3bAWGItuuMpzyELx+UiJfLiRqbKIF
         ztVA==
X-Gm-Message-State: AOUpUlGVa5RKPqmQbzFXYw0s4Yzj+8oeoGKTUo/ku8FUUy75JYLslV0M
        N7ARb1j9BeK3YgNDUUL1ge4=
X-Google-Smtp-Source: AAOMgpe58+7/fJiugiIxKRnzjWtAzoI+2EfkFzaFn8WiyVViH4DHByJBofVa/5kWzNao6GeOTAmmpQ==
X-Received: by 2002:a63:4c56:: with SMTP id m22-v6mr7218514pgl.299.1532227862632;
        Sat, 21 Jul 2018 19:51:02 -0700 (PDT)
Received: from localhost.localdomain ([180.172.91.97])
        by smtp.gmail.com with ESMTPSA id 77-v6sm7429200pga.40.2018.07.21.19.50.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 19:51:02 -0700 (PDT)
From:   Shaochun Chen <cscnull@gmail.com>
To:     pablo@netfilter.org
Cc:     kadlec@blackhole.kfki.hu, fw@strlen.de, davem@davemloft.net,
        johannes.berg@intel.com, pombredanne@nexb.com,
        kstewart@linuxfoundation.org, cscnull@gmail.com,
        gregkh@linuxfoundation.org, Jason@zx2c4.com, dsahern@gmail.com,
        lucien.xin@gmail.com, ktkhai@virtuozzo.com,
        xiyou.wangcong@gmail.com, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH] netlink: fix memory leak
Date:   Sun, 22 Jul 2018 10:49:25 +0800
Message-Id: <20180722024925.3176-1-cscnull@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when netlink_dump start failed, netlink_callback will not be called,
and the memory which pointed by control->data will leak. so if netlink_dump
start fail, call control->done to free the memory.

Signed-off-by: Shaochun Chen <cscnull@gmail.com>
---
 include/linux/netlink.h       | 10 ++++++++++
 net/netfilter/nf_tables_api.c |  4 +++-
 net/netlink/af_netlink.c      |  4 ++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index f3075d6c7e82..9d6b3edc5a5b 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -214,6 +214,16 @@ static inline int netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 	return __netlink_dump_start(ssk, skb, nlh, control);
 }
 
+static inline void netlink_dump_start_fail(struct netlink_dump_control *control)
+{
+	struct netlink_callback cb = {
+		.data = control->data,
+	};
+
+	if (control->done)
+		control->done(&cb);
+}
+
 struct netlink_tap {
 	struct net_device *dev;
 	struct module *module;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 896d4a36081d..dc30a329f785 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -588,8 +588,10 @@ static int nft_netlink_dump_start_rcu(struct sock *nlsk, struct sk_buff *skb,
 {
 	int err;
 
-	if (!try_module_get(THIS_MODULE))
+	if (!try_module_get(THIS_MODULE)) {
+		netlink_dump_start_fail(c);
 		return -EINVAL;
+	}
 
 	rcu_read_unlock();
 	err = netlink_dump_start(nlsk, skb, nlh, c);
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 393573a99a5a..7b85176cf9bb 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2275,6 +2275,7 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 	struct netlink_callback *cb;
 	struct sock *sk;
 	struct netlink_sock *nlk;
+	bool cb_running = false;
 	int ret;
 
 	refcount_inc(&skb->users);
@@ -2317,6 +2318,7 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 
 	nlk->cb_running = true;
 	nlk->dump_done_errno = INT_MAX;
+	cb_running = true;
 
 	mutex_unlock(nlk->cb_mutex);
 
@@ -2339,6 +2341,8 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 	mutex_unlock(nlk->cb_mutex);
 error_free:
 	kfree_skb(skb);
+	if (cb_running)
+		netlink_dump_start_fail(control);
 	return ret;
 }
 EXPORT_SYMBOL(__netlink_dump_start);
-- 
2.17.1

