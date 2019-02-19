Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A57AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BC0217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kt4nWEAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfBSGx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 01:53:26 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39111 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfBSGxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 01:53:25 -0500
Received: by mail-ua1-f67.google.com with SMTP id s15so6616846uap.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 22:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fEC0UJVun7Q0xDcH2zWhxgRlJel+8ot+VopWHEdCBK0=;
        b=Kt4nWEAw8uOpMBObDVTyR+ho4BllPTa4frLEVvmQ6a7KHJN7bOEuPE7SGM8mgYQJh5
         Tjjdn8IgVdUUG1ao9MU9k8BuxYtsTnlzvwV7p4giUMlTaNIllIeafqYwxyyfVpogJ45f
         7KUd0vrNOWDwk/bZXBkhFhKUOnvRocS8F78n9IIP87eY23GRS1HhOUib5VUYNjCkVL64
         NMmUGCsrqRcIGnucG32poqGRfvQTfMUPmFrYhN/fRXVUXB1SpGx+EL/REKrwX+0MFhdr
         W5h0m6WuOQ0AUiu9LTuPizabW9VOj4AGbEK8mTC0gqwM7CW4cfTV0sq+tK1eTnjUuxL2
         vYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fEC0UJVun7Q0xDcH2zWhxgRlJel+8ot+VopWHEdCBK0=;
        b=kvpDex6ES21ZDHRXC2dxwtJeJrmrWODBztun8V+IQMNLNJYxW6/hLKTAdftz0RZyJe
         8C4M02GnXdODBHjyEYOC3MSInisRnESM/ucfqVRuQhrhhInek7S4rIcnSX5I0v8zxdla
         ND21f1JD9NES1uRoZ/fYXXzBicCyN1xlodDZzbwd/j2CDv5AGcAamW0wYKhLjFEcyiNX
         n9ZptPNuSsJLxc1VxIOEXtUUhvJ74A63Ov+GdW1Z6qg4uUd34H1DyDif6n6Op0EQPBFE
         ZToK72TgiY1zM2rcZAiei7cMyggfqrzJgDZIT/NT+2SUkA1ClODzjHc6RKQClWpbpu9x
         oZXA==
X-Gm-Message-State: AHQUAuY8Co6SIKstif1mj94STT8N8mACUTc3+/6qtFAEVtiuMmmtxL3Q
        rMysUPsseFgScdq2JXiGjOpi+F3jHGo56zFUqR0VPQ==
X-Google-Smtp-Source: AHgI3IYlMa+h0hBroUuk5YGHMuq4wRGUgiXzaFT67S5GGlYwJx4vbKvAxirUlh4ImzZbJtjNUwPI614gI5OVgD/5XL4=
X-Received: by 2002:ab0:b8:: with SMTP id 53mr5380382uaj.33.1550559203692;
 Mon, 18 Feb 2019 22:53:23 -0800 (PST)
MIME-Version: 1.0
References: <20190219063302.22888-1-yuehaibing@huawei.com>
In-Reply-To: <20190219063302.22888-1-yuehaibing@huawei.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 19 Feb 2019 12:23:12 +0530
Message-ID: <CAFA6WYNKYkOj9Mv3ceG4G=mox2RWgSNEkywtLxLKHUn3i4eYoA@mail.gmail.com>
Subject: Re: [PATCH -next] hwrng: Fix unsigned comparison with less than zero
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 at 12:04, YueHaibing <yuehaibing@huawei.com> wrote:
>
> The return from the call to tee_client_invoke_func can be a
> negative error code however this is being assigned to an
> unsigned variable 'ret' hence the check is always false.
> Fix this by making 'ret' an int.
>
> Detected by Coccinelle ("Unsigned expression compared with zero:
> ret < 0")
>
> Fixes: 5fe8b1cc6a03 ("hwrng: add OP-TEE based rng driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

> ---
>  drivers/char/hw_random/optee-rng.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/optee-rng.c
> index 2b9fc8a..e9f4e10 100644
> --- a/drivers/char/hw_random/optee-rng.c
> +++ b/drivers/char/hw_random/optee-rng.c
> @@ -73,7 +73,7 @@ struct optee_rng_private {
>  static size_t get_optee_rng_data(struct optee_rng_private *pvt_data,
>                                  void *buf, size_t req_size)
>  {
> -       u32 ret = 0;
> +       int ret = 0;
>         u8 *rng_data = NULL;
>         size_t rng_size = 0;
>         struct tee_ioctl_invoke_arg inv_arg = {0};
> @@ -172,7 +172,7 @@ static struct optee_rng_private pvt_data = {
>
>  static int get_optee_rng_info(struct device *dev)
>  {
> -       u32 ret = 0;
> +       int ret = 0;
>         struct tee_ioctl_invoke_arg inv_arg = {0};
>         struct tee_param param[4] = {0};
>
> --
> 2.7.0
>
>
