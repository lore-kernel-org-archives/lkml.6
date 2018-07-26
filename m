Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5406C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A37920857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="q0DopVhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A37920857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbeG0BKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 21:10:10 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33364 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731629AbeG0BKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 21:10:09 -0400
Received: by mail-pl0-f68.google.com with SMTP id 6-v6so1496542plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 16:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qK3jlpJqPwzr9IyuaohdlGRYRs3VMHf+Mv/c7WztzZE=;
        b=q0DopVhTOS8S1XOcMBEC2b/n2t/0LcYDePX9in/Zi/UucVBquGSqoDnVCcn+ynRqi5
         OxARdIhKsi4Vnp1lm1xjOJ6nT3NwCARDd9Grksy/ArGiRT4stmFp+1RJvWKC0gW3OpJq
         Bl0aqAT2FKkA2mTof5HQidxz0bazFNLT+xG/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qK3jlpJqPwzr9IyuaohdlGRYRs3VMHf+Mv/c7WztzZE=;
        b=Hxmxw1BuYvZx8qHs2tat5BGQZCkk4qf2gaUJn2WjTq7iyiYFCTPQorVeUc6FiyeDFj
         s3sk3i4XUwgOah1ad1hMiTew19tKy/F4D9//i7PzxnsYCcv0bRxLip06WB3u1ah3JaCd
         DgXS8ruJzfwIwGx4zxdNyPXSCK7cDdXSWve8TmeiLw8Wodq8wgcXuYP54WuBFz120TqQ
         COgeI3Vyd9as4UUdYPHpTUIy3P+eHSqJeHTirMxgU1dM8yTukSdF8DHfzbuyUhUtbOmw
         HoTjbThdGBMpdP1MolzhvdLJam6LRcYzzGzeCrlw2HxhZW9fBfB++ts9522kgIPQOFf8
         9qtQ==
X-Gm-Message-State: AOUpUlG4DP4xtdj5pBpkdNaK68zip4F5Zr+hU87b5lcsem6K0wqnerDc
        Hqgb/Ic9wgMuxd0WT8oMbrAxbthCfPM=
X-Google-Smtp-Source: AAOMgpfPd1mCZEAoUaase4yGnpMW9g03ohDiZzh7CFROLh28YNkTp5IGzyrNGjG84fw2kbqJbEOrnA==
X-Received: by 2002:a17:902:bd07:: with SMTP id p7-v6mr3873983pls.32.1532649061953;
        Thu, 26 Jul 2018 16:51:01 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id t76-v6sm3818840pfe.109.2018.07.26.16.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 16:51:01 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v11 1/3] lockdep: use this_cpu_ptr instead of get_cpu_var stats
Date:   Thu, 26 Jul 2018 16:50:42 -0700
Message-Id: <20180726235044.10195-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180726235044.10195-1-joel@joelfernandes.org>
References: <20180726235044.10195-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

get_cpu_var disables preemption which has the potential to call into the
preemption disable trace points causing some complications. There's also
no need to disable preemption in uses of get_lock_stats anyway since
preempt is already disabled. So lets simplify the code.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/locking/lockdep.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5fa4d3138bf1..8f5ce0048d15 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -248,12 +248,7 @@ void clear_lock_stats(struct lock_class *class)
 
 static struct lock_class_stats *get_lock_stats(struct lock_class *class)
 {
-	return &get_cpu_var(cpu_lock_stats)[class - lock_classes];
-}
-
-static void put_lock_stats(struct lock_class_stats *stats)
-{
-	put_cpu_var(cpu_lock_stats);
+	return &this_cpu_ptr(&cpu_lock_stats)[class - lock_classes];
 }
 
 static void lock_release_holdtime(struct held_lock *hlock)
@@ -271,7 +266,6 @@ static void lock_release_holdtime(struct held_lock *hlock)
 		lock_time_inc(&stats->read_holdtime, holdtime);
 	else
 		lock_time_inc(&stats->write_holdtime, holdtime);
-	put_lock_stats(stats);
 }
 #else
 static inline void lock_release_holdtime(struct held_lock *hlock)
@@ -4090,7 +4084,6 @@ __lock_contended(struct lockdep_map *lock, unsigned long ip)
 		stats->contending_point[contending_point]++;
 	if (lock->cpu != smp_processor_id())
 		stats->bounces[bounce_contended + !!hlock->read]++;
-	put_lock_stats(stats);
 }
 
 static void
@@ -4138,7 +4131,6 @@ __lock_acquired(struct lockdep_map *lock, unsigned long ip)
 	}
 	if (lock->cpu != cpu)
 		stats->bounces[bounce_acquired + !!hlock->read]++;
-	put_lock_stats(stats);
 
 	lock->cpu = cpu;
 	lock->ip = ip;
-- 
2.18.0.345.g5c9ce644c3-goog

