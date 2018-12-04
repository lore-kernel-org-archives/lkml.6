Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6EFC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634252082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/T928xt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634252082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbeLDT3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:29:12 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40989 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbeLDT3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:29:11 -0500
Received: by mail-lj1-f195.google.com with SMTP id z80-v6so15998678ljb.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=InkRDJb3bMIXWPs5c5/xqK+kSTer9bJK74SZfDVgZxo=;
        b=Q/T928xt76bOPzWNBRs8eIDvxhFDwvl8m/aCuQw/hFMVMHVkDqGOpLwXrS9DKPEtVF
         f8gY7A7z+GIWJpRz9IG107vWUKWbywnyObTWk35izIbagI8WIMIrAvfcOnWX2Yx2sSgE
         D7gI9mefs3fkYiggzx7ADfdojrQ2E3HmHC82k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=InkRDJb3bMIXWPs5c5/xqK+kSTer9bJK74SZfDVgZxo=;
        b=TfhUsHkL+l+yxxmNpjHKM3rKJQiSHLXapuWTexhMNsDq8qESZuRh00k7Po6EEza0GY
         4rFh7/YCHGDGpVEqObRaZCpfc5diS5yv47+rC+06GSEhdoZFCvGqHrMa4+I6xPTYMJFQ
         YZ/P6RXWjNt3FzN7TMivl4XuLayIOuYOLxclNZYyIjaKdQowOcrXgmgSWilss3yyr9Ul
         dmRcu1Zbn0OjQ1JPWIM1+0x0DkGBvrHju5s5o7mbUlUBy5v0hp6TBBVjeL/5CkaNZ32u
         2iSN3qm13lvKcYqUIp83QUv9qgZC2mrVEIstsYqYmmgRxmO8RKbfjNTliyUjkcs2yqR9
         /jiQ==
X-Gm-Message-State: AA+aEWYqFryCgfdM2XGIXClvyYE9H9sOIuy+7qBhZwV1Zp7jRgZoN1jP
        geMSFJbOl9tRSsI/ZkyjHqxBuA==
X-Google-Smtp-Source: AFSGD/WWz7qhKO7Ngy7zj4/C0F7tI8lp/upK4iu+SD8FPW1eO2uImdDob9s6GBjj7dcxIvr9hWE8mg==
X-Received: by 2002:a2e:83d7:: with SMTP id s23-v6mr3594602ljh.139.1543951748560;
        Tue, 04 Dec 2018 11:29:08 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id f8sm3396773lfe.72.2018.12.04.11.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 11:29:07 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com
Cc:     keescook@chromium.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] tracing: add cond_resched to ftrace_replace_code()
Date:   Tue,  4 Dec 2018 20:29:03 +0100
Message-Id: <20181204192903.8193-1-anders.roxell@linaro.org>
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
index c375e33239f7..7080eb464983 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2419,11 +2419,19 @@ void __weak ftrace_replace_code(int enable)
 {
 	struct dyn_ftrace *rec;
 	struct ftrace_page *pg;
+	bool schedulable;
 	int failed;
 
 	if (unlikely(ftrace_disabled))
 		return;
 
+	/*
+	 * Some archs calls this function with interrupts or preemption
+	 * disabled. However, for other archs that can preempt, this can cause
+	 * an tremendous unneeded latency.
+	 */
+	schedulable = !irqs_disabled() && !preempt_count();
+
 	do_for_each_ftrace_rec(pg, rec) {
 
 		if (rec->flags & FTRACE_FL_DISABLED)
@@ -2435,6 +2443,8 @@ void __weak ftrace_replace_code(int enable)
 			/* Stop processing */
 			return;
 		}
+		if (schedulable)
+			cond_resched();
 	} while_for_each_ftrace_rec();
 }
 
-- 
2.19.2

