Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F3DC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAB220846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nghqM9T+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAB220846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754200AbeFTO3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754131AbeFTO3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:29:19 -0400
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com [209.85.223.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9EF920875;
        Wed, 20 Jun 2018 14:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529504958;
        bh=Fs+mO2Ed87m1tVtstPbu/lGb9ID9rfQpyN5j87Iqj0k=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=nghqM9T+22JXbz1uGUzF8veXaE3ZuVRuzCK7kh0SjIkqi0zD+gMj0i1eYZ7r7QW67
         cEBUxzVM7C/aGhg6Au0bmoERKMjKbhF5Fu+8N+Qb9BiiCC6ZHHulBr4G/qn9RWrSOh
         vqfgxuW0RVdvonjomEfDK8RQz/1vQu/biR0Tr2ec=
Received: by mail-io0-f172.google.com with SMTP id g22-v6so3631257iob.7;
        Wed, 20 Jun 2018 07:29:18 -0700 (PDT)
X-Gm-Message-State: APt69E2TFjAecwK7GSddEySk4gyMeVYC/gkDaRSaKnQu+XjbtmyrJUCu
        gN1Yq5WMJOUKiJbL3Jb9t1eETZnMV/GIrnZYbQ==
X-Google-Smtp-Source: ADUXVKK28nFp2V9EBLKOGb54Pylfg/fKTpGlprCIxJe6X//BRIte+Mm9Lh37xgSB3EtAIU/kCAtX1OG7vfp50PdRaIw=
X-Received: by 2002:a5e:9407:: with SMTP id q7-v6mr17891340ioj.268.1529504958087;
 Wed, 20 Jun 2018 07:29:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6403:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 07:28:57
 -0700 (PDT)
In-Reply-To: <20180620023903.242758-1-toddpoynor@gmail.com>
References: <20180620023903.242758-1-toddpoynor@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 20 Jun 2018 08:28:57 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+8J=BgrFAA2bdA1UcmpeYdZWHybwtyy+gq94bZaK8bKg@mail.gmail.com>
Message-ID: <CAL_Jsq+8J=BgrFAA2bdA1UcmpeYdZWHybwtyy+gq94bZaK8bKg@mail.gmail.com>
Subject: Re: [PATCH] drivers: base: initcall_debug logs for driver probe times
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Todd Poynor <toddpoynor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 8:39 PM, Todd Poynor <toddpoynor@gmail.com> wrote:
> From: Todd Poynor <toddpoynor@google.com>
>
> Add initcall_debug logs for each driver device probe call, for example:
>
>    probe of a3800000.ramoops returned after 3007 usecs
>
> This replaces the previous code added to report times for deferred
> probes.  It also reports OF platform bus device creates that were
> formerly lumped together in a single entry for function
> of_platform_default_populate_init, as well as helping to annotate other
> initcalls that involve device probing.
>
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
>  drivers/base/dd.c | 50 +++++++++++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 1435d7281c66..56db446a467a 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -62,26 +62,6 @@ static bool initcalls_done;
>   */
>  static bool defer_all_probes;
>
> -/*
> - * For initcall_debug, show the deferred probes executed in late_initcall
> - * processing.
> - */
> -static void deferred_probe_debug(struct device *dev)
> -{
> -       ktime_t calltime, delta, rettime;
> -       unsigned long long duration;
> -
> -       printk(KERN_DEBUG "deferred probe %s @ %i\n", dev_name(dev),
> -              task_pid_nr(current));
> -       calltime = ktime_get();
> -       bus_probe_device(dev);
> -       rettime = ktime_get();
> -       delta = ktime_sub(rettime, calltime);
> -       duration = (unsigned long long) ktime_to_ns(delta) >> 10;
> -       printk(KERN_DEBUG "deferred probe %s returned after %lld usecs\n",
> -              dev_name(dev), duration);
> -}
> -
>  /*
>   * deferred_probe_work_func() - Retry probing devices in the active list.
>   */
> @@ -125,11 +105,7 @@ static void deferred_probe_work_func(struct work_struct *work)
>                 device_pm_move_to_tail(dev);
>
>                 dev_dbg(dev, "Retrying from deferred list\n");
> -               if (initcall_debug && !initcalls_done)
> -                       deferred_probe_debug(dev);
> -               else
> -                       bus_probe_device(dev);
> -
> +               bus_probe_device(dev);
>                 mutex_lock(&deferred_probe_mutex);
>
>                 put_device(dev);
> @@ -527,6 +503,25 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>         return ret;
>  }
>
> +/*
> + * For initcall_debug, show the driver probe time.
> + */
> +static int really_probe_debug(struct device *dev, struct device_driver *drv)
> +{
> +       ktime_t calltime, delta, rettime;
> +       unsigned long long duration;

Probably should be s64.

> +       int ret;
> +
> +       calltime = ktime_get();
> +       ret = really_probe(dev, drv);
> +       rettime = ktime_get();
> +       delta = ktime_sub(rettime, calltime);
> +       duration = (unsigned long long) ktime_to_ns(delta) >> 10;

Is avoiding a divide really worth optimizing here compared to the
flood of messages typically on the serial port? Just use ktime_to_us.
Perhaps just get rid of duration and do the conversion in the printk
arg.

> +       printk(KERN_DEBUG "probe of %s returned after %lld usecs\n",
> +              dev_name(dev), duration);

Including the return code here too would be good.

> +       return ret;
> +}
> +
>  /**
>   * driver_probe_done
>   * Determine if the probe sequence is finished or not.
> @@ -585,7 +580,10 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
>                 pm_runtime_get_sync(dev->parent);
>
>         pm_runtime_barrier(dev);
> -       ret = really_probe(dev, drv);
> +       if (initcall_debug && !initcalls_done)
> +               ret = really_probe_debug(dev, drv);
> +       else
> +               ret = really_probe(dev, drv);
>         pm_request_idle(dev);
>
>         if (dev->parent)
> --
> 2.18.0.rc1.244.gcf134e6275-goog
>
