Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECEDC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC78A20856
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iTqiOAwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbfACDOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 22:14:43 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:42963 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730045AbfACDOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 22:14:40 -0500
Received: by mail-qt1-f201.google.com with SMTP id n50so41031087qtb.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 19:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LBYMDCbBA3NW41N7ApDqhkDWIbRHpdiaiS5pDRmTU0c=;
        b=iTqiOAwEtmzx3502zPCqdPgvcXLNwz4HTbRKYhwJsFyOnPRo/g6n0AILOfliy/qjuL
         3tVx78BpK4nsjlTIuxF54IsHOSC2grti05o7bDgSCF6IsjYm5La1e5Aa/vf4/YLGbQN7
         O9OJsYhIQk2iLMgpyW/GKEOMLdNyOs0lRpjAwNQ1yLwDOtCyRyMk3XMLPjWg6zPu1rdE
         RzlLyI1Vh+bwuVKcEwKMNvQ5XuPQ6t18pzC5zTcH2NEAbR/voOiAIYcB/Kd/VYsMd919
         5I98cCRTXQivucvkT9l7n6EHg8j8iB2+S2Cx3BQOV7xk5ACuqsp9je0gJP0jNNiPWdMc
         X4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LBYMDCbBA3NW41N7ApDqhkDWIbRHpdiaiS5pDRmTU0c=;
        b=c3Mi8RuduX9r0rsURM8wPK83AUDqFo9pNOMadIWv+rYS4CvaqUFQxCx3wEdiJnf/gB
         ExRUk4oNPzm5WPlCTUPOjxmSmLbn49kY1jfbIEE0/CvmMiKszYRrTTfOT5tgdJpQHibN
         gALYRyzHnCXbn1MxOWeNAWewMoZyZflfT3M2k6J5sUNkoGrIyjR2m1anagcH4fyy8b72
         +Ywtcx73Vhx1FgM0DJqwot5fCOExk4DQF2VueUrjzVYjulUocqzLNKSTZrEPUyPo4ajp
         6Ji2wAhk0dc631OtpgJXr4YnvUz9hEeAZGVZvnVs1Babv/RFoQdeWqkZnDaCFjRUj0kn
         Nysg==
X-Gm-Message-State: AA+aEWaH49xIv5yiY3PMwQ7r3JPOuJmIRYnGaMH1Ud1WkpCiweIEcT5C
        szwaMxdSetdICLVJYEHnBTkoqbNt5l+bJg==
X-Google-Smtp-Source: AFSGD/XhD8Zqj94uhrG5IFVMBnwqV8DDYNGWMdHHtQ1uf5iT/YLIKYUBEXhwMnpfIvWyUT6S3kAKUGkH0SeKKQ==
X-Received: by 2002:aed:22cb:: with SMTP id q11mr34452744qtc.31.1546485279505;
 Wed, 02 Jan 2019 19:14:39 -0800 (PST)
Date:   Wed,  2 Jan 2019 19:14:31 -0800
Message-Id: <20190103031431.247970-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
Subject: [PATCH v2] netfilter: account ebt_table_info to kmemcg
From:   Shakeel Butt <shakeelb@google.com>
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Westphal <fw@strlen.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        bridge@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The [ip,ip6,arp]_tables use x_tables_info internally and the underlying
memory is already accounted to kmemcg. Do the same for ebtables. The
syzbot, by using setsockopt(EBT_SO_SET_ENTRIES), was able to OOM the
whole system from a restricted memcg, a potential DoS.

By accounting the ebt_table_info, the memory used for ebt_table_info can
be contained within the memcg of the allocating process. However the
lifetime of ebt_table_info is independent of the allocating process and
is tied to the network namespace. So, the oom-killer will not be able to
relieve the memory pressure due to ebt_table_info memory. The memory for
ebt_table_info is allocated through vmalloc. Currently vmalloc does not
handle the oom-killed allocating process correctly and one large
allocation can bypass memcg limit enforcement. So, with this patch,
at least the small allocations will be contained. For large allocations,
we need to fix vmalloc.

Reported-by: syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com
Signed-off-by: Shakeel Butt <shakeelb@google.com>
Cc: Florian Westphal <fw@strlen.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Cc: Roopa Prabhu <roopa@cumulusnetworks.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux MM <linux-mm@kvack.org>
Cc: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org
Cc: bridge@lists.linux-foundation.org
Cc: LKML <linux-kernel@vger.kernel.org>
---
Changelog since v1:
- More descriptive commit message.

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

