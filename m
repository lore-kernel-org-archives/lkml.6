Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeDHCQg (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 22:16:36 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35614 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752258AbeDHCQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 22:16:35 -0400
X-Google-Smtp-Source: AIpwx4/KhLa5TN6KH7D4r3s2CcbUOUKsFU53C2H17CLHXpQjB8+gcR9uuCoIzvoprIsqnVJxlwrl2A==
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
X-Google-Original-From: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-patch-test@lists.linaro.org
Subject: [PATCH v1] ringbuffer: Don't choose the process with adj equal OOM_SCORE_ADJ_MIN
Date: Sun,  8 Apr 2018 10:16:23 +0800
Message-Id: <1523153783-20579-1-git-send-email-zhaoyang.huang@spreadtrum.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't choose the process with adj == OOM_SCORE_ADJ_MIN which
over-allocating pages for ring buffers.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 5f38398..1005d73 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1135,7 +1135,7 @@ static int rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
 static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
 {
 	struct buffer_page *bpage, *tmp;
-	bool user_thread = current->mm != NULL;
+	bool user_thread = (current->mm != NULL && current->signal->oom_score_adj != OOM_SCORE_ADJ_MIN);
 	gfp_t mflags;
 	long i;
 
-- 
1.9.1
