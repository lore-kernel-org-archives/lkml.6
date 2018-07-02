Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF051C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4CE20C10
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TsIEZLVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4CE20C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932399AbeGBWeC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:34:02 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39728 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932338AbeGBWdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:33:46 -0400
Received: by mail-pl0-f65.google.com with SMTP id s24-v6so8581818plq.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 15:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q++a8pnM3vWZhHlmb65vGbt0ms5aoh48STg7RZti8Mk=;
        b=TsIEZLVFXhRARBzI94DbO92h64u/7wC3/2MCEunX486sjOmqxce56QlxuOXVCQyw1s
         cHDmKoZrOYg1z0B0fAYCtvclXfSx4ivtEitkKUmzknwWz4IQ094xi83UNvQHtscVFWeL
         7p3w1APQ+OlYxXibjMxK9jEzHxKTKe9Oc66m4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q++a8pnM3vWZhHlmb65vGbt0ms5aoh48STg7RZti8Mk=;
        b=s6V9t6TWCcciU3kUdF13TzLHG3E4bCuAqBBnMk6bt9GdLBLcdtgu9D5YHfzxNWQSHJ
         zgJjd5srDFI+Sq/sqHAf/0tMshw/LliCkM/klMZrjLFcYl3qmm6Alcs0KMvK3YjD1JGO
         ais52/cHetqZfq05dmUjNlfhdSG9k30Y+bprJqtQAVtxEceHIywjUHTxKBJA9FxclGsI
         yPaFi+O4kT/coLPEPdGfYfhqO4s1tE04piLwWw+vjgVyWt2mjA+v9ODaIXbu29rfYzG1
         +yvqY8WP2PyUI6ZKE+Ww5ljbOfUNHyfjqrpDIQ0Gz/q7SBxeCKTI8zNRp2o4xSNJZcUl
         Qseg==
X-Gm-Message-State: APt69E3FWrZNm1Wwd2R3zdulQorgNa9PZci1bf7AMRiVv3AVN2OV31pE
        rMyG6mFp7K1wHhi94LgEy2D0Tw==
X-Google-Smtp-Source: ADUXVKKiImJD9nc7j8peP0IKMmLt7UeaRucQ+EFgga0VGmoN3izjq+PFZVEszzRc2OFmJAzsHacCPQ==
X-Received: by 2002:a17:902:1127:: with SMTP id d36-v6mr27855681pla.267.1530570824834;
        Mon, 02 Jul 2018 15:33:44 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id p11-v6sm21764132pgu.16.2018.07.02.15.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 15:33:43 -0700 (PDT)
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
Subject: [PATCH 5/6] perf/core: Use ioctl to communicate driver configuration to kernel
Date:   Mon,  2 Jul 2018 16:33:29 -0600
Message-Id: <1530570810-28929-6-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
References: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch follows what has been done for filters by adding an ioctl()
option to communicate to the kernel arbitrary PMU specific configuration
that don't fit in the conventional struct perf_event_attr to the kernel.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/perf_event.h |  54 ++++++++++++++++++++++
 kernel/events/core.c       | 110 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 4d9c8f30ca6c..6e06b63c262f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -178,6 +178,12 @@ struct hw_perf_event {
 	/* Last sync'ed generation of filters */
 	unsigned long			addr_filters_gen;
 
+	/* PMU driver configuration */
+	void				*drv_config;
+
+	/* Last sync'ed generation of driver config */
+	unsigned long			drv_config_gen;
+
 /*
  * hw_perf_event::state flags; used to track the PERF_EF_* state.
  */
@@ -447,6 +453,26 @@ struct pmu {
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
+	/* Synchronize PMU driver configuration */
+	void (*drv_config_sync)		(struct perf_event *event);
+
+	/*
+	 * Release PMU specific configuration acquired by
+	 * drv_config_validate()
+	 */
+	void (*drv_config_free)		(void *drv_data);
 };
 
 enum perf_addr_filter_action_t {
@@ -489,6 +515,11 @@ struct perf_addr_filters_head {
 	unsigned int		nr_file_filters;
 };
 
+struct perf_drv_config {
+	void		*drv_config;
+	raw_spinlock_t	lock;
+};
+
 /**
  * enum perf_event_state - the states of a event
  */
@@ -668,6 +699,10 @@ struct perf_event {
 	unsigned long			*addr_filters_offs;
 	unsigned long			addr_filters_gen;
 
+	/* PMU driver specific configuration */
+	struct perf_drv_config		drv_config;
+	unsigned long			drv_config_gen;
+
 	void (*destroy)(struct perf_event *);
 	struct rcu_head			rcu_head;
 
@@ -1234,6 +1269,13 @@ static inline bool has_addr_filter(struct perf_event *event)
 	return event->pmu->nr_addr_filters;
 }
 
+static inline bool has_drv_config(struct perf_event *event)
+{
+	return event->pmu->drv_config_validate &&
+	       event->pmu->drv_config_sync &&
+	       event->pmu->drv_config_free;
+}
+
 /*
  * An inherited event uses parent's filters
  */
@@ -1248,7 +1290,19 @@ perf_event_addr_filters(struct perf_event *event)
 	return ifh;
 }
 
+static inline struct perf_drv_config *
+perf_event_get_drv_config(struct perf_event *event)
+{
+	struct perf_drv_config *cfg = &event->drv_config;
+
+	if (event->parent)
+		cfg = &event->parent->drv_config;
+
+	return cfg;
+}
+
 extern void perf_event_addr_filters_sync(struct perf_event *event);
+extern void perf_event_drv_config_sync(struct perf_event *event);
 
 extern int perf_output_begin(struct perf_output_handle *handle,
 			     struct perf_event *event, unsigned int size);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f0434a9951a..701839866789 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2829,6 +2829,29 @@ void perf_event_addr_filters_sync(struct perf_event *event)
 }
 EXPORT_SYMBOL_GPL(perf_event_addr_filters_sync);
 
+/*
+ * PMU driver configuration works the same way as filter management above,
+ * but without the need to deal with memory mapping.  Driver configuration
+ * arrives through the SET_DRV_CONFIG ioctl() where it is validated and applied
+ * to the event.  When the PMU is ready it calls perf_event_drv_config_sync() to
+ * bring the configuration information within reach of the PMU.
+ */
+void perf_event_drv_config_sync(struct perf_event *event)
+{
+	struct perf_drv_config *drv_config = perf_event_get_drv_config(event);
+
+	if (!has_drv_config(event))
+		return;
+
+	raw_spin_lock(&drv_config->lock);
+	if (event->drv_config_gen != event->hw.drv_config_gen) {
+		event->pmu->drv_config_sync(event);
+		event->hw.drv_config_gen = event->drv_config_gen;
+	}
+	raw_spin_unlock(&drv_config->lock);
+}
+EXPORT_SYMBOL_GPL(perf_event_drv_config_sync);
+
 static int _perf_event_refresh(struct perf_event *event, int refresh)
 {
 	/*
@@ -4410,6 +4433,7 @@ static bool exclusive_event_installable(struct perf_event *event,
 
 static void perf_addr_filters_splice(struct perf_event *event,
 				       struct list_head *head);
+static void perf_drv_config_splice(struct perf_event *event, void *drv_data);
 
 static void _free_event(struct perf_event *event)
 {
@@ -4440,6 +4464,7 @@ static void _free_event(struct perf_event *event)
 	perf_event_free_bpf_prog(event);
 	perf_addr_filters_splice(event, NULL);
 	kfree(event->addr_filters_offs);
+	perf_drv_config_splice(event, NULL);
 
 	if (event->destroy)
 		event->destroy(event);
@@ -5002,6 +5027,8 @@ static inline int perf_fget_light(int fd, struct fd *p)
 static int perf_event_set_output(struct perf_event *event,
 				 struct perf_event *output_event);
 static int perf_event_set_filter(struct perf_event *event, void __user *arg);
+static int perf_event_set_drv_config(struct perf_event *event,
+				     void __user *arg);
 static int perf_event_set_bpf_prog(struct perf_event *event, u32 prog_fd);
 static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			  struct perf_event_attr *attr);
@@ -5088,6 +5115,10 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 
 		return perf_event_modify_attr(event,  &new_attr);
 	}
+
+	case PERF_EVENT_IOC_SET_DRV_CONFIG:
+		return perf_event_set_drv_config(event, (void __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
@@ -9086,6 +9117,85 @@ static int perf_event_set_filter(struct perf_event *event, void __user *arg)
 	return ret;
 }
 
+static void perf_drv_config_splice(struct perf_event *event, void *drv_data)
+{
+	unsigned long flags;
+	void *old_drv_data;
+
+	if (!has_drv_config(event))
+		return;
+
+	/* Children take their configuration from their parent */
+	if (event->parent)
+		return;
+
+	raw_spin_lock_irqsave(&event->drv_config.lock, flags);
+
+	old_drv_data = event->drv_config.drv_config;
+	event->drv_config.drv_config = drv_data;
+
+	raw_spin_unlock_irqrestore(&event->drv_config.lock, flags);
+
+	event->pmu->drv_config_free(old_drv_data);
+}
+
+static void perf_event_drv_config_apply(struct perf_event *event)
+{
+	unsigned long flags;
+	struct perf_drv_config *drv_config = perf_event_get_drv_config(event);
+
+	/* Notify event that a new configuration is available */
+	raw_spin_lock_irqsave(&drv_config->lock, flags);
+	event->drv_config_gen++;
+	raw_spin_unlock_irqrestore(&drv_config->lock, flags);
+}
+
+static int
+perf_event_process_drv_config(struct perf_event *event, char *config_str)
+{
+	int ret = -EINVAL;
+	void *drv_data;
+
+	/* Make sure ctx.mutex it held */
+	lockdep_assert_held(&event->ctx->mutex);
+
+	/* Children take their configuration from their parent */
+	if (WARN_ON_ONCE(event->parent))
+		goto out;
+
+	drv_data = event->pmu->drv_config_validate(event, config_str);
+	if (!drv_data)
+		goto out;
+	if (IS_ERR(drv_data)) {
+		ret = PTR_ERR(drv_data);
+		goto out;
+	}
+
+	perf_drv_config_splice(event, drv_data);
+
+	perf_event_for_each_child(event, perf_event_drv_config_apply);
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
+	config_str = strndup_user(arg, PAGE_SIZE);
+	if (IS_ERR(config_str))
+		return PTR_ERR(config_str);
+
+	if (has_drv_config(event))
+		ret = perf_event_process_drv_config(event, config_str);
+
+	kfree(config_str);
+	return ret;
+}
+
 /*
  * hrtimer based swevent callback
  */
-- 
2.7.4

