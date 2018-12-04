Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B35C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FAC20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AL5otzb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FAC20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbeLDTMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:12:38 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42573 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeLDTMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:12:38 -0500
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so15974674lja.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=//4FO27EOO8cJvGZSWp42VAK+MHOwE9eX7iULiXx+NQ=;
        b=AL5otzb+xOXtn4QEnKRppU81XMGlj6grJ+JkKUIvawxYMmV8SR/cJtdLQYLgVwV3dJ
         yQEjxbd+5i+yTM+xUkJLWV6PqYTe455r9rIUGZ4oRB6F+CRAgdDNlTFfU4kXUUEBcSwl
         C417mNp+NmnXAlV2NN1/5/EadWCXxSHatXGG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=//4FO27EOO8cJvGZSWp42VAK+MHOwE9eX7iULiXx+NQ=;
        b=Z3SGDUxgPa7movmiKIKKFp09AOWqn6KC1w6lXmcdSLAjMzccOVokD0MbDE/gbnzooB
         VyA0ZsXX47ZxiotyDF0nv5R6J8i0P4nV36YJfWu6EBM0QRCKaP1DUHTw801k0dhV7RSc
         OGtueIQnEuaUWF0kwc1kzKWHLHPfiLZXsCufYrsgOlxnOJzt8jEVZP7MSo/Jh7DaPcCe
         ZXjvRuDfqX2kbsu/ObLMj1Fb6rEwhNFhthG6gDJAg3GnGn9M8C/z5W4ox8pBfoz9DLBz
         7vBqNx4hwFxWbVaqBO1fxXMcUKwbt8Lb3Z5+HmSdV+BSSDgCK0k2vP3paH/2R0Wyi4dT
         OfSw==
X-Gm-Message-State: AA+aEWbLlYk4q+RG++5ckr81o576KAhISOBPr/JOhGXcQ3r65BJab0xs
        KDQa8Q8pds6mD3Xq89JVJtl87g==
X-Google-Smtp-Source: AFSGD/VcbdFiqs7e1PfxY8flJnZ2mo69hCTifzV9KM01NitR/eCV/NC+U5QrkyOD7Rq/GcgJvgXv/g==
X-Received: by 2002:a2e:9556:: with SMTP id t22-v6mr14969452ljh.36.1543950755121;
        Tue, 04 Dec 2018 11:12:35 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id o26sm3316312lfl.18.2018.12.04.11.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 11:12:34 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com
Cc:     keescook@chromium.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] tracing: add cond_resched to ftrace_replace_code()
Date:   Tue,  4 Dec 2018 20:12:28 +0100
Message-Id: <20181204191229.6851-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running in qemu on an kernel built with allmodconfig and debug
options (in particular kcov and ubsan) enabled, ftrace_replace_code
function call take minutes. The ftrace selftest calls
ftrace_replace_code to look >40000 through
ftrace_make_call/ftrace_make_nop, and these end up calling
__aarch64_insn_write/aarch64_insn_patch_text_nosync.

Microseconds add up because this is called in a loop for each dyn_ftrace
record, and this triggers the softlockup watchdog unless we let it sleep
occasionally.

Rework so that we call cond_resched() if !irqs_disabled() && !preempt_count().

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 kernel/trace/ftrace.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c375e33239f7..582e3441e318 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2419,11 +2419,14 @@ void __weak ftrace_replace_code(int enable)
 {
 	struct dyn_ftrace *rec;
 	struct ftrace_page *pg;
+	bool schedulable;
 	int failed;
 
 	if (unlikely(ftrace_disabled))
 		return;
 
+	schedulable = !irqs_disabled() && !preempt_count();
+
 	do_for_each_ftrace_rec(pg, rec) {
 
 		if (rec->flags & FTRACE_FL_DISABLED)
@@ -2435,6 +2438,13 @@ void __weak ftrace_replace_code(int enable)
 			/* Stop processing */
 			return;
 		}
+		/*
+		 * Some archs calls this function with interrupts or preemption
+		 * disabled. Howeve, other archs don't and this can cause a
+		 * tremendous unneeded latency.
+		 */
+		if (schedulable)
+			cond_resched();
 	} while_for_each_ftrace_rec();
 }
 
-- 
2.19.2

