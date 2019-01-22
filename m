Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE571C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBEA21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EmSVJ3tX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfAVSLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:11:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40559 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfAVSLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:11:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so12138684pfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 10:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1fSj0al6b5p/fuO8Ttc0sOxMG/zIPvqM89wtR7MI5cE=;
        b=EmSVJ3tXchTy4Cb+5I0JIS6FzteJVLymsc7Hvm3uW7lYGbX36Jg/+LhpItLWP2KZIZ
         2SNlGVc5JqWt66IlT358eZSKAKj05G/Il0bn3nVaQNEq6PsJC1rnmY2uDILo0wbZyesF
         7A70SBB6vCyx5P9loDLSaljOqkUFWRobSNPO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1fSj0al6b5p/fuO8Ttc0sOxMG/zIPvqM89wtR7MI5cE=;
        b=p67w4+pnfUsy8Fm2EZjHfUIRWerWhXXVdEj+0xZrukrG6PyOoR7wWe9FhobCLaf2zn
         1SyEcEthV119goXMOgvDbJhNWRVXxNtHOV0rL3qxxgYO4X6zSh3l44JzVJ14UfpcpVqY
         O8Co589wjqtNLkXJHaUdDTgMKwOgdheV+pyAaD6pR8RV1wn+gtL9dSB38F+RLa45YRpw
         Qtynk47zahMtCImNYJyBCMhhg307omSgqkpzRheTROM33I/ryLza0N8L+9VY59r7wYNN
         ARtXe0J4gWofCKwkxmxdsLYD3kmHvI24hQ/RayA70KddbISjM4n3+UeYWlKqxUowjoEF
         sPpQ==
X-Gm-Message-State: AJcUukcEmiOXw1dCxiOgocMWFprCB3USs5UthyVh8uQLovNonarbpoOU
        R4m/VOO2rAeuVtdAMHATRKML0w==
X-Google-Smtp-Source: ALg8bN5K/I9VMx03fEQTJB2qUFipw60oVI7IVLbTpB2RtPwhq7cDj16EeESYWdcZhrfjZMyuN4GDUg==
X-Received: by 2002:a63:680a:: with SMTP id d10mr33146762pgc.396.1548180707266;
        Tue, 22 Jan 2019 10:11:47 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a18sm23489919pgj.30.2019.01.22.10.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 10:11:46 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Subject: [PATCH v2 0/7] perf: Communicate sink via event::attr:config2
Date:   Tue, 22 Jan 2019 11:11:37 -0700
Message-Id: <20190122181144.26645-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second revision of a patchset allowing multiple sources to select
the same sink for a session which is a prerequisite for the support of CoreSight
CPU-wide trace scenarios.

The sink ID is communicated to the kernel by way of the event's configuration
attribute (event::attr:config2).  The ID itself is an hash of the sink's name,
something that is readily available and doesn't require the addition of a new
information field in the coresight_device structure.

With this set the mechanic to communicate sink selection to the kernel via
sysfs is no longer needed and removed.

Applies cleanly and tested on 5.0-rc3.

Thanks,
Mathieu

Changes for V2:
* Addressed memory leak in etm_perf_add_symlink_sink()
* Keep track of device attribute for future removal.
* Added PMU attribure for config2.
* Fixed email address signature.

Mathieu Poirier (7):
  perf/aux: Make perf_event accessible to setup_aux()
  coresight: perf: Add "sinks" group to PMU directory
  coresight: Use event attributes for sink selection
  perf pmu: Moving EVENT_SOURCE_DEVICE_PATH to PMU header file
  perf tools: Use event attributes to send sink information to kernel
  perf tools: Removing CoreSight set_drv_config() API
  perf tools: Remove PMU::set_drv_config API

 arch/s390/kernel/perf_cpum_sf.c               |   6 +-
 arch/x86/events/intel/bts.c                   |   4 +-
 arch/x86/events/intel/pt.c                    |   5 +-
 .../hwtracing/coresight/coresight-etm-perf.c  | 106 +++++++++++++++---
 .../hwtracing/coresight/coresight-etm-perf.h  |   6 +-
 drivers/hwtracing/coresight/coresight-priv.h  |   1 +
 drivers/hwtracing/coresight/coresight.c       |  57 ++++++++++
 drivers/perf/arm_spe_pmu.c                    |   6 +-
 include/linux/coresight.h                     |   7 +-
 include/linux/perf_event.h                    |   2 +-
 kernel/events/ring_buffer.c                   |   2 +-
 tools/perf/arch/arm/util/cs-etm.c             |  94 +++++++---------
 tools/perf/arch/arm/util/cs-etm.h             |   3 -
 tools/perf/arch/arm/util/pmu.c                |   2 -
 tools/perf/builtin-record.c                   |  10 --
 tools/perf/builtin-stat.c                     |   9 --
 tools/perf/builtin-top.c                      |  13 ---
 tools/perf/util/Build                         |   1 -
 tools/perf/util/drv_configs.c                 |  78 -------------
 tools/perf/util/drv_configs.h                 |  26 -----
 tools/perf/util/pmu.c                         |   2 -
 tools/perf/util/pmu.h                         |   2 +-
 22 files changed, 214 insertions(+), 228 deletions(-)
 delete mode 100644 tools/perf/util/drv_configs.c
 delete mode 100644 tools/perf/util/drv_configs.h

-- 
2.17.1

