Return-Path: <maran.wilson@oracle.com>
X-Google-Smtp-Source: AIpwx4+hEuGhmjtJkCYyp18Zx+QmFLlngAZG1W9rq5Emi0puAcXvpfqoIP90EZex5NgLuwr9kmUN
ARC-Seal: i=1; a=rsa-sha256; t=1523920222; cv=none;
        d=google.com; s=arc-20160816;
        b=yOpJ9RFC4Avn9UqvSylUPNfQtONVakOMKyx4fRXjAeFRaAQrNK4KEqT6SQinlAvz2M
         LEHjA/QWDS22ZDxy05Ssc3pcEjP1hpjq6purI4ZHfzVhMYY3TzcqZmOE22lq/F7XvGCF
         ptJ+E+3r6wh6hpxc1VYvEcvedQecz3Unn8cdFsaxEqwp/xIoJ33aA25WEJ8pdhUkO6Od
         I5MKjulY2ucHGCvRv0+Adb3EGMEEVpJOSTnZtPX8B6/M/kscikF5EhxoqIiijQJykecZ
         yNZSISKu3PHn/jGfinwsWuhSquIlupP2mOqI4gmD1dZWGjbqj3ymxe/mFjAc1lPLn5LH
         uj0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=jHb8nOeg4SLUQhJFe/wpjr/SZgyCrPzl7LVwhmihY9g=;
        b=TiwmfD+6cLCblQbUBnMFvFjbU0f2N1rF6XD9llRRolwRqtEdtsB0am3W8NnSlmHr1J
         K6Z/x0eYpCSsIkXgQOOOfqkTm/dm+jU5UzxHFluKVvi+aplsZhclV46TNRgTWzBmLWgC
         QlP0a1guaWxDgKQ6MU1CCXi3dXYd0OQhfUQ0+X49qYbPRx91mjE5AF15wrdJN4DHWnFW
         iLwBEYyziS59t0Rta4CfMuoghrn6zZh5BY24iMf+Osrv1sjtIjI43cXVvmckeXpyje1y
         CL10F0FX/lUNhmxTnssgCbtunOnMilUAuVscA5ww3r499GrxjFfYY85lWh1fvlqTmrJg
         /0gA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=A4m6WgN1;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=A4m6WgN1;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Maran Wilson <maran.wilson@oracle.com>
To: x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com,
        jgross@suse.com
Cc: boris.ostrovsky@oracle.com, bp@suse.de, dave.hansen@linux.intel.com,
        davem@davemloft.net, gregkh@linuxfoundation.org, hpa@zytor.com,
        jpoimboe@redhat.com, kirill.shutemov@linux.intel.com,
        linus.walleij@linaro.org, luto@kernel.org, mchehab@kernel.org,
        mingo@redhat.com, rdunlap@infradead.org, tglx@linutronix.de,
        thomas.lendacky@amd.com, hch@infradead.org, roger.pau@citrix.com,
        rkrcmar@redhat.com, maran.wilson@oracle.com
Subject: [PATCH v7 0/7] KVM: x86: Allow Qemu/KVM to use PVH entry point
Date: Mon, 16 Apr 2018 16:09:35 -0700
Message-Id: <1523920175-27287-1-git-send-email-maran.wilson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8865 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=7 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804160191
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597946171029255726?=
X-GMAIL-MSGID: =?utf-8?q?1597946171029255726?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For certain applications it is desirable to rapidly boot a KVM virtual
machine. In cases where legacy hardware and software support within the
guest is not needed, Qemu should be able to boot directly into the
uncompressed Linux kernel binary without the need to run firmware.

There already exists an ABI to allow this for Xen PVH guests and the ABI
is supported by Linux and FreeBSD:

   https://xenbits.xen.org/docs/unstable/misc/pvh.html

This patch series would enable Qemu to use that same entry point for
booting KVM guests.

Changes from v6:

 * Addressed issues caught by the kbuild test robot:
    - Restored an #include line that had been dropped by mistake (patch 4)
    - Removed a pair of #include lines that were no longer needed in a
      common code file and causing problems for certain 32-bit configs
      (patchs 4 and 7)

Changes from v5:

 * The interface changes to the x86/HVM start info layout have
   now been accepted into the Xen tree.
 * Rebase and merge upstream PVH file changes.
 * (Patch 6) Synced up to the final version of the header file that was
             acked and pulled into the Xen tree.
 * (Patch 1) Fixed typo and removed redundant "def_bool n" line.

Changes from v4:

Note: I've withheld Juergen's earlier "Reviewed-by" tags from patches
1 and 7 since there were minor changes (mostly just addition of
CONFIG_KVM_GUEST_PVH as requested) that came afterwards.

 * Changed subject prefix from RFC to PATCH
 * Added CONFIG_KVM_GUEST_PVH as suggested
 * Relocated the PVH common files to
   arch/x86/platform/pvh/{enlighten.c,head.S}
 * Realized I also needed to move the objtool override for those files
 * Updated a few code comments per reviewer feedback
 * Sent out a patch of the hvm_start_info struct changes against the Xen
   tree since that is the canonical copy of the header. Discussions on
   that thread have resulted in some (non-functional) updates to
   start_info.h (patch 6/7) and those changes are reflected here as well
   in order to keep the files in sync. The header file has since been
   ack'ed for the Xen tree by Jan Beulich.

Changes from v3:

 * Implemented Juergen's suggestion for refactoring and moving the PVH
   code so that CONFIG_XEN is no longer required for booting KVM guests
   via the PVH entry point.
   Functionally, nothing has changed from V3 really, but the patches
   look completely different now because of all the code movement and
   refactoring. Some of these patches can be combined, but I've left
   them very small in some cases to make the refactoring and code
   movement easier to review.
   My approach for refactoring has been to create a PVH entry layer that
   still has understanding and knowledge about Xen vs non-Xen guest types
   so that it can make run time decisions to handle either case, as
   opposed to going all the way and re-writing it to be a completely
   hypervisor agnostic and architecturally pure layer that is separate
   from guest type details. The latter seemed a bit overkill in this
   situation. And I've handled the complexity of having to support
   Qemu/KVM boot of kernels compiled with or without CONFIG_XEN via a
   pair of xen specific __weak routines that can be overridden in kernels
   that support Xen guests. Importantly, the __weak routines are for
   xen specific code only (not generic "guest type" specific code) so
   there is no clashing between xen version of the strong routine and,
   say, a KVM version of the same routine. But I'm sure there are many
   ways to skin this cat, so I'm open to alternate suggestions if there
   is a compelling reason for not using __weak in this situation.

Changes from v2:

 * All structures (including memory map table entries) are padded and
   aligned to an 8 byte boundary.

 * Removed the "packed" attributes and made changes to comments as
   suggested by Jan.

Changes from v1:

 * Adopted Paolo's suggestion for defining a v2 PVH ABI that includes the
   e820 map instead of using the second module entry to pass the table.

 * Cleaned things up a bit to reduce the number of xen vs non-xen special
   cases.


Maran Wilson (7):
  xen/pvh: Split CONFIG_XEN_PVH into CONFIG_PVH and CONFIG_XEN_PVH
  xen/pvh: Move PVH entry code out of Xen specific tree
  xen/pvh: Create a new file for Xen specific PVH code
  xen/pvh: Move Xen specific PVH VM initialization out of common file
  xen/pvh: Move Xen code for getting mem map via hcall out of common
    file
  xen/pvh: Add memory map pointer to hvm_start_info struct
  KVM: x86: Allow Qemu/KVM to use PVH entry point

 MAINTAINERS                                     |   1 +
 arch/x86/Kbuild                                 |   2 +
 arch/x86/Kconfig                                |  14 +++
 arch/x86/kernel/head_64.S                       |   2 +-
 arch/x86/platform/pvh/Makefile                  |   5 +
 arch/x86/platform/pvh/enlighten.c               | 136 ++++++++++++++++++++++++
 arch/x86/{xen/xen-pvh.S => platform/pvh/head.S} |   0
 arch/x86/xen/Kconfig                            |   3 +-
 arch/x86/xen/Makefile                           |   2 -
 arch/x86/xen/enlighten_pvh.c                    |  93 +++-------------
 include/xen/interface/hvm/start_info.h          |  63 ++++++++++-
 11 files changed, 240 insertions(+), 81 deletions(-)
 create mode 100644 arch/x86/platform/pvh/Makefile
 create mode 100644 arch/x86/platform/pvh/enlighten.c
 rename arch/x86/{xen/xen-pvh.S => platform/pvh/head.S} (100%)

-- 
2.16.1
