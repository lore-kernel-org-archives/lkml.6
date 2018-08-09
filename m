Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221A7C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D3821BC9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D3821BC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbeHIPJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:09:06 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15795 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbeHIPJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:09:06 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b6c37180000>; Thu, 09 Aug 2018 05:44:08 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 09 Aug 2018 05:44:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 09 Aug 2018 05:44:16 -0700
Received: from dhcp-10-21-25-168 (10.21.25.201) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 9 Aug
 2018 12:44:18 +0000
Date:   Thu, 9 Aug 2018 15:44:12 +0300
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Mikko Perttunen" <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 10/40] soc/tegra: pmc: Implement pad configuration via
 pinctrl
Message-ID: <20180809154412.4e7fe9b3@dhcp-10-21-25-168>
In-Reply-To: <20180809122706.GT21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
        <1533141150-10511-11-git-send-email-avienamo@nvidia.com>
        <20180809122706.GT21639@ulmo>
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

On Thu, 9 Aug 2018 14:27:06 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Wed, Aug 01, 2018 at 07:32:00PM +0300, Aapo Vienamo wrote:
> > Register a pinctrl device and implement get and set functions for
> > PIN_CONFIG_LOW_POWER_MODE and PIN_CONFIG_POWER_SOURCE parameters.
> > 
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > Acked-by: Jon Hunter <jonathanh@nvidia.com>
> > ---
> >  drivers/soc/tegra/pmc.c | 187 +++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 185 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c  
> [...]
> > @@ -1704,6 +1863,12 @@ static const u8 tegra124_cpu_powergates[] = {
> >  		.name	= (_name),			\
> >  	})
> >  
> > +#define TEGRA_IO_PIN_DESC(_id, _dpd, _voltage, _name)	\
> > +	((struct pinctrl_pin_desc) {			\
> > +		.number = (_id),			\
> > +		.name	= (_name)			\
> > +	})
> > +  
> 
> Do we really need the explicit cast to struct pinctrl_pin_desc here?
> 

No, but I prefer to have it as it makes the type of the value the macro
expands to explicit. In a way it hints at how and where the macro should
be used and arguably improves readability.

 -Aapo
