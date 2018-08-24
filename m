Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7426BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210042157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210042157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeHXOTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:19:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55412 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeHXOTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:19:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B722215A2;
        Fri, 24 Aug 2018 03:45:50 -0700 (PDT)
Received: from melchizedek.Emea.Arm.com (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1A2E63F5A0;
        Fri, 24 Aug 2018 03:45:48 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: [RFC PATCH 00/20] x86/intel_rdt: Start abstraction for a second arch
Date:   Fri, 24 Aug 2018 11:44:59 +0100
Message-Id: <20180824104519.11203-1-james.morse@arm.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

ARM have some upcoming CPU features that are similar to Intel RDT. Resctrl
is the defacto ABI for this sort of thing, but it lives under arch/x86.

To get existing software working, we need to make resctrl work with arm64.
This series is the first chunk of that. The aim is to move the filesystem/ABI
parts into /fs/resctrl, and implement a second arch backend.


What are the ARM features?
Future ARM SoCs may have a feature called MPAM: Memory Partitioning and
Monitoring. This is an umbrella term like RDT, and covers a range of controls
(like CAT) and monitors (like MBM, CMT).

This series is almost all about CDP. MPAM has equivalent functionality, but
it doesn't need enabling, and doesn't affect the available closids. (I'll
try and use Intel terms). MPAM expects the equivalent to IA32_PRQ_MSR to
be configured with an Instruction closid and a Data closid. These are the
same for no-CDP, and different otherwise. There is no need for them to be
adjacent.

To avoid emulating CDP in arm64's arch code, this series moves all the ABI
parts of the CDP behaviour, (half the closid-space, each having two
configurations) into the filesystem parts of resctrl. These will eventually
be moved to /fs/.

MPAMs control and monitor configuration is all memory mapped, the base
addresses are discovered via firmware tables, so we won't have a table of
possible resources that just need alloc_enabling.

Is this it? No... there are another two series of a similar size that
abstract the MBM/CMT overflow threads and avoid 'fs' code accessing things
that have moved into the 'hw' arch specific struct.


I'm after feedback on the general approach taken here, bugs, as there are
certainly subtleties I've missed, and any strong-opinions on what should be
arch-specific, and what shouldn't.

This series is based on v4.18, and can be retrieved from:
git://linux-arm.org/linux-jm.git -b mpam/resctrl_rework/rfc_1


Thanks,

James Morse (20):
  x86/intel_rdt: Split struct rdt_resource
  x86/intel_rdt: Split struct rdt_domain
  x86/intel_rdt: Group staged configuration into a separate struct
  x86/intel_rdt: Add closid to the staged config
  x86/intel_rdt: make update_domains() learn the affected closids
  x86/intel_rdt: Add a helper to read a closid's configuration for
    show_doms()
  x86/intel_rdt: Expose update_domains() as an arch helper
  x86/intel_rdt: Make cdp enable/disable global
  x86/intel_rdt: Track the actual number of closids separately
  x86/intel_rdt: Let resctrl change the resources's num_closid
  x86/intel_rdt: Pass in the code/data/both configuration value when
    parsing
  x86/intel_rdt: Correct the closid when staging configuration changes
  x86/intel_rdt: Allow different CODE/DATA configurations to be staged
  x86/intel_rdt: Add a separate resource list for resctrl
  x86/intel_rdt: Walk the resctrl schema list instead of the arch's
    resource list
  x86/intel_rdt: Move the schemata names into struct resctrl_schema
  x86/intel_rdt: Stop using Lx CODE/DATA resources
  x86/intel_rdt: Remove the CODE/DATA illusionary caches
  x86/intel_rdt: Kill off alloc_enabled
  x86/intel_rdt: Merge cdp enable/disable calls

 arch/x86/kernel/cpu/intel_rdt.c             | 298 +++++++-------------
 arch/x86/kernel/cpu/intel_rdt.h             | 161 ++++-------
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 142 +++++++---
 arch/x86/kernel/cpu/intel_rdt_monitor.c     |  78 ++---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 216 +++++++++-----
 include/linux/resctrl.h                     | 166 +++++++++++
 6 files changed, 621 insertions(+), 440 deletions(-)
 create mode 100644 include/linux/resctrl.h

-- 
2.18.0

