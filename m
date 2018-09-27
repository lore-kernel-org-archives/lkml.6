Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C8BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC6B216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fDrU2mfX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC6B216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeI0VwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:52:15 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:33061 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeI0VwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:52:14 -0400
Received: by mail-vs1-f74.google.com with SMTP id d17-v6so1060139vsc.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 08:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YD6ZM+HnTsOtlUk/16jXhScztnyHopHZs+PHDuwfBRA=;
        b=fDrU2mfXAiU/l5hZeI/7fp/5bLFJiasObZws8Ir326GyeFaLTzyMMKAFkLbbLjw+JE
         +6gb5LX0WKcGN9lQeZ05Qd57YxeLOHs0Ib9kI6VuH5NKvuZbKLPpLbU0e88Tud2fzC7m
         bLH1y7aaiJSRYzTPjODAhCUtKEreodNi30KLM0XyBPy+xyBgxNcC5gs6qnOiFT+hcpg/
         vvt6ymSYI+JB4xscxGXB/M8PaPpsjh5rO4PJKSqJfpxM+KMtIoEFOF7J8jGTnMjp9rWJ
         Sj82zqFObqpawadB53irfL7e2Q+UaQNYF4CazOXRc5b/21bOFYT8eztvESmEsMBkycnQ
         r7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YD6ZM+HnTsOtlUk/16jXhScztnyHopHZs+PHDuwfBRA=;
        b=KNmaTyHC7HrOtsQcjNt2PwYeOxAXitO+G/Uhs6oHlSroQK6LmKt4+RET1Dubr4tqvS
         P/2z4hiNj1kCVRcGToTQvC824HaA2A6qINETzUq/FLtKv9PH2vNhCbddVU88d48WgdxG
         xfZpwEZE1NmXQb84/AYqzBQzd6YGgsJkGoR5rVHnn/YQ+1DW06gx887v5DcAguEdZN5W
         xBFwKiXANd5TkTGKtgm0D5Mwbnz3NzYcXckgar2Uan9t55yhs4gy6RDYSOWIYuyPy91F
         hvAsVa9RG/gxeZ68kXVwEC/BiJ1ruJaqmULc2iILerAe0Cw0mtlzPb74ufB0GYyOu8rW
         7tzA==
X-Gm-Message-State: ABuFfoghiFxxlTwB6a0KUvbpRA+U0U7+4PRSC09GB3ULSExdAVrlqnZk
        rG6DAkWOJ/o8g0qsybcqtkhHYMloRw==
X-Google-Smtp-Source: ACcGV63IVoUugxs+B31IDjqaFMOeFcVNxtrgRFyiaE5zSCRf4q4LpTLQpKegopxq1ylOC5xQs+JQJHrCdw==
X-Received: by 2002:a67:4195:: with SMTP id x21-v6mr6037087vsf.25.1538062405281;
 Thu, 27 Sep 2018 08:33:25 -0700 (PDT)
Date:   Thu, 27 Sep 2018 17:33:16 +0200
Message-Id: <20180927153316.200286-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH resend] proc: restrict kernel stack dumps to root
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, jannh@google.com
Cc:     Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ken Chen <kenchen@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Security Officers <security@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restrict the ability to inspect kernel stacks of arbitrary tasks to root
in order to prevent a local attacker from exploiting racy stack unwinding
to leak kernel task stack contents.
See the added comment for a longer rationale.

There don't seem to be any users of this userspace API that can't
gracefully bail out if reading from the file fails. Therefore, I believe
that this change is unlikely to break things.
In the case that this patch does end up needing a revert, the next-best
solution might be to fake a single-entry stack based on wchan.

Fixes: 2ec220e27f50 ("proc: add /proc/*/stack")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
Resending because I forgot to send this to akpm the first time.

 fs/proc/base.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ccf86f16d9f0..7e9f07bf260d 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -407,6 +407,20 @@ static int proc_pid_stack(struct seq_file *m, struct pid_namespace *ns,
 	unsigned long *entries;
 	int err;
 
+	/*
+	 * The ability to racily run the kernel stack unwinder on a running task
+	 * and then observe the unwinder output is scary; while it is useful for
+	 * debugging kernel issues, it can also allow an attacker to leak kernel
+	 * stack contents.
+	 * Doing this in a manner that is at least safe from races would require
+	 * some work to ensure that the remote task can not be scheduled; and
+	 * even then, this would still expose the unwinder as local attack
+	 * surface.
+	 * Therefore, this interface is restricted to root.
+	 */
+	if (!file_ns_capable(m->file, &init_user_ns, CAP_SYS_ADMIN))
+		return -EACCES;
+
 	entries = kmalloc_array(MAX_STACK_TRACE_DEPTH, sizeof(*entries),
 				GFP_KERNEL);
 	if (!entries)
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

