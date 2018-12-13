Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784EBC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320E720849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j5Q94pHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320E720849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbeLMJUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:20:45 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37317 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbeLMJUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:20:44 -0500
Received: by mail-oi1-f195.google.com with SMTP id y23so1082843oia.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 01:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q7AVazXsZePEjvqArdeaIpI3yjrkGc+WeG0TPRsT/4M=;
        b=j5Q94pHwTxT7p20xoaLMhp9wPTXPZdUQJvg+NOiho9Q9Gckik8/4xSR+ZzdHOYT8G/
         HXdBZGZMVwHC7BtJX9+WBf0IRAfb/xMHgrl3IiE0/38YzZTefP+/srtZIfC0A064z03H
         S3HcYXWgvBHYgjM2GPdTQrs1hk03dAO7VWgZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q7AVazXsZePEjvqArdeaIpI3yjrkGc+WeG0TPRsT/4M=;
        b=GjJpBMizSXrqN+nuFm9se593BmirZ6xpfBKnBJ1AicWK1PR/Tiz0uP7nJ+Cpq86tyZ
         ilG57F672sMIPzayDaPKCvP6YoZeR0dJrww6d2pkl6NH7PJScFX1XKAm6sCO+u1Ki3VV
         +dnD0lmugiOnmCLWRShfGl8i16vrbWuWwqxC5KH+LEdgmfECf2kKSMFTRJJ6Bp4LjlL2
         Tx5j1+cmBQruol6e8I7BnFKTCwRKiBevgu0lAkmJc6I1Y3TpedXG2oxWSxd1w9hmRykr
         htNFCgkpmzrVUWvbiIfx/hJkGOmm8TZpHdJz+wgVKorH2LBInoORfxi+oeaBoA4la4hO
         mznQ==
X-Gm-Message-State: AA+aEWbnGWC4rSm4pgl7/EBO/CypqdkSugZykS0Vxbukx+KKi7iRAW1B
        zz58mAAeSdvEVa0NMe3+xh/L1RWh5DUCTze0CYxrOw==
X-Google-Smtp-Source: AFSGD/WPm0mv8whcIs6QQO/uKGRxeRv1ZvRfwQ8sHb6QKkxdW8JLXUmA6lf9KAl+vbpc8sIOYaNMR/uSWESO8M8v/0Q=
X-Received: by 2002:aca:53cd:: with SMTP id h196mr2576903oib.355.1544692843661;
 Thu, 13 Dec 2018 01:20:43 -0800 (PST)
MIME-Version: 1.0
References: <20181213084017.80850-1-louiscollard@chromium.org> <20181213085102.aiw64pubxgoohlo3@gondor.apana.org.au>
In-Reply-To: <20181213085102.aiw64pubxgoohlo3@gondor.apana.org.au>
From:   Louis Collard <louiscollard@chromium.org>
Date:   Thu, 13 Dec 2018 17:20:32 +0800
Message-ID: <CAKNRAJVAVQdRCmUFYC0PvzaSxFTjZmJMNuRzx8TgS2ihxCqE8A@mail.gmail.com>
Subject: Re: [RESEND PATCH] Allow hwrng to initialize crng.
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, mpm@selenic.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gary R Hook <gary.hook@amd.com>, Michael Buesch <m@bues.ch>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        mst@redhat.com, linux-kernel@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux@mniewoehner.de, "David R. Bild" <david.bild@xaptum.com>,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 4:51 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Thu, Dec 13, 2018 at 04:40:17PM +0800, Louis Collard wrote:
> > Some systems, for example embedded systems, do not generate
> > enough entropy on boot through interrupts, and boot may be blocked for
> > several minutes waiting for a call to getrandom to complete.
> >
> > Currently, random data is read from a hwrng when it is registered,
> > and is loaded into primary_crng. This data is treated in the same
> > way as data that is device-specific but otherwise unchanging, and
> > so primary_crng cannot become initialized with the data from the
> > hwrng.
> >
> > This change causes the data initially read from the hwrng to be
> > treated the same as subsequent data that is read from the hwrng if
> > it's quality score is non-zero.
> >
> > The implications of this are:
> >
> > The data read from hwrng can cause primary_crng to become
> > initialized, therefore avoiding problems of getrandom blocking
> > on boot.
> >
> > Calls to getrandom (with GRND_RANDOM) may be using entropy
> > exclusively (or in practise, almost exclusively) from the hwrng.
> >
> > Regarding the latter point; this behavior is the same as if a
> > user specified a quality score of 1 (bit of entropy per 1024 bits)
> > so hopefully this is not too scary a change to make.
> >
> > This change is the result of the discussion here:
> > https://patchwork.kernel.org/patch/10453893/
> >
> > Signed-off-by: Louis Collard <louiscollard@chromium.org>
> > Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >  drivers/char/hw_random/core.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> > index 95be7228f327..99c3e4127949 100644
> > --- a/drivers/char/hw_random/core.c
> > +++ b/drivers/char/hw_random/core.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/slab.h>
> >  #include <linux/uaccess.h>
> > +#include <crypto/chacha20.h>
> >
> >  #define RNG_MODULE_NAME              "hw_random"
> >
> > @@ -64,13 +65,17 @@ static size_t rng_buffer_size(void)
> >  static void add_early_randomness(struct hwrng *rng)
> >  {
> >       int bytes_read;
> > -     size_t size = min_t(size_t, 16, rng_buffer_size());
> > +     /* Read enough to initialize crng. */
> > +     size_t size = 2*CHACHA20_KEY_SIZE;
> >
> >       mutex_lock(&reading_mutex);
> >       bytes_read = rng_get_data(rng, rng_buffer, size, 1);
> >       mutex_unlock(&reading_mutex);
> >       if (bytes_read > 0)
> > -             add_device_randomness(rng_buffer, bytes_read);
> > +             /* Allow crng to become initialized, but do not add
> > +              * entropy to the pool.
> > +              */
> > +             add_hwgenerator_randomness(rng_buffer, bytes_read, 0);
> >  }
> >
> >  static inline void cleanup_rng(struct kref *kref)
> > --
> > 2.13.5
> >
>
> Adding Ted Ts'o to the cc list.
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Thanks - and apologies, just re-read this and realized I clearly
wasn't paying attention the first time, have sent a v2 that calculates
size correctly.
