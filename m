Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1375C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F4F2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F4F2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbeKGUky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:40:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53267 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeKGUky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:40:54 -0500
Received: by mail-wm1-f67.google.com with SMTP id f10-v6so1458226wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 03:10:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kaRsQefptxnEovWjsmZk9CySsZtoMQpnzCuREB9ux7k=;
        b=fIxYCn3tcX+0xRq+8jjQSAD/VlRdCUJMnwdiRDJ57ktU8QLLKph7AFseENrs4ACLoW
         DgWF5THuO7QRFiHoS733/v7ILkgzAArVf8eePxq0b8zuXRYXT3QcrMykO+60/tDoKVbn
         OkrXvoOztJnuIVTRaoDbNoBc8JTvh+WimzzTxNWWAh/h/jrkyJ3YjlbFn65Mx1/F1hfW
         C9AVqlran4p2vtmx5jykfSAdFNRdA/1R9GHwlf+XhThoZgQpeJwyCMt5NB/9bKD8Q7jf
         nWnmu/MixQQu+4tYV/GIXS2/Np7Utyp6PoHhIo9O2f7QGsw9I7TnNWPUbOXhsvViJlDm
         qszA==
X-Gm-Message-State: AGRZ1gITRpd1Zqmu1F+DjFAQ47tmvK0kkZT7aOjVhgtYAWInvpEiGLXB
        FmjQ+ZcmhiNOX2VZsNh+tR2OOw==
X-Google-Smtp-Source: AJdET5fzA3vjtyhHdBc+nbRtpaKvjIPwXa0b7zNGpBdGot8duWB/tp44R++aHhyNQl+rbGR+dIkr5A==
X-Received: by 2002:a1c:4e18:: with SMTP id g24-v6mr1626079wmh.92.1541589058939;
        Wed, 07 Nov 2018 03:10:58 -0800 (PST)
Received: from localhost.localdomain ([151.35.177.55])
        by smtp.gmail.com with ESMTPSA id t14-v6sm381538wra.63.2018.11.07.03.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 03:10:58 -0800 (PST)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, bristot@redhat.com,
        linux-rt-users@vger.kernel.org, mtk.manpages@gmail.com,
        Juri Lelli <juri.lelli@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH] kernel/time/posix-cpu-timers: Remove useless call to check_dl_overrun
Date:   Wed,  7 Nov 2018 12:10:32 +0100
Message-Id: <20181107111032.32291-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_dl_overrun is used to send a SIGXCPU to users that asked to be
informed when SCHED_DEADLINE runtime overruns occur.

The function is called by check_thread_timers already, so the call in
check_process_timers is redundant/wrong (even though harmless).

Remove it.

Fixes: 34be39305a77 ("sched/deadline: Implement "runtime overrun signal" support")
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Cc: Claudio Scordino <claudio@evidence.eu.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 kernel/time/posix-cpu-timers.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index ce32cf741b25..8f0644af40be 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -917,9 +917,6 @@ static void check_process_timers(struct task_struct *tsk,
 	struct task_cputime cputime;
 	unsigned long soft;
 
-	if (dl_task(tsk))
-		check_dl_overrun(tsk);
-
 	/*
 	 * If cputimer is not running, then there are no active
 	 * process wide timers (POSIX 1.b, itimers, RLIMIT_CPU).
-- 
2.17.2

