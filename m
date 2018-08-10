Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50447C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 22:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA59A223DC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 22:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cXOMRYif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA59A223DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbeHKAuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 20:50:02 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:47058 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeHKAuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 20:50:02 -0400
Received: by mail-ua1-f68.google.com with SMTP id u11-v6so3504703uan.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 15:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AZRGoc5YCgjsR/n/MCe9BFE+sp2D8ceFcmVNXhC6aBw=;
        b=cXOMRYif1kujwcyjxY1FtU+Wy6pbPgnNJp707h+ax069FU+jaM3I9z71QPoepN3BtW
         dq6t6D4c1133PzNxjQYgSu4whkHo9ZVTe9JqKjb6Zyw4Z7XZWURUP+ywGF/3gLFLF+vN
         9AiJ/AK9B5PWGPINpywv2CPeF94Erypy7G4Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AZRGoc5YCgjsR/n/MCe9BFE+sp2D8ceFcmVNXhC6aBw=;
        b=peKFyhnEh1l96m5XkLY3jVqfJxcIhZs0C/knG88Zp081wySyNlw2EfPZ2DWoMFTMvz
         xb9tWXK9NSsGiHaVejQXdI3/ctfU/HVHuk3U7vCBSAlvs+3nFfvfy74GWqQSGC5phLTA
         nO38nb40WDRONqSHTpqitHGdWXmnpQWUs9TZOHW4PxYbN1on2Q757Im7Bf+AwaukU6nD
         P8IhXuRxiQofOOI/G+iQlun8v3ksiNF966pT5YOL9JJnlU09SBbybTlQEe94EMkSkB+D
         qOoIUpQAQoNVE8dL7RG2sKRTsoua8DDN7cbc4YmtzBoDpf8vNNUW6tTjOG86X8/ITnqD
         FRqQ==
X-Gm-Message-State: AOUpUlHLr9qKO4DK5zQnlvvkD65WIgejzfC9JTnjKtPhV2TPsLs5CqPw
        UckY2miQoGhhAVjlEnOU8T0dhyf/q8s=
X-Google-Smtp-Source: AA+uWPyBMNlERdButYM9d5a+1n7HD4KpuXjkxLG/qvBuc2Y3Pj+2mxD6OhxEJAz8YcjHbj2vIEB1CA==
X-Received: by 2002:ab0:4e9d:: with SMTP id l29-v6mr5666004uah.126.1533939494811;
        Fri, 10 Aug 2018 15:18:14 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id q18-v6sm1665798ual.38.2018.08.10.15.18.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 15:18:13 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id k8-v6so3504873uaq.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 15:18:13 -0700 (PDT)
X-Received: by 2002:a1f:9d16:: with SMTP id g22-v6mr5239166vke.5.1533939492933;
 Fri, 10 Aug 2018 15:18:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 15:18:12 -0700 (PDT)
In-Reply-To: <20180719175356.14753-2-vivek.gautam@codeaurora.org>
References: <20180719175356.14753-1-vivek.gautam@codeaurora.org> <20180719175356.14753-2-vivek.gautam@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 10 Aug 2018 15:18:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vmn40CmLLLEfrE-eq2sj4CYnx2E2-k-dimk24CDTU1jQ@mail.gmail.com>
Message-ID: <CAD=FV=Vmn40CmLLLEfrE-eq2sj4CYnx2E2-k-dimk24CDTU1jQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dts: arm64/sdm845: Add node for arm,mmu-500
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, sricharan@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 19, 2018 at 10:53 AM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> Add device node for arm,mmu-500 available on sdm845.
> This MMU-500 with single TCU and multiple TBU architecture
> is shared among all the peripherals except gpu on sdm845.
>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  4 ++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 73 +++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index 6d651f314193..13b50dff440f 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -58,3 +58,7 @@
>                 bias-pull-up;
>         };
>  };
> +
> +&apps_smmu {
> +       status = "okay";
> +};

When you spin this patch please put the above in the correct place.
Since "a" sorts alphabetically before "i" then this should be just
before the line:

&i2c10 {

Thanks!

-Doug
