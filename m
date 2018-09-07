Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28454C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65FB20652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65FB20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeIGMaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:30:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43197 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbeIGMaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:30:01 -0400
Received: by mail-lf1-f66.google.com with SMTP id h64-v6so11279394lfi.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 00:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=rJi+GQRrL6Vi3lArdcK16IGEIVG9+K1joB7p0BmQqt4=;
        b=LojKezxmm5cCxUKaGg5WjnljSCeXTKKaMsna/ZVgxmllBZdNsEeUx/8gCvn9qW31wt
         A5hC5uwA74cqfpSaCzdwMMEFTvvLE+IcFNHyH6VByAkpPQyoOGbLSAVod3mHog14mLaK
         Ev2OmJ8Q2M/7TVTNIxNxA9o1u8su3gbvDBEETAlUk3X9NyIO/BsJTACCKy5ClV6xmgmX
         R47jnW/tbAZLqXo7P6MBu5lDIJ7hcMvy47M4FPmBn1S7US764DQF8PiCWa0lUiLQ67y6
         kkTHRkNcbb2dFVslTTj/ASuEcY5Falry4nrRBrPemQ+ixu927f1xnbdfpj7UeBJ187gg
         0gew==
X-Gm-Message-State: APzg51AelPM4E0fzC8XclYS/NNe7ZV873w/ECxOQdPbkLVSVPB0lz/3f
        vi0TCEw+pFfO7+6ziMUpUmM/lWen6slaUMp5E5s=
X-Google-Smtp-Source: ANB0VdZUQeFp/Xc9jrxrzbkEB0lFfGPJOeQxheSfenBKE6znD5mOy9Oi+ZOJtfhb8Du46UwGFTKQUafZ5Qc1yZJF3X4=
X-Received: by 2002:a19:73c5:: with SMTP id h66-v6mr4105215lfk.22.1536306618062;
 Fri, 07 Sep 2018 00:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180821172822.30975-1-peter@korsgaard.com>
In-Reply-To: <20180821172822.30975-1-peter@korsgaard.com>
From:   Peter Korsgaard <peter@korsgaard.com>
Date:   Fri, 7 Sep 2018 09:50:06 +0200
Message-ID: <CACXmViaj6XWUXmdFov_1-exCd5idDx2s-2_kfmDFydN75wUNNQ@mail.gmail.com>
Subject: Re: [PATCH] ttyprintk: make the printk log level configurable
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 7:28 PM Peter Korsgaard <peter@korsgaard.com> wrote:
>
> For some use cases it is handy to use a different printk log level than the
> default (info) for the messages written to ttyprintk, so add a Kconfig
> option similar to what we have for default console loglevel.

Ping? Feedback, comments?

> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index ce277ee0a28a..14a7f023f20b 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -66,6 +66,14 @@ config TTY_PRINTK
>
>           If unsure, say N.
>
> +config TTY_PRINTK_LEVEL
> +       depends on TTY_PRINTK
> +       int "ttyprintk log level (1-7)"
> +       range 1 7
> +       default "6"
> +       help
> +         Printk log level to use for ttyprintk messages.
> +
>  config PRINTER
>         tristate "Parallel printer support"
>         depends on PARPORT
> diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
> index 67549ce88cc9..22fbd483b5dc 100644
> --- a/drivers/char/ttyprintk.c
> +++ b/drivers/char/ttyprintk.c
> @@ -37,6 +37,8 @@ static struct ttyprintk_port tpk_port;
>   */
>  #define TPK_STR_SIZE 508 /* should be bigger then max expected line length */
>  #define TPK_MAX_ROOM 4096 /* we could assume 4K for instance */
> +#define TPK_PREFIX KERN_SOH __stringify(CONFIG_TTY_PRINTK_LEVEL) " [U]"
> +
>  static int tpk_curr;
>
>  static char tpk_buffer[TPK_STR_SIZE + 4];
> @@ -45,7 +47,7 @@ static void tpk_flush(void)
>  {
>         if (tpk_curr > 0) {
>                 tpk_buffer[tpk_curr] = '\0';
> -               pr_info("[U] %s\n", tpk_buffer);
> +               printk(TPK_PREFIX " %s\n", tpk_buffer);
>                 tpk_curr = 0;
>         }
>  }
> --
> 2.11.0
>

-- 
Bye, Peter Korsgaard
