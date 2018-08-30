Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA20FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748092082B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748092082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeH3MrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:47:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37834 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727238AbeH3MrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:47:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E62747A9;
        Thu, 30 Aug 2018 01:46:20 -0700 (PDT)
Received: from localhost (e105922-lin.Emea.Arm.com [10.4.13.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8137C3F5BD;
        Thu, 30 Aug 2018 01:46:20 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, edubezval@gmail.com,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] dt-binding: arm/cpus.txt: fix dynamic-power-coefficient unit
References: <1535526518-29022-1-git-send-email-vincent.guittot@linaro.org>
Date:   Thu, 30 Aug 2018 09:46:18 +0100
In-Reply-To: <1535526518-29022-1-git-send-email-vincent.guittot@linaro.org>
        (Vincent Guittot's message of "Wed, 29 Aug 2018 09:08:38 +0200")
Message-ID: <87y3co8co5.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

Vincent Guittot <vincent.guittot@linaro.org> writes:

> The unit of dynamic-power-coefficient is described as mW/MHz/uV^2 whereas
> its usage in the code assumes that unit is uW/MHz/V^2
>
> In drivers/thermal/cpu_cooling.c, the code is :
>
> power = (u64)capacitance * freq_mhz * voltage_mv * voltage_mv;
> do_div(power, 1000000000);
>
> which can be summarized as :
> power (mW) = capacitance * freq_mhz/1000 * (voltage_mv/1000)^2
> or
> power (mW) = (capacitance * freq_mhz * (voltage_mv/1000)^2) / 1000
> then
> power (mW) = power (uW) / 1000
> so
> power (uW) = capacitance * freq_mhz * (voltage_mv/1000)^2
>
> Furthermore, if we test basic values like :
> voltage_mv = 1000mV = 1V
> freq_mhz = 1000Mhz
>
> The minimum possible power, when dynamic-power-coefficient equals 1, will
> be with current unit:
> min power = 1 * 1000  * (1000000)^2 = 10^15 mW
> which is not realistic
>
> With the unit used by the code, the min power is
> min power =  1 * 1000 * 1^2 = 1000uW = 1mW which is far more realistic
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Punit Agrawal <punit.agrawal@arm.com>

Thanks for fixing the mismatch.

> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index 29e1dc5..71d8cd0 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -274,7 +274,7 @@ described below.
>  		Usage: optional
>  		Value type: <prop-encoded-array>
>  		Definition: A u32 value that represents the running time dynamic
> -			    power coefficient in units of mW/MHz/uV^2. The
> +			    power coefficient in units of uW/MHz/V^2. The
>  			    coefficient can either be calculated from power
>  			    measurements or derived by analysis.
>  
> @@ -285,7 +285,7 @@ described below.
>  
>  			    Pdyn = dynamic-power-coefficient * V^2 * f
>  
> -			    where voltage is in uV, frequency is in MHz.
> +			    where voltage is in V, frequency is in MHz.
>  
>  Example 1 (dual-cluster big.LITTLE system 32-bit):
