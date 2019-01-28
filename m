Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D56C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DC12171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692366;
	bh=0ieo5Dib0i5Gf3gMQ2kP4sQ1hKmfL8+L68c2DTTPqlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b6cJj60/Pzh1D1Hn211EuwWerBm46SRnJfPbuG5x5FagVMsNBzPpEIiX69SzVdmcY
	 Etjya5TIoPDyGHzLEGmd6T33udG6Jzuh+cEPlpiUPGTqRUhp3Y8upunGs4yzuyXfvP
	 nvWaj1WO/RjMxg4hvm1mYSU0/Ob8Z58XLIeLkFl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388607AbfA1QTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:19:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388120AbfA1QTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:19:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 090462084A;
        Mon, 28 Jan 2019 16:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692355;
        bh=0ieo5Dib0i5Gf3gMQ2kP4sQ1hKmfL8+L68c2DTTPqlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w4pOuV24r4adMmZ3MIqbVtWcOIiSnC9aZf9FqoyH+ryWRCiYJLSA9OXfnQoScaJ7H
         vZQLRfx45YitOAU1ToNNbvU8drYJmp4O9alezlj5eFuiYGMbu2L4k8wim12RP3nwhZ
         9lnTVgrlGuzAA0POPf0dUCtY0h1IaqHeuX+ZYiqQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.14 161/170] kdb: Don't back trace on a cpu that didn't round up
Date:   Mon, 28 Jan 2019 11:11:51 -0500
Message-Id: <20190128161200.55107-161-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

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
@@ -535,6 +535,8 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 				arch_kgdb_ops.correct_hw_break();
 			if (trace_on)
 				tracing_on();
+			kgdb_info[cpu].debuggerinfo = NULL;
+			kgdb_info[cpu].task = NULL;
 			kgdb_info[cpu].exception_state &=
 				~(DCPU_WANT_MASTER | DCPU_IS_SLAVE);
 			kgdb_info[cpu].enter_kgdb--;
@@ -667,6 +669,8 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
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

