Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC029C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E59C2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0FkG8pVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E59C2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbeKTBjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:39:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:50796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729645AbeKTBjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:39:46 -0500
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF2D9208E3;
        Mon, 19 Nov 2018 15:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542640552;
        bh=fcktiDibKyuhlQazZwvcRVxnDb0AjSWYVP7iyYu31zw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0FkG8pVFa13Zezmy+vej/40N5WeKhkxkMFKxwtbFFIwexWtuhy7NmFnvlB/cEeS1R
         I3vZGuZu0CGrLYxueFZXdX7M8vSHTCqIVZ3lhFP4nISi0Si1eIdCrQ2eapRDYNKY6h
         LQexclkMeCO3qFOPVinzjlzeY14JFnwO1NI6FaP4=
Received: by mail-qk1-f172.google.com with SMTP id a132so49141979qkg.1;
        Mon, 19 Nov 2018 07:15:52 -0800 (PST)
X-Gm-Message-State: AGRZ1gLMg/Di8L1Wcxes2Of43jdf/Jcb+NNyVKC7k6amXxVWkr/JUjbm
        Qf9g3go7jX31trLUqwJqMR12bAncfBpbANiOlQ==
X-Google-Smtp-Source: AJdET5eDkl2fi7FJ+0d63GP06bBxxW8/j26lBtTdav39bI2yHzWa/QdbBf2zzz/V6FlCQH7Diu5QWCJD7cnDpgRMYbw=
X-Received: by 2002:ae9:c306:: with SMTP id n6mr21202183qkg.79.1542640551866;
 Mon, 19 Nov 2018 07:15:51 -0800 (PST)
MIME-Version: 1.0
References: <20181114150904.19653-1-johan@kernel.org> <20181114150904.19653-3-johan@kernel.org>
In-Reply-To: <20181114150904.19653-3-johan@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 19 Nov 2018 09:15:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLuF-t_Rf5Hh400=aeiLT_ahTfE0a_czZ6XRG-mD9xmig@mail.gmail.com>
Message-ID: <CAL_JsqLuF-t_Rf5Hh400=aeiLT_ahTfE0a_czZ6XRG-mD9xmig@mail.gmail.com>
Subject: Re: [PATCH 2/4] serdev: make synchronous write return bytes written
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 9:10 AM Johan Hovold <johan@kernel.org> wrote:
>
> Make the synchronous serdev_device_write() helper behave analogous to
> the asynchronous serdev_device_write_buf() by returning the number of
> bytes written (or rather buffered) also on timeout.
>
> This will allow drivers to distinguish the case where data was partially
> written from the case where no data was written.
>
> Also update the only two users that checked the return value.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/gnss/serial.c     |  2 +-
>  drivers/gnss/sirf.c       |  2 +-
>  drivers/tty/serdev/core.c | 12 ++++++++++--
>  3 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
> index 31e891f00175..def64b36d994 100644
> --- a/drivers/gnss/serial.c
> +++ b/drivers/gnss/serial.c
> @@ -65,7 +65,7 @@ static int gnss_serial_write_raw(struct gnss_device *gdev,
>
>         /* write is only buffered synchronously */
>         ret = serdev_device_write(serdev, buf, count, MAX_SCHEDULE_TIMEOUT);
> -       if (ret < 0)
> +       if (ret < 0 || ret < count)

The 2nd condition covers the 1st condition. Though I guess this will
all change anyways when you address the FIXME below.

>                 return ret;
>
>         /* FIXME: determine if interrupted? */
