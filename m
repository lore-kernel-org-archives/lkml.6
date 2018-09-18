Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F73C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805EC20867
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WmUT7Vck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805EC20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbeISBpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:45:39 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33526 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729926AbeISBpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:45:38 -0400
Received: by mail-it0-f65.google.com with SMTP id j198-v6so15197213ita.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 13:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5lC8gZSfssAInOIoJgnYvt7c0uGK5ME7a6Od9IgmxRo=;
        b=WmUT7VckJ/isUx8zTmPCldMq+cuAsOnD9tW+5x3u9MQ8iAbbM2f28mrFpx51rXcmrW
         MKufO5CEVPZR/uln+XTFXNjMd/0Jx8vDob409GXRRvuEjJFZO0uJuNEoYl5bE21F+DJf
         sGHMPiuV8iA2KgmpZCDm2Kai0VI+Eotgmws0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5lC8gZSfssAInOIoJgnYvt7c0uGK5ME7a6Od9IgmxRo=;
        b=TU2bTfRLvWvxsgCZhDZdNaaETefvmYsapEwZaGsfaoLRNL+o8fXFED2O5qsAgagqTb
         QvCO8I9L34uGS6iTzHl4uGbDRbU9vJ4sjBmf9BarDUDS9BgtmXbDn7gizqvaJjwqK2ma
         8zB3ZqKU8IFfyEoZFlJc6ZsboBw0TbKHfz1cGOKtk+IotMNwbcylSN/ufo9i588GA63G
         K5OE5Ep+HCGgAyfTWw3EfNMjVKpYNSiCh3GMurvdvBiI4stGrSDgCURWa6u4Dy/l8oHl
         8o1rtWPJnKM0uiOEJK13/WyjQ1admACqJAAQxWDOvswoz7odEtHAWMU1ZPvq6Je+pU6W
         Gudg==
X-Gm-Message-State: APzg51CX5jb+L7eiMm4RiYUpJJ8rx504Hnl6zYPRrqE1YBe9aed+UGSU
        dD+ulDFPJTctPGPV8bFz7v/xpgYSRFg=
X-Google-Smtp-Source: ANB0VdYX20C1SEoOzFpEy+GoTbIWVR1gonYy1Q7q7Jz4pVMXL4N7QraKU/dXnUxhYMxxKNqY9eMrag==
X-Received: by 2002:a02:702:: with SMTP id f2-v6mr29323092jaf.70.1537301486838;
        Tue, 18 Sep 2018 13:11:26 -0700 (PDT)
Received: from mail-it0-f46.google.com (mail-it0-f46.google.com. [209.85.214.46])
        by smtp.gmail.com with ESMTPSA id x68-v6sm6996042ita.2.2018.09.18.13.11.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 13:11:26 -0700 (PDT)
Received: by mail-it0-f46.google.com with SMTP id u13-v6so4753669iti.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 13:11:25 -0700 (PDT)
X-Received: by 2002:a24:8647:: with SMTP id u68-v6mr17096290itd.154.1537301485460;
 Tue, 18 Sep 2018 13:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org> <1537294047-12093-3-git-send-email-dkota@codeaurora.org>
In-Reply-To: <1537294047-12093-3-git-send-email-dkota@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 18 Sep 2018 13:11:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VJesdkPuHmg8qSfkM284aC36Gq9OdbeJFTtpwGqtuEmg@mail.gmail.com>
Message-ID: <CAD=FV=VJesdkPuHmg8qSfkM284aC36Gq9OdbeJFTtpwGqtuEmg@mail.gmail.com>
Subject: Re: [PATCH V4 2/4] dt-bindings: soc: qcom: GENI SE SPI controller
 device tree binding
To:     Dilip Kota <dkota@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, Sep 18, 2018 at 11:08 AM Dilip Kota <dkota@codeaurora.org> wrote:
>
> Move GENI SE SPI controller device-tree bindings
> from devicetree/bindings/soc/qcom/qcom,geni-se.txt
> to devicetree/bindings/spi/qcom,spi-geni-qcom.txt.
>
> Signed-off-by: Dilip Kota <dkota@codeaurora.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  | 27 ++-------------
>  .../devicetree/bindings/spi/qcom,spi-geni-qcom.txt | 39 ++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 25 deletions(-)

IMO this matches what Mark Brown requested in a previous email and
seems like a good idea.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
