Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB03AECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C982075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jlY2g2p1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C982075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbeGRW2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:28:02 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35044 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbeGRW2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:28:02 -0400
Received: by mail-it0-f65.google.com with SMTP id q20-v6so6510898ith.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 14:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eDmaDWioT7P5gzCyidheXSXPLvDRrL2xsDJugt3KQ+g=;
        b=jlY2g2p1YPJL4xcZkNG9D2sPx1IcjBVCaUPvZU0Ui4LSHnoc2I3RRLWINKA5OP3MO6
         0FBmdASaZ+5a4L+e+nEyd6SqX2xMGSFoorY098BjVv4Z6bInH+XHE2xmW4upXq0bjjZG
         CsKOvdOzoYt7e2B03wsInk8caF83nN90r5ONA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eDmaDWioT7P5gzCyidheXSXPLvDRrL2xsDJugt3KQ+g=;
        b=F3GB6fCCEcxwBtOnMA/eHs8p3iuK7juaJiYqJhYHcGM1VaShq3LKT+Hybs3dp7brfU
         7g9zXnn3rBmY9VX3yzSM8o19A4A6f8PboCM0X2K3ejw/2Tn7gn/9WQ+BMAGp95hGBPO3
         7rzwKMpFymeYCr5IVyL4YFyBH//v7CspoHoAAzbq5JJrQ//tbkPFRYJ1FRy0sO+qp8LG
         q72+/t/AQvNuZySEOaUcq5gzh8MARc8wivVhMZDlvRm3mwSAWgFKIu81w8dzLOg1Stu/
         jbtAII0qRMyhDxR4E+zWb9HuqjoHY1KF/cdgc1t00vfnu9o5bVIo+HgJ8ZgI21BlT77s
         iD1w==
X-Gm-Message-State: AOUpUlFr1f4Cz8WFl6Pl60rdBLlKRbPcaUDkBMd2LCZbn/wrYVY3NmIt
        vZvCFsEiADoKHdRYgv2FnO/vqg==
X-Google-Smtp-Source: AAOMgpfBt0yDOw8sJPcEaBL/W/27SrncymbAOuQdpCRvO4E+DuqOskZbjlFbRJ+AlHgJFUEuMcvhVw==
X-Received: by 2002:a02:3b55:: with SMTP id i21-v6mr7191248jaf.118.1531950490893;
        Wed, 18 Jul 2018 14:48:10 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id w193-v6sm2093386ita.35.2018.07.18.14.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jul 2018 14:48:10 -0700 (PDT)
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
Subject: [PATCH v3 0/7] perf: Add ioctl for PMU driver configuration
Date:   Wed, 18 Jul 2018 15:48:00 -0600
Message-Id: <1531950487-24554-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set adds the capability to communiate event specific configuration
to the PMU kernel driver using an ioctl().  The functionatlity is made
generic enough for anyone to use but is targeted at the identification
of CoreSight sinks when operating in CPU-wide trace scenarios.

Applies cleanly on v4.18-rc5.

Thanks,
Mathieu

---
Changes for V3:
. Return an error for CPU-wide scenarios while the feature is being
  implemented (Kim)
. Proper initialisation for event::hw::drv_config::lock (Kim)

Changes for V2:
. Fixed s390 problem reported by buildbot.
. Removed uneeded check in perf_event_process_drv_config() (Jiri)
. Reordered data copy in perf_event_set_drv_config() (Jiri)
. Went from 2 to 1 step driver configuration process (Alex)
. Moved structure name "perf_drv_config" to "pmu_drv_config".

V1: https://lkml.org/lkml/2018/7/2/1008

Mathieu Poirier (7):
  perf: Introduce ioctl to communicate driver configuration to kernel
  perf/core: Use ioctl to communicate driver configuration to kernel
  perf/aux: Make perf_event accessible to setup_aux()
  coresight: Use PMU driver configuration for sink selection
  perf tools: Use ioctl to communicate driver configuration to kernel
  perf tools: Make perf_evsel accessible to PMU driver configuration
    code
  perf tools: Use ioctl function to send sink configuration to kernel

 arch/s390/kernel/perf_cpum_sf.c                  |   6 +-
 arch/x86/events/intel/bts.c                      |   4 +-
 arch/x86/events/intel/pt.c                       |   5 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c | 140 ++++++++++++++++++++---
 drivers/hwtracing/coresight/coresight-etm-perf.h |   4 +
 drivers/perf/arm_spe_pmu.c                       |   6 +-
 include/linux/perf_event.h                       |  47 +++++++-
 include/uapi/linux/perf_event.h                  |   1 +
 kernel/events/core.c                             |  78 +++++++++++++
 kernel/events/ring_buffer.c                      |   2 +-
 tools/include/uapi/linux/perf_event.h            |   1 +
 tools/perf/arch/arm/util/cs-etm.c                |  60 +++-------
 tools/perf/arch/arm/util/cs-etm.h                |   3 +-
 tools/perf/util/drv_configs.c                    |  30 ++---
 tools/perf/util/evsel.c                          |   7 ++
 tools/perf/util/evsel.h                          |   1 +
 tools/perf/util/pmu.h                            |   3 +-
 17 files changed, 305 insertions(+), 93 deletions(-)

-- 
2.7.4

