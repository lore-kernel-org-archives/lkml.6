Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2A9C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9491208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kX4ODAlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9491208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934536AbeFRPrl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:47:41 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33007 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933524AbeFRPri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:47:38 -0400
Received: by mail-io0-f196.google.com with SMTP id d185-v6so17263495ioe.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tOnjkKeADz3nJ/gip7p6u950ufjqLcXizLv/Itz+7U0=;
        b=kX4ODAlr9a/PVTwGZEAzsqsY/NtiI/iBnaoI7J/RGLOptSVkhIkzKBkoWSCGmbLqPm
         lMSIoNDXqI/6oiPEh2PjFqqzNH3RPHBPcuH1BjiArexgWaSVhoYqc3ad4AuwvZsofv+z
         7ghjcvWqkHUVNkp/cu6/7K7gD+zhTL3Diq000=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tOnjkKeADz3nJ/gip7p6u950ufjqLcXizLv/Itz+7U0=;
        b=LYDuSnpawoiPA6sxvYMZJSqudyh4Yqz+lonz2xV8n/3tCIyN4vfICBmn/C/4ai9D8a
         JJu5KoIixxkz1/i3sXCDzjwYEHqgLHhssTyRhHARStDrvfyWVGBTqxtHJMpEpPCgQo1A
         0j4fWdurY9vKDIwJ+tnmvCODOnvCL7i3NxMXoTfzpcxStG3jNbOHuZg8TdNBlapZ4a9y
         kFxaWeGuRmjTQMZ2sYF8vLg/TKNhz2/Ps+C08wKB8pYR8ZFSRD2ZHSt//X7GdRjgRLBw
         lJPp5QsEsFVBnd0hPxs0pJzgdscBy4pzoATpYNHXzIQIQi8P/GLs23oKOXhsLHrEidiD
         4kFw==
X-Gm-Message-State: APt69E0xB7K8MHi/i1o8pTQrzQ42l/L//BdFO9YYG1xw/PYCCBvJKU9o
        2Wp+pjzcF5U1YloQKuztDQFMKLrc4E0i9vMqpE+OMA==
X-Google-Smtp-Source: ADUXVKIN0Q+0SmweCmAOO7vfVHaZBY6sEyGI6Tg99f+ZY5w/KV8NJywFreWM1N08BTLx+AJNRXycaPA8NwLi8q+ygGI=
X-Received: by 2002:a6b:dd0b:: with SMTP id f11-v6mr10388845ioc.173.1529336857804;
 Mon, 18 Jun 2018 08:47:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 08:47:37
 -0700 (PDT)
In-Reply-To: <20180618141811.3353245-1-arnd@arndb.de>
References: <20180618141811.3353245-1-arnd@arndb.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 18 Jun 2018 17:47:37 +0200
Message-ID: <CAKv+Gu-r_+b_tCXeZeE6=EN3=1N98rheODOwV_4mpb9GMzdqrQ@mail.gmail.com>
Subject: Re: [PATCH] efi: cper: avoid using get_seconds()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        gengdongjiu <gengdongjiu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 June 2018 at 16:17, Arnd Bergmann <arnd@arndb.de> wrote:
> get_seconds() is deprecated because of the 32-bit time overflow
> in y2038/y2106 on 32-bit architectures. The way it is used in
> cper_next_record_id() causes an overflow in 2106 when unsigned UTC
> seconds overflow, even on 64-bit architectures.
>
> This starts using ktime_get_real_seconds() to give us more than 32 bits
> of timestamp on all architectures, and then changes the algorithm to use
> 39 bits for the timestamp after the y2038 wrap date, plus an always-1
> bit at the top. This gives us another 127 epochs of 136 years, with
> strictly monotonically increasing sequence numbers across boots.
>
> This is almost certainly overkill, but seems better than just extending
> the deadline from 2038 to 2106.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/firmware/efi/cper.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 3bf0dca378a6..b73fc4cab083 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -48,8 +48,21 @@ u64 cper_next_record_id(void)
>  {
>         static atomic64_t seq;
>
> -       if (!atomic64_read(&seq))
> -               atomic64_set(&seq, ((u64)get_seconds()) << 32);
> +       if (!atomic64_read(&seq)) {
> +               time64_t time = ktime_get_real_seconds();
> +
> +               /*
> +                * This code is unlikely to still be needed in year 2106,
> +                * but just in case, let's use a few more bits for timestamps
> +                * after y2038 to be sure they keep increasing monotonically
> +                * for the next few hundred years...
> +                */
> +               if (time < 0x80000000)
> +                       atomic64_set(&seq, (ktime_get_real_seconds()) << 32);
> +               else
> +                       atomic64_set(&seq, 0x8000000000000000ull |
> +                                          ktime_get_real_seconds() << 24);
> +       }

Given that these values are never decoded and interpreted as
timestamps, can't we simply switch to the second flavour immediately?

>
>         return atomic64_inc_return(&seq);
>  }
> --
> 2.9.0
>
