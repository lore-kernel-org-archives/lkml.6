Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87D9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F8D223CB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hGG9f1iX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F8D223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733208AbeKNAI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:08:56 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:33646 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730991AbeKNAI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:08:56 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id DCF7C10C0F18;
        Tue, 13 Nov 2018 06:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542118236; bh=q+hAuxtRGzrVfESAaZZPZxRKVXFV5tjaLNkQ22AsmrA=;
        h=From:To:Cc:Subject:Date:From;
        b=hGG9f1iXbK09NvRfb9/E2Hfs+IKe95U1ffE3QOsLchCvpyI+fg4YCBcfyscSvcm+4
         WCz4otrTONivF1zqYjzAHo4Ow5vDqNAGlQUw3/GB8l206oPqRD2SOiEWobwpbQj3Q0
         miVOzh5wehtfvICQz4TJ451llvuUqgveAWIyLEgnWnaYn97npO3Twym7A8xMOnZ9zb
         i1+hVwgq+cJQYGHk09fOKUVJrq8ZE66neg+LjP/+F1Ub+YqXwJxiCNbhhlcgj99DBC
         KEcqz1QVl5imMpPYMoBk7JISAZp0dJ4DkwvgruFiODRHk22y3R/C0jOyCeEW2fCOMC
         4wsXZ7AKRNINw==
Received: from vitor-VirtualBox.internal.synopsys.com (soares-e7470.internal.synopsys.com [10.107.19.128])
        by mailhost.synopsys.com (Postfix) with ESMTP id 302805662;
        Tue, 13 Nov 2018 06:10:28 -0800 (PST)
From:   Vitor Soares <vitor.soares@synopsys.com>
To:     boris.brezillon@bootlin.com, wsa@the-dreams.de,
        linux-i2c@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        arnd@arndb.de
Cc:     psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com,
        bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com,
        cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com,
        thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vitor.soares@synopsys.com, geert@linux-m68k.org,
        linus.walleij@linaro.org, Xiang.Lin@synaptics.com,
        linux-gpio@vger.kernel.org, nsekhar@ti.com, pgaj@cadence.com,
        peda@axentia.se, mshettel@codeaurora.org, swboyd@chromium.org,
        joao.pinto@synopsys.com
Subject: [PATCH v4 0/3] Add driver for Synopsys DesignWare I3C master IP
Date:   Tue, 13 Nov 2018 14:09:50 +0000
Message-Id: <1542118193-24925-1-git-send-email-vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is a proposal for the I3C master driver for Synopsys IP.
This patch is to be applied on top of I3C subsystem RFC V10 submitted by
Boris Brezillon.

Supported features:
  Regular CCC commands.
  I3C private transfers.
  I2C transfers.

Missing functionalities:
  Support DMA interface.
  Support for I3C_BUS_MODE_MIXED_SLOW.
  Hot-join.
  IBI.

Main change between v3 and v4:
- Minor fixes. They are described in each patch

Main change between v2 and v3:
- Minor fixes. They are described in each patch

Main change between v1 and v2:
- Add controller version on dt-binding
- The driver now calls writesl/readsl() instead readl/writel
- Rename some variables in the driver

Vitor Soares (3):
  i3c: master: Add driver for Synopsys DesignWare IP
  dt-binding: i3c: Document Synopsys DesignWare I3C
  MAINTAINERS: Add myself as the dw-i3c-master module maintainer

 .../devicetree/bindings/i3c/snps,dw-i3c-master.txt |   41 +
 MAINTAINERS                                        |    6 +
 drivers/i3c/master/Kconfig                         |   14 +
 drivers/i3c/master/Makefile                        |    1 +
 drivers/i3c/master/dw-i3c-master.c                 | 1216 ++++++++++++++++++++
 5 files changed, 1278 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
 create mode 100644 drivers/i3c/master/dw-i3c-master.c

-- 
2.7.4


