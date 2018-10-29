Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC32C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3860B20870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OjjHnNrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3860B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbeJ2Sz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:55:57 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:51986 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbeJ2Sz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:55:57 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id DBCD824E11D9;
        Mon, 29 Oct 2018 03:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1540807678; bh=cv+vAGIaacXfqsm6laxKspmfbhBbpJnIh33JEQ/PZN0=;
        h=From:To:Cc:Subject:Date:From;
        b=OjjHnNrA7/5Ji4V+qYIlPitzYwrqss7kviqX7GdPSQYOiS/O/gctzdzg2PxnuQ3sr
         r+z8J9TlyoRsE1/+F25X9iSFFsmSUh5YkRUK0XYVsJ6Hw2abck0jaPq4DUbawUk5Pg
         w8vN4PLBElAuwbo/RojjTbhvB4VjscDBe1eoEl1CfS4FikjcRIGeqZ4NgRlIlA2frZ
         /zOIL5CPqu63iBQ7vpQu0IXhiCZhcbaqIm/NgDXIPMTN3hCu9kAd1qvi0D6n+Puodk
         sXi++UEs+iI4zXyhRdlcQmpOrY+uuwuFeHpuI8NRYQ6cigoFBHXZ1cG7ZgUxx8QVU1
         8qA9/rOoV9a+Q==
Received: from localhost.localdomain (soares-e7470.internal.synopsys.com [10.225.2.39])
        by mailhost.synopsys.com (Postfix) with ESMTP id CF3245444;
        Mon, 29 Oct 2018 03:07:46 -0700 (PDT)
From:   Vitor soares <vitor.soares@synopsys.com>
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
        joao.pinto@synopsys.com, luis.oliveira@synopsys.com,
        manuel.abreu@synopsys.com, gustavo.pimentel@synopsys.com
Subject: [PATCH 0/3] Add driver for Synopsys DesignWare I3C master IP
Date:   Mon, 29 Oct 2018 10:06:55 +0000
Message-Id: <1540807618-13246-1-git-send-email-soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is a proposal for the I3C master driver for Synopsys IP.
This patch is to be applied on top of I3C subsystem RFC V10 submitted bu Boris Brezillon.

The change made on bufs passed to i3c_master_send_ccc_cmd_locked() be dynamically allocated allow the use of writesl/readsl() function on I3C transfers.
For I2C transfers still have memory misalignment on bufs and if the client try to read more than 4bytes the system stops. This will fixed next version.

Supported features:
  Regular CCC commands.
  I3C private transfers.
  I2C transfers.

Missing functionalities:
  Support for I3C_BUS_MODE_MIXED_SLOW.
  Hot-join.
  IBI.

Main change between v1 and v2:
  Add controller version on dt-binding
  The driver now calls writesl/readsl() instead readl/writel
  Rename some variables in the driver
   

Vitor soares (3):
  i3c: master: Add driver for Synopsys DesignWare IP
  dt-bindings: i3c: Document Synopsys DesignWare I3C master bindings
  MAINTAINERS: Add myself as the dw-i3c-master module maintainer

 .../devicetree/bindings/i3c/snps,dw-i3c-master.txt |   42 +
 MAINTAINERS                                        |    6 +
 drivers/i3c/master/Kconfig                         |   13 +
 drivers/i3c/master/Makefile                        |    1 +
 drivers/i3c/master/dw-i3c-master.c                 | 1217 ++++++++++++++++++++
 5 files changed, 1279 insertions(+)
 create mode 100755 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
 create mode 100755 drivers/i3c/master/dw-i3c-master.c

-- 
2.7.4


