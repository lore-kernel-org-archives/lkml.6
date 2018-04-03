Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755324AbeDCJMv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 05:12:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753452AbeDCJMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 05:12:50 -0400
Date: Tue, 3 Apr 2018 11:12:42 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 4.17 merge window #1
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18040309-0040-0000-0000-000004491295
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040309-0041-0000-0000-000020ED1C46
Message-Id: <20180403111242.49f43ee7@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804030100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

 * Improvements for the spectre defense:
   - The spectre related code is consolidated to a single file nospec-branch.c
   - Automatic enable/disable for the spectre v2 defenses (expoline vs. nobp)
   - Syslog messages for specve v2 are added
   - Enable CONFIG_GENERIC_CPU_VULNERABILITIES and define the attribute
     functions for spectre v1 and v2

 * Add helper macros for assembler alternatives and use them to shorten
   the code in entry.S.

 * Add support for persistent configuration data via the SCLP Store Data
   interface. The H/W interface requires a page table that uses 4K pages
   only, the code to setup such an address space is added as well.

 * Enable virtio GPU emulation in QEMU. To do this the depends statements
   for a few common Kconfig options are modified.

 * Add support for format-3 channel path descriptors and add a binary
   sysfs interface to export the associated utility strings.

 * Add a sysfs attribute to control the IFCC handling in case of constant
   channel errors.

 * The vfio-ccw changes from Cornelia.

 * Bug fixes and cleanups.

There is a trivial merge conflict in drivers/video/console/Kconfig.

Christian Borntraeger (2):
      s390/sclp_tty: enable line mode tty even if there is an ascii console
      s390/defkeymap: fix global init to zero

Claudio Imbrenda (4):
      s390/sclp: clean up, use sccb_mask_t where appropriate
      s390/sclp: generic event mask accessors
      s390/sclp: 32 bit event mask compatibility mode
      s390/sclp: 64 bit event mask

Cornelia Huck (3):
      s390: fix comment for scsw_cmd_is_valid_sctl
      vfio-ccw: update documentation
      vfio-ccw: fence off transport mode

Farhan Ali (3):
      Kconfig : Remove HAS_IOMEM dependency for Graphics support
      s390/char : Rename EBCDIC keymap variables
      s390/setup : enable display support for KVM guest

Harald Freudenberger (1):
      s390/crypto: Fix kernel crash on aes_s390 module remove.

Heiko Carstens (1):
      s390/mm: provide base_asce_alloc() / base_asce_free() helper functions

Julian Wiedmann (6):
      s390: fix typo in irb description
      s390/qdio: simplify math in get_*_buffer_frontier()
      s390/qdio: don't merge ERROR output buffers
      s390/qdio: restrict buffer merging to eligible devices
      s390/qdio: don't retry EQBS after CCQ 96
      s390/qdio: split up CCQ handling for EQBS / SQBS

Martin Schwidefsky (8):
      s390: move nobp parameter functions to nospec-branch.c
      s390: add automatic detection of the spectre defense
      s390: report spectre mitigation via syslog
      s390: add sysfs attributes for spectre
      s390: add assembler macros for CPU alternatives
      s390/entry.S: use assembler alternatives
      s390/lpp: use assembler alternatives for the LPP instruction
      s390/kvm: improve stack frame constants in entry.S

Peter Oberparleiter (1):
      s390/sclp: Add support for Store Data SCLP interface

Sebastian Ott (4):
      s390/cio: fix unbind of io_subchannel_driver
      s390/cio: rename struct channel_path_desc
      s390/chsc: query utility strings via fmt3 channel path descriptor
      s390/cio: add util_string sysfs attribute

Stefan Haberland (3):
      s390/dasd: configurable IFCC handling
      s390/dasd: remove unneeded sanity check
      s390/dasd: set timestamps unconditionally

Vasily Gorbik (4):
      s390/decompressor: discard __ex_table section
      s390: unify linker symbols usage
      s390: set bzImage as default image for packaging
      s390/decompressor: trim uncompressed image head during the build

 Documentation/s390/vfio-ccw.txt         |  79 +++--
 arch/s390/Kconfig                       |   3 +-
 arch/s390/Makefile                      |   8 +-
 arch/s390/boot/compressed/Makefile      |  16 +-
 arch/s390/boot/compressed/head.S        |   6 +-
 arch/s390/boot/compressed/misc.c        |  10 +-
 arch/s390/boot/compressed/vmlinux.lds.S |   1 +
 arch/s390/crypto/aes_s390.c             |   5 +-
 arch/s390/include/asm/alternative-asm.h | 108 ++++++
 arch/s390/include/asm/ccwdev.h          |   2 +-
 arch/s390/include/asm/chpid.h           |   2 +-
 arch/s390/include/asm/cio.h             |   2 +-
 arch/s390/include/asm/cpu_mf.h          |   4 +-
 arch/s390/include/asm/css_chars.h       |   6 +-
 arch/s390/include/asm/nospec-branch.h   |   6 +-
 arch/s390/include/asm/pgalloc.h         |   3 +
 arch/s390/include/asm/scsw.h            |   4 +-
 arch/s390/include/asm/setup.h           |   2 -
 arch/s390/include/uapi/asm/dasd.h       |  38 ++-
 arch/s390/kernel/Makefile               |   4 +-
 arch/s390/kernel/alternative.c          |  24 +-
 arch/s390/kernel/asm-offsets.c          |   1 +
 arch/s390/kernel/early.c                |   4 +-
 arch/s390/kernel/entry.S                |  96 ++----
 arch/s390/kernel/module.c               |  11 +-
 arch/s390/kernel/nospec-branch.c        | 120 +++++--
 arch/s390/kernel/setup.c                |  22 +-
 arch/s390/kernel/suspend.c              |   4 +-
 arch/s390/mm/dump_pagetables.c          |   4 +-
 arch/s390/mm/pgalloc.c                  | 293 +++++++++++++++-
 drivers/s390/block/dasd.c               |   9 +-
 drivers/s390/block/dasd_3990_erp.c      |  17 +-
 drivers/s390/block/dasd_devmap.c        |  43 ++-
 drivers/s390/block/dasd_eckd.c          |  27 +-
 drivers/s390/char/Makefile              |   2 +-
 drivers/s390/char/defkeymap.c           |  66 ++--
 drivers/s390/char/keyboard.c            |  32 +-
 drivers/s390/char/keyboard.h            |  11 +
 drivers/s390/char/sclp.c                |  58 ++--
 drivers/s390/char/sclp.h                |  61 +++-
 drivers/s390/char/sclp_early.c          |   2 +-
 drivers/s390/char/sclp_early_core.c     |  38 ++-
 drivers/s390/char/sclp_sd.c             | 569 ++++++++++++++++++++++++++++++++
 drivers/s390/char/sclp_tty.c            |   5 +-
 drivers/s390/cio/chp.c                  |  34 +-
 drivers/s390/cio/chp.h                  |   5 +-
 drivers/s390/cio/chsc.c                 |  59 ++--
 drivers/s390/cio/chsc.h                 |  11 +-
 drivers/s390/cio/device.c               |  16 +-
 drivers/s390/cio/device_ops.c           |   4 +-
 drivers/s390/cio/qdio_main.c            | 131 ++++----
 drivers/s390/cio/vfio_ccw_fsm.c         |   5 +
 drivers/s390/net/qeth_core_main.c       |   2 +-
 drivers/tty/Kconfig                     |   2 +-
 drivers/video/Kconfig                   |   5 +-
 drivers/video/console/Kconfig           |   6 +-
 56 files changed, 1633 insertions(+), 475 deletions(-)
 create mode 100644 arch/s390/include/asm/alternative-asm.h
 create mode 100644 drivers/s390/char/sclp_sd.c
