Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34DAC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC9122426
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ltzSGBME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC9122426
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeHJWii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 18:38:38 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35778 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbeHJWih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 18:38:37 -0400
Received: by mail-ua1-f68.google.com with SMTP id q12-v6so3162952ual.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 13:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jdNgFSaH8z8E8xyy4W9So0XahVKzGksztTByXt+jG4M=;
        b=ltzSGBMEgS+nQ0sMrrdCRUNZBzHXg/aeIuCIUY87djJagKtdO2JpdL0IijGgqXj2Z4
         ZqVow78ncWpf9oqITivK7ZRqL2hM7crQFelEZehabBUW87WlPBbqSKj5BnbhSJm8rRlX
         zVmLxv7JHQ4w9OG6CVfmFAZ4Z/rTJssMi8q2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jdNgFSaH8z8E8xyy4W9So0XahVKzGksztTByXt+jG4M=;
        b=cGfjYxocM1PatLeDU/YNpB3TvtgN3Gsyz5mogqLeFG0X4icHNRJ+AiJ+2DkhKu6JoI
         51vShsJwR5GlIi36cmm+bfF30dPXvJmG+ArSMtEF8HWlKn1clvYrwEDExwxTTavmml3v
         ZAbkjmE1ZqULDaabo350p8p9SeR1KQAEWhOU/P0k+VVJcpyfo4IRGQlCgVEBQfjqQ8hW
         a91/TK1qgmE0TZJvzQ7aDyCBz79FNU3KhDy6pprz98SaqoeALEooOga+G84BReXWRi5P
         pvg7sYTXf+cp5dZM7uoqvcSwzK6u5q/eAx1XkBiOkKDMvTB/pg5j/s/U94HSg2U2ty3T
         U7sA==
X-Gm-Message-State: AOUpUlGiJUtn0xG1QTbIhW/Mw0YJM0wZyG8NYWia8QyujtJsdbJVMl2Q
        +QsO+SG27PtTiaMCg2gaslZ9UWU/lTI=
X-Google-Smtp-Source: AA+uWPxtZQSghwjFKWiIchayCqAhfeYXSoN0JroFRv/rs/DN+rNPzNbN/64xk2C6PC0fKhmd4Feyfw==
X-Received: by 2002:a1f:61c5:: with SMTP id v188-v6mr4980683vkb.19.1533931636957;
        Fri, 10 Aug 2018 13:07:16 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id m143-v6sm3002522vke.23.2018.08.10.13.07.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 13:07:16 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id i4-v6so3162955uak.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 13:07:15 -0700 (PDT)
X-Received: by 2002:a1f:9d16:: with SMTP id g22-v6mr4986357vke.5.1533931635475;
 Fri, 10 Aug 2018 13:07:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 13:07:14 -0700 (PDT)
In-Reply-To: <20180810162920.GG20971@sirena.org.uk>
References: <cover.1531531808.git.collinsd@codeaurora.org> <acfc014f3ae3d7feea30be6beaec3e64d96a2723.1531531808.git.collinsd@codeaurora.org>
 <20180810162920.GG20971@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 10 Aug 2018 13:07:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V54aOCTLk3J_0=DL0XHJ-Tc77zKzURTwz5PJsioK73+A@mail.gmail.com>
Message-ID: <CAD=FV=V54aOCTLk3J_0=DL0XHJ-Tc77zKzURTwz5PJsioK73+A@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] regulator: add QCOM RPMh regulator driver
To:     Mark Brown <broonie@kernel.org>
Cc:     David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 10, 2018 at 9:29 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jul 13, 2018 at 06:50:59PM -0700, David Collins wrote:
>
>> +     switch (rpmh_mode) {
>
>> +     default:
>> +             mode = REGULATOR_MODE_INVALID;
>> +     }
>
> I'm not sure why the break statements are being omitted in default
> cases, but I do find myself stopping and trying to figure it out?

Hopefully <https://lore.kernel.org/lkml/20180810200531.88409-1-dianders@chromium.org/>
addresses this?

Thanks!

-Doug
