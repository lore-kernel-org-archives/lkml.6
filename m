Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BACECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D69920861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D69920861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeINUVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:21:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12138 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726845AbeINUVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:21:30 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5BA19AA2FD213;
        Fri, 14 Sep 2018 23:06:28 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Fri, 14 Sep 2018 23:06:28 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <paul@paul-moore.com>, <sds@tycho.nsa.gov>, <eparis@parisplace.org>
CC:     <james.morris@microsoft.com>, <sgrover@codeaurora.org>,
        <kyeongdon.kim@lge.com>, <selinux@tycho.nsa.gov>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] selinux: ss: use match_string() helper  to simplify the code
Date:   Fri, 14 Sep 2018 22:54:12 +0800
Message-ID: <1536936852-30893-1-git-send-email-zhongjiang@huawei.com>
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
 security/selinux/ss/services.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 12e4143..aa9fc35 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1461,14 +1461,14 @@ static int security_context_to_sid_core(struct selinux_state *state,
 		return -ENOMEM;
 
 	if (!state->initialized) {
-		int i;
+		int index;
 
-		for (i = 1; i < SECINITSID_NUM; i++) {
-			if (!strcmp(initial_sid_to_string[i], scontext2)) {
-				*sid = i;
-				goto out;
-			}
+		index = match_string(initial_sid_to_string, SECINITSID_NUM, scontext2);
+		if (index >= 0) {
+			*sid = index;
+			goto out;
 		}
+
 		*sid = SECINITSID_KERNEL;
 		goto out;
 	}
-- 
1.7.12.4

