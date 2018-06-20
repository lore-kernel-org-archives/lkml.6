Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E96DC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D215220652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D215220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754699AbeFTJAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:00:46 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38022 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754614AbeFTJAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:00:41 -0400
Received: by mail-oi0-f65.google.com with SMTP id d5-v6so2343160oib.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 02:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iaf34ur3LmcIDpURuViIahNYd2DHXnMfAJ45qUPsCVI=;
        b=LS7+j5I4iAxl8p3pX6jE6RrF/bu+QRLnC13z7LEBx3KGaU5d+Q3YmtPJ32IaksCUbO
         rOm/1o6/oDaTbmIpdY3xTm88z6kieSeuyePFIB2z/7F+UUHxrnUCIKxfFs/M0JG6N2rv
         EiNILiACT/z1q0nyFKmVbU6R63s1eyYVEec7Q9GoWnZhpmpKyA1HISbI0GFWkVY5d7gl
         UR08kreCGakqLVA9/Q7JcWFX2W4oiT93Zk8ZDYvIoWxGGLw5r6bZ2hY0CW+HWqEh0Baz
         v+0qkj8sZtvfRImZzc1LH+AHbie+5qh45UpJ4D/a6U/bfTRFHqNq0vyCwYoLys7MfT8D
         qGcw==
X-Gm-Message-State: APt69E1bYu6iXnClzCGrUV7Vb7s9DrNRtAP99HYsT38SRpgLM9MJQ2ia
        /f0z4adsqzleb1BHLPeIdJxqOB8ZnKn9I5fu75ydkPBs
X-Google-Smtp-Source: ADUXVKJKG3ou160SHe5bE0MF/Qdmj/g2WaKEz6Sc3NmVdJCoC9wUmiWfZnLZfiHxEl+4g3pPrT9zuD8490aG1uYEgwI=
X-Received: by 2002:aca:a686:: with SMTP id t6-v6mr11561924oij.48.1529479001610;
 Wed, 20 Jun 2018 00:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180619140229.3615110-1-arnd@arndb.de>
In-Reply-To: <20180619140229.3615110-1-arnd@arndb.de>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 20 Jun 2018 09:16:30 +0200
Message-ID: <CA+7wUsyN_gru4rW0y3ZzXzYwhfaA=uHKaOG=z5bprnYq6oVfMg@mail.gmail.com>
Subject: Re: [PATCH 1/3] [v2] powerpc: mac: fix rtc read/write functions
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>, funaho@jurai.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        gerg@linux-m68k.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, y2038@lists.linaro.org,
        Meelis Roos <mroos@linux.ee>, schwab@linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 4:04 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> As Mathieu pointed out, my conversion to time64_t was incorrect and resulted
> in negative times to be read from the RTC. The problem is that during the
> conversion from a byte array to a time64_t, the 'unsigned char' variable
> holding the top byte gets turned into a negative signed 32-bit integer
> before being assigned to the 64-bit variable for any times after 1972.
>
> This changes the logic to cast to an unsigned 32-bit number first for
> the Macintosh time and then convert that to the Unix time, which then gives
> us a time in the documented 1904..2040 year range. I decided not to use
> the longer 1970..2106 range that other drivers use, for consistency with
> the literal interpretation of the register, but that could be easily
> changed if we decide we want to support any Mac after 2040.
>
> Just to be on the safe side, I'm also adding a WARN_ON that will trigger
> if either the year 2040 has come and is observed by this driver, or we
> run into an RTC that got set back to a pre-1970 date for some reason
> (the two are indistinguishable).
>
> For the RTC write functions, Andreas found another problem: both
> pmu_request() and cuda_request() are varargs functions, so changing
> the type of the arguments passed into them from 32 bit to 64 bit
> breaks the API for the set_rtc_time functions. This changes it
> back to 32 bits.
>
> The same code exists in arch/m68k/ and is patched in an identical way now
> in a separate patch.
>
> Fixes: 5bfd643583b2 ("powerpc: use time64_t in read_persistent_clock")
> Reported-by: Mathieu Malaterre <malat@debian.org>
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Doing a reboot on Debian sets the hardware clock from system clock and
upon reboot everything is back in shape:

[    5.645082] rtc-generic rtc-generic: setting system clock to
2018-06-20 07:12:04 UTC (1529478724)


Tested-by: Mathieu Malaterre <malat@debian.org>

Thanks!
> ---
>  arch/powerpc/platforms/powermac/time.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powermac/time.c b/arch/powerpc/platforms/powermac/time.c
> index 7c968e46736f..12e6e4d30602 100644
> --- a/arch/powerpc/platforms/powermac/time.c
> +++ b/arch/powerpc/platforms/powermac/time.c
> @@ -42,7 +42,11 @@
>  #define DBG(x...)
>  #endif
>
> -/* Apparently the RTC stores seconds since 1 Jan 1904 */
> +/*
> + * Offset between Unix time (1970-based) and Mac time (1904-based). Cuda and PMU
> + * times wrap in 2040. If we need to handle later times, the read_time functions
> + * need to be changed to interpret wrapped times as post-2040.
> + */
>  #define RTC_OFFSET     2082844800
>
>  /*
> @@ -97,8 +101,11 @@ static time64_t cuda_get_time(void)
>         if (req.reply_len != 7)
>                 printk(KERN_ERR "cuda_get_time: got %d byte reply\n",
>                        req.reply_len);
> -       now = (req.reply[3] << 24) + (req.reply[4] << 16)
> -               + (req.reply[5] << 8) + req.reply[6];
> +       now = (u32)((req.reply[3] << 24) + (req.reply[4] << 16) +
> +                   (req.reply[5] << 8) + req.reply[6]);
> +       /* it's either after year 2040, or the RTC has gone backwards */
> +       WARN_ON(now < RTC_OFFSET);
> +
>         return now - RTC_OFFSET;
>  }
>
> @@ -106,10 +113,10 @@ static time64_t cuda_get_time(void)
>
>  static int cuda_set_rtc_time(struct rtc_time *tm)
>  {
> -       time64_t nowtime;
> +       u32 nowtime;
>         struct adb_request req;
>
> -       nowtime = rtc_tm_to_time64(tm) + RTC_OFFSET;
> +       nowtime = lower_32_bits(rtc_tm_to_time64(tm) + RTC_OFFSET);
>         if (cuda_request(&req, NULL, 6, CUDA_PACKET, CUDA_SET_TIME,
>                          nowtime >> 24, nowtime >> 16, nowtime >> 8,
>                          nowtime) < 0)
> @@ -140,8 +147,12 @@ static time64_t pmu_get_time(void)
>         if (req.reply_len != 4)
>                 printk(KERN_ERR "pmu_get_time: got %d byte reply from PMU\n",
>                        req.reply_len);
> -       now = (req.reply[0] << 24) + (req.reply[1] << 16)
> -               + (req.reply[2] << 8) + req.reply[3];
> +       now = (u32)((req.reply[0] << 24) + (req.reply[1] << 16) +
> +                   (req.reply[2] << 8) + req.reply[3]);
> +
> +       /* it's either after year 2040, or the RTC has gone backwards */
> +       WARN_ON(now < RTC_OFFSET);
> +
>         return now - RTC_OFFSET;
>  }
>
> @@ -149,10 +160,10 @@ static time64_t pmu_get_time(void)
>
>  static int pmu_set_rtc_time(struct rtc_time *tm)
>  {
> -       time64_t nowtime;
> +       u32 nowtime;
>         struct adb_request req;
>
> -       nowtime = rtc_tm_to_time64(tm) + RTC_OFFSET;
> +       nowtime = lower_32_bits(rtc_tm_to_time64(tm) + RTC_OFFSET);
>         if (pmu_request(&req, NULL, 5, PMU_SET_RTC, nowtime >> 24,
>                         nowtime >> 16, nowtime >> 8, nowtime) < 0)
>                 return -ENXIO;
> --
> 2.9.0
>
