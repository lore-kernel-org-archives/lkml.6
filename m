Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD0AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780D5205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780D5205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbeLEXU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:20:29 -0500
Received: from mga06.intel.com ([134.134.136.31]:24296 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbeLEXU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:20:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 15:20:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,320,1539673200"; 
   d="scan'208";a="281279555"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.154])
  by orsmga005.jf.intel.com with ESMTP; 05 Dec 2018 15:20:28 -0800
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
Subject: [RFC PATCH 0/4] x86: Add vDSO exception fixup for SGX
Date:   Wed,  5 Dec 2018 15:20:08 -0800
Message-Id: <20181205232012.28920-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First things first, this RFC is not intended to address whether or not
vDSO is the appropriate method for supporting SGX enclaves, but rather
its purpose is to hammer out the vDSO implementation *if* we decide it
is the best approach.

Though the code technically stands alone, the intent is to roll it
into the main SGX series once it has been beat on for a bit.  For that
reason there are no dependencies on CONFIG_SGX (which doesn't exist)
or any other bits that one might expect.

The quick and dirty is that for all intents and purposes, the SGX
architecture requires userspace to gracefully handle exceptions.  The
vast majority of enclaves are expected to leverage a library to handle
much of the plumbing.  Unfortunately for us (them?), putting two and
two together means SGX libraries would need to handle most signals on
behalf of the enclave's application, which is far from ideal.

One proposed solution for supporting SGX without requiring signals is
to wrap enclave transitions in a vDSO function so that SGX exceptions
can be intercepted via exception fixup and returned inline to the
caller.  This RFC series adds exception fixup and SGX support to the
vDSO.


Sean Christopherson (4):
  x86/vdso: Add support for exception fixup in vDSO functions
  x86/fault: Attempt to fixup unhandled #PF in vDSO before signaling
  x86/traps: Attempt to fixup exceptions in vDSO before signaling
  x86/vdso: Add __vdso_sgx_eenter() to wrap SGX enclave transitions

 arch/x86/entry/vdso/Makefile          |   5 +-
 arch/x86/entry/vdso/extable.c         |  37 +++++++++
 arch/x86/entry/vdso/extable.h         |  17 ++++
 arch/x86/entry/vdso/vdso-layout.lds.S |   9 ++-
 arch/x86/entry/vdso/vdso.lds.S        |   1 +
 arch/x86/entry/vdso/vdso2c.h          |  58 ++++++++++++--
 arch/x86/entry/vdso/vsgx_eenter.c     | 108 ++++++++++++++++++++++++++
 arch/x86/include/asm/vdso.h           |   5 ++
 arch/x86/kernel/traps.c               |  11 +++
 arch/x86/mm/fault.c                   |   7 ++
 10 files changed, 247 insertions(+), 11 deletions(-)
 create mode 100644 arch/x86/entry/vdso/extable.c
 create mode 100644 arch/x86/entry/vdso/extable.h
 create mode 100644 arch/x86/entry/vdso/vsgx_eenter.c

-- 
2.19.2

