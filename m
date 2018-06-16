Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46D0C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 03:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66949208DA
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 03:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66949208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756516AbeFPDH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 23:07:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:40643 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753907AbeFPDH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 23:07:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 20:07:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,228,1526367600"; 
   d="scan'208";a="233011909"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 15 Jun 2018 20:07:26 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>
Cc:     "Ashok Raj" <ashok.raj@intel.com>,
        "Alan Cox" <alan@linux.intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [RFC PATCH 0/8] x86: Enable a few new instructions
Date:   Fri, 15 Jun 2018 20:06:07 -0700
Message-Id: <1529118375-90191-1-git-send-email-fenghua.yu@intel.com>
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
APIs for user or kernel to call the instructions.

The sysfs interface files are in /sys/devices/system/cpu/user_wait because
it's hard to find existing place to host the files.

The user libraries for the instructions are in arch/x86/include/uapi/asm/.
Hopefully this is a right place to keep the libraries.

Detailed information on the instructions and the MSR can be found in
the latest Intel Architecture Instruction Set Extensions and Future
Features Programming Reference at
https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf

Fenghua Yu (8):
  x86/cpufeatures: Enumerate MOVDIRI instruction
  x86/cpufeatures: Enumerate MOVDIR64B instruction
  x86/cpufeatures: Enumerate UMONITOR, UMWAIT, and TPAUSE instructions
  cpuidle: Set up maximum umwait time and umwait states
  x86/umwait.c: Add sysfs interface to show tsc_khz
  x86/lib_direct_store.h: Add APIs for direct store instructions
  x86/lib_user_wait.h: Add APIs for user wait instructions
  selftests/x86: Self test for the APIs in lib_direct_store.h and
    lib_user_wait.h

 arch/x86/include/asm/cpufeatures.h               |   3 +
 arch/x86/include/asm/msr-index.h                 |   4 +
 arch/x86/include/uapi/asm/lib_direct_store.h     | 161 ++++++++++++++
 arch/x86/include/uapi/asm/lib_user_wait.h        | 255 +++++++++++++++++++++++
 arch/x86/power/Makefile                          |   1 +
 arch/x86/power/umwait.c                          | 123 +++++++++++
 tools/testing/selftests/x86/Makefile             |   5 +-
 tools/testing/selftests/x86/directstore_umwait.c | 202 ++++++++++++++++++
 8 files changed, 752 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/include/uapi/asm/lib_direct_store.h
 create mode 100644 arch/x86/include/uapi/asm/lib_user_wait.h
 create mode 100644 arch/x86/power/umwait.c
 create mode 100644 tools/testing/selftests/x86/directstore_umwait.c

-- 
2.5.0

