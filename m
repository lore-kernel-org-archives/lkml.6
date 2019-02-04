Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F187BC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E972175B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbfBDUma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:42:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:31022 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729889AbfBDUm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:42:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 12:42:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="131064327"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Feb 2019 12:42:28 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH] x86/resctrl: Remove duplicate MSR_MISC_FEATURE_CONTROL definition
Date:   Mon,  4 Feb 2019 12:41:36 -0800
Message-Id: <ff6b95d9b6ef6f4ac96267f130719ba1af09614b.1549312475.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definition of MSR_MISC_FEATURE_CONTROL was first introduced in
commit 98af74599ea0 ("x86 msr_index.h: Define MSR_MISC_FEATURE_CONTROL")
and present in Linux since v4.11.

The Cache Pseudo-Locking code added this duplicate definition in more
recent commit f2a177292bd0 ("x86/intel_rdt: Discover supported platforms
via prefetch disable bits"), available since v4.19.

Remove the duplicate definition from the resctrl subsystem and let that
code obtain the needed definition from the core architecture msr-index.h
instead.

Fixes: f2a177292bd0 ("x86/intel_rdt: Discover supported platforms via prefetch disable bits")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 14bed6af8377..604c0e3bcc83 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -33,13 +33,6 @@
 #define CREATE_TRACE_POINTS
 #include "pseudo_lock_event.h"
 
-/*
- * MSR_MISC_FEATURE_CONTROL register enables the modification of hardware
- * prefetcher state. Details about this register can be found in the MSR
- * tables for specific platforms found in Intel's SDM.
- */
-#define MSR_MISC_FEATURE_CONTROL	0x000001a4
-
 /*
  * The bits needed to disable hardware prefetching varies based on the
  * platform. During initialization we will discover which bits to use.
-- 
2.17.0

