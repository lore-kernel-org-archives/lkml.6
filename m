Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B7BC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9702620873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9702620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbeGJHA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 03:00:57 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7276 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbeGJHAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 03:00:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b44597a0000>; Tue, 10 Jul 2018 00:00:10 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 10 Jul 2018 00:00:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 10 Jul 2018 00:00:53 -0700
Received: from tbergstrom-lnx.Nvidia.com (172.20.13.39) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1347.2; Tue, 10 Jul 2018 07:00:52 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1002)
        id 7B80DF80439; Tue, 10 Jul 2018 10:00:49 +0300 (EEST)
Date:   Tue, 10 Jul 2018 10:00:49 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Aapo Vienamo <avienamo@nvidia.com>
CC:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v4 0/4] Multiplex sdmmc low jitter clock path
Message-ID: <20180710070049.GH27696@tbergstrom-lnx.Nvidia.com>
References: <1531154338-3998-1-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1531154338-3998-1-git-send-email-avienamo@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Series Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>

Peter.

On Mon, Jul 09, 2018 at 07:38:54PM +0300, Aapo Vienamo wrote:
> The SDMMC clocks have a Low Jitter (LJ) clock path which bypasses a
> divider to achieve better jitter performance with high speed signaling
> modes. The clock path with the divider is needed by some of the slower
> signaling modes. This series automatically multiplexes the LJ and
> non-LJ clock paths based on the requested frequency.
> 
> Changelog:
> v4:
> 	- Add a changelog
> 
> v3:
> 	- Use <asm/div64.h> include instead of <linux/kernel.h> for
> 	  do_div()
> 	- Use SPDX tags for new files
> 	- Make mux_lj_idx[] and mux_non_lj_idx[] const
> 	- Make tegra_clk_sdmmc_mux_ops static
> 	- Fix the includes for fence_udelay() in a separate patch
> 
> v2:
> 	- Fix the type compatibility error on do_div
> 
> Aapo Vienamo (1):
>   clk: tegra: Fix includes required by fence_udelay()
> 
> Peter De Schrijver (1):
>   clk: tegra: refactor 7.1 div calculation
> 
> Peter De-Schrijver (2):
>   clk: tegra: Add sdmmc mux divider clock
>   clk: tegra: make sdmmc2 and sdmmc4 as sdmmc clocks
> 
>  drivers/clk/tegra/Makefile           |   2 +
>  drivers/clk/tegra/clk-divider.c      |  30 +----
>  drivers/clk/tegra/clk-id.h           |   2 -
>  drivers/clk/tegra/clk-sdmmc-mux.c    | 250 +++++++++++++++++++++++++++++++++++
>  drivers/clk/tegra/clk-tegra-periph.c |  11 --
>  drivers/clk/tegra/clk-tegra210.c     |  14 +-
>  drivers/clk/tegra/clk.h              |  30 +++++
>  drivers/clk/tegra/div71.c            |  43 ++++++
>  8 files changed, 342 insertions(+), 40 deletions(-)
>  create mode 100644 drivers/clk/tegra/clk-sdmmc-mux.c
>  create mode 100644 drivers/clk/tegra/div71.c
> 
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
