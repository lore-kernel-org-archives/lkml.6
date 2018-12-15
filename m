Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA20C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 18:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932222080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 18:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbeLOSUx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 13:20:53 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21718 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeLOSUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 13:20:53 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1544898033; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=HOBERY26xuzPEk/keaX5pT8LUVxiiNe43nYr+ULGNJZIgKpZXhUz5F2RauztFDUR6V4rIjR1w9zDzolXKH2pymgzBZ7iopaMJL7MMhZpkOLQqhXMpP6LBGHalJcNQNwva42RFtUXye0TPGkOr+ytSd3Aa0dGwIBcOZFUftNBxCg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1544898033; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=lvmpJfp7vLbzuiM8clL+9qGJF+LywWqz5fU9/rT2ERk=; 
        b=HQEpLnCxCHee11w9v8qsF/zPF5hh0Di1u2LXHqk+WR5EiwEWmdHpoN8XxWCJPaOih4SgyDreYdJQ6p2QsUunvo/qRtrFQ03iABUZSyfruWCYxRufPmUV28l8xvO7o5GMc2Ogx9Utnp+CHpkD1Q/YStrQ/aKtV7wEpPZZtJTrZmk=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=mniewoehner.de;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de> header.from=<linux@mniewoehner.de>
Received: from z3r0 (31.187.91.78 [31.187.91.78]) by mx.zohomail.com
        with SMTPS id 1544898031002809.4777730993383; Sat, 15 Dec 2018 10:20:31 -0800 (PST)
Message-ID: <de76bdf7f1441fc6d85ceb759a438ea793d9c0bd.camel@mniewoehner.de>
Subject: Re: [PATCH] Allow hwrng to initialize crng.
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     Louis Collard <louiscollard@chromium.org>
Cc:     linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David R. Bild" <david.bild@xaptum.com>
In-Reply-To: <bc8a550472c42e010a70090c1b1bc87c7a26627d.camel@mniewoehner.de>
References: <20180926032455.224600-1-louiscollard@chromium.org>
         <568ea3447a8116ef460d191bf3599e2761bca3a5.camel@mniewoehner.de>
         <CAKNRAJVF5bf7LgyxQRkRFq3ihm9TmbGO8=wCo8i8NWds2yr2bg@mail.gmail.com>
         <bc8a550472c42e010a70090c1b1bc87c7a26627d.camel@mniewoehner.de>
Content-Type: text/plain; charset="UTF-8"
Date:   Sat, 15 Dec 2018 19:20:27 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-12-15 at 18:11 +0100, Michael Niewöhner wrote:
> On Thu, 2018-12-13 at 12:50 +0800, Louis Collard wrote:
> > On Sun, Nov 18, 2018 at 4:15 AM Michael Niewöhner <linux@mniewoehner.de>
> > wrote:
> > > 
> > > Hi Louis,
> > > 
> > > On Wed, 2018-09-26 at 11:24 +0800, Louis Collard wrote:
> > > > Some systems, for example embedded systems, do not generate
> > > > enough entropy on boot through interrupts, and boot may be blocked for
> > > > several minutes waiting for a call to getrandom to complete.
> > > > 
> > > > Currently, random data is read from a hwrng when it is registered,
> > > > and is loaded into primary_crng. This data is treated in the same
> > > > way as data that is device-specific but otherwise unchanging, and
> > > > so primary_crng cannot become initialized with the data from the
> > > > hwrng.
> > > > 
> > > > This change causes the data initially read from the hwrng to be
> > > > treated the same as subsequent data that is read from the hwrng if
> > > > it's quality score is non-zero.
> > > > 
> > > > The implications of this are:
> > > > 
> > > > The data read from hwrng can cause primary_crng to become
> > > > initialized, therefore avoiding problems of getrandom blocking
> > > > on boot.
> > > > 
> > > > Calls to getrandom (with GRND_RANDOM) may be using entropy
> > > > exclusively (or in practise, almost exclusively) from the hwrng.
> > > > 
> > > > Regarding the latter point; this behavior is the same as if a
> > > > user specified a quality score of 1 (bit of entropy per 1024 bits)
> > > > so hopefully this is not too scary a change to make.
> > > > 
> > > > This change is the result of the discussion here:
> > > > https://patchwork.kernel.org/patch/10453893/
> > > > 
> > > > Signed-off-by: Louis Collard <louiscollard@chromium.org>
> > > > Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > ---
> > > >  drivers/char/hw_random/core.c | 9 +++++++--
> > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/char/hw_random/core.c
> > > > b/drivers/char/hw_random/core.c
> > > > index aaf9e5afaad4..47f358aa0c3d 100644
> > > > --- a/drivers/char/hw_random/core.c
> > > > +++ b/drivers/char/hw_random/core.c
> > > > @@ -24,6 +24,7 @@
> > > >  #include <linux/sched.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/uaccess.h>
> > > > +#include <crypto/chacha20.h>
> > > > 
> > > >  #define RNG_MODULE_NAME              "hw_random"
> > > > 
> > > > @@ -64,13 +65,17 @@ static size_t rng_buffer_size(void)
> > > >  static void add_early_randomness(struct hwrng *rng)
> > > >  {
> > > >       int bytes_read;
> > > > -     size_t size = min_t(size_t, 16, rng_buffer_size());
> > > > +     /* Read enough to initialize crng. */
> > > > +     size_t size = 2*CHACHA20_KEY_SIZE;
> > > > 
> > > >       mutex_lock(&reading_mutex);
> > > >       bytes_read = rng_get_data(rng, rng_buffer, size, 1);
> > > >       mutex_unlock(&reading_mutex);
> > > >       if (bytes_read > 0)
> > > > -             add_device_randomness(rng_buffer, bytes_read);
> > > > +             /* Allow crng to become initialized, but do not add
> > > > +              * entropy to the pool.
> > > > +              */
> > > > +             add_hwgenerator_randomness(rng_buffer, bytes_read, 0);
> > > >  }
> > > > 
> > > >  static inline void cleanup_rng(struct kref *kref)
> > > 
> > > I found your patch by chance, searching for a solution for crng init delay
> > > on my
> > > headless machine. Unfortunately it hardly makes any difference for me.
> > > With
> > > the
> > > patch the system hangs for about 80s instead of 120s until the "crng init
> > > done"
> > > message.In contrast, doing a `cat /dev/hwrng >/dev/random` or running rngd
> > > initializes the crng instantly.
> > > 
> > > Isn't that delay the problem this patch tries to fix? Any idea what is
> > > wrong
> > > here?
> > > 
> > > Thanks!
> > > 
> > > Best regards
> > > Michael
> > > 
> > > 
> > 
> > Yes that is the problem this is trying to address. My guess would be
> > rng_get_data() is not returning as much data as requested, so the
> > delay is reduced but not eliminated. Looking at implementation of
> > rng_get_data() it appears this could be caused by device support for
> > read() vs data_read(). I don't have a good feel for whether looping to
> > retrieve more data here would be acceptable, it is certainly a bigger
> > change than currently proposed.
> > 
> > Thanks,
> > Louis
> 
> Hi Louis,
> 
> that is what I thought first, too, but I was able to verify that 64 bytes are
> read as expected.
> 
> It seems this is exactly what David noticed in your discussion about the
> quality
> module parameter (https://patchwork.kernel.org/patch/10453893/#22130681):
> 
> > Interesting.
> > 
> > add_hwgenereator_randomness() will call crng_fast_load(), regardless
> > of entropy estimate/quality, if crng_init is 0.  So initializing
> > crng_init from the hwrng, regardless of quality, is already the
> > intent.
> > 
> > But hw_random only calls add_hwgenerator_randomness() if
> > current_quality > 0, via the hwrng_fillfn() kthread.
> > 
> > All that to say, I agree.  add_early_randomness() should (indirectly)
> > call crng_fast_load(), like add_hwgenerator_randomness() does.
> 
> When I set rng_quality=1024, the crng does get initialized more or less
> instantly.
> 
> 
> dmesg with default rng_quality=0:
> 
> [    0.003831] ACPI: TPM2 0x000000009E0B7F70 000034 (v03 LENOVO TC-
> S06   00001260 AMI  00000000)
> [    0.161803] random: get_random_bytes called from start_kernel+0x8f/0x50e
> with
> crng_init=0
> [    3.590433] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
> [    3.644148] random: fast init done
> [   85.183006] random: crng init done
> 
> 
> dmesg with rng_quality patch:
> 
> [    0.003837] ACPI: TPM2 0x000000009E0B7F70 000034 (v03 LENOVO TC-
> S06   00001260 AMI  00000000)
> [    0.162136] random: get_random_bytes called from start_kernel+0x8f/0x50e
> with
> crng_init=0
> [    3.582675] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
> [    3.636408] random: fast init done
> [    3.650355] random: crng init done
> 
> 
> Test patch:
> 
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index f08949a5f678..59e5a8753ba1 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -214,6 +214,8 @@ static int tpm_tis_init(struct device *dev, struct
> tpm_info
> *tpm_info)
>         if (itpm || is_itpm(ACPI_COMPANION(dev)))
>                 phy->priv.flags |= TPM_TIS_ITPM_WORKAROUND;
>  
> +       priv->rng_quality = 1;
> +
>         return tpm_tis_core_init(dev, &phy->priv, irq, &tpm_tcg,
>                                  ACPI_HANDLE(dev));
>  }
> 
> 
> 
> Thanks
> Michael


Hi Louis,

I think I might know what is causing the delay of crng init.

Your patch is working as expected but only for fast init.
add_hwgenerator_randomness calls crng_fast_load which does stage 1
initialization of the crng ("fast init done" -> crng_init=1).

Currently no entropy comes from the TPM at all for 1) the second stage init /
reseed 2) later operation because tpm_tis sets no quality while the default in
tpm-chip is quality=0 and so khwrngd will not be started in hwrng_init.
This is why setting the quality to 1024 instantly leads to setting crng_init=2
and reseeding the crng ("crng init done").

That means the current default value of rng_quality=0 renders the tpm hwrng
completely useless.




