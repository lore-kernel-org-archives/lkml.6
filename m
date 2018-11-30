Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEC6C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787B620834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787B620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeLAE2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:28:25 -0500
Received: from foss.arm.com ([217.140.101.70]:60956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbeLAE2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:28:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFCF6EBD;
        Fri, 30 Nov 2018 09:18:26 -0800 (PST)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 350DD3F5A0;
        Fri, 30 Nov 2018 09:18:25 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        catalin.marinas@arm.com, dave.martin@arm.com, mark.rutland@arm.com,
        vladimir.murzin@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 0/7] arm64: capabilities: Optimize checking and enabling
Date:   Fri, 30 Nov 2018 17:17:59 +0000
Message-Id: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We maintain two separate tables (i.e, arm64_features and arm64_errata) of
struct arm64_cpu_capabilities which decide the capabilities of the system.
We iterate over the two tables for detecting/verifying/enabling the capabilities.
e.g, this_cpu_has_cap() needs to iterate over the two tables one by one to
find the "capability" structure corresponding to the cap number and then
check it on the CPU.

Also, we enable all the non-boot scoped capabilities after all the SMP cpus
are brought up by the kernel, using stop_machine() for each available
capability. We could batch all the "enabling" activity to a single
stop_machine() callback. But that implies you need a way to map
a given capability number to the corresponding capability entry
to finish the operation quickly.

So we need a quicker way to access the entry for a given capability.
We have two choices :

 1) Unify both the tables to a static/dynamic sorted entry based on
    the capability number. This has the following drawbacks :
     a) The entries must be unique. i.e, no duplicate entries for a
        capability.
     b) Looses the separation of "features" vs. "errata" classification
     c) Statically sorting the list is error prone. Runtime sorting the
        array means more time for booting.

 2) Keep an array of pointers to the capability sorted at boot time
    based on the capability.
     a) As for (1), the entries must be unique for a capability.

This series implements (2) and uses the new list for optimizing the
operations on the entries. As a prepatory step, we remove the
duplicate entries for the same capabilities (Patch 1-3).

Changes since v1:
 - Fix merging workarounds for clean cache errata. Added
   a Kconfig symbol for covering the capability to make
   the handling better.
 - Make the WARNINGs meaningful on duplicate entries
 - Added tags from Vladimir

Suzuki K Poulose (7):
  arm64: capabilities: Merge entries for ARM64_WORKAROUND_CLEAN_CACHE
  arm64: capabilities: Merge duplicate Cavium erratum entries
  arm64: capabilities: Merge duplicate entries for Qualcomm erratum 1003
  arm64: capabilities: Speed up capability lookup
  arm64: capabilities: Optimize this_cpu_has_cap
  arm64: capabilities: Use linear array for detection and verification
  arm64: capabilities: Batch cpu_enable callbacks

 arch/arm64/Kconfig                  |   7 ++
 arch/arm64/include/asm/cpufeature.h |   3 +
 arch/arm64/include/asm/cputype.h    |   2 +
 arch/arm64/kernel/cpu_errata.c      | 103 ++++++++++++----------
 arch/arm64/kernel/cpufeature.c      | 169 +++++++++++++++++++++---------------
 5 files changed, 165 insertions(+), 119 deletions(-)

-- 
2.7.4

