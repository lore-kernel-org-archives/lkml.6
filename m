Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0E6ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362962084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362962084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732351AbeGTOWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:22:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36226 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbeGTOWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:22:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB84F80D;
        Fri, 20 Jul 2018 06:33:42 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (e105550-lin.cambridge.arm.com [10.1.211.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F5353F73C;
        Fri, 20 Jul 2018 06:33:41 -0700 (PDT)
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCH 0/4] sched/topology: Set SD_ASYM_CPUCAPACITY flag automatically
Date:   Fri, 20 Jul 2018 14:32:30 +0100
Message-Id: <1532093554-30504-1-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SD_ASYM_CPUCAPACITY flag has been around for some time now with no code to
actually set it. Android has carried patches to do this out-of-tree in the
meantime. The flag is meant to indicate cpu capacity asymmetry and is set at
the topology level where the sched_domain spans all available cpu capacity in
the system, i.e. all core types are visible, for any cpu in the system.

The flag was merged as being a topology flag meaning that architecture had to
provide the flag explicitly, however when mixed with cpusets splitting the
system into multiple root_domains the flag can't be set without knowledge about
the cpusets. Rather than exposing cpusets to architecture code this patch set
moves the responsibility for setting the flag to generic topology code which is
simpler and make the code architecture agnostic.

Morten Rasmussen (4):
  sched/topology: SD_ASYM_CPUCAPACITY flag detection
  drivers/base/arch_topology: Rebuild sched_domain hierarchy when
    capacities change
  arch/arm64: Rebuild sched_domain hierarchy when cpu capacity changes
  arch/arm: Rebuild sched_domain hierarchy when cpu capacity changes

 arch/arm/include/asm/topology.h   |  3 ++
 arch/arm64/include/asm/topology.h |  3 ++
 drivers/base/arch_topology.c      | 26 +++++++++++++
 include/linux/arch_topology.h     |  1 +
 include/linux/sched/topology.h    |  2 +-
 kernel/sched/topology.c           | 81 ++++++++++++++++++++++++++++++++++++---
 6 files changed, 109 insertions(+), 7 deletions(-)

-- 
2.7.4

