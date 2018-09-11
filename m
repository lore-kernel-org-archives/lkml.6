Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EBCC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC5320865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L1PO4N6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC5320865
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeIKXju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:39:50 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:35963 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKXju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:39:50 -0400
Received: by mail-yb1-f201.google.com with SMTP id e126-v6so12547577ybb.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 11:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jA8N4ToyH/y2/88nkwU8HeWL5jyBjgd+FrQpYzLpCG4=;
        b=L1PO4N6ooNOgTvZDAdWAuNyyDsoblSHhK44AZ84grrtK7ZUc35zWEScq3nvNJ3HqvX
         dYfbeyzdTHclaXYRO828eHYuduHpmT0gpoFEX1dDSk4uv4TzrXj6yslinsQjoAl2No+9
         SG6ww/U7Z9zZVBbm4VhGFspKtkRUxBank/U/Mqns/onxbPxR7piJOf0xMlsp3Q81zRb7
         iPIIb67tfDEZp0T44r+09m6lhqUEVSd924sUzFOkHycjlGWqW26b97y9YmrVUfc6BeJ1
         +FodHTElVbIqBPvPunU4zjRU+KgLXWRPEjZM3/cI1r5B33aH1TekP+1BzdB0vBbjkUo0
         Hksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jA8N4ToyH/y2/88nkwU8HeWL5jyBjgd+FrQpYzLpCG4=;
        b=i/KdeovqjWtJVCunCFvTpnaVyEOZqROYXTXpcFktKa8jNqwd+UpLZ95W/HxOYOTlBC
         1B80TNruCbsNjUYkCcgGGv9oR7qOWJYmjwzCugXJmyOOTfFW2eigAIZqg25vdHiZVEnP
         K/XcNMJe5OwYsOhpAYKOW/jcRiO9P6E30VB05IsbK0PJ4pWXPsfuuQOiTUdq0CFs3+nI
         7EH1F0EQfRHn3P60SDL4UezjEVZoo7uePbOI1aQSGuWPBOa3WubJntMfJ8mcEIKxjDKx
         +Z4WKHjtLv+edzIG0c1d3490HHkanJl2W1+hXKXbNR5ZVsUNG4uAtFZUjQnIC4mXCJGs
         YDyg==
X-Gm-Message-State: APzg51BAvP+ussP8wxVOoseZF9lbIoyws63kZ6rDzDzjwdKza5rHCJS/
        U+zsylVeQqqYAl2Ub1awRrQNt3HHeQ==
X-Google-Smtp-Source: ANB0VdZt81L8knkX5ivKEG+jBo1aTCuv7/Fo6l//lISTiooXyr0DBppat66yH/HipA+4PfcNyxT4TFNH6A==
X-Received: by 2002:a25:a08f:: with SMTP id y15-v6mr5758025ybh.28.1536691154741;
 Tue, 11 Sep 2018 11:39:14 -0700 (PDT)
Date:   Tue, 11 Sep 2018 20:39:09 +0200
Message-Id: <20180911183909.233413-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
Subject: [PATCH] proc: restrict kernel stack dumps to root
From:   Jann Horn <jannh@google.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>, jannh@google.com
Cc:     Ken Chen <kenchen@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>, security@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
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

