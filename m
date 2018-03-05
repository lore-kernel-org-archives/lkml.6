Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELtRKf/MNufZGMh2xJFIDo6AK+YhkSnbohEBfEtwmJ+do8k4N4ZmjheiFxzd53VZZGXvf4UR
ARC-Seal: i=1; a=rsa-sha256; t=1520245570; cv=none;
        d=google.com; s=arc-20160816;
        b=tJdJslSrHPmbPVFL8fz9UsiqhzQKuJj+jaWNghkVuom7bCL5uQoGUHRzUC37kAXynC
         OIHTgf532c2xbY3x+5XNZXRQ6mmjsiM+2bafr4JjLSPgdtlVE8Q/5gG6fRo3Lj+pamUX
         YKq5bRFURhyLoOfct7Ymr5RLz/Gq8qi/MFojJe94i8aYnMvEdqBUleE5XCFb9ZtSGrER
         ZmDSxfEi+coHBTyAexhBOPBYzUByFSRd2uhKp9/51D3dHGhIwQ/DGkfSO1sYtZA7OWrE
         sfLcPug7m7RZsJlsDcEmg9KdolYuEVOu33MNrQzuh1VRfVfwfzaA0v7sjpl4O5uuQ619
         sN3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=hoLXwpH6HeYT4QiejW444GuAIUvUoqegLhUT/HT6Mi4=;
        b=HcSnlti88p+j5xjkGQR4zVvGjGp/dbwthKN3eakXL8VRiPP5Byp7824L0t90oeBANv
         qpsrkK5kb0TDumT1EwBvzXB/aWCtzsVuY4pKU8pcJFE3blmB+qzKaOEj8iw2LKDmmz1g
         v0c8CPkHCUzYJ4e/zZqgTqUn8+vmFSqklkSN2zp2L8/uN/FRTAIO5K5qZ4keeRaOaLTt
         CcdHXhEMz8LpxpnD/udhXjFy06oauF9PfkmTJahMPRbCIa3kxJ1Hv0gnejk4ZuQ6UHb/
         GitHHIeKmw211ZfefSRmPCnV2Mo1HvVfW48awtyyLz9+nLLoYvqjnIwfqsQXkimBVkOh
         W43g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=g2srU4uS;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=g2srU4uS;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
From: Joerg Roedel <joro@8bytes.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	aliguori@amazon.com,
	daniel.gruss@iaik.tugraz.at,
	hughd@google.com,
	keescook@google.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 00/34 v3] PTI support for x32
Date: Mon,  5 Mar 2018 11:25:29 +0100
Message-Id: <1520245563-8444-1-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093018072269426?=
X-GMAIL-MSGID: =?utf-8?q?1594093018072269426?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

here is an updated version of my PTI patches for x86-32. I
worked in the review comments and fixed a few bugs that were
found during review of v2.

In particular, the changes to v2 are:

	* Switched from movsb to movsl for stack copy
	* Simplified sysexit path to not do a full pt_regs
	  copy, copies now only 2 dwords to entry stack
	* Renamed pti_set_user_pgd() to pti_set_user_pgtbl()
	* Added a warning in case someone boots a 32 bit
	  kernel on a PCIE capable machine
	* Added switch to user-cr3 to the paranoid exit path
	  in case we entered the kernel from kernel-mode
	  with user-cr3
	* Simplified the debug handler now that all its
	  special cases are handled in the stack/cr3-switch
	  code
	* Fixed PGD_PAE_PHYS_MASK for XEN-PV
	
Here is a link to my post of the v2 patches:

	https://marc.info/?l=linux-kernel&m=151816914932088&w=2

And I also pushed these out to:

	git://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git pti-x32-v3

For easier testing. Please review.

Thanks,

	Joerg

Joerg Roedel (34):
  x86/asm-offsets: Move TSS_sp0 and TSS_sp1 to asm-offsets.c
  x86/entry/32: Rename TSS_sysenter_sp0 to TSS_entry_stack
  x86/entry/32: Load task stack from x86_tss.sp1 in SYSENTER handler
  x86/entry/32: Put ESPFIX code into a macro
  x86/entry/32: Unshare NMI return path
  x86/entry/32: Split off return-to-kernel path
  x86/entry/32: Restore segments before int registers
  x86/entry/32: Enter the kernel via trampoline stack
  x86/entry/32: Leave the kernel via trampoline stack
  x86/entry/32: Introduce SAVE_ALL_NMI and RESTORE_ALL_NMI
  x86/entry/32: Handle Entry from Kernel-Mode on Entry-Stack
  x86/entry/32: Simplify debug entry point
  x86/entry/32: Add PTI cr3 switches to NMI handler code
  x86/entry/32: Add PTI cr3 switch to non-NMI entry/exit points
  x86/pgtable: Rename pti_set_user_pgd to pti_set_user_pgtbl
  x86/pgtable/pae: Unshare kernel PMDs when PTI is enabled
  x86/pgtable/32: Allocate 8k page-tables when PTI is enabled
  x86/pgtable: Move pgdp kernel/user conversion functions to pgtable.h
  x86/pgtable: Move pti_set_user_pgtbl() to pgtable.h
  x86/pgtable: Move two more functions from pgtable_64.h to pgtable.h
  x86/mm/pae: Populate valid user PGD entries
  x86/mm/pae: Populate the user page-table with user pgd's
  x86/mm/legacy: Populate the user page-table with user pgd's
  x86/mm/pti: Add an overflow check to pti_clone_pmds()
  x86/mm/pti: Define X86_CR3_PTI_PCID_USER_BIT on x86_32
  x86/mm/pti: Clone CPU_ENTRY_AREA on PMD level on x86_32
  x86/mm/dump_pagetables: Define INIT_PGD
  x86/pgtable/pae: Use separate kernel PMDs for user page-table
  x86/ldt: Reserve address-space range on 32 bit for the LDT
  x86/ldt: Define LDT_END_ADDR
  x86/ldt: Split out sanity check in map_ldt_struct()
  x86/ldt: Enable LDT user-mapping for PAE
  x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32
  x86/mm/pti: Add Warning when booting on a PCIE capable CPU

 arch/x86/entry/entry_32.S                   | 668 ++++++++++++++++++++++------
 arch/x86/include/asm/mmu_context.h          |   4 -
 arch/x86/include/asm/pgtable-2level.h       |   9 +
 arch/x86/include/asm/pgtable-2level_types.h |   3 +
 arch/x86/include/asm/pgtable-3level.h       |   7 +
 arch/x86/include/asm/pgtable-3level_types.h |   6 +-
 arch/x86/include/asm/pgtable.h              |  88 ++++
 arch/x86/include/asm/pgtable_32_types.h     |   9 +-
 arch/x86/include/asm/pgtable_64.h           |  89 +---
 arch/x86/include/asm/pgtable_64_types.h     |   4 +
 arch/x86/include/asm/pgtable_types.h        |  28 +-
 arch/x86/include/asm/processor-flags.h      |   8 +-
 arch/x86/include/asm/switch_to.h            |   6 +-
 arch/x86/kernel/asm-offsets.c               |   5 +
 arch/x86/kernel/asm-offsets_32.c            |   2 +-
 arch/x86/kernel/asm-offsets_64.c            |   2 -
 arch/x86/kernel/cpu/common.c                |   5 +-
 arch/x86/kernel/head_32.S                   |  20 +-
 arch/x86/kernel/ldt.c                       | 137 ++++--
 arch/x86/kernel/process.c                   |   2 -
 arch/x86/kernel/process_32.c                |  10 +-
 arch/x86/mm/dump_pagetables.c               |  21 +-
 arch/x86/mm/pgtable.c                       | 105 ++++-
 arch/x86/mm/pti.c                           |  42 +-
 security/Kconfig                            |   2 +-
 25 files changed, 963 insertions(+), 319 deletions(-)

-- 
2.7.4
