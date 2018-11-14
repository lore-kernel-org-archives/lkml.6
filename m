Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490FEC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06768223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXcnnVtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06768223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbeKNMrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:47:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:51850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732434AbeKNMry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:47:54 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D100223D0;
        Wed, 14 Nov 2018 02:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542163603;
        bh=GITGujmNftQUAJ3F6h7f+eUSisiSWIJCB/4EnS3MUSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NXcnnVtVtce9CfzFzCLeM6ukwozEVkRSQOexyw+vvikphGy2l9L0RBcRdqrWPdnbq
         5ZznwQDrvLyqyQWVa8kmPqPa8iEf/7V4B29SJYLqqMbapE6z+c6kDBEzRLAvE0SP25
         /NOaCH+RDWic/C/yWPJE6xO5iljfIZwexbsWUL/o=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 12/25] context_tracking: Rename context_tracking_is_cpu_enabled() to context_tracking_enabled_this_cpu()
Date:   Wed, 14 Nov 2018 03:45:56 +0100
Message-Id: <1542163569-20047-13-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542163569-20047-1-git-send-email-frederic@kernel.org>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Standardize the naming on top of the context_tracking_enabled_*() base.
Also make it clear we are checking the context tracking state of the
*current* CPU with this function. We'll need to add an API to check that
state on remote CPUs as well, so we must disambiguate the naming.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/context_tracking.h       | 2 +-
 include/linux/context_tracking_state.h | 4 ++--
 include/linux/vtime.h                  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index f1601ba..c9065ad 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -118,7 +118,7 @@ static inline void guest_enter_irqoff(void)
 	 * one time slice). Lets treat guest mode as quiescent state, just like
 	 * we do with user-mode execution.
 	 */
-	if (!context_tracking_cpu_is_enabled())
+	if (!context_tracking_enabled_this_cpu())
 		rcu_virt_note_context_switch(smp_processor_id());
 }
 
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 91250bd..08f125f 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -31,7 +31,7 @@ static inline bool context_tracking_enabled(void)
 	return static_branch_unlikely(&context_tracking_key);
 }
 
-static inline bool context_tracking_cpu_is_enabled(void)
+static inline bool context_tracking_enabled_this_cpu(void)
 {
 	return __this_cpu_read(context_tracking.active);
 }
@@ -43,7 +43,7 @@ static inline bool context_tracking_in_user(void)
 #else
 static inline bool context_tracking_in_user(void) { return false; }
 static inline bool context_tracking_enabled(void) { return false; }
-static inline bool context_tracking_cpu_is_enabled(void) { return false; }
+static inline bool context_tracking_enabled_this_cpu(void) { return false; }
 #endif /* CONFIG_CONTEXT_TRACKING */
 
 #endif
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 01f09ca..df03b37 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -34,7 +34,7 @@ static inline bool vtime_accounting_enabled(void)
 static inline bool vtime_accounting_cpu_enabled(void)
 {
 	if (vtime_accounting_enabled()) {
-		if (context_tracking_cpu_is_enabled())
+		if (context_tracking_enabled_this_cpu())
 			return true;
 	}
 
-- 
2.7.4

