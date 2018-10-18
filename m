Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70D7C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6964021479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6964021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeJRQcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:32:01 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36330 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeJRQcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:32:00 -0400
Received: by mail-qk1-f195.google.com with SMTP id q184-v6so199701qkd.3;
        Thu, 18 Oct 2018 01:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R8sDPwY4l3gEUHyt0euGvwGTWuIF0k6mhka7sPoXV/0=;
        b=P3OY9/tfIBoGQW6pc0kebiPkm5gOEyNpx2LzNT6xEDGEBlqXqjEC6peElkrNjhCM2D
         FunS+7l8c526wG0QafJmJzyH+ndH8451jmvsWW02nycsHdIthO1EsdpY7eDql0e7iiTW
         e+16LJmVJ6rOuEOMxPY7N+JxDzFjFXGh5Wx+1MAK6ioRfnzQgOvpzRN5wlWPV8JdKXPE
         FB6CE7IPsW3/FvQYO5vOd96Mimvl/pSop/67/1zd4IYlXU1DgFKqK8VvDvYNOTHsOS23
         xReLJBU5XAGJbcgZcwMjCcr35UISTWt7Gf8HVctd19V5w1F4gXhhzq8FDhHmwltnc9dn
         p3rw==
X-Gm-Message-State: ABuFfog5dr2VFY1KRsbCEUwEQ0mmb106tuFZZZ4JT5KoinaoRABAfVNC
        V+enESskwrAMjU0Abrfak8sJcjcm/eFmt0680iHaEA==
X-Google-Smtp-Source: ACcGV62SJO1bxSx2KCnm+cD5ZcHEWq0NTACMxezfKFTCiCVpq3wCpLOnqZIQsT+0Mb3SoeUIk1gdcvaYB+wKPcIw6pI=
X-Received: by 2002:a37:e21a:: with SMTP id g26-v6mr27242186qki.330.1539851525372;
 Thu, 18 Oct 2018 01:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <27589f69f513177892d39868050dccb5f21023aa.1539655732.git.ren_guo@c-sky.com>
 <CAK8P3a2vwe=4SqKfyGruKEJ1yd7txbdBqw6kD_3pN47F8u7OAA@mail.gmail.com> <20181018024929.GC13314@guoren-Inspiron-7460>
In-Reply-To: <20181018024929.GC13314@guoren-Inspiron-7460>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 18 Oct 2018 10:31:48 +0200
Message-ID: <CAK8P3a1Mg3X-hwQ0DS7NB6t++2OO3SfKQj5V==Fp3tZZDdKzrA@mail.gmail.com>
Subject: Re: [PATCH V9 12/21] csky: ELF and module probe
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 4:49 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> On Wed, Oct 17, 2018 at 05:18:49PM +0200, Arnd Bergmann wrote:
> > On Tue, Oct 16, 2018 at 5:02 AM Guo Ren <ren_guo@c-sky.com> wrote:
> > >
> > > This patch adds ELF definition and module relocate codes.
> > >
> > > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> >
> > > +#ifdef __cskyBE__
> > > +#define ELF_DATA       ELFDATA2MSB
> > > +#else
> > > +#define ELF_DATA       ELFDATA2LSB
> > > +#endif
> >
> > You removed support for big-endian, right? I guess the #ifdef can also
> > get removed here then. Aside from that,
> Now, we only support little-endian and it could be removed. But maybe we
> need support big-endian in future, so I keep it here.

Ok, just made sure it was intentional.

       Arnd
