Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051DEC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 00:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FEA2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 00:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbeLZAoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 19:44:02 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:57126 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeLZAn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 19:43:58 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 7ADB929501; Tue, 25 Dec 2018 19:43:55 -0500 (EST)
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org
Message-Id: <cover.1545784679.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v8 00/25] Re-use nvram module
Date:   Wed, 26 Dec 2018 11:37:59 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic NVRAM module, drivers/char/generic_nvram.c, implements a
/dev/nvram misc device. This module is used only by 32-bit PowerPC
platforms. Unfortunately, it isn't generic enough to be more widely used.

The RTC "CMOS" NVRAM module, drivers/char/nvram.c, also implements a
/dev/nvram misc device. This module is now used only by x86 and m68k
thanks to commit 3ba9faedc180 ("char: nvram: disable on ARM").

The "generic" module cannot be used by x86 or m68k platforms because it
cannot co-exist with the "CMOS" module. One reason for that is the
CONFIG_GENERIC_NVRAM kludge in drivers/char/Makefile. Another reason is
that automatically loading the appropriate module would be impossible
because only one module can provide the 'char-major-10-144' alias.

A multi-platform kernel binary needs a single generic module. With this
patch series, drivers/char/nvram.c becomes more generic and some
arch-specific code gets moved under arch/. The 'nvram' module is then
usable by all m68k, powerpc and x86 platforms.

This allows for removal of drivers/char/generic_nvram.c as well as some
duplicated code in arch/powerpc/kernel/nvram_64.c. By reducing the number
of /dev/nvram char misc device implementations, the number of bugs and
inconsistencies is also reduced.

This patch series reduces inconsistencies between PPC32 and PPC64, and
between PPC_PMAC and MAC. A uniform API has benefits for userspace.
For example, some error codes for some ioctl calls become consistent
across PowerPC platforms. The uniform API can potentially benefit
bootloaders that work across different platforms which all have XPRAM
(e.g. Emile).

I think there are two reasonable merge strategies for this patch series.
The char misc maintainer could take the entire series. Alternatively the
m68k maintainer could take patches 1 thru 14, and after those patches
reach mainline the powerpc maintainer could take 15 thru 25 (even though
patch 21 is not powerpc-related).

This patch series has been tested on m68k, powerpc32, powerpc64 and x86.
The nvram and thinkpad_acpi modules were regression tested on a ThinkPad
T43. The /dev/nvram functionality was also regression tested on a G3
PowerMac. The nvram module was also tested on a variety of m68k Macs
and an Atari Falcon. The PPC64 changes were tested on a G5 PowerMac.
AFAIK, there's been no testing on pSeries or CHRP as yet.

Changed since v7:
 - Rebased.
 - Dropped patch 9/26, "char/nvram: Use generic fixed_size_llseek()"
because generic_file_llseek_size() was adopted in commit b808b1d632f6.
 - Reordered the m68k and powerpc patches to simplify the merge strategy.
 - Addressed some trivial checkpatch.pl complaints.
 - Improved some commit log entries.
 - Changed the CONFIG_NVRAM default to better approximate the present code.
In particular, the CONFIG_GENERIC_NVRAM default and use of "select NVRAM".
 - Added more tested-by tags.

For older change logs, please refer to,
https://lore.kernel.org/lkml/20151101104202.301856132@telegraphics.com.au/


Finn Thain (25):
  scsi/atari_scsi: Don't select CONFIG_NVRAM
  m68k/atari: Move Atari-specific code out of drivers/char/nvram.c
  m68k/atari: Replace nvram_{read,write}_byte with arch_nvram_ops
  char/nvram: Re-order functions to remove forward declarations and
    #ifdefs
  char/nvram: Adopt arch_nvram_ops
  x86/thinkpad_acpi: Use arch_nvram_ops methods instead of
    nvram_read_byte() and nvram_write_byte()
  char/nvram: Allow the set_checksum and initialize ioctls to be omitted
  char/nvram: Implement NVRAM read/write methods
  m68k/atari: Implement arch_nvram_ops methods and enable
    CONFIG_HAVE_ARCH_NVRAM_OPS
  m68k/mac: Adopt naming and calling conventions for PRAM routines
  m68k/mac: Use macros for RTC accesses not magic numbers
  m68k/mac: Fix PRAM accessors
  m68k: Dispatch nvram_ops calls to Atari or Mac functions
  char/nvram: Add "devname:nvram" module alias
  powerpc: Clean up nvram includes
  powerpc: Add missing ppc_md.nvram_size for CHRP and PowerMac
  powerpc: Implement arch_nvram_ops.get_size() and remove old nvram_*
    exports
  powerpc: Implement nvram sync ioctl
  powerpc, fbdev: Use NV_CMODE and NV_VMODE only when CONFIG_PPC32 &&
    CONFIG_PPC_PMAC && CONFIG_NVRAM
  powerpc, fbdev: Use arch_nvram_ops methods instead of
    nvram_read_byte() and nvram_write_byte()
  nvram: Drop nvram_* symbol exports and prototypes
  powerpc: Remove CONFIG_GENERIC_NVRAM and adopt
    CONFIG_HAVE_ARCH_NVRAM_OPS
  char/generic_nvram: Remove as unused
  powerpc: Adopt nvram module for PPC64
  powerpc: Remove pmac_xpram_{read,write} functions

 arch/m68k/Kconfig                          |   3 +
 arch/m68k/Kconfig.machine                  |   2 +
 arch/m68k/atari/Makefile                   |   2 +
 arch/m68k/atari/nvram.c                    | 279 ++++++++
 arch/m68k/include/asm/atarihw.h            |   6 +
 arch/m68k/include/asm/macintosh.h          |   4 +
 arch/m68k/kernel/setup_mm.c                | 100 ++-
 arch/m68k/mac/misc.c                       | 174 +++--
 arch/powerpc/Kconfig                       |   5 +-
 arch/powerpc/include/asm/nvram.h           |  13 -
 arch/powerpc/kernel/nvram_64.c             | 188 ++----
 arch/powerpc/kernel/setup_32.c             |  30 +-
 arch/powerpc/platforms/chrp/Makefile       |   2 +-
 arch/powerpc/platforms/chrp/nvram.c        |  14 +-
 arch/powerpc/platforms/chrp/setup.c        |   2 +-
 arch/powerpc/platforms/powermac/Makefile   |   2 -
 arch/powerpc/platforms/powermac/nvram.c    |  37 +-
 arch/powerpc/platforms/powermac/setup.c    |   3 +-
 arch/powerpc/platforms/powermac/time.c     |  19 +-
 arch/powerpc/platforms/pseries/nvram.c     |   2 -
 drivers/char/Kconfig                       |  19 +-
 drivers/char/Makefile                      |   6 +-
 drivers/char/generic_nvram.c               | 159 -----
 drivers/char/nvram.c                       | 701 +++++++++------------
 drivers/platform/x86/thinkpad_acpi.c       |  20 +-
 drivers/scsi/Kconfig                       |   6 +-
 drivers/scsi/atari_scsi.c                  |  15 +-
 drivers/video/fbdev/Kconfig                |   2 +-
 drivers/video/fbdev/controlfb.c            |   4 +-
 drivers/video/fbdev/imsttfb.c              |  16 +-
 drivers/video/fbdev/matrox/matroxfb_base.c |   6 +-
 drivers/video/fbdev/platinumfb.c           |   4 +-
 drivers/video/fbdev/valkyriefb.c           |  18 +-
 include/linux/nvram.h                      |  24 +-
 include/uapi/linux/pmu.h                   |   2 +
 35 files changed, 964 insertions(+), 925 deletions(-)
 create mode 100644 arch/m68k/atari/nvram.c
 delete mode 100644 drivers/char/generic_nvram.c

-- 
2.19.2

