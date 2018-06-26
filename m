Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC7FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709CE2690E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709CE2690E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964840AbeFZK0q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:26:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36405 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934339AbeFZK0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:26:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5QAPcKo1648115
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Jun 2018 03:25:38 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5QAPbI21648110;
        Tue, 26 Jun 2018 03:25:37 -0700
Date:   Tue, 26 Jun 2018 03:25:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-9a4903dde2c8633c5fcf887b98c4e047a6154a54@git.kernel.org>
Cc:     ysato@users.sourceforge.jp, benh@kernel.crashing.org,
        mingo@kernel.org, peterz@infradead.org, frederic@kernel.org,
        dalias@libc.org, hpa@zytor.com, paulus@samba.org, acme@kernel.org,
        namhyung@kernel.org, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        joel.opensrc@gmail.com, mark.rutland@arm.com, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, torvalds@linux-foundation.org,
        chris@zankel.net, mpe@ellerman.id.au, will.deacon@arm.com,
        jcmvbkbc@gmail.com, acme@redhat.com
Reply-To: acme@kernel.org, paulus@samba.org, namhyung@kernel.org,
          ysato@users.sourceforge.jp, benh@kernel.crashing.org,
          mingo@kernel.org, frederic@kernel.org, peterz@infradead.org,
          hpa@zytor.com, dalias@libc.org, will.deacon@arm.com,
          jcmvbkbc@gmail.com, acme@redhat.com, catalin.marinas@arm.com,
          linux-kernel@vger.kernel.org, luto@kernel.org,
          tglx@linutronix.de, joel.opensrc@gmail.com, mark.rutland@arm.com,
          torvalds@linux-foundation.org,
          alexander.shishkin@linux.intel.com, jolsa@redhat.com,
          mpe@ellerman.id.au, chris@zankel.net
In-Reply-To: <1529981939-8231-2-git-send-email-frederic@kernel.org>
References: <1529981939-8231-2-git-send-email-frederic@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/hw_breakpoint: Split attribute parse and
 commit
Git-Commit-ID: 9a4903dde2c8633c5fcf887b98c4e047a6154a54
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

Commit-ID:  9a4903dde2c8633c5fcf887b98c4e047a6154a54
Gitweb:     https://git.kernel.org/tip/9a4903dde2c8633c5fcf887b98c4e047a6154a54
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 26 Jun 2018 04:58:48 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 26 Jun 2018 09:07:53 +0200

perf/hw_breakpoint: Split attribute parse and commit

arch_validate_hwbkpt_settings() mixes up attribute check and commit into
a single code entity. Therefore the validation may return an error due to
incorrect atributes while still leaving halfway modified architecture
breakpoint data.

This is harmless when we deal with a new breakpoint but it becomes a
problem when we modify an existing breakpoint.

Split attribute parse and commit to fix that. The architecture is
passed a "struct arch_hw_breakpoint" to fill on top of the new attr
and the core takes care about copying the backend data once it's fully
validated. The architectures then need to implement the new API.

Original-patch-by: Andy Lutomirski <luto@kernel.org>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
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
Link: http://lkml.kernel.org/r/1529981939-8231-2-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/hw_breakpoint.c | 57 +++++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 6e28d2866be5..314e2a9040c7 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -400,16 +400,35 @@ int dbg_release_bp_slot(struct perf_event *bp)
 	return 0;
 }
 
-static int validate_hw_breakpoint(struct perf_event *bp)
+#ifndef hw_breakpoint_arch_parse
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw)
 {
-	int ret;
+	int err;
 
-	ret = arch_validate_hwbkpt_settings(bp);
-	if (ret)
-		return ret;
+	err = arch_validate_hwbkpt_settings(bp);
+	if (err)
+		return err;
+
+	*hw = bp->hw.info;
+
+	return 0;
+}
+#endif
+
+static int hw_breakpoint_parse(struct perf_event *bp,
+			       const struct perf_event_attr *attr,
+			       struct arch_hw_breakpoint *hw)
+{
+	int err;
+
+	err = hw_breakpoint_arch_parse(bp, attr, hw);
+	if (err)
+		return err;
 
 	if (arch_check_bp_in_kernelspace(bp)) {
-		if (bp->attr.exclude_kernel)
+		if (attr->exclude_kernel)
 			return -EINVAL;
 		/*
 		 * Don't let unprivileged users set a breakpoint in the trap
@@ -424,19 +443,22 @@ static int validate_hw_breakpoint(struct perf_event *bp)
 
 int register_perf_hw_breakpoint(struct perf_event *bp)
 {
-	int ret;
-
-	ret = reserve_bp_slot(bp);
-	if (ret)
-		return ret;
+	struct arch_hw_breakpoint hw;
+	int err;
 
-	ret = validate_hw_breakpoint(bp);
+	err = reserve_bp_slot(bp);
+	if (err)
+		return err;
 
-	/* if arch_validate_hwbkpt_settings() fails then release bp slot */
-	if (ret)
+	err = hw_breakpoint_parse(bp, &bp->attr, &hw);
+	if (err) {
 		release_bp_slot(bp);
+		return err;
+	}
 
-	return ret;
+	bp->hw.info = hw;
+
+	return 0;
 }
 
 /**
@@ -464,6 +486,7 @@ modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *a
 	u64 old_len  = bp->attr.bp_len;
 	int old_type = bp->attr.bp_type;
 	bool modify  = attr->bp_type != old_type;
+	struct arch_hw_breakpoint hw;
 	int err = 0;
 
 	bp->attr.bp_addr = attr->bp_addr;
@@ -473,7 +496,7 @@ modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *a
 	if (check && memcmp(&bp->attr, attr, sizeof(*attr)))
 		return -EINVAL;
 
-	err = validate_hw_breakpoint(bp);
+	err = hw_breakpoint_parse(bp, attr, &hw);
 	if (!err && modify)
 		err = modify_bp_slot(bp, old_type);
 
@@ -484,7 +507,9 @@ modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *a
 		return err;
 	}
 
+	bp->hw.info = hw;
 	bp->attr.disabled = attr->disabled;
+
 	return 0;
 }
 
