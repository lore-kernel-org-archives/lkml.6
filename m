Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E48C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9512156F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9512156F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeHGWKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:10:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39664 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeHGWKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:10:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so16865199wre.6;
        Tue, 07 Aug 2018 12:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CxQUVpWuBYD6zIrYBlhv5veGvGXjxX9j8fkdJ8mIwQ4=;
        b=lLYNryPX/k6cvBwQ6iYjsADmCKMJjHC20bfVJ5qeGRninKChVASUyJc1iNvVLpU9NT
         WMX2kRr64VEx9UcXuW1/FArheVsBapjd2GdttuZzs8HVePUp0D/rUBgmahPkrmskuOyE
         O+IEI08RiNqxKQ6vkiPD3N42TcYYIZizYd0VHmhpcgOXEP6nr8gSwxcitbfit6F+Wp5+
         t+DdOC3K8JNjw0wWZ/e5qz+Z8Mlc0RYBmbEnn0hfKfAu8YlRBuHeGqG1Ica2G+U6CQmF
         io1LamnyrpAfcv3qiPzv7OhATGJNtK8ZMMu7tLPnEaudkmnAYveN5ERPXdOLNew4Px3v
         rZcg==
X-Gm-Message-State: AOUpUlGnfDNtB7+jKu543vgMdANn7DK9wN7SHZt5a85NWd0jq033K3Im
        nV1oewdiQwO7HYOWk85Zp4w=
X-Google-Smtp-Source: AAOMgpfWGRTeiO76IBAyklMCd9cBZXUoGZc7X4hMxYSy3DGjJWkrydP/elW5BKRvm5JSKm8SFPfnMQ==
X-Received: by 2002:a5d:40c4:: with SMTP id b4-v6mr12399952wrq.133.1533671646976;
        Tue, 07 Aug 2018 12:54:06 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-37-188-187-151.eurotel.cz. [37.188.187.151])
        by smtp.gmail.com with ESMTPSA id y206-v6sm3171179wmg.45.2018.08.07.12.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 12:54:06 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Georgi Nikolov <gnikolov@icdsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH] netfilter/x_tables: do not fail xt_alloc_table_info too easilly
Date:   Tue,  7 Aug 2018 21:54:00 +0200
Message-Id: <20180807195400.23687-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

eacd86ca3b03 ("net/netfilter/x_tables.c: use kvmalloc()
in xt_alloc_table_info()") has unintentionally fortified
xt_alloc_table_info allocation when __GFP_RETRY has been dropped from
the vmalloc fallback. Later on there was a syzbot report that this
can lead to OOM killer invocations when tables are too large and
0537250fdc6c ("netfilter: x_tables: make allocation less aggressive")
has been merged to restore the original behavior. Georgi Nikolov however
noticed that he is not able to install his iptables anymore so this can
be seen as a regression.

The primary argument for 0537250fdc6c was that this allocation path
shouldn't really trigger the OOM killer and kill innocent tasks. On the
other hand the interface requires root and as such should allow what the
admin asks for. Root inside a namespaces makes this more complicated
because those might be not trusted in general. If they are not then such
namespaces should be restricted anyway. Therefore drop the __GFP_NORETRY
and replace it by __GFP_ACCOUNT to enfore memcg constrains on it.

Fixes: 0537250fdc6c ("netfilter: x_tables: make allocation less aggressive")
Reported-by: Georgi Nikolov <gnikolov@icdsoft.com>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 net/netfilter/x_tables.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index d0d8397c9588..aecadd471e1d 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1178,12 +1178,7 @@ struct xt_table_info *xt_alloc_table_info(unsigned int size)
 	if (sz < sizeof(*info) || sz >= XT_MAX_TABLE_SIZE)
 		return NULL;
 
-	/* __GFP_NORETRY is not fully supported by kvmalloc but it should
-	 * work reasonably well if sz is too large and bail out rather
-	 * than shoot all processes down before realizing there is nothing
-	 * more to reclaim.
-	 */
-	info = kvmalloc(sz, GFP_KERNEL | __GFP_NORETRY);
+	info = kvmalloc(sz, GFP_KERNEL_ACCOUNT);
 	if (!info)
 		return NULL;
 
-- 
2.18.0

