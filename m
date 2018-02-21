Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbeBUXw4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 18:52:56 -0500
Received: from mail-yb0-f193.google.com ([209.85.213.193]:37393 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeBUXwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 18:52:53 -0500
X-Google-Smtp-Source: AH8x225hnuERD7nZEG8PoHjTM1ojmb+jVy1Eb861kxW9F+JzKNGWSYYV+W4vtpmwd5TxItSdw673OyF7ug8q0A2en1M=
MIME-Version: 1.0
In-Reply-To: <20180219224602.22582-1-enric.balletbo@collabora.com>
References: <20180219224602.22582-1-enric.balletbo@collabora.com>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Wed, 21 Feb 2018 15:52:31 -0800
X-Google-Sender-Auth: dsLSNMw5ruQ8wtRzGkgQrR3ppN8
Message-ID: <CAMHSBOUTrkyANDovR1eV4c80ci2hf3tm+0rPTijojHuBm-gH2g@mail.gmail.com>
Subject: Re: [PATCH 1/6] mfd: cros_ec: fail early if we cannot identify the EC
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Vincent Palatin <vpalatin@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 2:46 PM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> From: Vincent Palatin <vpalatin@chromium.org>
>
> If we cannot communicate with the EC chip to detect the protocol version
> and its features, it's very likely useless to continue. Else we will
> commit all kind of uninformed mistakes (using the wrong protocol, the
> wrong buffer size, mixing the EC with other chips).
>
> Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
> Acked-by: Benson Leung <bleung@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/mfd/cros_ec.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index d61024141e2b..74780f2964a1 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -112,7 +112,11 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>
>         mutex_init(&ec_dev->lock);
>
> -       cros_ec_query_all(ec_dev);
> +       err = cros_ec_query_all(ec_dev);
> +       if (err) {
> +               dev_err(dev, "Cannot identify the EC: error %d\n", err);
> +               return err;
> +       }
>
>         if (ec_dev->irq) {
>                 err = request_threaded_irq(ec_dev->irq, NULL, ec_irq_thread,
> --
> 2.16.1
>
