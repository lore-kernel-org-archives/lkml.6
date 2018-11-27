Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F91C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C312086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="foFl1T1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C312086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbeK0V6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:58:54 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34591 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbeK0V6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:58:54 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so18626986ede.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 03:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=O/D9kbnAYZwk5S050zq7rQZlhZQPJhRryIL1wLBWUrU=;
        b=foFl1T1d1YXalNJRZ86A5IWZmeBSFcZTCOPtU4kgzcXHOtsavw3kQMR2sWnzMniaSL
         zFx8hX0MUsHePoROzuMHSYYOqcSa66WoVay2Ef6M44hDcppxW58rBZRjGwmIzhaIGGif
         lHAvvjiY3g6fSp7o8FHll0DpvdCaa8/6HTDi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O/D9kbnAYZwk5S050zq7rQZlhZQPJhRryIL1wLBWUrU=;
        b=DUrEsNEzhQ+tw1ENDWK6wTREr1pWzlRYhiLf5CwOM93/tGXmo2puVf7Uu4KjDruWMG
         CBj2YwBNM95qSzLPDkCMiTI1rfRQUBd5+acHVFTrgxQlwUkQfK0Izc6o1TAfDNLImUbz
         fmBodoiXuA7b3M5o+BCkEhkBTVZNn6lnTjiUnLqy3JXRvNGHOxLgEGFIlRq6TT4o4Wk1
         UG3j5FlH9ByZXzu7KKMF9+9R5VMTd9B413xTLImal+dy1ThGf4X6oiYOXmtprh5Lweo8
         C8jaCdy7T66pOgpj//aVCEX0aTEnDG3A2sdxD7NolHUm/3xP9cHQbeqIumooZKuOONeT
         4clA==
X-Gm-Message-State: AA+aEWZYgDZcy1XinQ8D7RFGFKmiRYcwgzSvd+Z/RC8lImIBsYXYN8uD
        8UqW8ERvV/rQAuvaBFQQvCZe+tyhpJqXVQ==
X-Google-Smtp-Source: AFSGD/V2XB7bdR8Rw5wmrGGYtxtHmq8el66L81hapfl5+i/AcHLEev1ZHvmiOxqTj9hdbbdp5xAIQw==
X-Received: by 2002:a50:bb08:: with SMTP id y8mr26826227ede.10.1543316481034;
        Tue, 27 Nov 2018 03:01:21 -0800 (PST)
Received: from andrea.amarulasolutions.com (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id s27-v6sm519172ejm.14.2018.11.27.03.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 03:01:20 -0800 (PST)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: Clean up comment in nohz_idle_balance()
Date:   Tue, 27 Nov 2018 12:01:10 +0100
Message-Id: <20181127110110.5533-1-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Concerning the comment associated to the atomic_fetch_andnot() in
nohz_idle_balance(), Vincent explains [1]:

  "[...] the comment is useless and can be removed [...]  it was
   referring to a line code above the comment that was present in
   a previous iteration of the patchset. This line disappeared in
   final version but the comment has stayed."

So remove the comment.

Vincent also points out that the full ordering associated to the
atomic_fetch_andnot() primitive could be relaxed, but this patch
insists on the current more conservative/fully ordered solution:

"Performance" isn't a concern, stay away from "correctness"/subtle
relaxed (re)ordering if possible..., just make sure not to confuse
the next reader with misleading/out-of-date comments.

[1] http://lkml.kernel.org/r/CAKfTPtBjA-oCBRkO6__npQwL3+HLjzk7riCcPU1R7YdO-EpuZg@mail.gmail.com

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ac855b2f47746..db514993565b2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9533,9 +9533,7 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 		return false;
 	}
 
-	/*
-	 * barrier, pairs with nohz_balance_enter_idle(), ensures ...
-	 */
+	/* could be _relaxed() */
 	flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
 	if (!(flags & NOHZ_KICK_MASK))
 		return false;
-- 
2.17.1

