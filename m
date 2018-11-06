Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E64C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD9A2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BDuji+jW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD9A2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbeKFPGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 10:06:34 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43195 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbeKFPGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 10:06:33 -0500
Received: by mail-pl1-f196.google.com with SMTP id g59-v6so5616334plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 21:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=713B2YJc8DMVCIsxQId0TubBbtFhH4LE/O/KGRCq34k=;
        b=BDuji+jWtTodTv9YA1GG0M4rOt+B+BWvdHCL3jKgBUvNJ6rvt8Yz6nfyDc84U1EtOO
         LyAP6oXHf255DMCLvc8fDKjGmwVUY258z9ZmqEGMBbY+emAckoXIPE9Jnd8YrhqtzyK0
         wUBxPfqhFcMKXkU+TRrRKWMq27d8iq6aPAnJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=713B2YJc8DMVCIsxQId0TubBbtFhH4LE/O/KGRCq34k=;
        b=KcA1WVFAcMbf5CCq9ALCMz4s4EFBWY0914Bp4tOON7YG9THmlUDNDcQ73UZ/wt7vuE
         MseSdVCxY8gJWyRKnomM3Nd0ZhNqu6/J/6vwDY9ixYK75Wj20WwcNpvBPXUP+B5mPql3
         Bzs4bJqs14hk3XMyCVPvlP5Y8dzlHDr0W/g9zdfzZxUwXjCoROw7gXwIKlXYVtmsrM2h
         MeA4RBJppoXJhCgbzN2L8QbRPtqJpWsydXF7QXG61AU/YHZ9UGmZoGOGbRWGENaklg8n
         qhVLXdZe4Lp1xwTdaQpF+5AmDUNSWBrgVegFY2HYZvirwtSUlgkIH/xEtvRDe2t1UXPc
         WjzQ==
X-Gm-Message-State: AGRZ1gLAeLeKIrmqk3itXLL6uhW79X5rgM3T4ZT/YMWwNqfZUrVr1phg
        FrpesWrt2n398cNM8L0W3xBEWw==
X-Google-Smtp-Source: AJdET5djf5Qwp0b0gp77RMoE0xmL/WiJqOXzjpyfPOfEZKB0HR8U7AdOc/vH1yaj2hP7YIE0y+9UNg==
X-Received: by 2002:a17:902:a5c6:: with SMTP id t6-v6mr25260883plq.31.1541482983020;
        Mon, 05 Nov 2018 21:43:03 -0800 (PST)
Received: from localhost ([171.61.116.174])
        by smtp.gmail.com with ESMTPSA id g8-v6sm26747069pfh.57.2018.11.05.21.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 21:43:01 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched: Fix the ifdef block in add_nr_running()
Date:   Tue,  6 Nov 2018 11:12:57 +0530
Message-Id: <78cbd78a615d6f9fdcd3327f1ead68470f92593e.1541482935.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in keeping the conditional statement of the if block
outside of the ifdef block, while all of its body is contained within
the ifdef block. Move the conditional statement as well under the ifdef
block.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b7a3147874e3..e0e052a50fcd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1801,12 +1801,12 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 
 	rq->nr_running = prev_nr + count;
 
-	if (prev_nr < 2 && rq->nr_running >= 2) {
 #ifdef CONFIG_SMP
+	if (prev_nr < 2 && rq->nr_running >= 2) {
 		if (!READ_ONCE(rq->rd->overload))
 			WRITE_ONCE(rq->rd->overload, 1);
-#endif
 	}
+#endif
 
 	sched_update_tick_dependency(rq);
 }
-- 
2.19.1.568.g152ad8e3369a

