Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E50BC43444
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DE8218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlJ42Wmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbeL2B4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 20:56:04 -0500
Received: from mail-vs1-f73.google.com ([209.85.217.73]:41341 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbeL2B4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 20:56:03 -0500
Received: by mail-vs1-f73.google.com with SMTP id h136so12749085vsd.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 17:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8Befy3R1F0eWwTQ9Ik5Xd4dXNM48kHZxmA2Si2BNh00=;
        b=mlJ42Wmk0g/Zww+wc3HKcPht3SrNzqwN2DG+h/dsO09sj927qHH3eGiBy5Afo0HNo+
         bctv4+9wDrgDHLfhKzOle+rQcSOTFC0RASt9EBC/uogrRZFx/sO0wPjCbVOu6ptOVQA1
         f2V8aAOHMjsUORgJNd2eNlQMHwPFkzur8+Jsa6NWt658Ye45a196pTY9ereEh52XKGpm
         O8uQ02a5qG23Qsspm3RQ9yfkWrCRbXIknMpk7rXJZDffpoUn7ReZGDuBFkJHz33bzVwA
         ihk4ppGr4T4pvA8ZIR3hRYGfRMAhkA8qXYEdyV8hNUUe0H0f0jYRaO1Zil0L63knZ6JP
         a6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8Befy3R1F0eWwTQ9Ik5Xd4dXNM48kHZxmA2Si2BNh00=;
        b=SUqW92zLijKW6z6f2ZWQqzHYSTauwez9zUOttYc1Tn39taY0bAsu00ICxmYocTU0ze
         Mb1RxDUhcIB7ZL8ZhIfvDLhm+M3SACMnOOFImqLh59dnGo1K1JEs9MpgBl/0qIAuIFQk
         hRWdnw0o8thhB0bxEuFLQsnkw19ne4JLExP1/IZ1PivEmOGVySX2YGPqV6d+WzmPbE1d
         nJ9dOvjmz4wYS0MsDe/V7C1+e1o0IBT90dxlYy40LGpED45oNR5+LTXqkdBB0+GNbDgy
         OkNQ+ZFU0uO/fT73cXgcFaiVtdUi0tCrssYwvCHfld9jTVHq7j9GBOYaceO8y3d5cpvw
         /27Q==
X-Gm-Message-State: AA+aEWYL37x+gfDw9OkcGjvMxcVcyJFYrloCQhvnXAveJ416w4/RuXnN
        Oc5vl3KufRy5vH2uK5LbnGkmXTyNxl1M0g==
X-Google-Smtp-Source: AFSGD/VUJwpoOtcwDGOTLEovtGTpiu3z/uEmvt2SuY6ZhBZkmc3qpn4Xtk6Krlw43FVtamVlIIGJZy76b0CO6A==
X-Received: by 2002:a67:6948:: with SMTP id e69mr25271286vsc.25.1546048562499;
 Fri, 28 Dec 2018 17:56:02 -0800 (PST)
Date:   Fri, 28 Dec 2018 17:55:24 -0800
Message-Id: <20181229015524.222741-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
Subject: [PATCH] netfilter: account ebt_table_info to kmemcg
From:   Shakeel Butt <shakeelb@google.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, bridge@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The [ip,ip6,arp]_tables use x_tables_info internally and the underlying
memory is already accounted to kmemcg. Do the same for ebtables. The
syzbot, by using setsockopt(EBT_SO_SET_ENTRIES), was able to OOM the
whole system from a restricted memcg, a potential DoS.

Reported-by: syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 net/bridge/netfilter/ebtables.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 491828713e0b..5e55cef0cec3 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1137,14 +1137,16 @@ static int do_replace(struct net *net, const void __user *user,
 	tmp.name[sizeof(tmp.name) - 1] = 0;
 
 	countersize = COUNTER_OFFSET(tmp.nentries) * nr_cpu_ids;
-	newinfo = vmalloc(sizeof(*newinfo) + countersize);
+	newinfo = __vmalloc(sizeof(*newinfo) + countersize, GFP_KERNEL_ACCOUNT,
+			    PAGE_KERNEL);
 	if (!newinfo)
 		return -ENOMEM;
 
 	if (countersize)
 		memset(newinfo->counters, 0, countersize);
 
-	newinfo->entries = vmalloc(tmp.entries_size);
+	newinfo->entries = __vmalloc(tmp.entries_size, GFP_KERNEL_ACCOUNT,
+				     PAGE_KERNEL);
 	if (!newinfo->entries) {
 		ret = -ENOMEM;
 		goto free_newinfo;
-- 
2.20.1.415.g653613c723-goog

