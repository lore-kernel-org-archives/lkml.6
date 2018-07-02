Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887E7C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B27F21456
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b1JnZ6B+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B27F21456
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeGBOwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:52:20 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:34909 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeGBOwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:52:19 -0400
Received: by mail-qk0-f202.google.com with SMTP id c3-v6so19414833qkb.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=xWiNCxLjc5o9MHlPm5wYvJq0DglGGclMpeHn1C9nuas=;
        b=b1JnZ6B+Pciud2vVvlyROa/SaZUrqA1rTGEgqktZAOBAkf96Ety6QUTeT0KWrAzyaE
         8ZFb1gkGavCp0Lh/5dzHoNsG0i8yt7TwkOdEg1oKbTzrZl7jihtpGLw8GFGU9I8pD0fx
         wCR/GVSkArI9Hl1rT25PSN8AZdyBKq9VOsSJMngxKbI9dub7mKJmwldd8s2uevDB1jqF
         ZOKg+7TljnLMHNz6BxpDMOeq2qfygfPPi5TCAGPNo1uppoWDjJj52IvsDQiLVhswfZHw
         qy9pIn+kjKQzB5Q82WPB0TsJ5/jCeXGl4BUph4c0u7+22Cjaszvz6ShFGxjcAvbJkNbv
         P4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=xWiNCxLjc5o9MHlPm5wYvJq0DglGGclMpeHn1C9nuas=;
        b=InAUzRQRhrIB0TXdPaTAKp5Ukbsx1YnyvFfPFzInCrwfqXjpV/JbJMwOXeBr/cdc0s
         69SjaOeZiEdFfDSA1U3PYXRYqvp/k8yBxaYwGffCfJGIa59IRU9BFRP+/KieviOeHfm6
         9dVk7fW8rzc0H22F9zcCwvrr5AjdrbY/QkRnz7nd/KZxMZYFvuH1YfNLdM/aA7MVtsYI
         ZBVSWc9khwVsxaS3bLI++6Xdh+3NDRuRFgQ69UIx6DCShit1PAziP0eksB18hK5EHNZ1
         /oe7JHNYorZk0AqCPqy7NIRAB6rjWgczUiRjt/a6FLfTCP5rbxZvTwtaWOjgo06qRIBc
         ggrw==
X-Gm-Message-State: APt69E183Bbqy0qoOl39H7L+eUd6YIVMfEOMJ6ctSXmfL5wi86ZTWqMF
        Y1pfy5nEyzxKAvxtDmZNkYeljrcAdg==
X-Google-Smtp-Source: AAOMgpc1Pv2crRfmBnKMXmvMbx26vPfxOKUOShAK9JOw6VfTrqJe/WigwhR+sHn3JTzGo83WxqMptFF82Q==
MIME-Version: 1.0
X-Received: by 2002:ac8:6655:: with SMTP id j21-v6mr6185258qtp.11.1530543138134;
 Mon, 02 Jul 2018 07:52:18 -0700 (PDT)
Date:   Mon,  2 Jul 2018 16:51:08 +0200
Message-Id: <20180702145108.73189-1-jannh@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH] fork: don't copy inconsistent signal handler state to child
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, jannh@google.com
Cc:     Rik van Riel <riel@redhat.com>, Michal Hocko <mhocko@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this change, if a multithreaded process forks while one of its
threads is changing a signal handler using sigaction(), the memcpy() in
copy_sighand() can race with the struct assignment in do_sigaction().
It isn't clear whether this can cause corruption of the userspace signal
handler pointer, but it definitely can cause inconsistency between
different fields of struct sigaction.

Take the appropriate spinlock to avoid this.

I have tested that this patch prevents inconsistency between sa_sigaction
and sa_flags, which is possible before this patch.

Signed-off-by: Jann Horn <jannh@google.com>
---
I haven't added a CC stable line to this patch because I feel that it
doesn't quite meet the bar; if anyone disagrees, please say so.


 kernel/fork.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 9440d61b925c..4c86e8daae53 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1394,7 +1394,9 @@ static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
 		return -ENOMEM;
 
 	atomic_set(&sig->count, 1);
+	spin_lock_irq(&current->sighand->siglock);
 	memcpy(sig->action, current->sighand->action, sizeof(sig->action));
+	spin_unlock_irq(&current->sighand->siglock);
 	return 0;
 }
 
-- 
2.18.0.399.gad0ab374a1-goog

