Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450EBC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E987F20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E987F20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbeG0J0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:26:48 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16333 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbeG0J0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:26:48 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b5ad2620002>; Fri, 27 Jul 2018 01:05:54 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 27 Jul 2018 01:06:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 27 Jul 2018 01:06:05 -0700
Received: from dhcp-10-21-25-168 (10.21.25.201) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 27 Jul
 2018 08:06:01 +0000
Date:   Fri, 27 Jul 2018 11:05:55 +0300
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Stefan Agner <stefan@agner.ch>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra-owner@vger.kernel.org>
Subject: Re: [PATCH v2 02/10] dt-bindings: mmc: tegra: Add nvidia,only-1-8-v
 property
Message-ID: <20180727110555.1b7ad97d@dhcp-10-21-25-168>
In-Reply-To: <484a31bdaad6d76b4fbb7d6fa80cbb8d@agner.ch>
References: <1532607560-11253-1-git-send-email-avienamo@nvidia.com>
        <1532607560-11253-3-git-send-email-avienamo@nvidia.com>
        <484a31bdaad6d76b4fbb7d6fa80cbb8d@agner.ch>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.21.25.201]
X-ClientProxiedBy: UKMAIL101.nvidia.com (10.26.138.13) To HQMAIL101.nvidia.com
 (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 15:05:55 +0200
Stefan Agner <stefan@agner.ch> wrote:

> On 26.07.2018 14:19, Aapo Vienamo wrote:
> > Add a property to mark controllers which operate at a 1.8 V fixed I/O
> > voltage.
> > 
> > This feature of the hardware needs to be signaled this way because it
> > cannot be probed at runtime or reliably derived from other properties.  
> 
> Is this really needed? Can we not use vqmmc to determine which voltage
> the controller runs on?
> 
> There is already some precedence in the SDHCI core to determine which
> voltage levels are supported:
> https://lkml.org/lkml/2018/7/5/342

This property is introduced to solve a slightly different issue. The
thing is that supplying a fixed voltage SDHCI controller from a variable
regulator is still a valid configuration. Which means that testing the
capabilities of the regulator doesn't actually describe the SDHCI
controller itself.

In practice this property is used to communicate whether pad
reconfiguration and voltage switching needs to be performed or not. This
cannot be determined from the absence or presence of the pinctrl
properties either because they naturally won't be there on older dtbs.

The logic behind this goes like this: if this property is present,
there's no need to perform pad or regulator reconfiguration and UHS
modes can be enabled. If this property is missing then valid pinctrl and
regulator properties are required to enable UHS signaling. This is
implemented in tegra_sdhci_is_uhs_valid() in "[PATCH v2 03/10] mmc:
tegra: Reconfigure pad voltages during voltage switching"

 -Aapo
