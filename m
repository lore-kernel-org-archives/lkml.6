Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A531C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36FC206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Of9pgjyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36FC206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbeIKWI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:08:56 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55096 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbeIKWIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:08:54 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8BH8YBu036275;
        Tue, 11 Sep 2018 12:08:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536685714;
        bh=jIEKUb4Td+cQ6AwjCG+5Y5mrHSrf1qG8gMHsR3DD7T4=;
        h=From:To:CC:Subject:Date;
        b=Of9pgjyuORmqoMwAuVKf8RJ0vkSV0DHCveU5Tu2DvtkC/25wQwk5p/X4gaGnd8l++
         RB6NwmsVm7B1jlmtRvkNEbYeQkWnEXS99DIUJiXbCeVyv2JRz0Dd8L3zi3XCN4+Vej
         WAQT+hJUMSXsEhyiIAol8OOqaZA3rd0QIKYhaJDE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8BH8Y0R031409;
        Tue, 11 Sep 2018 12:08:34 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 11
 Sep 2018 12:08:34 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 11 Sep 2018 12:08:34 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8BH8YpI015281;
        Tue, 11 Sep 2018 12:08:34 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.156.248])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w8BH8Xx21184;
        Tue, 11 Sep 2018 12:08:33 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee.jones@linaro.org>, <linux-omap@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v7 0/6] LM3697 dedicated LED driver
Date:   Tue, 11 Sep 2018 12:08:19 -0500
Message-ID: <20180911170825.17789-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All

The LM3697 LED driver has two opportunities to be included in the Linux
kernel source.

The ti-lmu MFD driver and the leds-lm3697 driver contained in this series.

This LED driver is basic in nature and is not really suitable for the MFD
inclusion.  This device has no other function than to control the LEDs.

So this series will remove the lm3697 from the ti-lmu and add the driver
in the LEDs directory.

Dan Murphy


Dan Murphy (6):
  dt-bindings: ti-lmu: Remove LM3697
  mfd: ti-lmu: Remove support for LM3697
  dt-bindings: leds: Add bindings for lm3697 driver
  leds: lm3697: Introduce the lm3697 driver
  dt-bindings: leds: Add runtime ramp node for LM3697
  leds: lm3697: Add ramp rate feature

 .../devicetree/bindings/leds/leds-lm3697.txt  |  98 ++++
 .../devicetree/bindings/mfd/ti-lmu.txt        |  26 +-
 drivers/leds/Kconfig                          |   9 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-lm3697.c                    | 449 ++++++++++++++++++
 drivers/mfd/Kconfig                           |   2 +-
 drivers/mfd/ti-lmu.c                          |  17 -
 include/linux/mfd/ti-lmu-register.h           |  44 --
 include/linux/mfd/ti-lmu.h                    |   1 -
 9 files changed, 559 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
 create mode 100644 drivers/leds/leds-lm3697.c

-- 
2.17.0.1855.g63749b2dea

