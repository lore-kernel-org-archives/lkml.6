Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752739AbeEOVUv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:20:51 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:55918 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752483AbeEOVUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:20:49 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Tue, 15 May 2018 23:20:46 +0200
From: Stefan Agner <stefan@agner.ch>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Lucas Stach <dev@lynxeye.de>
Subject: Re: [PATCH v4 3/3] ARM: dts: tegra: Work safely with 256 MB
 Colibri-T20 modules
In-Reply-To: <1526395285-19006-4-git-send-email-krzk@kernel.org>
References: <1526395285-19006-1-git-send-email-krzk@kernel.org>
 <1526395285-19006-4-git-send-email-krzk@kernel.org>
Message-ID: <fce1d8c51fc3fd74fe61933fe9b59654@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[10];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.05.2018 16:41, Krzysztof Kozlowski wrote:
> Colibri-T20 can come in 256 MB RAM (with 512 MB NAND) or 512 MB RAM
> (with 1024 MB NAND) flavors.  Both of them will use the same DTSI
> expecting the bootloader to do the fixup of /memory node.  However in
> case it does not happen, let's stay on safe side by limiting the memory
> to 256 MB for both versions of Colibri-T20.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> RFT:
> Not tested on 512 MB module as I have only the 256 MB one.
> 
> Changes since v3:
> 1. Reduce the memory in existing DTSI instead of creating a new one
>    (suggested by Marcel).
> 
> Changes since v2:
> 1. Do not add new compatible but use everywhere existing
>    "toradex,colibri_t20-512" (suggested by Rob).
> 
> Changes since v1:
> 1. Fix memory size in tegra20-colibri-256.dtsi (was working fine because
>    my bootloader uses mem= argument).
> ---
>  arch/arm/boot/dts/tegra20-colibri-512.dtsi | 9 +++++++--
>  arch/arm/boot/dts/tegra20-iris-512.dts     | 2 +-

I don't like this variant too much.

Can we not just drop the 512? And while at it, I would prefer to see the
usual $soc-$module-$carrier schema, as we use with all the other modules
of the Colibri and Apalis family.

e.g.
tegra20-colibri-512.dtsi -> tegra20-colibri.dtsi
tegra20-iris-512.dts -> tegra20-colibri-iris.dts

Yes, it is somewhat churn, but I would prefer it for the sake of clarity
and consistency...

--
Stefan


>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
> b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
> index 305efb275b48..b9387c540450 100644
> --- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
> +++ b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
> @@ -2,7 +2,7 @@
>  #include "tegra20.dtsi"
>  
>  / {
> -	model = "Toradex Colibri T20 512MB";
> +	model = "Toradex Colibri T20 256/512 MB";
>  	compatible = "toradex,colibri_t20-512", "nvidia,tegra20";
>  
>  	aliases {
> @@ -12,7 +12,12 @@
>  
>  	memory@0 {
>  		device_type = "memory";
> -		reg = <0x00000000 0x20000000>;
> +		/*
> +		 * Set memory to 256 MB to be safe as this could be used on
> +		 * 256 or 512 MB module. It is expected from bootloader
> +		 * to fix this up for 512 MB version.
> +		 */
> +		reg = <0x00000000 0x10000000>;
>  	};
>  
>  	host1x@50000000 {
> diff --git a/arch/arm/boot/dts/tegra20-iris-512.dts
> b/arch/arm/boot/dts/tegra20-iris-512.dts
> index 40126388946d..efaa96228722 100644
> --- a/arch/arm/boot/dts/tegra20-iris-512.dts
> +++ b/arch/arm/boot/dts/tegra20-iris-512.dts
> @@ -4,7 +4,7 @@
>  #include "tegra20-colibri-512.dtsi"
>  
>  / {
> -	model = "Toradex Colibri T20 512MB on Iris";
> +	model = "Toradex Colibri T20 256/512 MB on Iris";
>  	compatible = "toradex,iris", "toradex,colibri_t20-512", "nvidia,tegra20";
>  
>  	aliases {
