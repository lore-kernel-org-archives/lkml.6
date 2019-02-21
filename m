Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7267CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4562147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lips2aEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfBUL34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:29:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38260 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfBUL3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:29:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so14035312plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 03:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F3LLSRDQOqGMBHSWQuz4LBphwjqYjeDRnqRsCnlMxjs=;
        b=Lips2aEKIKK1upuax5qhmiKCJgKL1LmwUbdV2ZR/oYjvtu0xU/X+cH6gi5VFgepDbQ
         JL4mezqlDB3Fe967wMqevBiYFtCikh94TjVeXAz5BInuPBchESHQEvi19AGoFOh22Wzb
         q/l+RID/abLT0wMBXKa1XYzlXlmh7hg9vADcLN/K1sdclHx5R5Lyu6Qw1Isyp2jAMCpp
         IpMw6pzWKQgw1vEw+W5jmzcp01JnHIRhPk7k2mqWKrT8+Q9v9OllnX5DoiFEuIkKXzer
         NadrUK39mhkOfGUQ1nRqJ5eK/yCoQagwKBIIKixm5PZ1r8sY5TfwpSRXTXY3X67uJMl3
         Jr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F3LLSRDQOqGMBHSWQuz4LBphwjqYjeDRnqRsCnlMxjs=;
        b=OZ8d8ekTMugM1faTuwEePn/t2MZkyL7sf8vxwEz1jZ4zXc5t5cP4UianQhp/EBRWEN
         4Rg8Ir6zUZuCvskyugWvqrDQDeL3mMATIXCRZ+HobSFetdICK+i7RJZFgcObMAjGVks+
         cjZ8HCR86KkypyaVXa1DuoImbl9B3w2uGOTlc0tARPwSQCzMjSDFBG0TG9AJjFtsMcNW
         mLXKYKu1QcKP0y7dQPtYeZna5d4OWzuLSgcM25128lFATYm46+bd4tg78PQJ4lWXkrCz
         A043G0Pk5NFJEjXvvY7b6hG2WZP41h8GttmR3iStRzUdYz/+wrBdzdscTV0sAGhzZKXz
         hpHg==
X-Gm-Message-State: AHQUAuaIi2K/ZhhePdAdiFYty+euTD6tD/NieM0PMWApaOVwGrxJoOox
        IjmDWVnM/qklzf+z4O4FACfesA==
X-Google-Smtp-Source: AHgI3IYQI1vZwH0/D2uaCGv/IbNySVLhByJuxrz7BnCWO8skoC/13jb1DZiMQ3u67j7i9skRDQ3fuA==
X-Received: by 2002:a17:902:8f82:: with SMTP id z2mr3003556plo.163.1550748592835;
        Thu, 21 Feb 2019 03:29:52 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id l64sm12733460pga.87.2019.02.21.03.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:29:52 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org,
        juri.lelli@gmail.com, Qais.Yousef@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/5] PM / QOS: Pass request type to dev_pm_qos_read_value()
Date:   Thu, 21 Feb 2019 16:59:28 +0530
Message-Id: <fe4b74ff20d96586118c5d501fe968b0bc20eb91.1550748118.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1550748118.git.viresh.kumar@linaro.org>
References: <cover.1550748118.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use dev_pm_qos_read_value(), and other internal routines to
it, to read values for different QoS requests, pass request type as a
parameter to these routines.

For now, it only supports resume-latency request type.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/power/pm_qos_interface.txt |  2 +-
 drivers/base/power/domain_governor.c     |  4 +--
 drivers/base/power/qos.c                 | 10 +++---
 drivers/base/power/runtime.c             |  2 +-
 drivers/cpuidle/governor.c               |  2 +-
 include/linux/pm_qos.h                   | 41 +++++++++++++++++-------
 6 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/Documentation/power/pm_qos_interface.txt b/Documentation/power/pm_qos_interface.txt
index ec7d662d1707..cfcb1df39799 100644
--- a/Documentation/power/pm_qos_interface.txt
+++ b/Documentation/power/pm_qos_interface.txt
@@ -123,7 +123,7 @@ Will remove the element.  After removal it will update the aggregate target and
 call the notification trees if the target was changed as a result of removing
 the request.
 
-s32 dev_pm_qos_read_value(device):
+s32 dev_pm_qos_read_value(device, type):
 Returns the aggregated value for a given device's constraints list.
 
 enum pm_qos_flags_status dev_pm_qos_flags(device, mask)
diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 99896fbf18e4..c36925adba69 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -32,7 +32,7 @@ static int dev_update_qos_constraint(struct device *dev, void *data)
 		 * take its current PM QoS constraint (that's the only thing
 		 * known at this point anyway).
 		 */
-		constraint_ns = dev_pm_qos_read_value(dev);
+		constraint_ns = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
 		constraint_ns *= NSEC_PER_USEC;
 	}
 
@@ -65,7 +65,7 @@ static bool default_suspend_ok(struct device *dev)
 	td->constraint_changed = false;
 	td->cached_suspend_ok = false;
 	td->effective_constraint_ns = 0;
-	constraint_ns = __dev_pm_qos_read_value(dev);
+	constraint_ns = __dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
 
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 49672f9dc8c4..fda7266970e9 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -96,27 +96,29 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_flags);
 /**
  * __dev_pm_qos_read_value - Get PM QoS constraint for a given device.
  * @dev: Device to get the PM QoS constraint value for.
+ * @type: QoS request type.
  *
  * This routine must be called with dev->power.lock held.
  */
-s32 __dev_pm_qos_read_value(struct device *dev)
+s32 __dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type)
 {
 	lockdep_assert_held(&dev->power.lock);
 
-	return dev_pm_qos_raw_read_value(dev);
+	return dev_pm_qos_raw_read_value(dev, type);
 }
 
 /**
  * dev_pm_qos_read_value - Get PM QoS constraint for a given device (locked).
  * @dev: Device to get the PM QoS constraint value for.
+ * @type: QoS request type.
  */
-s32 dev_pm_qos_read_value(struct device *dev)
+s32 dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type)
 {
 	unsigned long flags;
 	s32 ret;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
-	ret = __dev_pm_qos_read_value(dev);
+	ret = __dev_pm_qos_read_value(dev, type);
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
 	return ret;
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 04407d9f76fd..997cd420accc 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -267,7 +267,7 @@ static int rpm_check_suspend_allowed(struct device *dev)
 	    || (dev->power.request_pending
 			&& dev->power.request == RPM_REQ_RESUME))
 		retval = -EAGAIN;
-	else if (__dev_pm_qos_read_value(dev) == 0)
+	else if (__dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY) == 0)
 		retval = -EPERM;
 	else if (dev->power.runtime_status == RPM_SUSPENDED)
 		retval = 1;
diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
index bb93e5cf6a4a..251d3ef4a1e5 100644
--- a/drivers/cpuidle/governor.c
+++ b/drivers/cpuidle/governor.c
@@ -109,7 +109,7 @@ int cpuidle_governor_latency_req(unsigned int cpu)
 {
 	int global_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
 	struct device *device = get_cpu_device(cpu);
-	int device_req = dev_pm_qos_raw_read_value(device);
+	int device_req = dev_pm_qos_raw_read_value(device, DEV_PM_QOS_RESUME_LATENCY);
 
 	return device_req < global_req ? device_req : global_req;
 }
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 1f4d456e8fff..55814d48c39c 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -139,8 +139,8 @@ s32 pm_qos_read_value(struct pm_qos_constraints *c);
 #ifdef CONFIG_PM
 enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev, s32 mask);
 enum pm_qos_flags_status dev_pm_qos_flags(struct device *dev, s32 mask);
-s32 __dev_pm_qos_read_value(struct device *dev);
-s32 dev_pm_qos_read_value(struct device *dev);
+s32 __dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type);
+s32 dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type);
 int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
 			   enum dev_pm_qos_req_type type, s32 value);
 int dev_pm_qos_update_request(struct dev_pm_qos_request *req, s32 new_value);
@@ -176,11 +176,19 @@ static inline s32 dev_pm_qos_requested_flags(struct device *dev)
 	return dev->power.qos->flags_req->data.flr.flags;
 }
 
-static inline s32 dev_pm_qos_raw_read_value(struct device *dev)
+static inline s32 dev_pm_qos_raw_read_value(struct device *dev,
+					    enum dev_pm_qos_req_type type)
 {
-	return IS_ERR_OR_NULL(dev->power.qos) ?
-		PM_QOS_RESUME_LATENCY_NO_CONSTRAINT :
-		pm_qos_read_value(&dev->power.qos->resume_latency);
+	struct dev_pm_qos *qos = dev->power.qos;
+
+	switch (type) {
+	case DEV_PM_QOS_RESUME_LATENCY:
+		return IS_ERR_OR_NULL(qos) ? PM_QOS_RESUME_LATENCY_NO_CONSTRAINT
+			: pm_qos_read_value(&qos->resume_latency);
+	default:
+		WARN_ON(1);
+		return 0;
+	}
 }
 #else
 static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev,
@@ -189,10 +197,6 @@ static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev,
 static inline enum pm_qos_flags_status dev_pm_qos_flags(struct device *dev,
 							s32 mask)
 			{ return PM_QOS_FLAGS_UNDEFINED; }
-static inline s32 __dev_pm_qos_read_value(struct device *dev)
-			{ return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT; }
-static inline s32 dev_pm_qos_read_value(struct device *dev)
-			{ return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT; }
 static inline int dev_pm_qos_add_request(struct device *dev,
 					 struct dev_pm_qos_request *req,
 					 enum dev_pm_qos_req_type type,
@@ -245,10 +249,23 @@ static inline s32 dev_pm_qos_requested_resume_latency(struct device *dev)
 	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
 }
 static inline s32 dev_pm_qos_requested_flags(struct device *dev) { return 0; }
-static inline s32 dev_pm_qos_raw_read_value(struct device *dev)
+
+static inline s32 dev_pm_qos_raw_read_value(struct device *dev,
+					    enum dev_pm_qos_req_type type)
 {
-	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+	switch type {
+	case DEV_PM_QOS_RESUME_LATENCY:
+		return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+	default:
+		WARN_ON(1);
+		return 0;
+	}
 }
+
+static inline s32 __dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type)
+			{ return dev_pm_qos_raw_read_value(dev, type); }
+static inline s32 dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type)
+			{ return dev_pm_qos_raw_read_value(dev, type); }
 #endif
 
 #endif
-- 
2.21.0.rc0.269.g1a574e7a288b

