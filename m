Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A69EC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E762081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OjEOaGAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E762081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbeLDTky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:40:54 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43856 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeLDTky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:40:54 -0500
Received: by mail-lf1-f65.google.com with SMTP id u18so12881244lff.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MJ2RoHnxkmKN1SVC9aFtGcbGzzZFAKHvy0LyoUhWX9E=;
        b=OjEOaGAOFkvDZNcY6d+glGYmOCDflfGVTlcSq7GeLuHN2n3uCFPDwIGkWqVm/tIcfP
         cQMhbLZcN/CQuT1vVh4F7zR+wNgo5NYyZyk+tf48SggDyKpRpD9wHEjVaKvtM7rm7Vig
         Wig9sYqCOseL68ELNr7naLr3FBy4R59c70Rnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MJ2RoHnxkmKN1SVC9aFtGcbGzzZFAKHvy0LyoUhWX9E=;
        b=b23ML0AEoIzuQXfrY3LjcrDnXhIrWwiJDJ0v+DOsjPmIBigU/SG+hhvVDaIXAAUGgh
         +L/L1g49gJb0nlirm8PUMyUzJAkQx4Jbtm8XHY7bVbtxmV1QglauqW/qjKaHFZ80AJqw
         9CPpYwzxIbP+ej173T9+REg93APYshPNwf6sY7CbxtyG03ZxvLvllvwoYPnnEQPay4Up
         Q7jzL4nrilvtf1kP0B/3LA3O0TsRiLoqtNbtLUOINGw+m5yE8iRmfzxewrzJjQ4A4oku
         ad4x+JzC6Vtun7+vwlC3QR10w8k0Vxcm99OO7kWv/McZTk4wYriTNBqppgzcXJ7ZQMJ1
         e+kw==
X-Gm-Message-State: AA+aEWb1r/6iBrPFtZDJSzTFTHM5iw+6WBSXZmdyf90f/L/B9swjotXK
        2Rz4lYMWunI5Lk3UD2wpOuAVew==
X-Google-Smtp-Source: AFSGD/Xx4VXmGc945omBmedemBhF6sDuPq8xHe5Usk1n+/+ssWVExT4AWpb5pXG2Ewp55V4iZUuZvA==
X-Received: by 2002:a19:c413:: with SMTP id u19mr12341607lff.100.1543952452174;
        Tue, 04 Dec 2018 11:40:52 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id i75sm3187945lfb.58.2018.12.04.11.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 11:40:51 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com
Cc:     keescook@chromium.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v3] tracing: add cond_resched to ftrace_replace_code()
Date:   Tue,  4 Dec 2018 20:40:44 +0100
Message-Id: <20181204194044.9506-1-anders.roxell@linaro.org>
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
index c375e33239f7..7c9f49a5a1ab 100644
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
+	 * Some archs call this function with interrupts or preemption
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

