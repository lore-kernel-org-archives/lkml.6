Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07291C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECD12098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJlxS+Id"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECD12098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbeIYVzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:55:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43694 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729438AbeIYVzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:55:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id q19-v6so10986892pgn.10;
        Tue, 25 Sep 2018 08:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DazXR1Y+IANIXdg1k4I6OUDyeRgvWTafVUJGpdKnTdM=;
        b=EJlxS+IdNdFSyISBPCyxnHHxJh1E++W+NARnk61kKWoeLkc1CXT4CJrupYQr6Mttok
         jnxdgL7Bb2CF6XT+sftEXeGBNudSGYdUFodxzQhWmLHrdD/xFAPuSUm9fBTzEg89hWBl
         OIqcm31CmU3K4icWuwwpk0GBbHUOdOjlp5s1m4Xv/nV3fQ/AjI4qZ8my/gze/B7n50ED
         1pGJoyRg9vdQBaRX9SNzvV0vf2S0OH4O+e4PSydWgLkjOVGlSg9jFJw01oBfd02QsRc0
         KX8uVBczVExa99U5HWXf1dQo14B66IyJ5O6FY2te7ZPYfjYXqUq7YcD+LbMEY9kJ0+LL
         NBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DazXR1Y+IANIXdg1k4I6OUDyeRgvWTafVUJGpdKnTdM=;
        b=CHltVZXNvAPMxT9FJ8jH63NadgkCmvYUyS8fY7btoNn/CkAaK5XA8iORV4rKGVhxGT
         B+tf6VuGVx/3fdI+xOO2DhV3UJ28GBMCwlupXWGR2h9W/2NZCMi3LQgLIbm4QGERklTh
         U9MK6oHPFD0CQHSw4HmKdmAlMNyc67q0bGzXF79LgdtznyTW2KkLZDB03TZOleAuskhJ
         fdHNNRNlc9cI3TzBeoPcvcqNgeSjkYorxf5OuxxWoFTwqTNQGOAQhZr6EMzv6D2n42Yi
         16wwKuyoOfr+nWZJG9Eg5d5XRZdzyUiKBcDx+imtAsRGTmUQtYkIe7E5lDGIYWRSqjhi
         L7UA==
X-Gm-Message-State: ABuFfoj7HREEMGgzkF3Avs9eWMe1d8Q8Nsqe4SmP9N5SMxZwtPd86xno
        TX1mGOxAkeugWUqJJm2GPUvbXok4
X-Google-Smtp-Source: ACcGV62q+hIi3MswNjMOwO6mAiOGQCoPwbuf8qi2daELu0kjrS1tQFCFWZbQZB4GaZmJca0QYc30BA==
X-Received: by 2002:a17:902:7b96:: with SMTP id w22-v6mr1841479pll.24.1537890434177;
        Tue, 25 Sep 2018 08:47:14 -0700 (PDT)
Received: from ziggy.stardust ([37.223.146.97])
        by smtp.gmail.com with ESMTPSA id w2-v6sm3208097pgb.61.2018.09.25.08.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 08:47:13 -0700 (PDT)
Subject: Re: [PATCH 3/5] arm: dts: mt7623: add iommu/smi device nodes
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        Weijie Gao <weijie.gao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <84011aa94dd7be9239b7a2f944dd30fc70568fbb.1536141302.git.ryder.lee@mediatek.com>
 <2d9d216adb779bac6f5515b39cfeaed8b4b61878.1536141302.git.ryder.lee@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 xsFNBFP1zgUBEAC21D6hk7//0kOmsUrE3eZ55kjc9DmFPKIz6l4NggqwQjBNRHIMh04BbCMY
 fL3eT7ZsYV5nur7zctmJ+vbszoOASXUpfq8M+S5hU2w7sBaVk5rpH9yW8CUWz2+ZpQXPJcFa
 OhLZuSKB1F5JcvLbETRjNzNU7B3TdS2+zkgQQdEyt7Ij2HXGLJ2w+yG2GuR9/iyCJRf10Okq
 gTh//XESJZ8S6KlOWbLXRE+yfkKDXQx2Jr1XuVvM3zPqH5FMg8reRVFsQ+vI0b+OlyekT/Xe
 0Hwvqkev95GG6x7yseJwI+2ydDH6M5O7fPKFW5mzAdDE2g/K9B4e2tYK6/rA7Fq4cqiAw1+u
 EgO44+eFgv082xtBez5WNkGn18vtw0LW3ESmKh19u6kEGoi0WZwslCNaGFrS4M7OH+aOJeqK
 fx5dIv2CEbxc6xnHY7dwkcHikTA4QdbdFeUSuj4YhIZ+0QlDVtS1QEXyvZbZky7ur9rHkZvP
 ZqlUsLJ2nOqsmahMTIQ8Mgx9SLEShWqD4kOF4zNfPJsgEMB49KbS2o9jxbGB+JKupjNddfxZ
 HlH1KF8QwCMZEYaTNogrVazuEJzx6JdRpR3sFda/0x5qjTadwIW6Cl9tkqe2h391dOGX1eOA
 1ntn9O/39KqSrWNGvm+1raHK+Ev1yPtn0Wxn+0oy1tl67TxUjQARAQABzSlNYXR0aGlhcyBC
 cnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPsLBkgQTAQIAPAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AWIQTmuZIYwPLDJRwsOhfZFAuyVhMC8QUCWt3scQIZAQAKCRDZFAuy
 VhMC8WzRD/4onkC+gCxG+dvui5SXCJ7bGLCu0xVtiGC673Kz5Aq3heITsERHBV0BqqctOEBy
 ZozQQe2Hindu9lasOmwfH8+vfTK+2teCgWesoE3g3XKbrOCB4RSrQmXGC3JYx6rcvMlLV/Ch
 YMRR3qv04BOchnjkGtvm9aZWH52/6XfChyh7XYndTe5F2bqeTjt+kF/ql+xMc4E6pniqIfkv
 c0wsH4CkBHqoZl9w5e/b9MspTqsU9NszTEOFhy7p2CYw6JEa/vmzR6YDzGs8AihieIXDOfpT
 DUr0YUlDrwDSrlm/2MjNIPTmSGHH94ScOqu/XmGW/0q1iar/Yr0leomUOeeEzCqQtunqShtE
 4Mn2uEixFL+9jiVtMjujr6mphznwpEqObPCZ3IcWqOFEz77rSL+oqFiEA03A2WBDlMm++Sve
 9jpkJBLosJRhAYmQ6ey6MFO6Krylw1LXcq5z1XQQavtFRgZoruHZ3XlhT5wcfLJtAqrtfCe0
 aQ0kJW+4zj9/So0uxJDAtGuOpDYnmK26dgFN0tAhVuNInEVhtErtLJHeJzFKJzNyQ4GlCaLw
 jKcwWcqDJcrx9R7LsCu4l2XpKiyxY6fO4O8DnSleVll9NPfAZFZvf8AIy3EQ8BokUsiuUYHz
 wUo6pclk55PZRaAsHDX/fNr24uC6Eh5oNQ+v4Pax/gtyyc7BTQRT9gkSARAApxtQ4zUMC512
 kZ+gCiySFcIF/mAf7+l45689Tn7LI1xmPQrAYJDoqQVXcyh3utgtvBvDLmpQ+1BfEONDWc8K
 RP6Abo35YqBx3udAkLZgr/RmEg3+Tiof+e1PJ2zRh5zmdei5MT8biE2zVd9DYSJHZ8ltEWIA
 LC9lAsv9oa+2L6naC+KFF3i0m5mxklgFoSthswUnonqvclsjYaiVPoSldDrreCPzmRCUd8zn
 f//Z4BxtlTw3SulF8weKLJ+Hlpw8lwb3sUl6yPS6pL6UV45gyWMe677bVUtxLYOu+kiv2B/+
 nrNRDs7B35y/J4t8dtK0S3M/7xtinPiYRmsnJdk+sdAe8TgGkEaooF57k1aczcJlUTBQvlYA
 Eg2NJnqaKg3SCJ4fEuT8rLjzuZmLkoHNumhH/mEbyKca82HvANu5C9clyQusJdU+MNRQLRmO
 Ad/wxGLJ0xmAye7Ozja86AIzbEmuNhNH9xNjwbwSJNZefV2SoZUv0+V9EfEVxTzraBNUZifq
 v6hernMQXGxs+lBjnyl624U8nnQWnA8PwJ2hI3DeQou1HypLFPeY9DfWv4xYdkyeOtGpueeB
 lqhtMoZ0kDw2C3vzj77nWwBgpgn1Vpf4hG/sW/CRR6tuIQWWTvUM3ACa1pgEsBvIEBiVvPxy
 AtL+L+Lh1Sni7w3HBk1EJvUAEQEAAcLBXwQYAQIACQUCU/YJEgIbDAAKCRDZFAuyVhMC8Qnd
 EACuN16mvivnWwLDdypvco5PF8w9yrfZDKW4ggf9TFVB9skzMNCuQc+tc+QM+ni2c4kKIdz2
 jmcg6QytgqVum6V1OsNmpjADaQkVp5jL0tmg6/KA9Tvr07Kuv+Uo4tSrS/4djDjJnXHEp/tB
 +Fw7CArNtUtLlc8SuADCmMD+kBOVWktZyzkBkDfBXlTWl46T/8291lEspDWe5YW1ZAH/HdCR
 1rQNZWjNCpB2Cic58CYMD1rSonCnbfUeyZYNNhNHZosl4dl7f+am87Q2x3pK0DLSoJRxWb7v
 ZB0uo9CzCSm3I++aYozF25xQoT+7zCx2cQi33jwvnJAK1o4VlNx36RfrxzBqc1uZGzJBCQu4
 8UjmUSsTwWC3HpE/D9sM+xACs803lFUIZC5H62G059cCPAXKgsFpNMKmBAWweBkVJAisoQeX
 50OP+/11ArV0cv+fOTfJj0/KwFXJaaYh3LUQNILLBNxkSrhCLl8dUg53IbHx4NfIAgqxLWGf
 XM8DY1aFdU79pac005PuhxCWkKTJz3gCmznnoat4GCnL5gy/m0Qk45l4PFqwWXVLo9AQg2Kp
 3mlIFZ6fsEKIAN5hxlbNvNb9V2Zo5bFZjPWPFTxOteM0omUAS+QopwU0yPLLGJVf2iCmItHc
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <de407ddd-d423-288b-02d1-5b75381b6417@gmail.com>
Date:   Tue, 25 Sep 2018 17:47:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <2d9d216adb779bac6f5515b39cfeaed8b4b61878.1536141302.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/09/2018 12:22, Ryder Lee wrote:
> Add iommu/smi device nodes for MT7623.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Applied to v4.19-next/dts32

> ---
>  arch/arm/boot/dts/mt7623.dtsi | 59 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index b7ccf8b..a46987b 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -13,6 +13,7 @@
>  #include <dt-bindings/power/mt2701-power.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/memory/mt2701-larb-port.h>
>  #include <dt-bindings/reset/mt2701-resets.h>
>  #include <dt-bindings/thermal/thermal.h>
>  
> @@ -286,6 +287,17 @@
>  		clock-names = "system-clk", "rtc-clk";
>  	};
>  
> +	smi_common: smi@1000c000 {
> +		compatible = "mediatek,mt7623-smi-common",
> +			     "mediatek,mt2701-smi-common";
> +		reg = <0 0x1000c000 0 0x1000>;
> +		clocks = <&infracfg CLK_INFRA_SMI>,
> +			 <&mmsys CLK_MM_SMI_COMMON>,
> +			 <&infracfg CLK_INFRA_SMI>;
> +		clock-names = "apb", "smi", "async";
> +		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
> +	};
> +
>  	pwrap: pwrap@1000d000 {
>  		compatible = "mediatek,mt7623-pwrap",
>  			     "mediatek,mt2701-pwrap";
> @@ -317,6 +329,17 @@
>  		reg = <0 0x10200100 0 0x1c>;
>  	};
>  
> +	iommu: mmsys_iommu@10205000 {
> +		compatible = "mediatek,mt7623-m4u",
> +			     "mediatek,mt2701-m4u";
> +		reg = <0 0x10205000 0 0x1000>;
> +		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&infracfg CLK_INFRA_M4U>;
> +		clock-names = "bclk";
> +		mediatek,larbs = <&larb0 &larb1 &larb2>;
> +		#iommu-cells = <1>;
> +	};
> +
>  	efuse: efuse@10206000 {
>  		compatible = "mediatek,mt7623-efuse",
>  			     "mediatek,mt8173-efuse";
> @@ -709,6 +732,18 @@
>  		#clock-cells = <1>;
>  	};
>  
> +	larb0: larb@14010000 {
> +		compatible = "mediatek,mt7623-smi-larb",
> +			     "mediatek,mt2701-smi-larb";
> +		reg = <0 0x14010000 0 0x1000>;
> +		mediatek,smi = <&smi_common>;
> +		mediatek,larb-id = <0>;
> +		clocks = <&mmsys CLK_MM_SMI_LARB0>,
> +			 <&mmsys CLK_MM_SMI_LARB0>;
> +		clock-names = "apb", "smi";
> +		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
> +	};
> +
>  	imgsys: syscon@15000000 {
>  		compatible = "mediatek,mt7623-imgsys",
>  			     "mediatek,mt2701-imgsys",
> @@ -717,6 +752,18 @@
>  		#clock-cells = <1>;
>  	};
>  
> +	larb2: larb@15001000 {
> +		compatible = "mediatek,mt7623-smi-larb",
> +			     "mediatek,mt2701-smi-larb";
> +		reg = <0 0x15001000 0 0x1000>;
> +		mediatek,smi = <&smi_common>;
> +		mediatek,larb-id = <2>;
> +		clocks = <&imgsys CLK_IMG_SMI_COMM>,
> +			 <&imgsys CLK_IMG_SMI_COMM>;
> +		clock-names = "apb", "smi";
> +		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
> +	};
> +
>  	vdecsys: syscon@16000000 {
>  		compatible = "mediatek,mt7623-vdecsys",
>  			     "mediatek,mt2701-vdecsys",
> @@ -725,6 +772,18 @@
>  		#clock-cells = <1>;
>  	};
>  
> +	larb1: larb@16010000 {
> +		compatible = "mediatek,mt7623-smi-larb",
> +			     "mediatek,mt2701-smi-larb";
> +		reg = <0 0x16010000 0 0x1000>;
> +		mediatek,smi = <&smi_common>;
> +		mediatek,larb-id = <1>;
> +		clocks = <&vdecsys CLK_VDEC_CKGEN>,
> +			 <&vdecsys CLK_VDEC_LARB>;
> +		clock-names = "apb", "smi";
> +		power-domains = <&scpsys MT2701_POWER_DOMAIN_VDEC>;
> +	};
> +
>  	hifsys: syscon@1a000000 {
>  		compatible = "mediatek,mt7623-hifsys",
>  			     "mediatek,mt2701-hifsys",
> 
