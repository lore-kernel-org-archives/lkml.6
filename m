Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC81ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 14:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367B820843
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 14:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367B820843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sunsite.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeJUWxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 18:53:54 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43544 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbeJUWxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 18:53:54 -0400
Received: by mail-lf1-f67.google.com with SMTP id p34-v6so28420026lfg.10;
        Sun, 21 Oct 2018 07:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=plgtVOh6mlQqij48pa91e53Tg92qvHACqua4eBtVyVQ=;
        b=ZVqpyEVSCJA0uoeh3iAlEd++ODAIOeEkB8lOpEcAX9NJAWOVMBF7edzjEm9yETkKpg
         Ajuw+P4Sib+WXgv90rY1q4uiC4XRjjma+Sywc9ZrQo+v0G0/qfG/dNpDYosfdxT1ps5n
         E9b9kxggmu/pwGF3RVXG5GrEsR+UWwjTNItl0ZgjOvsGn/5aw2fkibhubsXXPhftjRHN
         1B4HN25OxSrfaW8lgw0jfHSajC0o4lm8rYpkDWb4AOPrFZ2SXKMAfAzZW+AKOA5JSnGO
         T4WPHiuFrR0ukmKFVpFCk0Jqrq5eFwv4v3Nzqjr10GqGpHE6Y2CLu7kxZnh6QhwGkqtF
         u0zw==
X-Gm-Message-State: ABuFfoi6X1WWcOsPAE1d/jxBev5LcPgquqgzunuzfMt5/xctkE2t33Ww
        XuIc9Dk0U3U6AOrMSDo4ijlekGxqCmo+GDa9HVFR0uIYn5U=
X-Google-Smtp-Source: ACcGV60O3yu9IQ4hmlgz7rvFeRU37OJ/qR0TR6gLRBJXasRpVdWIGnpxKjY9DSUejEjEimRcjkBM2OO9Y3kId1vw6eA=
X-Received: by 2002:a19:9d8d:: with SMTP id g135-v6mr7614204lfe.3.1540132758439;
 Sun, 21 Oct 2018 07:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180625161303.7991-1-federico.vaga@cern.ch> <20180625161303.7991-4-federico.vaga@cern.ch>
In-Reply-To: <20180625161303.7991-4-federico.vaga@cern.ch>
From:   Peter Korsgaard <jacmet@sunsite.dk>
Date:   Sun, 21 Oct 2018 16:39:07 +0200
Message-ID: <CACXmViZK=4dXYN-399=U6UDJDv4NuTQ2LHEfgh8UbeUJLJp_QQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] i2c:ocores: add polling interface
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 6:14 PM Federico Vaga <federico.vaga@cern.ch> wrote:
>
> This driver assumes that an interrupt line is always available for
> the I2C master. This is not always the case and this patch adds support
> for a polling version based on workqueue.

It probably makes sense to make it the switch between irq/irqless mode
dynamic to support the upcoming master_xfer_irqless logic.

> Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> ---
>  drivers/i2c/busses/i2c-ocores.c | 94 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 79 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
> index 274d6eb22a2c..0dad1a512ef5 100644
> --- a/drivers/i2c/busses/i2c-ocores.c
> +++ b/drivers/i2c/busses/i2c-ocores.c
> @@ -13,6 +13,7 @@
>   */
>
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -26,14 +27,19 @@
>  #include <linux/io.h>
>  #include <linux/log2.h>
>  #include <linux/spinlock.h>
> +#include <linux/workqueue.h>
> +
> +#define OCORES_FLAG_POLL BIT(0)
>
>  struct ocores_i2c {
>         void __iomem *base;
>         u32 reg_shift;
>         u32 reg_io_width;
> +       unsigned long flags;
>         wait_queue_head_t wait;
>         struct i2c_adapter adap;
>         struct i2c_msg *msg;
> +       struct work_struct xfer_work;
>         int pos;
>         int nmsgs;
>         int state; /* see STATE_ */
> @@ -166,8 +172,9 @@ static void ocores_process(struct ocores_i2c *i2c, u8 stat)
>                         oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
>                         return;
>                 }
> -       } else
> +       } else {
>                 msg->buf[i2c->pos++] = oc_getreg(i2c, OCI2C_DATA);
> +       }

This looks unrelated to $SUBJECT.

>
>         /* end of msg? */
>         if (i2c->pos == msg->len) {
> @@ -232,6 +239,50 @@ static irqreturn_t ocores_isr(int irq, void *dev_id)
>         return IRQ_HANDLED;
>  }
>
> +
> +/**
> + * It waits until is possible to process some data

Please don't use "It waits ..", but rather "wait until ..". Same for
the other function comments.


> + * @i2c: ocores I2C device instance
> + *
> + * This is used when the device is in polling mode (interrupts disabled).
> + * It sleeps for the time necessary to send 8bits (one transfer over
> + * the I2C bus), then it permanently ping the ip-core until is possible
> + * to process data. The idea is that we sleep for most of the time at the
> + * beginning because we are sure that the ip-core is not ready yet.
> + */
> +static void ocores_poll_wait(struct ocores_i2c *i2c)
> +{
> +       int sleep_min = (8/i2c->bus_clock_khz) * 1000; /* us for 8bits */
> +       u8 loop_on;
> +
> +       usleep_range(sleep_min, sleep_min + 10);

Where does this 10 come from?

> +       if (i2c->state == STATE_DONE || i2c->state == STATE_ERROR)
> +               loop_on = OCI2C_STAT_BUSY;
> +       else
> +               loop_on = OCI2C_STAT_TIP;
> +       while (oc_getreg(i2c, OCI2C_STATUS) & loop_on)
> +               ;

How would an I2C transmission timeout be handled here?

> +}
> +
> +
> +/**
> + * It implements the polling logic
> + * @work: work instance descriptor
> + *
> + * Here we try to re-use as much as possible from the IRQ logic
> + */
> +static void ocores_work(struct work_struct *work)
> +{
> +       struct ocores_i2c *i2c = container_of(work,
> +                                             struct ocores_i2c, xfer_work);
> +       irqreturn_t ret;
> +
> +       do {
> +               ocores_poll_wait(i2c);
> +               ret = ocores_isr(-1, i2c);
> +       } while (ret != IRQ_NONE);

Might as well drop the negation, E.G. while (ret == IRQ_HANDLED);

> +}
> +
>  static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>  {
>         struct ocores_i2c *i2c = i2c_get_adapdata(adap);
> @@ -245,6 +296,9 @@ static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>         oc_setreg(i2c, OCI2C_DATA, i2c_8bit_addr_from_msg(i2c->msg));
>         oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
>
> +       if (i2c->flags & OCORES_FLAG_POLL)
> +               schedule_work(&i2c->xfer_work);
> +
>         if (wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
>                                (i2c->state == STATE_DONE), HZ)) {
>                 return (i2c->state == STATE_DONE) ? num : -EIO;
> @@ -264,7 +318,8 @@ static int ocores_init(struct device *dev, struct ocores_i2c *i2c)
>         u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
>
>         /* make sure the device is disabled */
> -       oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
> +       ctrl &= ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN);
> +       oc_setreg(i2c, OCI2C_CONTROL, ctrl);

This looks unrelated to $SUBJECT

>
>         prescale = (i2c->ip_clock_khz / (5 * i2c->bus_clock_khz)) - 1;
>         prescale = clamp(prescale, 0, 0xffff);
> @@ -277,12 +332,16 @@ static int ocores_init(struct device *dev, struct ocores_i2c *i2c)
>                 return -EINVAL;
>         }
>
> +

Here as well.

> @@ -538,6 +600,8 @@ static int ocores_i2c_remove(struct platform_device *pdev)
>  {
>         struct ocores_i2c *i2c = platform_get_drvdata(pdev);
>
> +       flush_scheduled_work();
> +

Why not cancel_work_sync(&i2c->xfer_work)?

-- 
Bye, Peter Korsgaard
