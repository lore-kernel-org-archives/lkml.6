Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FB4ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AA4208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5AA4208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732981AbeGMPyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:54:43 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7284 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbeGMPym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:54:42 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b48c7b20000>; Fri, 13 Jul 2018 08:39:30 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 13 Jul 2018 08:39:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 13 Jul 2018 08:39:34 -0700
Received: from dhcp-10-21-25-168 (10.21.25.201) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 13 Jul
 2018 15:39:31 +0000
Date:   Fri, 13 Jul 2018 18:39:25 +0300
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Jon Hunter <jonathanh@nvidia.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        <linux-mmc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: tegra: Add and use tegra_sdhci_get_max_clock()
Message-ID: <20180713183925.67d7d5f4@dhcp-10-21-25-168>
In-Reply-To: <6af41450-4770-3b2d-05b8-914f90743a7e@nvidia.com>
References: <1531487865-17427-1-git-send-email-avienamo@nvidia.com>
        <6af41450-4770-3b2d-05b8-914f90743a7e@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.21.25.201]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To HQMAIL101.nvidia.com
 (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jul 2018 15:01:21 +0100
Jon Hunter <jonathanh@nvidia.com> wrote:

> On 13/07/18 14:17, Aapo Vienamo wrote:
> > Implement and use tegra_sdhci_get_max_clock() which returns the true
> > maximum host clock rate. The issue with tegra_sdhci_get_max_clock() is  
> 
> Don't you mean sdhci_pltfm_clk_get_max_clock above? Does this function
> need fixing then? Or at least should there be another variant added
> because there is nothing Tegra specific we are doing below?

There are several drivers which use sdhci_pltfm_clk_get_max_clock() in
its current state and changing it could have unforeseen side-effects on
drivers which I'm unable to test. Adding another variant of 
sdhci_pltfm_clk_get_max_clock() would probably be a more feasible
approach.

> > that it returns the current clock rate of the host instead of the
> > maximum one, which can lead to unnecessarily small clock rates.
> > 
> > This differs from the previous implementation of
> > tegra_sdhci_get_max_clock() in that it doesn't divide the result by two.  
> 
> Why?

As far as I can tell the original tegra_sdhci_get_max_clock() was
implemented this way in order to force sdhci_calc_clk() to always set
the SDHCI clock divider to two on sdhci_set_clock(). The requirement to
configure the SDHCI divider to two is specific to DDR50/52 modes on
Tegra.

The .get_max_clock() callback retuning half of the actual maximum will
result in HS200 and HS400 modes not being able to run at full speed.
Another mechanism to enforce the divider requirement has to be figured
out in order to enable DDR50/52 modes on Tegra SoCs.

 -Aapo
