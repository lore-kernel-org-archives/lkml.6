Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7A0C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1325206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1325206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeIKWOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:14:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:27760 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbeIKWOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:14:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 10:14:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,361,1531810800"; 
   d="scan'208";a="89096759"
Received: from chenyu-desktop.sh.intel.com ([10.239.160.116])
  by fmsmga001.fm.intel.com with ESMTP; 11 Sep 2018 10:14:07 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Pavel Machek <pavel@ucw.cz>, Rui Zhang <rui.zhang@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Zhimin Gu <kookoo.gu@intel.com>,
        Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/4][v2] Fixes hibernation bugs on x86-32 system
Date:   Wed, 12 Sep 2018 01:19:55 +0800
Message-Id: <cover.1536685746.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Chen Yu (1):
  PM / hibernate: Check the success of generating md5 digest before
    hibernation

Zhimin Gu (3):
  x86, hibernate: Fix nosave_regions setup for hibernation
  x86, hibernate: Extract the common code of 64/32 bit system
  x86, hibernate: Backport several fixes from 64bits to 32bits
    hibernation

 arch/x86/Kconfig                  |   2 +-
 arch/x86/include/asm/suspend_32.h |   4 +
 arch/x86/kernel/setup.c           |   2 +-
 arch/x86/power/hibernate.c        | 263 ++++++++++++++++++++++++++++++
 arch/x86/power/hibernate_32.c     |  60 ++++---
 arch/x86/power/hibernate_64.c     | 242 +--------------------------
 arch/x86/power/hibernate_asm_32.S |  49 +++++-
 arch/x86/power/hibernate_asm_64.S |   2 +-
 8 files changed, 350 insertions(+), 274 deletions(-)
 create mode 100644 arch/x86/power/hibernate.c

-- 
2.17.1

