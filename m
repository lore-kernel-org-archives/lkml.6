Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BD0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935F8222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QPtCRoKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732956AbfBMM57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:57:59 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40436 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732744AbfBMM57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:57:59 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so3694645oth.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 04:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QXguzOfzcV3+ah430bo2TAyV1C0BFKI2hS7FQPF9m8Q=;
        b=QPtCRoKltR8BQnzOuCjlAA5f9j6tD04SEu7B0Nlqn/rmox9kZtZF7RCidlR1quyP29
         n8JgPzgN5lCfurrN8UPP21bVdNnFHvC/bHNSLohLLT2bElrS3ZPQrVanzSk5P/+/NyY7
         UMiCmMjHWDzP2PjD/Dn5Zh1bgAk3ROZGU9ZDu4+lV/UmQQepTc1AHJPqrdflaMFMKixC
         5B/sy+8BGoIhioAAe7iPu5aqhclS8DY7YGpai3oKEeeXJDhHZF0DFB6v8S8BajSqYYpX
         aJQ20ABpxNK7Gi40CfeTQfjq/D2G7OF6STR6YcRagpNTpHcJj3ZAuReO/Uwtv2vX2Vpg
         9Y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QXguzOfzcV3+ah430bo2TAyV1C0BFKI2hS7FQPF9m8Q=;
        b=oWk9EB06WEAVbrXM7NtsssSVbIpG2OSLOJ645VroNk4uKyWnO0ZbCq6CMf0t+/foGJ
         xniqNLKuGOQopdpG5M+hGIVhRTJ8uRq6a2NZ6eb46y6AzmsVB+NRJas83Nafy+ye57ra
         XhSQ7QgS8dFsvjry0Jn3KynZ96NNaZv+EWWqTb+g/fhE98FjblkBSMvOUCNN4j2z+kZ3
         xmCiwklefUMSkHAKmY98UI0iNsVuvtY2qIgUmgLF+Od21ur0a71AdaxX3xY3YXtrrDUh
         YVuGlZmK2CgAEKmwtov9b6qkB808oDylw9VeU9KfeBV+wVoLoi/h5YA2Es+5RdBo20qx
         96TQ==
X-Gm-Message-State: AHQUAuY0TKVMsHS6qnxMLzQcuXVwZZ7WXEV/tyRz8yvVOjkw7rfLljMI
        bi2aHY9IfYP2NttLBRTC8+No1yMWN+aR1v0aaI7P9g==
X-Google-Smtp-Source: AHgI3IaJN/J38y3yTq7n7qDMW4hfEIKcZjLeETJ4ww9sfA+8MYBbMb88D17/npWNisrtn0XdFN6REuscCt+d4NRiiys=
X-Received: by 2002:aca:cf57:: with SMTP id f84mr132392oig.147.1550062677989;
 Wed, 13 Feb 2019 04:57:57 -0800 (PST)
MIME-Version: 1.0
References: <b8101fd6d303c1993ee294eeee8bce4d24b9547f.1550061925.git.baolin.wang@linaro.org>
In-Reply-To: <b8101fd6d303c1993ee294eeee8bce4d24b9547f.1550061925.git.baolin.wang@linaro.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 13 Feb 2019 13:57:47 +0100
Message-ID: <CAMpxmJX7WdtbN=w8D=ZPwAFsamoTm89KeC42ag_LoSoJBFjiRg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: gpio: Use SoC compatible string instead
 of wildcard string
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 13 lut 2019 o 13:49 Baolin Wang <baolin.wang@linaro.org> napisa=
=C5=82(a):
>
> Use SoC compatible string instead of wildcard string.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  .../devicetree/bindings/gpio/gpio-eic-sprd.txt     |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt b/D=
ocumentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
> index 93d98d0..54040a2 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
> @@ -33,7 +33,7 @@ Required properties:
>    "sprd,sc9860-eic-latch",
>    "sprd,sc9860-eic-async",
>    "sprd,sc9860-eic-sync",
> -  "sprd,sc27xx-eic".
> +  "sprd,sc2731-eic".
>  - reg: Define the base and range of the I/O address space containing
>    the GPIO controller registers.
>  - gpio-controller: Marks the device node as a GPIO controller.
> @@ -86,7 +86,7 @@ Example:
>         };
>
>         pmic_eic: gpio@300 {
> -               compatible =3D "sprd,sc27xx-eic";
> +               compatible =3D "sprd,sc2731-eic";
>                 reg =3D <0x300>;
>                 interrupt-parent =3D <&sc2731_pmic>;
>                 interrupts =3D <5 IRQ_TYPE_LEVEL_HIGH>;
> --
> 1.7.9.5
>

Hi,

please indicate the module this concerns in the subject line.
Something like: "dt-bindings: gpio: sprd: ..."

Bartosz
