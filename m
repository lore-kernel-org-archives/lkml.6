Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFD4C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE5420652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fcp2Qs0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE5420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbeJXAyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:54:49 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42639 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbeJXAyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:54:49 -0400
Received: by mail-lf1-f66.google.com with SMTP id q6-v6so912681lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 09:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rNfd1jPzEHUb7LLxCVbCKVIOG4POLcH0dnvi5CKkp/U=;
        b=fcp2Qs0sBakH5hLUzN3CHT+mtoM8hB2Vm24tTakTPVgQBdqt3syrxPU28ftudyu1B9
         bkN3hrSz/oQ4p+bi+0pZpUmvI0AwS0+CgAEyRxT+eEH2uyIZQ0jJGMIIHkVvXC1CljlU
         Nj0+kyggSzh1EUmcvUix9xa+k0bU1bUFM9ta8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rNfd1jPzEHUb7LLxCVbCKVIOG4POLcH0dnvi5CKkp/U=;
        b=ihPAJrVOZ7US7c/eeGNZ5U5sUVvE6D8/FKUC523nfRcatjVzAGfpCkxIy/7UU6ygTM
         N2kGDrWDRx53yChmGT2ROzn5IRmqKhkkGhWzhldCkJWNReet42AxQEPQ/X5/VOiNLA6A
         0aw2YvUv6QQ4yG8g+cqv26gQa5w1DhM9qzevmZtDrwi+eRa5VJ3hVXF03UOfMHHe4yXl
         Lob2LanTgJhc78ahm85ADRJXalYC8dBn/UHgOBjveBEepOir0EpaNSAvc+95Q20YnSZP
         cA0Gc3nLhSg9fmM3NxWdmxydoCTtEYCD3rN0NZ931PXWN48IIHFXVUIK7RMj1QnIIGWQ
         VzCA==
X-Gm-Message-State: ABuFfog53p6klxNBMSTQtnzB3tM0S09dtLmIjClDiFe5pb4GeRYO9Jej
        pQ/uKzTeoNdMkzVsQqIQDf7FPaFD3uo=
X-Google-Smtp-Source: ACcGV60aGlm4m9cMtebz1ApGcsL6JsI1QhS5edh0k/xno+PhWV02ExuGuQz7iTkJJQ4t74cc49rA0A==
X-Received: by 2002:a19:5154:: with SMTP id f81mr9131176lfb.96.1540312241426;
        Tue, 23 Oct 2018 09:30:41 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id l124-v6sm281524lfb.58.2018.10.23.09.30.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 09:30:40 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id c16so1640556lfj.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 09:30:39 -0700 (PDT)
X-Received: by 2002:a19:274b:: with SMTP id n72-v6mr12326059lfn.153.1540312238802;
 Tue, 23 Oct 2018 09:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20181018210933.113592-1-evgreen@chromium.org> <20181018210933.113592-2-evgreen@chromium.org>
 <20181023002903.GA16854@bogus>
In-Reply-To: <20181023002903.GA16854@bogus>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 23 Oct 2018 09:30:00 -0700
X-Gmail-Original-Message-ID: <CAE=gft4t7jY89sJ8aJysdiJxq64Gp0ABC04jmOQEq9=yCckBhw@mail.gmail.com>
Message-ID: <CAE=gft4t7jY89sJ8aJysdiJxq64Gp0ABC04jmOQEq9=yCckBhw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: phy-qcom-qmp: Fix register underspecification
To:     robh@kernel.org
Cc:     mark.rutland@arm.com, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, kishon@ti.com,
        Doug Anderson <dianders@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, swboyd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 5:29 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Oct 18, 2018 at 02:09:29PM -0700, Evan Green wrote:
> > This change adds register regions for the second lane of dual-lane nodes.
> > This additional specification is needed so that the driver can stop
> > reaching beyond the tx and rx register allocations to get at the
> > second lane registers in a dual-lane PHY.
> >
> > While in there, document #clock-cells as optional for PHYs that don't
> > provide a pipe clock. Also, document the pcs_misc register region, which
> > was being quietly supplied and used.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> >
> > ---
> > This applies atop linux-next 20181018 with the addition of Doug's
> > changes [1] and [2].
> >
> > [1] https://lore.kernel.org/lkml/20181012213632.252346-1-dianders@chromium.org/
> > [2] https://lore.kernel.org/lkml/20181012213926.253765-1-dianders@chromium.org/
> >
> >  .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 73 +++++++++++++++++++---
> >  1 file changed, 65 insertions(+), 8 deletions(-)
>
> One nit below, otherwise:
>
> Reviewed-by: Rob Herring <robh@kernel.org>
>
> >
> > diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> > index fbc198d5dd39..297a7c753fc8 100644
> > --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> > +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> > @@ -25,7 +25,7 @@ Required properties:
> > +
> > +     phy@88eb000 {
> > +             compatible = "qcom,sdm845-qmp-usb3-uni-phy";
> > +             reg = <0x88eb000 0x18c>;
> > +             status = "disabled";
>
> Don't show status in examples.

I'll fix it. Thanks Rob.
