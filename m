Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E06C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74BB20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nPJSAb6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74BB20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbeK0S2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:28:33 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36916 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbeK0S2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:28:33 -0500
Received: by mail-oi1-f193.google.com with SMTP id y23so18435415oia.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 23:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iuKpkEGM7qpo9UUMnYTqTA6JngBECjQh4s6cNdS73GY=;
        b=nPJSAb6Z9KqLRWL9+7UBVvG6Fj0pEOezAR6J5zykjWhBtaXIaswc4DED3aqmWRukoa
         DYqTP406yPVdhX4E0ueQC1Ss149nHMjAYEIarbTWins98oPhX6JT2UNRtppEWGwe/p/g
         VW2xzikJxYexsofTDZILaHW6Abu2YtAQuldY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iuKpkEGM7qpo9UUMnYTqTA6JngBECjQh4s6cNdS73GY=;
        b=Z7POplilQLbG4t4JaILbMVZM4Iz6lSasE/wow1JUIoSYUSFvewpJBDNvNEJxlSjZpR
         K/jbZVAY9BYmJtusCDAUwq4wglZXk7+AI+WYYWoM1lw7tFhNC+EMrMHYOyUDOVxegYoI
         nvoJW+5E4H1ddg9FsZhu2w5yVhatgDxHktGB59v2YP/ytlobhdg8u5Rc+K+0U3Gxu7E7
         mIGqIWS9sAlm7sHc/gufIbdz4OCIxwdsxgCHzEmFXdBVKIxWcx8Atptxv10nl0+VBbY/
         lMAZ1p46iJy+PWP+yoQd8XDVk+j+jtdpGyk6BNOs0vDlOeNJfRPzF7PxpDH/BIq4+DmV
         eRdA==
X-Gm-Message-State: AGRZ1gL+SQnathof2cF8p05Dq0BajYZakMvzjvT44aLloDduHDeonkc2
        Aohe5qpvL23EvIk3Hrmt4Bkkllg3QOyHQQ==
X-Google-Smtp-Source: AJdET5c7Puj4RkzdFFqtUGec2fiDxASnpkN8uViZe6Nopsru/jdCX1JdVrYJkAfg3v8h+X6w7WrU2Q==
X-Received: by 2002:aca:3807:: with SMTP id f7-v6mr18132868oia.46.1543303895144;
        Mon, 26 Nov 2018 23:31:35 -0800 (PST)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id v141sm2876796oia.25.2018.11.26.23.31.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 23:31:34 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id g27so19235762oth.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 23:31:34 -0800 (PST)
X-Received: by 2002:a9d:3f7:: with SMTP id f110mr14688880otf.171.1543303893729;
 Mon, 26 Nov 2018 23:31:33 -0800 (PST)
MIME-Version: 1.0
References: <1542708506-12680-1-git-send-email-mgottam@codeaurora.org>
In-Reply-To: <1542708506-12680-1-git-send-email-mgottam@codeaurora.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Tue, 27 Nov 2018 16:31:22 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVzmxfRstUrTOtkJdCDaZEZO=UeP_u3btGKrsKasBijRg@mail.gmail.com>
Message-ID: <CAPBb6MVzmxfRstUrTOtkJdCDaZEZO=UeP_u3btGKrsKasBijRg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sdm845: add video nodes
To:     mgottam@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 7:08 PM Malathi Gottam <mgottam@codeaurora.org> wrote:
>
> This adds video nodes to sdm845 based on the examples
> in the bindings.
>
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 0c9a2aa..d82487d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -84,6 +84,10 @@
>                         reg = <0 0x86200000 0 0x2d00000>;
>                         no-map;
>                 };
> +               venus_region: venus@95800000 {
> +                       reg = <0x0 0x95800000 0x0 0x500000>;

Note that the driver expects a size of 0x600000 here and will fail to
probe if this is smaller.
