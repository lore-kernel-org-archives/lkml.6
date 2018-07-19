Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CECC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B086820684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ZS9Et4pU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B086820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbeGSUoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 16:44:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44071 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbeGSUoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 16:44:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so4694108pgp.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 13:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=I75kxmBTru1UzX2PQRe3XdnyeGupJQzpnNNYnAgGGLg=;
        b=ZS9Et4pUmgr/FSYDih5UtMKXideAWa8ZeeI8iZXwv4CkaWbVjAOpQPTXjsZKoCohLu
         yHVfxxdwLa5GnVaVSxD+zbQ+Dfxrt0sVMcMvC31hM+zssmJDvfLYkhDxQTgD3k8MxuUj
         K1usnZ4X8HrlucJLz7i4heVgB+uxsbVbV/xao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I75kxmBTru1UzX2PQRe3XdnyeGupJQzpnNNYnAgGGLg=;
        b=VAkxqDywyxD7Rc2VuscyDKr1SRy41Savppg2gpP6n+fI6vVyqb2brmDgSgMbg+vgKz
         5MPfv0VtO8EtByHlTh/N/EAgtpfRh0uwrWusp8PGy2qBfaJJMfZDFgBmfrwtMNVeQdPZ
         myxxFjVGllQzrn3rhad4zbsoPuXm+cWmqPGDpDZjsjTvv1jXfVEjXuuC7YxwQRx2C90P
         sH/bssYjoyUYuVGe8RTwH21+ELUF6InNsWfJcJXU1xhZBXvzG0mVpy51l0aHyCutGPcg
         vsWXI1nvGluUVFTeLJsulQLTZ9cklkQ/yHq1kt5ggRe0/JkcYWBT4GNigDjoZ1P8SvOK
         x+Gw==
X-Gm-Message-State: AOUpUlF2vwBUOGTwmNlvZvhMkiBXN5fQE5cvVH3bGkteHv49nhJdnMVQ
        GktRiTBV2XF/z78/HWpR2zheRNNRbXc=
X-Google-Smtp-Source: AAOMgpcO1AH75HpcnXi3yE/HOWglb6fxGeKqQik7cozriRvPgUTI26zwXmNN+xUtrycyrs8QtGyCIQ==
X-Received: by 2002:a62:f0d:: with SMTP id x13-v6mr10777303pfi.123.1532030415613;
        Thu, 19 Jul 2018 13:00:15 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id x4-v6sm15379pfm.119.2018.07.19.13.00.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 13:00:15 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Ruchi Kandoi <kandoiruchi@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH RFC] cpufreq: trace frequency limits change
Date:   Thu, 19 Jul 2018 12:59:57 -0700
Message-Id: <20180719195957.59000-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ruchi Kandoi <kandoiruchi@google.com>

systrace used for tracing for Android systems has carried a patch for
many years in the Android tree that traces when the cpufreq limits
change.  With the help of this information, systrace can know when the
policy limits change and can visually display the data. Lets add
upstream support for the same.

Signed-off-by: Ruchi Kandoi <kandoiruchi@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/trace/events-power.rst |  1 +
 drivers/cpufreq/cpufreq.c            |  1 +
 include/trace/events/power.h         | 25 +++++++++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/Documentation/trace/events-power.rst b/Documentation/trace/events-power.rst
index a77daca75e30..2ef318962e29 100644
--- a/Documentation/trace/events-power.rst
+++ b/Documentation/trace/events-power.rst
@@ -27,6 +27,7 @@ cpufreq.
 
   cpu_idle		"state=%lu cpu_id=%lu"
   cpu_frequency		"state=%lu cpu_id=%lu"
+  cpu_frequency_limits	"min=%lu max=%lu cpu_id=%lu"
 
 A suspend event is used to indicate the system going in and out of the
 suspend mode:
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b0dfd3222013..6533c6987866 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2236,6 +2236,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 
 	policy->min = new_policy->min;
 	policy->max = new_policy->max;
+	trace_cpu_frequency_limits(policy->max, policy->min, policy->cpu);
 
 	policy->cached_target_freq = UINT_MAX;
 
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 908977d69783..e978b05b0200 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -148,6 +148,31 @@ DEFINE_EVENT(cpu, cpu_frequency,
 	TP_ARGS(frequency, cpu_id)
 );
 
+TRACE_EVENT(cpu_frequency_limits,
+
+	TP_PROTO(unsigned int max_freq, unsigned int min_freq,
+		unsigned int cpu_id),
+
+	TP_ARGS(max_freq, min_freq, cpu_id),
+
+	TP_STRUCT__entry(
+		__field(u32,		min_freq)
+		__field(u32,		max_freq)
+		__field(u32,		cpu_id)
+	),
+
+	TP_fast_assign(
+		__entry->min_freq = min_freq;
+		__entry->max_freq = max_freq;
+		__entry->cpu_id = cpu_id;
+	),
+
+	TP_printk("min=%lu max=%lu cpu_id=%lu",
+		  (unsigned long)__entry->min_freq,
+		  (unsigned long)__entry->max_freq,
+		  (unsigned long)__entry->cpu_id)
+);
+
 TRACE_EVENT(device_pm_callback_start,
 
 	TP_PROTO(struct device *dev, const char *pm_ops, int event),
-- 
2.18.0.203.gfac676dfb9-goog

