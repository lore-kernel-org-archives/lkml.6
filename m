Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A126C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE22A2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EllzHqvi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE22A2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeI2ApD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:45:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46836 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeI2ApC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:45:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id h22-v6so7603633qtr.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LcKmU7L+xBx0pBdhtJyMkoX3aJB7gK2IFsKoZuZ4G2o=;
        b=EllzHqviTOTomyNkep9PH15pjXWKPAJAfkV9tztBHpEgJjzTP9O42Ih2+/+3pOFbsg
         W/MpVC/KajS8rjW0f9TTOSMO8eSYIJz1oL7k63CCTrwaROtSlDdN34YY/ROIFCY1vZZF
         kWy/YCJo0ltpnKZdYoMdCEY3sPM8qk6JtZS00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LcKmU7L+xBx0pBdhtJyMkoX3aJB7gK2IFsKoZuZ4G2o=;
        b=ioRuNavr4zLjr4uPkTo2H6fI3tJykwOCD3VFIKjc3c+ncovyWk401ZnBl3gywM0+On
         BBt3jzRMSZh2JP3FAqOigY1GkN972gdR9LHtl9hbsT9DYFrxUjy0oCQmjrtYBlHrf+VY
         Rz1DYpvwh7b3Ldx34kpFgD5aprwrlwvSWdizICXAgcXy9rgyct3L7Xtf6FuuiUEDiNNG
         tIAO+Kswm53z1Jq5MD4sfbYuM5KO214XecKERFGf4q6BSnGVoj9jiO44GZ1AzURYI20d
         mLVsp/akmmzf1NoZvv140PtSzOCBH1kJOm8IWOvWclQHGfpqmZN1icnQ8jDC+OFpiXhD
         N+qg==
X-Gm-Message-State: ABuFfogfOvoRTOYSjRfJMfMsmgAT47Nonz+M4v4/EYn7m9hkKWrsfUXG
        xiucAW08FQLWNFqTT1CrySno6lu5wgPJy2KZED2V6g==
X-Google-Smtp-Source: ACcGV62UJI1ojCXjTIlG1FKItuy7iG3uUcuqrji77E2oFGbeJGFYf2eEvo8EbPE6kqZ400304BOG8v65FV1ZkW/SVzY=
X-Received: by 2002:ac8:1019:: with SMTP id z25-v6mr13780167qti.25.1538158802236;
 Fri, 28 Sep 2018 11:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180926205204.184898-1-ryandcase@chromium.org>
 <20180926205204.184898-2-ryandcase@chromium.org> <153803059441.119890.891880266219521584@swboyd.mtv.corp.google.com>
In-Reply-To: <153803059441.119890.891880266219521584@swboyd.mtv.corp.google.com>
From:   Ryan Case <ryandcase@chromium.org>
Date:   Fri, 28 Sep 2018 11:19:51 -0700
Message-ID: <CACjz--=Qj8Jd9yCvox1MGh1PFkHAzpt1L0OwPkMhtV30_jCDWA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] spi: Introduce new driver for Qualcomm QuadSPI controller
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Trent Piepho <tpiepho@impinj.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 11:43 PM Stephen Boyd <swboyd@chromium.org> wrote:
> Quoting Ryan Case (2018-09-26 13:52:04)
> > From: Girish Mahadevan <girishm@codeaurora.org>
> > +#include <asm/unaligned.h>
> > +
> > +#define AHB_MIN_HZ             9600000UL
>
> Is this used?

Nope. Do you want all currently unused defines removed or specifically this
one? I saw precedent in other drivers for defining registers/flags/values of
supported but unused functionality so I left these (big endian, DDR, ...).


> > +       speed_hz = slv->max_speed_hz;
> > +       if (xfer->speed_hz)
> > +               speed_hz = xfer->speed_hz;
> > +
> > +       ret = clk_set_rate(ctrl->clks[QSPI_CLK_CORE].clk, speed_hz * 4);
>
> Why 4? Is that related to the number of wires?

In normal operation the core clock should be running at 4x the rate of the
transfer clock regardless of number of wires used.

> > +                       put_unaligned(rd_fifo, word_buf++);
> > +               }
> > +               ctrl->xfer.rx_buf = word_buf;
> > +       }
> > +
> > +       if (bytes_to_read) {
> > +               byte_buf = ctrl->xfer.rx_buf;
>
> Does this need to move forward by words_to_read bytes so that the left
> over bytes are tacked onto the end? Or this should be an else if
> statement?

When the words block completes it updates the rx_buf location so it is already
at the correct offset for bytes.

> > +
> > +       master->max_speed_hz = 300000000;
> > +       master->num_chipselect = QSPI_NUM_CS;
> > +       master->bus_num = pdev->id;
>
> Can this come from DT aliases? I've never thought about qspi and
> "regular" spi being in the same spi bus numbering system, but I suppose
> that will happen now and we need to make sure that qspi numbers start
> after the regular ones?

I'm not sure. Can look into it.

>
> > +       master->dev.of_node = pdev->dev.of_node;
> > +       master->mode_bits = SPI_MODE_0 |
> > +                           SPI_TX_DUAL | SPI_RX_DUAL |
> > +                           SPI_TX_QUAD | SPI_RX_QUAD;
> > +       master->flags = SPI_MASTER_HALF_DUPLEX;
> > +       master->prepare_message = qcom_qspi_prepare_message;
> > +       master->transfer_one = qcom_qspi_transfer_one;
