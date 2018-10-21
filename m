Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C923ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 14:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F382086E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 14:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F382086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sunsite.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbeJUWZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 18:25:13 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40908 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbeJUWZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 18:25:13 -0400
Received: by mail-lf1-f66.google.com with SMTP id n3-v6so1532778lfe.7;
        Sun, 21 Oct 2018 07:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CdhV1/U4LJvWkVTErpGCM4NWA8Xt9FYe63YOaCMUVAo=;
        b=QeK8PbDbuU6wEAeaR7Qn4U7CkxUQOkJYMWh+wTqkRaEeTwbief5KpysxVuHkEGHQ2/
         zeGd3tG6qdgealNynv0EDm/EgpUAAZbr/Pn/CSa6fzhJWcGZg2ZiYfS5++PgngexWnbt
         cl+5vOtjrNtc1tyjGePfBgAzmck5PX7JsYlKixkC9+IThMsqcucoURpCRTTJPi5B7DKy
         RcvSYqEo4Q4iffGh23ifVGvJQzhI8xCRTAOOvJ1aQ2XAFJ4zk2GQmLewMXCNVFl1pQjd
         uxrVs6hpgbWtPKfqgoFKsJ9zhUqfdjhgwvBCWmqlJpJm9rOvN/o3C6XWY7Dw7k3U9bBq
         r8Sw==
X-Gm-Message-State: ABuFfojrHEDr05yauQAXkib2oj8hnruenLUwkP9m3LuXUKLtHSGE9ls4
        u/NodjFmQK6pEam85C4V3hZmS3ajbrvLi1M7/dqrINqH
X-Google-Smtp-Source: ACcGV60GEnMomLADHEJjBpRz8OOSthSP39GD3qDfEIkBewfPv/DWXdn7H0ZFBevkoCEe4/QaHtrAffj62lHOQFA7nII=
X-Received: by 2002:a19:8fce:: with SMTP id s75mr6963679lfk.151.1540131042326;
 Sun, 21 Oct 2018 07:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180625161303.7991-1-federico.vaga@cern.ch> <20180625161303.7991-2-federico.vaga@cern.ch>
In-Reply-To: <20180625161303.7991-2-federico.vaga@cern.ch>
From:   Peter Korsgaard <jacmet@sunsite.dk>
Date:   Sun, 21 Oct 2018 16:10:30 +0200
Message-ID: <CACXmVia0vStmBwd4ndFk6UjE9wGsjp7Y75ej0AGq68H8-XkZqw@mail.gmail.com>
Subject: Re: [PATCH 1/3] i2c:ocores: stop transfer on timeout
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 6:14 PM Federico Vaga <federico.vaga@cern.ch> wrote:

Hi, and sorry for the slow response.

> Detecting a timeout is ok, but we also need to assert a STOP command on
> the bus in order to prevent it from generating interrupts when there are
> no on going transfers.
>
> Example: very long transmission.
>
> 1. ocores_xfer: START a transfer
> 2. ocores_isr : handle byte by byte the transfer
> 3. ocores_xfer: goes in timeout [[bugfix here]]
> 4. ocores_xfer: return to I2C subsystem and to the I2C driver
> 5. I2C driver : it may clean up the i2c_msg memory
> 6. ocores_isr : receives another interrupt (pending bytes to be
>                 transferred) but the i2c_msg memory is invalid now
>
> So, since the transfer was too long, we have to detect the timeout and
> STOP the transfer.
>
> Another point is that we have a critical region here. When handling the
> timeout condition we may have a running IRQ handler. For this reason I
> introduce a spinlock. In the IRQ handler we can just use trylock because
> if the lock is taken is because we are in timeout, so there is no need to
> process the IRQ.
>
> Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> ---
>  drivers/i2c/busses/i2c-ocores.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
> index 88444ef74943..98c0ef74882b 100644
> --- a/drivers/i2c/busses/i2c-ocores.c
> +++ b/drivers/i2c/busses/i2c-ocores.c
> @@ -25,6 +25,7 @@
>  #include <linux/slab.h>
>  #include <linux/io.h>
>  #include <linux/log2.h>
> +#include <linux/spinlock.h>
>
>  struct ocores_i2c {
>         void __iomem *base;
> @@ -36,6 +37,7 @@ struct ocores_i2c {
>         int pos;
>         int nmsgs;
>         int state; /* see STATE_ */
> +       spinlock_t xfer_lock;
>         struct clk *clk;
>         int ip_clock_khz;
>         int bus_clock_khz;
> @@ -207,15 +209,30 @@ static void ocores_process(struct ocores_i2c *i2c)
>  static irqreturn_t ocores_isr(int irq, void *dev_id)
>  {
>         struct ocores_i2c *i2c = dev_id;
> +       unsigned long flags;
> +       int ret;
> +
> +       /*
> +        * We need to protect i2c against a timeout event (see ocores_xfer())
> +        * If we cannot take this lock, it means that we are already in
> +        * timeout, so it's pointless to handle this interrupt because we
> +        * are going to abort the current transfer.
> +        */
> +       ret = spin_trylock_irqsave(&i2c->xfer_lock, flags);

This is very old code, so I might be missing something - But I still
don't quite understand this trylock logic. If we end up here with the
lock taken, then that must mean that we are on SMP system. We still
need to ack the interrupt, so just spinning until the other CPU
releases the lock seems more sensible?

-- 
Bye, Peter Korsgaard
