Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B34DC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70D62184E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C4nqGzh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388361AbeLQRV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:21:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46676 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388315AbeLQRVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:21:53 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so6418896ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 09:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BBqRtwO6PGFlctrxGALj04LHSsu+aeiHiAedSoB+rfE=;
        b=C4nqGzh5cPKSL5/IPhN70S1CecaokCmGiC2UXWLUIX8Jb+zGXeG8cV3FViYapKUt9P
         JtXBFdraKVQej2cL9Lsa2nSV/XFm0HcIRBNqSIoye+CvqslcB3S9Hu7O2Q+1Ljkw7MqG
         +LqxmQIWHJywbSjjqIz9NvNmGwKFJsf96HVaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BBqRtwO6PGFlctrxGALj04LHSsu+aeiHiAedSoB+rfE=;
        b=gsWhQ/eebuDS2Nw+92rS64u54cmtSG8+WXQTP/rh6+FaLbJi0nRHms91oAu+034bhN
         sNw4BbUg0laO7YzKRvOLZ1gp2zK/uXOsW7pvv42sd4UdYDFIvf8Q6BIwYBcxeYCTl52K
         iDGLElcNcDT2QRkZqv0/oiTDAqEWfSFVheST5saLo2nyyHi7pXYe3ZiXvG3og9JP7ruy
         e43TSR5m0HZrooS7LpUzuJ4ig1tDhwl3kxVYzCSdQ3YPm3+WBHSys7VAqt4ih/z4W4JK
         OjQ7SNkKbuGCjNIcAKnT1b+PEyCdUpJyenrDKgFU4czzMeh282k9wryHasx8jZXfb5RS
         2fwQ==
X-Gm-Message-State: AA+aEWYojb9XL3he1GUIOge4jeTYXe2MHcYHTGD0iEEJn0lznc75+Ctw
        1246HmdkzGW8n6RiZPWz9vcxig==
X-Google-Smtp-Source: AFSGD/VQdQ5g0qC8bZxRHPUXsx85VHoFCrYhPxSv0pYoQzQQtJHyVLA+jZdwJzZiMX/6Y9UnrBEAxQ==
X-Received: by 2002:a17:902:128c:: with SMTP id g12mr12797936pla.146.1545067312998;
        Mon, 17 Dec 2018 09:21:52 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j6sm20526648pfg.126.2018.12.17.09.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 09:21:52 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org
Cc:     mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        suzuki.poulosi@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v5 2/6] perf/core: Use ioctl to communicate driver configuration to kernel
Date:   Mon, 17 Dec 2018 10:21:42 -0700
Message-Id: <1545067306-31687-3-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
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
 include/linux/perf_event.h | 38 ++++++++++++++++++++++++++
 kernel/events/core.c       | 67 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 53c500f0ca79..8e69b7e309e7 100644
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
+					 u64 value);
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
index 84530ab358c3..af7a53c97744 100644
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
@@ -9128,6 +9134,66 @@ static int perf_event_set_filter(struct perf_event *event, void __user *arg)
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
+perf_event_process_drv_config(struct perf_event *event, u64 value)
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
+	drv_data = event->pmu->drv_config_validate(event, value);
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
+	int ret;
+	u64 value;
+
+	if (!has_drv_config(event))
+		return -EINVAL;
+
+	if (copy_from_user(&value, arg, sizeof(value)))
+		return -EFAULT;
+
+	ret = perf_event_process_drv_config(event, value);
+
+	return ret;
+}
+
 /*
  * hrtimer based swevent callback
  */
@@ -10052,6 +10118,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	if (attr->freq && attr->sample_freq)
 		hwc->sample_period = 1;
 	hwc->last_period = hwc->sample_period;
+	raw_spin_lock_init(&hwc->drv_config.lock);
 
 	local64_set(&hwc->period_left, hwc->sample_period);
 
-- 
2.7.4

