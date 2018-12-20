Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DFFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B732177E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545302141;
	bh=I14Xhu5863uA8WlGUYullK5C6m7PshxnfuxRuhCTakM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SuRPeNbtDPMALSjNUXiPQNBlG0DRhc8mAuE89F62JvTX8tfDKrjdE1/cKDwxfwEMT
	 ByoEQpiyNpdOMLrUjqNbtuKXNV5GAH1u7FWnnmOPbY4EK+093Xg+6Er/A/5rYwUkSU
	 zVWI9KpzIxowicXR51zmGhpVT+a1Z0Upo9/xQOyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbeLTKfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 05:35:39 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38013 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbeLTKfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 05:35:39 -0500
Received: by mail-ot1-f66.google.com with SMTP id e12so1140500otl.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 02:35:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eLCDsw0Ehg/InjXwwxdbQFCOnNOo69hsIb55rOLFQHM=;
        b=NxLTuiO/Z/97+H0otLLEiL7eFhmTG6K72tGNFqD1VGYOp+GH9vplfDrmgaW0iWQN6W
         XF3t5gwQxoj0XsWsZlBcXrQOuMAeVcEuzYqFWp64i5+aTsgYUgdh6WQfEkGuMd24uj+n
         sVhE8BRhIorwlwUU9TNq6DjFrz34Xc+2ETp/KXWqcBNRfd7EOOg8H3icNw/Lx+YKqeex
         A4kWU7uKnOzSLqLYt6dD48RCsFYtkbtrq3buljp1x/NPJyO1LkpdLj0SvmQsTTZ/PZC+
         CJyAbSO3X9q//U90LkEwpJPvdXqcFjH88EvhKh8kDZupaiO8Oby1XbjxPyMuzZTSIxTV
         Jo7A==
X-Gm-Message-State: AA+aEWamBOB9frcAtx8PFJwNfUXNmVjTpGEM0W40qRozVxB33wl0POS9
        8UeYf/pnhJirI3TfK52rc6yi9SttA3r3zyd63Mc=
X-Google-Smtp-Source: AFSGD/WTF7cj30vtsipQOAdHMfLuUdcEidVbwt1UCFNuvVwEqDxfWOkCiGXFL7A/0DPW0p3vnhDmFHEQfQh0FN2nQhc=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr18120855otg.139.1545302137597;
 Thu, 20 Dec 2018 02:35:37 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181220102259eucas1p2f748c68e01cd4e09a266da879722e218@eucas1p2.samsung.com>
 <20181220102247.4911-1-a.hajda@samsung.com> <20181220102247.4911-2-a.hajda@samsung.com>
In-Reply-To: <20181220102247.4911-2-a.hajda@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Dec 2018 11:35:26 +0100
Message-ID: <CAJZ5v0in=0FVaoUeL=s8CS+pGVpVo460sTXg4MX_P17pss7JbA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] driver core: add probe_err log helper
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        javierm@redhat.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 11:23 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> During probe every time driver gets resource it should usually check for error
> printk some message if it is not -EPROBE_DEFER and return the error. This
> pattern is simple but requires adding few lines after any resource acquisition
> code, as a result it is often omited or implemented only partially.
> probe_err helps to replace such code sequences with simple call, so code:
>         if (err != -EPROBE_DEFER)
>                 dev_err(dev, ...);
>         return err;
> becomes:
>         return probe_err(dev, err, ...);
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

I'm not entirely convinced that the dev_err() log level is adequate
for this purpose, but anyway it looks like this may reduce code
duplication quite a bit, so

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v3:
>   - added 'extern __printf(3, 4)' decorators to probe_err,
>   - changed error logging format - newline at the end,
>   - added empty lines in probe_err around dev_err,
>   - added R-b by Mark and Andy.
> v2:
>   - added error value to log message,
>   - fixed code style,
>   - added EXPORT_SYMBOL_GPL,
>   - Added R-B by Javier (I hope the changes did not invalidate it).
> ---
>  drivers/base/core.c    | 39 +++++++++++++++++++++++++++++++++++++++
>  include/linux/device.h |  3 +++
>  2 files changed, 42 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 0073b09bb99f..7f644f3c41d3 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3099,6 +3099,45 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>
>  #endif
>
> +/**
> + * probe_err - probe error check and log helper
> + * @dev: the pointer to the struct device
> + * @err: error value to test
> + * @fmt: printf-style format string
> + * @...: arguments as specified in the format string
> + *
> + * This helper implements common pattern present in probe functions for error
> + * checking: print message if the error is not -EPROBE_DEFER and propagate it.
> + * It replaces code sequence:
> + *     if (err != -EPROBE_DEFER)
> + *             dev_err(dev, ...);
> + *     return err;
> + * with
> + *     return probe_err(dev, err, ...);
> + *
> + * Returns @err.
> + *
> + */
> +int probe_err(const struct device *dev, int err, const char *fmt, ...)
> +{
> +       struct va_format vaf;
> +       va_list args;
> +
> +       if (err == -EPROBE_DEFER)
> +               return err;
> +
> +       va_start(args, fmt);
> +       vaf.fmt = fmt;
> +       vaf.va = &args;
> +
> +       dev_err(dev, "error %d: %pV", err, &vaf);
> +
> +       va_end(args);
> +
> +       return err;
> +}
> +EXPORT_SYMBOL_GPL(probe_err);
> +
>  static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
>  {
>         return fwnode && !IS_ERR(fwnode->secondary);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 6cb4640b6160..2d3a1cc6f5da 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1591,6 +1591,9 @@ do {                                                                      \
>         WARN_ONCE(condition, "%s %s: " format, \
>                         dev_driver_string(dev), dev_name(dev), ## arg)
>
> +extern __printf(3, 4)
> +int probe_err(const struct device *dev, int err, const char *fmt, ...);
> +
>  /* Create alias, so I can be autoloaded. */
>  #define MODULE_ALIAS_CHARDEV(major,minor) \
>         MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
> --
> 2.17.1
>
