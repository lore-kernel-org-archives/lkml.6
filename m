Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4FBC004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 16:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D766920666
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 16:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D766920666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbeI2XQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 19:16:33 -0400
Received: from mail5.windriver.com ([192.103.53.11]:60244 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728394AbeI2XQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 19:16:33 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w8TGk5Av029114
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sat, 29 Sep 2018 09:46:42 -0700
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Sat, 29 Sep 2018 09:46:31 -0700
From:   <zhe.he@windriver.com>
To:     <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>,
        <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
        <zhe.he@windriver.com>
Subject: [PATCH v5 2/4] printk: Correct wrong casting
Date:   Sun, 30 Sep 2018 00:45:51 +0800
Message-ID: <1538239553-81805-2-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538239553-81805-1-git-send-email-zhe.he@windriver.com>
References: <1538239553-81805-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

Correct wrong casting that might cut off the normal output.

Signed-off-by: He Zhe <zhe.he@windriver.com>
Cc: stable@vger.kernel.org
Cc: pmladek@suse.com
Cc: sergey.senozhatsky@gmail.com
Cc: rostedt@goodmis.org
---
 kernel/printk/printk.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 06045ab..c9a0be3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2356,8 +2356,9 @@ void console_unlock(void)
 		printk_safe_enter_irqsave(flags);
 		raw_spin_lock(&logbuf_lock);
 		if (console_seq < log_first_seq) {
-			len = sprintf(text, "** %u printk messages dropped **\n",
-				      (unsigned)(log_first_seq - console_seq));
+			len = sprintf(text,
+				      "** %llu printk messages dropped **\n",
+				      log_first_seq - console_seq);
 
 			/* messages are gone, move to first one */
 			console_seq = log_first_seq;
-- 
2.7.4

