Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9285C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC3A213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfBJU5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:57:08 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37367 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfBJU5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:57:07 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1AKuO4q3235816
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 10 Feb 2019 12:56:25 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1AKuOF13235811;
        Sun, 10 Feb 2019 12:56:24 -0800
Date:   Sun, 10 Feb 2019 12:56:24 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Matthias Kaehlcke <tipbot@zytor.com>
Message-ID: <tip-0121805d9d2b1fff371e195c28e9b86ae38b5e47@git.kernel.org>
Cc:     peterz@infradead.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        paulmck@linux.vnet.ibm.com, rostedt@goodmis.org, mka@chromium.org,
        mingo@kernel.org, tglx@linutronix.de, bigeasy@linutronix.de,
        dianders@chromium.org, swboyd@chromium.org
Reply-To: peterz@infradead.org, mka@chromium.org, rostedt@goodmis.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org,
          paulmck@linux.vnet.ibm.com, mingo@kernel.org,
          swboyd@chromium.org, dianders@chromium.org,
          bigeasy@linutronix.de, tglx@linutronix.de
In-Reply-To: <20190128234625.78241-2-mka@chromium.org>
References: <20190128234625.78241-2-mka@chromium.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] kthread: Add __kthread_should_park()
Git-Commit-ID: 0121805d9d2b1fff371e195c28e9b86ae38b5e47
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0121805d9d2b1fff371e195c28e9b86ae38b5e47
Gitweb:     https://git.kernel.org/tip/0121805d9d2b1fff371e195c28e9b86ae38b5e47
Author:     Matthias Kaehlcke <mka@chromium.org>
AuthorDate: Mon, 28 Jan 2019 15:46:24 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 10 Feb 2019 21:51:39 +0100

kthread: Add __kthread_should_park()

kthread_should_park() is used to check if the calling kthread ('current')
should park, but there is no function to check whether an arbitrary kthread
should be parked. The latter is required to plug a CPU hotplug race vs. a
parking ksoftirqd thread.

The new __kthread_should_park() receives a task_struct as parameter to
check if the corresponding kernel thread should be parked.

Call __kthread_should_park() from kthread_should_park() to avoid code
duplication.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Link: https://lkml.kernel.org/r/20190128234625.78241-2-mka@chromium.org

---
 include/linux/kthread.h | 1 +
 kernel/kthread.c        | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index c1961761311d..1577a2d56e9d 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -56,6 +56,7 @@ void kthread_bind_mask(struct task_struct *k, const struct cpumask *mask);
 int kthread_stop(struct task_struct *k);
 bool kthread_should_stop(void);
 bool kthread_should_park(void);
+bool __kthread_should_park(struct task_struct *k);
 bool kthread_freezable_should_stop(bool *was_frozen);
 void *kthread_data(struct task_struct *k);
 void *kthread_probe_data(struct task_struct *k);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 087d18d771b5..65234c89d85b 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -101,6 +101,12 @@ bool kthread_should_stop(void)
 }
 EXPORT_SYMBOL(kthread_should_stop);
 
+bool __kthread_should_park(struct task_struct *k)
+{
+	return test_bit(KTHREAD_SHOULD_PARK, &to_kthread(k)->flags);
+}
+EXPORT_SYMBOL_GPL(__kthread_should_park);
+
 /**
  * kthread_should_park - should this kthread park now?
  *
@@ -114,7 +120,7 @@ EXPORT_SYMBOL(kthread_should_stop);
  */
 bool kthread_should_park(void)
 {
-	return test_bit(KTHREAD_SHOULD_PARK, &to_kthread(current)->flags);
+	return __kthread_should_park(current);
 }
 EXPORT_SYMBOL_GPL(kthread_should_park);
 
