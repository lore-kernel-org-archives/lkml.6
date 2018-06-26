Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC3DC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6077E26478
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2lRtospQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6077E26478
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965508AbeFZDAb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 23:00:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965415AbeFZDA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 23:00:27 -0400
Received: from localhost.localdomain (h2133.porttelecom.ru [193.189.69.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E0112647A;
        Tue, 26 Jun 2018 03:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529982027;
        bh=ujD7adzc6C2uTf5OT13zdTM1f9osxn836xttMH78da4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2lRtospQ7yFyYY2NT9yG+w0Wy7oTgE8KQDkACWax50cwYoaX0uTxB/7cNulIA8/mt
         KVH2qj2rkdlITsn/x+IvoPELuXvFAndxns9WhYdyGa7MXDhEhEQXFQVuYw4Z5qUbFh
         Atl6iBH7OR1qmMpDBgghRDxLxi6kzBOUiwK+P+0g=
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
Subject: [PATCH 12/12] perf/breakpoint: Clean up and consolidate modify_user_hw_breakpoint_check()
Date:   Tue, 26 Jun 2018 04:58:59 +0200
Message-Id: <1529981939-8231-13-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529981939-8231-1-git-send-email-frederic@kernel.org>
References: <1529981939-8231-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the dance around old and new attributes. Just don't modify the
previous breakpoint at all until we have verified everything.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Original-patch-by: Andy Lutomirski <luto@kernel.org>
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
 kernel/events/hw_breakpoint.c | 46 ++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 7138770..b3814fc 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -461,37 +461,43 @@ register_user_hw_breakpoint(struct perf_event_attr *attr,
 }
 EXPORT_SYMBOL_GPL(register_user_hw_breakpoint);
 
+static void hw_breakpoint_copy_attr(struct perf_event_attr *to,
+				    struct perf_event_attr *from)
+{
+	to->bp_addr = from->bp_addr;
+	to->bp_type = from->bp_type;
+	to->bp_len  = from->bp_len;
+	to->disabled = from->disabled;
+}
+
 int
 modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *attr,
 			        bool check)
 {
-	u64 old_addr = bp->attr.bp_addr;
-	u64 old_len  = bp->attr.bp_len;
-	int old_type = bp->attr.bp_type;
-	bool modify  = attr->bp_type != old_type;
 	struct arch_hw_breakpoint hw;
-	int err = 0;
-
-	bp->attr.bp_addr = attr->bp_addr;
-	bp->attr.bp_type = attr->bp_type;
-	bp->attr.bp_len  = attr->bp_len;
-
-	if (check && memcmp(&bp->attr, attr, sizeof(*attr)))
-		return -EINVAL;
+	int err;
 
 	err = hw_breakpoint_parse(bp, attr, &hw);
-	if (!err && modify)
-		err = modify_bp_slot(bp, old_type, bp->attr.bp_type);
-
-	if (err) {
-		bp->attr.bp_addr = old_addr;
-		bp->attr.bp_type = old_type;
-		bp->attr.bp_len  = old_len;
+	if (err)
 		return err;
+
+	if (check) {
+		struct perf_event_attr old_attr;
+
+		old_attr = bp->attr;
+		hw_breakpoint_copy_attr(&old_attr, attr);
+		if (memcmp(&old_attr, attr, sizeof(*attr)))
+			return -EINVAL;
+	}
+
+	if (bp->attr.bp_type != attr->bp_type) {
+		err = modify_bp_slot(bp, bp->attr.bp_type, attr->bp_type);
+		if (err)
+			return err;
 	}
 
+	hw_breakpoint_copy_attr(&bp->attr, attr);
 	bp->hw.info = hw;
-	bp->attr.disabled = attr->disabled;
 
 	return 0;
 }
-- 
2.7.4

