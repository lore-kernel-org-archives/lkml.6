Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752773AbeB1PGV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:06:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752250AbeB1PGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:06:19 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, bhe@redhat.com, slp@redhat.com, mst@redhat.com,
        somlo@cmu.edu, xiaolong.ye@intel.com,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v16 00/11] fw_cfg: add DMA operations & etc/vmcoreinfo support
Date: Wed, 28 Feb 2018 16:06:04 +0100
Message-Id: <20180228150615.17317-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds DMA operations support to the qemu fw_cfg kernel
module and populates "etc/vmcoreinfo" with vmcoreinfo location
details (entry added since qemu 2.11 with -device vmcoreinfo).

v16:
- patch reordering
- commit message updates
- rename fw_cfg.h -> qemu_fw_cfg.h
- fix warning when CONFIG_CRASH_CORE=n without RFC DMA read patch
  applied
- use a function pointer rather than a dma hint to read_blob()

v15:
- fix fw_cfg.h uapi header #include
- use BSD license for fw_cfg.h uapi header
- move the uapi defines/structs for DMA & vmcoreinfo in the
  corresponding patch
- use cpu_relax() instead of usleep_range(50, 100);
- replace do { } while(true) by for (;;)
- fix the rmb() call location
- add a preliminary patch to handle error from fw_cfg_write_blob()
- rewrite fw_cfg_sel_endianness() to wrap iowrite() calls

v14:
- add "fw_cfg: add a public uapi header"
- fix sparse warnings & don't introduce new warnings
- add memory barriers to force IO ordering
- split fw_cfg_read_blob() in fw_cfg_read_blob_io() and
  fw_cfg_read_blob_dma()
- add error handling to fw_cfg_read_blob() callers
- minor stylistic changes

v13:
- reorder patch series, introduce DMA write before DMA read
- do some measurements of DMA read speed-ups

v12:
- fix virt_to_phys(NULL) panic with CONFIG_DEBUG_VIRTUAL=y
- do not use DMA read, except for kmalloc() memory we allocated
  ourself (only fw_cfg_register_dir_entries() so far)

v11:
- add #include <linux/crash_core.h> in last patch,
  fixing kbuild .config test

Marc-André Lureau (11):
  fw_cfg: fix sparse warnings in fw_cfg_sel_endianness()
  fw_cfg: fix sparse warnings with fw_cfg_file
  fw_cfg: fix sparse warning reading FW_CFG_ID
  fw_cfg: fix sparse warnings around FW_CFG_FILE_DIR read
  fw_cfg: remove inline from fw_cfg_read_blob()
  fw_cfg: handle fw_cfg_read_blob() error
  fw_cfg: add a public uapi header
  fw_cfg: add DMA register
  crash: export paddr_vmcoreinfo_note()
  fw_cfg: write vmcoreinfo details
  RFC: fw_cfg: do DMA read operation

 MAINTAINERS                      |   1 +
 drivers/firmware/qemu_fw_cfg.c   | 339 +++++++++++++++++++++++++++++++--------
 include/uapi/linux/qemu_fw_cfg.h |  97 +++++++++++
 kernel/crash_core.c              |   1 +
 4 files changed, 374 insertions(+), 64 deletions(-)
 create mode 100644 include/uapi/linux/qemu_fw_cfg.h

-- 
2.16.1.73.g5832b7e9f2
