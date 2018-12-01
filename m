Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18844C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 08:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C861020867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 08:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XmlAJQBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C861020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbeLATNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 14:13:14 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37411 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeLATNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 14:13:14 -0500
Received: by mail-yb1-f196.google.com with SMTP id w129-v6so1686855ybe.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 00:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=okiTj2ag2Wb3u5hZZLTG2IDy4RVm89b8fVtLPObUnug=;
        b=XmlAJQBcl3LzZp8QWJGHvkE8rYTINTPYQJbXC8DLLEiShDgaFLZVoP93dV0L5fPBIx
         wxm4rDKeLqagd0TlTYqLY5qqVEsGyLoOFNfM1BFaHI7E4o84as3wcUiCuAnJahFq0q9U
         SKXPZj5PU8GCHAMd5pN2+UCP/+1/cKPkzEOtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=okiTj2ag2Wb3u5hZZLTG2IDy4RVm89b8fVtLPObUnug=;
        b=ra6vlJSvD26CC0mVffLUQ3+glTq9SzjPKPaYhnyTKtuPIypL2pw704OZJNf6rXr6GE
         0Tkl4/5rEaPxlQJEID38vSI9HNf3onHDqtt2VvobzGipcd9B/zkrLvYVUIhYFOGZCwOl
         jEA7BKl1fVSgy05v2eQ72YfmOUrYgcEpBiKMTG2ernoEGYFbNyZgmTcLG5/X1EO79bYM
         TMFu64kkGruMkqiuNuRZSLy1I3qeoniN9pJtSiaB9HKOWY+oc5ZMexZChEQ7Oj2A+HnX
         hTZ6qmwVV93Zn+tPQIr7u02+pSFptPq370tzWxNYkbcoFLsiC/ropRk7qxPzTbr6laVW
         kuLQ==
X-Gm-Message-State: AA+aEWZ2XBYSbbcB456qG0DWc/BBcZwQDg4CQhC5EKDbI0SRWAaMHVnA
        s8Xctdrf6/mju6eU5xamitby7z1NLIk=
X-Google-Smtp-Source: AFSGD/V/pineKuGjarGQRkXrLfygLx0LbRpIQh3szWsp1UF67UZKPLMu4Foj5yjMT7R3PiaLyI/gIg==
X-Received: by 2002:a25:e86:: with SMTP id 128-v6mr8402675ybo.184.1543651277696;
        Sat, 01 Dec 2018 00:01:17 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id d85sm2578946ywd.22.2018.12.01.00.01.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 00:01:16 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id a67-v6so3276335ybg.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 00:01:16 -0800 (PST)
X-Received: by 2002:a25:b3c6:: with SMTP id x6-v6mr8204881ybf.508.1543651275547;
 Sat, 01 Dec 2018 00:01:15 -0800 (PST)
MIME-Version: 1.0
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com> <20181130192737.15053-9-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20181130192737.15053-9-jarkko.sakkinen@linux.intel.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Sat, 1 Dec 2018 00:01:04 -0800
X-Gmail-Original-Message-ID: <CAAFQd5De7sck9DoZHngd7PRM7ap8G_kO=9Bk0WpZVXjhyZhYig@mail.gmail.com>
Message-ID: <CAAFQd5De7sck9DoZHngd7PRM7ap8G_kO=9Bk0WpZVXjhyZhYig@mail.gmail.com>
Subject: Re: [PATCH RFC 08/15] media: replace **** with a hug
To:     jarkko.sakkinen@linux.intel.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 11:28 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> In order to comply with the CoC, replace **** with a hug. In
> addition, fix a coding style issue (lines with over 80 chars).
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  drivers/media/i2c/bt819.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/i2c/bt819.c b/drivers/media/i2c/bt819.c
> index 472e37637c8d..c0f198b764f0 100644
> --- a/drivers/media/i2c/bt819.c
> +++ b/drivers/media/i2c/bt819.c
> @@ -165,9 +165,11 @@ static int bt819_init(struct v4l2_subdev *sd)
>                 0x0f, 0x00,     /* 0x0f Hue control */
>                 0x12, 0x04,     /* 0x12 Output Format */
>                 0x13, 0x20,     /* 0x13 Vertial Scaling msb 0x00
> -                                          chroma comb OFF, line drop scaling, interlace scaling
> -                                          BUG? Why does turning the chroma comb on fuck up color?
> -                                          Bug in the bt819 stepping on my board?
> +                                          chroma comb OFF, line drop scaling,
> +                                          interlace scaling BUG? Why does
> +                                          turning the chroma comb on hug up

Putting the strong language aside, this comment could actually benefit
from rewording to make it convey more information about the problem.
For example, wouldn't

NOTE: The chroma comb causes a random color distortion on some boards
(stepping of the chip?).

be much more meaningful? I had to guess what f**king up was supposed
to mean here, which is obviously a problem with this comment. It could
be extended even more by mentioning what board and chip stepping it
was observed on.

Best regards,
Tomasz
