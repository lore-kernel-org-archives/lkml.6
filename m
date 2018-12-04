Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47047C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09234214D9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ep2qBWhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09234214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbeLDHYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:24:41 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37851 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLDHYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 02:24:41 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so7854526plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 23:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5dwK9Gc1ilATX5PZtGQWTIvlOupWvPV8pyzXonNFRrQ=;
        b=Ep2qBWhHgvCqDyTB80T3hNTLTnvOkVG7PBahc5Qk72N+Df2qAfE2XbE+XKXXSVKyw6
         H7HSn/V/trwoWDd4Nmi+6j0ea5B+pSAdyDWWFK3EDVPsmkwWg3FF2VoBKj5A2J3R/pG+
         Q+Zj6CSC95OyvWWLamedhEgFy4lWJ/zBBgQxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5dwK9Gc1ilATX5PZtGQWTIvlOupWvPV8pyzXonNFRrQ=;
        b=Ea4CMWX+bvZ2uoAvOdatFZILjtxRgluHRbrT/qNEEXs5tc0OMh01fL4WvGZRPDTpQA
         iPlwYYu5ES/Qy28HhZ7KRXhb99UrW9iOc865nBz9TkxBpJxVV3MIRMX45i0Fxhf1sTS9
         +Uga51iUBjY3CwXDAsUs1B9oi5ExTRILvVOmGx3Rx7BxnlvZScOvT+Y1+DLpd4TiznU9
         CGUKL+TyKdCz7JE5tMo/ThwgliIJ5ejUPcFqxIwMArDGosg0t1BURscLKMbzoBNPew1h
         +1d++tfFmLCqsaZO+pQuzoRXjE1U/xaDTScCS+867gxxqH9kopsF9KVSb8IIcZWaAQM2
         J/Mg==
X-Gm-Message-State: AA+aEWaZrNTLZ3muSa3o02xmKUhfwWB047OiBEecbiRCK9J0iCMf7diK
        bZgegRqPyB5W+bSTkjSX/PEVZA==
X-Google-Smtp-Source: AFSGD/WfXi/ih4hBizPf1FR88wNhObowVHTSdRVYWusq4OVRjcYW9TOWg1rHMAlKWFZ5XbDrnvH1Ew==
X-Received: by 2002:a17:902:bf0c:: with SMTP id bi12mr18526341plb.0.1543908279641;
        Mon, 03 Dec 2018 23:24:39 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id g136sm22705943pfb.154.2018.12.03.23.24.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Dec 2018 23:24:38 -0800 (PST)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V3 0/3] Add support for using external dma in SDHCI
Date:   Tue,  4 Dec 2018 15:24:27 +0800
Message-Id: <1543908270-13953-1-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the generic SDHCI code in the Linux kernel supports the SD
standard DMA integrated into the host controller but does not have any
support for external DMA controllers implemented using dmaengine meaning
that custom code is needed for any systems that use a generic DMA
controller with SDHCI which in practice means any SDHCI controller that
doesn't have an integrated DMA controller so we should have this as a
generic feature.

There are already a number of controller specific drivers that have dmaengine
code, and some could use sdhci.c actually, but needed to implement mmc_ops->request()
in their specific driver for sending command with external dma using dmaengine
framework, with this patchset, them will take advantage of the generic support.
TI's omap controller is the case as an example.

Any comments are very appreciated.

Thanks,
Chunyan

Changes from v2 (https://lkml.org/lkml/2018/11/12/1936):
* Remove CONFIG_EXTERNAL_DMA prompt and help graph;
* Add checking for cmd->data;
* Select MMC_SDHCI_EXTERNAL_DMA for MMC_SDHCI_OMAP;
* Add checking if there's 'dmas' in device tree before decide using external dma.

Changes from v1 (https://lkml.org/lkml/2018/11/5/110):
(The code on patch 1/3 only was revised)
* Address comments from Arnd:
- Release channel when failed to request it unconditionally;
- Skip warning message if get EPROBE_DEFER;
* Address Andrian's comments:
- Replace extdma with external_dma;
- Add release dma resources in sdhci_cleanup_host() and sdhci_remove_host();
- Release dma resources once dmaengine_submit() failed.
- Put rx/tx_chan in struct sdhci_host, and removed unused structure.
* Fall back to the DMA/PIO which standard SDHCI supports, if sdhci_external_dma_setup()
  or sdhci_external_dma_init failed;

Chunyan Zhang (3):
  mmc: sdhci: add support for using external DMA devices
  mmc: sdhci-omap: Add using external dma
  dt-bindings: sdhci-omap: Add example for using external dma

 .../devicetree/bindings/mmc/sdhci-omap.txt         |   7 +
 drivers/mmc/host/Kconfig                           |   4 +
 drivers/mmc/host/sdhci-omap.c                      |  10 ++
 drivers/mmc/host/sdhci.c                           | 185 ++++++++++++++++++++-
 drivers/mmc/host/sdhci.h                           |   8 +
 5 files changed, 213 insertions(+), 1 deletion(-)

-- 
2.7.4

