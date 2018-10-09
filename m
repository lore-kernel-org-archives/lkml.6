Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267BFC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C4A213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HPmfd+aj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C4A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeJIX3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:29:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44732 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbeJIX3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:29:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id g2-v6so1031784pgu.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=1y5p9Odrxdk4dikh1SyZD0JhPP23jfvmQAWmeNz0h7o=;
        b=HPmfd+aj0ScRFHvp3GAfACDrMAuAidWvFkdUeDFKmZpnlrXadWzliMx351/6fe3KbP
         sAV1J8xpEDZkEUADOmFYQpYMhOMnOtpj5Zc4lsrEpNhB4EoxRZ+ba2o6zExozXT8G9ns
         a88NnfbR5og4iv4fqo4Q7ljHDVRW3LDbQ9mJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=1y5p9Odrxdk4dikh1SyZD0JhPP23jfvmQAWmeNz0h7o=;
        b=LvgHcTDnqCnmHzR5W2gG9QpmLePbidoMipStijFmz9dhOSg9DvbmC12cHPkfMwIvbH
         YlDUBRP/5ID0lrNkjjRyvAnwZnKLQXSG0Mx6HDwUhsdGKFLwbYA2DD4csd8hP2DSiu52
         jul6diJIQbkpip9bQcxlgmqGigyor+g6jG3l+P+PCJhhGM+qQJqFOclkyj9aPt3opEJV
         dleAvtTHxJzYiGJ0cQg0BaKbsY/DURDx0N3Acb/fY/Z1hOL5IdiMwOK5wuOsyeu9CpRU
         bOScfBrV/DLfNbkX7hO1Vm2Bye0qBsxxFFqYabbPxwB5BjP/T554CQ3U79XVBDwLrDuG
         K2BA==
X-Gm-Message-State: ABuFfohagkJZHsbUe4u7FC/v9vTLJ8d/eX8BKgcSSSRmRMLeIxAKLMSC
        YfrZaIKm0ZIMVxZYw26BQCsUmw==
X-Google-Smtp-Source: ACcGV62OYwcli75E382I+kVhLL3P+cEmkpgQqr5IarviEOO+yoXKfkhW2HZoIFHQkZ/YLjolEgwloA==
X-Received: by 2002:a62:b286:: with SMTP id z6-v6mr31215534pfl.79.1539101527440;
        Tue, 09 Oct 2018 09:12:07 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id o9-v6sm33484092pgn.30.2018.10.09.09.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:12:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Doug Anderson <dianders@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CAD=FV=XnYucy4JmgATrB89RYHTbzRC_GaouaRjHAocD4-H0ncg@mail.gmail.com>
Cc:     alokc@codeaurora.org, Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>
References: <1538574265-30235-1-git-send-email-alokc@codeaurora.org>
 <1538574265-30235-4-git-send-email-alokc@codeaurora.org>
 <153904219713.119890.7463642233895152532@swboyd.mtv.corp.google.com>
 <CAD=FV=XnYucy4JmgATrB89RYHTbzRC_GaouaRjHAocD4-H0ncg@mail.gmail.com>
Message-ID: <153910152600.119890.14820584405992384926@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V5 3/3] spi: spi-geni-qcom: Add SPI driver support for GENI based
 QUP
Date:   Tue, 09 Oct 2018 09:12:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2018-10-08 16:52:36)
> Hi,
> =

> On Mon, Oct 8, 2018 at 4:43 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > +       mas->irq =3D platform_get_irq(pdev, 0);
> > > +       if (mas->irq < 0) {
> > > +               ret =3D mas->irq;
> > > +               dev_err(&pdev->dev, "Err getting IRQ %d\n", ret);
> > > +               goto spi_geni_probe_runtime_disable;
> > > +       }
> >
> > Nitpick: If you got the irq earlier before allocating anything then not=
hing has
> > to be put on failure path.
> =

> I think this might have been in response to previous feedback from you
> suggesting that we should get the irq as late as possible.  Ah, here
> ya go:
> =

> https://lkml.kernel.org/r/153780767551.119890.9339380838620508307@swboyd.=
mtv.corp.google.com

Yes I suggested we register for the irq as last as possible, but I
didn't suggest calling platform_get_irq() this late. It could be called
earlier so that if there isn't any irq then nothing to do besides return
failure.

