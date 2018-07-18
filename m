Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E34ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D7B2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eBfH2OWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D7B2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbeGRW2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:28:09 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52106 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbeGRW2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:28:08 -0400
Received: by mail-it0-f68.google.com with SMTP id h2-v6so6325562itj.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 14:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zKokYU1sqv2XQ4BO3FvTpjJgpxRIa8oNDIwHvFCAE7Y=;
        b=eBfH2OWNI4YFGwcqpGBiVneColENwVAO96kDQ4vimYQqVBWyOH9iMIXUWhSz5rcfFs
         F0/HwIOPIrbymw1yf5JbwS/gV10EKFhVgrCGfUAg+0042oEtfyXCwfnJvH6A0EzZAEqm
         +rMKGxPsYGflsBwWnUkLgxRZoZQgJbSG5IYAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zKokYU1sqv2XQ4BO3FvTpjJgpxRIa8oNDIwHvFCAE7Y=;
        b=cXk9n+YSyMVAq4roQDYBIHrcd9TDKesiTUolhtgl75qoUKzGSO77ylg94PLEt6uwBD
         SYMfYsyfYBMcePTMaAyDDxKKT5NGpAeKuoIHtzWLJE3GHinERXDgeN7lnaAyzqylmcsT
         pwPY3JLtl0E+ZV0hKCIqPesYFBymjbNOeb+cDhY/Don0eVGPV5KLqg1p4pc+M+DA/pdL
         N44FFmV0IGsiS7UFE2SdoF4kmAJI0u4zRGGl4CA5DIaiB4QHN+9ObEU4eGCQ3LISvKIM
         j1w03kHEzLNgBtAIWYG6BGkKisPyDsVSx/9YimikiwvmlkVAXN9aMSAMs3MFV7t1cAZd
         ryFQ==
X-Gm-Message-State: AOUpUlF2iTDrVMNiJ1b/lp4g9paHm6i6bxm1bS+PqT/tyDDQu/lnWJEX
        pwcJZ571mptlGaUTB2vQlFdiaw==
X-Google-Smtp-Source: AAOMgpcgAY0oalTOPHah3ARB7BRSLEwYU6jr6keOmf4VjK90DIrN/6Zkw8/1a2uH/vMcBs4C2HbH6Q==
X-Received: by 2002:a24:41a3:: with SMTP id b35-v6mr3395672itd.12.1531950496150;
        Wed, 18 Jul 2018 14:48:16 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id w193-v6sm2093386ita.35.2018.07.18.14.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jul 2018 14:48:15 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peterz@infradead.org, acme@kernel.org
Cc:     mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com, kim.phillips@arm.com,
        suzuki.poulosi@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/7] perf/core: Use ioctl to communicate driver configuration to kernel
Date:   Wed, 18 Jul 2018 15:48:02 -0600
Message-Id: <1531950487-24554-3-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531950487-24554-1-git-send-email-mathieu.poirier@linaro.org>
References: <1531950487-24554-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the mechanic needed for user space to send PMU specific
configuration to the kernel driver using an ioctl() command.  That way
events can keep track of options that don't fit in the perf_event_attr
structure like the selection of a CoreSight sink to use for the session.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/perf_event.h | 45 ++++++++++++++++++++++++++
 kernel/events/core.c       | 78 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1fa12887ec02..7064b513ca2b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -114,6 +114,14 @@ struct hw_perf_event_extra {
 	int		idx;	/* index in shared_regs->regs[] */
 };
 
+/*
+ * PMU driver configuration
+ */
+struct pmu_drv_config {
+	void		*config;
+	raw_spinlock_t	lock;
+};
+
 /**
  * struct hw_perf_event - performance event hardware details:
  */
@@ -178,6 +186,9 @@ struct hw_perf_event {
 	/* Last sync'ed generation of filters */
 	unsigned long			addr_filters_gen;
 
+	/* PMU driver configuration */
+	struct pmu_drv_config		drv_config;
+
 /*
  * hw_perf_event::state flags; used to track the PERF_EF_* state.
  */
@@ -447,6 +458,23 @@ struct pmu {
 	 * Filter events for PMU-specific reasons.
 	 */
 	int (*filter_match)		(struct perf_event *event); /* optional */
+
+	/*
+	 * Valiate complex PMU configuration that don't fit in the
+	 * perf_event_attr struct.  Returns a PMU specific pointer or an error
+	 * value < 0.
+	 *
+	 * As with addr_filters_validate(), runs in the context of the ioctl()
+	 * process and is not serialized with the rest of the PMU callbacks.
+	 */
+	void *(*drv_config_validate)	(struct perf_event *event,
+					 char *config_str);
+
+	/*
+	 * Release PMU specific configuration acquired by
+	 * drv_config_validate()
+	 */
+	void (*drv_config_free)		(void *drv_data);
 };
 
 enum perf_addr_filter_action_t {
@@ -1234,6 +1262,12 @@ static inline bool has_addr_filter(struct perf_event *event)
 	return event->pmu->nr_addr_filters;
 }
 
+static inline bool has_drv_config(struct perf_event *event)
+{
+	return event->pmu->drv_config_validate &&
+	       event->pmu->drv_config_free;
+}
+
 /*
  * An inherited event uses parent's filters
  */
@@ -1248,6 +1282,17 @@ perf_event_addr_filters(struct perf_event *event)
 	return ifh;
 }
 
+static inline struct pmu_drv_config *
+perf_event_get_drv_config(struct perf_event *event)
+{
+	struct pmu_drv_config *cfg = &event->hw.drv_config;
+
+	if (event->parent)
+		cfg = &event->parent->hw.drv_config;
+
+	return cfg;
+}
+
 extern void perf_event_addr_filters_sync(struct perf_event *event);
 
 extern int perf_output_begin(struct perf_output_handle *handle,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a56f10b1e13b..4892246c3af2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4410,6 +4410,7 @@ static bool exclusive_event_installable(struct perf_event *event,
 
 static void perf_addr_filters_splice(struct perf_event *event,
 				       struct list_head *head);
+static void perf_drv_config_replace(struct perf_event *event, void *drv_data);
 
 static void _free_event(struct perf_event *event)
 {
@@ -4440,6 +4441,7 @@ static void _free_event(struct perf_event *event)
 	perf_event_free_bpf_prog(event);
 	perf_addr_filters_splice(event, NULL);
 	kfree(event->addr_filters_offs);
+	perf_drv_config_replace(event, NULL);
 
 	if (event->destroy)
 		event->destroy(event);
@@ -5002,6 +5004,8 @@ static inline int perf_fget_light(int fd, struct fd *p)
 static int perf_event_set_output(struct perf_event *event,
 				 struct perf_event *output_event);
 static int perf_event_set_filter(struct perf_event *event, void __user *arg);
+static int perf_event_set_drv_config(struct perf_event *event,
+				     void __user *arg);
 static int perf_event_set_bpf_prog(struct perf_event *event, u32 prog_fd);
 static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			  struct perf_event_attr *attr);
@@ -5088,6 +5092,10 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 
 		return perf_event_modify_attr(event,  &new_attr);
 	}
+
+	case PERF_EVENT_IOC_SET_DRV_CONFIG:
+		return perf_event_set_drv_config(event, (void __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
@@ -9090,6 +9098,75 @@ static int perf_event_set_filter(struct perf_event *event, void __user *arg)
 	return ret;
 }
 
+static void perf_drv_config_replace(struct perf_event *event, void *drv_data)
+{
+	unsigned long flags;
+	void *old_drv_data;
+	struct pmu_drv_config *drv_config = &event->hw.drv_config;
+
+	if (!has_drv_config(event))
+		return;
+
+	/* Children take their configuration from their parent */
+	if (event->parent)
+		return;
+
+	/* Make sure the PMU doesn't get a handle on the data */
+	raw_spin_lock_irqsave(&drv_config->lock, flags);
+
+	old_drv_data = drv_config->config;
+	drv_config->config = drv_data;
+
+	raw_spin_unlock_irqrestore(&drv_config->lock, flags);
+
+	/* Free PMU private data allocated by pmu::drv_config_validate() */
+	event->pmu->drv_config_free(old_drv_data);
+}
+
+static int
+perf_event_process_drv_config(struct perf_event *event, char *config_str)
+{
+	int ret = -EINVAL;
+	void *drv_data;
+
+	/* Make sure ctx.mutex is held */
+	lockdep_assert_held(&event->ctx->mutex);
+
+	/* Children take their configuration from their parent */
+	if (WARN_ON_ONCE(event->parent))
+		goto out;
+
+	drv_data = event->pmu->drv_config_validate(event, config_str);
+	if (IS_ERR(drv_data)) {
+		ret = PTR_ERR(drv_data);
+		goto out;
+	}
+
+	perf_drv_config_replace(event, drv_data);
+
+	ret = 0;
+out:
+	return ret;
+}
+
+static int perf_event_set_drv_config(struct perf_event *event, void __user *arg)
+{
+	int ret = -EINVAL;
+	char *config_str;
+
+	if (!has_drv_config(event))
+		return ret;
+
+	config_str = strndup_user(arg, PAGE_SIZE);
+	if (IS_ERR(config_str))
+		return PTR_ERR(config_str);
+
+	ret = perf_event_process_drv_config(event, config_str);
+
+	kfree(config_str);
+	return ret;
+}
+
 /*
  * hrtimer based swevent callback
  */
@@ -10019,6 +10096,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	if (attr->freq && attr->sample_freq)
 		hwc->sample_period = 1;
 	hwc->last_period = hwc->sample_period;
+	raw_spin_lock_init(&hwc->drv_config.lock);
 
 	local64_set(&hwc->period_left, hwc->sample_period);
 
-- 
2.7.4

