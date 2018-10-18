Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5059CECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B822083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e6FL8hX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B822083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeJRRgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:36:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33463 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbeJRRgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:36:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id y140-v6so1439277wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 02:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TTrXFYk6ckWhe/RcG7Y9fVDARiuLwZVJhNpwNwTgiU0=;
        b=e6FL8hX1cB6XxsO0KhIGhDkGQouoKIOXVP7ig0ZHtwBymoQE+/FZBSmKm01fDK9mZ8
         FW4DxnRZ+HRKO6Pa/uhtcmsg/S219++vouRPVmFba571usJTcKFPTtMZPAdjVrirxjKv
         crdezw8loky+0rc7zdR8FhWHzg8yr4vUImzVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TTrXFYk6ckWhe/RcG7Y9fVDARiuLwZVJhNpwNwTgiU0=;
        b=OATxMxCQWg4fq/O3+qU4I4H1sWI1Q6pj3t/JT+4en/rq/oFzSELIyYAVrvF4IcwKSd
         pZIISb9JzzdiZ3mDe993ZTBy9VlIHkZRARF14T6Jv+OD/cLWj5I5vs5jjFJK5ZMb0BWU
         KMuFc/VAT2dOU6g5LFIB5+IV5J0ZOrB9v7jYjg9IkpoGM8csHBrdisJRtKl3BELdHbVn
         003l2Hlb6OlvJXgkiOK1EPSCIjtlC5zpTfkvoCSW8IauMh+iS1by82C0+0kVh1dsDouR
         LI6a+untnWmW2CqBM3CEAEMXES5kxE1FNCHSZg2qvtCqWuXxYj17tPBOsveUg9bDGlTM
         a1+Q==
X-Gm-Message-State: ABuFfoh05Slzo5X6fPRVjo8lFRoPqQQQff1iRGxSFso7XtX2PGk7+IZ1
        4FzSQgbfVvt18NJxv9/df23tqg==
X-Google-Smtp-Source: ACcGV612ZA/uuqL8nCzldmjyi9TQQv7oXSVRlV/D033Z5H6ujuxlgLBExIuRXGN6qpQP6+qEuLcP+w==
X-Received: by 2002:a1c:4a:: with SMTP id 71-v6mr6278527wma.96.1539855401885;
        Thu, 18 Oct 2018 02:36:41 -0700 (PDT)
Received: from localhost.localdomain (77.65.136.77.rev.sfr.net. [77.136.65.77])
        by smtp.gmail.com with ESMTPSA id 6-v6sm811323wrb.95.2018.10.18.02.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 02:36:41 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, mingo@kernel.org
Cc:     thara.gopinath@linaro.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, rui.zhang@intel.com,
        gregkh@linuxfoundation.org, viresh.kumar@linaro.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        edubezval@gmail.com, linux-pm@vger.kernel.org,
        quentin.perret@arm.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH 2/2] sched/cpufreq: Add the SPDX tags
Date:   Thu, 18 Oct 2018 11:35:59 +0200
Message-Id: <1539855372-11472-2-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539855372-11472-1-git-send-email-daniel.lezcano@linaro.org>
References: <CAJZ5v0iALqLw+Y_tKw86dh2oxnmvALhoVJxEcWWA+x1jU3GjdA@mail.gmail.com>
 <1539855372-11472-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPDX tags are not present in core.c and metrics.c.

Replace the license description by the SPDX tags.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/sched/cpufreq/core.c    | 4 +---
 kernel/sched/cpufreq/metrics.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/cpufreq/core.c b/kernel/sched/cpufreq/core.c
index 8c17a63..7a1400c 100644
--- a/kernel/sched/cpufreq/core.c
+++ b/kernel/sched/cpufreq/core.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Scheduler code and data structures related to cpufreq.
  *
  * Copyright (C) 2016, Intel Corporation
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include "../sched.h"
 
diff --git a/kernel/sched/cpufreq/metrics.c b/kernel/sched/cpufreq/metrics.c
index 597df47..9083a70 100644
--- a/kernel/sched/cpufreq/metrics.c
+++ b/kernel/sched/cpufreq/metrics.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * CPUFreq governor based on scheduler-provided CPU utilization data.
  *
  * Copyright (C) 2016, Intel Corporation
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-- 
2.7.4

