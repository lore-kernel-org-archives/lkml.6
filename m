Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5602FECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AA920880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WuKYUmQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3AA920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbeISNJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 09:09:19 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55590 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731106AbeISNJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 09:09:18 -0400
Received: by mail-it0-f65.google.com with SMTP id d10-v6so6946391itj.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 00:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9uPA69eajesH/rvoa4ZEPF3aZkxyK6Cwi+ARhg7mQG0=;
        b=WuKYUmQOAKhIZlQCOAYc/MKP9xBWOj2WnpltQap/k5KMZdCSCI1jbi01b7EFvzCZdy
         YUBenARwa1W8K7Fc7OwGo2FJshHQmn9zdpYfZrcwopudTXUkddsAKHpKZx4NzBKYm1S1
         lKwmgIrSzB8jSgysFrDoDkDjNiBONg0ZGn5PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9uPA69eajesH/rvoa4ZEPF3aZkxyK6Cwi+ARhg7mQG0=;
        b=OucgXNbvAMP/e5nYwOPdQpshwBkzv5i1JqfsYuy5cGuKd8JZ5KCEuAizUtdQFz7vbT
         uuQ0pNCdUmDdQKw4yk6rNWZsGygg6gbUsRUorTZryPJZ8cFZts1C+ncIQx3rDYuIMkOq
         xGdoJ2FvE2Y/RsY/BWd8rpFqDMomduJffARV1K8spPR/1JaSa6gbOyCagoiLxkN7dxyW
         BX317azAVN97ih+W7IC7MXfjwA11jDvDa1g//uiZVFG/LM0RcDagwx0S3FwdKiMS1XdR
         InF773Gsv645XGraaOl8lt8283U94uaHT3sXJIh5lNi/Hyl6Jy7T3RHLyZ1zKr6Kw4cn
         ryPw==
X-Gm-Message-State: APzg51D/PgO8edaKZzTcNlnDHueuUdibjFq0epT+kDgoDDTya76Z4dVl
        3uglgW0tuCw6YCs1ziWoJkY3RIUMLen9Ag==
X-Google-Smtp-Source: ANB0VdZJQMv93ZjiwEwEV5sWFFdVo4mFcg6j5O2D1TbRekBfrntDia12jYmgDm1wisXMNeIsDtGb8A==
X-Received: by 2002:a24:d6d3:: with SMTP id o202-v6mr18937499itg.115.1537342360284;
        Wed, 19 Sep 2018 00:32:40 -0700 (PDT)
Received: from mail-it0-f43.google.com (mail-it0-f43.google.com. [209.85.214.43])
        by smtp.gmail.com with ESMTPSA id d198-v6sm3556229ith.5.2018.09.19.00.32.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 00:32:39 -0700 (PDT)
Received: by mail-it0-f43.google.com with SMTP id j81-v6so6997243ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 00:32:39 -0700 (PDT)
X-Received: by 2002:a24:f54a:: with SMTP id k71-v6mr19237580ith.36.1537342358820;
 Wed, 19 Sep 2018 00:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <1537314192-26892-1-git-send-email-vgarodia@codeaurora.org> <1537314192-26892-6-git-send-email-vgarodia@codeaurora.org>
In-Reply-To: <1537314192-26892-6-git-send-email-vgarodia@codeaurora.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Wed, 19 Sep 2018 16:32:27 +0900
X-Gmail-Original-Message-ID: <CAPBb6MV0egcso8fDcfkvc_+Un2PKX+H=fz-1aKFRJ38ciOBd7g@mail.gmail.com>
Message-ID: <CAPBb6MV0egcso8fDcfkvc_+Un2PKX+H=fz-1aKFRJ38ciOBd7g@mail.gmail.com>
Subject: Re: [PATCH v9 5/5] dt-bindings: media: Document bindings for venus
 firmware device
To:     vgarodia@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, robh@kernel.org,
        mark.rutland@arm.com, Andy Gross <andy.gross@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, bjorn.andersson@linaro.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 8:44 AM Vikash Garodia <vgarodia@codeaurora.org> wrote:
>
> Add devicetree binding documentation for firmware loader for video
> hardware running on qualcomm chip.
>
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/media/qcom,venus.txt | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/media/qcom,venus.txt b/Documentation/devicetree/bindings/media/qcom,venus.txt
> index 00d0d1b..7e04586 100644
> --- a/Documentation/devicetree/bindings/media/qcom,venus.txt
> +++ b/Documentation/devicetree/bindings/media/qcom,venus.txt
> @@ -53,7 +53,7 @@
>
>  * Subnodes
>  The Venus video-codec node must contain two subnodes representing
> -video-decoder and video-encoder.
> +video-decoder and video-encoder, and one optional firmware subnode.

I think I mentioned this in my previous review, but it would be nice
to explain in which circumstances the firmware node is optional. I.e.
it should not be specified if TrustZone is used.

>
>  Every of video-encoder or video-decoder subnode should have:
>
> @@ -79,6 +79,13 @@ Every of video-encoder or video-decoder subnode should have:
>                     power domain which is responsible for collapsing
>                     and restoring power to the subcore.
>
> +The firmware subnode must have:
> +
> +- iommus:
> +       Usage: required
> +       Value type: <prop-encoded-array>
> +       Definition: A list of phandle and IOMMU specifier pairs.
> +
>  * An Example
>         video-codec@1d00000 {
>                 compatible = "qcom,msm8916-venus";
> @@ -105,4 +112,8 @@ Every of video-encoder or video-decoder subnode should have:
>                         clock-names = "core";
>                         power-domains = <&mmcc VENUS_CORE1_GDSC>;
>                 };
> +
> +               video-firmware {
> +                       iommus = <&apps_iommu 0x10b2 0x0>;
> +               };
>         };
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
