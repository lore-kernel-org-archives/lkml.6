Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1D2ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB7620779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB7620779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbeGWP3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:29:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:43703 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388166AbeGWP3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:29:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 07:27:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,393,1526367600"; 
   d="scan'208";a="242560338"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 23 Jul 2018 07:27:34 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>
Cc:     "Ashok Raj" <ashok.raj@intel.com>,
        "Alan Cox" <alan@linux.intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 0/7] x86: Enable a few new instructions
Date:   Mon, 23 Jul 2018 05:55:50 -0700
Message-Id: <1532350557-98388-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few new instructions including direct stores (movdiri and movdir64b)
and user wait (umwait, umonitor, and tpause) and IA32_MWAIT_CONTROL MSR to
control umwait/umonitor/tpause behaviors will be available in Tremont and
other future x86 processors.

This patch set enumerates the instructions, adds a sysfs interface for
user to configure the umwait/umonitor/tpause instructions, and provides
APIs for user to call the instructions.

The sysfs interface file are in /sys/devices/system/cpu/umwait_control/
umwait_enable_c0_2 because it's hard to find an existing place to host
the files.

The user APIs for the instructions are implemented as vDSO functions.

Detailed information on the instructions and the MSR can be found in
the latest Intel Architecture Instruction Set Extensions and Future
Features Programming Reference at
https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf

Changelog:

Based on comments from Thomas:
- Change user APIs to vDSO functions
- Change sysfs to positive logic and enable file name
- Change patch descriptions etc

Fenghua Yu (7):
  x86/cpufeatures: Enumerate MOVDIRI instruction
  x86/cpufeatures: Enumerate MOVDIR64B instruction
  x86/cpufeatures: Enumerate UMONITOR, UMWAIT, and TPAUSE instructions
  x86/umwait_contro: Set global umwait maximum time limit and umwait
    C0.2 state
  x86/vdso: Add vDSO functions for direct store instructions
  x86/vdso: Add vDSO functions for user wait instructions
  selftests/vDSO: Add selftest to test vDSO functions for direct store
    and user wait instructions

 arch/x86/entry/vdso/Makefile                      |   2 +-
 arch/x86/entry/vdso/vdirectstore.c                | 152 ++++++++
 arch/x86/entry/vdso/vdso.lds.S                    |  20 ++
 arch/x86/entry/vdso/vma.c                         |  21 ++
 arch/x86/entry/vdso/vuserwait.c                   | 233 +++++++++++++
 arch/x86/include/asm/cpufeatures.h                |   3 +
 arch/x86/include/asm/msr-index.h                  |   4 +
 arch/x86/include/asm/vdso_funcs_data.h            |  20 ++
 arch/x86/include/asm/vvar.h                       |   1 +
 arch/x86/power/Makefile                           |   1 +
 arch/x86/power/umwait.c                           | 116 +++++++
 tools/testing/selftests/vDSO/Makefile             |   4 +-
 tools/testing/selftests/vDSO/vdso_inst_test_x86.c | 405 ++++++++++++++++++++++
 13 files changed, 980 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/entry/vdso/vdirectstore.c
 create mode 100644 arch/x86/entry/vdso/vuserwait.c
 create mode 100644 arch/x86/include/asm/vdso_funcs_data.h
 create mode 100644 arch/x86/power/umwait.c
 create mode 100644 tools/testing/selftests/vDSO/vdso_inst_test_x86.c

-- 
2.5.0

