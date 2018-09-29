Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C61C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 00:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD4220645
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 00:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UIErrrQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD4220645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeI2HLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 03:11:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43591 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeI2HLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 03:11:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id q19-v6so5551291pgn.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 17:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=lu3W8hNOf5vBJ0OSfSyTf2R0XqT5DQqqn4zskv6xfk8=;
        b=UIErrrQ9QQKYG+srjvfby5N0HLR3DEoCJvQEVChacsG7c89yRZ7w1DzUAiqGZ2BU18
         BKhOvsiCrx2iTWTx+KOHAQZXk+tGv8SOJsE6PeFFBawe0sKqjD5mbvWl5BzFR9gKfJOP
         b0JTfe6/kNDJ3mIFLWdFVKr8QyorIB1ICGyaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=lu3W8hNOf5vBJ0OSfSyTf2R0XqT5DQqqn4zskv6xfk8=;
        b=prrVm2yCKS+YrUsIVFUc2N+M0WoG0mqFOnruVERrMOas7kArNmpoY/IjVglajs2xsY
         eE2mn4llqNGsHxEUssopNwpIIyXYPC7/wJ7Iz1AZUzKT3SLtG5rnwU8WqP6DaGeQdG8q
         Ekxc58WhKTfvpBGDHZoS+Il+2vTbTHxs5qm7DiU6lTVNLdJfBKQoCyAIVLyc8UKgpmzC
         ccweqpGzmJjRsl6CWFJuxsnEWfoOVvGGQMbHnMge2E2gkNhpMwfnABXx2CGLNFrBya5c
         CQpGXobc9axBZ/TKpq+LL2cECh0cjxRtq87J5Tan/LmXjVrqgREDzrIjhXJfdBGDZ0h6
         4hGw==
X-Gm-Message-State: ABuFfohI6xksK8lE7BLUKwqDepD0/vzV0PZNDlcvB8SkHwFo+lt/fK01
        dxVKZLVUmBPz/bLEmIfoex7pX379BNc=
X-Google-Smtp-Source: ACcGV6095PzgIAh0zJFfyFrxSLv23j8M9l3u+20cc8h7bTeCePHekxTu3JpdxulL493I6+Qi7TLJHg==
X-Received: by 2002:a63:cd45:: with SMTP id a5-v6mr926048pgj.43.1538181926984;
        Fri, 28 Sep 2018 17:45:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id p3-v6sm10407876pfg.175.2018.09.28.17.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 17:45:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Ryan Case <ryandcase@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CACjz--=Qj8Jd9yCvox1MGh1PFkHAzpt1L0OwPkMhtV30_jCDWA@mail.gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Trent Piepho <tpiepho@impinj.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20180926205204.184898-1-ryandcase@chromium.org>
 <20180926205204.184898-2-ryandcase@chromium.org>
 <153803059441.119890.891880266219521584@swboyd.mtv.corp.google.com>
 <CACjz--=Qj8Jd9yCvox1MGh1PFkHAzpt1L0OwPkMhtV30_jCDWA@mail.gmail.com>
Message-ID: <153818192522.119890.9441387074333006354@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 2/2] spi: Introduce new driver for Qualcomm QuadSPI controller
Date:   Fri, 28 Sep 2018 17:45:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryan Case (2018-09-28 11:19:51)
> On Wed, Sep 26, 2018 at 11:43 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > Quoting Ryan Case (2018-09-26 13:52:04)
> > > From: Girish Mahadevan <girishm@codeaurora.org>
> > > +#include <asm/unaligned.h>
> > > +
> > > +#define AHB_MIN_HZ             9600000UL
> >
> > Is this used?
> =

> Nope. Do you want all currently unused defines removed or specifically th=
is
> one? I saw precedent in other drivers for defining registers/flags/values=
 of
> supported but unused functionality so I left these (big endian, DDR, ...).

I guess it's fine but I don't know if it will ever be used so remove it?
I'd leave the others if they help someone know what register bits exist.
That's usually how I handle it.

> =

> =

> > > +       speed_hz =3D slv->max_speed_hz;
> > > +       if (xfer->speed_hz)
> > > +               speed_hz =3D xfer->speed_hz;
> > > +
> > > +       ret =3D clk_set_rate(ctrl->clks[QSPI_CLK_CORE].clk, speed_hz =
* 4);
> >
> > Why 4? Is that related to the number of wires?
> =

> In normal operation the core clock should be running at 4x the rate of the
> transfer clock regardless of number of wires used.

Ok. Maybe add a comment so we understand that.

> =

> > > +                       put_unaligned(rd_fifo, word_buf++);
> > > +               }
> > > +               ctrl->xfer.rx_buf =3D word_buf;
> > > +       }
> > > +
> > > +       if (bytes_to_read) {
> > > +               byte_buf =3D ctrl->xfer.rx_buf;
> >
> > Does this need to move forward by words_to_read bytes so that the left
> > over bytes are tacked onto the end? Or this should be an else if
> > statement?
> =

> When the words block completes it updates the rx_buf location so it is al=
ready
> at the correct offset for bytes.
> =


Ok I see. Subtle!

