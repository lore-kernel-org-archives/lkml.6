Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07D0C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A781F20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A781F20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbeGZP7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:59:06 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:8229 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbeGZP7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:59:06 -0400
Received: from [192.168.90.67] (61.170.236.39) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 26 Jul
 2018 22:42:01 +0800
Subject: Re: [PATCH] arm64: dts: meson: Switch simple-mfd and syscon order
To:     Neil Armstrong <narmstrong@baylibre.com>, <khilman@baylibre.com>
References: <1532614438-7207-1-git-send-email-narmstrong@baylibre.com>
CC:     <yixun.lan@amlogic.com>, <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
From:   Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <494ff778-1888-7743-3a91-62364431d82e@amlogic.com>
Date:   Thu, 26 Jul 2018 22:41:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1532614438-7207-1-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [61.170.236.39]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Neil

On 07/26/2018 10:13 PM, Neil Armstrong wrote:
> The order between "syscon" and "simple-mfd" is important because in these
> particular cases, the node needs to be first a "simple-mfd" to expose
> it's sub-nodes, and later on a "syscon" to permit other nodes to access
> this register space through the "syscon" mechanism.
> 

could you explain a bit which specific case that it need compatible
"simple-mfd" come first? is this a problem in kernel side? because I see
you have a comment below about problem in U-Boot..


also while Rob review the mmc-clkc patch, he raise a suggestion to  drop
"syscon" in drivers/mfd/syscon.c, see [1], will that solve or affect
your problem?

[1]
https://lkml.kernel.org/r/CAL_Jsq+r+7BaJAPBn3L26sdxATVyDiuC=V3xE+yz0-27q0RJhA@mail.gmail.com

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> This also has a consequence for U-Boot since the U-Boot DM is much simpler
> and can only associate a single device to a node, thus here we want these
> nodes to be an mfd bus to be able to probe the sub-nodes.
> 
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 6adc8d3..3f0de9d 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -342,7 +342,7 @@
>  			ranges = <0x0 0x0 0x0 0xff63c000 0x0 0x1c00>;
>  
>  			sysctrl: system-controller@0 {
> -				compatible = "amlogic,meson-axg-hhi-sysctrl", "syscon", "simple-mfd";
> +				compatible = "amlogic,meson-axg-hhi-sysctrl", "simple-mfd", "syscon";
>  				reg = <0 0 0 0x400>;
>  
>  				clkc: clock-controller {
> @@ -1180,7 +1180,7 @@
>  			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
>  
>  			sysctrl_AO: sys-ctrl@0 {
> -				compatible = "amlogic,meson-axg-ao-sysctrl", "syscon", "simple-mfd";
> +				compatible = "amlogic,meson-axg-ao-sysctrl", "simple-mfd", "syscon";
>  				reg =  <0x0 0x0 0x0 0x100>;
>  
>  				clkc_AO: clock-controller {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index b8dc4db..d88699f 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -344,7 +344,7 @@
>  			ranges = <0x0 0x0 0x0 0xc8100000 0x0 0x100000>;
>  
>  			sysctrl_AO: sys-ctrl@0 {
> -				compatible = "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd";
> +				compatible = "amlogic,meson-gx-ao-sysctrl", "simple-mfd", "syscon";
>  				reg =  <0x0 0x0 0x0 0x100>;
>  
>  				pwrc_vpu: power-controller-vpu {
> @@ -431,7 +431,7 @@
>  			ranges = <0x0 0x0 0x0 0xc883c000 0x0 0x2000>;
>  
>  			sysctrl: system-controller@0 {
> -				compatible = "amlogic,meson-gx-hhi-sysctrl", "syscon", "simple-mfd";
> +				compatible = "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon";
>  				reg = <0 0 0 0x400>;
>  			};
>  
> 

