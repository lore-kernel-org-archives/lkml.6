Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B890ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 22:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009E220671
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 22:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009E220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbeIPDWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 23:22:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:34542 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727302AbeIPDV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 23:21:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Sep 2018 15:01:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,379,1531810800"; 
   d="scan'208";a="70289138"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga007.fm.intel.com with ESMTP; 15 Sep 2018 15:01:28 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Tony Luck" <tony.luck@intel.com>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Xiaochen Shen" <xiaochen.shen@intel.com>,
        "Chen Yu" <yu.c.chen@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, "Fenghua Yu" <fenghua.yu@intel.com>
Subject: [PATCH V2 0/9] x86/intel_rdt: MBA integration fixes
Date:   Sat, 15 Sep 2018 14:58:18 -0700
Message-Id: <1537048707-76280-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen Yu reported an issue where reading the resctrl "size" file results in
a divide-by-zero issue on a system with a MBA resource. Further
investigation revealed more issues where the recent RDT features are not
well integrated with the MBA resource handling.

This series consists out of:
 - One helper function in support of fixes that need to know the number of
   supported CLOSIDs on the system (the minimum of all CLOSIDs of all
   resources).
 - The fix to the issue reported by Chen Yu  - now reading a resource
   group's "size" file will show a MB resource's allocation as its size.
 - A fix from Xiaochen Shen to the MB parsing callback that was never
   changed to accept a new parameter format.
 - Functions that iterate over the number of CLOSIDs need to take care
   whether it is using a particular resource's supported CLOSIDs or the
   number of CLOSIDs supported by the system. This was done incorrectly in
   a few places and fixed here.
 - When a new resource group is created it is intended to be configured
   with sane defaults. This new feature blindly assumed that the resource
   group only consists out of cache resources - make this explicit to not
   cause invalid register writes on a system with MBA resources.
 - The new "exclusive" mode assumes that all resources support a CBM, while
   a MBA resource does not. Since the MBA resource allocations cannot be
   done in a way to specify whether allocations can overlap or not the
   "exclusive" mode of a resource group will only apply to the cache
   resources within the group, if only a MBA resource is present then
   "exclusive" mode will not be allowed.

Changelog
v2:
 - Patch 1: Change 'data' from void pointer to struct rdt_parse_data
   pointer in parsing callbacks based on suggestion from Thomas.
 - Patch 2, 4, 5: Condense backtraces in commit description to minimum
   based on suggestion from Thomas

Reinette Chatre (8):
  x86/intel_rdt: Fix size reporting of MBA resource
  x86/intel_rdt: Global closid helper to support future fixes
  x86/intel_rdt: Fix invalid mode warning when multiple resources are
    managed
  x86/intel_rdt: Fix unchecked MSR access
  x86/intel_rdt: Do not allow pseudo-locking of MBA resource
  x86/intel_rdt: Fix incorrect loop end condition
  x86/intel_rdt: Fix exclusive mode handling of MBA resource
  x86/intel_rdt: Fix incorrect loop end condition

Xiaochen Shen (1):
  x86/intel_rdt: Fix data type in parsing callbacks

 arch/x86/kernel/cpu/intel_rdt.h             | 17 +++++--
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 27 ++++++-----
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 53 +++++++++++++++++----
 3 files changed, 71 insertions(+), 26 deletions(-)

-- 
2.19.0

