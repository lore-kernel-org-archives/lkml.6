Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F5BECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427C620874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427C620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388158AbeGWJu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:50:59 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10991 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388105AbeGWJu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:50:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b5596e30000>; Mon, 23 Jul 2018 01:50:43 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 23 Jul 2018 01:50:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 23 Jul 2018 01:50:50 -0700
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 23 Jul
 2018 08:50:50 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1002)
        id C97F9F805D2; Mon, 23 Jul 2018 11:50:46 +0300 (EEST)
Date:   Mon, 23 Jul 2018 11:50:46 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
CC:     <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pgaikwad@nvidia.com>,
        <jonathanh@nvidia.co>, <thierry.reding@gmail.com>,
        <linux-kernel@lists.codethink.co.uk>
Subject: Re: [PATCH 3/8] clk: tegra: fix fractional clocks for VDI, VI, EPP,
 MPE, 2D and 3D
Message-ID: <20180723085046.GL1636@tbergstrom-lnx.Nvidia.com>
References: <20180720134532.13148-1-ben.dooks@codethink.co.uk>
 <20180720134532.13148-4-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180720134532.13148-4-ben.dooks@codethink.co.uk>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 02:45:27PM +0100, Ben Dooks wrote:
> The clocks vde, vi, epp, mpe, 2d and 3d are all fractional
> divisors, and not integer divisors as setup in the current
> kernel. This seems to be the same for tegra2 and tegra3.
> 

Same comment as the host1x clock patch.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/clk/tegra/clk-tegra-periph.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-tegra-periph.c b/drivers/clk/tegra/clk-tegra-periph.c
> index 8fa1cecf18a0..ed70419f4ff9 100644
> --- a/drivers/clk/tegra/clk-tegra-periph.c
> +++ b/drivers/clk/tegra/clk-tegra-periph.c
> @@ -641,13 +641,13 @@ static struct tegra_periph_init_data periph_clks[] = {
>  	I2C("i2c4", mux_pllp_clkm, CLK_SOURCE_I2C4, 103, tegra_clk_i2c4),
>  	I2C("i2c5", mux_pllp_clkm, CLK_SOURCE_I2C5, 47, tegra_clk_i2c5),
>  	I2C("i2c6", mux_pllp_clkm, CLK_SOURCE_I2C6, 166, tegra_clk_i2c6),
> -	INT("vde", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_VDE, 61, 0, tegra_clk_vde),
> -	INT("vi", mux_pllm_pllc_pllp_plla, CLK_SOURCE_VI, 20, 0, tegra_clk_vi),
> -	INT("epp", mux_pllm_pllc_pllp_plla, CLK_SOURCE_EPP, 19, 0, tegra_clk_epp),
> +	MUX("vde", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_VDE, 61, 0, tegra_clk_vde),
> +	MUX("vi", mux_pllm_pllc_pllp_plla, CLK_SOURCE_VI, 20, 0, tegra_clk_vi),
> +	MUX("epp", mux_pllm_pllc_pllp_plla, CLK_SOURCE_EPP, 19, 0, tegra_clk_epp),
>  	MUX("host1x", mux_pllm_pllc_pllp_plla, CLK_SOURCE_HOST1X, 28, 0, tegra_clk_host1x),
> -	INT("mpe", mux_pllm_pllc_pllp_plla, CLK_SOURCE_MPE, 60, 0, tegra_clk_mpe),
> -	INT("2d", mux_pllm_pllc_pllp_plla, CLK_SOURCE_2D, 21, 0, tegra_clk_gr2d),
> -	INT("3d", mux_pllm_pllc_pllp_plla, CLK_SOURCE_3D, 24, 0, tegra_clk_gr3d),
> +	MUX("mpe", mux_pllm_pllc_pllp_plla, CLK_SOURCE_MPE, 60, 0, tegra_clk_mpe),
> +	MUX("2d", mux_pllm_pllc_pllp_plla, CLK_SOURCE_2D, 21, 0, tegra_clk_gr2d),
> +	MUX("3d", mux_pllm_pllc_pllp_plla, CLK_SOURCE_3D, 24, 0, tegra_clk_gr3d),
>  	INT8("vde", mux_pllp_pllc2_c_c3_pllm_clkm, CLK_SOURCE_VDE, 61, 0, tegra_clk_vde_8),
>  	INT8("vi", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_VI, 20, 0, tegra_clk_vi_8),
>  	INT8("vi", mux_pllm_pllc2_c_c3_pllp_plla_pllc4, CLK_SOURCE_VI, 20, 0, tegra_clk_vi_9),
> -- 
> 2.18.0
> 
