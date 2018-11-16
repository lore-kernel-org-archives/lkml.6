Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5EFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10732086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10732086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389478AbeKPUgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:36:06 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48644 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727446AbeKPUgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:36:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8758BEBD;
        Fri, 16 Nov 2018 02:24:23 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F2143F5BD;
        Fri, 16 Nov 2018 02:24:20 -0800 (PST)
From:   Andrew Murray <andrew.murray@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org
Cc:     linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] perf/core: Generalise event exclusion checking
Date:   Fri, 16 Nov 2018 10:24:03 +0000
Message-Id: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many PMU drivers do not have the capability to exclude counting events
that occur in specific contexts such as idle, kernel, guest, etc. These
drivers indicate this by returning an error in their event_init upon
testing the events attribute flags.

However this approach requires that each time a new event modifier is
added to perf, all the perf drivers need to be modified to indicate that
they don't support the attribute. This results in additional boiler-plate
code common to many drivers that needs to be maintained. An example of
this is the addition of exclude_host and exclude_guest in 2011 yet many
PMU drivers do not support this or indicate an error on events that make
use of it.

This patch generalises the test for exclusion and updates PMU drivers to
use it. This is a functional change as some PMU drivers will now correctly
report that they don't support certain events whereas they previously did.

An alternative approach might have been to provide a static perf_event_attr
with exclusion events set such that each PMU driver could compare against
(see ref [1]) - however this is less readable. A longer term approach may
instead be for PMU's to advertise their capabilities on registration.

All drivers touched by this patchset have been compile tested.

[1] https://lore.kernel.org/patchwork/patch/325116/
~                                                               

Andrew Murray (10):
  perf/core: Add macro to test for event exclusion flags
  arm: perf/core: generalise event exclusion checking with perf macro
  arm: perf: add additional validation to set_event_filter
  powerpc: perf/core: generalise event exclusion checking with perf
    macro
  powerpc/pmu/fsl: add additional validation to event_init
  alpha: perf/core: generalise event exclusion checking with perf macro
  x86: perf/core: generalise event exclusion checking with perf macro
  perf/core: Remove unused perf_flags
  drivers/perf: perf/core: generalise event exclusion checking with perf
    macro
  perf/doc: update design.txt for exclude_{host|guest} flags

 arch/alpha/kernel/perf_event.c           |  4 +---
 arch/arm/kernel/perf_event_v7.c          |  2 ++
 arch/arm/mach-imx/mmdc.c                 |  8 +-------
 arch/arm/mm/cache-l2x0-pmu.c             |  7 +------
 arch/powerpc/perf/core-fsl-emb.c         |  2 ++
 arch/powerpc/perf/hv-24x7.c              |  7 +------
 arch/powerpc/perf/hv-gpci.c              |  7 +------
 arch/powerpc/perf/imc-pmu.c              | 14 ++------------
 arch/x86/events/amd/ibs.c                | 11 +----------
 arch/x86/events/amd/iommu.c              |  3 +--
 arch/x86/events/amd/power.c              |  8 +-------
 arch/x86/events/amd/uncore.c             |  3 +--
 arch/x86/events/intel/cstate.c           |  7 +------
 arch/x86/events/intel/rapl.c             |  7 +------
 arch/x86/events/intel/uncore.c           |  3 +--
 arch/x86/events/intel/uncore_snb.c       |  7 +------
 arch/x86/events/msr.c                    |  7 +------
 drivers/perf/arm-cci.c                   |  7 +------
 drivers/perf/arm-ccn.c                   |  5 +----
 drivers/perf/arm_dsu_pmu.c               |  7 +------
 drivers/perf/arm_pmu.c                   |  9 +--------
 drivers/perf/hisilicon/hisi_uncore_pmu.c |  7 +------
 drivers/perf/qcom_l2_pmu.c               |  3 +--
 drivers/perf/qcom_l3_pmu.c               |  3 +--
 drivers/perf/xgene_pmu.c                 |  3 +--
 include/linux/perf_event.h               |  9 +++++++++
 include/uapi/linux/perf_event.h          |  2 --
 tools/include/uapi/linux/perf_event.h    |  2 --
 tools/perf/design.txt                    |  4 ++++
 29 files changed, 41 insertions(+), 127 deletions(-)

-- 
2.7.4

