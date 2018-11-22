Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5D5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF1020672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="k0cDlNDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF1020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405865AbeKWCvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:51:01 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44228 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395001AbeKWCvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:51:01 -0500
Received: by mail-ed1-f67.google.com with SMTP id y56so8102767edd.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 08:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dkKdJz+UCQP1sHE7zZVC/y0S6Fyw626GuOuqKhihHTo=;
        b=k0cDlNDP1jC/jmw6lvWHUxSIMYl7CRW3pwBGRT9hMOXNu6d1VxJbW5T4Z9wZ8JHaw5
         dmuY4+7qMx7E5wsFbEtyeyr/iippufRYHtAh1xBzNpf+zjJp8d6dtJuFCjvm+V6E0u9j
         keTWRCeT8az3V4kvAMA38RI3Xo0vmyYSSP4LY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dkKdJz+UCQP1sHE7zZVC/y0S6Fyw626GuOuqKhihHTo=;
        b=WVNt3c5ueZblEHle8NFMCmd5/WJ0EAQjLrFQwgDD3Tsyrjzb5ztmnyyGKyjCoopcjB
         SDOJCGfvpgnzs1U9RViGWY0P2jX+r449H/Pcoh28j4zOjh8Oqsc8k0mSU6dehLWrkmut
         bp4Pu/DGxVjplYEPpW43vgsuuKOgBUB7WvM5vJs31eg987iIvY90ev7EME9JspZaJUN3
         C5Eb5DW/JmClbcPIqXa0+9CEYqfLFkrWaZDX23oKaQ/AjV/+mfbhqYDEtQ3BH8HmDKO+
         LtYEpgYLrAvW16j9qgUgkSwsHldLJq3GUFi4bHwkMataEAeScm/2U/xetuoiKuQIUJYg
         CDZQ==
X-Gm-Message-State: AA+aEWZAxy+M4fw52Jx/2s5JfIOd7MqfVx9s5R7KCTmw+O0MlRS+go97
        gBS1KN16HVAhTOiqaSh8ly7Ex5NFNyotYA==
X-Google-Smtp-Source: AFSGD/U5TjbTocMFnVuMmJyfbLjvvUbpGt6MWlC2Hd0lqMz2FC7kRwzT2jB5IaQqjCtGxq210MYI2Q==
X-Received: by 2002:a50:e3cb:: with SMTP id c11mr10164723edm.80.1542903059000;
        Thu, 22 Nov 2018 08:10:59 -0800 (PST)
Received: from andrea.amarulasolutions.com (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id r46sm1346299edd.18.2018.11.22.08.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 08:10:58 -0800 (PST)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, stable@kernel.org
Subject: [PATCH] uprobes: Fix handle_swbp() vs. unregister() + register() race once more
Date:   Thu, 22 Nov 2018 17:10:31 +0100
Message-Id: <20181122161031.15179-1-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 142b18ddc8143 ("uprobes: Fix handle_swbp() vs unregister() +
register() race") added the UPROBE_COPY_INSN flag, and corresponding
smp_wmb() and smp_rmb() memory barriers, to ensure that handle_swbp()
uses fully-initialized uprobes only.

However, the smp_rmb() is mis-placed: this barrier should be placed
after handle_swbp() has tested for the flag, thus guaranteeing that
(program-order) subsequent loads from the uprobe can see the initial
stores performed by prepare_uprobe().

Move the smp_rmb() accordingly.  Also amend the comments associated
to the two memory barriers to indicate their actual locations.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: stable@kernel.org
Fixes: 142b18ddc8143 ("uprobes: Fix handle_swbp() vs unregister() + register() race")
---
 kernel/events/uprobes.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 96d4bee83489b..322e97bbb4370 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -829,7 +829,7 @@ static int prepare_uprobe(struct uprobe *uprobe, struct file *file,
 	BUG_ON((uprobe->offset & ~PAGE_MASK) +
 			UPROBE_SWBP_INSN_SIZE > PAGE_SIZE);
 
-	smp_wmb(); /* pairs with rmb() in find_active_uprobe() */
+	smp_wmb(); /* pairs with the smp_rmb() in handle_swbp() */
 	set_bit(UPROBE_COPY_INSN, &uprobe->flags);
 
  out:
@@ -2178,10 +2178,18 @@ static void handle_swbp(struct pt_regs *regs)
 	 * After we hit the bp, _unregister + _register can install the
 	 * new and not-yet-analyzed uprobe at the same address, restart.
 	 */
-	smp_rmb(); /* pairs with wmb() in install_breakpoint() */
 	if (unlikely(!test_bit(UPROBE_COPY_INSN, &uprobe->flags)))
 		goto out;
 
+	/*
+	 * Pairs with the smp_wmb() in prepare_uprobe().
+	 *
+	 * Guarantees that if we see the UPROBE_COPY_INSN bit set, then
+	 * we must also see the stores to &uprobe->arch performed by the
+	 * prepare_uprobe() call.
+	 */
+	smp_rmb();
+
 	/* Tracing handlers use ->utask to communicate with fetch methods */
 	if (!get_utask())
 		goto out;
-- 
2.17.1

