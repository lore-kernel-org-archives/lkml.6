Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2FDC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5940224E6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ApmMCK73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5940224E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934057AbeFUWep (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:34:45 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42826 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933863AbeFUWd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:33:29 -0400
Received: by mail-pg0-f68.google.com with SMTP id c10-v6so2045643pgu.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 15:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j6lPye0g1OOV0nGV5FlFez9sBig7U1uURpZjRjQnBJo=;
        b=ApmMCK731bMxyQFQDadi34zQPuyeFUY2dMwsb24ql22oMA6PAc6tPHScn9Su6cVXOC
         H6bdyRoi0dey52sIY5bxDNXfzFyRdJ6l3Bqg9nx2YsFGbJij5Trdx4+AL74UNVJN5pJi
         CJPfvpfTXScFHDs3aaufnfHmokx+u5L9T/XIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j6lPye0g1OOV0nGV5FlFez9sBig7U1uURpZjRjQnBJo=;
        b=AFyrfQWmgjzlsdfzrVQ6ZMuMoU2IGSPkqtEY1JNj5wzMK1JTow4WlhaJhGEEDLeOP5
         IPdh1SZ4x59dXsR/IQNdNy2AEoiNEg9z9tMPjEddtg11mNcjbCDVlwHrT1GMeyXnxezk
         5YhDExlzO2Nx5+DN1mugwcmew2nAatmMZhfL1Xa9BovdqBAqIr475gkGIEqb44zT7r+R
         RJbTzSkL2Ysi+LkQH5A73z2SpdInFnC4uv6+0iEhBK9+ptnF3CLfkGXEEK+H9ESmdKPe
         U5obbo9mfYWrgc4IR42k6LSUgMVRHQv78wzGDo5kObBK8H9AUzBvH91FOAvaR6yi6S5f
         0OIA==
X-Gm-Message-State: APt69E2bhsAUi8t58MdYZzoceogwBnFrakx+ck9ITi17m/reVh6YIEVS
        nT2i7Vx88Dg2iGKbQBAV/6R4kbvQHTg=
X-Google-Smtp-Source: ADUXVKIfldjTlW9GqBtOak36gxJUpI5G3QnJpkE+ll3pfznvLL8WaJ35FschdJvMFYhChjrJAgR89Q==
X-Received: by 2002:a62:8b9b:: with SMTP id e27-v6mr29225952pfl.82.1529620408643;
        Thu, 21 Jun 2018 15:33:28 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id x19-v6sm11060824pfi.5.2018.06.21.15.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 15:33:28 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v9 3/7] trace/irqsoff: Split reset into separate functions
Date:   Thu, 21 Jun 2018 15:32:32 -0700
Message-Id: <20180621223236.211495-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <20180621223236.211495-1-joel@joelfernandes.org>
References: <20180621223236.211495-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Split reset functions into seperate functions in preparation
of future patches that need to do tracer specific reset.

Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/trace/trace_irqsoff.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 03ecb4465ee4..f8daa754cce2 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -634,7 +634,7 @@ static int __irqsoff_tracer_init(struct trace_array *tr)
 	return 0;
 }
 
-static void irqsoff_tracer_reset(struct trace_array *tr)
+static void __irqsoff_tracer_reset(struct trace_array *tr)
 {
 	int lat_flag = save_flags & TRACE_ITER_LATENCY_FMT;
 	int overwrite_flag = save_flags & TRACE_ITER_OVERWRITE;
@@ -665,6 +665,12 @@ static int irqsoff_tracer_init(struct trace_array *tr)
 
 	return __irqsoff_tracer_init(tr);
 }
+
+static void irqsoff_tracer_reset(struct trace_array *tr)
+{
+	__irqsoff_tracer_reset(tr);
+}
+
 static struct tracer irqsoff_tracer __read_mostly =
 {
 	.name		= "irqsoff",
@@ -697,11 +703,16 @@ static int preemptoff_tracer_init(struct trace_array *tr)
 	return __irqsoff_tracer_init(tr);
 }
 
+static void preemptoff_tracer_reset(struct trace_array *tr)
+{
+	__irqsoff_tracer_reset(tr);
+}
+
 static struct tracer preemptoff_tracer __read_mostly =
 {
 	.name		= "preemptoff",
 	.init		= preemptoff_tracer_init,
-	.reset		= irqsoff_tracer_reset,
+	.reset		= preemptoff_tracer_reset,
 	.start		= irqsoff_tracer_start,
 	.stop		= irqsoff_tracer_stop,
 	.print_max	= true,
@@ -731,11 +742,16 @@ static int preemptirqsoff_tracer_init(struct trace_array *tr)
 	return __irqsoff_tracer_init(tr);
 }
 
+static void preemptirqsoff_tracer_reset(struct trace_array *tr)
+{
+	__irqsoff_tracer_reset(tr);
+}
+
 static struct tracer preemptirqsoff_tracer __read_mostly =
 {
 	.name		= "preemptirqsoff",
 	.init		= preemptirqsoff_tracer_init,
-	.reset		= irqsoff_tracer_reset,
+	.reset		= preemptirqsoff_tracer_reset,
 	.start		= irqsoff_tracer_start,
 	.stop		= irqsoff_tracer_stop,
 	.print_max	= true,
-- 
2.18.0.rc2.346.g013aa6912e-goog

