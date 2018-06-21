Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2321BC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CDA223CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CDA223CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754277AbeFUVSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:18:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:27241 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752650AbeFUVSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:18:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 14:18:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,253,1526367600"; 
   d="scan'208";a="48912102"
Received: from hanvin-mobl2.amr.corp.intel.com ([10.254.42.214])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jun 2018 14:18:01 -0700
From:   "H. Peter Anvin, Intel" <h.peter.anvin@intel.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     "H. Peter Anvin" <hpa@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        "Markus T . Metzger" <markus.t.metzger@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 0/7] x86/ptrace: regset access to the GDT and LDT
Date:   Thu, 21 Jun 2018 14:17:47 -0700
Message-Id: <20180621211754.12757-1-h.peter.anvin@intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin" <hpa@linux.intel.com>

Give a debugger access to the visible part of the GDT and LDT.  This
allows a debugger to find out what a particular segment descriptor
corresponds to; e.g. if %cs is 16, 32, or 64 bits.

v3:
	Requalify LDT segments for selectors that have actually changed.

v2:
	Add missing change to elf.h for the very last patch.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Markus T. Metzger <markus.t.metzger@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>

 arch/x86/Kconfig               |   4 +
 arch/x86/include/asm/desc.h    |  24 +++-
 arch/x86/include/asm/ldt.h     |  16 +++
 arch/x86/include/asm/segment.h |  10 ++
 arch/x86/kernel/Makefile       |   3 +-
 arch/x86/kernel/ldt.c          | 283 ++++++++++++++++++++++++++++++++---------
 arch/x86/kernel/ptrace.c       | 103 ++++++++++++++-
 arch/x86/kernel/tls.c          | 102 +++++----------
 arch/x86/kernel/tls.h          |   8 +-
 include/uapi/linux/elf.h       |   2 +
 10 files changed, 413 insertions(+), 142 deletions(-)
