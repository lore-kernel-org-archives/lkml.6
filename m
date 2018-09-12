Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65AEC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C4A20854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHUv+gGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C4A20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeILPVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:21:55 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52844 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeILPVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:21:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id y139-v6so1743076wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 03:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bsEoaNtogAkFxQnZ7BQnLOGtX8Jp0LJhcmAzVTGrtUM=;
        b=EHUv+gGhnIbSBI+xxv7RJjB77blplobkEeaRtlZVEvrd2QoSrJlLv4cIEI7yr52uR7
         JlWI+AnEa3EG8E7IG87wAQvPAKVKupLtdL2wSmNP2c9/SwqxkDVX9iy//gBRtEAvvZ7E
         eQ7RLip0cMVR5guL8cq++IAMAFCXU9iB9gg1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bsEoaNtogAkFxQnZ7BQnLOGtX8Jp0LJhcmAzVTGrtUM=;
        b=I7qsbrGs5cL75kBtPknOlD+Wu+yJnqBUdJTTIF/qVavQ2zr+G+knpRs/Zgttd7fGJ+
         6CmeqqZiK1LMwLv/wehInIfmP4/7AaoDiMuHFLyD/Q+7HGArRS4ESoG1msdoqDyY6ok0
         INdKNwjtRdFq7S6W9Bc5GZaXMcb0IPiAf8i+cY3pKFEiKk8nbXJv8h5ls1XTjGTS7Jq9
         ECxOJDINwZnfIECU9i5t+uuFTEtoKKFskCbbLREFP5smP0FVs+Uk3lGQs5oGwh3wvN7R
         sREQlTDWfMey0A8GG38NcUt6vVaAYq9fontmwPOj2EOxRwIwJYo4BDg56Fsq6mE5QsNi
         y4nQ==
X-Gm-Message-State: APzg51DXoW7G9fA+f9bV2/xF2z2rntUpwTJTARGfWKaN0QSt9rdVSxTQ
        spphMbvAx5hxdUt9sqXHwZUZ6w==
X-Google-Smtp-Source: ANB0Vda+IbXCZ+xfZe2M1JSPqdbDe872YaQYubU7Bme+T97V+PV5moWEwfmApF/iGNHnMATiHBLXXA==
X-Received: by 2002:a7b:c215:: with SMTP id x21-v6mr1147918wmi.72.1536747482057;
        Wed, 12 Sep 2018 03:18:02 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id x16-v6sm619798wro.84.2018.09.12.03.17.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 03:18:01 -0700 (PDT)
Date:   Wed, 12 Sep 2018 18:17:53 +0800
From:   leo.yan@linaro.org
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        arm@kernel.org, sudeep.holla@arm.com,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "Ivan T . Ivanov" <ivan.ivanov@linaro.org>
Subject: Re: [PATCH 04/11] dts: qcom: Update coresight bindings for hardware
 ports
Message-ID: <20180912101753.GB3353@leoy-ThinkPad-X240s>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
 <1536661032-30481-5-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536661032-30481-5-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Tue, Sep 11, 2018 at 11:17:05AM +0100, Suzuki K Poulose wrote:
> Switch to updated coresight bindings for hw ports
> 
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Ivan T. Ivanov <ivan.ivanov@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 98 ++++++++++++++++++++++-------------
>  1 file changed, 63 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 7b32b89..5bed52b 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -1099,10 +1099,11 @@
>  			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>  			clock-names = "apb_pclk", "atclk";
>  
> -			port {
> -				tpiu_in: endpoint {
> -					slave-mode;
> -					remote-endpoint = <&replicator_out1>;
> +			out-ports {

Here should be in-ports for tpiu node?

BTW, if upper comment is valid, this means the DT binding doc also
gives wrong example for tpiu node [1].

I tested this patch with upper changing to 'in-ports', etm with perf
mode can work well on DB410c board.

[...]

Thanks,
Leo Yan

[1] https://git.linaro.org/kernel/coresight.git/tree/Documentation/devicetree/bindings/arm/coresight.txt?h=next#n135
