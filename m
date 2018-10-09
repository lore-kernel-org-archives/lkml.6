Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DE3C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9CC2075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="daiUVhzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9CC2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeJIXmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:42:49 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40717 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeJIXmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:42:49 -0400
Received: by mail-qk1-f194.google.com with SMTP id a13-v6so1308260qkc.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dEbuJPg+sN0ZPa1pEhH5wuA0UPKQdzy17mOB6bYyGbg=;
        b=daiUVhzbL59m4RASOtUiAn3akoxuVjVtj/XuovByPLhG8hj903rY+ER2Bmkgm5LJXf
         t73QZ9Str5bVbSodIRVr0m1x5Y1MQbLwXhi4MIf+p9KRSPj12vaHDJgvDY0epj38IBh8
         IWnBamNbhNvEmSLaKfc/OcwQC2+qyGFZjhmWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dEbuJPg+sN0ZPa1pEhH5wuA0UPKQdzy17mOB6bYyGbg=;
        b=hhGqmQteCk+ue/ODbgZyuMhD7iKln+21aCVPo8DzS+PRl0lFhjsKYWh7bxju8wMEcb
         NDSIvrLDFUmhJ2sK8m2URx1XCfEopfm60wej7pVbqMJhNu8e9N6P8qY1EHMA3x39bEw4
         iyUbEEfbZg5bPazNzauSUczNNDst3JsyhDgEG1N0SMGF2ZFWqTxsRnaoE/JpGcIs4VAd
         EOD1N5EVWh/m27NuCS8YlvVBFt7N3HUuMW2SbzrVhMCZH+kgEECbgFFrF0tf6OBJ599J
         slyHSNU3XGLPHClwAzkA1ZOToNEFVg2FwKuP/h/k9NjoTfq20rtx5iKbD7OJcYXqK1q5
         RnfA==
X-Gm-Message-State: ABuFfohvF+TOj+ygvxpNqXUCoKECIGeCyWbsIvYf6/fWfyaLh0k1gy3v
        QbYFCe1UTnBZv5L2E09w/ulKoAgj+jIZmg==
X-Google-Smtp-Source: ACcGV62k1XIswLjjO5lfrt2ZzZpwkE7tQsZyeU76mI+rVocYrlcppRx8noff/9U1WlpOIqeWY7pZ2w==
X-Received: by 2002:a37:27d0:: with SMTP id n199-v6mr22300447qkn.33.1539102304914;
        Tue, 09 Oct 2018 09:25:04 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id o7-v6sm10441169qkc.67.2018.10.09.09.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 09:25:03 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        quentin.perret@arm.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org
Subject: [RFC PATCH 0/7] Introduce thermal pressure
Date:   Tue,  9 Oct 2018 12:24:55 -0400
Message-Id: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal governors can respond to an overheat event for a cpu by
capping the cpu's maximum possible frequency. This in turn
means that the maximum available compute capacity of the
cpu is restricted. But today in linux kernel, in event of maximum
frequency capping of a cpu, the maximum available compute
capacity of the cpu is not adjusted at all. In other words, scheduler
is unware maximum cpu capacity restrictions placed due to thermal
activity. This patch series attempts to address this issue.
The benefits identified are better task placement among available
cpus in event of overheating which in turn leads to better
performance numbers.

The delta between the maximum possible capacity of a cpu and
maximum available capacity of a cpu due to thermal event can
be considered as thermal pressure. Instantaneous thermal pressure
is hard to record and can sometime be erroneous as there can be mismatch
between the actual capping of capacity and scheduler recording it.
Thus solution is to have a weighted average per cpu value for thermal
pressure over time. The weight reflects the amount of time the cpu has
spent at a capped maximum frequency. To accumulate, average and
appropriately decay thermal pressure, this patch series uses pelt
signals and reuses the available framework that does a similar
bookkeeping of rt/dl task utilization.

Regarding testing, basic build, boot and sanity testing have been
performed on hikey960 mainline kernel with debian file system.
Further aobench (An occlusion renderer for benchmarking realworld
floating point performance) showed the following results on hikey960
with debain.

                                        Result          Standard        Standard
                                        (Time secs)     Error           Deviation
Hikey 960 - no thermal pressure applied 138.67          6.52            11.52%
Hikey 960 -  thermal pressure applied   122.37          5.78            11.57%

Thara Gopinath (7):
  sched/pelt: Add option to make load and util calculations frequency
    invariant
  sched/pelt.c: Add support to track thermal pressure
  sched: Add infrastructure to store and update instantaneous thermal
    pressure
  sched: Initialize per cpu thermal pressure structure
  sched/fair: Enable CFS periodic tick to update thermal pressure
  sched/fair: update cpu_capcity to reflect thermal pressure
  thermal/cpu-cooling: Update thermal pressure in case of a maximum
    frequency capping

 drivers/base/arch_topology.c  |  1 +
 drivers/thermal/cpu_cooling.c | 20 ++++++++++++-
 include/linux/sched.h         | 14 +++++++++
 kernel/sched/Makefile         |  2 +-
 kernel/sched/core.c           |  2 ++
 kernel/sched/fair.c           |  4 +++
 kernel/sched/pelt.c           | 40 ++++++++++++++++++--------
 kernel/sched/pelt.h           |  7 +++++
 kernel/sched/sched.h          |  1 +
 kernel/sched/thermal.c        | 66 +++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/thermal.h        | 13 +++++++++
 11 files changed, 157 insertions(+), 13 deletions(-)
 create mode 100644 kernel/sched/thermal.c
 create mode 100644 kernel/sched/thermal.h

-- 
2.1.4

