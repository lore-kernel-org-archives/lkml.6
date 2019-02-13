Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC3BC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7287C222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732859AbfBMA2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 19:28:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727915AbfBMA2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 19:28:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 124ADA7E1;
        Wed, 13 Feb 2019 00:28:43 +0000 (UTC)
Received: from llong.com (ovpn-121-56.rdu2.redhat.com [10.10.121.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C21A45C219;
        Wed, 13 Feb 2019 00:28:31 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 09/10] locking/lock_events: Don't show pvqspinlock events on bare metal
Date:   Tue, 12 Feb 2019 19:27:06 -0500
Message-Id: <1550017627-14504-10-git-send-email-longman@redhat.com>
In-Reply-To: <1550017627-14504-1-git-send-email-longman@redhat.com>
References: <1550017627-14504-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 13 Feb 2019 00:28:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On bare metail, the pvqspinlock event counts will always be 0. So there
is no point in showing their corresponding debugfs files. So they are
skipped in this case.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lock_events.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lock_events.c b/kernel/locking/lock_events.c
index 71c36d1..fa2c2f9 100644
--- a/kernel/locking/lock_events.c
+++ b/kernel/locking/lock_events.c
@@ -115,6 +115,29 @@ static ssize_t lockevent_write(struct file *file, const char __user *user_buf,
 	.llseek = default_llseek,
 };
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+#include <asm/paravirt.h>
+
+static bool __init skip_lockevent(const char *name)
+{
+	static int pv_on __initdata = -1;
+
+	if (pv_on < 0)
+		pv_on = !pv_is_native_spin_unlock();
+	/*
+	 * Skip PV qspinlock events on bare metal.
+	 */
+	if (!pv_on && !memcmp(name, "pv_", 3))
+		return true;
+	return false;
+}
+#else
+static inline bool skip_lockevent(const char *name)
+{
+	return false;
+}
+#endif
+
 /*
  * Initialize debugfs for the locking event counts.
  */
@@ -133,10 +156,13 @@ static int __init init_lockevent_counts(void)
 	 * root is allowed to do the read/write to limit impact to system
 	 * performance.
 	 */
-	for (i = 0; i < lockevent_num; i++)
+	for (i = 0; i < lockevent_num; i++) {
+		if (skip_lockevent(lockevent_names[i]))
+			continue;
 		if (!debugfs_create_file(lockevent_names[i], 0400, d_counts,
 					 (void *)(long)i, &fops_lockevent))
 			goto fail_undo;
+	}
 
 	if (!debugfs_create_file(lockevent_names[LOCKEVENT_reset_cnts], 0200,
 				 d_counts, (void *)(long)LOCKEVENT_reset_cnts,
-- 
1.8.3.1

