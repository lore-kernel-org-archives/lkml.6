Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A811C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 19:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5B1208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 19:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHDdTtox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5B1208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933902AbeFQTae (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 15:30:34 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38723 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933189AbeFQTab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 15:30:31 -0400
Received: by mail-wr0-f194.google.com with SMTP id e18-v6so14617649wrs.5;
        Sun, 17 Jun 2018 12:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X9pwQuWCL6gho1xv2CjP1+YfCSR0q6nkAETBp85w4Yg=;
        b=dHDdTtoxjj5XVcrY9WXe+OMWgZq4lqUC2STnCLoaIEkddlsP6izFkI1b9LMdR00MVW
         jp8xjfJD2ujrhpYZ+nQzHMvOUUdYl4MkpTJYHwCKrYoVBurqS8i2p4lekAfCQodfn5gI
         ioCbEbMC9V2px6hs4iN9FOVUYns2XX1AVjiT/idjRfIvcdKCw0OSLN4dCi+E10SPw9nZ
         aoDkj0MPcsMFsrhmQ9Qr2IZGrASm5WJYXaYi8RNfniYbs65v7dsImvPKlq2MO+H3BSB7
         cW4VE6Ic1HG/NHmWAisMjUDMrZAVhP8hqR7yRC6su/h71L4hOAYBgQK1lzdvGhEkd+NE
         LRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X9pwQuWCL6gho1xv2CjP1+YfCSR0q6nkAETBp85w4Yg=;
        b=MMmu4IEF2ALhelR4PUp3aozEcuNJAD2+rvrY8rsT4yBEkZONB7+yqjSWdd7ULmFRHl
         hImXi8hlpCXezgFAujEPwiWzbNjnZn2CgFAFyBURwPbQwxR2NvulOHHcSj8kLuVjgk3U
         MS07B8cLwXb3gok84niAtnBrTH+lP1U4CD4/5ubxy2L7kVK7lRNeruH1M5ua9jQjko9x
         mxfp3gQoXkHws//7v5OxS47oc/lA9mHNp2N0MsR4kc8wYvtVMD/RtHqkZjPDdNiA6A9K
         RcyeL7d/Q5PNJlwpQC9na9e+sUMDT0dqAQ3WXvKnHNeg+VuEuOzko09L9ZBKWvk5TSSv
         oolw==
X-Gm-Message-State: APt69E1tz6EAvpcWFTgNP3QoG5RXu8HNCBoAhk8PTfibIypy1eqRbR0s
        fIklKND1tc180Cu6EZvXk78=
X-Google-Smtp-Source: ADUXVKI4CbB3F9XczqKBplxFVG+9Yl01Vo04bS42eXavIJqQ7aaLU4GgMjq58rbC28VsuAE8H+cI3g==
X-Received: by 2002:adf:b219:: with SMTP id u25-v6mr8194163wra.1.1529263830318;
        Sun, 17 Jun 2018 12:30:30 -0700 (PDT)
Received: from [192.168.1.131] ([188.25.245.15])
        by smtp.gmail.com with ESMTPSA id v31-v6sm32189323wrc.80.2018.06.17.12.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 12:30:29 -0700 (PDT)
Message-ID: <1529263827.6069.4.camel@gmail.com>
Subject: Re: wmi: usercopy: Kernel memory overwrite attempt detected to
 spans multiple pages (offset 0, size 4104)
From:   Mihai =?UTF-8?Q?Don=C8=9Bu?= <mihai.dontu@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Date:   Sun, 17 Jun 2018 22:30:27 +0300
In-Reply-To: <CAGXu5jLwA37YJWi50i7bQZ6N7MtctvbXjsVg337zgD11AQ=9SA@mail.gmail.com>
References: <1529182886.3450.3.camel@gmail.com>
         <1529186697.2784.2.camel@gmail.com>
         <CAGXu5jLwA37YJWi50i7bQZ6N7MtctvbXjsVg337zgD11AQ=9SA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-06-17 at 10:36 -0700, Kees Cook wrote:
> On Sat, Jun 16, 2018 at 3:04 PM, Mihai Donțu wrote:
> > On Sun, 2018-06-17 at 00:01 +0300, Mihai Donțu wrote:
> > > While trying to adjust the keyboard backlight mode, I hit this BUG:
> > > 
> > > Jun 16 22:16:07 mdontu-l kernel: usercopy: Kernel memory overwrite attempt detected to spans multiple pages (offset 0, size 4104)!
> 
> CONFIG_HARDENED_USERCOPY_PAGESPAN=y is really only useful for
> debugging special cases. For now, I recommend leaving it disabled,
> since there are a lot of cases it still trips over.
> 
> > I eventually sprinkled some printk-s and got this:
> > 
> >  855         if (copy_from_user(buf, input, wblock->req_buf_size)) {
> >  856                 dev_dbg(&wblock->dev.dev, "Copy %llu from user failed\n",
> >  857                         wblock->req_buf_size);
> >  858                 ret = -EFAULT;
> >  859                 goto out_ioctl;
> >  860         }
> 
> However, since you tracked this one down, I think this would be fixed
> by adjusting the handler_data allocation:
> 
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 8e3d0146ff8c..ea6bf98f197a 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -918,8 +918,8 @@ static int wmi_dev_probe(struct device *dev)
>                 }
> 
>                 count = get_order(wblock->req_buf_size);
> -               wblock->handler_data = (void *)__get_free_pages(GFP_KERNEL,
> -                                                               count);
> +               wblock->handler_data = (void *)
> +                       __get_free_pages(GFP_KERNEL | __GFP_COMP, count);
>                 if (!wblock->handler_data) {
>                         ret = -ENOMEM;
>                         goto probe_failure;
> 

Your patch works OK for me, thank you. The libsmbios tool, however, not
so much. It appears to be behind latest developments.

# echo "+keyboard" >/sys/class/leds/dell\:\:kbd_backlight/start_triggers

is all that is needed today.

Regards,

> But in looking further, I don't know why this is using
> __get_free_pages() instead of kmalloc? In fact, there is a kfree() in
> the error path, which looks wrong:
> 
>         kfree(wblock->handler_data);
> 
> I think this should just be converted to using kmalloc/kfree everywhere.

-- 
Mihai Donțu

