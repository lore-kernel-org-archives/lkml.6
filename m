Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC86C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8360420645
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="irsWlRL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8360420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeK1GZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:25:41 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45089 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbeK1GZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:25:40 -0500
Received: by mail-vk1-f196.google.com with SMTP id n126so5338295vke.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 11:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fT92pSQBkH2Kacv5dZWsTSHpUZMrE0kewaDsRcZSiu8=;
        b=irsWlRL2tt7r8w+QiQ/VULh6PG9bDa7DSELPb7rfeihLiX6Cywt/HEk//FQ+gOFSm1
         K/qbYwH2jJr3OrzGalalVksxUtn8xlBCUh3+S6II5x+h9FX+kV/zqvcc5I8rzm9ZtUlV
         xfHRhq1mrPBsCrv7VePEgRetKTXZBywy10USg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fT92pSQBkH2Kacv5dZWsTSHpUZMrE0kewaDsRcZSiu8=;
        b=ZAWZ9t3bDvMR08lbDx+6atS7pTM4fC3oNzA0AEwUAklDt9ugaA4jCzUt5P/Wyj66Qh
         GPC+Al9Z8KQ0LYbH8ZqAzrnDdnC3sMvpIH0oE5Ntmo+K87YIedKNetdF9Kd5sWE2Hh0L
         /mlow2Q7U3jLMTIoDfs5aZH8O4vWvE8uyeAkWLI1gSpPr+yLs+bpVn9XEtUtfYcqNucQ
         s8nYWeMnwc+WS7I9oKDtrpYcW+wrnGHJA5ap9Wzy1UJm5wsv2H439bTOed6+et66qwcD
         XfD1nnodbNNm5h5rWMpS0oTGOySTbIcTBvPQo0fPGls97zLvKZcGu0GI8y5Zc+a9SeDn
         9AvQ==
X-Gm-Message-State: AA+aEWbbMNe+x3zUllGMX9Ufqsdd6jkn7ftEaQtQDGzswG3skE+f/bU3
        mT+penDDWbn/JAJhfctjh2cGClgEz98=
X-Google-Smtp-Source: AFSGD/WJtPOtItiqDjE/PuJKZqmpMWc5Km3exTJ/OtmlvlZQN9KoODGpwY2+s/ak0Ie21ElDnvEdHA==
X-Received: by 2002:a1f:3093:: with SMTP id w141mr13412692vkw.32.1543346803284;
        Tue, 27 Nov 2018 11:26:43 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id j25sm3385923uag.8.2018.11.27.11.26.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 11:26:42 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id z24so8017977ual.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 11:26:42 -0800 (PST)
X-Received: by 2002:a9f:2bc6:: with SMTP id f6mr13743866uaj.52.1543346801602;
 Tue, 27 Nov 2018 11:26:41 -0800 (PST)
MIME-Version: 1.0
References: <1541414117-27864-1-git-send-email-tdas@codeaurora.org>
 <CAD=FV=X3C=oKep1kPWjasLDZdFKfhCs0JMWTOensgYDj=apvuQ@mail.gmail.com> <154330186815.88331.12720647562079303842@swboyd.mtv.corp.google.com>
In-Reply-To: <154330186815.88331.12720647562079303842@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 27 Nov 2018 11:26:30 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XoriDM2Dmj0bYwbqZ+ej6Ybf_XX5DOTSW1_X3eGRkohQ@mail.gmail.com>
Message-ID: <CAD=FV=XoriDM2Dmj0bYwbqZ+ej6Ybf_XX5DOTSW1_X3eGRkohQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sdm845: Add videocc node
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 26, 2018 at 10:57 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> > > +               videocc: clock-controller@ab00000 {
> > > +                       compatible = "qcom,sdm845-videocc";
> > > +                       reg = <0xab00000 0x10000>;
> > > +                       #clock-cells = <1>;
> > > +                       #power-domain-cells = <1>;
> >
> > Any reason not to include "#reset-cells = <1>;" here?  The bindings
> > list it as optional but I see no reason why we should leave it off.
> > The file "include/dt-bindings/clock/qcom,videocc-sdm845.h" seems to
> > include some #defines for resets.  Even though the driver doesn't seem
> > like it supports it yet, it still should be fine to list it here.
>
> We should update the binding to make it a required property. It doesn't
> make any sense why that property would be optional given that the
> hardware either has support for resets or it doesn't.

Patch sent for the bindings change.

https://lkml.kernel.org/r/20181127192443.136158-1-dianders@chromium.org
