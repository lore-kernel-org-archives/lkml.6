Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50338C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C4526479
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgT0ogcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C4526479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965493AbeFZDAZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 23:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965415AbeFZDAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 23:00:21 -0400
Received: from localhost.localdomain (h2133.porttelecom.ru [193.189.69.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6928926477;
        Tue, 26 Jun 2018 03:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529982021;
        bh=796wM8kZs0714cNQRwe9jXqOq809rFIeEEaVQFZt0vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qgT0ogclgd8O8M0hinawIrmIbkoOPcWZJ/0GaM1UqDwEmEQoiZxoDLzvOFrwcZ1Pn
         LLtlFJ49eLxXebUcnioccy14bxLnWj3a3nP7JCxbvxdNZgHKvOy+h7EY57YXiv2eyh
         5xIRRuzG+KotX+mO7h9NE6kJrPJn5h1ZEDdQ2kL4=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Joel Fernandes <joel.opensrc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 11/12] perf/breakpoint: Pass new breakpoint type to modify_breakpoint_slot()
Date:   Tue, 26 Jun 2018 04:58:58 +0200
Message-Id: <1529981939-8231-12-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529981939-8231-1-git-send-email-frederic@kernel.org>
References: <1529981939-8231-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We soon won't be able to rely on bp->attr anymore to get the new
type of the modifying breakpoint because the new attributes are going
to be copied only once we successfully modified the breakpoint slot.

This will fix the current misdesigned layout where the new attr are
copied to the modifying breakpoint before we actually know if the
modification will be validated.

In order to prepare for that, allow modify_breakpoint_slot() to take
the new breakpoint type.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Joel Fernandes <joel.opensrc@gmail.com>
---
 kernel/events/hw_breakpoint.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index e7bc8d0..7138770 100644
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
-- 
2.7.4

