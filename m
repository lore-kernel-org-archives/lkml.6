Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4366C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE302082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QHm7FJfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE302082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeJCBaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:30:11 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42316 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbeJCBaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:30:11 -0400
Received: by mail-vs1-f68.google.com with SMTP id w16-v6so1689392vso.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 11:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qjhNsFW4Qi2+zTgNK92VzJq5zVLk494kt0Y5jk6tpuw=;
        b=QHm7FJfAK6MnMuzFxau4TS8lglmqCg7x1SNiCZjL4RnbZ0vLHxhOmlfFetFLxafwil
         Pu0u3oeO4mbqgLGh+PhBYNT06LhhCKhc0SV5Jjvx0sL4buvy5oiaF5RPZ3flQDy0czRs
         /3bdisSH8KRDWlPYIYRgUIgot976gBjd53EmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qjhNsFW4Qi2+zTgNK92VzJq5zVLk494kt0Y5jk6tpuw=;
        b=qf+zfV242YedYudxvaARWbApSCJh2J9pkwwhTO6dQY7aoLGZXcHoYGc36IFnRF28sR
         DRcfZhe+8vRuf+6YBR/vOLqA0KxwxiqtDgS4q2hSf0qz96H0/alhEAjAJe19xLbeBIPD
         /KYtTeLNboeqUCzBiq28jgl2vwAluVQEHcfXJIBpCASHEddsszwyZtA2rL13kJRWPZ4o
         2fIsRGpwc83jfwK71rk8Xx9aHgZ+0Plnc3AFTEnouJwQuOtdQRY8egJWBWdtXoReWTEC
         Xow/y7/BMaJrJJzBMQtvaGjiRqjOFBKyAY5O5VqzznSVE4OeBcqFYQhyGoQj/2n5lEik
         VdhA==
X-Gm-Message-State: ABuFfogiB7x8WxyjZNyhMNBT9e7Klb89S5jogO/JSik//MI/G+t+sTKl
        6RRDinZ1qQ14/5eu7UJolgejTIeD+dE=
X-Google-Smtp-Source: ACcGV614voROFhr1YlLSVduc7nUDhDICDKxAm19tEW/ydmfz0pCv8Rj1YhpcHSq9asqB5dgcFEHIvQ==
X-Received: by 2002:a67:1a02:: with SMTP id a2mr6259893vsa.189.1538505924005;
        Tue, 02 Oct 2018 11:45:24 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id 17sm2395887uas.5.2018.10.02.11.45.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 11:45:23 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id m7so1116938uao.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 11:45:22 -0700 (PDT)
X-Received: by 2002:a9f:344d:: with SMTP id s13mr3664415uab.27.1538505922381;
 Tue, 02 Oct 2018 11:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181002013142.209751-1-ryandcase@chromium.org> <20181002013142.209751-2-ryandcase@chromium.org>
In-Reply-To: <20181002013142.209751-2-ryandcase@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 2 Oct 2018 11:45:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WxL8HO3qKMF_3DXXLCqOZh8FDFUyuvgDwhQGjVxUN7cQ@mail.gmail.com>
Message-ID: <CAD=FV=WxL8HO3qKMF_3DXXLCqOZh8FDFUyuvgDwhQGjVxUN7cQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] spi: Introduce new driver for Qualcomm QuadSPI controller
To:     ryandcase@chromium.org
Cc:     Mark Brown <broonie@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
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

On Mon, Oct 1, 2018 at 6:32 PM Ryan Case <ryandcase@chromium.org> wrote:
> +#include <asm/unaligned.h>

Don't need unaligned.h any more do you?


> +#define RD_FIFO_CFG            0x0028
> +#define CONTINUOUS_MODE                BIT(0)
> +
> +#define RD_FIFO_RESET          0x0030
> +#define RESET_FIFO             BIT(0)
> +
> +#define PIO_XFER_CFG           0x0018

nit: when you moved the bits next to the registers you reordered the
registers.  I would have expected 0x0018 to be above 0x0028 though.
Similar 0x0014 (below) should be above 0x0018.


> +#define CUR_MEM_ADDR           0x0048
> +#define HW_VERSION             0x004c
> +#define RD_FIFO                        0x0050
> +#define SAMPLING_CLK_CFG       0x0090
> +#define SAMPLING_CLK_STATUS    0x0094
> +
> +
> +

nit: one less blank line?


> +static int qspi_buswidth_to_iomode(struct qcom_qspi *ctrl,
> +                                  unsigned int buswidth)
> +{
> +       switch (buswidth) {
> +       case 1:
> +               return SDR_1BIT << MULTI_IO_MODE_SHFT;
> +       case 2:
> +               return SDR_2BIT << MULTI_IO_MODE_SHFT;
> +       case 4:
> +               return SDR_4BIT << MULTI_IO_MODE_SHFT;
> +       default:
> +               dev_warn_once(ctrl->dev,
> +                               "Unexpected bus width: %u\n", buswidth);
> +               return SDR_1BIT << MULTI_IO_MODE_SHFT;
> +       }

nit: now that this function is returning something that's shifted (and
so something in the format of a hardware register) it should return
u32.


> +       if (ctrl->xfer.dir == QSPI_WRITE) {
> +               if (int_status & WR_FIFO_EMPTY)
> +                       ret = pio_write(ctrl);
> +       } else if (ctrl->xfer.dir == QSPI_READ) {

I'd maybe just call this "else" not "else if".  "dir" can either be
read or write--there are no other options.


> +               if (int_status & RESP_FIFO_RDY)
> +                       ret = pio_read(ctrl);
> +       } else if (int_status & QSPI_ERR_IRQS) {

You can't have "else" here, especially since dir should either be
WRITE or READ you'll never end up here.  You should just always print
errors.


Everything else looks good and as far as I can tell Stephen's previous
feedback has been addressed.  So mostly just nits but the one bug is
that the checking for error interrupts is probably not working.

-Doug
