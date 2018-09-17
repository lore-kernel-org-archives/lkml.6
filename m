Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2DBECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE352147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="er5FRZhz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE352147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbeIQS1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:27:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbeIQS1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:27:19 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 397ED2147A;
        Mon, 17 Sep 2018 13:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537189205;
        bh=cyOd9xRfXngf+LId+Y+OLkh0sSSHZaCGH6RHI29NQEw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=er5FRZhzP6FR8V371SPRGfXvGXqN4kUTxMvV+8DxkH1uMiUlHFNT+rqB8Gbpf1+EX
         ExmUapqtfVHLD//m1WHXql/abck8Ais3aynpKJnkRXbkQVCZxU9fKDqLycFilM3mnN
         3swTD1I97XpN3BvzNeE0Kk/oEyM71zhp9L97j1Qw=
Received: by mail-wr1-f42.google.com with SMTP id a108-v6so17190949wrc.13;
        Mon, 17 Sep 2018 06:00:05 -0700 (PDT)
X-Gm-Message-State: APzg51DGUWBRuv6UunA1X0nvFOSo5goFEejLyjnrl6XQkQNQRH+3lVUY
        cmcrz3oiWHySz5OX0GhcmY2T4rmwym0tFoTfIrE=
X-Google-Smtp-Source: ANB0VdZU80jpSazpFaB9P5zHWGxujTZpyF2Fr8jtcOpD5vzkWk4LexJG1AIkkBACYheBk6wru6lq4qPCJFDt61opx+E=
X-Received: by 2002:a05:6000:10d0:: with SMTP id b16mr18996315wrx.226.1537189203625;
 Mon, 17 Sep 2018 06:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20180913075857eucas1p2cbccf3cd452a23eb46a234acb37b3a44@eucas1p2.samsung.com>
 <1536825522-6027-1-git-send-email-c.manszewski@samsung.com> <20180913075857eucas1p2cbccf3cd452a23eb46a234acb37b3a44~T5q8CpLOD2420024200eucas1p24@eucas1p2.samsung.com>
In-Reply-To: <20180913075857eucas1p2cbccf3cd452a23eb46a234acb37b3a44~T5q8CpLOD2420024200eucas1p24@eucas1p2.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 17 Sep 2018 14:59:52 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfM-_qeSZ--B0YAYzgOAFbB0tFfr6M9iXM8JiVnKyymfA@mail.gmail.com>
Message-ID: <CAJKOXPfM-_qeSZ--B0YAYzgOAFbB0tFfr6M9iXM8JiVnKyymfA@mail.gmail.com>
Subject: Re: [PATCH 1/4] crypto: s5p-sss: Fix race in error handling
To:     c.manszewski@samsung.com
Cc:     linux-crypto@vger.kernel.org, vz@mleia.com,
        k.konieczny@partner.samsung.com, herbert@gondor.apana.org.au,
        davem@davemloft.net,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018 at 09:59, Christoph Manszewski
<c.manszewski@samsung.com> wrote:
>
> Remove a race condition introduced by error path in functions:
> s5p_aes_interrupt and s5p_aes_crypt_start. Setting the busy field of
> struct s5p_aes_dev to false made it possible for s5p_tasklet_cb to
> change the req field, before s5p_aes_complete was called.

Nice catch. Indeed the code looks racy.

>
> Change the first parameter of s5p_aes_complete to struct
> ablkcipher_request. Before spin_unlock, make a copy of the currently
> handled request, to ensure s5p_aes_complete function call with the
> correct request.
>
> Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
> ---
>  drivers/crypto/s5p-sss.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
> index faa282074e5a..0cf3f12d8f74 100644
> --- a/drivers/crypto/s5p-sss.c
> +++ b/drivers/crypto/s5p-sss.c
> @@ -475,9 +475,9 @@ static void s5p_sg_done(struct s5p_aes_dev *dev)
>  }
>
>  /* Calls the completion. Cannot be called with dev->lock hold. */
> -static void s5p_aes_complete(struct s5p_aes_dev *dev, int err)
> +static void s5p_aes_complete(struct ablkcipher_request *req, int err)
>  {
> -       dev->req->base.complete(&dev->req->base, err);
> +       req->base.complete(&req->base, err);
>  }
>
>  static void s5p_unset_outdata(struct s5p_aes_dev *dev)
> @@ -655,6 +655,7 @@ static irqreturn_t s5p_aes_interrupt(int irq, void *dev_id)
>  {
>         struct platform_device *pdev = dev_id;
>         struct s5p_aes_dev *dev = platform_get_drvdata(pdev);
> +       struct ablkcipher_request *req;
>         int err_dma_tx = 0;
>         int err_dma_rx = 0;
>         int err_dma_hx = 0;
> @@ -725,9 +726,10 @@ static irqreturn_t s5p_aes_interrupt(int irq, void *dev_id)
>                 if (err_dma_hx == 1)
>                         s5p_set_dma_hashdata(dev, dev->hash_sg_iter);
>
> +               req = dev->req;

In this path it should not be needed, so just
s5p_aes_complete(dev->req)? At this point dev->busy is true so
s5p_aes_handle_req() will exit before starting new tasklet. Also the
interrupt is an effect of finishing work by device scheduled in last
tasklet... so obviously no tasklet should be running.

>                 spin_unlock_irqrestore(&dev->lock, flags);
>
> -               s5p_aes_complete(dev, 0);
> +               s5p_aes_complete(req, 0);
>                 /* Device is still busy */
>                 tasklet_schedule(&dev->tasklet);
>         } else {
> @@ -755,8 +757,9 @@ static irqreturn_t s5p_aes_interrupt(int irq, void *dev_id)
>         if (err_dma_hx == 1)
>                 s5p_set_dma_hashdata(dev, dev->hash_sg_iter);
>
> +       req = dev->req;

Please put it before new line (so there will be new line before
unlock). Logically it should not be separated from other commands in
error path.

Best regards,
Krzysztof
