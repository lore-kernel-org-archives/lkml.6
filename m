Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B55BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418E92694A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418E92694A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964826AbeFZKc1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:32:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53869 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933509AbeFZKcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:32:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5QAVNXQ1648972
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Jun 2018 03:31:23 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5QAVNNn1648969;
        Tue, 26 Jun 2018 03:31:23 -0700
Date:   Tue, 26 Jun 2018 03:31:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-cb8b78815b68b048303f55c276d2aef147e8f2e7@git.kernel.org>
Cc:     jolsa@redhat.com, acme@redhat.com, ysato@users.sourceforge.jp,
        torvalds@linux-foundation.org, acme@kernel.org, hpa@zytor.com,
        namhyung@kernel.org, benh@kernel.crashing.org, will.deacon@arm.com,
        chris@zankel.net, dalias@libc.org, linux-kernel@vger.kernel.org,
        joel.opensrc@gmail.com, mingo@kernel.org, mark.rutland@arm.com,
        paulus@samba.org, peterz@infradead.org, catalin.marinas@arm.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        frederic@kernel.org, luto@kernel.org, jcmvbkbc@gmail.com,
        mpe@ellerman.id.au
Reply-To: jolsa@redhat.com, ysato@users.sourceforge.jp,
          torvalds@linux-foundation.org, acme@redhat.com, acme@kernel.org,
          hpa@zytor.com, namhyung@kernel.org, benh@kernel.crashing.org,
          will.deacon@arm.com, chris@zankel.net, dalias@libc.org,
          linux-kernel@vger.kernel.org, joel.opensrc@gmail.com,
          mingo@kernel.org, mark.rutland@arm.com, paulus@samba.org,
          peterz@infradead.org, catalin.marinas@arm.com,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          frederic@kernel.org, jcmvbkbc@gmail.com, luto@kernel.org,
          mpe@ellerman.id.au
In-Reply-To: <1529981939-8231-12-git-send-email-frederic@kernel.org>
References: <1529981939-8231-12-git-send-email-frederic@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/hw_breakpoint: Pass new breakpoint type to
 modify_breakpoint_slot()
Git-Commit-ID: cb8b78815b68b048303f55c276d2aef147e8f2e7
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

Commit-ID:  cb8b78815b68b048303f55c276d2aef147e8f2e7
Gitweb:     https://git.kernel.org/tip/cb8b78815b68b048303f55c276d2aef147e8f2e7
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 26 Jun 2018 04:58:58 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 26 Jun 2018 09:07:59 +0200

perf/hw_breakpoint: Pass new breakpoint type to modify_breakpoint_slot()

We soon won't be able to rely on bp->attr anymore to get the new
type of the modifying breakpoint because the new attributes are going
to be copied only once we successfully modified the breakpoint slot.

This will fix the current misdesigned layout where the new attr are
copied to the modifying breakpoint before we actually know if the
modification will be validated.

In order to prepare for that, allow modify_breakpoint_slot() to take
the new breakpoint type.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joel Fernandes <joel.opensrc@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Link: http://lkml.kernel.org/r/1529981939-8231-12-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/hw_breakpoint.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index e7bc8d0a5972..71387703b5f1 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -345,13 +345,13 @@ void release_bp_slot(struct perf_event *bp)
 	mutex_unlock(&nr_bp_mutex);
 }
 
-static int __modify_bp_slot(struct perf_event *bp, u64 old_type)
+static int __modify_bp_slot(struct perf_event *bp, u64 old_type, u64 new_type)
 {
 	int err;
 
 	__release_bp_slot(bp, old_type);
 
-	err = __reserve_bp_slot(bp, bp->attr.bp_type);
+	err = __reserve_bp_slot(bp, new_type);
 	if (err) {
 		/*
 		 * Reserve the old_type slot back in case
@@ -367,12 +367,12 @@ static int __modify_bp_slot(struct perf_event *bp, u64 old_type)
 	return err;
 }
 
-static int modify_bp_slot(struct perf_event *bp, u64 old_type)
+static int modify_bp_slot(struct perf_event *bp, u64 old_type, u64 new_type)
 {
 	int ret;
 
 	mutex_lock(&nr_bp_mutex);
-	ret = __modify_bp_slot(bp, old_type);
+	ret = __modify_bp_slot(bp, old_type, new_type);
 	mutex_unlock(&nr_bp_mutex);
 	return ret;
 }
@@ -481,7 +481,7 @@ modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *a
 
 	err = hw_breakpoint_parse(bp, attr, &hw);
 	if (!err && modify)
-		err = modify_bp_slot(bp, old_type);
+		err = modify_bp_slot(bp, old_type, bp->attr.bp_type);
 
 	if (err) {
 		bp->attr.bp_addr = old_addr;
