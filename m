Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA97FC46462
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F34121526
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1jRinH74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F34121526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeJKGhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:37:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727291AbeJKGhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:37:35 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C032214C4;
        Wed, 10 Oct 2018 23:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213194;
        bh=kBO09AKHgomL2iAA5/sLRku4inhxuDBaT0QUgGn/RPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1jRinH74upEtjx2+c8pDYg/5KyMvmdnC8qtEJqU4Sj2BkR3mLV4MeIKIwcLMls00D
         1Po8C/dJLyUiFjoP7wrmWMx0ShNcxfJyZ4HB4c5WSXEq+SI+r2FhF3Y5wa5O4STu/b
         wkxxYsdzy5ZTwdeH4wcnyqTqGsnV7MZlWwIuqb9A=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [RFC PATCH 14/30] softirq: Introduce local_bh_disable_all()
Date:   Thu, 11 Oct 2018 01:12:01 +0200
Message-Id: <1539213137-13953-15-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we plan to narrow down local_bh_disable() to a per-vector disablement
granularity, a shortcut can be handy for code that want to disable all
of them and not care about carrying the bh enabled mask state prior to
the call.

(TODO: check that it is called while bh are ALL enabled because
local_bh_enable_all() is going to re-enable ALL of them. Pretty much like
there should be no local_irq_enable() between a pair or local_irq_save()
and local_irq_restore()).

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/bottom_half.h |  3 +++
 kernel/softirq.c            | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index fd75d1a..192a71c 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -64,4 +64,7 @@ static inline void local_bh_enable(void)
 	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
 }
 
+extern void local_bh_disable_all(void);
+extern void local_bh_enable_all(void);
+
 #endif /* _LINUX_BH_H */
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 75aab25..730a5c9 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -197,6 +197,16 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
+void local_bh_disable_all(void)
+{
+	local_bh_disable();
+}
+
+void local_bh_enable_all(void)
+{
+	local_bh_enable();
+}
+
 /*
  * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
  * but break the loop if need_resched() is set or after 2 ms.
-- 
2.7.4

