Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BD5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF69B2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfBZLyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:54:12 -0500
Received: from aliyun-cloud.icoremail.net ([47.90.88.95]:30591 "HELO
        aliyun-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S1726004AbfBZLyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:54:12 -0500
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Feb 2019 06:54:10 EST
Received: from bogon.wangsu.com (unknown [59.61.78.237])
        by app2 (Coremail) with SMTP id 4zNnewCnJAT_JnVc+aQ9AA--.7800S3;
        Tue, 26 Feb 2019 19:46:17 +0800 (CST)
From:   Lin Feng <linf@wangsu.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com, fabf@skynet.be,
        arjan@infradead.org, linf@wangsu.com
Subject: [PATCH 2/2] kernel/latencytop.c: remove unnecessary checks for latencytop_enabled
Date:   Tue, 26 Feb 2019 19:46:02 +0800
Message-Id: <20190226114602.16902-2-linf@wangsu.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226114602.16902-1-linf@wangsu.com>
References: <20190226114602.16902-1-linf@wangsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 4zNnewCnJAT_JnVc+aQ9AA--.7800S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4xuFWkKF4kWry7AFykuFg_yoW8CryUpF
        s7urnFy3y8Ja1j9w1Iga1rCryUJw4rAry7KFyDA3W8Zr1qgr13XrnavF4j9r4jkry7Aan3
        XrWqqanrtF4UGaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: holqwq5zdqw23xof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. In latencytop source codes, we only have such calling chain:
account_scheduler_latency(struct task_struct *task, int usecs, int inter)
{
        if (unlikely(latencytop_enabled)) /* the outtermost check */
                __account_scheduler_latency(task, usecs, inter);
}
__account_scheduler_latency
    account_global_scheduler_latency
        if (!latencytop_enabled)

So, the inner check for latencytop_enabled is not necessary at all.

2. In clear_all_latency_tracing and now is called
clear_tsk_latency_tracing the check for latencytop_enabled is redundant
and buggy to some extent.
We have no reason to refuse clearing the /proc/$pid/latency if
latencytop_enabled is set to 0, considering that if we use latencytop
manually by echo 0 > /proc/sys/kernel/latencytop, then we want to clear
/proc/$pid/latency and failed.
Aslo we don't have such check in brother function
clear_global_latency_tracing.

Notes: These changes only visible to users who sets CONFIG_LATENCYTOP and
won't change user tool latencytop's behaviors.

Signed-off-by: Lin Feng <linf@wangsu.com>
---
 kernel/latencytop.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/latencytop.c b/kernel/latencytop.c
index 9e794b49791e..897895efafd9 100644
--- a/kernel/latencytop.c
+++ b/kernel/latencytop.c
@@ -71,9 +71,6 @@ void clear_tsk_latency_tracing(struct task_struct *p)
 {
 	unsigned long flags;
 
-	if (!latencytop_enabled)
-		return;
-
 	raw_spin_lock_irqsave(&latency_lock, flags);
 	memset(&p->latency_record, 0, sizeof(p->latency_record));
 	p->latency_record_count = 0;
@@ -96,9 +93,6 @@ account_global_scheduler_latency(struct task_struct *tsk,
 	int firstnonnull = MAXLR + 1;
 	int i;
 
-	if (!latencytop_enabled)
-		return;
-
 	/* skip kernel threads for now */
 	if (!tsk->mm)
 		return;
-- 
2.20.1

