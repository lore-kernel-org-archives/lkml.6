Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F62C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99D724049
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H00UCCTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99D724049
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753537AbeGEWNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 18:13:53 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34851 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753346AbeGEWNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 18:13:51 -0400
Received: by mail-pf0-f193.google.com with SMTP id q7-v6so5475910pff.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 15:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=c8qCcNG8jWrbYoFnZUPPI/ZfJ2QX62PpFQ4zMBNfD+g=;
        b=H00UCCTB0hT6Udp/5fuJabmg/llXzMi3LDiBolfZzRafpjMd7U51Mt+Jcre3+uHCt/
         ykk95bhN/ebSqgmKSpftr13PgKsD7mkG7lhTUS76MjJZOd+2KCQH7rrW6Dupf0rgzxbf
         fFTDxmnEnwEPEkDYyWLDMP48Uk47LC09rKK8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c8qCcNG8jWrbYoFnZUPPI/ZfJ2QX62PpFQ4zMBNfD+g=;
        b=ZqIxDmjJRVpOL9JiAPRx6xN9GaTEWYj4RRFC9Ttw1I76kTwDt4h7oaIOLidZaYnISC
         RwgMYiSNewhR+LWj6YX5Yvg7DUondc7mlmQclgesj9zs3o4V+eBodEb6awzLhpwc1N88
         XfbYTjuUc/6RbhqnZlKYQmwgcPMPTDL4+l2q80Tay0ZBLOU4X124zLcHq18Xxta5wLD/
         sx5Wf6WRDkgY9W3RzUDCLdaoFmKM8N8eOHOX07wEj58hBNrQbfOZLrJuSpZ07k8VgWq7
         jMKAXwyUXYS4AoQPWm6a1bV8KDcue6u+C0TtSl18mKbAHs138muXcOFLNhzERyI2OmXp
         6RCA==
X-Gm-Message-State: APt69E3LB/k4dpv0xjEzCYdfL/39ZMsE7NXjgazLHsHMhTMB/IrpplwQ
        RmPlsn7R48i/2a7LU3tk9gA4IQ==
X-Google-Smtp-Source: AAOMgpcvasKoXnplchRwCiA5oPIYXoA0vdxHAbFr33IH/oTLL5qNEBRCN9vwJxOem9JETl1/cwpKEg==
X-Received: by 2002:a63:3201:: with SMTP id y1-v6mr7241959pgy.419.1530828830878;
        Thu, 05 Jul 2018 15:13:50 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r89-v6sm13297486pfa.75.2018.07.05.15.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jul 2018 15:13:49 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peterz@infradead.org, acme@kernel.org
Cc:     mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/7] perf: Add ioctl for PMU driver configuration
Date:   Thu,  5 Jul 2018 16:13:40 -0600
Message-Id: <1530828827-11604-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set adds the capability to communiate event specific configuration
to the PMU kernel driver using an ioctl().  The functionatlity is made
generic enough for anyone to use but is targeted at the identification
of CoreSight sinks when operating in CPU-wide trace scenarios.

Other than the changes highlighted below I have moved things around,
deciding to start with the kernel portion rather than user space -
hopefully this will be easier to review.

Applies cleanly on v4.18-rc3.

Thanks,
Mathieu

---
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
 drivers/hwtracing/coresight/coresight-etm-perf.c | 136 ++++++++++++++++++++---
 drivers/hwtracing/coresight/coresight-etm-perf.h |   4 +
 drivers/perf/arm_spe_pmu.c                       |   6 +-
 include/linux/perf_event.h                       |  47 +++++++-
 include/uapi/linux/perf_event.h                  |   1 +
 kernel/events/core.c                             |  77 +++++++++++++
 kernel/events/ring_buffer.c                      |   2 +-
 tools/include/uapi/linux/perf_event.h            |   1 +
 tools/perf/arch/arm/util/cs-etm.c                |  60 +++-------
 tools/perf/arch/arm/util/cs-etm.h                |   3 +-
 tools/perf/util/drv_configs.c                    |  30 ++---
 tools/perf/util/evsel.c                          |   7 ++
 tools/perf/util/evsel.h                          |   1 +
 tools/perf/util/pmu.h                            |   3 +-
 17 files changed, 300 insertions(+), 93 deletions(-)

-- 
2.7.4

