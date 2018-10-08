Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21217C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9AB20858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HyotIFZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF9AB20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeJHSuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:50:50 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54092 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeJHSuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:50:50 -0400
Received: by mail-it1-f195.google.com with SMTP id q70-v6so10979379itb.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 04:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zME3rs+2xcyOm3rsFpLRMIfJQN8W+jcGL4qAhyQKjMM=;
        b=HyotIFZFBQL1DwGXT9GI3Bp5ydInycDiW5q4kpnVyhvNiIih9ZvICAz91VB01L8ksM
         co71smwiWQrFNaREhxkl5chi3ykLkHVogEMkiypCjM3xfRMerF9PjwCjBC+RfRFdcciy
         AAkNfG5i52Movk7AMA2vT7rDOyqtKTJ9hFUD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zME3rs+2xcyOm3rsFpLRMIfJQN8W+jcGL4qAhyQKjMM=;
        b=tVyvJ/r6zYQuHK5RuHhKK/c8m5mni3Ax64SU4lUGEe6iYzU7ZRlcdfoopM2j/7Ch2T
         GuwkBxEDMIUO8SLYD8rYRhjYlq6Zi0EKWl/IoJekuFw127jmxwdAvkv/qsz/qWorSVsn
         F0x3moKrJmXyjd8O+j5XcyW3kbL59OfrJayt40WoodNFrsss7CR+t+gxsqt+Pru5IqvY
         e42EiBZHxhFTGpu/y4rPLOi14HXtA0G+6FMTB5hkXiqJs+6bJvwwK+JcPUxts+q2I/ef
         3ytLZWvAVR7xcc4UJ7agEgcw3KAmHrEp/bvAer0RuXB7uluyRbs/21ca0tocIBu8O1km
         P0EA==
X-Gm-Message-State: ABuFfogLBR+Div6vxT69iogoxqi4FPcqGCKqMD1c71rXqn3kxWn5O/AL
        fVmBm2ZybQ8ZpYuZGZ4n7sy1k8vQ7rsNyGtdlaB6bw==
X-Google-Smtp-Source: ACcGV63+1ikbDg6uPeOPfNpAIrRknowjSQ6RxPMFVNr7Ue+xhcvoPRyqJwKioj+5CIMh2m3586go7m5uNPswcxeM4s8=
X-Received: by 2002:a02:b015:: with SMTP id p21-v6mr17934223jah.2.1538998770541;
 Mon, 08 Oct 2018 04:39:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Mon, 8 Oct 2018 04:39:29 -0700 (PDT)
In-Reply-To: <20181007115810.27779-1-michael@schupikov.de>
References: <20181007115810.27779-1-michael@schupikov.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 8 Oct 2018 13:39:29 +0200
Message-ID: <CAKv+Gu9s_0xCMvVJoTRRsEkXdDjLdKjj34=1U1y=o=r-OqLm8Q@mail.gmail.com>
Subject: Re: [PATCH] crypto/testmgr.c: fix sizeof() on COMP_BUF_SIZE
To:     Michael Schupikov <michael@schupikov.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 October 2018 at 13:58, Michael Schupikov <michael@schupikov.de> wrote:
> After allocation, output and decomp_output both point to memory chunks of
> size COMP_BUF_SIZE. Then, only the first bytes are zeroed out using
> sizeof(COMP_BUF_SIZE) as parameter to memset(), because
> sizeof(COMP_BUF_SIZE) provides the size of the constant and not the size of
> allocated memory.
>
> Instead, the whole allocated memory is meant to be zeroed out. Use
> COMP_BUF_SIZE as parameter to memset() directly in order to accomplish
> this.
>
> Fixes: 336073840a872 ("crypto: testmgr - Allow different compression results")
>
> Signed-off-by: Michael Schupikov <michael@schupikov.de>

Nice catch

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  crypto/testmgr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> index a1d42245082a..790aa3536631 100644
> --- a/crypto/testmgr.c
> +++ b/crypto/testmgr.c
> @@ -1400,8 +1400,8 @@ static int test_comp(struct crypto_comp *tfm,
>                 int ilen;
>                 unsigned int dlen = COMP_BUF_SIZE;
>
> -               memset(output, 0, sizeof(COMP_BUF_SIZE));
> -               memset(decomp_output, 0, sizeof(COMP_BUF_SIZE));
> +               memset(output, 0, COMP_BUF_SIZE);
> +               memset(decomp_output, 0, COMP_BUF_SIZE);
>
>                 ilen = ctemplate[i].inlen;
>                 ret = crypto_comp_compress(tfm, ctemplate[i].input,
> @@ -1445,7 +1445,7 @@ static int test_comp(struct crypto_comp *tfm,
>                 int ilen;
>                 unsigned int dlen = COMP_BUF_SIZE;
>
> -               memset(decomp_output, 0, sizeof(COMP_BUF_SIZE));
> +               memset(decomp_output, 0, COMP_BUF_SIZE);
>
>                 ilen = dtemplate[i].inlen;
>                 ret = crypto_comp_decompress(tfm, dtemplate[i].input,
> --
> 2.19.0
>
