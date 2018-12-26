Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53DFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964C3217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbeLZIhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 03:37:38 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17060 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726217AbeLZIhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 03:37:38 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3F5D5BBF228EC;
        Wed, 26 Dec 2018 16:37:34 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Wed, 26 Dec 2018
 16:37:28 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>,
        <yoshfuji@linux-ipv6.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] ipv4: fib_rules: Fix possible infinite loop in fib_empty_table
Date:   Wed, 26 Dec 2018 16:34:20 +0800
Message-ID: <20181226083420.20436-1-yuehaibing@huawei.com>
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
 net/ipv4/fib_rules.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index f8eb78d..1567e12 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -200,9 +200,13 @@ static struct fib_table *fib_empty_table(struct net *net)
 {
 	u32 id;
 
-	for (id = 1; id <= RT_TABLE_MAX; id++)
+	for (id = 1; id <= RT_TABLE_MAX; id++) {
 		if (!fib_get_table(net, id))
 			return fib_new_table(net, id);
+
+		if (id == RT_TABLE_MAX)
+			break;
+	}
 	return NULL;
 }
 
-- 
2.7.4


