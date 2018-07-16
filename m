Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BDDECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2773A208EA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIPfS9Qj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2773A208EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388874AbeGPISU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:18:20 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37527 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbeGPIST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:18:19 -0400
Received: by mail-lf0-f67.google.com with SMTP id j8-v6so31529971lfb.4;
        Mon, 16 Jul 2018 00:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=j3hsZvrtufMVdxboyF5VWnGayBW4Dpcr2ETKdorfZZw=;
        b=lIPfS9QjYPRurQRdT2MmPx2wV8WkyB0a6BqSYI9BSgzAxh4qRNC/PmVazjyy0Ueuhx
         wKeIuPb/AyFz9cn62YmlV5xKSGn7llklFp6lsf2MvBm0qJZxMtLtvrZDzrA8olVCpK1e
         1QtY5YBcYRhVouff5xSHOydg6AGwiw32XHq5F45Ccj5HppKHxG8ZazVwX7C3pC9zYgsj
         JAZOw7y0Eq4w+YewuwOIZ67bLy+IDLwn8Han3WVnFkF9qhmXszfQvEWydql1MWPZF0EL
         wN7Rv3hzrNmwfjs+iWuRwiGnA6KwkDCkb0aSI8OV6a8VVuRuYaByE2XoHFYuZ9mKhU89
         G55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=j3hsZvrtufMVdxboyF5VWnGayBW4Dpcr2ETKdorfZZw=;
        b=ofxAzfJz0bsBosToAF9v8CV44aGn2EP4xgxNWchZHyDSzHMd39XtQsmN4CHE+hcK67
         zDjFnLFyJRPqvBf2v3I8KBOdxxso0vTSmT6f+lBIjlyAHBSaT5mzSiAX1w68Qpo9V0AX
         c0AMT0qyq25EtIYyckuykMhoi//yQ/HlaULj37eEWRxD4IN8ugjsZg2B7V7abpFNiHkG
         pf/MVLiXZld8Y8fArl9JJo024lPGzxfJaukievk3sDLgk8wT0AhdObaAqsMqxH5hLsRu
         XYmpuQDouAFpGjmop64V1CyQj+RZy4sZQ83ic7SdB/6yxbFhCuYZeRER7c9sHdPwK8Uq
         livA==
X-Gm-Message-State: AOUpUlHOXlqi8B3HKz0IsZGAVquJflfbLyEeI7A000Vj7V5MXhPPu5R/
        2Ybhyj0fWEkAI1kIVUtaXVBUe8qQSoQZVh2iiiQXEtGu
X-Google-Smtp-Source: AAOMgpdvmAdNO4pBTQMeEuRiMdCw/x8oMxWCMgL+d7R+alsCJrnQw6TeCjAA7Cc+S9Ni8x2Abs3M4JTLlbdWmo7lm4E=
X-Received: by 2002:a19:b2c7:: with SMTP id t68-v6mr10316553lfk.132.1531725847188;
 Mon, 16 Jul 2018 00:24:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 00:24:06
 -0700 (PDT)
In-Reply-To: <CAGXu5jKQV+qiLjbDoS=8QYfG_hdiYeRqeDdov_of5wn5Sek0KA@mail.gmail.com>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-12-keescook@chromium.org>
 <CAK8P3a3356dbruUfS_+fj9f+X-0jbNE8WMe5sWhJmuRY9Nvcbg@mail.gmail.com>
 <20180713004038.lwibdesz7ohhoind@gondor.apana.org.au> <CAGXu5jJOZ3u1BTf8U20wErphfjKzaGK+m1sdhA89LqVP3MDYZA@mail.gmail.com>
 <20180713062204.2o7gz5xri374nii6@gondor.apana.org.au> <CAGXu5jJp3Y4RZD+ZUYsWqf+sTbGJwdN3M=KOiPBn9VecYE4OgQ@mail.gmail.com>
 <20180715024430.n6bcnb4k7cm3ugtj@gondor.apana.org.au> <CAGXu5jLkhC8Jb0zVXuVZnbJM6tmMpyGkaoCvw=jACLA3fnoChw@mail.gmail.com>
 <20180716000118.nna5jkgcjxofbsup@gondor.apana.org.au> <CAGXu5jKQV+qiLjbDoS=8QYfG_hdiYeRqeDdov_of5wn5Sek0KA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 16 Jul 2018 09:24:06 +0200
X-Google-Sender-Auth: CL4f1rPGqIihFKKbtl8qfIbQfj8
Message-ID: <CAK8P3a0Y82-zxiC4L1v3B20fTgP=AwfFT7sogZZBH5+v0uToHw@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] treewide: Prepare to remove VLA usage for AHASH_REQUEST_ON_STACK
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 5:39 AM, Kees Cook <keescook@chromium.org> wrote:
> On Sun, Jul 15, 2018 at 5:01 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>> On Sat, Jul 14, 2018 at 07:59:09PM -0700, Kees Cook wrote:
>>> On Sat, Jul 14, 2018 at 7:44 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>>> > On Fri, Jul 13, 2018 at 08:07:10PM -0700, Kees Cook wrote:
>>> >>
>>> >> On a plane today I started converting all these to shash. IIUC, it
>>> >> just looks like this (apologies for whitespace damage):
>>> >
>>> > Yes if it doesn't actually make use of SGs then shash would be
>>> > the way to go.  However, for SG users ahash is the best interface.
>>>
>>> Nearly all of them artificially build an sg explicitly to use the
>>> ahash interface. :P
>>>
>>> So, I'll take that as a "yes, do these conversions." :) Thanks!
>>
>> Yeah anything that's doing a single-element SG list should just
>> be converted.
>
> There are a few that are multiple element SG list, but it's a locally
> allocated array of SGs, and filled with data. All easily replaced with
> just calls to ..._update() instead of sg helpers. For example
> net/wireless/lib80211_crypt_tkip.c:
>
> -       sg_init_table(sg, 2);
> -       sg_set_buf(&sg[0], hdr, 16);
> -       sg_set_buf(&sg[1], data, data_len);
> ...
> -       ahash_request_set_tfm(req, tfm_michael);
> -       ahash_request_set_callback(req, 0, NULL, NULL);
> -       ahash_request_set_crypt(req, sg, mic, data_len + 16);
> -       err = crypto_ahash_digest(req);
> -       ahash_request_zero(req);
> +       err = crypto_shash_init(desc);
> +       if (err)
> +               goto out;
> +       err = crypto_shash_update(desc, hdr, 16);
> +       if (err)
> +               goto out;
> +       err = crypto_shash_update(desc, data, data_len);
> +       if (err)
> +               goto out;
> +       err = crypto_shash_final(desc, mic);
> +
> +out:
> +       shash_desc_zero(desc);
>         return err;

There may be a little overhead in calling crypto_shash_update()/
crypto_shash_final() repeatedly compared to calling
crypto_ahash_digest() once. It's probably no worse (or maybe
better) in this case, since we call only three times and there
is less indirection, but if there are any cases with a long sglist,
it would be good to measure the performance difference.

       Arnd
