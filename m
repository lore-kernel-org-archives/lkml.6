Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454E4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D742086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXVuxutt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfARME7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:04:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42134 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfARME6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:04:58 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so6283333plp.9;
        Fri, 18 Jan 2019 04:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9ivMpsQH7Sopdj0yxoUpxKSRkYdEf1RapYxunaBr/wc=;
        b=FXVuxuttU5bj6Xq8PgxHwO4Vin2m+3alydXOIIVcGVGQG73lEzvj06tYMmH45BRREg
         cJSKDxx43ArdCLrV1XS8NnQanfoaiVPUQVPQiyCiz++KIHs4WK+c0gG/8czF/P2nhjaW
         VJTkiJ068owtWI1dZquEoec+gdMHWkLgLYcu8SDg1YpcQFWnKjyhHyR9LGYKV9Cow+rZ
         mYZGP8iK5cXkQ7/O3gQB6iOyiqCOkOfugX7sZG8Kibn2Lrwg/ril9Dt/f44Xdjvc7xvg
         gDy99O4R4of0+LBRdEXMmujO2rpjrzDziXJ8CEDN4oz2MLh6jLCgTnV67LBOojIa0YRb
         +scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9ivMpsQH7Sopdj0yxoUpxKSRkYdEf1RapYxunaBr/wc=;
        b=rfQH5j4/EXziMiszJgZn0RhRq+lgIu14ObJ/YHQKlQNpRCjTLeygeeQfzqRrB48rqa
         AwJcCAIUqQhx8m8dpFnb8Cm/KjsbWbJ0EKwGIZN8R6vvOMrBhYgmSj8kDjt/3G2xEcR1
         7GCen3NorClHJS6TC/j45Mk8rqmDfS+RjYeU2MxeslD06nEs/mKdBsrNryxDXA09ZW1u
         ZFUI+EfLg6AXs4VDfChbHREDRmmqnbpOm6d7+BMQCzMDJ8hHQeEHVtbav9hjk/WwJAod
         fNkN7CTlFmMt6eJajFyg3R4R/1kUa17WTL2WsVEQLY0OypM9ZfOkGDeqzCuUOQmeN1hg
         KCfA==
X-Gm-Message-State: AJcUukdlNNNWTGg48KmAProQfHg2aTnmTuv5By0TuQNcFbY/notJOnMR
        h973V+MDAbLhvYfTLz3DOU8=
X-Google-Smtp-Source: ALg8bN7O535JR0TcCrIvRgUfprqPoDMsDmS0RARMcZbJSI9njms6VCXaV8lYyUfzX96h0iCmcm1LPw==
X-Received: by 2002:a17:902:6909:: with SMTP id j9mr18459660plk.196.1547813097854;
        Fri, 18 Jan 2019 04:04:57 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l74sm7887775pfb.145.2019.01.18.04.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 04:04:56 -0800 (PST)
Subject: Re: [PATCH v5 3/3] PM/runtime:Replace jiffies based accounting with
 ktime based accounting
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        ulf.hansson@linaro.org
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
 <1545388436-7489-4-git-send-email-vincent.guittot@linaro.org>
 <20190117221628.GA21979@roeck-us.net> <20190118104215.GA13168@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <03a594f1-d6bb-2e29-aac7-034cd2d9af45@roeck-us.net>
Date:   Fri, 18 Jan 2019 04:04:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190118104215.GA13168@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 2:42 AM, Vincent Guittot wrote:
> Hi Guenter,
> 
> Le Thursday 17 Jan 2019 à 14:16:28 (-0800), Guenter Roeck a écrit :
>> On Fri, Dec 21, 2018 at 11:33:56AM +0100, Vincent Guittot wrote:
>>> From: Thara Gopinath <thara.gopinath@linaro.org>
>>>
>>> This patch replaces jiffies based accounting for runtime_active_time
>>> and runtime_suspended_time with ktime base accounting. This makes the
>>> runtime debug counters inline with genpd and other pm subsytems which
>>> uses ktime based accounting.
>>>
>>> timekeeping is initialized before pm_runtime_init() so ktime_get() will
>>> be ready before first call. In fact, timekeeping_init() is called early
>>> in start_kernel() which is way before driver_init() (and that's when
>>> devices can start to be initialized) called from rest_init() via
>>> kernel_init_freeable() and do_basic_setup().
>>>
>> This is not (always) correct. My qemu "collie" boot test fails with this
>> patch applied. Reverting the patch fixes the problem. Bisect log attached.
>>
> 
> Can you try the patch below ?
> ktime_get_mono_fast_ns() has the advantage of being init with dummy clock so
> it can be used at early_init.
> 
Yes, that works.

Guenter

> ---
>   drivers/base/power/runtime.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index ae1c728..118c7f6 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -66,7 +66,7 @@ static int rpm_suspend(struct device *dev, int rpmflags);
>    */
>   void update_pm_runtime_accounting(struct device *dev)
>   {
> -	u64 now = ktime_to_ns(ktime_get());
> +	u64 now = ktime_get_mono_fast_ns();
>   	u64 delta;
>   
>   	delta = now - dev->power.accounting_timestamp;
> @@ -1507,7 +1507,7 @@ void pm_runtime_init(struct device *dev)
>   	dev->power.request_pending = false;
>   	dev->power.request = RPM_REQ_NONE;
>   	dev->power.deferred_resume = false;
> -	dev->power.accounting_timestamp = ktime_to_ns(ktime_get());
> +	dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
>   	INIT_WORK(&dev->power.work, pm_runtime_work);
>   
>   	dev->power.timer_expires = 0;
> 

