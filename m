Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983D4C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40130216E5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JN2ixLKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40130216E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934479AbeF0Mnw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 08:43:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41742 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934434AbeF0Mnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 08:43:50 -0400
X-Greylist: delayed 895 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jun 2018 08:43:50 EDT
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5RCSkbh101746;
        Wed, 27 Jun 2018 07:28:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530102526;
        bh=Bq+zJspI5iXtki90MgFw3SfgywwjqPRjiXCpzJAAOC4=;
        h=From:To:CC:Subject:Date;
        b=JN2ixLKc2iLfVvehVdgYZR9ZuB/s1fe+sYJqCYKRLF10YIslMxcUUuGoyZSlA3WS+
         /STE3Ai3jnwQeS3WiIo6M0IBIbci9hzStHLBuJxbCl6itcIz16f+ezgnwxbE4wcjer
         r9QKefTZRBGusnilinKblVrihYE5HHoMMVJuK9ek=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5RCSkXh000668;
        Wed, 27 Jun 2018 07:28:46 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 27
 Jun 2018 07:28:46 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 27 Jun 2018 07:28:46 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5RCSgMr027559;
        Wed, 27 Jun 2018 07:28:43 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 0/4] pci-dra7xx: Enable errata i870 workaround for RC mode
Date:   Wed, 27 Jun 2018 17:59:15 +0530
Message-ID: <20180627122919.23926-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make workaround for errata i870 applicable in Host mode as
well(previously it was enabled only for EP mode) as per errata
documentation: http://www.ti.com/lit/er/sprz450/sprz450.pdf

Tested on DRA72 EVM

Changes since v1:
Drop IRQ handling rework (will be sent out separately)

v1: https://lkml.org/lkml/2017/12/1/59

Vignesh R (4):
  dt-bindings: PCI: dra7xx: Add bindings for unaligned access in host
    mode
  pci: dwc: pci-dra7xx: Enable errata i870 for both EP and RC mode
  ARM: dts: dra7: Enable workaround for errata i870 in PCIe host mode
  ARM: dts: dra7: Fix up unaligned access setting for PCIe EP

 Documentation/devicetree/bindings/pci/ti-pci.txt |  5 +++++
 arch/arm/boot/dts/dra7.dtsi                      |  4 +++-
 drivers/pci/controller/dwc/pci-dra7xx.c          | 12 ++++++------
 3 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.18.0

