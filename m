Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0F7C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D715D208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D715D208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754418AbeGIHH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 03:07:28 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:46068 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752894AbeGIHHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 03:07:25 -0400
Received: by mail-ua0-f195.google.com with SMTP id z4-v6so11068689uao.12;
        Mon, 09 Jul 2018 00:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+Ei7Tkwy8q6+P8lfrNS7E9p8YvClJ8nHDB4mGBSvCA=;
        b=bHT7dyDsJXFJYKRcofdiHTelIdEs1LjwKTGRhkD3Tl21g4RpSJSUwlR/WMhTP+yJbV
         wpFf5GjZMWtIJmojfyic64/EZgV9echkCVACxS2BjvvCFKgwGmi/mWpTomsJ1hW9LqZ0
         PBe7xN0vBJ952UFr8TiyirymVti2n/CwCcNs4ueiUv/4cxFqhH81PEh1reGGZxLR86aE
         DtG9sM/f4WKPi7+DPEohkbDR81nEbbSa5lKlOcOVGKfoiyxWOgMNcZ3PYK7a1o9B91SL
         lSbknqzBCOtlvvr0WnWDnc0TbGQ17xcf9Niy21FXUk2q6sAJ38NWcJXtgUEG0eydzAPf
         bJeA==
X-Gm-Message-State: APt69E3ThiQRVsUVnP7Ka3NjaObFDoH9xwxsq4QQPlM/8xy5UwPMT4GY
        oNDe1spB7CSR7hZlt8A34wa41sWUTjwJ+cP8Ug4=
X-Google-Smtp-Source: AAOMgpfwWPTP0eM67HqNyvyOWR9yD5GJueqUKWJ4t+X44IU2VfvOFPICcABYykTM45aluRfXDwF2X2mZhqJ0ki2gdRc=
X-Received: by 2002:ab0:80e:: with SMTP id a14-v6mr12938549uaf.114.1531120044756;
 Mon, 09 Jul 2018 00:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180709044444.6397-1-abrodkin@synopsys.com> <20180709054842.GB7618@kroah.com>
In-Reply-To: <20180709054842.GB7618@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Jul 2018 09:07:13 +0200
Message-ID: <CAMuHMdVBBu6gho_JVQTiOHxVFHqX2MUxS_c-6-x50OEu4OqpRQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
To:     Greg KH <greg@kroah.com>
Cc:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 7:49 AM Greg KH <greg@kroah.com> wrote:
> On Mon, Jul 09, 2018 at 07:44:44AM +0300, Alexey Brodkin wrote:
> > Depending on ABI "long long" type of a particular 32-bit CPU
> > might be aligned by either word (32-bits) or double word (64-bits).

Or even 16-bit (on e.g. m68k).

> > --- a/drivers/base/devres.c
> > +++ b/drivers/base/devres.c
> > @@ -24,8 +24,12 @@ struct devres_node {
> >
> >  struct devres {
> >       struct devres_node              node;
> > -     /* -- 3 pointers */
> > -     unsigned long long              data[]; /* guarantee ull alignment */
> > +     /*
> > +      * Depending on ABI "long long" type of a particular 32-bit CPU
> > +      * might be aligned by either word (32-bits) or double word (64-bits).

or even 16-bit (on e.g. m68k).

> > +      * Make sure "data" is really 64-bit aligned for any 32-bit CPU.
> > +      */
> > +     unsigned long long              data[] __aligned(sizeof(unsigned long long));
> >  };
>
> Does this change the padding today for any other arches?  If so, does
> the increased memory usage cause any noticable issues?

Yes it does. struct devres_node contains an odd number of pointers, so
there will be a hole between node and data on all 32-bit architectures.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
