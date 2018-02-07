Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754766AbeBGUTq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:19:46 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:59470 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754266AbeBGUTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:19:43 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org
Cc: dan.j.williams@intel.com, tglx@linutronix.de, ak@linux.intel.com,
        torvalds@linux-foundation.org, luto@kernel.org
Subject: [RFC v2 PATCH 0/7] x86/entry: simplify and unify SAVE/POP_REGS
Date: Wed,  7 Feb 2018 21:15:10 +0100
Message-Id: <20180207201517.6518-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The starting point for this series was the intention to interleave
the register clearing with register PUSH or MOV instructions, in order
to minimize the cost of the additional instructions required for the
register clearing. While at it, I noticed that a couple of macros in
arch/x86/entry/calling.h are unused and can be cleaned up.

Based on a preliminary version of this patch,[*] Linus suggested to
merge further codepaths and to use PUSH instead of MOV, as this should
be faster on newer CPUs.

[*] http://lkml.kernel.org/r/20180206212546.GA2026@light.dominikbrodowski.net and
    http://lkml.kernel.org/r/20180206213202.GB2026@light.dominikbrodowski.net

NOTE / WARNING: Please be *extremely* stringent in reviewing these
patches, *especially* concerning patch 6/7 (x86/entry: get rid of 
ALLOC_PT_GPREGS_ON_STACK and SAVE_AND_CLEAR_REGS).


Dominik Brodowski (7):
  x86/entry: merge SAVE_C_REGS and SAVE_EXTRA_REGS, remove unused
    extensions
  x86/entry: merge POP_C_REGS and POP_EXTRA_REGS
  x86/entry: interleave XOR register clearing with PUSH instructions
  x86/entry: introduce PUSH_AND_CLEAN_REGS
  x86/entry: use PUSH_AND_CLEAN_REGS in more cases
  x86/entry: get rid of ALLOC_PT_GPREGS_ON_STACK and SAVE_AND_CLEAR_REGS
  x86/entry: indent PUSH_AND_CLEAR_REGS and POP_REGS properly

 arch/x86/entry/calling.h  | 118 ++++++++++++++++++----------------------------
 arch/x86/entry/entry_64.S | 104 +++++++---------------------------------
 2 files changed, 62 insertions(+), 160 deletions(-)

-- 
2.16.1
