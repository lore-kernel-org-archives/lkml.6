Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBD5C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF01820827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZUsYaxda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF01820827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeKHMAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 07:00:13 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43376 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbeKHMAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 07:00:12 -0500
Received: by mail-io1-f68.google.com with SMTP id t81-v6so13512674iod.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 18:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csi6QKEF2b4SeReeT+7meXgfI+dHcf6fIMotUt4qfRk=;
        b=ZUsYaxdaGTfq5sTTB+1/e6FMGo5jg4bCNFiCwQV78qKBf7ch4uAJqOQRIZr5A7jpHw
         vgsVgJ39lhE3JFJFkdBxrb06DApDsGkm0W+D616/8E2BZod0JOuNAhcqK9i+1FCe+OnB
         tvp9lS8gBL82mLL3Zn92SQA2KREEbc8XrQ7VA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csi6QKEF2b4SeReeT+7meXgfI+dHcf6fIMotUt4qfRk=;
        b=J6pGVST/jv2udZ39u1Duxmamg9J3XgskckqNBSOEFkGoiEdrauOeXW/5ELIb8cv9A2
         bFLgts3CdCP5M2plqeFpU2ttnYCL6fwuOuSadALRZhiY4kCCm6JHEvI4hiB3Z5g0wvp/
         ODGl2Q42ts0v0wAfj9YDpl44gLn+eI0P55nA43rZelb27enksN2ehC+bicsXawL+hrai
         M7putx2LiBbqS3mPn/2p3ksp0WlkGp4mkBtmzBOScIiHoAyRqgTxnqlJVticT/AjfLu6
         Hf0F0wy3I1NX8mQ0Z91mL+SkTJxF0KHNzwymb1ysxYO3RrUSBduW++qG7XLIfEycztyT
         u07g==
X-Gm-Message-State: AGRZ1gI8YMSCsfNn/jBN/k1493Q71xybMjpH7LhQuanOXev3klBiRzxF
        flQbqRCJo6L+8D5nfDUrWLa9jcyyqrM=
X-Google-Smtp-Source: AJdET5dgfO72eZd33z9PVreQ8uRe4IAi8flmocNKAKc0Wya2i3CVuEXKq6IREvgRPBsn+jYQ6tcVHA==
X-Received: by 2002:a6b:bf44:: with SMTP id p65-v6mr2114016iof.225.1541644019760;
        Wed, 07 Nov 2018 18:26:59 -0800 (PST)
Received: from mail-it1-f179.google.com (mail-it1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id a134-v6sm1759889itc.33.2018.11.07.18.26.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 18:26:58 -0800 (PST)
Received: by mail-it1-f179.google.com with SMTP id k206-v6so26021455ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 18:26:57 -0800 (PST)
X-Received: by 2002:a02:c85:: with SMTP id 5-v6mr2554453jan.87.1541644017331;
 Wed, 07 Nov 2018 18:26:57 -0800 (PST)
MIME-Version: 1.0
References: <20181108013005.37362-1-briannorris@chromium.org>
In-Reply-To: <20181108013005.37362-1-briannorris@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 7 Nov 2018 18:26:45 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNJdbUNw3FX8HL7V2OFwkE8eqLnhHOt+CWELP2a_RzY8Q@mail.gmail.com>
Message-ID: <CA+ASDXNJdbUNw3FX8HL7V2OFwkE8eqLnhHOt+CWELP2a_RzY8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/chrome: fixup cros_ec_get_next_event() error codes
To:     bleung@chromium.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>, olof@lixom.net,
        Shawn N <shawnn@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, egranata@chromium.org,
        ravisadineni@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 5:30 PM Brian Norris <briannorris@chromium.org> wrote:
>
> cros_ec_get_next_event() is documented to return 0 for success and
> negative for errors. It currently returns negative for some errors, and
> non-negative (number of bytes received) for success (including some "no
> data available" responses as zero). This works out OK, because the
> callers were more or less ignoring the documentation, and only treating
> positive values as success (and indepdently checking the modification of
> 'wakeup').

Hmm, I realized there's a problem with this: I'd need to change
get_keyboard_state_event() too, if I want to do this right.

I think maybe it'll be better to leave this alone, and just fix up the
documentation and a few corner cases.

> This is difficult to reason about though, and it makes it harder to
> refactor cros_ec_get_next_event() without breaking its users. So
> instead, I
> (a) make cros_ec_get_next_event() match its documentation and
> (b) change the users to treat non-negative as success.
>
> This change tries to match a roughly similar pattern to
> cros_ec_cmd_xfer_status(), where most non-zero result codes are treated
> as an error -- in this case, all protocol errors (including
> EC_RES_UNAVAILABLE) are treated as "no data available."
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> This barely touches MFD code, but overall this series should probably go
> through the platform/chrome maintenance, IMO.
> ---
>  drivers/mfd/cros_ec.c                   |  4 ++--

I may end up dropping the MFD changes from the next version, so I
might drop Lee from the list too.

Everyone else...stay tuned for v2.

Thanks,
Brian

>  drivers/platform/chrome/cros_ec_lpc.c   |  2 +-
>  drivers/platform/chrome/cros_ec_proto.c | 13 ++++++++++---
>  3 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index fe6f83766144..807a5870198d 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -67,7 +67,7 @@ static irqreturn_t ec_irq_thread(int irq, void *data)
>         if (wake_event && device_may_wakeup(ec_dev->dev))
>                 pm_wakeup_event(ec_dev->dev, 0);
>
> -       if (ret > 0)
> +       if (ret >= 0)
>                 blocking_notifier_call_chain(&ec_dev->event_notifier,
>                                              0, ec_dev);
>         return IRQ_HANDLED;
> @@ -219,7 +219,7 @@ EXPORT_SYMBOL(cros_ec_suspend);
>  static void cros_ec_report_events_during_suspend(struct cros_ec_device *ec_dev)
>  {
>         while (ec_dev->mkbp_event_supported &&
> -              cros_ec_get_next_event(ec_dev, NULL) > 0)
> +              cros_ec_get_next_event(ec_dev, NULL) >= 0)



>                 blocking_notifier_call_chain(&ec_dev->event_notifier,
>                                              1, ec_dev);
>  }
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index e1b75775cd4a..292408eefe43 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -235,7 +235,7 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
>         struct cros_ec_device *ec_dev = data;
>
>         if (ec_dev->mkbp_event_supported &&
> -           cros_ec_get_next_event(ec_dev, NULL) > 0)
> +           cros_ec_get_next_event(ec_dev, NULL) >= 0)
>                 blocking_notifier_call_chain(&ec_dev->event_notifier, 0,
>                                              ec_dev);
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index b6fd4838f60f..49625836fdd6 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -541,8 +541,12 @@ static int get_next_event(struct cros_ec_device *ec_dev)
>         if (cmd_version == 1) {
>                 ret = get_next_event_xfer(ec_dev, msg, cmd_version,
>                                 sizeof(struct ec_response_get_next_event_v1));
> -               if (ret < 0 || msg->result != EC_RES_INVALID_VERSION)
> +               if (ret < 0)
>                         return ret;
> +               if (msg->result == EC_RES_SUCCESS)
> +                       return 0;
> +               if (msg->result != EC_RES_INVALID_VERSION)
> +                       return -ENODATA;
>
>                 /* Fallback to version 0 for future send attempts */
>                 cmd_version = 0;
> @@ -550,8 +554,11 @@ static int get_next_event(struct cros_ec_device *ec_dev)
>
>         ret = get_next_event_xfer(ec_dev, msg, cmd_version,
>                                   sizeof(struct ec_response_get_next_event));
> -
> -       return ret;
> +       if (ret < 0)
> +               return ret;
> +       if (msg->result != EC_RES_SUCCESS)
> +               return -ENODATA;
> +       return 0;
>  }
>
>  static int get_keyboard_state_event(struct cros_ec_device *ec_dev)
> --
> 2.19.1.930.g4563a0d9d0-goog
>
