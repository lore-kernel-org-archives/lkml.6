Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396A6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B89B20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V8yB2XGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391149AbfAOXHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 18:07:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42994 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbfAOXHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 18:07:47 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so2023162pfr.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 15:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KGp8W3Zi1Td46Yk/Amf0n/ihhixIOFYJ4kdCIRrt+Pk=;
        b=V8yB2XGajuaKlqeqY4NqXp2OImEJbkruXqxI3dlvsBkK4tACG1CKqC6/YOtkaMwkg7
         z2+wfOlCxIePRJl5LUumBvlULAgCajajHtPbuqDZsbiUPUKWqoCFZU7pxMhyHzIxJ1E3
         S7Nvq8sQy9iMW5Xjjyt24+QulBf4mmGaPZHp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KGp8W3Zi1Td46Yk/Amf0n/ihhixIOFYJ4kdCIRrt+Pk=;
        b=S+2yC/y4D8EGbEfPi1PxMANz8ME5c/ukJSzSGbSCRsIox0mLvHOyHY6M1prcTyQxpl
         /zfeRqcjtECCVS7gLwuIGGyOhlIituDwHRzLF9auBXDzWtOAHy9zPeuJEonZ9WI4aCAN
         +ghKzAV0J0RkH22kfDrvyKeFZbB+/vf4vTzcZiRPAORa6nfZQ2el99HKX2XY0cvh8Las
         FoA6rpRtcx3vh1poVmDyrtvtNqFswn/tE71UvX2Nuhfw998K1qCMfWDOKQfbaE6BT6+S
         di3pZiQfD2vDjp3cMNHuemtSs+bejHONaHIt3GZhEK6AtBpOIp2Qm6M0IxSYI/MWs1QN
         LNVg==
X-Gm-Message-State: AJcUukeJb4hBo2NdTTpT+STNDm+ealgY7AnevziqNAIQkHo2yQjflplS
        Q75U6W8DWnI4tq5TY/o7WejoVQ==
X-Google-Smtp-Source: ALg8bN48pOIf9+7lGLTLTPTCCIpyMaEocODeQrdksMnYnOGP+K00uzuNmu8PLm9HEttSbuTciXO3+Q==
X-Received: by 2002:a62:2e46:: with SMTP id u67mr6404064pfu.3.1547593665952;
        Tue, 15 Jan 2019 15:07:45 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id h19sm4985928pfn.114.2019.01.15.15.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 15:07:44 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org
Cc:     mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        suzuki.poulose@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/7] perf: Communicate sink via event::attr:config2 
Date:   Tue, 15 Jan 2019 16:07:35 -0700
Message-Id: <20190115230742.13730-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mathieu Poirier]" <mathieu.poirier@linaro.org>

This set is a refurbished version of this one [1].  I dropped the version
count and changed the name because a new approach is taken.

The end result is the same though, that is to allow multiple sources to
select the same sink for a session which is a prerequisite for the CoreSight
support of CPU-wide trace scenarios.

Here the sink ID is communicated to the kernel by way of the event's
configuration attribure (event::attr::config2).  The ID itself is an
hash of the sink's name, something that is readily available and doesn't
require the addition of a new information field in the coresight_device
structure.

With this new strategy the mechanic used to communicate sink selection to the
kernel via sysfs is no longer needed and removed from the code base.

Everthing has been applied and tested on 5.0-rc2.

Regards,
Mathieu

PS: Greg, I'm drawing your attention to patch 02 where I seem to be the first
to use function sysfs_add_file_to_group() in this way.

[1]. https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1818488.html

Mathieu Poirier (6):
  perf/aux: Make perf_event accessible to setup_aux()
  coresight: perf: Add "sinks" group to PMU directory
  coresight: Use event attributes for sink selection
  perf tools: Use event attributes to send sink information to kernel
  perf tools: Removing CoreSight set_drv_config() API
  perf tools: Remove PMU::set_drv_config API

linaro (1):
  perf pmu: Moving EVENT_SOURCE_DEVICE_PATH to PMU header file

 arch/s390/kernel/perf_cpum_sf.c               |  6 +-
 arch/x86/events/intel/bts.c                   |  4 +-
 arch/x86/events/intel/pt.c                    |  5 +-
 .../hwtracing/coresight/coresight-etm-perf.c  | 65 ++++++++++---
 .../hwtracing/coresight/coresight-etm-perf.h  |  1 +
 drivers/hwtracing/coresight/coresight-priv.h  |  1 +
 drivers/hwtracing/coresight/coresight.c       | 56 +++++++++++
 drivers/perf/arm_spe_pmu.c                    |  6 +-
 include/linux/perf_event.h                    |  2 +-
 kernel/events/ring_buffer.c                   |  2 +-
 tools/perf/arch/arm/util/cs-etm.c             | 94 ++++++++-----------
 tools/perf/arch/arm/util/cs-etm.h             |  3 -
 tools/perf/arch/arm/util/pmu.c                |  2 -
 tools/perf/builtin-record.c                   | 10 --
 tools/perf/builtin-stat.c                     |  9 --
 tools/perf/builtin-top.c                      | 13 ---
 tools/perf/util/Build                         |  1 -
 tools/perf/util/drv_configs.c                 | 78 ---------------
 tools/perf/util/drv_configs.h                 | 26 -----
 tools/perf/util/pmu.c                         |  2 -
 tools/perf/util/pmu.h                         |  2 +-
 21 files changed, 163 insertions(+), 225 deletions(-)
 delete mode 100644 tools/perf/util/drv_configs.c
 delete mode 100644 tools/perf/util/drv_configs.h

-- 
2.17.1

