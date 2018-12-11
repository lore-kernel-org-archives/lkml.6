Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C41AC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C55920855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C55920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbeLKSjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:39:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:51498 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbeLKSjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:39:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 10:39:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="258646831"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by orsmga004.jf.intel.com with ESMTP; 11 Dec 2018 10:39:41 -0800
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Add KCS support for LPC BMC
To:     Vijay Khemka <vijaykhemka@fb.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
References: <20181210200753.3018124-1-vijaykhemka@fb.com>
 <20181210200753.3018124-3-vijaykhemka@fb.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <584ddf6f-2e0c-5c1c-df06-bdd37ecd2489@linux.intel.com>
Date:   Tue, 11 Dec 2018 10:39:40 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181210200753.3018124-3-vijaykhemka@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijay,

On 12/10/2018 12:07 PM, Vijay Khemka wrote:
> Added kcs device support for lpc BMC.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>   arch/arm/boot/dts/aspeed-g5.dtsi | 29 ++++++++++++++++++++++++++++-
>   1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index d107459fc0f8..1bd48655bacb 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -330,8 +330,35 @@
>   				ranges = <0x0 0x1e789000 0x1000>;
>   
>   				lpc_bmc: lpc-bmc@0 {
> -					compatible = "aspeed,ast2500-lpc-bmc";
> +					compatible = "aspeed,ast2500-lpc-bmc, "simple-mfd", "syscon"";
>   					reg = <0x0 0x80>;
> +					reg-io-width = <4>;
> +
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +					ranges = <0x0 0x0 0x80>;
> +
> +					kcs1: kcs1@0 {
> +						compatible = "aspeed,ast2500-kcs-bmc";
> +						reg = <0x0 0x80>;

This reg property isn't needed at here because kcs_bmc_aspeed module
reads regmap from the parent node. Please check below code in the
driver code.

priv->map = syscon_node_to_regmap(dev->parent->of_node);

> +						interrupts = <8>;
> +						kcs_chan = <1>;
> +						status = "disabled";
> +					};
> +					kcs2: kcs2@0 {
> +						compatible = "aspeed,ast2500-kcs-bmc";
> +						reg = <0x0 0x80>;

ditto.

> +						interrupts = <8>;
> +						kcs_chan = <2>;
> +						status = "disabled";
> +					};
> +					kcs3: kcs3@0 {
> +						compatible = "aspeed,ast2500-kcs-bmc";
> +						reg = <0x0 0x80>;

ditto.

> +						interrupts = <8>;
> +						kcs_chan = <3>;
> +						status = "disabled";
> +					};
>   				};
>   
>   				lpc_host: lpc-host@80 {
> 

You might need to add kcs4 as a sub-node under lpc_host like below:

kcs4: kcs4@0 {
	compatible = "aspeed,ast2500-kcs-bmc";
	interrupts = <8>;
	kcs_chan = <4>;
	status = "disabled";
};

This would be uses as an SMM channel.

-Jae
