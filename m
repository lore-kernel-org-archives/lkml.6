Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6700C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914032082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914032082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbeLFWT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:19:29 -0500
Received: from mga06.intel.com ([134.134.136.31]:39981 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLFWT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:19:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 14:19:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="99313296"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.154])
  by orsmga008.jf.intel.com with ESMTP; 06 Dec 2018 14:19:28 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [RFC PATCH v2 0/4] x86: Add vDSO exception fixup for SGX
Date:   Thu,  6 Dec 2018 14:19:18 -0800
Message-Id: <20181206221922.31012-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version is almost entirely about the vDSO function itself,
i.e. patch 4/4.  Feel free to ignore patches 2/4 and 3/4, I need
to do (a lot) more legwork to address feedback and improve their
changelogs.  I'm expecting that to take a fair amount of time and
wanted to get the alternative exit handler idea out there ASAP.

The new vDSO function builds but is otherwise completely untested.

v2:
  - For all intents and purposes, rewrite the SGX vDSO function.
    This version is quite a bit different than anything discussed in
    the past.  Rather than provide separate a separate function or an
    explicit parameter to request ERESUME, e.g. to recover after a
    fault, take an optional "exit handler" that provides the caller
    the opportunity to specify if and how the enclave should be
    resumed.  More details in the changelog.

  - Rename it to __vdso_sgx_enter_enclave() to abstract the details
    of EENTER and ERESUME to some degree.

  - Give the enclave RDI, RSI and RDX to pass data out of the enclave.

  - Call fixup_vdso_exception() in do_int3().


v1: https://lkml.kernel.org/r/20181205232012.28920-1-sean.j.christopherson@intel.com


Sean Christopherson (4):
  x86/vdso: Add support for exception fixup in vDSO functions
  x86/fault: Attempt to fixup unhandled #PF in vDSO before signaling
  x86/traps: Attempt to fixup exceptions in vDSO before signaling
  x86/vdso: Add __vdso_sgx_enter_enclave() to wrap SGX enclave
    transitions

 arch/x86/entry/vdso/Makefile             |   5 +-
 arch/x86/entry/vdso/extable.c            |  37 +++++++
 arch/x86/entry/vdso/extable.h            |  17 ++++
 arch/x86/entry/vdso/vdso-layout.lds.S    |   9 +-
 arch/x86/entry/vdso/vdso.lds.S           |   1 +
 arch/x86/entry/vdso/vdso2c.h             |  58 +++++++++--
 arch/x86/entry/vdso/vsgx_enter_enclave.c | 119 +++++++++++++++++++++++
 arch/x86/include/asm/vdso.h              |   5 +
 arch/x86/kernel/traps.c                  |  15 +++
 arch/x86/mm/fault.c                      |   7 ++
 10 files changed, 262 insertions(+), 11 deletions(-)
 create mode 100644 arch/x86/entry/vdso/extable.c
 create mode 100644 arch/x86/entry/vdso/extable.h
 create mode 100644 arch/x86/entry/vdso/vsgx_enter_enclave.c

-- 
2.19.2

