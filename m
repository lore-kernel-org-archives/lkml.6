Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7C4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADFD206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a+4bWHvq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfAOBKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 20:10:07 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38234 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfAOBKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 20:10:07 -0500
Received: by mail-vs1-f66.google.com with SMTP id x64so665454vsa.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 17:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ksB2ayFP/NTGxreAkGUO765puiXCtztQ2E4cR81tAWo=;
        b=a+4bWHvqVgoT2+J9wcncY04YXwWjQ6CcHOrcM+7nGJ+zcWz22HfEz7z87tvFk/k+WE
         JtqBiMhNUlegeE5/LZT6hv7SSJ0+GCFjzYSKqIZfJ/cQr1jecuLWSbmiEZg+vQkYBJ3r
         OiStdVrarKtAZw6qKPb02gE0K7LA+uVAT/iPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ksB2ayFP/NTGxreAkGUO765puiXCtztQ2E4cR81tAWo=;
        b=h59BJeBNaalUVYWRwh5GIH0I1PiS/56EHFtZW7SKgbwDra/k2+lPMvdXGCX0h4CSxj
         k56IKeTnmJsEJlJXXjMlBkRk8KSGnfcw3mzNFkGkwvYAOn9O2hoNDN1UwBfoXceplU4c
         8WZh9lOiM00KJzoHt8WTdQiY+YEJq9qC0mVtXkyteLMAXk7wP+BUcvwulaYQiAbeWthm
         VKEgzOqo0+m6ELvNQopzLCgfH1RcC1/92Nrt9zLhcAqO5+cZivbOiYVV5QKnkbSH6f4T
         BJoPYXtTMPCp2peDmHk5qsF9SVozaYqDzfZtRpdDwreSIAsAaZhNFhIG5abx6sCpLjA6
         yhKg==
X-Gm-Message-State: AJcUukdbcO/h4LITBTbrSH6jZvCJd2I3hrli8JhGt11+cCFwLm36OOyU
        VYOAP4zbHAPIeru9fK7pPOp/CK3vN1w=
X-Google-Smtp-Source: ALg8bN6C6oPQ2ClesQ5aZM3o5vVIOLagiF6cZEU2VJpLytUXfK5HCJxtB+axxITfxJSqjW/rJ2nKEw==
X-Received: by 2002:a67:3144:: with SMTP id x65mr620662vsx.186.1547514604963;
        Mon, 14 Jan 2019 17:10:04 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id c11sm528694vsd.9.2019.01.14.17.10.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 17:10:04 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id u19so376952uae.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 17:10:03 -0800 (PST)
X-Received: by 2002:ab0:6151:: with SMTP id w17mr572886uan.114.1547514603506;
 Mon, 14 Jan 2019 17:10:03 -0800 (PST)
MIME-Version: 1.0
References: <20190112152844.26550-1-w@1wt.eu> <20190112152844.26550-8-w@1wt.eu>
In-Reply-To: <20190112152844.26550-8-w@1wt.eu>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 14 Jan 2019 17:09:52 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+=ZdFzSoZy3ct+POumC7mkK57wtFe+RXhnmUCJ6cETjg@mail.gmail.com>
Message-ID: <CAGXu5j+=ZdFzSoZy3ct+POumC7mkK57wtFe+RXhnmUCJ6cETjg@mail.gmail.com>
Subject: Re: [PATCH 8/8] spi: dw: change snprintf to scnprintf for possible overflow
To:     Willy Tarreau <w@1wt.eu>
Cc:     Silvio Cesare <silvio.cesare@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 7:28 AM Willy Tarreau <w@1wt.eu> wrote:
>
> From: Silvio Cesare <silvio.cesare@gmail.com>
>
> Change snprintf to scnprintf. There are generally two cases where using
> snprintf causes problems.
>
> 1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
> In this case, if snprintf would have written more characters than what the
> buffer size (SIZE) is, then size will end up larger than SIZE. In later
> uses of snprintf, SIZE - size will result in a negative number, leading
> to problems. Note that size might already be too large by using
> size = snprintf before the code reaches a case of size += snprintf.
>
> 2) If size is ultimately used as a length parameter for a copy back to user
> space, then it will potentially allow for a buffer overflow and information
> disclosure when size is greater than SIZE. When the size is used to index
> the buffer directly, we can have memory corruption. This also means when
> size = snprintf... is used, it may also cause problems since size may become
> large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
> configuration.
>
> The solution to these issues is to use scnprintf which returns the number of
> characters actually written to the buffer, so the size variable will never
> exceed SIZE.
>
> Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Greg KH <greg@kroah.com>
> Signed-off-by: Willy Tarreau <w@1wt.eu>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>
> ---
>  drivers/spi/spi-dw.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index b705f2bdb8b9..008d52d37439 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -54,41 +54,41 @@ static ssize_t dw_spi_show_regs(struct file *file, char __user *user_buf,
>         if (!buf)
>                 return 0;
>
> -       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +       len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
>                         "%s registers:\n", dev_name(&dws->master->dev));
> -       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +       len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
>                         "=================================\n");
> -       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +       len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
>                         "CTRL0: \t\t0x%08x\n", dw_readl(dws, DW_SPI_CTRL0));
> -       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +       len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
>                         "CTRL1: \t\t0x%08x\n", dw_readl(dws, DW_SPI_CTRL1));
> -       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +       len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
>                         "SSIENR: \t0x%08x\n", dw_readl(dws, DW_SPI_SSIENR));
> -       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +       len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
>                         "SER: \t\t0x%08x\n", dw_readl(dws, DW_SPI_SER));
> -       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +       len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
>                         "BAUDR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_BAUDR));
> -       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +       len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
>                         "TXFTLR: \t0x%08x\n", dw_readl(dws, DW_SPI_TXFLTR));
> -       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +       len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
>                         "RXFTLR: \t0x%08x\n", dw_readl(dws, DW_SPI_RXFLTR));
> -       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +       len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
>                         "TXFLR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_TXFLR));
> -       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +       len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
>                         "RXFLR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_RXFLR));
> -       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +       len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
>                         "SR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_SR));
> -       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +       len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
>                         "IMR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_IMR));
> -       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +       len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
>                         "ISR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_ISR));
> -       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +       len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
>                         "DMACR: \t\t0x%08x\n", dw_readl(dws, DW_SPI_DMACR));
> -       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +       len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
>                         "DMATDLR: \t0x%08x\n", dw_readl(dws, DW_SPI_DMATDLR));
> -       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +       len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
>                         "DMARDLR: \t0x%08x\n", dw_readl(dws, DW_SPI_DMARDLR));
> -       len += snprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +       len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
>                         "=================================\n");
>
>         ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
> --
> 2.19.2
>


-- 
Kees Cook
