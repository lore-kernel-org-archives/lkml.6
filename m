Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC10C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75E720832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JvaGhXCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75E720832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbeK2JE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:04:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37079 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbeK2JE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:04:28 -0500
Received: by mail-pg1-f196.google.com with SMTP id 80so10109966pge.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 14:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9ArLK6lkyYJGZT2BBz1S2MAD3wdLFqaTbbWFM/1RhoE=;
        b=JvaGhXCakBbgKtMuu7Am5WMIKyL1OD2YnkifjxC6dd5PMwaDyoS43382toposAuZ7F
         7bZkjfvqkB2o70f5BnoJI6GvdJ634Yi8Fc4/P8AXBwzcJbS3j8tj7iZ+iHWsjnoC4he3
         roYh+HXd59ZaRQ7y9WJ64ySRMP0dCOyTh3iZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9ArLK6lkyYJGZT2BBz1S2MAD3wdLFqaTbbWFM/1RhoE=;
        b=I9XfabEI6He3j3r+ZyFGzykPMTiryXwMTPoiAuqs0BcbnWmjpHYtRdtTesNckWeS0J
         22rKkH/kgpcPN/nqMnhE00d39xSvpVh9skeIhawGpP6pAmFhmibjSUT4YpQKQpmiWEBC
         8/r5L3UCvSEyUiyy09t37gS+hLwe6fY4GIBKgo+iLGqVDI3GqlfGMDIe5Uo9eTpCaNhM
         ZpBEk4vGrsotvSUTTWTNMsg8YuA4mKhu3NJ7j7sD+AvZ3Oq2i4bKg6vNhW7x64Bh/aLs
         Yx9z5H4PelSDKvVRc4Y/RGDh5DkRwGv+lrdQDlB4eVqXOujTNKtTld1D6MIOnqtkCAyG
         DLCw==
X-Gm-Message-State: AA+aEWZP73KN6eSzxWT7rPDZFlzfk5aJBraIUt0T3LZ1MI0+KabFQpAq
        Gug0ny/t7vIXJjS6yePdMW9XqA==
X-Google-Smtp-Source: AFSGD/WX8mg2zVz0dQESUQF17S7pzkAkjFnynFmyFVZK1sdqJou+E2d1RI98Ta1GWAPEzibgqwnplg==
X-Received: by 2002:a65:41c2:: with SMTP id b2mr34325372pgq.67.1543442483779;
        Wed, 28 Nov 2018 14:01:23 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 12sm8698051pgd.35.2018.11.28.14.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:01:23 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com
Cc:     tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        will.deacon@arm.com, mark.rutland@arm.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ast@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com, suzuki.poulosi@arm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/6] perf/core: Use ioctl to communicate driver configuration to kernel
Date:   Wed, 28 Nov 2018 15:01:14 -0700
Message-Id: <1543442478-31465-3-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543442478-31465-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543442478-31465-1-git-send-email-mathieu.poirier@linaro.org>
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
 include/linux/perf_event.h | 38 +++++++++++++++++++++++++
 kernel/events/core.c       | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 53c500f0ca79..629fa1e1d6cf 100644
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
@@ -447,6 +458,17 @@ struct pmu {
 	 * Filter events for PMU-specific reasons.
 	 */
 	int (*filter_match)		(struct perf_event *event); /* optional */
+
+	/*
+	 * Validate complex PMU configuration that don't fit in the
+	 * perf_event_attr struct.  Returns a PMU specific pointer or an error
+	 * value < 0.
+	 *
+	 * As with addr_filters_validate(), runs in the context of the ioctl()
+	 * process and is not serialized with the rest of the PMU callbacks.
+	 */
+	void *(*drv_config_validate)	(struct perf_event *event,
+					 char *config_str);
 };
 
 enum perf_addr_filter_action_t {
@@ -1235,6 +1257,11 @@ static inline bool has_addr_filter(struct perf_event *event)
 	return event->pmu->nr_addr_filters;
 }
 
+static inline bool has_drv_config(struct perf_event *event)
+{
+	return event->pmu->drv_config_validate;
+}
+
 /*
  * An inherited event uses parent's filters
  */
@@ -1249,6 +1276,17 @@ perf_event_addr_filters(struct perf_event *event)
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
index 84530ab358c3..a76c0ce39c4e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5003,6 +5003,8 @@ static inline int perf_fget_light(int fd, struct fd *p)
 static int perf_event_set_output(struct perf_event *event,
 				 struct perf_event *output_event);
 static int perf_event_set_filter(struct perf_event *event, void __user *arg);
+static int perf_event_set_drv_config(struct perf_event *event,
+				     void __user *arg);
 static int perf_event_set_bpf_prog(struct perf_event *event, u32 prog_fd);
 static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			  struct perf_event_attr *attr);
@@ -5089,6 +5091,10 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 
 		return perf_event_modify_attr(event,  &new_attr);
 	}
+
+	case PERF_EVENT_IOC_SET_DRV_CONFIG:
+		return perf_event_set_drv_config(event, (void __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
@@ -9128,6 +9134,68 @@ static int perf_event_set_filter(struct perf_event *event, void __user *arg)
 	return ret;
 }
 
+static void perf_drv_config_replace(struct perf_event *event, void *drv_data)
+{
+	unsigned long flags;
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
+	drv_config->config = drv_data;
+	raw_spin_unlock_irqrestore(&drv_config->lock, flags);
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
@@ -10052,6 +10120,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	if (attr->freq && attr->sample_freq)
 		hwc->sample_period = 1;
 	hwc->last_period = hwc->sample_period;
+	raw_spin_lock_init(&hwc->drv_config.lock);
 
 	local64_set(&hwc->period_left, hwc->sample_period);
 
-- 
2.7.4

