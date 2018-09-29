Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDE7C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 00:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5ABF2073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 00:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IoOgkxbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5ABF2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeI2GpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 02:45:15 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46409 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeI2GpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 02:45:14 -0400
Received: by mail-vs1-f66.google.com with SMTP id t21-v6so4575070vso.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 17:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gMHyU/2rVS2rVaT2Mvuic0wzkY6wrvKjTTOWzTehV/o=;
        b=IoOgkxbgbKzjJeeuxfyqmSUzjrTQrFyTgwp3hyeks9bt2mla88qkjGuxVYsjWxyKxP
         k6zAcKsCHZBRw5mkagSJNeNsPO0u8PsEjAQhS6n/loxt3eytqMtytiJeeI8dYLf9IBay
         lYF/1q0qF83b8TCxZ0FPJshwQXXZmYgaYMe1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gMHyU/2rVS2rVaT2Mvuic0wzkY6wrvKjTTOWzTehV/o=;
        b=HupY6Lwhe9eCbM49Z0ESf3bf/9ghFDJcLCTgqJSUNt3T31EnkddFpnojbr+wFFFsHt
         mPzVLvUOduLY0XJN/S2j9tLwAP1nrdZiszhjakmD5cHYYbt+sCvFmM+lPTJtxEXNbBzH
         JMzibYKXEwJpqTuZnE/Diai/S5idPKLtz+HFLPqmA6qXLDhvjKeTZqYzc3TLncMtjeVo
         wpgAzCxh95zZx/EFns0cpJ7G5iPl5k0RvmyAbSboXgieqiOmbgsT++9FyJweO8zGfeiI
         qn7miB5EEYBC6LffsLWZ+ys/M2PRw4Qtgwqglx43hMk6U3e9i0rS/bWcPQFcPNeIQ5tG
         EmCw==
X-Gm-Message-State: ABuFfoh8eSg53HVwTk7ZfJfh+e7Rgny4Ht86GCkHvvBOmq1p+TnFotMD
        TodInqMZ1qov5Pm+10nObPBHldJwFUU=
X-Google-Smtp-Source: ACcGV61VChfwxG0PZ3gYtUAxnu4hXTk0UCUTtD7DfKXxMl0bbcyyacoCL+rH/tpR/OpKeb9wxJwW9Q==
X-Received: by 2002:a67:4581:: with SMTP id z1-v6mr449379vsf.45.1538180341885;
        Fri, 28 Sep 2018 17:19:01 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 72-v6sm7002620uas.19.2018.09.28.17.19.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 17:19:00 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id i23-v6so4225133vsj.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 17:19:00 -0700 (PDT)
X-Received: by 2002:a67:7949:: with SMTP id u70-v6mr459646vsc.119.1538180340315;
 Fri, 28 Sep 2018 17:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180926205204.184898-1-ryandcase@chromium.org>
 <20180926205204.184898-2-ryandcase@chromium.org> <153803059441.119890.891880266219521584@swboyd.mtv.corp.google.com>
 <CACjz--=Qj8Jd9yCvox1MGh1PFkHAzpt1L0OwPkMhtV30_jCDWA@mail.gmail.com>
In-Reply-To: <CACjz--=Qj8Jd9yCvox1MGh1PFkHAzpt1L0OwPkMhtV30_jCDWA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 28 Sep 2018 17:18:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VY_BvyQywUQMwTuRw=Niq0JMaaJQNrpsGiNF8kt_Wsww@mail.gmail.com>
Message-ID: <CAD=FV=VY_BvyQywUQMwTuRw=Niq0JMaaJQNrpsGiNF8kt_Wsww@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] spi: Introduce new driver for Qualcomm QuadSPI controller
To:     ryandcase@chromium.org
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Trent Piepho <tpiepho@impinj.com>, boris.brezillon@bootlin.com,
        Girish Mahadevan <girishm@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 28, 2018 at 11:20 AM Ryan Case <ryandcase@chromium.org> wrote:
> > > +       master->max_speed_hz = 300000000;
> > > +       master->num_chipselect = QSPI_NUM_CS;
> > > +       master->bus_num = pdev->id;
> >
> > Can this come from DT aliases? I've never thought about qspi and
> > "regular" spi being in the same spi bus numbering system, but I suppose
> > that will happen now and we need to make sure that qspi numbers start
> > after the regular ones?
>
> I'm not sure. Can look into it.

In a previous response for the other Qualcomm SPI driver Mark said to
set this to -1.  Specifically the code was checking the alias and Mark
said:

> Don't do this, just set bus_num to -1 and let the core assign an ID.

[1] https://lkml.kernel.org/r/20180503233849.GF13402@sirena.org.uk

-Doug
