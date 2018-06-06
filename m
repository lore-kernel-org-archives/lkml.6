Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gtWwfnxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C44F60763
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932304AbeFFSk4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 14:40:56 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45937 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932098AbeFFSkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 14:40:55 -0400
X-Google-Smtp-Source: ADUXVKJMtbNexHAJIAmiak5+GcX1c8nOoUrbJr+L2jnU+vkkUCVZYwP2ULjXuWpKhi1GORnqDVsETA==
Date: Wed, 6 Jun 2018 11:40:51 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [GIT PULL] overflow changes for v4.18-rc1
Message-ID: <20180606184051.GA20310@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these overflow changes for v4.18-rc1. As the tag notes, this
adds the new overflow checking helpers and adds them to the 2-factor
argument allocators. And this adds the saturating size helpers and does
a treewide replacement for the struct_size() usage. Additionally this
adds the overflow testing modules to make sure everything works.

I'm still working on the treewide replacements for allocators with "simple"
multiplied arguments (*alloc(a * b, ...) -> *alloc_array(a, b, ...) and
*zalloc(a * b, ...) -> *calloc(a, b, ...)) as well as the more complex
cases, but that's separable from this portion of the series. I expect to
have the rest sent before -rc1 closes; there are a lot of messy cases to
clean up.

Thanks!

-Kees

The following changes since commit 75bc37fefc4471e718ba8e651aa74673d4e0a9eb:

  Linux 4.17-rc4 (2018-05-06 16:57:38 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/overflow-v4.18-rc1

for you to fetch changes up to 0ed2dd03b94b7b7f66e23f25073b5385d0416589:

  treewide: Use struct_size() for devm_kmalloc() and friends (2018-06-06 11:15:43 -0700)

----------------------------------------------------------------
- Introduce arithmetic overflow test helper functions (Rasmus)
- Use overflow helpers in 2-factor allocators (Kees, Rasmus)
- Introduce overflow test module (Rasmus, Kees)
- Introduce saturating size helper functions (Matthew, Kees)
- Treewide use of struct_size() for allocators (Kees)

----------------------------------------------------------------
Kees Cook (9):
      test_overflow: Report test failures
      overflow.h: Add allocation size calculation helpers
      test_overflow: Add memory allocation overflow tests
      mm: Use overflow helpers in kmalloc_array*()
      mm: Use overflow helpers in kvmalloc()
      device: Use overflow helpers for devm_kmalloc()
      treewide: Use struct_size() for kmalloc()-family
      treewide: Use struct_size() for vmalloc()-family
      treewide: Use struct_size() for devm_kmalloc() and friends

Rasmus Villemoes (3):
      compiler.h: enable builtin overflow checkers and add fallback code
      lib: add runtime test of check_*_overflow functions
      test_overflow: macrofy some more, do more tests for free

 crypto/af_alg.c                                   |   4 +-
 drivers/base/devres.c                             |   7 +-
 drivers/clk/bcm/clk-bcm2835-aux.c                 |   6 +-
 drivers/clk/bcm/clk-bcm2835.c                     |   4 +-
 drivers/clk/bcm/clk-iproc-asiu.c                  |   4 +-
 drivers/clk/bcm/clk-iproc-pll.c                   |   3 +-
 drivers/clk/berlin/bg2.c                          |   3 +-
 drivers/clk/berlin/bg2q.c                         |   3 +-
 drivers/clk/clk-asm9260.c                         |   3 +-
 drivers/clk/clk-aspeed.c                          |   6 +-
 drivers/clk/clk-clps711x.c                        |   6 +-
 drivers/clk/clk-efm32gg.c                         |   4 +-
 drivers/clk/clk-gemini.c                          |   6 +-
 drivers/clk/clk-s2mps11.c                         |   4 +-
 drivers/clk/clk-scmi.c                            |   4 +-
 drivers/clk/clk-stm32h7.c                         |   5 +-
 drivers/clk/clk-stm32mp1.c                        |   5 +-
 drivers/clk/davinci/da8xx-cfgchip.c               |   4 +-
 drivers/clk/mvebu/armada-37xx-periph.c            |   7 +-
 drivers/clk/mvebu/armada-37xx-tbg.c               |   4 +-
 drivers/clk/qcom/clk-spmi-pmic-div.c              |   3 +-
 drivers/clk/samsung/clk-exynos-audss.c            |   4 +-
 drivers/clk/samsung/clk-exynos-clkout.c           |   3 +-
 drivers/clk/samsung/clk-exynos5433.c              |   4 +-
 drivers/clk/samsung/clk-s3c2410-dclk.c            |   7 +-
 drivers/clk/samsung/clk-s5pv210-audss.c           |   3 +-
 drivers/dax/device.c                              |   2 +-
 drivers/dma/bcm-sba-raid.c                        |   5 +-
 drivers/dma/edma.c                                |   9 +-
 drivers/dma/moxart-dma.c                          |   2 +-
 drivers/dma/nbpfaxi.c                             |   4 +-
 drivers/dma/omap-dma.c                            |   2 +-
 drivers/dma/sa11x0-dma.c                          |   4 +-
 drivers/dma/sh/usb-dmac.c                         |   2 +-
 drivers/dma/sprd-dma.c                            |   4 +-
 drivers/firewire/core-topology.c                  |   3 +-
 drivers/gpio/gpio-uniphier.c                      |   3 +-
 drivers/gpio/gpiolib.c                            |   3 +-
 drivers/gpu/drm/nouveau/nvkm/core/ramht.c         |   3 +-
 drivers/gpu/drm/nouveau/nvkm/engine/pm/base.c     |   4 +-
 drivers/hwspinlock/omap_hwspinlock.c              |   2 +-
 drivers/hwspinlock/sirf_hwspinlock.c              |   6 +-
 drivers/hwspinlock/u8500_hsem.c                   |   2 +-
 drivers/infiniband/core/cache.c                   |   5 +-
 drivers/infiniband/core/cm.c                      |   4 +-
 drivers/infiniband/core/multicast.c               |   2 +-
 drivers/infiniband/core/uverbs_cmd.c              |   4 +-
 drivers/infiniband/core/uverbs_ioctl_merge.c      |  21 +-
 drivers/infiniband/hw/mthca/mthca_memfree.c       |   4 +-
 drivers/infiniband/sw/rdmavt/mr.c                 |   4 +-
 drivers/input/input-leds.c                        |   3 +-
 drivers/input/input-mt.c                          |   2 +-
 drivers/input/keyboard/cap11xx.c                  |   3 +-
 drivers/md/dm-raid.c                              |   2 +-
 drivers/md/dm-table.c                             |  10 +-
 drivers/mfd/qcom-pm8xxx.c                         |   4 +-
 drivers/misc/cb710/core.c                         |   4 +-
 drivers/misc/vexpress-syscfg.c                    |   3 +-
 drivers/mtd/spi-nor/aspeed-smc.c                  |   5 +-
 drivers/net/can/peak_canfd/peak_pciefd_main.c     |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/debugfs.c |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |   5 +-
 drivers/net/wireless/mediatek/mt76/agg-rx.c       |   3 +-
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c         |   4 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c  |   3 +-
 drivers/regulator/mc13783-regulator.c             |   6 +-
 drivers/regulator/mc13892-regulator.c             |   6 +-
 drivers/reset/core.c                              |   3 +-
 drivers/rtc/rtc-ac100.c                           |   8 +-
 drivers/s390/cio/ccwgroup.c                       |   3 +-
 drivers/soc/actions/owl-sps.c                     |   4 +-
 drivers/soc/rockchip/pm_domains.c                 |   3 +-
 drivers/staging/greybus/module.c                  |   4 +-
 drivers/thermal/qcom/tsens.c                      |   6 +-
 drivers/usb/gadget/function/f_midi.c              |   5 +-
 drivers/zorro/zorro.c                             |   3 +-
 fs/afs/addr_list.c                                |   3 +-
 include/linux/compiler-clang.h                    |  14 +
 include/linux/compiler-gcc.h                      |   4 +
 include/linux/compiler-intel.h                    |   4 +
 include/linux/device.h                            |   8 +-
 include/linux/mm.h                                |   7 +-
 include/linux/overflow.h                          | 278 +++++++++++++++
 include/linux/slab.h                              |  17 +-
 include/linux/vmalloc.h                           |   1 +
 kernel/cgroup/cgroup.c                            |   4 +-
 kernel/module.c                                   |   3 +-
 kernel/workqueue.c                                |   3 +-
 lib/Kconfig.debug                                 |   3 +
 lib/Makefile                                      |   1 +
 lib/test_overflow.c                               | 417 ++++++++++++++++++++++
 net/ceph/mon_client.c                             |   5 +-
 net/ceph/osd_client.c                             |   3 +-
 net/netfilter/xt_recent.c                         |   3 +-
 net/sctp/endpointola.c                            |   4 +-
 sound/core/vmaster.c                              |   4 +-
 sound/soc/qcom/apq8016_sbc.c                      |   3 +-
 sound/soc/soc-dapm.c                              |   2 +-
 99 files changed, 916 insertions(+), 205 deletions(-)
 create mode 100644 include/linux/overflow.h
 create mode 100644 lib/test_overflow.c

-- 
Kees Cook
Pixel Security
