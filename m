Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED05ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9381620881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9381620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeIOBwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 21:52:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:60388 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbeIOBvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 21:51:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 13:35:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,374,1531810800"; 
   d="scan'208";a="263593790"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga006.fm.intel.com with ESMTP; 14 Sep 2018 13:35:44 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Tony Luck" <tony.luck@intel.com>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Xiaochen Shen" <xiaochen.shen@intel.com>,
        "Chen Yu" <yu.c.chen@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, "Fenghua Yu" <fenghua.yu@intel.com>
Subject: [PATCH 0/9] x86/intel_rdt: MBA integration fixes
Date:   Fri, 14 Sep 2018 13:32:00 -0700
Message-Id: <1536957129-70380-1-git-send-email-fenghua.yu@intel.com>
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

Reinette Chatre (8):
  x86/intel_rdt: Fix size reporting of MBA resource
  x86/intel_rdt: Global closid helper to support future fixes
  x86/intel_rdt: Fix invalid mode warning when
  x86/intel_rdt: Fix unchecked MSR access
  x86/intel_rdt: Do not allow pseudo-locking of MBA resource
  x86/intel_rdt: Fix incorrect loop end condition
  x86/intel_rdt: Fix exclusive mode handling of MBA resource
  x86/intel_rdt: Fix incorrect loop end condition

Xiaochen Shen (1):
  x86/intel_rdt: Fix MBA parsing callback

 arch/x86/kernel/cpu/intel_rdt.h             |  3 +-
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 30 +++++++-----
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 53 +++++++++++++++++----
 3 files changed, 64 insertions(+), 22 deletions(-)

-- 
2.19.0

