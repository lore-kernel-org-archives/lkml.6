Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B32C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3752173B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Df/29kM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeLZBHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 20:07:06 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45781 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbeLZBHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 20:07:05 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so12763672ljd.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 17:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pA9dTqbl67VOASovxKEwkiuLynEHO/coRCOBN6gbTqQ=;
        b=Df/29kM1eD3/RHN81pc5WF3c4heRiaXJnGZBKE6lXTtoT+m+WuDYuJ2gGDyeXlH4r0
         6IbNE+ShKaFr1+RpGWuNDycCAmt3QdjYhXD3azvZNVi8nRMM6bH5akgnVO7ca8/I5h1n
         L/SSFS6YWXVvyFgjtM6beuMEkrP10avsmrbEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pA9dTqbl67VOASovxKEwkiuLynEHO/coRCOBN6gbTqQ=;
        b=MfpVk1A84miy2lj8BHEDa1I0Ugigf7GKlVqm/V12Wiz+OCMW+0a352Wj9UZ+vXn/Cz
         FSyRNS33//0ZOFrxta+jdci+RWec89dQxwohhjB0w+LqphTYltB59IYqycTgb3/9ywAs
         Ns7e24AUElLot921mKlBk6VYtLp664XAYW1WesL9q0JDu6ZljbeRV4/yvg6QHHdW0pNI
         mPDhSp0NpsCV6KUEyBB+tNFCZCapu68/ZlYI/TbQqZpVXriyI3DJK2quOpTZncuFLEfl
         WN7PERZBATgSqB4TpGsNReVJ2qLbFtDcSfl4sSOtLlEfaVBbtg0XOJ8vJm/oI2LHhmXY
         KaRw==
X-Gm-Message-State: AJcUukck09l9gpMqxaTk+dMb2qEyY4W2ApZ44GVYP6poNlQt78ltRTFe
        laJ8JnvS/OE6zYVif83EcY6CCk0P724jUmUq7qqhag==
X-Google-Smtp-Source: ALg8bN62x7qi0rsKJjROmHk3l0FUunViPBx+DRyZIxINNVFbqc2Z8OnX8Dnu3S0lhFqqH8lXKycyi4BXroVfLIA7zGY=
X-Received: by 2002:a2e:7f04:: with SMTP id a4-v6mr11384244ljd.156.1545786423507;
 Tue, 25 Dec 2018 17:07:03 -0800 (PST)
MIME-Version: 1.0
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com> <20181222202623.4521-6-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181222202623.4521-6-wsa+renesas@sang-engineering.com>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Wed, 26 Dec 2018 09:06:52 +0800
Message-ID: <CABymUCMpU+xwb8aaEgfyMWwyYSR5a33ZXuLseZiiDM7oXyRH5Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] i2c: zx2967: don't open code to reject transfers
 when suspended
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfram Sang <wsa+renesas@sang-engineering.com> =E4=BA=8E2018=E5=B9=B412=E6=
=9C=8823=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=884:26=E5=86=99=E9=81=
=93=EF=BC=9A
>
> This is handled by the I2C core meanwhile.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-zx2967.c | 8 --------
>  1 file changed, 8 deletions(-)
>
    Reviewed-by: Jun Nie <jun.nie@linaro.org>
