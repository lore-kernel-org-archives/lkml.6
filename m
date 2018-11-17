Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB32C04EBF
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 20:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73382080D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 20:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73382080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mniewoehner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeKRGdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 01:33:49 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21703 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725732AbeKRGdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 01:33:49 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1542485738; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=c5wAj65ZHymBfCUwwXAUODUl7cbn2/KsfhGG+jEQi3euUt6hIfNwIfRjLWR/fOjH4MSJc1NOzS2ZuL+UuDts3t9m4H4iyWz+NxcuojVMlfjj733jT1BKuNPcX1JiM4KtcS3FWU/d8b+x1EZNKpIm2fkqVd/ECpq9H6TV1XIbEDg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1542485738; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=msrNFitDTuhne6hzcdz+5zKDQbarSW+zE6EKA7b+4K0=; 
        b=jZMqeqe65HKyBkHxLYiuZa+ooMhQeF0bhkrJ4QMXJfPSO0ytQfrWNpUtRvyu598twtTR6PE6Q3ObmKBDeuZxuLpHyufXo/GJBvIeGIybPfqr3cqna0+WaPwIaRTg2UtEjBNuh6ElTcvMImHh8xrPXG+7Nc1Mp45Tw67OfZiI3yo=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=mniewoehner.de;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de> header.from=<linux@mniewoehner.de>
Received: from z3r0 (31.187.91.78 [31.187.91.78]) by mx.zohomail.com
        with SMTPS id 1542485736387545.3812507833644; Sat, 17 Nov 2018 12:15:36 -0800 (PST)
Message-ID: <568ea3447a8116ef460d191bf3599e2761bca3a5.camel@mniewoehner.de>
Subject: Re: [PATCH] Allow hwrng to initialize crng.
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     Louis Collard <louiscollard@chromium.org>
Cc:     linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        apronin@chromium.org, Jason Gunthorpe <jgg@ziepe.ca>,
        david.bild@xaptum.com
In-Reply-To: <20180926032455.224600-1-louiscollard@chromium.org>
References: <20180926032455.224600-1-louiscollard@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Sat, 17 Nov 2018 21:15:32 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5 
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Louis,

On Wed, 2018-09-26 at 11:24 +0800, Louis Collard wrote:
> Some systems, for example embedded systems, do not generate
> enough entropy on boot through interrupts, and boot may be blocked for
> several minutes waiting for a call to getrandom to complete.
> 
> Currently, random data is read from a hwrng when it is registered,
> and is loaded into primary_crng. This data is treated in the same
> way as data that is device-specific but otherwise unchanging, and
> so primary_crng cannot become initialized with the data from the
> hwrng.
> 
> This change causes the data initially read from the hwrng to be
> treated the same as subsequent data that is read from the hwrng if
> it's quality score is non-zero.
> 
> The implications of this are:
> 
> The data read from hwrng can cause primary_crng to become
> initialized, therefore avoiding problems of getrandom blocking
> on boot.
> 
> Calls to getrandom (with GRND_RANDOM) may be using entropy
> exclusively (or in practise, almost exclusively) from the hwrng.
> 
> Regarding the latter point; this behavior is the same as if a
> user specified a quality score of 1 (bit of entropy per 1024 bits)
> so hopefully this is not too scary a change to make.
> 
> This change is the result of the discussion here:
> https://patchwork.kernel.org/patch/10453893/
> 
> Signed-off-by: Louis Collard <louiscollard@chromium.org>
> Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  drivers/char/hw_random/core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> index aaf9e5afaad4..47f358aa0c3d 100644
> --- a/drivers/char/hw_random/core.c
> +++ b/drivers/char/hw_random/core.c
> @@ -24,6 +24,7 @@
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> +#include <crypto/chacha20.h>
>  
>  #define RNG_MODULE_NAME		"hw_random"
>  
> @@ -64,13 +65,17 @@ static size_t rng_buffer_size(void)
>  static void add_early_randomness(struct hwrng *rng)
>  {
>  	int bytes_read;
> -	size_t size = min_t(size_t, 16, rng_buffer_size());
> +	/* Read enough to initialize crng. */
> +	size_t size = 2*CHACHA20_KEY_SIZE;
>  
>  	mutex_lock(&reading_mutex);
>  	bytes_read = rng_get_data(rng, rng_buffer, size, 1);
>  	mutex_unlock(&reading_mutex);
>  	if (bytes_read > 0)
> -		add_device_randomness(rng_buffer, bytes_read);
> +		/* Allow crng to become initialized, but do not add
> +		 * entropy to the pool.
> +		 */
> +		add_hwgenerator_randomness(rng_buffer, bytes_read, 0);
>  }
>  
>  static inline void cleanup_rng(struct kref *kref)

I found your patch by chance, searching for a solution for crng init delay on my
headless machine. Unfortunately it hardly makes any difference for me. With the
patch the system hangs for about 80s instead of 120s until the "crng init done"
message.In contrast, doing a `cat /dev/hwrng >/dev/random` or running rngd
initializes the crng instantly.

Isn't that delay the problem this patch tries to fix? Any idea what is wrong
here?

Thanks!

Best regards
Michael


