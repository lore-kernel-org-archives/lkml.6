Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AE9ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5396520C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="M1e/HulU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5396520C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeIXOJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 10:09:01 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4287 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbeIXOJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 10:09:01 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ba89b520000>; Mon, 24 Sep 2018 01:07:46 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 24 Sep 2018 01:08:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 24 Sep 2018 01:08:09 -0700
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 24 Sep
 2018 08:08:09 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1002)
        id 8EBFEF8076D; Mon, 24 Sep 2018 11:08:03 +0300 (EEST)
Date:   Mon, 24 Sep 2018 11:08:03 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     ryang <decatf@gmail.com>
CC:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: tegra: Return the exact clock rate from
 clk_round_rate
Message-ID: <20180924080803.GF7636@tbergstrom-lnx.Nvidia.com>
References: <20180921220149.17136-1-decatf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180921220149.17136-1-decatf@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1537776466; bh=Zsg2wOD81o6UeTs6JodahP3dvNM/mHBaVxxM8dSftac=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=M1e/HulU8zD52wBzJ0hImlRCFBWVKno1erNAOwHo1bF0IGqJuEih3EMuSjPBkj/EY
         qc2gL54oEwGHyyH2G8S1uQzPHc1jEpkhX/SvtJcrNoziKyI3duh0O68HH/PTntCC7A
         HhFWEAuF/F8XMuVPzUotLUFmqQBCgYsUABHlnowGoRbyJvkYwLy/c7eFlLe2N37FJH
         esRgDxLhw/k/5qwgKi+YppaPlRizL/qkiuhfXhlQ8KxKSk/SVl4v6Fl5u0Ls079B+7
         ky6eQo+Pc551mW0UaX/GyQMEx3REVpJJ9RIIDRkXa52omiDeukj+bkWEMCttSIPQrS
         gOVpxP+WtQ4ew==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 06:01:49PM -0400, ryang wrote:
> The current behavior is that clk_round_rate would return the same clock
> rate passed to it for valid PLL configurations. This change will return
> the exact rate the PLL will provide in accordance with clk API.
> 
> Signed-off-by: ryang <decatf@gmail.com>
> ---
>  drivers/clk/tegra/clk-pll.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
> index 17a058c3bbc1..36014a6ec42e 100644
> --- a/drivers/clk/tegra/clk-pll.c
> +++ b/drivers/clk/tegra/clk-pll.c
> @@ -595,7 +595,12 @@ static int _calc_rate(struct clk_hw *hw, struct tegra_clk_pll_freq_table *cfg,
>  		return -EINVAL;
>  	}
>  
> -	cfg->output_rate >>= p_div;
> +	if (cfg->m == 0) {
> +		cfg->output_rate = 0;

I think a WARN_ON() is appropriate here. the input divider should never be 0.

Peter.

> +	} else {
> +		cfg->output_rate = cfg->n * DIV_ROUND_UP(parent_rate, cfg->m);
> +		cfg->output_rate >>= p_div;
> +	}
>  
>  	if (pll->params->pdiv_tohw) {
>  		ret = _p_div_to_hw(hw, 1 << p_div);
> -- 
> 2.17.1
> 
