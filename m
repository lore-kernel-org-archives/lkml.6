Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EC9C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BB720850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLzKMTPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BB720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeLDTZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:25:43 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35070 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeLDTZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:25:43 -0500
Received: by mail-yw1-f66.google.com with SMTP id h32so7464691ywk.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QOg6aNcJr1LQ7jAnnZQn6cnT30WyrQH2omgagch31qU=;
        b=JLzKMTPAxNKMl9OJ0JnfJxdS+jvQrSVktsCKY05zGofV9GRG158An8xO7Y0UoabwTB
         r7/WLg4ZzfmE9nvyGV8S75W7Qd8bwMwLNaSZjkbijleiy3rbXRZ9o7YC+his5iPEIVSh
         bV3QJyeWjCty/0yezB/FW5AYzASB9QL7GKCG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QOg6aNcJr1LQ7jAnnZQn6cnT30WyrQH2omgagch31qU=;
        b=pULv2SmG0KyHew6bQ//0Ltf8rqAupL0IztW2SLpK4/9EY7vKuTsHjralfM/QNWcAsU
         aBz3cxm1fcwduhb8QZpyTbtLWAwcwhH33sl5kLmXxX058SlLdRXlJABl5xloiSkwv8Jc
         RAjE5ahIlkEDvEtXtaxOM+xzFhOz3Dst66NmpZlB7qQFSXEOMY7wNzKgSC4Xa+GUVWx5
         5wBjgNAZeW2P5HKHOEdJrMxunaM2Wc7h5PTVwd092WBnhKH8DNJxT58uMnOuMd7t6rnu
         YMvTniTZ1qVsU1dV/ajuxtPDN89lLQsSMdRq6SgwdFd8VOkyy19uepBZphXFjLRTLmNk
         9o9Q==
X-Gm-Message-State: AA+aEWa3C2jY3+Oz+5J9ISjdqfN6irXcLasOfoUBPr41Tq6kmuPukMoS
        eDogd/hl/iUbjnPydRceWAQdUWQpRuUz4mOtK2upAg==
X-Google-Smtp-Source: AFSGD/UjJ6NCQDWd3O3Xf2OCzZtaZuSW+MEc2k2UdWTzt2JOjOUqklIBIx0TGuKyKLOCS1dUqf64PARvW45TkV301fA=
X-Received: by 2002:a81:e40b:: with SMTP id r11mr21086209ywl.56.1543951542441;
 Tue, 04 Dec 2018 11:25:42 -0800 (PST)
MIME-Version: 1.0
References: <20181204191229.6851-1-anders.roxell@linaro.org>
 <20181204141908.76e7afa5@vmware.local.home> <20181204142142.4e2e2169@vmware.local.home>
In-Reply-To: <20181204142142.4e2e2169@vmware.local.home>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 4 Dec 2018 20:25:31 +0100
Message-ID: <CADYN=9LNunVkSTzg1fri7Mu7mbu8gFPpgnFfCRQk4T61JXt1_A@mail.gmail.com>
Subject: Re: [PATCH] tracing: add cond_resched to ftrace_replace_code()
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 at 20:21, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 4 Dec 2018 14:19:08 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > > @@ -2435,6 +2438,13 @@ void __weak ftrace_replace_code(int enable)
> > >                     /* Stop processing */
> > >                     return;
> > >             }
> > > +           /*
> > > +            * Some archs calls this function with interrupts or preemption
> > > +            * disabled. Howeve, other archs don't and this can cause a
>
> typo "However". But could you write it this way:
>
>         "However, for other archs that can preempt, this can cause an
>         tremendous unneeded latency."
>

I'll fix this and move it up (where I added it in the first place but
moved it) =)

Cheers,
Anders

> Thanks!
>
> -- Steve
>
> > > +            * tremendous unneeded latency.
> > > +            */
> >
> > Actually, could you move the comment up where schedulable gets set?
> >
> > Thanks!
> >
> > -- Steve
> >
> > > +           if (schedulable)
> > > +                   cond_resched();
> > >     } while_for_each_ftrace_rec();
> > >  }
> > >
> >
>
