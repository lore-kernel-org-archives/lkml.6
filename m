Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB15C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE90208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJZHn5tH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE90208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeJRRpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:45:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45372 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeJRRpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:45:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id f17-v6so1148734wrs.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 02:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TTrXFYk6ckWhe/RcG7Y9fVDARiuLwZVJhNpwNwTgiU0=;
        b=hJZHn5tHDaDoyKrLelihmEpzmPAPjfdEf6A2L/hsysJxKF0iqKhdyXdg3WkKcI99+s
         YLZlNQzmH05D1BghCDDIOZCR8h16PMBeiHf9VMeUhxhgCiyVjI7EMvmFLx4VZcfDlH86
         kSvhketa4W1txJaQWqaDgFc/icFzXWxzBDNlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TTrXFYk6ckWhe/RcG7Y9fVDARiuLwZVJhNpwNwTgiU0=;
        b=a6NaySw0J+VvFYvDb7oq9bIitWFtEW4bOMzU8qUeB+VRKMKf7FRydO7pCLM7sqvzbf
         SZbI3IB8oX1yDL5dxaoEZC/arBbDMNbTBgrOkpGA8uMfckDoquGcl3JMb6o7wbOeFlKn
         vETtj3kY146AtlakqXquOMOy0g/xllCJeumwj2Cxj36YuOGYVuFj30CFIZtK+cUygE2N
         ZAbXakwX07Y50Shkk3ncmw70n2mf0IeNwzbpCIrynroWMlWGJ4zKS3ilfa71Oh5sFnOU
         NU/ctEWcM/e/6rJkio/e+g0nEdGrTMaEMDYol5zGz/PRGTN7ztzRtVOM1AFFzdcDG6os
         zO1Q==
X-Gm-Message-State: ABuFfojmmdbIzToSgnScYcpQoSRHu2qYxebpGPmgNyZ1mRicFdUrDRMV
        hWIsMFqZr+CyHJRstkJUAoVSAA==
X-Google-Smtp-Source: ACcGV62o/Pu7I637SxDclrz8kqSP0pAl03HP4JxXfDx4RKRBRUiA4LjCPQQaq7FzkBNNxG367ptLqQ==
X-Received: by 2002:a05:6000:12c5:: with SMTP id l5mr27112400wrx.215.1539855926590;
        Thu, 18 Oct 2018 02:45:26 -0700 (PDT)
Received: from localhost.localdomain (77.65.136.77.rev.sfr.net. [77.136.65.77])
        by smtp.gmail.com with ESMTPSA id 195-v6sm4321756wmx.21.2018.10.18.02.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 02:45:25 -0700 (PDT)
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
Subject: [PATCH V2 2/2] sched/cpufreq: Add the SPDX tags
Date:   Thu, 18 Oct 2018 11:44:15 +0200
Message-Id: <1539855869-13524-2-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539855869-13524-1-git-send-email-daniel.lezcano@linaro.org>
References: <CAJZ5v0iALqLw+Y_tKw86dh2oxnmvALhoVJxEcWWA+x1jU3GjdA@mail.gmail.com>
 <1539855869-13524-1-git-send-email-daniel.lezcano@linaro.org>
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

