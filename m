Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C88EECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D597220673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D597220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbeGTLrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:47:03 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12041 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbeGTLrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:47:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b51c0830000>; Fri, 20 Jul 2018 03:59:15 -0700
Received: from HQMAIL105.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 20 Jul 2018 03:59:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 20 Jul 2018 03:59:21 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 20 Jul
 2018 10:59:21 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Fri, 20 Jul 2018 10:59:20 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b51c0860002>; Fri, 20 Jul 2018 03:59:20 -0700
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
CC:     Aapo Vienamo <avienamo@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/7] Tegra PMC pinctrl pad configuration
Date:   Fri, 20 Jul 2018 13:59:08 +0300
Message-ID: <1532084355-31482-1-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The Tegra Power Management Controller (PMC) can set pad power states
and voltage configuration. This series implements pinctrl interfaces
for configuring said pad properties.

Changelog
v5:
	- Fix a typo in "soc/tegra: pmc: Remove public pad voltage APIs"
		- 1.8 V / 3.3 V selection logic worked the wrong way
		  around on SoCs without pmc->soc->has_impl_33v_pwr.
v4:
	- Revise the dt-bindings docs
v3:
	- Don't expose tegra_io_pad_is_powered()
	- Remove tegra_io_pad_set_voltage() stub from pmc.h
		- Fixes i386 build failure reported by kbuild test robot
v2:
	- Add Tegra186 AO_HV pad
	- Make the IO pad tables narrower
	- Add parens to TEGRA_IO_PAD() and TEGRA_IO_PIN_DESC()
	- Fix a typo in the dt-bindings docs
	- Remove old pmc pad voltage configuration APIs
	- Check return value of tegra_io_pad_find() in
	  tegra_io_pad_pinconf_get()/_set()

Aapo Vienamo (7):
  soc/tegra: pmc: Fix pad voltage configuration for Tegra186
  soc/tegra: pmc: Factor out DPD register bit calculation
  soc/tegra: pmc: Implement tegra_io_pad_is_powered()
  soc/tegra: pmc: Use X macro to generate IO pad tables
  dt-bindings: Add Tegra PMC pad configuration bindings
  soc/tegra: pmc: Remove public pad voltage APIs
  soc/tegra: pmc: Implement pad configuration via pinctrl

 .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |  92 ++++
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 103 +++++
 drivers/soc/tegra/pmc.c                            | 512 +++++++++++++++------
 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h |  18 +
 include/soc/tegra/pmc.h                            |  20 +-
 5 files changed, 597 insertions(+), 148 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h

-- 
2.7.4

