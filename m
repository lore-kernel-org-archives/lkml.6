Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3ACC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0D32184E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549988074;
	bh=VND5k2JW7QtV9ySj2wCYQ+iFgA8ygUhr6ofMEiu+/Dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AConTVCU+KVkR6zTY8JxwTcF9jZlgKOZLTEW0MpXUbpUc/S77zT1WCOl8tGa+Rz+M
	 VopCTm8jZ/TaRFxZqdxj5pwbBzN+ejyUdfcDBLUPXYsvG/RC5KYidulYH4qYKl3kGF
	 9cbGVKrkjjB9/mA2fOHlikSQvTFzfMm+1w97FAII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbfBLQOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:14:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbfBLQOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:14:32 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0965F21773;
        Tue, 12 Feb 2019 16:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549988072;
        bh=VND5k2JW7QtV9ySj2wCYQ+iFgA8ygUhr6ofMEiu+/Dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P9TjQDRh4cYn8IgvJjmfRXqvz2Jt5vNj7ZzePA9dkLTguZaIo+yH3KW43Qw0Zlp/L
         VFwiwtFjkccBwxfK6NFokTojvFuJvLspu08fUSTsVSNkR39SQ9OuHEV8tmnmC60QeV
         V705v3ZKnC+bK0F3MpCJi1qqSTm+KnAradhMnWtA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH -tip v3 07/10] kprobes: Prohibit probing on preempt_check debug functions
Date:   Wed, 13 Feb 2019 01:14:09 +0900
Message-Id: <154998804911.31052.3541963527929117920.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154998785011.31052.1475728497912659748.stgit@devbox>
References: <154998785011.31052.1475728497912659748.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since kprobes depends on preempt disable/enable, probing
on the preempt debug routine can cause recursive breakpoint
problem.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 lib/smp_processor_id.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 85925aaa4fff..157d9e31f6c2 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -5,10 +5,11 @@
  * DEBUG_PREEMPT variant of smp_processor_id().
  */
 #include <linux/export.h>
+#include <linux/kprobes.h>
 #include <linux/sched.h>
 
-notrace static unsigned int check_preemption_disabled(const char *what1,
-							const char *what2)
+notrace static nokprobe_inline
+unsigned int check_preemption_disabled(const char *what1, const char *what2)
 {
 	int this_cpu = raw_smp_processor_id();
 
@@ -56,9 +57,11 @@ notrace unsigned int debug_smp_processor_id(void)
 	return check_preemption_disabled("smp_processor_id", "");
 }
 EXPORT_SYMBOL(debug_smp_processor_id);
+NOKPROBE_SYMBOL(debug_smp_processor_id);
 
 notrace void __this_cpu_preempt_check(const char *op)
 {
 	check_preemption_disabled("__this_cpu_", op);
 }
 EXPORT_SYMBOL(__this_cpu_preempt_check);
+NOKPROBE_SYMBOL(__this_cpu_preempt_check);

