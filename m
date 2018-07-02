Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1044FC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55A124EFE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AtMKy3NQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55A124EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932379AbeGBWds (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:33:48 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43689 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932100AbeGBWdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:33:43 -0400
Received: by mail-pl0-f65.google.com with SMTP id c41-v6so8581279plj.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 15:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LYBWjD9MwZq6AeXds2cnbJ8nNRd/Ae3mKj4z54DE1Zs=;
        b=AtMKy3NQmBdR9DRsALEIXaFSpIUgdc/SJ8gjwuATA71vLVImd02gY8iqPxZ+lzyH4c
         RekUEJmI3/Zb0q5IqvJ0Bw1x+73Tq+SYyPvCKR9bdKteSheDI6PMB4+7B6AUVdP4af0i
         qXPwUL6fdrsUn9rQI2ij7H1+EwhH9MTYTLxIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LYBWjD9MwZq6AeXds2cnbJ8nNRd/Ae3mKj4z54DE1Zs=;
        b=t0ApM0VcHfMldFrcTyRjlyKHcrRmsuI+Z6ARQTjxiISEZvAdGSwqerKs5MiXwcGLif
         0GvAc7h60F5ANdkeEQDV6w/gc2cCTW0S+AWG2SVLnsGFB9/cLoQFptQ+gOK3wfvN71TJ
         7JyH+NuC1zvJVNbp2XklqH4khWFN+wIyo7ooxibe2Na0Y2/gLd/IYMscupHNpn8mrVL3
         z1fcA1u3kpXpjOf8yW485wS5gH22/mKa7QnCRj3bM+j1WFWjbHmoBl/bZPWh9lJxRnxo
         /NfAyf3ByLSkRIZqRchCFa4yyoNHWFRTIPLeQrIgCoTx/fAa3j0TNfZpyaWuXdW132Tl
         uKcQ==
X-Gm-Message-State: APt69E0T74wQyBkP/j0QUWr0MP6t5+zaihuZ1J63Nyo067j0zq+WqAy1
        +U+I8aw7MXW8ZBn2NnVbFbVp9Q==
X-Google-Smtp-Source: ADUXVKLK18tZmCuXH7mYlDlCFLc04gDg2/5EoDmkNGcyaXU5PYQLciOtfS2V1VwmFvobnTYQT6zhpQ==
X-Received: by 2002:a17:902:6ac7:: with SMTP id i7-v6mr28197745plt.288.1530570822617;
        Mon, 02 Jul 2018 15:33:42 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id p11-v6sm21764132pgu.16.2018.07.02.15.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 15:33:41 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peterz@infradead.org, acme@kernel.org
Cc:     mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com,
        mathieu.poirier@linaro.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/6] perf/aux: Make perf_event accessible to setup_aux()
Date:   Mon,  2 Jul 2018 16:33:28 -0600
Message-Id: <1530570810-28929-5-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
References: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be advantagous to have access to all the information conveyed by
a perf_event when setting up the AUX buffer, as it is the case when
dealing with PMU specific driver configuration communicated to the kernel
using an ioctl() call.

As such simply replace the cpu information by the complete perf_event
structure and change all affected customers.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/s390/kernel/perf_cpum_sf.c                  | 4 ++--
 arch/x86/events/intel/bts.c                      | 4 +++-
 arch/x86/events/intel/pt.c                       | 5 +++--
 drivers/hwtracing/coresight/coresight-etm-perf.c | 6 +++---
 drivers/perf/arm_spe_pmu.c                       | 6 +++---
 include/linux/perf_event.h                       | 2 +-
 kernel/events/ring_buffer.c                      | 2 +-
 7 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 0292d68e7dde..e06daaa08894 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1601,8 +1601,8 @@ static void aux_buffer_free(void *data)
  *
  * Return the private AUX buffer structure if success or NULL if fails.
  */
-static void *aux_buffer_setup(int cpu, void **pages, int nr_pages,
-			      bool snapshot)
+static void *aux_buffer_setup(struct perf_event *event, void **pages,
+			      int nr_pages, bool snapshot);
 {
 	struct sf_buffer *sfb;
 	struct aux_buffer *aux;
diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 24ffa1e88cf9..7139f6bf27ad 100644
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
index 8d016ce5b80d..8f4c98fdd03c 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1104,10 +1104,11 @@ static int pt_buffer_init_topa(struct pt_buffer *buf, unsigned long nr_pages,
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
index 677695635211..0f5e03e4df22 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -181,15 +181,15 @@ static void etm_free_aux(void *data)
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
index 54ec278d2fc4..4dcd7bf14dcc 100644
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
index 1fa12887ec02..4d9c8f30ca6c 100644
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
index 5d3cf407e374..4c96c7575224 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -648,7 +648,7 @@ int rb_alloc_aux(struct ring_buffer *rb, struct perf_event *event,
 			goto out;
 	}
 
-	rb->aux_priv = event->pmu->setup_aux(event->cpu, rb->aux_pages, nr_pages,
+	rb->aux_priv = event->pmu->setup_aux(event, rb->aux_pages, nr_pages,
 					     overwrite);
 	if (!rb->aux_priv)
 		goto out;
-- 
2.7.4

