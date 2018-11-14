Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05733C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB6522419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qM+F5sK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB6522419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732216AbeKNMrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:47:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731854AbeKNMrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:47:31 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49679223C8;
        Wed, 14 Nov 2018 02:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542163581;
        bh=ss1XwfAtdETZN5yX6kTWC5TF1aressA6u6hKvdhcIf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qM+F5sK69Kbq+DhGYUU/J4ZRY/Sj30L6lucA9C+/buSQngdRhWQR7xloL91stlfAk
         MpJi/9eNlLYbL9xMw4M8mS4dF5MuqAVU5sB2MRO1xPi/s0riYx++BiGyynQIzMit/z
         mnWOFmw7w6k3F0/4197n9ZzdP6d3UmrhMXwZGDl4=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 02/25] sched/vtime: Protect idle accounting under vtime seqcount
Date:   Wed, 14 Nov 2018 03:45:46 +0100
Message-Id: <1542163569-20047-3-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542163569-20047-1-git-send-email-frederic@kernel.org>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Locking the seqcount on idle vtime accounting wasn't thought to be
necessary because the readers of idle cputime don't use vtime (yet).

Now updating vtime expect the related seqcount to be locked so do it
for locking coherency purposes.

Also idle cputime updates use vtime, but idle cputime readers use the
traditional ad-hoc nohz time delta. We may want to consider moving
readers to use vtime to consolidate the overall accounting scheme. The
seqcount will be a functional requirement for it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cputime.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 54eb945..6e74ec2 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -800,7 +800,11 @@ EXPORT_SYMBOL_GPL(vtime_guest_exit);
 
 void vtime_account_idle(struct task_struct *tsk)
 {
+	struct vtime *vtime = &tsk->vtime;
+
+	write_seqcount_begin(&vtime->seqcount);
 	account_idle_time(get_vtime_delta(&tsk->vtime));
+	write_seqcount_end(&vtime->seqcount);
 }
 
 void arch_vtime_task_switch(struct task_struct *prev)
-- 
2.7.4

