Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8987C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4CA20873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfAPVYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:24:39 -0500
Received: from mga11.intel.com ([192.55.52.93]:32307 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729505AbfAPVYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:24:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 13:24:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,487,1539673200"; 
   d="scan'208";a="117269594"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jan 2019 13:24:34 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@amacapital.net>,
        "Andrew Cooper" <andrew.cooper3@citrix.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 0/3] x86/umwait: Enable user wait instructions
Date:   Wed, 16 Jan 2019 13:18:39 -0800
Message-Id: <1547673522-226408-5-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1547673522-226408-1-git-send-email-fenghua.yu@intel.com>
References: <1547673522-226408-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User wait instructions (umwait, umonitor, and tpause) and
IA32_MWAIT_CONTROL MSR to control umwait/umonitor/tpause behaviors
will be available in Tremont and other future x86 processors.

This patch set enumerates the instructions, adds a sysfs interface for
user to configure the umwait/umonitor/tpause instructions.

The sysfs interface files are in /sys/devices/system/cpu/umwait_control/
because it's hard to find an existing place to host the files.

The instructions generates #GP if CR4.TSD=1 and CPL>0. If user worries
security issues from the instructions, disabling TSC can prevent
malicious code from executing the instructions.

Detailed information on the instructions and the MSR can be found in
the latest Intel Architecture Instruction Set Extensions and Future
Features Programming Reference.

Changelog:
v2:
- Address comments from Thomas Gleixner and Andy Lutomirski
- Remove vDSO functions
- Add sysfs control file for umwait max time

v1:
Based on comments from Thomas:
- Change user APIs to vDSO functions
- Change sysfs to positive logic and enable file name
- Change patch descriptions etc

Fenghua Yu (3):
  x86/cpufeatures: Enumerate user wait instructions
  x86/umwait: Setup umwait C0.2 state
  x86/umwait: Control umwait maximum time

 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/msr-index.h   |   6 ++
 arch/x86/power/Makefile            |   1 +
 arch/x86/power/umwait.c            | 154 +++++++++++++++++++++++++++++
 4 files changed, 162 insertions(+)
 create mode 100644 arch/x86/power/umwait.c

-- 
2.19.1

