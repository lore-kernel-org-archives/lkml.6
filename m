Return-Path: <leo.yan@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522379769; cv=none;
        d=google.com; s=arc-20160816;
        b=kdlXWtx76kTtfaiJeZYs3zFII6+LMHIhhCHgq2rowyZl7+Bxe7Hx5O/bh+fH333q2K
         IeZsbbR+F81pAVWd43osMf/9OgyCH3GoZ8GpQFM40ZXURvbhGpdLOc8pJu+vK2pIeTJq
         uqbGgbLy21fuDnlot6lC0kJfnEoBzSUg0GfEsq14ts/ErzLB/maZXZazyM1FGDRGJKJz
         AP4GHGZhBPJjz9/lDnEyErp2v/zPceKCPN5NBpd+pmAuOzzdXVBbV18XONYuin2Z2wyf
         frunqNPwjt/pWim59YGxg1MP3ZidUGDyLa3BkgucojNoS9VHXHrsxFtj6JLQiyxQhJ2q
         oqjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Q2kDM5YY0TwXhvJ2W20sii7DcFnE2eb+0roImoIBLhE=;
        b=yain3p/a9fabF2YgSOtGiA2hC5w3AToMSc9+1FJUPZGvlwMIFTDfqr2uH9sDTpF2lh
         218oduWMAnOmLmCCaEErCjeS0PAhasD8+2GXCQhEQzDLq1zgS3bVENyXcX5YRBodr/S/
         +2WDMKnaoG8/tr1J49bkPrR4U1o6Wz7zkbjS4i3qVkOV+tD2+egssnVeu71ov5rD/fOt
         imT53q58XOxczc72V5sVr4NWD7HUEe2/LGxg1nNm933l+43sMnjBTvmVbJFwMTm4Iy78
         XeOU4IbfrAPSniv+NliWcaNw5WRmKCvEzMkgxgF3z+TbpxH8KrcM39nMErlbEk5GKeIr
         sygA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=GMNqn4QN;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=GMNqn4QN;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/Hx8k47AgYUFTHesg40c/ixXuEBaOkWFXadUEmF3FYWomfV2Ez+AlODfglrazTqGUzpTHqcA==
From: Leo Yan <leo.yan@linaro.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	Kim Phillips <kim.phillips@arm.com>,
	Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 5/6] coresight: Set and clear sink device handler for kdump node
Date: Fri, 30 Mar 2018 11:15:23 +0800
Message-Id: <1522379724-30648-6-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522379724-30648-1-git-send-email-leo.yan@linaro.org>
References: <1522379724-30648-1-git-send-email-leo.yan@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596330889082321383?=
X-GMAIL-MSGID: =?utf-8?q?1596330889082321383?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If Coresight path is enabled for specific CPU, the sink device handler
need to be set to kdump node; on the other hand we also need to clear
sink device handler when path is disabled.

This patch sets sink devices handler for kdump node for two separate
Coresight enabling modes: CS_MODE_SYSFS and CS_MODE_PERF; and clear the
handler when Coresight is disabled.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c |  5 +++++
 drivers/hwtracing/coresight/coresight.c          | 16 ++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 8a0ad77..f8b159c 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -139,6 +139,8 @@ static void free_event_data(struct work_struct *work)
 	for_each_cpu(cpu, mask) {
 		if (!(IS_ERR_OR_NULL(event_data->path[cpu])))
 			coresight_release_path(event_data->path[cpu]);
+
+		coresight_kdump_sink(cpu, NULL);
 	}
 
 	kfree(event_data->path);
@@ -238,6 +240,9 @@ static void *etm_setup_aux(int event_cpu, void **pages,
 		event_data->path[cpu] = coresight_build_path(csdev, sink);
 		if (IS_ERR(event_data->path[cpu]))
 			goto err;
+
+		if (coresight_kdump_sink(cpu, sink))
+			goto err;
 	}
 
 	if (!sink_ops(sink)->alloc_buffer)
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 389c4ba..483a1f7 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -272,6 +272,7 @@ static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
 static bool coresight_disable_source(struct coresight_device *csdev)
 {
 	if (atomic_dec_return(csdev->refcnt) == 0) {
+
 		if (source_ops(csdev)->disable)
 			source_ops(csdev)->disable(csdev, NULL);
 		csdev->enable = false;
@@ -612,6 +613,13 @@ int coresight_enable(struct coresight_device *csdev)
 	if (ret)
 		goto err_source;
 
+	cpu = source_ops(csdev)->cpu_id(csdev);
+
+	/* Set sink device handler into kdump node */
+	ret = coresight_kdump_sink(cpu, sink);
+	if (ret)
+		goto err_kdump;
+
 	switch (subtype) {
 	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
 		/*
@@ -621,7 +629,6 @@ int coresight_enable(struct coresight_device *csdev)
 		 * be a single session per tracer (when working from sysFS)
 		 * a per-cpu variable will do just fine.
 		 */
-		cpu = source_ops(csdev)->cpu_id(csdev);
 		per_cpu(tracer_path, cpu) = path;
 		break;
 	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
@@ -636,6 +643,9 @@ int coresight_enable(struct coresight_device *csdev)
 	mutex_unlock(&coresight_mutex);
 	return ret;
 
+err_kdump:
+	coresight_disable_source(csdev);
+
 err_source:
 	coresight_disable_path(path);
 
@@ -659,9 +669,10 @@ void coresight_disable(struct coresight_device *csdev)
 	if (!csdev->enable || !coresight_disable_source(csdev))
 		goto out;
 
+	cpu = source_ops(csdev)->cpu_id(csdev);
+
 	switch (csdev->subtype.source_subtype) {
 	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
-		cpu = source_ops(csdev)->cpu_id(csdev);
 		path = per_cpu(tracer_path, cpu);
 		per_cpu(tracer_path, cpu) = NULL;
 		break;
@@ -674,6 +685,7 @@ void coresight_disable(struct coresight_device *csdev)
 		break;
 	}
 
+	coresight_kdump_sink(cpu, NULL);
 	coresight_disable_path(path);
 	coresight_release_path(path);
 
-- 
2.7.4
