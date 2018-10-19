Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F1BECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5012520866
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5012520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeJSJti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 05:49:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbeJSJth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 05:49:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED91A83F45;
        Fri, 19 Oct 2018 01:45:47 +0000 (UTC)
Received: from llong.com (ovpn-121-107.rdu2.redhat.com [10.10.121.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC74886B41;
        Fri, 19 Oct 2018 01:45:46 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] locking/lockdep: Make global debug_locks* variables read-mostly
Date:   Thu, 18 Oct 2018 21:45:18 -0400
Message-Id: <1539913518-15598-2-git-send-email-longman@redhat.com>
In-Reply-To: <1539913518-15598-1-git-send-email-longman@redhat.com>
References: <1539913518-15598-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 19 Oct 2018 01:45:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the frequently used lockdep global variable debug_locks read-mostly.
As debug_locks_silent is sometime used together with debug_locks,
it is also made read-mostly so that they can be close together.

With false cacheline sharing, cacheline contention problem can happen
depending on what get put into the same cacheline as debug_locks.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/debug_locks.h | 4 ++--
 lib/debug_locks.c           | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/debug_locks.h b/include/linux/debug_locks.h
index 120225e..257ab3c 100644
--- a/include/linux/debug_locks.h
+++ b/include/linux/debug_locks.h
@@ -8,8 +8,8 @@
 
 struct task_struct;
 
-extern int debug_locks;
-extern int debug_locks_silent;
+extern int debug_locks __read_mostly;
+extern int debug_locks_silent __read_mostly;
 
 
 static inline int __debug_locks_off(void)
diff --git a/lib/debug_locks.c b/lib/debug_locks.c
index 124fdf2..ce51749 100644
--- a/lib/debug_locks.c
+++ b/lib/debug_locks.c
@@ -21,7 +21,7 @@
  * that would just muddy the log. So we report the first one and
  * shut up after that.
  */
-int debug_locks = 1;
+int debug_locks __read_mostly = 1;
 EXPORT_SYMBOL_GPL(debug_locks);
 
 /*
@@ -29,7 +29,7 @@
  * 'silent failure': nothing is printed to the console when
  * a locking bug is detected.
  */
-int debug_locks_silent;
+int debug_locks_silent __read_mostly;
 EXPORT_SYMBOL_GPL(debug_locks_silent);
 
 /*
-- 
1.8.3.1

