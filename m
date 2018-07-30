Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF421FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2EF820870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2EF820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbeG3RTd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:19:33 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16316 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbeG3RTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:19:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b5f32330001>; Mon, 30 Jul 2018 08:43:47 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 30 Jul 2018 08:43:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 30 Jul 2018 08:43:59 -0700
Received: from dhcp-10-21-25-168 (10.21.25.201) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 30 Jul
 2018 15:43:56 +0000
Date:   Mon, 30 Jul 2018 18:43:51 +0300
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Mikko Perttunen" <mperttunen@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/10] Tegra SDHCI update the pad autocal procedure
Message-ID: <20180730184351.5044cb6e@dhcp-10-21-25-168>
In-Reply-To: <CAPDyKFo+nv+9qYV=J5k-63cDhQO=L==87RLMj_7BnjEjUf5iEQ@mail.gmail.com>
References: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
        <CAPDyKFo+nv+9qYV=J5k-63cDhQO=L==87RLMj_7BnjEjUf5iEQ@mail.gmail.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.21.25.201]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To HQMAIL101.nvidia.com
 (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018 17:07:59 +0200
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On 26 July 2018 at 14:26, Aapo Vienamo <avienamo@nvidia.com> wrote:
> > Hi all,
> >
> > Update the tegra_sdhci_pad_autocalib() pad drive strength calibration
> > procedure to match the ones specified in the TRMs of the more recent
> > SoCs. This was tested on Tegra186, Tegra210, and Tegra124, although it
> > should not break things older generations either.
> >
> > This series depends on the "Tegra SDHCI enable 1.8 V signaling on
> > Tegar210 and Tegra186" series posted earlier.  
> 
> According to the cover letter of the above series, it states that it
> depends on $subject series. A circular dependency. :-)

The dependency chain goes like this: "Tegra SDHCI update the pad
autocal procedure" -> "Tegra SDHCI enable 1.8 V signaling on Tegar210
and Tegra186" -> "Tegra PMC pinctrl pad configuration".

> In fact, there should be no dependency at all or else there seems to
> be a DT compatibility problem here...

From a functionality perspective there's no strict dependency, however,
I don't think "[PATCH v2 09/10] mmc: tegra: Perform pad calibration
after voltage switch" can be applied cleanly without
"[PATCH v2 03/10] mmc: tegra: Reconfigure pad voltages during voltage
switching" from the "Tegra SDHCI enable 1.8 V signaling on Tegar210 and
Tegra186" series.

> Anyway, I think it actually makes sense to fold in all changes into
> one series. Make sure the dt-doc changes comes first, then the driver
> changes and finally arm64/dts changes. This should make it easy to
> follow the review and I can pick the mmc parts and the soc maintainer
> can pick the arm64/dts changes.

I've sent the changes in multiple part because I've been working on
further changes to the driver while the previous parts have been
getting reviewed. This is still the case and there's still going to be
at least one more series which adds support for HS200 tuning and some
smaller changes after it. However, the HS200 work is probably going to
be ready for review in a day or two. I can send these as a one series
from now on, although at this point it would be 27 patches in total
and even more with the HS200 patches.

I can do that if you prefer to do it that way. Makes my life somewhat
easier too.

 -Aapo
