Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C80BECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBBC21523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0CGTrOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBBC21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388362AbeIUAn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:43:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:47009 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387920AbeIUAnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:43:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id t20-v6so1335265ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 11:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7fD6Vg7mINt4+L+n806WJ/52MHN2Q3cbMiTXXilOWak=;
        b=D0CGTrOcw4zP1xQeYH05qDhT0fr1I+kdSIVs+wsSoQQRliHXT9pFqUq0/htvq9rE1m
         ut8u/K86NfdH/3DXEgBMGpGtvZQ/bZ8sMMC8n5psqP8zDkzmcpznHIvJjhSFgthwubv0
         cc1rP7UHuVR/br6+2AM6PnU+qI494NRXEVuc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7fD6Vg7mINt4+L+n806WJ/52MHN2Q3cbMiTXXilOWak=;
        b=Nuo5BTjFq2e/ieYb9mnOrZHPsXbCFJRscmBQAn2iR9fh/VvhA+0ZcS/lGnj7JZysCw
         VLW9pnFwJ5cR75D5P3l2vikB89oUZL4Mp3XheL8M3K81mZmVi1KMeTbK4acQCRVuxSX9
         IB4/xRtpWTAL4ZQHNTuo5SPbKoRrwxsMcw9BVmGIFDqtP9YIx2M5zw+pUnhJO67juK56
         Bq9FMm3wp7xJ6fZuOlyDH1eml64jItxXc5W+78GzQM3uu0M7L76nVXXcZcKPUEwEtjMy
         kdzm55O8mUDcapNhUt9WAzdktBD8jTxWQ0EtKoWo5Oe2ndCOYttLZFSdJXm5zguyXTje
         0/Tg==
X-Gm-Message-State: APzg51CiawEGEQDDTTdEGM+H6KAIZPTHQrBpVOoUi2fxMSDZOezL9qKY
        lHjs6FJKkTi24cHHdr3CZVSSPg==
X-Google-Smtp-Source: ANB0VdaqP+sF8dcw2ed/P1tUeh6YAFVDWyCwmiNRWK4RBnp88uXgIKVvqM3nsDzqzGiDk1La++7MQA==
X-Received: by 2002:a17:902:b68d:: with SMTP id c13-v6mr40530817pls.139.1537469941788;
        Thu, 20 Sep 2018 11:59:01 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id m15-v6sm75365520pfk.149.2018.09.20.11.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 11:59:00 -0700 (PDT)
Date:   Thu, 20 Sep 2018 11:59:00 -0700
From:   Andy Gross <andy.gross@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 14/16] arm64: dts: msm8916: Add gpu thermal zone
Message-ID: <20180920185900.GC19253@hector.localdomain>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
 <ffefc578b5cb9298e33f0ea480b3d521f34afd54.1536744310.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffefc578b5cb9298e33f0ea480b3d521f34afd54.1536744310.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 03:22:59PM +0530, Amit Kucheria wrote:
> Initialise the gpu thermal zone to export temperature to userspace.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index be27d8dc9e6b..62f079ae9ba3 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi

Acked-by: Andy Gross <andy.gross@linaro.org>
