Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA57ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A3E2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A3E2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbeISTTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:19:52 -0400
Received: from foss.arm.com ([217.140.101.70]:59842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731430AbeISTTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:19:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D0CA80D;
        Wed, 19 Sep 2018 06:41:52 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF70B3F703;
        Wed, 19 Sep 2018 06:41:50 -0700 (PDT)
Subject: Re: [PATCH 18/21] arm64: dts: ls104xa: set mask to drop TBU ID from
 StreamID
To:     laurentiu.tudor@nxp.com, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     madalin.bucur@nxp.com, roy.pledge@nxp.com, leoyang.li@nxp.com,
        shawnguo@kernel.org, davem@davemloft.net
References: <20180919123613.15092-1-laurentiu.tudor@nxp.com>
 <20180919123613.15092-19-laurentiu.tudor@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <fe2af486-3d7d-a38f-ef62-6754f809298f@arm.com>
Date:   Wed, 19 Sep 2018 14:41:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919123613.15092-19-laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/18 13:36, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> The StreamID entering the SMMU is actually a concatenation of the
> SMMU TBU ID and the ICID configured in software.
> Since the TBU ID is internal to the SoC and since we want that the
> actual the ICID configured in software to enter the SMMU witout any
> additional set bits, mask out the TBU ID bits and leave only the
> relevant ICID bits to enter SMMU.
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>   arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
>   arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index 8b3eba167508..90296b9fb171 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -226,6 +226,7 @@
>   			compatible = "arm,mmu-500";
>   			reg = <0 0x9000000 0 0x400000>;
>   			dma-coherent;
> +			stream-match-mask = <0x7f00>;

The TBU ID only forms the top 5 bits, so also ignoring bits 9:8 raises 
an eyebrow - if the LS104x SMMU really is configured for 8-bit SID input 
then it's harmless, but if it's actually a 9 or 10-bit configuration 
then you probably want to avoid masking them (or at least document why) 
- IIRC there *was* stuff wired there on LS2085 at least.

Robin.

>   			#global-interrupts = <2>;
>   			#iommu-cells = <1>;
>   			interrupts = <0 142 4>, /* global secure fault */
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index 06863d3e4a7d..15094dd8400e 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -232,6 +232,7 @@
>   			compatible = "arm,mmu-500";
>   			reg = <0 0x9000000 0 0x400000>;
>   			dma-coherent;
> +			stream-match-mask = <0x7f00>;
>   			#global-interrupts = <2>;
>   			#iommu-cells = <1>;
>   			interrupts = <0 142 4>, /* global secure fault */
> 
