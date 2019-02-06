Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E39AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A6F2083B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479014;
	bh=+fdLtBa/jTcz5Smb3xVqKFDQXHQ3oH4hwydtbSFEpJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n7TdFQIs+vY3uwEavWt1eojtkLZiFlGqznFd0wBwR4XVgpBlOqhsHXO04Dvq7VX1O
	 yPtD+ntWzyjPo+gAGrPzklwmPy5kQLyCTR8FG0XvJjqrhNcdDaGntD3pQ5c4B/hx3z
	 QHNU6gi0z2tthF8KIBeRb9A7PvCGAcCQk3vxUXFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfBFSuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:50:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbfBFSuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:50:11 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B276218FE;
        Wed,  6 Feb 2019 18:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549479010;
        bh=+fdLtBa/jTcz5Smb3xVqKFDQXHQ3oH4hwydtbSFEpJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=toQnCDZ1Bh3NhTYaJp2d996JlKBJIzKzaPZuciv6Pfv/w2zp2Mu5bfe9tpXJDtYwT
         L1puKvQ5z0qDgMSO+U4mxWFh6+LYT4SVA4Z92JobY3+mTZPGkWhrcSkfrKQaDcRfjo
         eycm4HfOuR4gwsDrJRn1lr7cYoaQ0bWUletSn/XM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 20/53] perf/aux: Make perf_event accessible to setup_aux()
Date:   Wed,  6 Feb 2019 15:48:30 -0300
Message-Id: <20190206184903.24054-21-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

When pmu::setup_aux() is called the coresight PMU needs to know which
sink to use for the session by looking up the information in the
event's attr::config2 field.

As such simply replace the cpu information by the complete perf_event
structure and change all affected customers.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki Poulouse <suzuki.poulose@arm.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Link: http://lkml.kernel.org/r/20190131184714.20388-2-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index 6cb5d483ab34..d9c3610e0e25 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -410,7 +410,7 @@ struct pmu {
 	/*
 	 * Set up pmu-private data structures for an AUX area
 	 */
-	void *(*setup_aux)		(int cpu, void **pages,
+	void *(*setup_aux)		(struct perf_event *event, void **pages,
 					 int nr_pages, bool overwrite);
 					/* optional */
 
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 805f0423ee0b..70ae2422cbaf 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -657,7 +657,7 @@ int rb_alloc_aux(struct ring_buffer *rb, struct perf_event *event,
 			goto out;
 	}
 
-	rb->aux_priv = event->pmu->setup_aux(event->cpu, rb->aux_pages, nr_pages,
+	rb->aux_priv = event->pmu->setup_aux(event, rb->aux_pages, nr_pages,
 					     overwrite);
 	if (!rb->aux_priv)
 		goto out;
-- 
2.20.1

