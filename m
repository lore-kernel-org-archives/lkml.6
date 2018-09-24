Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BFFC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C333220C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YyqV+INi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C333220C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeIXOH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 10:07:29 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15778 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbeIXOH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 10:07:29 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ba89b0f0000>; Mon, 24 Sep 2018 01:06:39 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Sep 2018 01:06:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Sep 2018 01:06:37 -0700
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 24 Sep
 2018 08:06:37 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1002)
        id 861C8F8076D; Mon, 24 Sep 2018 11:06:31 +0300 (EEST)
Date:   Mon, 24 Sep 2018 11:06:31 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     ryang <decatf@gmail.com>
CC:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: tegra: Fix an infinite loop when clock rate is zero
Message-ID: <20180924080631.GE7636@tbergstrom-lnx.Nvidia.com>
References: <20180921220037.16862-1-decatf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180921220037.16862-1-decatf@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1537776400; bh=JBa6cNfMJOdqf+mnmUeztcbQDvOdMgoxkEdEFDmNxF4=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=YyqV+INiayn3aOno02S6LXOW0sWnGUsctCcFMYlklVjtBFxSMR0GCr9JuopbPzTAL
         FnRxi1DHkiSG8TaFE2ls15v8e96ckVMBZgL/A6o3lT5+FIpRrJYGMTaSZAwoiUI+Sk
         +Q4BEhhoVq81vNJ1revzE91frty/RWAuDisl/fvtTQYB31BwaT42IbyaYPW9GkhiTr
         KYNw6o8yx9Hqk2Fcb/x/bUtQon/fKfYKhyITvZv22DmLLDpl2gKCPwhm0iIMzPzl08
         7xsfGFq2vTXJxvgEnpgqJe2JovzCcPRnzHEf+gjnN6Rtt15gn/j3OCwHDxDq2zjF9C
         K19Eu7NB7k6qA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 06:00:37PM -0400, ryang wrote:
> Calling clk_set_rate or clk_round_rate will lock up the kernel when the
> rate is zero. This avoids the infinite loop and uses a slightly more
> optimized p divider calculation.
> 

Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>

At some point we should also limit pdiv to its maximum possible value, but
that's not so obvious as we need to take into account PLLs where pdiv is
non-linear.

Peter.

> Signed-off-by: ryang <decatf@gmail.com>
> ---
>  drivers/clk/tegra/clk-pll.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
> index 830d1c87fa7c..17a058c3bbc1 100644
> --- a/drivers/clk/tegra/clk-pll.c
> +++ b/drivers/clk/tegra/clk-pll.c
> @@ -582,9 +582,8 @@ static int _calc_rate(struct clk_hw *hw, struct tegra_clk_pll_freq_table *cfg,
>  	}
>  
>  	/* Raise VCO to guarantee 0.5% accuracy */
> -	for (cfg->output_rate = rate; cfg->output_rate < 200 * cfreq;
> -	     cfg->output_rate <<= 1)
> -		p_div++;
> +	p_div = rate ? fls((200 * cfreq) / rate) : 0;
> +	cfg->output_rate = rate << p_div;
>  
>  	cfg->m = parent_rate / cfreq;
>  	cfg->n = cfg->output_rate / cfreq;
> -- 
> 2.17.1
> 
