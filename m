Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DA2C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6202075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PaCRsAxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6202075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbeIFUg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:36:58 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43717 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730278AbeIFUg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:36:58 -0400
Received: by mail-ua1-f66.google.com with SMTP id f4-v6so9220171uao.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 09:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=87iNoYSUfe/536EvXk8+5SiR5kVKsQLteihjzvJE/VQ=;
        b=PaCRsAxYKcVm/VhawSeC6jdfpgujhPzEenQNTdeukh1qzf0LE4LUKt3nVK1qxi5pF/
         5DM+LYcwmgNsWgy0fQm47N8IUKu+8TSxUFFr4WwB1BPFG+IzqSPZDpJfRKqaUqFAfKCK
         n5gBbVldTIcE0wNjqBmr56O3kFwZuuxwOITN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=87iNoYSUfe/536EvXk8+5SiR5kVKsQLteihjzvJE/VQ=;
        b=BdK9WeI5yzyybrsiwgDDWC3u0bHBQ7PAI0EvlE+7wVsFZvDmdYLy0+43b8KGCuWRV2
         bA4r8sFZYVjEK/J/5pK2vN+2aV6TAUsaij8FrkbXguZK8fokAGa+NUTMKVyVZu+0/31G
         MDCKZUHLVEWy8LcdSZJNsBztHiSvQE97lbLZpnogUAVWJw+H0dp281ypa+vrDVFQu8kd
         IXmvK3o75YgjUH6YxHkQCPuLrGif+VjonkyL4FvZRk+gnzSlQ75CNFGZlROuSODWIhvq
         LiAdKYkLHfapb0Mq9lmV03qOmf24lGFY5mpL2ythwQpEYqkw+pg5aVTa1KrEZdM1TPKV
         1g6g==
X-Gm-Message-State: APzg51Dq4aHEf+1aR537eC36iszMNZcX97Y4xw0o9mLLLRQrA625UG+e
        E7gIkSf2wDbFXAM93zpCSJyLzrBaTxk=
X-Google-Smtp-Source: ANB0VdZDH7v8B3XAtkFv69f7EZ8moTxj9aKq0AXVakr7GQPeRVqcedK63TftnUBJqKPZtdEmzbVr2g==
X-Received: by 2002:a67:f74a:: with SMTP id w10-v6mr1182994vso.85.1536249647361;
        Thu, 06 Sep 2018 09:00:47 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id u15-v6sm1837621uaf.15.2018.09.06.09.00.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 09:00:46 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id 101-v6so9222914uav.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 09:00:46 -0700 (PDT)
X-Received: by 2002:a1f:bc6:: with SMTP id 189-v6mr1162425vkl.69.1536249645719;
 Thu, 06 Sep 2018 09:00:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:5e8e:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 09:00:45 -0700 (PDT)
In-Reply-To: <20180901222355.21803-1-bjorn.andersson@linaro.org>
References: <20180901222355.21803-1-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Sep 2018 09:00:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UohTgZLG+Nymf6Rd0v7H9gssheYAxuH5m0QRN3TufJQA@mail.gmail.com>
Message-ID: <CAD=FV=UohTgZLG+Nymf6Rd0v7H9gssheYAxuH5m0QRN3TufJQA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: Add AOSS reset driver node for SDM845
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Sep 1, 2018 at 3:23 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> From: Sibi Sankar <sibis@codeaurora.org>
>
> This patch adds the node to support AOSS reset driver on
> SDM845
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> [bjorn: Updated addresses to match the binding that was merged]
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 0c9a2aa6a1b5..077760792cf0 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/reset/qcom,sdm845-aoss.h>

nit: please sort alphabetically.  "reset" comes before "soc"

...other than that this looks sane to me.  Feel free to add my Reviewed-by tag.


-Doug
