Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE8AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA4520880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VzMQ7Nci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA4520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388475AbeGXSih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:38:37 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43976 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388324AbeGXSih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:38:37 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6OHUwdF099530;
        Tue, 24 Jul 2018 12:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532453458;
        bh=ZcoqMlJlRRSnMxcYyEuWz6BPKj5BCYWiTRG+Zfa3Mjk=;
        h=From:To:CC:Subject:Date;
        b=VzMQ7Nci9sDSExPClk6YRFE+TpBNGq9FBsi7TVpAWZnAQl3c2uo5JpJVWjE9L9WJc
         GgG/kuhqTqEDhsXx5b/hPlLt8IRuVumXj5gRvPwBpgI3FMpwYXD5DQtavhkfatFpsm
         NJaGmh3b5G2Q7iZJM0txtkMnhr4PvJ1fGR+mXeVc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6OHUwKs010535;
        Tue, 24 Jul 2018 12:30:58 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 24
 Jul 2018 12:30:58 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 24 Jul 2018 12:30:58 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6OHUt8S031458;
        Tue, 24 Jul 2018 12:30:55 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>
Subject: [PATCH v3 0/4] pci-dra7xx: Enable errata i870 workaround for RC mode
Date:   Tue, 24 Jul 2018 23:01:46 +0530
Message-ID: <20180724173150.2701-1-vigneshr@ti.com>
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

Tony,

If you are okay with the series, could you pick this via omap tree?
All ACKs are in place and Lorenzo is okay with PCIe bits to go along with
rest of DTS changes.

Regards
Vignesh


Changes since v2:
Reorder patch 2 to appear at the last.
Collect all the ACKs

Changes since v1:
Drop IRQ handling rework (will be sent out separately)

v2: https://patchwork.ozlabs.org/cover/935454/
v1: https://lkml.org/lkml/2017/12/1/59


Vignesh R (4):
  dt-bindings: PCI: dra7xx: Add bindings for unaligned access in host
    mode
  ARM: dts: dra7: Enable workaround for errata i870 in PCIe host mode
  ARM: dts: dra7: Fix up unaligned access setting for PCIe EP
  pci: dwc: pci-dra7xx: Enable errata i870 for both EP and RC mode

 Documentation/devicetree/bindings/pci/ti-pci.txt |  5 +++++
 arch/arm/boot/dts/dra7.dtsi                      |  4 +++-
 drivers/pci/controller/dwc/pci-dra7xx.c          | 12 ++++++------
 3 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.18.0

