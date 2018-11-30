Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86481C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6962146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EISXwtFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6962146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeK3TfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:35:16 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35644 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbeK3TfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:35:16 -0500
Received: by mail-io1-f67.google.com with SMTP id u19so3880387ioc.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dF6A6KbI7n1ExzCRqtataz/107wdQmD0y3PRdoOGBl0=;
        b=EISXwtFIlibDZBkGx2610HiCrKiXY6ByskDWYsEVr9gAt0F2ZeSJT3UoH1OF+cFjbc
         0Y5lsk1irJh5VMsWexi6FKgVbGVX0BShj14jRAipfbkAGK50fJ75/34JsrsGGYP0Pk0v
         vWP35sQmzD4l4h6sj6XnJ9ukB7Ri8jwh2oEZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dF6A6KbI7n1ExzCRqtataz/107wdQmD0y3PRdoOGBl0=;
        b=GG+GVfVTY2MX4YQKqXx/oDL/T+/5BNV10dWj3w6I/lch1XNVI273Si4BDEYgUQ5LaN
         LsSVJTRlPB1c48v0i3NQfRtBkItvpS6iRoYoxMw9Hag5Fg/NtBDj/Javi5JGt4TuSaI9
         L3ofG/3gwTof4KmcQp72HmMYPwyQ8NH99UDfU8m6NdJ6Yg+q6rFX4uMf0fevD8RlrJ0y
         J6k2FxEBYdFru/jAgvEK4TT+5sAt/VvRA+4B7+KqLsVc1/CTnYb/Pi9uTLTPn+eTV/9h
         WChuhzIuqPVaud5Zc77wGE6Few+9xFr9ThK99sRNxQyMZIwE8iDKShUV06ZU90qQUGtZ
         ztjQ==
X-Gm-Message-State: AA+aEWazQL8erME8UMf2LzDsYeVL+pjXtmCdvXRNZpmYbZ3U39mbSKbw
        1FeyXlcf61a9xVWX7kIqTtCWqStd8AoxNr35QkOkXA==
X-Google-Smtp-Source: AFSGD/U6RxZnKLDH7CridCHrSP2obw/0ECSWCKAVSX/fZWyqB8YhE1THlPW4LA3KYldcQw5j8ioJoQq9XPRDr58yzRk=
X-Received: by 2002:a5d:8402:: with SMTP id i2mr3897501ion.173.1543566404092;
 Fri, 30 Nov 2018 00:26:44 -0800 (PST)
MIME-Version: 1.0
References: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
 <20181129171230.18699-2-ard.biesheuvel@linaro.org> <20181130072952.GA16084@gmail.com>
In-Reply-To: <20181130072952.GA16084@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 30 Nov 2018 09:26:32 +0100
Message-ID: <CAKv+Gu8OMvnxb-n+ubYETRNhm79_H1RkGp+-7N1KF6Hgg3cbCQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] x86/efi: Allocate e820 buffer before calling efi_exit_boot_service
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 at 08:29, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> > From: Eric Snowberg <eric.snowberg@oracle.com>
> >
> > Commit d64934019f6c ("x86/efi: Use efi_exit_boot_services()")
> > introduced a regression on systems with large memory maps
> > causing them to hang on boot. The first "goto get_map" that was removed
> > from exit_boot insured there was enough room for the memory map when
> > efi_call_early(exit_boot_services) was called. This happens when
> > (nr_desc > ARRAY_SIZE(params->e820_table).
> >
> > Chain of events:
> >   exit_boot()
> >     efi_exit_boot_services()
> >       efi_get_memory_map <- at this point the mm can't grow over 8 desc
> >       priv_func()
> >         exit_boot_func()
> >           allocate_e820ext() <- new mm grows over 8 desc from e820 alloc
> >       efi_call_early(exit_boot_services) <- mm key doesn't match so retry
> >       efi_call_early(get_memory_map) <- not enough room for new mm
> >       system hangs
> >
> > This patch allocates the e820 buffer before calling efi_exit_boot_services
> > and fixes the regression.
> >
> > Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/x86/boot/compressed/eboot.c | 65 ++++++++++++++++++++------------
> >  1 file changed, 41 insertions(+), 24 deletions(-)
>
> Any objections against marking this for -stable and filing it in
> efi/urgent? Boot hangs are show-stopper bugs, so distributions would want
> to backport this fix anyway.
>

No objections per se, but this is the kind of patch that might go the
other way as well, so I would prefer to give it some wider coverage at
first, given how quickly patches are taken into -stable.

I can make a note of it and send it to Greg halfway into the next -rc cycle.

> > +     boot_map.map =          &map;
> > +     boot_map.map_size =     &map_size;
> > +     boot_map.desc_size =    &desc_size;
> > +     boot_map.desc_ver =     NULL;
> > +     boot_map.key_ptr =      NULL;
> > +     boot_map.buff_size =    &buff_size;
>
> I have changed this to the canonical style, which is also used elsewhere
> in the file:
>
> >       map.buff_size           = &buff_size;
> >       priv.boot_params        = boot_params;
> >       priv.efi                = &boot_params->efi_info;
> > -     priv.e820ext            = NULL;
> > -     priv.e820ext_size       = 0;
>
> I.e.:
>
> +       boot_map.map            = &map;
> +       boot_map.map_size       = &map_size;
> +       boot_map.desc_size      = &desc_size;
> +       boot_map.desc_ver       = NULL;
> +       boot_map.key_ptr        = NULL;
> +       boot_map.buff_size      = &buff_size;
> +
> +       status = efi_get_memory_map(sys_table, &boot_map);
>

Excellent, thanks.
