Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AA5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA37222D9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlENrjd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393312AbfBOWjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:39:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45547 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391931AbfBOWja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:39:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id w17so11869295wrn.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 14:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EKOasi3ehXMaYPZuhYtHpJswCTyvYVNLcDJWX+KSSpo=;
        b=rlENrjd3Abeh14kO/wqbCuHYd8g8KfJ596IUUadIznsk4F6idY531MfLvTuhOJC2T/
         gzl2EcL/BaZ6jCwCy2M2N1asaAruJnLWFDTNgatnQewIJnMgP2bbyr0mkW1S0w1/chOc
         CZfeDFLsupCPUikVwPTo8SVBVgi8Si9AvZIWbCHiPHXujqQTsyLLC1fxldWjnzUZfkPK
         sSiETtNrSdppT7sdfjfCeEZrA4vl1ywjD+l4rwumvGELqHkqmoEpoMt99ngi0fFOexUL
         EjkMrFzRyNJd+fxI/E126w2thZZIm/F5zvF1F4WcCiznjAbdM/Uu71FwruP10dqVCVZr
         tiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EKOasi3ehXMaYPZuhYtHpJswCTyvYVNLcDJWX+KSSpo=;
        b=Vhpt4U50hWangkFH+AoV85Key4IsWywKlUtOZ3bIpPF9w15alMvrisQ/vSO4WqIdd/
         qgBdoUy3F50/PjkMm39WVHpmiBpnfIhBWvuLQBKhmb1gkKNu5bF6+6Wsf5KKnIrRWigX
         TUqOOLfdXnDV/Sxo3HSD4Q5NldNntjgbDF5CNwUHs4fI/cAHbc1VsbduEsz5UZ4a1WwV
         eIKAMoW1XkjRkp0JKzt2bfU5I/8rZN4TYUaN8931ic4Sh3Ht+o1vqJmtjhXk+XCYzg71
         2mvsQO6FNrb28+oWhX7EJ30KQS1pt5Vm7fw8zySU2D4YiZeIXMQN17LIyEasM6+IcDov
         w5sA==
X-Gm-Message-State: AHQUAuZgiVEJp25+Ry4WLxVNE26Q4+fX9N6KUuHo+Dy0uOqehqNNiKkG
        bGeYhIF3be2w6ZN5XABNaPo=
X-Google-Smtp-Source: AHgI3IYfdKC2Uewrb/3lYnwHLarMDWZKPAjQzpvBFOQj5PgZqNOqjJSP8iajvKR1UsZ1nDVmyUqxTQ==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr8030509wrp.150.1550270368040;
        Fri, 15 Feb 2019 14:39:28 -0800 (PST)
Received: from goyamonster.habana-labs.com ([31.154.181.186])
        by smtp.gmail.com with ESMTPSA id b197sm14652609wmd.23.2019.02.15.14.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 14:39:27 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rppt@linux.ibm.com, olof@lixom.net
Cc:     ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: [PATCH v6 00/15] Habana Labs kernel driver
Date:   Sat, 16 Feb 2019 00:39:10 +0200
Message-Id: <20190215223925.16351-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is v6 of the Habana Labs kernel driver patch-set. This version fixes the
compilation failure on arm 32-bit and removes many includes of headers which
are not really needed by the code.

Link to v5 cover letter: https://lkml.org/lkml/2019/2/14/741

Link to v4 cover letter: https://lkml.org/lkml/2019/2/11/993

Link to v3 cover letter: https://lkml.org/lkml/2019/2/4/1033

Link to v2 cover letter: https://lkml.org/lkml/2019/1/30/1003

Link to v1 cover letter: https://lwn.net/Articles/777342/

I would appricate any feedback, question and/or review.

Thanks,
Oded

p.s. for those who prefer to clone the tree instead of looking at the
emails, you can grab a copy from our company's page in GitHub:

https://github.com/HabanaAI/linux/releases/tag/hl_patchset_v6_20190216

Oded Gabbay (14):
  habanalabs: add skeleton driver
  habanalabs: add Goya registers header files
  habanalabs: add basic Goya support
  habanalabs: add context and ASID modules
  habanalabs: add command buffer module
  habanalabs: add basic Goya h/w initialization
  habanalabs: add h/w queues module
  habanalabs: add event queue and interrupts
  habanalabs: add sysfs and hwmon support
  habanalabs: add device reset support
  habanalabs: add command submission module
  habanalabs: implement INFO IOCTL
  habanalabs: add debugfs support
  Update MAINTAINERS and CREDITS with habanalabs info

Omer Shpigelman (1):
  habanalabs: add virtual memory and MMU modules

 CREDITS                                       |    2 +-
 .../ABI/testing/debugfs-driver-habanalabs     |  126 +
 .../ABI/testing/sysfs-driver-habanalabs       |  190 +
 MAINTAINERS                                   |    9 +
 drivers/misc/Kconfig                          |    1 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/habanalabs/Kconfig               |   22 +
 drivers/misc/habanalabs/Makefile              |   14 +
 drivers/misc/habanalabs/asid.c                |   57 +
 drivers/misc/habanalabs/command_buffer.c      |  442 ++
 drivers/misc/habanalabs/command_submission.c  |  778 +++
 drivers/misc/habanalabs/context.c             |  215 +
 drivers/misc/habanalabs/debugfs.c             | 1072 ++++
 drivers/misc/habanalabs/device.c              | 1138 ++++
 drivers/misc/habanalabs/goya/Makefile         |    3 +
 drivers/misc/habanalabs/goya/goya.c           | 5363 +++++++++++++++++
 drivers/misc/habanalabs/goya/goyaP.h          |  190 +
 drivers/misc/habanalabs/goya/goya_hwmgr.c     |  254 +
 drivers/misc/habanalabs/goya/goya_security.c  | 2999 +++++++++
 drivers/misc/habanalabs/habanalabs.h          | 1454 +++++
 drivers/misc/habanalabs/habanalabs_drv.c      |  461 ++
 drivers/misc/habanalabs/habanalabs_ioctl.c    |  234 +
 drivers/misc/habanalabs/hw_queue.c            |  632 ++
 drivers/misc/habanalabs/hwmon.c               |  452 ++
 drivers/misc/habanalabs/include/armcp_if.h    |  335 +
 .../goya/asic_reg/cpu_ca53_cfg_masks.h        |  191 +
 .../include/goya/asic_reg/cpu_ca53_cfg_regs.h |   61 +
 .../include/goya/asic_reg/cpu_if_regs.h       |   49 +
 .../include/goya/asic_reg/cpu_pll_regs.h      |  105 +
 .../include/goya/asic_reg/dma_ch_0_regs.h     |  209 +
 .../include/goya/asic_reg/dma_ch_1_regs.h     |  209 +
 .../include/goya/asic_reg/dma_ch_2_regs.h     |  209 +
 .../include/goya/asic_reg/dma_ch_3_regs.h     |  209 +
 .../include/goya/asic_reg/dma_ch_4_regs.h     |  209 +
 .../include/goya/asic_reg/dma_macro_masks.h   |  105 +
 .../include/goya/asic_reg/dma_macro_regs.h    |  181 +
 .../include/goya/asic_reg/dma_nrtr_masks.h    |  209 +
 .../include/goya/asic_reg/dma_nrtr_regs.h     |  227 +
 .../include/goya/asic_reg/dma_qm_0_masks.h    |  465 ++
 .../include/goya/asic_reg/dma_qm_0_regs.h     |  179 +
 .../include/goya/asic_reg/dma_qm_1_regs.h     |  179 +
 .../include/goya/asic_reg/dma_qm_2_regs.h     |  179 +
 .../include/goya/asic_reg/dma_qm_3_regs.h     |  179 +
 .../include/goya/asic_reg/dma_qm_4_regs.h     |  179 +
 .../include/goya/asic_reg/goya_blocks.h       | 1372 +++++
 .../include/goya/asic_reg/goya_masks.h        |  275 +
 .../include/goya/asic_reg/goya_regs.h         |  117 +
 .../include/goya/asic_reg/ic_pll_regs.h       |  105 +
 .../include/goya/asic_reg/mc_pll_regs.h       |  105 +
 .../include/goya/asic_reg/mme1_rtr_masks.h    |  653 ++
 .../include/goya/asic_reg/mme1_rtr_regs.h     |  331 +
 .../include/goya/asic_reg/mme2_rtr_regs.h     |  331 +
 .../include/goya/asic_reg/mme3_rtr_regs.h     |  331 +
 .../include/goya/asic_reg/mme4_rtr_regs.h     |  331 +
 .../include/goya/asic_reg/mme5_rtr_regs.h     |  331 +
 .../include/goya/asic_reg/mme6_rtr_regs.h     |  331 +
 .../include/goya/asic_reg/mme_cmdq_masks.h    |  373 ++
 .../include/goya/asic_reg/mme_cmdq_regs.h     |  139 +
 .../include/goya/asic_reg/mme_masks.h         | 1537 +++++
 .../include/goya/asic_reg/mme_qm_masks.h      |  465 ++
 .../include/goya/asic_reg/mme_qm_regs.h       |  179 +
 .../include/goya/asic_reg/mme_regs.h          | 1153 ++++
 .../include/goya/asic_reg/mmu_masks.h         |  143 +
 .../include/goya/asic_reg/mmu_regs.h          |   53 +
 .../include/goya/asic_reg/pci_nrtr_masks.h    |  209 +
 .../include/goya/asic_reg/pci_nrtr_regs.h     |  227 +
 .../include/goya/asic_reg/pcie_aux_regs.h     |  243 +
 .../goya/asic_reg/psoc_emmc_pll_regs.h        |  105 +
 .../goya/asic_reg/psoc_global_conf_masks.h    |  447 ++
 .../goya/asic_reg/psoc_global_conf_regs.h     |  745 +++
 .../include/goya/asic_reg/psoc_mme_pll_regs.h |  105 +
 .../include/goya/asic_reg/psoc_pci_pll_regs.h |  105 +
 .../include/goya/asic_reg/psoc_spi_regs.h     |  143 +
 .../goya/asic_reg/sram_y0_x0_rtr_regs.h       |   83 +
 .../goya/asic_reg/sram_y0_x1_rtr_regs.h       |   83 +
 .../goya/asic_reg/sram_y0_x2_rtr_regs.h       |   83 +
 .../goya/asic_reg/sram_y0_x3_rtr_regs.h       |   83 +
 .../goya/asic_reg/sram_y0_x4_rtr_regs.h       |   83 +
 .../include/goya/asic_reg/stlb_masks.h        |  117 +
 .../include/goya/asic_reg/stlb_regs.h         |   55 +
 .../include/goya/asic_reg/tpc0_cfg_masks.h    | 1607 +++++
 .../include/goya/asic_reg/tpc0_cfg_regs.h     |  887 +++
 .../include/goya/asic_reg/tpc0_cmdq_masks.h   |  373 ++
 .../include/goya/asic_reg/tpc0_cmdq_regs.h    |  139 +
 .../goya/asic_reg/tpc0_eml_cfg_masks.h        |  347 ++
 .../include/goya/asic_reg/tpc0_eml_cfg_regs.h |  313 +
 .../include/goya/asic_reg/tpc0_nrtr_masks.h   |  209 +
 .../include/goya/asic_reg/tpc0_nrtr_regs.h    |  227 +
 .../include/goya/asic_reg/tpc0_qm_masks.h     |  465 ++
 .../include/goya/asic_reg/tpc0_qm_regs.h      |  179 +
 .../include/goya/asic_reg/tpc1_cfg_regs.h     |  887 +++
 .../include/goya/asic_reg/tpc1_cmdq_regs.h    |  139 +
 .../include/goya/asic_reg/tpc1_qm_regs.h      |  179 +
 .../include/goya/asic_reg/tpc1_rtr_regs.h     |  323 +
 .../include/goya/asic_reg/tpc2_cfg_regs.h     |  887 +++
 .../include/goya/asic_reg/tpc2_cmdq_regs.h    |  139 +
 .../include/goya/asic_reg/tpc2_qm_regs.h      |  179 +
 .../include/goya/asic_reg/tpc2_rtr_regs.h     |  323 +
 .../include/goya/asic_reg/tpc3_cfg_regs.h     |  887 +++
 .../include/goya/asic_reg/tpc3_cmdq_regs.h    |  139 +
 .../include/goya/asic_reg/tpc3_qm_regs.h      |  179 +
 .../include/goya/asic_reg/tpc3_rtr_regs.h     |  323 +
 .../include/goya/asic_reg/tpc4_cfg_regs.h     |  887 +++
 .../include/goya/asic_reg/tpc4_cmdq_regs.h    |  139 +
 .../include/goya/asic_reg/tpc4_qm_regs.h      |  179 +
 .../include/goya/asic_reg/tpc4_rtr_regs.h     |  323 +
 .../include/goya/asic_reg/tpc5_cfg_regs.h     |  887 +++
 .../include/goya/asic_reg/tpc5_cmdq_regs.h    |  139 +
 .../include/goya/asic_reg/tpc5_qm_regs.h      |  179 +
 .../include/goya/asic_reg/tpc5_rtr_regs.h     |  323 +
 .../include/goya/asic_reg/tpc6_cfg_regs.h     |  887 +++
 .../include/goya/asic_reg/tpc6_cmdq_regs.h    |  139 +
 .../include/goya/asic_reg/tpc6_qm_regs.h      |  179 +
 .../include/goya/asic_reg/tpc6_rtr_regs.h     |  323 +
 .../include/goya/asic_reg/tpc7_cfg_regs.h     |  887 +++
 .../include/goya/asic_reg/tpc7_cmdq_regs.h    |  139 +
 .../include/goya/asic_reg/tpc7_nrtr_regs.h    |  227 +
 .../include/goya/asic_reg/tpc7_qm_regs.h      |  179 +
 .../include/goya/asic_reg/tpc_pll_regs.h      |  105 +
 drivers/misc/habanalabs/include/goya/goya.h   |   45 +
 .../include/goya/goya_async_events.h          |  186 +
 .../misc/habanalabs/include/goya/goya_fw_if.h |   28 +
 .../habanalabs/include/goya/goya_packets.h    |  129 +
 drivers/misc/habanalabs/include/hl_boot_if.h  |   30 +
 .../include/hw_ip/mmu/mmu_general.h           |   46 +
 .../habanalabs/include/hw_ip/mmu/mmu_v1_0.h   |   15 +
 drivers/misc/habanalabs/include/qman_if.h     |   56 +
 drivers/misc/habanalabs/irq.c                 |  325 +
 drivers/misc/habanalabs/memory.c              | 1723 ++++++
 drivers/misc/habanalabs/mmu.c                 |  691 +++
 drivers/misc/habanalabs/sysfs.c               |  536 ++
 include/uapi/misc/habanalabs.h                |  444 ++
 132 files changed, 51252 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/debugfs-driver-habanalabs
 create mode 100644 Documentation/ABI/testing/sysfs-driver-habanalabs
 create mode 100644 drivers/misc/habanalabs/Kconfig
 create mode 100644 drivers/misc/habanalabs/Makefile
 create mode 100644 drivers/misc/habanalabs/asid.c
 create mode 100644 drivers/misc/habanalabs/command_buffer.c
 create mode 100644 drivers/misc/habanalabs/command_submission.c
 create mode 100644 drivers/misc/habanalabs/context.c
 create mode 100644 drivers/misc/habanalabs/debugfs.c
 create mode 100644 drivers/misc/habanalabs/device.c
 create mode 100644 drivers/misc/habanalabs/goya/Makefile
 create mode 100644 drivers/misc/habanalabs/goya/goya.c
 create mode 100644 drivers/misc/habanalabs/goya/goyaP.h
 create mode 100644 drivers/misc/habanalabs/goya/goya_hwmgr.c
 create mode 100644 drivers/misc/habanalabs/goya/goya_security.c
 create mode 100644 drivers/misc/habanalabs/habanalabs.h
 create mode 100644 drivers/misc/habanalabs/habanalabs_drv.c
 create mode 100644 drivers/misc/habanalabs/habanalabs_ioctl.c
 create mode 100644 drivers/misc/habanalabs/hw_queue.c
 create mode 100644 drivers/misc/habanalabs/hwmon.c
 create mode 100644 drivers/misc/habanalabs/include/armcp_if.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_ca53_cfg_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_ca53_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_if_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_2_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_3_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_4_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_macro_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_macro_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_nrtr_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_nrtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_0_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_2_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_3_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_4_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/goya_blocks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/goya_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/ic_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mc_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme1_rtr_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme1_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme2_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme3_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme4_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme5_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme6_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_cmdq_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_qm_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mmu_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mmu_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pci_nrtr_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pci_nrtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pcie_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_emmc_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_global_conf_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_global_conf_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_mme_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_pci_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_spi_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x0_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x1_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x2_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x3_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x4_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/stlb_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/stlb_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cfg_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cmdq_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_eml_cfg_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_eml_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_nrtr_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_nrtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_qm_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_nrtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/goya.h
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_async_events.h
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_fw_if.h
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_packets.h
 create mode 100644 drivers/misc/habanalabs/include/hl_boot_if.h
 create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
 create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_0.h
 create mode 100644 drivers/misc/habanalabs/include/qman_if.h
 create mode 100644 drivers/misc/habanalabs/irq.c
 create mode 100644 drivers/misc/habanalabs/memory.c
 create mode 100644 drivers/misc/habanalabs/mmu.c
 create mode 100644 drivers/misc/habanalabs/sysfs.c
 create mode 100644 include/uapi/misc/habanalabs.h

-- 
2.18.0

