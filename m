Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9712AC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C142086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C142086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeIDNFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 09:05:54 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:30295 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeIDNFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 09:05:54 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee45b8e4546eda-ce12d; Tue, 04 Sep 2018 16:41:42 +0800 (CST)
X-RM-TRANSID: 2ee45b8e4546eda-ce12d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25b8e4545043-532d1;
        Tue, 04 Sep 2018 16:41:42 +0800 (CST)
X-RM-TRANSID: 2ee25b8e4545043-532d1
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     takedakn@nttdata.co.jp, penguin-kernel@I-love.SAKURA.ne.jp,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dingxiang@cmss.chinamobile.com
Subject: [PATCH] security: tomoyo: Fix obsolete function
Date:   Tue,  4 Sep 2018 16:41:39 +0800
Message-Id: <1536050499-20889-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

simple_strtoul is obsolete, and use kstrtouint instead

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 security/tomoyo/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 03923a1..9b38f94 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -1660,7 +1660,8 @@ static void tomoyo_read_pid(struct tomoyo_io_buffer *head)
 	head->r.eof = true;
 	if (tomoyo_str_starts(&buf, "global-pid "))
 		global_pid = true;
-	pid = (unsigned int) simple_strtoul(buf, NULL, 10);
+	if (kstrtouint(buf, 10, &pid))
+		return;
 	rcu_read_lock();
 	if (global_pid)
 		p = find_task_by_pid_ns(pid, &init_pid_ns);
-- 
1.9.1



