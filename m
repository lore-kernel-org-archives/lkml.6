Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633C1C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63EB21565
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hg8jKJHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63EB21565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeHQN0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:26:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40888 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbeHQN0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:26:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19-v6so5973052ljc.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 03:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dWzAHnJPCkWAIIC7affH6V57IgNwu1vsYguAXrV2/sk=;
        b=Hg8jKJHhvand2ncnNQHDutyEKiKmjNqMxI3IcBuftcPnOBDqTsQM1oRJj3YsameR5L
         +eMOc2QTV3QaJkRxtoAFX1aAUw+WK3FzuFHb1xBVpS3ZxCFpOXg4U9TDg89X9R5Gld/R
         1uXtQIfP7eJ1jbxsmQudnVRnwcA9GoIJbePIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dWzAHnJPCkWAIIC7affH6V57IgNwu1vsYguAXrV2/sk=;
        b=txU3TnLOYfAKNUXQiKnAbhzm1p8m/e/frfl7Q4exudW12i8jgEGBOxY4k3IwPbPoop
         +LGXBRBE3ViepocwtPLM5iChXXI3sWtN6Jpx1zagJ0wqS1Prp+XiEjkx1/YWUcZMwq6E
         J0dERfdNrE/0aaE4VZD0hL2xM9WEsJ0wpJm+aLXx0j1F8fjJhjTuwP+TToAK7o1lQp7G
         Pd7jelLMod8NXQ+Upgsmat2jJJWyGpp0COr1+1enGSw0bwPS6pXxT2lEypDT+SHk8X2K
         nUoZQzIGLlUdGtUXBfSLHJgpk3X0fH2+KTtL+7adh+VmWukKWC/fjBSrY5r546pPOXBF
         bxpA==
X-Gm-Message-State: AOUpUlFKjY4YynVIwaVF0TG3qWF+RhsZ1oH+4wJ+PAJa0QfnPdJekZhY
        XkSTIUENQxhmVBjVMt/8/yDDPQ==
X-Google-Smtp-Source: AA+uWPzPQYbzF4O5xQ5pK6ZzPM9MAkrGjDsKBeWPE6fOM//N9r97TTQuh7T8MCi1c+khW6yymT7B5w==
X-Received: by 2002:a2e:658d:: with SMTP id e13-v6mr7887274ljf.57.1534501396806;
        Fri, 17 Aug 2018 03:23:16 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id v20-v6sm247999ljc.94.2018.08.17.03.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 03:23:16 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v4.19
Date:   Fri, 17 Aug 2018 12:23:14 +0200
Message-Id: <20180817102314.3979-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with the updates for MMC for v4.19. Details about the highlights are
as usual found in the signed tag.

Note, this time I have also merged an immutable branch/tag for switching the
pxa platforms to DMA slave maps, by Robert Jarzmik. This was needed due to
dependency for additional changes of the pxamci mmc driver.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 3b1074bf9817bf43d4da375aa5f4b6c88f1d953e:

  mmc: mxcmmc: Fix missing parentheses and brace (2018-07-16 11:45:44 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.19

for you to fetch changes up to 7f38abf220e2c800a2c451372e9f07ed5fd0ea49:

  mmc: core: improve reasonableness of bus width setting for HS400es (2018-08-01 14:15:28 +0200)

----------------------------------------------------------------
MMC core:
 - Add some fine-grained hooks to further support HS400 tuning
 - Improve error path for bus width setting for HS400es
 - Use a common method when checking R1 status

MMC host:
 - renesas_sdhi: Add r8a77990 support
 - renesas_sdhi: Add eMMC HS400 mode support
 - tmio/renesas_sdhi: Improve tuning/clock management
 - tmio: Add eMMC HS400 mode support
 - sunxi: Add support for 3.3V eMMC DDR mode
 - mmci: Initial support to manage variant specific callbacks
 - sdhci: Don't try 3.3V I/O voltage if not supported
 - sdhci-pci-dwc-mshc: Add driver to support Synopsys dwc mshc SDHCI PCI
 - sdhci-of-dwcmshc: Add driver to support Synopsys DWC MSHC SDHCI
 - sdhci-msm: Add support for new version sdcc V5
 - sdhci-pci-o2micro: Add support for O2 eMMC HS200 mode
 - sdhci-pci-o2micro: Add support for O2 hardware tuning
 - sdhci-pci-o2micro: Add MSI interrupt support for O2 SD host
 - sdhci-pci: Add support for Intel ICP
 - sdhci-tegra: Prevent ACMD23 and HS200 mode on Tegra 3
 - sdhci-tegra: Fix eMMC DDR52 mode
 - sdhci-tegra: Improve clock management
 - dw_mmc-rockchip: Document compatible string for px30
 - sdhci-esdhc-imx: Add support for 3.3V eMMC DDR mode
 - sdhci-of-esdhc: Set proper DMA mask for ls104x chips
 - sdhci-of-esdhc: Improve clock management
 - sdhci-of-arasan: Add a quirk to manage unstable clocks
 - dw_mmc-exynos: Address potential external abort during system resume
 - pxamci: Add support for common MMC DT bindings
 - pxamci: Several cleanups and improvements
 - pxamci: Merge immutable branch for pxa to switch to DMA slave maps

----------------------------------------------------------------
Aapo Vienamo (3):
      mmc: tegra: Use sdhci_pltfm_clk_get_max_clock
      mmc: tegra: Add and use tegra_sdhci_get_max_clock()
      mmc: tegra: Force correct divider calculation on DDR50/52

Adrian Hunter (1):
      mmc: sdhci-pci: Add support for Intel ICP

Andre Przywara (1):
      mmc: sunxi: remove output of virtual base address

Daniel Mack (9):
      mmc: pxamci: remove irq from private context
      mmc: pxamci: remove dma resources from private context
      mmc: pxamci: remove dead code from pxamci_remove()
      mmc: pxamci: fix indenting
      mmc: pxamci: call mmc_of_parse()
      mmc: pxamci: remove pxa-mmc, gpio-power from devicetree bindings
      mmc: pxamci: let mmc core handle regulators
      mmc: pxamci: make GPIO lookups from pdata optional
      mmc: pxamci: provide a short-hand for &pdev->dev

Fabio Estevam (1):
      mmc: sdhci-esdhc-imx: Switch to SPDX identifier

Gustavo A. R. Silva (1):
      mmc: sdhci-xenon: mark expected switch fall-through

Helmut Grohne (2):
      dt-bindings: mmc: broken clock stable indicator on arasan controllers
      mmc: sdhci-of-arasan: Add quirk for unstable clocks

Hongjie Fang (1):
      mmc: core: improve reasonableness of bus width setting for HS400es

Icenowy Zheng (1):
      mmc: sunxi: allow 3.3V DDR when DDR is available

Jisheng Zhang (2):
      dt: bindings: Add bindings for SDHCI Synopsys DWC MSHC
      mmc: sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC MSHC driver

Laurentiu Tudor (1):
      mmc: sdhci-of-esdhc: set proper dma mask for ls104x chips

Liang Chen (1):
      dt-bindings: mmc: rockchip-dw-mshc: add description for px30

Marek Szyprowski (1):
      mmc: dw_mmc-exynos: fix potential external abort in resume_noirq()

Masaharu Hayakawa (3):
      mmc: tmio: add eMMC HS400 mode support
      mmc: renesas_sdhi: add eMMC HS400 mode support
      mmc: tmio: Fix tuning flow

Masahiro Yamada (1):
      mmc: tmio: remove unneeded variable in tmio_mmc_start_command()

Niklas Söderlund (1):
      mmc: renesas_sdhi: Fix sampling clock position selecting

Prabu Thangamuthu (1):
      mmc: sdhci-pci-dwc-mshc: synopsys dwc mshc support

Robert Jarzmik (10):
      dmaengine: pxa: use a dma slave map
      ARM: pxa: add dma slave map
      dmaengine: pxa: add a default requestor policy
      mmc: pxamci: remove the dmaengine compat need
      media: pxa_camera: remove the dmaengine compat need
      mtd: rawnand: marvell: remove the dmaengine compat need
      ata: pata_pxa: remove the dmaengine compat need
      dmaengine: pxa: document pxad_param
      ARM: pxa: remove the DMA IO resources
      ARM: pxa: change SSP DMA channels allocation

Sayali Lokhande (3):
      mmc: sdhci-msm: Define new Register address map
      Documentation: sdhci-msm: Add new compatible string for SDCC v5
      mmc: host: Register changes for sdcc V5

Shawn Lin (1):
      mmc: core: Adjust and reuse the macro of R1_STATUS(x)

Simon Horman (1):
      mmc: core: more fine-grained hooks for HS400 tuning

Stefan Agner (8):
      mmc: sdhci-esdhc-imx: support eMMC DDR mode when running at 3.3V
      mmc: sdhci-esdhc-imx: get rid of support_vsel
      mmc: sdhci: do not try to use 3.3V signaling if not supported
      mmc: tegra: prevent HS200 on Tegra 3
      mmc: tegra: fix eMMC DDR52 mode
      mmc: tegra: prevent ACMD23 on Tegra 3
      mmc: sdhci-esdhc-imx: disable clocks before changing frequency
      mmc: sdhci-esdhc-imx: fix indent

Ulf Hansson (6):
      Merge tag 'pxa-for-4.19-dma_slave_map' of https://github.com/rjarzmik/linux
      Merge branch 'next_pxa_dma' into next
      mmc: core: Drop the unused mmc_power_save|restore_host()
      Merge branch 'fixes' into next
      mmc: mmci: Initial support to manage variant specific callbacks
      mmc: mmci: Add and implement a ->dma_setup() callback for qcom dml

Vijay Viswanath (1):
      mmc: sdhci-msm: Add msm version specific ops and data structures

Wolfram Sang (1):
      mmc: renesas_sdhi: Add r8a77990 support

ernest.zhang (5):
      mmc: sdhci: Add support for O2 eMMC HS200 mode
      mmc: sdhci: Change O2 Host HS200 mode clock frequency to 200MHz
      mmc: sdhci: Export sdhci tuning function symbol
      mmc: sdhci: Add support for O2 hardware tuning
      mmc: sdhci: Add MSI interrupt support for O2 SD host

weiyongjun (A) (1):
      mmc: sdhci-msm: Remove redundant dev_err call in sdhci_msm_probe()

yinbo.zhu (1):
      mmc: sdhci-of-esdhc: modify the sd clock in of_match_node way

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |   2 +
 Documentation/devicetree/bindings/mmc/pxa-mmc.txt  |   6 +-
 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |   1 +
 .../devicetree/bindings/mmc/sdhci-msm.txt          |   7 +-
 .../devicetree/bindings/mmc/sdhci-of-dwcmshc.txt   |  20 +
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   1 +
 MAINTAINERS                                        |   7 +
 arch/arm/mach-pxa/devices.c                        | 148 +-----
 arch/arm/mach-pxa/devices.h                        |   6 +-
 arch/arm/mach-pxa/pxa25x.c                         |  38 +-
 arch/arm/mach-pxa/pxa27x.c                         |  39 +-
 arch/arm/mach-pxa/pxa3xx.c                         |  41 +-
 arch/arm/plat-pxa/ssp.c                            |  47 --
 drivers/ata/pata_pxa.c                             |  10 +-
 drivers/dma/pxa_dma.c                              |  15 +-
 drivers/media/platform/pxa_camera.c                |  22 +-
 drivers/mmc/core/core.c                            |  48 +-
 drivers/mmc/core/core.h                            |   2 -
 drivers/mmc/core/mmc.c                             |  16 +-
 drivers/mmc/core/mmc_ops.c                         |   2 +-
 drivers/mmc/core/sdio.c                            |   1 -
 drivers/mmc/host/Kconfig                           |  11 +
 drivers/mmc/host/Makefile                          |   4 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |  33 +-
 drivers/mmc/host/mmci.c                            |  82 +---
 drivers/mmc/host/mmci.h                            |  81 +++-
 drivers/mmc/host/mmci_qcom_dml.c                   |  18 +-
 drivers/mmc/host/mmci_qcom_dml.h                   |   5 +-
 drivers/mmc/host/pxamci.c                          | 236 ++++------
 drivers/mmc/host/renesas_sdhi_core.c               | 139 +++++-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |  20 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |  17 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  29 +-
 drivers/mmc/host/sdhci-msm.c                       | 510 ++++++++++++++++-----
 drivers/mmc/host/sdhci-of-arasan.c                 |  16 +
 drivers/mmc/host/sdhci-of-dwcmshc.c                | 116 +++++
 drivers/mmc/host/sdhci-of-esdhc.c                  |  91 ++--
 drivers/mmc/host/sdhci-pci-core.c                  |   3 +
 drivers/mmc/host/sdhci-pci-dwc-mshc.c              |  84 ++++
 drivers/mmc/host/sdhci-pci-o2micro.c               | 129 +++++-
 drivers/mmc/host/sdhci-pci.h                       |   5 +
 drivers/mmc/host/sdhci-tegra.c                     |  37 +-
 drivers/mmc/host/sdhci-xenon-phy.c                 |   1 +
 drivers/mmc/host/sdhci.c                           |  25 +-
 drivers/mmc/host/sdhci.h                           |   5 +
 drivers/mmc/host/sunxi-mmc.c                       |   7 +-
 drivers/mmc/host/tmio_mmc.h                        |   6 +
 drivers/mmc/host/tmio_mmc_core.c                   |  52 ++-
 drivers/mtd/nand/raw/marvell_nand.c                |  17 +-
 include/linux/dma/pxa-dma.h                        |   9 +
 include/linux/mfd/tmio.h                           |   3 +
 include/linux/mmc/host.h                           |  10 +-
 include/linux/mmc/mmc.h                            |   2 +-
 include/linux/platform_data/mmc-esdhc-imx.h        |   2 -
 include/linux/platform_data/mmp_dma.h              |   4 +
 include/linux/pxa2xx_ssp.h                         |   2 -
 sound/soc/pxa/pxa-ssp.c                            |   5 +-
 57 files changed, 1531 insertions(+), 764 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
 create mode 100644 drivers/mmc/host/sdhci-of-dwcmshc.c
 create mode 100644 drivers/mmc/host/sdhci-pci-dwc-mshc.c
