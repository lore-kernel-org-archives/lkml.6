Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4403FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED647205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QWmJju6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED647205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030648AbeFSToJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:44:09 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:12439 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030433AbeFSToH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:44:07 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelnx193.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5JJgrD0017767;
        Tue, 19 Jun 2018 14:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529437373;
        bh=st3gD9gvpYgzJkAAE9OosdHm7DBij4fTCHJkv9SuC/I=;
        h=From:To:CC:Subject:Date;
        b=QWmJju6OEaaDF8UIXCaFrvLpIFnLlcG5PjbK13AZe2aL/6HBJR49eTYyKLQHZtB+u
         KBtrrLSYkgExnOQ4C0eypGOYho7dAK4DqAvqzrYxmpzd/RA1EnVAxlR9/ZwKhqNtLH
         w3hIgQZ0SPRQtGVzHT5Y/bYu4YSYaralPhaIQBtw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJgrjf023368;
        Tue, 19 Jun 2018 14:42:53 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 19
 Jun 2018 14:42:53 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 19 Jun 2018 14:42:53 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJgrYQ031549;
        Tue, 19 Jun 2018 14:42:53 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 0/5] arm64: Initial support Texas Instrument's AM654 Platform
Date:   Tue, 19 Jun 2018 14:42:48 -0500
Message-ID: <20180619194253.27288-1-nm@ti.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This is an update from RFC posted earlier:
        https://marc.info/?l=linux-arm-kernel&m=152817866312732&w=2

The following series enables support for newest addition in TI's SoC
portfolio - AM654 SoC.

The series is based off v4.18-rc1, also available here:
https://github.com/nmenon/linux-2.6-playground/tree/upstream/v4.18-rc1/k3-1-am6-base

Key changes since RFC are indicated in respective patches:
* dt bindings updates (from review comments)
* device tree is split up to incorporate ranges and bus segments
* Cosmetic fixes including renaming the base dts to prevent confusion
* UART has been split out

Consolidated all patches (including all series) are available here:
https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.18-rc1/k3-am6-integ

Full Boot log (integrated of all series) is available here:
   https://pastebin.ubuntu.com/p/bBFmnzYtCd/

NOTE: The uart series is seperated out and we get operational console only
after that series is merged.

The AM654 SoC is a lead device of the K3 Multicore SoC architecture
platform, targeted for broad market and industrial control with aim to
meet the complex processing needs of modern embedded products.

The Linux development follows closely the 66AK2G SoC model in aarch64.

See AM65x Technical Reference Manual (SPRUID7, April 2018)
for further details: http://www.ti.com/lit/pdf/spruid7

Nishanth Menon (5):
  dt-bindings: arm: ti: Add bindings for AM654 SoC
  arm64: Add support for TI's K3 Multicore SoC architecture
  arm64: dts: ti: Add Support for AM654 SoC
  soc: ti: Add Support for AM654 SoC config option
  arm64: dts: ti: Add support for AM654 EVM base board

 Documentation/devicetree/bindings/arm/ti/k3.txt |  23 +++++
 MAINTAINERS                                     |   9 ++
 arch/arm64/Kconfig.platforms                    |   7 ++
 arch/arm64/boot/dts/Makefile                    |   1 +
 arch/arm64/boot/dts/ti/Makefile                 |   9 ++
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi        |  31 +++++++
 arch/arm64/boot/dts/ti/k3-am65.dtsi             |  87 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts  |  36 ++++++++
 arch/arm64/boot/dts/ti/k3-am654.dtsi            | 115 ++++++++++++++++++++++++
 drivers/soc/ti/Kconfig                          |  14 +++
 10 files changed, 332 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/ti/k3.txt
 create mode 100644 arch/arm64/boot/dts/ti/Makefile
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654-base-board.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654.dtsi

-- 
2.15.1

