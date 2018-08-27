Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6BBC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BB6206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BB6206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeH0NLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:11:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:11706 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbeH0NLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:11:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 02:25:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,294,1531810800"; 
   d="scan'208";a="75876892"
Received: from kookoo32-optiplex-9020.sh.intel.com ([10.239.37.4])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Aug 2018 02:25:07 -0700
From:   Gu Zhimin <kookoo.gu@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>,
        Yu Chen <yu.c.chen@intel.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhimin Gu <kookoo.gu@intel.com>
Subject: [PATCH 0/3] Fixes hibernation bugs on x86-32 system
Date:   Mon, 27 Aug 2018 17:41:18 +0800
Message-Id: <cover.1535361949.git.kookoo.gu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

Currently there are mainly three bugs in x86-32 system when doing
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
   code be overwriten when image kernel pages are being copied.
2. Set up temporary text mapping for the image kernel's jump address, so that
   after all the pages have been copied back, the system could jump to this address.
3. Switch to the original kernel page table during resume.

Furthermore, MD5 hash check for e820 map is also backported from 64bits

Zhimin Gu (3):
  x86, hibernate: Fix nosave_regions setup for hibernation
  x86, hibernate: Extract the common code of 64/32 bit system
  x86, hibernate: Backport several fixes from 64bits to 32bits
    hibernation

 arch/x86/Kconfig                  |   2 +-
 arch/x86/include/asm/suspend_32.h |   4 +
 arch/x86/kernel/setup.c           |   2 +-
 arch/x86/power/hibernate.c        | 253 ++++++++++++++++++++++++++++++++++++++
 arch/x86/power/hibernate_32.c     |  76 ++++++++----
 arch/x86/power/hibernate_64.c     | 241 +-----------------------------------
 arch/x86/power/hibernate_asm_32.S |  49 ++++++--
 arch/x86/power/hibernate_asm_64.S |   2 +-
 8 files changed, 353 insertions(+), 276 deletions(-)
 create mode 100644 arch/x86/power/hibernate.c

-- 
2.7.4

