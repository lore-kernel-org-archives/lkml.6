Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FC5C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E674220818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895761;
	bh=yuX/uGq+4qlryy93lnqueQk/S0Zv3nuRPJuT0L9kW40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u56vQN7TariVWfhnbQicBZ9fPFo9y+IhEmJvWi0Yk6B6Bnc6VwhJL0wfz9LPmlb48
	 W8qYzeX5uISfGQDq8KCjg/NS34Y3Ty9NqGtN2rjszBjEGV9sFQt50Gdh8z8A7B3j7z
	 pXW2MIm6ANDr8jeU+zD4GzILwG+izplumsSbyzUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbfBKOf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:35:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731138AbfBKOf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:35:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1B502080F;
        Mon, 11 Feb 2019 14:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895755;
        bh=yuX/uGq+4qlryy93lnqueQk/S0Zv3nuRPJuT0L9kW40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lDLMShLXJuAdP9ze7jUHyRwfscDaShi06fFw3pWOGN0OelYfThfXgtt8QXgAIy2QK
         vzlr74cxWKJZrvYZ5ybtgZKOd8rPYtnBzciwiTu0Y4n93cZ9xa1oBbFHoikeaLHH0Y
         xcE4R0d7VQXRVjjEOOoWGKzNHJ1x7ggpdY/njCOI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 275/352] kdb: Dont back trace on a cpu that didnt round up
Date:   Mon, 11 Feb 2019 15:18:22 +0100
Message-Id: <20190211141904.465436663@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 162bc7f5afd75b72acbe3c5f3488ef7e64a3fe36 ]

If you have a CPU that fails to round up and then run 'btc' you'll end
up crashing in kdb becaue we dereferenced NULL.  Let's add a check.
It's wise to also set the task to NULL when leaving the debugger so
that if we fail to round up on a later entry into the debugger we
won't backtrace a stale task.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/debug/debug_core.c       |  4 ++++
 kernel/debug/kdb/kdb_bt.c       | 11 ++++++++++-
 kernel/debug/kdb/kdb_debugger.c |  7 -------
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 65c0f1363788..94aa9ae0007a 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -535,6 +535,8 @@ return_normal:
 				arch_kgdb_ops.correct_hw_break();
 			if (trace_on)
 				tracing_on();
+			kgdb_info[cpu].debuggerinfo = NULL;
+			kgdb_info[cpu].task = NULL;
 			kgdb_info[cpu].exception_state &=
 				~(DCPU_WANT_MASTER | DCPU_IS_SLAVE);
 			kgdb_info[cpu].enter_kgdb--;
@@ -667,6 +669,8 @@ kgdb_restore:
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
2.19.1



