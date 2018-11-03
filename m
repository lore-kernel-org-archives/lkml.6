Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872AFC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 05:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BDA2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 05:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioP+d6bK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32BDA2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeKCOyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 10:54:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33905 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeKCOyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 10:54:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id f12-v6so753649plo.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 22:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tWZX+rzXp8zGCnh815hVbfFFGzy8Hb6ZcyMrfI/uV4Y=;
        b=ioP+d6bKoiubFf0RFYto7odYHFCnkOjHeuuhsYiB+Nlo/Kk+BBrCSPv3aHg+GrHpt/
         925fHyaV+JiHLoCqSkmDCpyJ4dEI2iUSGoltC/aFDiDxWqBM5Km85t1eAy+D4+uaC8mk
         bwu6xww5cr03eU3WvO0MN9P+Muq+w4F8wA/OV5kaeIdiE0EsieICskCc8NhOdkG6HpnA
         MGjyp10+yKmTlN86OlBBtn55U1tWdf21cua9vB9U34DmiyfdKu/oi4fOmp9H23Cn8r2k
         2bVAgEPQF9EOiA/eAnA95uBXwGw/Gdq2n2+Y12/E44sZc0Yo71jGUelSjhsngk37ikLD
         eFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tWZX+rzXp8zGCnh815hVbfFFGzy8Hb6ZcyMrfI/uV4Y=;
        b=uZ35DsAuMypYyCev2+yolIY8RTmkPMmE4gdvf5m6fpwfoUYnMWrTtpsSfDR4iG7AJ1
         jlLHclrtsFK7xNqlWwGtkXQ5e5yey0gguBWWpJl9H/lOzN9POElZF7Pd//CuQMRD7uYH
         XGmoWqCxxXWRndK/ZIzqoFyYsTSapT3HuwcDt41T/vpthrsvsZtI0sjAcN3ugxnKA7Y1
         uC02F6gm0iKgJgB16il6svVHv44vmF1lIYPInQlwkZsOU1E/r9tdLtd99KELBr+8fWhA
         nAC1b1KyfKP2h5tMLYvqEWcw9i/PzYpRudFon9hip+7dKtJyow1HB6x6qFepAYrnaRTo
         qz7Q==
X-Gm-Message-State: AGRZ1gKzJY7/JRKH5Mkgn7pq9GmYcytHVjuWyucwKm8EyeKOs2TkwEpT
        JJimBbgIMe/JpODfv+rJwWs=
X-Google-Smtp-Source: AJdET5fN7riYmXnn0N5BHNHFUbbVyG+7e0PcozhOLIqc095nb7O/U77R2yOBesSy24EGRZ5B1AKHEQ==
X-Received: by 2002:a17:902:28a8:: with SMTP id f37-v6mr14414410plb.264.1541223839881;
        Fri, 02 Nov 2018 22:43:59 -0700 (PDT)
Received: from localhost.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id g20-v6sm17249464pfj.145.2018.11.02.22.43.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 22:43:59 -0700 (PDT)
From:   Muchun Song <smuchun@gmail.com>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/rt: Remove unnecessary check for next_task in push_rt_task()
Date:   Sat,  3 Nov 2018 13:43:42 +0800
Message-Id: <20181103054342.53449-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In push_rt_task(), we call pick_next_pushable_task() to pick
next_task before the check. If next_task and rq->curr are equal,
which will trigger BUG_ON() in pick_next_pushable_task(). See
the following code in pick_next_pushable_task().

  static struct task_struct *pick_next_pushable_task(struct rq *rq)
  {
	BUG_ON(task_current(rq, p));
  }

The task_current() will check if task p and rq->curr are equal.
So, we can remove the unnecessary check in push_rt_task().

Signed-off-by: Muchun Song <smuchun@gmail.com>
---
 kernel/sched/rt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 481bb7aa25c5..ec097edea9ca 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1813,11 +1813,6 @@ static int push_rt_task(struct rq *rq)
 		return 0;
 
 retry:
-	if (unlikely(next_task == rq->curr)) {
-		WARN_ON(1);
-		return 0;
-	}
-
 	/*
 	 * It's possible that the next_task slipped in of
 	 * higher priority than current. If that's the case
-- 
2.17.1

