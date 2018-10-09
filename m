Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D564AECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932C9214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aFYhAl95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932C9214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeJIXm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:42:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35867 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbeJIXm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:42:58 -0400
Received: by mail-qt1-f195.google.com with SMTP id u34-v6so2301885qth.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k9t4ZQyhj3UHB2vpFiS96ld6Wm363DNdyAeKB8jO/D8=;
        b=aFYhAl95BW4L9QN7e/W030cStVJJKryh0zaKjg8BqMNvfm+X6GuHEX527vtwOs3Ldh
         bz9Vaf0vkJ7P/PAPDf/xA501Z1tQhjteOvNnC0nX9hyw5yFyLAH5Q2jJVIfU0Y079fwh
         ntW/ZjBmwdH4k4/iIBE19vywXV1+vj6FBLhzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k9t4ZQyhj3UHB2vpFiS96ld6Wm363DNdyAeKB8jO/D8=;
        b=LyHoTRZtlhJHpLKnIPcR4FY6f0yHigikzclyNvUXy8SaCLRjN2OcpqApDuD0cWaWsd
         Q0DTIY8s4toIkaNoHTVoi79+7RjLOUVALwi2cFp+NhHuFma32RZ31ISDG6mpVmRfHu0T
         Z55TisAKbhOHR06cbSZQeBCX3pFdADuVl+qlVcBJw1sEDrb02VsTQlIR6or/NsX8xUVB
         AJ0IOdq+DLDA0P3oWfdhNg1vDmL8QZmyKK3b9Vt7rVC08TuBpTxf4LZfwiGl3CIyEfFc
         GVdtf6KEa2D4Aoo4D+5CwJ3t026NyHdZ6ke4mgx8MdYTyzztH2B1GfwHclG8zHHp7QpX
         5KrQ==
X-Gm-Message-State: ABuFfoh8VDttNFCqSlpbRn2V28l7rsCo+bDmLB2lPJFq4PuYmSMmJoxA
        N3Vcwpmp7GfBiGhUkEKEdAJoxM8vFPJK9Q==
X-Google-Smtp-Source: ACcGV60Q8Q69K6x6jktKcbORVVIYHWgG+VD+W/6rLUgk92I9qhk1TLvvekYSF1tpP8fUeEnSMsUVyQ==
X-Received: by 2002:ad4:414b:: with SMTP id z11-v6mr19680915qvp.206.1539102314077;
        Tue, 09 Oct 2018 09:25:14 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id o7-v6sm10441169qkc.67.2018.10.09.09.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 09:25:13 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        quentin.perret@arm.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org
Subject: [RFC PATCH 5/7] sched/fair: Enable CFS periodic tick to update thermal pressure
Date:   Tue,  9 Oct 2018 12:25:00 -0400
Message-Id: <1539102302-9057-6-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce support in CFS periodic tick to trigger the process of
computing average thermal pressure for a cpu.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b39fb59..7deb1d0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -21,6 +21,7 @@
  *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
  */
 #include "sched.h"
+#include "thermal.h"
 
 #include <trace/events/sched.h>
 
@@ -9557,6 +9558,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
+
+	update_periodic_maxcap(rq);
 }
 
 /*
-- 
2.1.4

