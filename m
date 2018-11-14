Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF15C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D511F2245E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pe+cCexv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D511F2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732644AbeKNMsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:48:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:51982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732434AbeKNMsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:48:01 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD473223DD;
        Wed, 14 Nov 2018 02:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542163610;
        bh=oGrXjdIbIznOFrNsPh8cP+AcnTb8vDZkWf+XpTvS3Os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pe+cCexvGF31rAZIuKzy0SnaJk5MQ7De8r3P3UN4G0MI3HMuXxOJFo+Ppx05xT6a/
         O3j+h4U8qXpSI7n/5zmap1nO1kjauSMQdCXy7d/w6IvYQEBrTEgKsXerGdwqBR5oUP
         xrZ1IrEf0TP2VPAJXRFKXilrIjPQz51yMVV77jzc=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 15/25] sched/vtime: Introduce vtime_accounting_enabled_cpu()
Date:   Wed, 14 Nov 2018 03:45:59 +0100
Message-Id: <1542163569-20047-16-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542163569-20047-1-git-send-email-frederic@kernel.org>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to check if a remote CPU runs vtime accounting
(ie: is nohz_full). We'll need that to reliably support "nice"
accounting on kcpustat.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/vtime.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 82fed7a..a53f6ea 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -31,6 +31,16 @@ static inline bool vtime_accounting_enabled(void)
 	return context_tracking_enabled();
 }
 
+static inline bool vtime_accounting_enabled_cpu(int cpu)
+{
+	if (vtime_accounting_enabled()) {
+		if (context_tracking_enabled_cpu(cpu))
+			return true;
+	}
+
+	return false;
+}
+
 static inline bool vtime_accounting_enabled_this_cpu(void)
 {
 	if (vtime_accounting_enabled()) {
@@ -51,6 +61,7 @@ static inline void vtime_task_switch(struct task_struct *prev)
 
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING */
 
+static inline bool vtime_accounting_enabled_cpu(int cpu) {return false; }
 static inline bool vtime_accounting_enabled_this_cpu(void) { return false; }
 static inline void vtime_task_switch(struct task_struct *prev) { }
 
-- 
2.7.4

