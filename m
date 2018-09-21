Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AD9C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B585421547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B585421547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389324AbeIUMGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 08:06:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:41430 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbeIUMGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 08:06:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 23:19:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,283,1534834800"; 
   d="scan'208";a="234744635"
Received: from chenyu-desktop.sh.intel.com ([10.239.160.116])
  by orsmga004.jf.intel.com with ESMTP; 20 Sep 2018 23:19:28 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Zhimin Gu <kookoo.gu@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/12][v4] Backport several fixes from 64bits to 32bits hibernation 
Date:   Fri, 21 Sep 2018 14:24:46 +0800
Message-Id: <cover.1537448058.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are mainly three bugs in 32bits system when doing
hibernation:
1. The page copy code is not running in safe page, which might
   cause hang during resume.
2. There's no text mapping for the final jump address
   of the original kernel, which might cause the system jumping
   into illegal address and causes system hang during resume.
3. The restore kernel switches to its own kernel page table(swapper_pg_dir)
   rather than the original kernel page table after all the pages
   been copied back, which might cause invalid virtual-physical
   mapping issue during resume.

To solve these problems:

1. Copy the code core_restore_code to a safe page, to avoid the instruction
   code been overwritten when image kernel pages are being copied.
2. Set up temporary text mapping for the image kernel's jump address,
   so that after all the pages have been copied back, the system could
   jump to this address.
3. Switch to the original kernel page table during resume.

Furthermore, MD5 hash check for e820 map is also backported from 64bits
system.

In order to make this patch set more readable, these fixes are splitted
into several sub patches.

And use CONFIG_X86_64 to control the common code to be 'activated' for
32 bit system during each sub-patch for better maintaining.

Chen Yu (1):
  PM / hibernate: Check the success of generating md5 digest before
    hibernation

Zhimin Gu (11):
  x86, hibernate: Fix nosave_regions setup for hibernation
  x86-32/asm/power: Create stack frames in hibernate_asm_32.S
  x86, hibernate: Extract the common code of 64/32 bit system
  x86-32, hibernate: Enable CONFIG_ARCH_HIBERNATION_HEADER on 32bit
    system
  x86, hibernate: Rename temp_level4_pgt to temp_pgt
  x86-32, hibernate: Use temp_pgt as the temporary page table
  x86-32, hibernate: Use the page size macro instead of constant value
  x86-32, hibernate: Switch to original page table after resumed
  x86-32, hibernate: Switch to relocated restore code during resume on
    32bit system
  x86-32, hibernate: Set up temporary text mapping for 32bit system
  x86-32, hibernate: Adjust in_suspend after resumed on 32bit system

 arch/x86/Kconfig                  |   2 +-
 arch/x86/include/asm/suspend.h    |   8 +
 arch/x86/include/asm/suspend_32.h |   4 +
 arch/x86/kernel/setup.c           |   2 +-
 arch/x86/power/Makefile           |   2 +-
 arch/x86/power/hibernate.c        | 248 ++++++++++++++++++++++++++++++
 arch/x86/power/hibernate_32.c     |  52 +++++--
 arch/x86/power/hibernate_64.c     | 224 +--------------------------
 arch/x86/power/hibernate_asm_32.S |  37 ++++-
 arch/x86/power/hibernate_asm_64.S |   2 +-
 10 files changed, 334 insertions(+), 247 deletions(-)
 create mode 100644 arch/x86/power/hibernate.c

-- 
2.17.1

