Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6A8C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1454A21884
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZusevqsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1454A21884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754174AbeGGL2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 07:28:04 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35347 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753687AbeGGL2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 07:28:02 -0400
Received: by mail-oi0-f65.google.com with SMTP id i12-v6so28130598oik.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 04:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ifu+eouiNPr+93Gd9P5KpIguxwMiifwmBu+oB9Y8ABI=;
        b=ZusevqsC9EtN1sR0RXgfUHn8Y30/WICE1EwXSRnmESQUEQIfAnGFmmTQJYHgotwZG+
         eDFXS/cFj53ItOLK6/j1bCPjXpPHYglm030VcxJUYppIQ/BAVRS0eTgFqyk7r159miBi
         GRt/r3Pqm5ezt7aBpGL8H1X0Pp3aOylFOHjHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ifu+eouiNPr+93Gd9P5KpIguxwMiifwmBu+oB9Y8ABI=;
        b=dzpqbPewwFeaT2HFlCyNHxIgyCfNv8nYLbJMthVefedriVVEN9j5iD21SDSOz72DrH
         i3cCdljodeoMqZCDpECa23Jt3jF7GY3j+aA/T4Kf9rpX36lFB2NdugpND9Pdp1gFCRR3
         +yy8GZr0Q8qx+7FYK7OaRyPl7EBtfafS+kQjkueFFOfH2CcgTXFuXGDwrFIRVS2/kgDS
         bWbUmnQ3+FQ8459Cmbkwb9TtJvYetUFi/lL/l3xX36c7RIw5EgIpm5GSt8rOptNjgpC0
         2B1WPnXlXb/b5NlPeRT08nB44qaplOmgWRyJnln2u9aedbODvGiZrOvQl7oK9Wsgs0kW
         5KyA==
X-Gm-Message-State: APt69E2h/nSSOM+2Gz3JiYj8a7PG+Y5RLk7aNSpPXUNphnEqrd6BkvlA
        mlOs/JRSO3Dlx+lcolEwNQ8SNuaLIuqOZWb/cUUKKQ==
X-Google-Smtp-Source: AAOMgpc5F9KSwQBUNLZtDRMrzoP9q+N4e1x3ULN/+2j/LjHZA1+uJDXsBynFMcNUAVrgeJWGqUr3yUc9DAgLjamLfxk=
X-Received: by 2002:aca:a8c7:: with SMTP id r190-v6mr14131954oie.357.1530962881772;
 Sat, 07 Jul 2018 04:28:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:192d:0:0:0:0:0 with HTTP; Sat, 7 Jul 2018 04:28:01 -0700 (PDT)
In-Reply-To: <CAMuHMdVEOx=PLAHzGEtPmVtitsVYSc-F1TUP6DVCS=Ct7QupYw@mail.gmail.com>
References: <20180706130220.21957-1-benjamin.gaignard@st.com> <CAMuHMdVEOx=PLAHzGEtPmVtitsVYSc-F1TUP6DVCS=Ct7QupYw@mail.gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Sat, 7 Jul 2018 13:28:01 +0200
Message-ID: <CA+M3ks7URGgxKfjkB9H2vi0qH-SvMZd1SfK4KZGPbF81+xJR9g@mail.gmail.com>
Subject: Re: [PATCH] dma: stm32: replace "%p" with "%pK"
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     vkoul@kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-06 21:38 GMT+02:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> Hi Benjamin,
>
> On Fri, Jul 6, 2018 at 3:03 PM Benjamin Gaignard
> <benjamin.gaignard@linaro.org> wrote:
>> The format specifier "%p" can leak kernel addresses.
>> Use "%pK" instead.
>
> Still? Isn't the value randomized these days?

%p give an hashed value, with %pK you can use a sysctl to get the real
value if you are root

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
