Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97776ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 05:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B3A20881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 05:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B3A20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeIOKmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 06:42:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40399 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbeIOKmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 06:42:45 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8DE5F1D02826D;
        Sat, 15 Sep 2018 13:25:01 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Sat, 15 Sep 2018 13:25:02 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <mhocko@suse.com>, <vbabka@suse.cz>, <aryabinin@virtuozzo.com>,
        <aarcange@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [PATCH] mm: use match_string() helper to simplify the code
Date:   Sat, 15 Sep 2018 13:12:45 +0800
Message-ID: <1536988365-50310-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used intead of open coded implementation.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 mm/mempolicy.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2e76a8f..cfd26d7 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2711,12 +2711,11 @@ void numa_default_policy(void)
 int mpol_parse_str(char *str, struct mempolicy **mpol)
 {
 	struct mempolicy *new = NULL;
-	unsigned short mode;
 	unsigned short mode_flags;
 	nodemask_t nodes;
 	char *nodelist = strchr(str, ':');
 	char *flags = strchr(str, '=');
-	int err = 1;
+	int err = 1, mode;
 
 	if (nodelist) {
 		/* NUL-terminate mode or flags string */
@@ -2731,12 +2730,8 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 	if (flags)
 		*flags++ = '\0';	/* terminate mode string */
 
-	for (mode = 0; mode < MPOL_MAX; mode++) {
-		if (!strcmp(str, policy_modes[mode])) {
-			break;
-		}
-	}
-	if (mode >= MPOL_MAX)
+	mode = match_string(policy_modes, MPOL_MAX, str);
+	if (mode < 0)
 		goto out;
 
 	switch (mode) {
-- 
1.7.12.4

