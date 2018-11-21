Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C8AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C77621479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FVFU6g5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C77621479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731765AbeKVDHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:07:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45436 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbeKVDHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:07:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id v6so6340404wrr.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 08:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tbWi/zS4gRmhuS+TuLe+neCy6A744+6S6a8Gx5sFG3g=;
        b=FVFU6g5Aoh8HYnzfpw1W3f8QLbUrlpNaO/KXEcv7t7Ba/wpC7DX5eb+cPT0C9ftdb6
         AsN4aouy9A+/m6e01hWODpOa6VnuGuhtozTZU8i+7odbMVR10j/nq1k4C4u+GkhoZMnj
         6phDwSkfAI9JzEIQSwu6Ivm+nL7dKWdVSGdXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tbWi/zS4gRmhuS+TuLe+neCy6A744+6S6a8Gx5sFG3g=;
        b=nk3ehEaJpkqZahphrb6GY96XLB1mgk3yUb/XiQGAihqDt3JgCpqXkxyIDxYvgM4pq2
         LQQHfJhlMapIbMB8jSzS6q5c+VPjFUmcFpT4jceXaIWtXVlhT1974VGHF0wshM1reEMA
         zqm3SmtPZ1qUQZga9yhWHmnCQ7pkV2rI4lhIeNEVYk0Z+e9E/aefInGj1WxlQKYRwn5I
         i0Qwq3mJd0I7AJxd0yg+ferI6dn8iej03C+dh9RwxiGD7b2AnD4a5aUrXFviYY9x49dP
         Y/3ih3E1/r9+5/mbZMNX+LcXh2gBxY7DkLAxsoOPGxSraWi933jD2uXsoub2AwIFSlRU
         0HYw==
X-Gm-Message-State: AA+aEWaOJMD9LeRyix79PmFJuct/puV18xHLsY1ETRuIT2i7Y6WoHZAk
        BJ9tOwwT/B6PY40+XMFqXpzi1fVfV/b/lUsHlXLfIA==
X-Google-Smtp-Source: AFSGD/UOFFtcikIYJm3mggBIBtXnFwTuaqntClSXthiI+GY1AFp2UutHQKi+OW+4EPS9D5wDuwkvP+AICfdQT3zYFwU=
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr6889067wrr.67.1542817919353;
 Wed, 21 Nov 2018 08:31:59 -0800 (PST)
MIME-Version: 1.0
References: <20181030202713.26203-1-semen.protsenko@linaro.org>
In-Reply-To: <20181030202713.26203-1-semen.protsenko@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 21 Nov 2018 18:31:47 +0200
Message-ID: <CAKaJLVu0h5woVtN5=Mh38ajACBZZQ3JHfRhkjNrwMwYXHEG-NQ@mail.gmail.com>
Subject: Re: [PATCH v2] codafs: Fix build using bare-metal toolchain
To:     Andrew Morton <akpm@linux-foundation.org>,
        kernel-janitors@vger.kernel.org, Jan Harkes <jaharkes@cs.cmu.edu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org, codalist@coda.cs.cmu.edu,
        coda@cs.cmu.edu, Andy Shevchenko <andy.shevchenko@gmail.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 10:27 PM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> The kernel is self-contained project and can be built with bare-metal
> toolchain. But bare-metal toolchain doesn't define __linux__. Because of
> this u_quad_t type is not defined when using bare-metal toolchain and
> codafs build fails. This patch fixes it by defining u_quad_t type
> unconditionally.
>
> Cc: Jan Harkes <jaharkes@cs.cmu.edu>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  include/linux/coda.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/coda.h b/include/linux/coda.h
> index d30209b9cef8..0ca0c83fdb1c 100644
> --- a/include/linux/coda.h
> +++ b/include/linux/coda.h
> @@ -58,8 +58,7 @@ Mellon the rights to redistribute these changes without encumbrance.
>  #ifndef _CODA_HEADER_
>  #define _CODA_HEADER_
>
> -#if defined(__linux__)
>  typedef unsigned long long u_quad_t;
> -#endif
> +
>  #include <uapi/linux/coda.h>
>  #endif
> --
> 2.19.1
>

+ Jan Harkes, + Ruslan Bilovol

Hi Jan,

Can you please apply this? Nobody seems to be interested in taking
this patch, so I'm not sure how to proceed further. Please advice.

Thanks!
