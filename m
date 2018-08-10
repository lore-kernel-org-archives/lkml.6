Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBC8C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BBD223AB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gg7OBvrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BBD223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbeHJTUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 15:20:18 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35626 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbeHJTUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 15:20:18 -0400
Received: by mail-ua1-f65.google.com with SMTP id q12-v6so2535622ual.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pzS0sAK3QmLnlcTfr4Qz28c9C9QFNYAbbNOlSMDSzZw=;
        b=Gg7OBvrSmrl5uV7nc3GrUyZ6hPLjSG4MmdAdghToqtu9AaCmUZTQ8OMDHyXHAKoOgv
         TN0FZHO6timIuC9cxI4FswpUo2OJIMcQBAZLEEdAPx+stmVrsADpEtRADzbOV9MbF88Z
         y3ez4AdXurkd8c4c+0xRH5QCZweZAp/bTSmfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pzS0sAK3QmLnlcTfr4Qz28c9C9QFNYAbbNOlSMDSzZw=;
        b=AIHqH2PrSDB/XYjSV1MFtELRT1pSenqhBS8VYeS6dp9nGt9XiEJlgmq6233fHqt9NK
         NhmVi5sWhcOSKsB7nywnwMP0Zsp05Kq5AvaPqLsoJlUNcq1IwopSZlQ7XfGgmY/l8XVF
         2O9Rm1ExK2EbBhEhLDgLEgfezhgaouM+4qmqAd7BbdsHBU6mPNGuH/OcwI/bk9ZrpZlX
         i1U/TtltboJ4m3srsAGaXD2Le/yFl2F1SC6gweZe6YBLR7yd+4rzkkkyOMS5E8uNeSgG
         UvtkjrqqM643tHmGL5DACgYT2naPbzQTY/ku4CdGq/fArAob0Dl07Wp2kFiP+EvhDR5f
         W+dA==
X-Gm-Message-State: AOUpUlHqRNfja5DBa6DY3m9ovzzcEc5dr6Fx55eytE9K7wpoUB78MF44
        GabjDmM2LXKRe4ivygGq0wvRvytBqp0=
X-Google-Smtp-Source: AA+uWPzBH1v6rmRXUTFCr7MINiG0qQW0HS00meHxV3i1EUlFYyKWpRv4/XH+dh/yQ2Zy3nyssVYEFA==
X-Received: by 2002:a1f:3815:: with SMTP id f21-v6mr4616630vka.110.1533919779833;
        Fri, 10 Aug 2018 09:49:39 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id n9-v6sm1506813uap.37.2018.08.10.09.49.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 09:49:38 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id g18-v6so2539162uam.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 09:49:38 -0700 (PDT)
X-Received: by 2002:a1f:ebc7:: with SMTP id j190-v6mr4588442vkh.114.1533919778343;
 Fri, 10 Aug 2018 09:49:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 09:49:37 -0700 (PDT)
In-Reply-To: <c1bc416ba407b5a3cc098e78a529752e@codeaurora.org>
References: <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org>
 <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
 <20180522173000.GG24776@sirena.org.uk> <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
 <20180524162940.GA4828@sirena.org.uk> <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
 <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org> <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
 <20180810105205.GC20971@sirena.org.uk> <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
 <20180810161329.GF20971@sirena.org.uk> <c1bc416ba407b5a3cc098e78a529752e@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 10 Aug 2018 09:49:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Us65kRtn6wtc+cr-ws0b1vYwARbqt0yY+T2BdSFPnfcg@mail.gmail.com>
Message-ID: <CAD=FV=Us65kRtn6wtc+cr-ws0b1vYwARbqt0yY+T2BdSFPnfcg@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based QUP
To:     Dilip Kota <dkota@codeaurora.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Mahadevan, Girish" <girishm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 10, 2018 at 9:29 AM,  <dkota@codeaurora.org> wrote:
> Here are my couple of cents:
> SPI controller maximum frequency can be lesser than or equal to Clock
> framework's maximum
> frequency, so should not rely on the Clock framework.

You could make that argument on other SoCs perhaps, but from what I've
seen in Qualcomm clock drivers there is a hardcoded frequency plan
that takes into account how fast the IP blocks can go.

-Doug
