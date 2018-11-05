Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C66ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 03:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBAE2082A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 03:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BEPL279p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBAE2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbeKEMe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 07:34:27 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45890 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbeKEMe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 07:34:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id p17-v6so3313028pfj.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 19:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+Abqyr0Tlz0dd8ae03r0keXJovqhbjDX9+vNfD+Uzik=;
        b=BEPL279pKdQHOlzlhabGHLAJgREkzorzBOB9kb6szIY6paHzHSz0h2CHZGhZ1ryVk9
         DTl8TEFBI37jIonnbqdBYmKVNT5cvSr4pCWEjw46mKvVPyfmDzAZM3H6S7vfuMM0PvCq
         w4ZUxFOaILNGGi/c6dmoxMCx6+FId1Mwa81D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+Abqyr0Tlz0dd8ae03r0keXJovqhbjDX9+vNfD+Uzik=;
        b=cHVI3xGLN6LWJHoHVAAEMvzaQZV+slllxuZ4p9tIwVra9dy4vjp1he223vaZY3BiZ+
         9FSX4VyKbiwJ9+UOOW8VTKn1RIzwYAJNVHgACz6zxvelfg2/BLhjl59d1rSOKK2omMsE
         ZB0R8ru23Edi9U5d1qlSDSGd1RGMcpZj0qkCRGR1Xuz4mfDm6U1la9gi2Hh8gOcrQdPj
         hzaqe6MXltJl+EV6xnCKcpgOVe3nS8iXwW+negbmmRrSqOObY8EmLlelrmK8e1/ul9VP
         /tPMAtrB8BxmvGtNklkcAHd+OsZdo7LO2OpdsH8DejLfkBOhYdPoJqyiz01hA7f1nmE/
         JFMg==
X-Gm-Message-State: AGRZ1gL7joPAUZ1UHI0OsHY0xvSBqzyQU1lNyUmC4hmn1RQ1A12Zykr8
        zBMwPSiDHdsWEfb1MHMz5C/vHw==
X-Google-Smtp-Source: AJdET5d3IQsBBeeuM+JavzKZOcuTeTNRkChYZ13CdjsmUutLMCCXNZHeOFVNvbg6d4zwdOK9OdT7YA==
X-Received: by 2002:a63:ee0e:: with SMTP id e14mr18263487pgi.8.1541387818840;
        Sun, 04 Nov 2018 19:16:58 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id f10-v6sm40182773pgp.72.2018.11.04.19.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Nov 2018 19:16:57 -0800 (PST)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH RFC 0/3] Add support for using external dma in SDHCI
Date:   Mon,  5 Nov 2018 11:16:47 +0800
Message-Id: <1541387810-24867-1-git-send-email-zhang.chunyan@linaro.org>
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

Chunyan Zhang (3):
  mmc: sdhci: add support for using external DMA devices
  mmc: sdhci-omap: Add using external dma
  dt-bindings: sdhci-omap: Add example for using dmaengine

 .../devicetree/bindings/mmc/sdhci-omap.txt         |   7 ++
 drivers/mmc/host/Kconfig                           |  13 ++
 drivers/mmc/host/sdhci-omap.c                      |   7 ++
 drivers/mmc/host/sdhci.c                           | 137 ++++++++++++++++++++-
 drivers/mmc/host/sdhci.h                           |  12 ++
 5 files changed, 175 insertions(+), 1 deletion(-)

-- 
2.7.4

