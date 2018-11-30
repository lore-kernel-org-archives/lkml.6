Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53629C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A3C20673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJhuzO03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A3C20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeLAKnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:43:06 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41604 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLAKnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:43:06 -0500
Received: by mail-ed1-f65.google.com with SMTP id z28so6156613edi.8;
        Fri, 30 Nov 2018 15:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hb9iROKQ24m/jZb9N825lntId9X0twzxl/1GipSJBdQ=;
        b=jJhuzO037ZQHDLszxu29u9cP2HBt5CMIt014Ibtok6p8fFlKWUmiEecbAlyJ6/Kt9N
         zfV5MAiJ/zW9m/K34KG6F92R0ntOGLZiQrCAh7cc+RmiPQffpt+8AJe2SHgzf9LT2Mku
         9K/RIfKPF1yC5vqM4pWqH9BuU69Bcdj2qOnB5rXIUrtVmDHLhYkybGjc5XdEuymo/hKx
         rWjTpXSkG+ozg62caukCvDzbcS781RcMyCphJB5M+eoeOTH6bRmsgYXks+6Tf87/si9U
         bM3VCG8+bc254u+5+r3GLGEgN3kPhbAvBpz1tMjmr2GALdHzOCiOIt9gSPtCGHXa7Gd1
         D9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hb9iROKQ24m/jZb9N825lntId9X0twzxl/1GipSJBdQ=;
        b=EDH3H2Z+QeJswlTvAUJI35kSG/h2cq4RaxSfx73MDGr7+rFldRbWsHbPAcErYwT8Oh
         TVEGwJfQ0MB+fF5x2Ms04U5tZ7uxAHjhnlsig8UVQsU0L+mh92LGnE72VKUINURTSWH7
         8V2mXaJ/dfJvpm1JGo9tsE7VshgvjgE82Nh//Z0tT7IMiUIrL75Gu85fdO5enTOj+6XT
         /MO8eybDcUUPI3lynhshHKfphIkhLk3YNBq+cTEQ4VxtdXakJawrVP0guYFnz+awbH/s
         JoHjeYoPOyETOMjzcW1sJvXwHiJHNSxf8KHOJZqep6c3mcP3u7USN6JaOWqe4aAJMrkd
         znMw==
X-Gm-Message-State: AA+aEWY80JmTdmjVk0Xaev9uN51x5bE92evFWevE69lfi+rhDWK7gKks
        TKbYDiUjMwoxjIj3ikLTjSmBTHhRhy44X6zh4ySsEg==
X-Google-Smtp-Source: AFSGD/XglEdJGBqQEk0is2PAtBsiZBKc9B3WejyvNOiMtUYYdzIKMgcg4SquiiwQ1bNoll6pAtrUI0sEONdqSZ+xRgA=
X-Received: by 2002:a17:906:753:: with SMTP id z19-v6mr5903844ejb.175.1543620728560;
 Fri, 30 Nov 2018 15:32:08 -0800 (PST)
MIME-Version: 1.0
References: <CAF=yD-JGh23sA_6eUtBq8=wSZ5g=nipmhdr1WwjP5th51qEtiQ@mail.gmail.com>
 <CABeXuvqgPE_Cft+T0fSw8zT09uCKWQGUB+bVNqQDk6fOinn8rA@mail.gmail.com>
 <CAF=yD-LjfVKSr=KhknZHhN-M2-ZdLE9g0XR8Ta4rokx24arkBg@mail.gmail.com>
 <20181125.101953.2072129230580561127.davem@davemloft.net> <CABeXuvp6tBvuHu94H3qHkhu48KXadRwZ_3aNZn0_fEjZyXsnvQ@mail.gmail.com>
In-Reply-To: <CABeXuvp6tBvuHu94H3qHkhu48KXadRwZ_3aNZn0_fEjZyXsnvQ@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 30 Nov 2018 18:31:32 -0500
Message-ID: <CAF=yD-+UdzXisXSvtNu1cZvDvbxi_DYDSR_==nVSkAdyCbrraw@mail.gmail.com>
Subject: Re: [PATCH 3/8] socket: Disentangle SOCK_RCVTSTAMPNS from SOCK_RCVTSTAMP
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 5:16 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> On Sun, Nov 25, 2018 at 10:19 AM David Miller <davem@davemloft.net> wrote:
> >
> > From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Date: Sun, 25 Nov 2018 09:18:55 -0500
> >
> > > The existing logic is as is for a reason. There is no need to change
> > > it to satisfy the main purpose of your patchset?
> > >
> > > It is structured as one bit to test whether a timestamp is requested
> > > and another to select among two variants usec/nsec. Just add another
> > > layer of branching between new/old in cases where this distinction is
> > > needed.
> > >
> > > Please avoid code churn unless needed.
> >
> > +1
>
> This patch makes it easier to add logic for 2 new socket time options.
> But, if you prefer for all of the options to depend on SOCK_RCVTSTAMP
> then I will drop it.

Yes, please keep as is.

I don't see how this change is needed to significantly simplify the
main patchset, and an unnecessary change can cause an unforeseen
regression (as was the case with doubling the tests in the hot path).

The current approach has one branch in the hot path where timestamps
are disabled and then selects from two variants where it is enabled:

    if (rcvtstamp) {
      if (rcvtstamp_ns)
        ..
      else
        ..
    }

Both of these need to be split into new and old variants. The way to
achieve that with minimal code perturbation is

    if (rcvtstamp) {
  +    if (sk_timestamping_new)
  +     return __sock_recv_timestamp_new(..)
  +
      if (rcvtstamp_ns)
        ..
      else
        ..
   }

Or alternatively add a check for new in each of the inner branches. In
any case, please be consistent between sock_recv_sw_timestamp and
tcp_recv_sw_timestamp. The current patchset alternates them.
