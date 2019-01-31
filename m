Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C88C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDA2218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="12G4XWtc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbfAaNjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:39:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45965 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfAaNjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:39:42 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so3279976wrr.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2GsZ9+PJNS9N+o9+/KD8LoAUK41fA90WItC0890wMYo=;
        b=12G4XWtcYy1aE7q9Z+nN3iy3d5A9/qP1aADWly33c1yr73JobNK2ElmX0HnSvuxLhf
         WTJ18JjGw5482KkFhJlw/Ff+ddZs4CCo5t2pFmW8NbDeDxDXL7ILW235A6M0QiJYoG1y
         iOTikeIIm2NK29qKj9F3+xvZrVsPtwR1YpFaQQOnLXD7k1RnQk4frPSSFtLERdAbzhTC
         bUf6HNI5vkx8Y3lv9auJPcotTiMgNsU9osZCmLvEjWkGwBP/+oxu4Q/vziCErFzQzUBq
         4xaurO3FfyzMOyj4uefocuHiE+XseIZGngpVLZg4Ohj31gaoJnJ4IJ5xHkqkhvMALb0S
         ctsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2GsZ9+PJNS9N+o9+/KD8LoAUK41fA90WItC0890wMYo=;
        b=MYUzpvpkGszLGBfiMktYdkIUBYMeveLv/dNEL11gQZv7UyUM5GbNFpGv+tITdVHudH
         GgM0WKaEhdN8sBApHRoegh5p3TBPYBQyBWZeFBOWmBnaeRmf9CYKBHe8Ba1SzH7dPelZ
         wcG82KFL6A+wA44IqZkHBP9fCXNCYX3dUwvdSw7DUQYj6VLDmah0esGtsgLrFYAf3594
         O07jPpONC3a/77qC3iRz1k0z53mL/B2wh5BK6wQ+6S3aslmBb7Nrz+ht0Ys/haOE+AtK
         jQDQkKKbVBWT46mvnd0akymKAK6oJ8WsQUjZBHcULSNJ/MEHKTLomlM3D7uKK+vcXkhU
         Ppng==
X-Gm-Message-State: AJcUukchSWpuo6D7HKIpmr7zma57OBReR0FW9VNWWnIZTkyAQdyq+L1i
        QDSxhwOgU11MjRp0HmDY39ujXw==
X-Google-Smtp-Source: ALg8bN52g9qYqvzY0nMmpSnZw1cWRQHuPDvKfEQalqeVkilXhwJ/vNH67J881SbY+IgA68IKsFAgYQ==
X-Received: by 2002:adf:9d85:: with SMTP id p5mr33050506wre.41.1548941980577;
        Thu, 31 Jan 2019 05:39:40 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:39:39 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 00/35] ARM: davinci: modernize the irq support
Date:   Thu, 31 Jan 2019 14:38:53 +0100
Message-Id: <20190131133928.17985-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series ports the davinci platform to using SPARSE_IRQ, cleans up
the irqchip drivers and moves them over to drivers/irqchip.

The series can be logically split into four parts. The first (1-8) aims
at introducing support for SPARSE_IRQ. It contains a couple changes
required for that functionality and the final patch actually selecting
it.

Second part (9-18) makes the aintc driver suitable for drivers/irqchip
and eventually moves it over there.

Part 3 (19-31) does the same for the cp-intc driver.

Last part (32-35) aims at removing mach/irqs.h as it's no longer needed
with SPARSE_IRQ selected.

The series has been tested on da850-lcdk (for cp-intc) and
dm365-evm (for aintc).

Bartosz Golaszewski (35):
  ARM: davinci: remove intc_host_map from davinci_soc_info struct
  ARM: davinci: select GENERIC_IRQ_MULTI_HANDLER
  ARM: davinci: remove davinci_intc_type
  ARM: davinci: pull davinci_intc_base into the respective intc drivers
  ARM: davinci: drop irq defines from default_priorites
  ARM: davinci: wrap interrupt definitions with a macro for SPARSE_IRQ
  ARM: davinci: aintc: use irq domain
  ARM: davinci: select SPARSE_IRQ
  ARM: davinci: aintc: drop GPL license boilerplate
  ARM: davinci: aintc: wrap davinci_irq_init() with a helper
  ARM: davinci: aintc: use a common prefix for symbols in the driver
  ARM: davinci: aintc: drop the 00 prefix from register offsets
  ARM: davinci: aintc: add a new config structure
  ARM: davinci: aintc: use the new irqchip config structure in dm* SoCs
  ARM: davinci: aintc: use the new config structure
  ARM: davinci: aintc: move timer-specific irq_set_handler() out of
    irq.c
  ARM: davinci: aintc: remove unnecessary includes
  irqchip: davinci-aintc: move the driver to drivers/irqchip
  ARM: davinci: cp-intc: remove cp_intc.h
  ARM: davinci: cp-intc: add a wrapper around cp_intc_init()
  ARM: davinci: cp-intc: add a new config structure
  ARM: davinci: cp-intc: add the new config structures for da8xx SoCs
  ARM: davinci: cp-intc: use a common prefix for all symbols
  ARM: davinci: cp-intc: convert all hex numbers to lowercase
  ARM: davinci: cp-intc: use the new-style config structure
  ARM: davinci: cp-intc: improve coding style
  ARM: davinci: cp-intc: unify error handling
  ARM: davinci: cp-intc: remove unneeded include
  ARM: davinci: cp-intc: drop GPL license boilerplate
  ARM: davinci: cp-intc: remove redundant comments
  irqchip: davinci-cp-intc: move the driver to drivers/irqchip
  ARM: davinci: remove intc related fields from davinci_soc_info
  ARM: davinci: prepare to remove mach/irqs.h
  ARM: davinci: stop using defines from mach/irqs.h
  ARM: davinci: remove mach/irqs.h

 arch/arm/Kconfig                              |   2 +
 arch/arm/mach-davinci/Kconfig                 |  19 +-
 arch/arm/mach-davinci/Makefile                |   3 -
 arch/arm/mach-davinci/asp.h                   |   8 +-
 arch/arm/mach-davinci/board-da830-evm.c       |   5 +-
 arch/arm/mach-davinci/board-da850-evm.c       |   7 +-
 arch/arm/mach-davinci/board-dm355-evm.c       |   2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c   |   2 +-
 arch/arm/mach-davinci/board-dm365-evm.c       |   2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c      |   4 +-
 arch/arm/mach-davinci/board-dm646x-evm.c      |   7 +-
 arch/arm/mach-davinci/board-mityomapl138.c    |   3 +-
 arch/arm/mach-davinci/board-neuros-osd2.c     |   2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c   |   3 +-
 arch/arm/mach-davinci/board-sffsdr.c          |   2 +-
 arch/arm/mach-davinci/common.c                |   3 -
 arch/arm/mach-davinci/cp_intc.c               | 215 ---------
 arch/arm/mach-davinci/cp_intc.h               |  57 ---
 arch/arm/mach-davinci/da830.c                 | 127 +-----
 arch/arm/mach-davinci/da850.c                 | 153 ++-----
 arch/arm/mach-davinci/davinci.h               |   6 +
 arch/arm/mach-davinci/devices-da8xx.c         | 146 +++----
 arch/arm/mach-davinci/devices.c               |  31 +-
 arch/arm/mach-davinci/dm355.c                 | 149 +++----
 arch/arm/mach-davinci/dm365.c                 | 175 +++-----
 arch/arm/mach-davinci/dm644x.c                | 145 +++----
 arch/arm/mach-davinci/dm646x.c                | 159 +++----
 arch/arm/mach-davinci/include/mach/common.h   |  14 +-
 arch/arm/mach-davinci/include/mach/da8xx.h    |   2 +
 .../mach-davinci/include/mach/entry-macro.S   |  39 --
 arch/arm/mach-davinci/include/mach/irqs.h     | 409 ------------------
 arch/arm/mach-davinci/irq.c                   | 117 -----
 arch/arm/mach-davinci/usb-da8xx.c             |   7 +-
 arch/arm/mach-davinci/usb.c                   |   7 +-
 drivers/irqchip/Kconfig                       |  10 +
 drivers/irqchip/Makefile                      |   2 +
 drivers/irqchip/irq-davinci-aintc.c           | 141 ++++++
 drivers/irqchip/irq-davinci-cp-intc.c         | 224 ++++++++++
 include/linux/irqchip/irq-davinci-aintc.h     |  19 +
 include/linux/irqchip/irq-davinci-cp-intc.h   |  18 +
 40 files changed, 829 insertions(+), 1617 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/cp_intc.c
 delete mode 100644 arch/arm/mach-davinci/cp_intc.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-davinci/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-davinci/irq.c
 create mode 100644 drivers/irqchip/irq-davinci-aintc.c
 create mode 100644 drivers/irqchip/irq-davinci-cp-intc.c
 create mode 100644 include/linux/irqchip/irq-davinci-aintc.h
 create mode 100644 include/linux/irqchip/irq-davinci-cp-intc.h

-- 
2.20.1

