Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A908C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D272820857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VnFxFZ7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D272820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbeGaABw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:01:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40537 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeGaABw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:01:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id x5-v6so7988544pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 15:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/czMhb1QemsAd31haxvAVX6PsBRZge5ZhQaYenBgIik=;
        b=VnFxFZ7A8vmywHSZR9e7mRGCqSVkld5obMyKcR62D/OJAkaBYVOCDyw9d5gTpW/qoi
         DpT7h8z51IBDLPaStWfi4vCSBtQE38VyXisHSjed1x5eYkZUMWVd4yA0Huw0lox4FxT8
         M1KsCAIlO2BYy2o5PbwarY1HwvqSQweLE6GS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/czMhb1QemsAd31haxvAVX6PsBRZge5ZhQaYenBgIik=;
        b=Dohg8z3b2gVG3MxyBO3zJc7ddFzFlSQF/YwMMrPMkKp8ZXcf+cQI//cow1qtxpAgZv
         eNKeqqJkK/Vg5omF3YHhu+JrwWo8eFSoVoaAL7ZYXcIMnXmaJQ/KB8oIJSp2IT+P8nAx
         qjXWxBo/1CKF2Z9rsujAFS+fKEx26MC/P0Nf8khKt7Ldd6mM4We8Fr6Fs/jFcI+NS6p4
         LbKXtUF+QaodOHvFYzhvQk54gAoYI+nEDptP0kiOrjd0NlWIMImIVqJJu+MGf/dNDgUF
         Z5x8fRXKcC0gJLN85KoDqSYEtSuZlZDLhFXSmYAwp4EDKIp0FfWmzS+TqwUlnA7FzZQH
         f2Ow==
X-Gm-Message-State: AOUpUlG1D/V5Uv51oEFOlKim04JS+kLTs7HePN2zzWHNQ2DiOwRyPhVl
        QW9qJVIcaZEnoUX++z/QvRKy9L4wYu8=
X-Google-Smtp-Source: AAOMgpfVFN3K78RI+mfKasLr5r5SsiRtDMqGoMd+uhgMX8L8yvBfr7hWnE9riU5gNldm1DUUagP0Ow==
X-Received: by 2002:a62:e813:: with SMTP id c19-v6mr19440786pfi.124.1532989486581;
        Mon, 30 Jul 2018 15:24:46 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id t21-v6sm21183914pfi.73.2018.07.30.15.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 15:24:46 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v12 1/3] lockdep: use this_cpu_ptr instead of get_cpu_var stats
Date:   Mon, 30 Jul 2018 15:24:21 -0700
Message-Id: <20180730222423.196630-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180730222423.196630-1-joel@joelfernandes.org>
References: <20180730222423.196630-1-joel@joelfernandes.org>
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
Acked-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/locking/lockdep.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5fa4d3138bf1..fbbb79d5cfa0 100644
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
+	return &this_cpu_ptr(cpu_lock_stats)[class - lock_classes];
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

