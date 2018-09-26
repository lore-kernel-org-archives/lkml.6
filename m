Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D374C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB95C20684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="J1v3FXU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB95C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeIZSkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:40:31 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8699 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbeIZSkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:40:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bab7b460000>; Wed, 26 Sep 2018 05:27:51 -0700
Received: from HQMAIL105.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 26 Sep 2018 05:27:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 26 Sep 2018 05:27:45 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 26 Sep
 2018 12:27:43 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 26 Sep
 2018 12:27:43 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Sep 2018 12:27:43 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.132.143]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bab7b3d0004>; Wed, 26 Sep 2018 05:27:43 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 0/5] Tegra xHCI genpd support
Date:   Wed, 26 Sep 2018 13:27:33 +0100
Message-ID: <1537964858-30332-1-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1537964871; bh=qbTAQD9IltqQcEM8ekVFE+/WZufmTLx8l1mHnQPF88M=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=J1v3FXU5Ws/NbNL2Bzq9NGbfTvGzb0UdR5PektbxU9tadUPplMLCvUYgR0DDVPmCJ
         CqRgZBJI+rhH4/jD0kVl8n4KKi7JwGQSWPmsvppmYrGf+nGlh2Wjh6e0yvHNTou1ds
         PsfeapkiRNdYF2MT4TrSE5fuBCnwYedCD1AyIkXoLmXM0WgViCetwxYJVKKgyhS6+t
         sSmxWlaA/W/ZHAqJlJqnokp0bYNKXGe5Yq56q6kbiuf7Jvb9U0Uia8Hj8NH236sKST
         ZPrwlPS/SGuBJhl57IpUrNjYmC3jgx6nAvocKlEUrSU+jw+yn+I44ktaDHEzw23Vmr
         ivhun70I69Wug==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add genpd support for the Tegra xHCI device that requires
more than one power-domain to operate.

This series is making changes to more than one subsystem and at first
glance may look like a maintainers nightmare. However, my proposal is
this, once reviewed and people are happy ...
1. Patches 1-3 should be merged first. Note there is a dependency
   between patches 1 and 3 such that 3 can only be merged once 1 has
   been accepted.
2. Once patches 1-3 are accepted, then 4 and 5 can be merged via the
   Tegra tree.

Jon Hunter (5):
  PM / Domains: Export symbol for genpd_dev_pm_attach_by_name
  dt-bindings: usb: xhci-tegra: Add power-domain details
  usb: xhci: tegra: Add genpd support
  soc/tegra: pmc: Don't power-up XUSB power-domains
  arm64: dts: tegra210: Add power-domains for xHCI

 .../bindings/usb/nvidia,tegra124-xusb.txt          |  8 ++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  2 +
 drivers/base/power/domain.c                        |  1 +
 drivers/soc/tegra/pmc.c                            | 16 ----
 drivers/usb/host/xhci-tegra.c                      | 88 +++++++++++++++++++---
 5 files changed, 88 insertions(+), 27 deletions(-)

-- 
2.7.4

