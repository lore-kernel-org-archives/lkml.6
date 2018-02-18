Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeBRMeB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 07:34:01 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:51530 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbeBRMdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 07:33:55 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org,
        brgerst@gmail.com, luto@kernel.org, jpoimboe@redhat.com
Cc: torvalds@linux-foundation.org, ak@linux.intel.com, tglx@linutronix.de,
        dan.j.williams@intel.com
Subject: [RFC PATCH v2 0/5] x86/entry/64: interrupt entry size reduction
Date: Sun, 18 Feb 2018 13:31:11 +0100
Message-Id: <20180218123116.21334-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a re-spin of the interrupt entry size reduction patchset, which
applies on top of tip/pti and tries to implement what Linus suggested a
few days ago.[*]

Patch 1/5 provides the most significant cuttings (-3k) and gets us below
the text size of entry_64.o (by about 2k) compared to before I started
meddling with it. This patch is unchanged to v1 and seems to be the most
trivial of this patchset (famous last words), but still requires
stringent review before being applied.

The other four patches still need more discussion on whether each additional
step and the code complexity it adds is really worth it. And stringent
review, of course.

Overall, these patches provide for a sizeable cutting of up to 4.1k compared
to tip/pti:

   text	   data	    bss	    dec	    hex	filename
  19500	      0	      0	  19500	   4c2c	entry_64.o-orig (before 2e3f0098bc45)
  21088	      0	      0	  21088	   5260	entry_64.o-pti (as of ced5d0bf603f)
  18006	      0	      0	  18006	   4656	entry_64.o (patch 1/5)
  16882	      0	      0	  16882	   41f2	entry_64.o (patch 5/5)

[*] http://lkml.kernel.org/r/CA+55aFwLTF3EtaQ4OpDv2UM41J=EU7gfemv=eVq+uQi31-usSg@mail.gmail.com

Changes since v1:
- patch 1 (unchanged)
- patch 2:
	- use leaq 8() instead of mov+addq in ENTER_IRQ_STACK (suggested
	  by Brian Gerst)
	- add UNWIND_HINT_REGS indirect=1 after call to interrupt_helper;
	  update size information accordingly
- patch 3:
	- add cld to switch_to_thread_stack wrapper function
	- improve commit message
	- update size information
- patch 4:
	- add UNWIND_HINT_REGS indirect=1 to the now-removed interrupt
	  macro
- patch 5 (NEW):
	- open-code the DO_SWITCH_TO_THREAD_STACK macro (suggested by
	  Brian Gerst)
	- improve (?) UNWIND hints

Dominik Brodowski (5):
  x86/entry/64: move PUSH_AND_CLEAR_REGS from interrupt macro to helper
    function
  x86/entry/64: move ENTER_IRQ_STACK from interrupt macro to helper
    function
  x86/entry/64: move switch_to_thread_stack to interrupt helper function
  x86/entry/64: remove interrupt macro
  x86/entry/64: open-code switch_to_thread_stack

 arch/x86/entry/entry_64.S        | 105 +++++++++++++++++++++++----------------
 arch/x86/entry/entry_64_compat.S |  19 ++++++-
 2 files changed, 81 insertions(+), 43 deletions(-)

-- 
2.16.1
