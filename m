Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42ECFC6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0927820852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0927820852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388922AbeGXVt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:49:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:61800 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388858AbeGXVtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:49:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 13:40:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,399,1526367600"; 
   d="scan'208";a="74172835"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2018 13:40:29 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH 0/7] x86/intel_rdt: Restoration of Cache Pseudo-Locked regions
Date:   Tue, 24 Jul 2018 13:40:11 -0700
Message-Id: <cover.1532463771.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Maintainers,

A Cache Pseudo-Locked region is vulnerable to certain instructions (INVD,
WBINVD, CLFLUSH) or deeper C-states (that could shrink or power off the
cache) evicting the pseudo-locked memory. The current support for
pseudo-locked regions already restrict deeper C-states on cores associated
with the pseudo-locked regions, but the vulnerability to some instructions
remain.

This work does not prevent the instructions to which Cache Pseudo-Locked
regions are vulnerable, instead, this work support the restoration of
Cache Pseudo-Locked regions that can be triggered manually by the user
or automatically after the WBINVD instruction has been issued.

A new debugfs file "pseudo_lock_restore" is associated with each
pseudo-locked region and can be used to manually trigger the memory
associated with the region to be pseudo-locked to cache again.

The system-wide "native_wbinvd()" is modified to trigger the restoration of
all Cache Pseudo-Locked regions after the WBINVD instruction returns and
effort is made to avoid any unnecessary work in this flow.

Within the kernel two locations with direct invocations of the WBINVD
instruction are coverted to native_wbinvd() and compile tested. Neither
location is likely to be used on the platforms supporting Cache Pseudo-Locking.

I am sending this as RFC to maintainers of core first to obtain feedback on
the approach before including the maintainers of other subsystems changed.

Your feedback on this proposal would be greatly appreciated.

Reinette

Reinette Chatre (7):
  x86/intel_rdt: Expose useful functions to all RDT code
  x86/intel_rdt: Enable a pseudo-locked region to be restored
  x86/intel_rdt: Enable user to trigger pseudo-locked region restore
  x86/intel_rdt: Support restore of all pseudo-locked regions
  x86/intel_rdt: Trigger pseudo-lock restore after wbinvd call
  mtd: replace direct wbinvd invoke with kernel api
  video: fbdev: i810: replace direct wbinvd invoke with kernel api

 Documentation/x86/intel_rdt_ui.txt          |  18 +-
 arch/x86/include/asm/special_insns.h        |  13 +-
 arch/x86/kernel/cpu/intel_rdt.h             |   2 +
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 198 +++++++++++++++++++-
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    |   4 +-
 drivers/mtd/maps/nettel.c                   |   6 +-
 drivers/video/fbdev/i810/i810_main.h        |   2 +-
 7 files changed, 229 insertions(+), 14 deletions(-)

-- 
2.17.0

