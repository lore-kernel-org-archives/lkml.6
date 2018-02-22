Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752519AbeBVGde (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 01:33:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:55370 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751594AbeBVGdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 01:33:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,377,1515484800";
   d="scan'208";a="31891772"
From: Ashok Raj <ashok.raj@intel.com>
To: bp@suse.de
Cc: Ashok Raj <ashok.raj@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: [v2 0/3] Patches to address some limitations in OS microcode loading.
Date: Wed, 21 Feb 2018 22:33:22 -0800
Message-Id: <1519281205-58951-1-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series to address limitations of OS microcode loading.

Review comments from Boris:

Changes since v1: Patch 1/3
- Check for revision to avoid duplicate microcode load in early load
- Added inline comments.

Changes since v1: Patch 2/3
- Change to native_wbinvd for early load.

Changes since v1: Patch 3/3
- Check for return code of stop_machine
- When microcode file load fails, stop on first error.
- If any of the present CPUs are offline, then stop reload.
  This is just for being paranoid. 
- Added more comments in commit log and inline in file.
- split some functionality from reload_store() per Boris's comments.

What's not done from review: TBD:
- Load microcode file only once. Added comments in source for future cleanup.
- Removing ucd->errors. (Gives a count of failed loads)


Ashok Raj (3):
  x86/microcode/intel: Check microcode revision before updating sibling
    threads
  x86/microcode/intel: Perform a cache flush before ucode update.
  x86/microcode: Quiesce all threads before a microcode update.

 arch/x86/kernel/cpu/microcode/core.c  | 207 ++++++++++++++++++++++++++++++----
 arch/x86/kernel/cpu/microcode/intel.c |  43 ++++++-
 2 files changed, 222 insertions(+), 28 deletions(-)

-- 
2.7.4
