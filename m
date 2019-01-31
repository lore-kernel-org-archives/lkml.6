Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97492C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FDE8218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BJKZnQ+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfAaSrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:47:23 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37687 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfAaSrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:47:19 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so1882055plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 10:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MDOVaEZRoG9B5WvSdx3N1/m5BAdIo/VwcdxFaAGLjXA=;
        b=BJKZnQ+p0uBUVj3n7icarSryaTOKTRasioqWRPgu+TOzelrnbg1R0SAw9L0i0x8xTa
         /UehSgEvaBqDDKe6qMaqPktktwAZy+gZHHqJn/FQHxag2SnXa6+QrAmyrT8wRSW6NMwy
         hlQftDB6KkRCdIrT/gYfa1IwVnANf6ApHPY/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MDOVaEZRoG9B5WvSdx3N1/m5BAdIo/VwcdxFaAGLjXA=;
        b=XVEEb71/nJBNYw40J6Ehl6jc7bYk4+gLDBJaZRvWmlxeqINJcX3vzbum0KmLqntejr
         RCsL2SI+1gxWtK8HV+WeToViag3IQQK+qo6pULFBsPHsw9sjGFwzY+u6k5Es0wOgDN2Z
         Sylo91pS4jUxxFYK2nKmERJGi4bgnhSoPKJM9bRy3xBWsMQ4Q9zOGOujIngZRYhie/i+
         jO1lVD7XwF6R4/tJ/fUOpJ5/HsvBB4QK8zqtarVZcDCNggvf2hDqMd2gPaSiVqY8RdbH
         YDtkk+vY0LroVpUOG9J2bOPzkNZ71afy0hDcO5kO1TaGnXJvXW3U9TOiDy0nGJQZlH5N
         2lqw==
X-Gm-Message-State: AJcUukcsfPMhvSu8/gOki9afAtwVm9UuF5hajiY3QQNrlbgnncwxArCt
        /vaoMuFBumZy7sdNsi1PWRxbeg==
X-Google-Smtp-Source: ALg8bN5gd1ngPUG4p0KKUQTOYYflRSYy02z33XiAqbwILxDmb2UHq2uegUeSvYjrDjP+dIm2MbDdfA==
X-Received: by 2002:a17:902:7d90:: with SMTP id a16mr34489495plm.249.1548960438825;
        Thu, 31 Jan 2019 10:47:18 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o66sm6236234pgo.75.2019.01.31.10.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 10:47:18 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org
Cc:     suzuki.poulose@arm.com, gregkh@linuxfoundation.org,
        mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/7] perf/aux: Make perf_event accessible to setup_aux()
Date:   Thu, 31 Jan 2019 11:47:08 -0700
Message-Id: <20190131184714.20388-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190131184714.20388-1-mathieu.poirier@linaro.org>
References: <20190131184714.20388-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pmu::setup_aux() is called the coresight PMU needs to know which
sink to use for the session by looking up the information in the
event's attr::config2 field.

As such simply replace the cpu information by the complete perf_event
structure and change all affected customers.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/s390/kernel/perf_cpum_sf.c                  | 6 +++---
 arch/x86/events/intel/bts.c                      | 4 +++-
 arch/x86/events/intel/pt.c                       | 5 +++--
 drivers/hwtracing/coresight/coresight-etm-perf.c | 6 +++---
 drivers/perf/arm_spe_pmu.c                       | 6 +++---
 include/linux/perf_event.h                       | 2 +-
 kernel/events/ring_buffer.c                      | 2 +-
 7 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index bfabeb1889cc..1266194afb02 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1600,7 +1600,7 @@ static void aux_sdb_init(unsigned long sdb)
 
 /*
  * aux_buffer_setup() - Setup AUX buffer for diagnostic mode sampling
- * @cpu:	On which to allocate, -1 means current
+ * @event:	Event the buffer is setup for, event->cpu == -1 means current
  * @pages:	Array of pointers to buffer pages passed from perf core
  * @nr_pages:	Total pages
  * @snapshot:	Flag for snapshot mode
@@ -1612,8 +1612,8 @@ static void aux_sdb_init(unsigned long sdb)
  *
  * Return the private AUX buffer structure if success or NULL if fails.
  */
-static void *aux_buffer_setup(int cpu, void **pages, int nr_pages,
-			      bool snapshot)
+static void *aux_buffer_setup(struct perf_event *event, void **pages,
+			      int nr_pages, bool snapshot)
 {
 	struct sf_buffer *sfb;
 	struct aux_buffer *aux;
diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index a01ef1b0f883..7cdd7b13bbda 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -77,10 +77,12 @@ static size_t buf_size(struct page *page)
 }
 
 static void *
-bts_buffer_setup_aux(int cpu, void **pages, int nr_pages, bool overwrite)
+bts_buffer_setup_aux(struct perf_event *event, void **pages,
+		     int nr_pages, bool overwrite)
 {
 	struct bts_buffer *buf;
 	struct page *page;
+	int cpu = event->cpu;
 	int node = (cpu == -1) ? cpu : cpu_to_node(cpu);
 	unsigned long offset;
 	size_t size = nr_pages << PAGE_SHIFT;
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 9494ca68fd9d..c0e86ff21f81 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1114,10 +1114,11 @@ static int pt_buffer_init_topa(struct pt_buffer *buf, unsigned long nr_pages,
  * Return:	Our private PT buffer structure.
  */
 static void *
-pt_buffer_setup_aux(int cpu, void **pages, int nr_pages, bool snapshot)
+pt_buffer_setup_aux(struct perf_event *event, void **pages,
+		    int nr_pages, bool snapshot)
 {
 	struct pt_buffer *buf;
-	int node, ret;
+	int node, ret, cpu = event->cpu;
 
 	if (!nr_pages)
 		return NULL;
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index abe8249b893b..f21eb28b6782 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -177,15 +177,15 @@ static void etm_free_aux(void *data)
 	schedule_work(&event_data->work);
 }
 
-static void *etm_setup_aux(int event_cpu, void **pages,
+static void *etm_setup_aux(struct perf_event *event, void **pages,
 			   int nr_pages, bool overwrite)
 {
-	int cpu;
+	int cpu = event->cpu;
 	cpumask_t *mask;
 	struct coresight_device *sink;
 	struct etm_event_data *event_data = NULL;
 
-	event_data = alloc_event_data(event_cpu);
+	event_data = alloc_event_data(cpu);
 	if (!event_data)
 		return NULL;
 	INIT_WORK(&event_data->work, free_event_data);
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 8e46a9dad2fa..7cb766dafe85 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -824,10 +824,10 @@ static void arm_spe_pmu_read(struct perf_event *event)
 {
 }
 
-static void *arm_spe_pmu_setup_aux(int cpu, void **pages, int nr_pages,
-				   bool snapshot)
+static void *arm_spe_pmu_setup_aux(struct perf_event *event, void **pages,
+				   int nr_pages, bool snapshot)
 {
-	int i;
+	int i, cpu = event->cpu;
 	struct page **pglist;
 	struct arm_spe_pmu_buf *buf;
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1d5c551a5add..3e49b2144808 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -409,7 +409,7 @@ struct pmu {
 	/*
 	 * Set up pmu-private data structures for an AUX area
 	 */
-	void *(*setup_aux)		(int cpu, void **pages,
+	void *(*setup_aux)		(struct perf_event *event, void **pages,
 					 int nr_pages, bool overwrite);
 					/* optional */
 
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 4a9937076331..857308295f63 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -658,7 +658,7 @@ int rb_alloc_aux(struct ring_buffer *rb, struct perf_event *event,
 			goto out;
 	}
 
-	rb->aux_priv = event->pmu->setup_aux(event->cpu, rb->aux_pages, nr_pages,
+	rb->aux_priv = event->pmu->setup_aux(event, rb->aux_pages, nr_pages,
 					     overwrite);
 	if (!rb->aux_priv)
 		goto out;
-- 
2.17.1

