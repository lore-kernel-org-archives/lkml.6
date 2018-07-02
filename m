Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070D2C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB043204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DwZWUn3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB043204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753746AbeGBWdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:33:37 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41668 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753470AbeGBWdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:33:35 -0400
Received: by mail-pg0-f67.google.com with SMTP id l65-v6so7738035pgl.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 15:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ObPwghtueNF6LlLM7mcfjzv83XXf9Nzzo2SzCH6fO+g=;
        b=DwZWUn3jpZIlghNKAwEt15EQDN5bBzXFJ6MJvDOQz1MwQxxvb79GAATXNUyHBSiupk
         4zB3gYC7/qrtTDmPX9YSM1GGsa5Xd0QL756cIszoHwt+RyQUkhRhV9MYGeW6nvE16pTB
         MuFrMtzcrUfDYDrj2uC6MVt3qExjzE2pTEBnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ObPwghtueNF6LlLM7mcfjzv83XXf9Nzzo2SzCH6fO+g=;
        b=PuWopSw3EdR/PHNCy1FhRUtLPFlwijoKJFEeykbZA1o0VNlTZBNTxWdSlsgD16yXYy
         Tjvtlsss4lKmSpaQI5rEV6649+c2im59JxY4/YrBLGiDkA49GHD5sLC2AXrXwGm3bIUN
         Kh2xoYQkitFTODco9J77gRJYweldSaoWHeU+RwSY8BjZ3+i/byZoCpN8q3LMo2+3E9Cs
         x3D+6+SNtCIPKL0rb9QmOkYPPbp1gbZpwz0bMiZ1+r2uoE1Fw6WaBa0k5WOkhlJRmTzB
         aR46w4WyppQLXx/DsE+WpF5F/tvW/BEtRBfkPTROxIXOZlcPfr33rMCdEnsVcSlUk3XQ
         mb8g==
X-Gm-Message-State: APt69E23w6MidQr0NPFbhDYERgcnzyj/+JSFXeiiYHPRjcNlIA/6LfIl
        60kQn2UnBO88CFEJPnhKk+bjUA==
X-Google-Smtp-Source: AAOMgpe4PRdft+7cNvSBckcNH+kY2C1fOP2HOBk73aT/utkVy4qPHxYr9cXre7VVz6KiqGrQipzlLQ==
X-Received: by 2002:a62:3a5b:: with SMTP id h88-v6mr10906279pfa.61.1530570813796;
        Mon, 02 Jul 2018 15:33:33 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id p11-v6sm21764132pgu.16.2018.07.02.15.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 15:33:32 -0700 (PDT)
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
Subject: [PATCH 0/6] perf: Add ioctl for PMU driver configuration 
Date:   Mon,  2 Jul 2018 16:33:24 -0600
Message-Id: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set follows what has been done for filters by adding an ioctl
to communicate PMU specific driver configuration to the kernel.

Patch 01 and 02 provide the functionality in user space while patch 04
and 05 take care of the kernel part.  Patches 03 and 06 use the newly
added functionality to communicate the selection of CoreSight sink
for each event.

This functionality is needed to identify the CoreSight sink to use when
working with CPU-wide trace scenarios.  It also paves the way to support
complex tracer configurations where dozens of trace parameters need to
be communicated to the CoreSight PMU driver.

Applies cleanly on v4.18-rc3.

Best regards,
Mathieu

Mathieu Poirier (6):
  perf tools: Use ioctl to communicate driver configuration to kernel
  perf tools: Make perf_evsel accessible to PMU driver configuration
    code
  perf tools: Use ioctl function to send sink configuration to kernel
  perf/aux: Make perf_event accessible to setup_aux()
  perf/core: Use ioctl to communicate driver configuration to kernel
  coresight: Use PMU driver configuration for sink selection

 arch/s390/kernel/perf_cpum_sf.c                  |   4 +-
 arch/x86/events/intel/bts.c                      |   4 +-
 arch/x86/events/intel/pt.c                       |   5 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c | 134 ++++++++++++++++++++---
 drivers/hwtracing/coresight/coresight-etm-perf.h |  10 ++
 drivers/perf/arm_spe_pmu.c                       |   6 +-
 include/linux/perf_event.h                       |  56 +++++++++-
 include/uapi/linux/perf_event.h                  |   1 +
 kernel/events/core.c                             | 110 +++++++++++++++++++
 kernel/events/ring_buffer.c                      |   2 +-
 tools/include/uapi/linux/perf_event.h            |   1 +
 tools/perf/arch/arm/util/cs-etm.c                |  60 +++-------
 tools/perf/arch/arm/util/cs-etm.h                |   3 +-
 tools/perf/util/drv_configs.c                    |  30 ++---
 tools/perf/util/evsel.c                          |   7 ++
 tools/perf/util/evsel.h                          |   1 +
 tools/perf/util/pmu.h                            |   3 +-
 17 files changed, 345 insertions(+), 92 deletions(-)

-- 
2.7.4

