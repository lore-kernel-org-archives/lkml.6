Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB388ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF6420874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF6420874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388139AbeGWJuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:50:22 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10956 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388031AbeGWJuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:50:22 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b5596be0000>; Mon, 23 Jul 2018 01:50:07 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 23 Jul 2018 01:50:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 23 Jul 2018 01:50:10 -0700
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 23 Jul
 2018 08:50:13 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1002)
        id 775C4F805D2; Mon, 23 Jul 2018 11:50:10 +0300 (EEST)
Date:   Mon, 23 Jul 2018 11:50:10 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
CC:     <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pgaikwad@nvidia.com>,
        <jonathanh@nvidia.co>, <thierry.reding@gmail.com>,
        <linux-kernel@lists.codethink.co.uk>
Subject: Re: [PATCH 2/8] clk: tegra: host1x has fractional divider
Message-ID: <20180723085010.GK1636@tbergstrom-lnx.Nvidia.com>
References: <20180720134532.13148-1-ben.dooks@codethink.co.uk>
 <20180720134532.13148-3-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180720134532.13148-3-ben.dooks@codethink.co.uk>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 02:45:26PM +0100, Ben Dooks wrote:
> The host1x clock according to both tegra2 and tegra3 manuals is
> an 8bit divider with lsb being fractional. This is running into
> an issue where the host1x is being set on a tegra20a system to
> 266.4MHz but ends up at 222MHz instead.
> 

The fact the hw has a fractional divider, does not mean we're allowed to use
it. Due to the non 50% duty cycle of fractional divided clocks, they are not
allowed for certain peripherals. Do you have information indicating this is
ok for the host1x clock?

Peter.


> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/clk/tegra/clk-tegra-periph.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/tegra/clk-tegra-periph.c b/drivers/clk/tegra/clk-tegra-periph.c
> index 2acba2986bc6..8fa1cecf18a0 100644
> --- a/drivers/clk/tegra/clk-tegra-periph.c
> +++ b/drivers/clk/tegra/clk-tegra-periph.c
> @@ -644,7 +644,7 @@ static struct tegra_periph_init_data periph_clks[] = {
>  	INT("vde", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_VDE, 61, 0, tegra_clk_vde),
>  	INT("vi", mux_pllm_pllc_pllp_plla, CLK_SOURCE_VI, 20, 0, tegra_clk_vi),
>  	INT("epp", mux_pllm_pllc_pllp_plla, CLK_SOURCE_EPP, 19, 0, tegra_clk_epp),
> -	INT("host1x", mux_pllm_pllc_pllp_plla, CLK_SOURCE_HOST1X, 28, 0, tegra_clk_host1x),
> +	MUX("host1x", mux_pllm_pllc_pllp_plla, CLK_SOURCE_HOST1X, 28, 0, tegra_clk_host1x),
>  	INT("mpe", mux_pllm_pllc_pllp_plla, CLK_SOURCE_MPE, 60, 0, tegra_clk_mpe),
>  	INT("2d", mux_pllm_pllc_pllp_plla, CLK_SOURCE_2D, 21, 0, tegra_clk_gr2d),
>  	INT("3d", mux_pllm_pllc_pllp_plla, CLK_SOURCE_3D, 24, 0, tegra_clk_gr3d),
> -- 
> 2.18.0
> 
