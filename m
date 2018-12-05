Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E22BC07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049312054F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="InSmdtbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049312054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeLEDix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 22:38:53 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43005 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbeLEDiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 22:38:50 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so8346655pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 19:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ZDYCqv4PsKwCfxV4wYiEidyqfLofMuOiTwJRPvYNXY=;
        b=InSmdtbNs9MMdHQmrSpAC7teVBWc4cZ+2JnvEqbjhoOmUpBkWEq/enx2o906dkJ1CC
         ro2g29ceCp4EqCNppNQm3Fs+9DdjxkrQOuaD4akABkiZUgld+ZTBThEdhJaxHF8yTrWT
         H5iXc/ytmpps/nYzYCcqb60FRo+PP+76Rk1cA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ZDYCqv4PsKwCfxV4wYiEidyqfLofMuOiTwJRPvYNXY=;
        b=NK0JMXE1r50u/8010Ts5t69z2/9UizV/pGJnC+7TP917QsuIlIIqrnbgknWX7NN/AZ
         IOaGAacFxOMnK9yBapDe9wRJ6FQhAaXnSsDVVR5rSXubAudfFCb6rgF4lSqXdz0dwkvR
         YJgFKMvgRggkqhWIZHIb9oBEl+s9Zdfq6SYPZdIGTMgUAI5Dsh0hVy11SeYFIqK5G0/d
         +caTrOoUY4Iz0EEAE+ClU6YrOtuRmlAwBJ87Bvw02AoIign988O3TsZwQ9Ypj31SfPk6
         j7yP3gIxsjt9CTmkREr87zsTjDmhBK7hqsJLd9VBbj2nufyoL7EUGiiEf1KSt/qCsRnI
         U0bQ==
X-Gm-Message-State: AA+aEWbJc5XH2XwhrtmJi2YIqW4wOeP0+gj/NfVzOnriyB2yWS/jqF7G
        nEKRktPOblHdP0RG32r+6bzPTg==
X-Google-Smtp-Source: AFSGD/XLhA+x6nOuPfC86BrUdq9pGIS40T8Ll47DltojKBTe0T6KgOoWhfdfzEAUorDn2Mjesx86GA==
X-Received: by 2002:a62:2b8b:: with SMTP id r133mr11365337pfr.246.1543981129808;
        Tue, 04 Dec 2018 19:38:49 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id z62sm26456939pfl.33.2018.12.04.19.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 19:38:49 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org
Subject: [REPOST PATCH v6 4/4] kdb: Don't back trace on a cpu that didn't round up
Date:   Tue,  4 Dec 2018 19:38:28 -0800
Message-Id: <20181205033828.6156-5-dianders@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181205033828.6156-1-dianders@chromium.org>
References: <20181205033828.6156-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you have a CPU that fails to round up and then run 'btc' you'll end
up crashing in kdb becaue we dereferenced NULL.  Let's add a check.
It's wise to also set the task to NULL when leaving the debugger so
that if we fail to round up on a later entry into the debugger we
won't backtrace a stale task.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Changes in v6: None
Changes in v5: None
Changes in v4:
- Also clear out .debuggerinfo.
- Also clear out .debuggerinfo and .task for the master.
- Remove clearing out in kdb_stub for offline CPUs; it's now redundant.

Changes in v3:
- Don't back trace on a cpu that didn't round up new for v3.

Changes in v2: None

 kernel/debug/debug_core.c       |  4 ++++
 kernel/debug/kdb/kdb_bt.c       | 11 ++++++++++-
 kernel/debug/kdb/kdb_debugger.c |  7 -------
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 1fb8b239e567..5cc608de6883 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -592,6 +592,8 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 				arch_kgdb_ops.correct_hw_break();
 			if (trace_on)
 				tracing_on();
+			kgdb_info[cpu].debuggerinfo = NULL;
+			kgdb_info[cpu].task = NULL;
 			kgdb_info[cpu].exception_state &=
 				~(DCPU_WANT_MASTER | DCPU_IS_SLAVE);
 			kgdb_info[cpu].enter_kgdb--;
@@ -724,6 +726,8 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 	if (trace_on)
 		tracing_on();
 
+	kgdb_info[cpu].debuggerinfo = NULL;
+	kgdb_info[cpu].task = NULL;
 	kgdb_info[cpu].exception_state &=
 		~(DCPU_WANT_MASTER | DCPU_IS_SLAVE);
 	kgdb_info[cpu].enter_kgdb--;
diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
index 7921ae4fca8d..7e2379aa0a1e 100644
--- a/kernel/debug/kdb/kdb_bt.c
+++ b/kernel/debug/kdb/kdb_bt.c
@@ -186,7 +186,16 @@ kdb_bt(int argc, const char **argv)
 		kdb_printf("btc: cpu status: ");
 		kdb_parse("cpu\n");
 		for_each_online_cpu(cpu) {
-			sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
+			void *kdb_tsk = KDB_TSK(cpu);
+
+			/* If a CPU failed to round up we could be here */
+			if (!kdb_tsk) {
+				kdb_printf("WARNING: no task for cpu %ld\n",
+					   cpu);
+				continue;
+			}
+
+			sprintf(buf, "btt 0x%px\n", kdb_tsk);
 			kdb_parse(buf);
 			touch_nmi_watchdog();
 		}
diff --git a/kernel/debug/kdb/kdb_debugger.c b/kernel/debug/kdb/kdb_debugger.c
index 15e1a7af5dd0..53a0df6e4d92 100644
--- a/kernel/debug/kdb/kdb_debugger.c
+++ b/kernel/debug/kdb/kdb_debugger.c
@@ -118,13 +118,6 @@ int kdb_stub(struct kgdb_state *ks)
 	kdb_bp_remove();
 	KDB_STATE_CLEAR(DOING_SS);
 	KDB_STATE_SET(PAGER);
-	/* zero out any offline cpu data */
-	for_each_present_cpu(i) {
-		if (!cpu_online(i)) {
-			kgdb_info[i].debuggerinfo = NULL;
-			kgdb_info[i].task = NULL;
-		}
-	}
 	if (ks->err_code == DIE_OOPS || reason == KDB_REASON_OOPS) {
 		ks->pass_exception = 1;
 		KDB_FLAG_SET(CATASTROPHIC);
-- 
2.20.0.rc1.387.gf8505762e3-goog

