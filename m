Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC42C282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43457217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gpw1Psz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfAXBS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 20:18:56 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39961 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfAXBS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 20:18:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18-v6so3716746lji.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 17:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=evCDAp72O4n58O/GYaPYVCYBTU2Nnw9Zuy1bZqRgCwI=;
        b=Gpw1Psz9joOTqRIRt0682kzqaFSdd8ieMvU8GgXx7FyJqXwM5OaDiSQYveKz3KNpZ5
         dESCk+hG3yMs5xSTKrDyI0YZJion2a4RYFK54YgN5/dMC5d8gQ1atMh9mR5pcsXU3zSn
         HJ2RRR+CIztCEs9racH7J7t+zq01oYmi10pzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=evCDAp72O4n58O/GYaPYVCYBTU2Nnw9Zuy1bZqRgCwI=;
        b=SXEd2GKPQ8UDajIM+DWBjETi110YGvau8NITi1mJ+Kb88P3TGuXooQRiigxRyviGAc
         18EjIXAMXzp/l5rLUlUHZa0Iu0QpYKkc8074tqoChc0aE2Lr92iXcv1Vgh8I0jgljOP3
         YsWOPlw15am6MD3JgevnhQ6R6PuFLDp92CYeIrMtjiBzHjpCLBaCcvnBuKm8YX0U/BSr
         qfrZUqHIM/nPKmsTVHpFx/AXUly1tFiUdU9cjUnbJgh79P5I0cZVaXKLYJfePUXSB581
         8NfmsAjTKdkS/djEXyuVpqA9W8PWpisX3HLzR/gjLjrwqWxPWuGEebvjhewxY5Voqokr
         2xZw==
X-Gm-Message-State: AJcUukeDI/z2lpsQnRcMAlKZyM5knNz4adInGuLy5epRWTzFe4yTkiDL
        1AC1EbvisJ85moS5vmnuBaRb4uGBtIE=
X-Google-Smtp-Source: ALg8bN5F5qoRmO1z5y7IsRH5qT4Tf7V+MmZWVv5PIbvkG0HoQMogyp9GzRpSGZprB1Amp3/jcWZueg==
X-Received: by 2002:a2e:5816:: with SMTP id m22-v6mr3605046ljb.177.1548292734033;
        Wed, 23 Jan 2019 17:18:54 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id r29-v6sm747954ljd.44.2019.01.23.17.18.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 17:18:53 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id i26so3092311lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 17:18:53 -0800 (PST)
X-Received: by 2002:a19:d381:: with SMTP id k123mr3476475lfg.101.1548292243283;
 Wed, 23 Jan 2019 17:10:43 -0800 (PST)
MIME-Version: 1.0
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org> <1548138816-1149-2-git-send-email-alokc@codeaurora.org>
In-Reply-To: <1548138816-1149-2-git-send-email-alokc@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 23 Jan 2019 17:10:07 -0800
X-Gmail-Original-Message-ID: <CAE=gft5+OJCHTVszSW2Tt9HX3UA-LuTzK95Q4-R3v=DUqff9OA@mail.gmail.com>
Message-ID: <CAE=gft5+OJCHTVszSW2Tt9HX3UA-LuTzK95Q4-R3v=DUqff9OA@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: soc: qcom: Add interconnect binding for
 GENI QUP
To:     Alok Chauhan <alokc@codeaurora.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 10:34 PM Alok Chauhan <alokc@codeaurora.org> wrote:
>
> Add documentation for the interconnect and interconnect-names bindings
> for the GENI QUP as detailed by bindings/interconnect/interconnect.txt.
>
> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> index dab7ca9..44d7e02 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> @@ -17,6 +17,12 @@ Required properties if child node exists:
>  - #address-cells:      Must be <1> for Serial Engine Address
>  - #size-cells:                 Must be <1> for Serial Engine Address Size
>  - ranges:              Must be present
> +- interconnects:       phandle to a interconnect provider. Please refer
> +                       ../interconnect/interconnect.txt for details.

This path to the interconnect documentation is not correct.
