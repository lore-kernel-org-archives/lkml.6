Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EDCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50A520883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfARRFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:05:11 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:25638 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbfARRFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:05:11 -0500
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0IH54WW090682;
        Sat, 19 Jan 2019 02:05:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Sat, 19 Jan 2019 02:05:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0IH4wmG090626
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 19 Jan 2019 02:05:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] workqueue: Try to catch flush_work() without INIT_WORK().
Date:   Sat, 19 Jan 2019 02:04:58 +0900
Message-Id: <1547831098-7930-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot found a flush_work() caller who forgot to call INIT_WORK()
because that work_struct was allocated by kzalloc(). But the message

  INFO: trying to register non-static key.
  the code is fine but needs lockdep annotation.
  turning off the locking correctness validator.

by lock_map_acquire() is failing to tell that INIT_WORK() is missing.

Since flush_work() without INIT_WORK() is a bug, and INIT_WORK() should
set ->func field to non-zero, let's warn if ->func field is zero.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 kernel/workqueue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 392be4b..a503ad9 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2908,6 +2908,9 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
 	if (WARN_ON(!wq_online))
 		return false;
 
+	if (WARN_ON(!work->func))
+		return false;
+
 	if (!from_cancel) {
 		lock_map_acquire(&work->lockdep_map);
 		lock_map_release(&work->lockdep_map);
-- 
1.8.3.1

