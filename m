Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FA5C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 06:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0173421019
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 06:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbeL2Gq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 01:46:28 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:33746 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727254AbeL2Gq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 01:46:28 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9BC47B8863118;
        Sat, 29 Dec 2018 14:46:25 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Sat, 29 Dec 2018
 14:46:16 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>,
        <yoshfuji@linux-ipv6.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2] ipv4: fib_rules: Fix possible infinite loop in fib_empty_table
Date:   Sat, 29 Dec 2018 14:45:23 +0800
Message-ID: <20181229064523.15812-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc warn this:
net/ipv4/fib_rules.c:203 fib_empty_table() warn:
 always true condition '(id <= 4294967295) => (0-u32max <= u32max)'

'id' is u32, which always not greater than RT_TABLE_MAX
(0xFFFFFFFF), So add a check to break while wrap around.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: clean up exit conditions
---
 net/ipv4/fib_rules.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index f8eb78d..cfec3af 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -198,11 +198,15 @@ static int fib4_rule_match(struct fib_rule *rule, struct flowi *fl, int flags)
 
 static struct fib_table *fib_empty_table(struct net *net)
 {
-	u32 id;
+	u32 id = 1;
 
-	for (id = 1; id <= RT_TABLE_MAX; id++)
+	while (1) {
 		if (!fib_get_table(net, id))
 			return fib_new_table(net, id);
+
+		if (id++ == RT_TABLE_MAX)
+			break;
+	}
 	return NULL;
 }
 
-- 
2.7.4


