Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71796C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D66205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D66205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbeH3Ptk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:49:40 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40565 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbeH3Ptj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:49:39 -0400
Received: by mail-qt0-f196.google.com with SMTP id h4-v6so9351358qtj.7;
        Thu, 30 Aug 2018 04:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BvF7K72jEWeISoisGQ8jfqvyvn82QaMD91dmGFmWyiY=;
        b=fqRUyzgHWTmFgA25imDPmlXiP4UH0bTEHZFjC/YXJK/JEXTXYhhqvbj8hXCdJmMVhK
         oiR9l7fy3RhjFJWEoKIeaKrOgdCviGGvDY4KfrAXGdVfbMsTPWci9KJxGmxQb571qPYw
         nhZ3IrP3CUdXnoNCqrijvDXzuUbECiCJCHgBTydJWjJ6TIjD7IHepOWa1A/qQzYmc2Fl
         FBwiCac0GoSqKSVsXurmLZ35WmEu+oEnXXQ6KfxmyYmWw8G68GTAGF7beOnKoPuE4R2m
         3EhgXdh0MULY5NGLKJL3PLY8Lb2dIudxIbnxdxlFlrMOG7A1WNmQZKFq7wIa3S0dkfxN
         vW2w==
X-Gm-Message-State: APzg51AMeKVEW4IJnLRtdlJqlk9GTRhkBTijVYgaN0/Z4m864F4FAZeN
        Kg8cuTwkoWNFT0VXa8ywrL3He+WtiLHn4cBSFWE=
X-Google-Smtp-Source: ANB0VdYY/heCjk7rU2sJa3rVGhbJfmQq3zBi/dHnfyH/8Y0DA8NJK+8ZGdbpPtnOgXubVnUijvfcmB5ZuNZj6x640K8=
X-Received: by 2002:a0c:a8cc:: with SMTP id h12-v6mr11110668qvc.161.1535629674136;
 Thu, 30 Aug 2018 04:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180829140409.833488-1-arnd@arndb.de> <20180829140409.833488-5-arnd@arndb.de>
 <20180830110601.GA19534@alphalink.fr>
In-Reply-To: <20180830110601.GA19534@alphalink.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 30 Aug 2018 13:47:37 +0200
Message-ID: <CAK8P3a0B0u7dRajmTKZwXnuxjAiARJJTQguB1RUsEASDbq7TkA@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] ppp: handle PPPIOCGIDLE for 64-bit time_t
To:     g.nault@alphalink.fr
Cc:     Paul Mackerras <paulus@samba.org>, linux-ppp@vger.kernel.org,
        Networking <netdev@vger.kernel.org>, mitch@sfgoth.com,
        mostrows@earthlink.net, jchapman@katalix.com, xeb@mail.ru,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Karsten Keil <isdn@linux-pingi.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 1:06 PM Guillaume Nault <g.nault@alphalink.fr> wrote:
> On Wed, Aug 29, 2018 at 04:03:30PM +0200, Arnd Bergmann wrote:

> > @@ -743,10 +744,17 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >               err = 0;
> >               break;
> >
> > -     case PPPIOCGIDLE:
> > -             idle.xmit_idle = (jiffies - ppp->last_xmit) / HZ;
> > -             idle.recv_idle = (jiffies - ppp->last_recv) / HZ;
> > -             if (copy_to_user(argp, &idle, sizeof(idle)))
> > +     case PPPIOCGIDLE32:
> > +                idle32.xmit_idle = (jiffies - ppp->last_xmit) / HZ;
> > +                idle32.recv_idle = (jiffies - ppp->last_recv) / HZ;
> > +                if (copy_to_user(argp, &idle32, sizeof(idle32)))
> >
> Missing 'break;'
>
> > +             err = 0;
> > +             break;
> > +
> > +     case PPPIOCGIDLE64:
> > +             idle64.xmit_idle = (jiffies - ppp->last_xmit) / HZ;
> > +             idle64.recv_idle = (jiffies - ppp->last_recv) / HZ;
> > +             if (copy_to_user(argp, &idle32, sizeof(idle32)))
> >
> I guess you meant 'idle64' instead of 'idle32'.

Good catch, fixing up both now.

Thanks for the review!

     Arnd
