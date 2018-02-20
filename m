Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbeBTVBa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 16:01:30 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:46868 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751440AbeBTVB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 16:01:26 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org,
        brgerst@gmail.com, luto@kernel.org, jpoimboe@redhat.com
Cc: torvalds@linux-foundation.org, ak@linux.intel.com, tglx@linutronix.de,
        dan.j.williams@intel.com
Subject: [RFC PATCH v3 0/6] x86/entry/64: interrupt entry size reduction
Date: Tue, 20 Feb 2018 22:01:07 +0100
Message-Id: <20180220210113.6725-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is another re-spin of the interrupt entry size reduction patchset,
which applies on top of tip/pti and tries to implement what Linus
suggested a few days ago.[*]

Patch 1/5 provides the most significant cuttings (-3k) and gets us below
the text size of entry_64.o (by about 2k) compared to before I started
meddling with it. This patch is the most evolved of the set, yet saw the
helper function being renamed since v2.

The other five patches still need more discussion on whether each
additional step and the code complexity it adds is really worth it. And
stringent review, of course.

Overall, these patches provide for a sizeable cutting of up to 4.5k compared
to tip/pti:

   text	   data	    bss	    dec	    hex	filename
  19500	      0	      0	  19500	   4c2c	entry_64.o-orig (before 2e3f0098bc45)
  21088	      0	      0	  21088	   5260	entry_64.o-pti (as of ced5d0bf603f)
  18006	      0	      0	  18006	   4656	entry_64.o (patch 1/6)
  16623	      0	      0	  16623	   40ef	entry_64.o (patch 6/6)

Changes for v3:
- patch 1:
	- rename interrupt_helper to interrupt_entry (suggested by Josh
	  Poimboeuf)
	- do not add cld to interrupt_entry yet
- patch 2 (follow-up changes only)
- patch 3:
	- move cld from interrupt macro to interrupt_entry (suggestion
	  by Linus Torvalds to make this more explicit)
	- do not add cld to switch_to_thread_stack wrapper function, but
	  keep cld where it is entry_INT80_compat.
- patch 4: (follow-up changes only)
- patch 5 (NEW):
	- move ASM_CLAC to interrupt helper (suggested by Brian Gerst)
- patch 6 (was patch 5/5 in v2):
	- update commentary (suggested by Josh Poimboeuf)
	- remove unused UNWIND hint from entry_64_compat.S (suggested by
	  Josh Poimboeuf)

Changes for v2:
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

[*] http://lkml.kernel.org/r/CA+55aFwLTF3EtaQ4OpDv2UM41J=EU7gfemv=eVq+uQi31-usSg@mail.gmail.com

Dominik Brodowski (6):
  x86/entry/64: move PUSH_AND_CLEAR_REGS from interrupt macro to helper
    function
  x86/entry/64: move ENTER_IRQ_STACK from interrupt macro to
    interrupt_entry
  x86/entry/64: move switch_to_thread_stack to interrupt_entry
  x86/entry/64: remove interrupt macro
  x86/entry/64: move ASM_CLAC to interrupt_entry
  x86/entry/64: open-code switch_to_thread_stack

 arch/x86/entry/entry_64.S        | 132 ++++++++++++++++++++++++---------------
 arch/x86/entry/entry_64_compat.S |  17 ++++-
 2 files changed, 98 insertions(+), 51 deletions(-)

-- 
2.16.2
