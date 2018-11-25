Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C304DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 05:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8976820855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 05:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCf3iMOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8976820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeKYP4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 10:56:35 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39750 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbeKYP4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 10:56:34 -0500
Received: by mail-it1-f193.google.com with SMTP id m15so22851386itl.4;
        Sat, 24 Nov 2018 21:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1gytGHmyHCjL8inRM1pR1/xjcYMy7PWwk46/OvusrUI=;
        b=ZCf3iMOWPg5P1zIp8YSenu9rP2oryRR0KP1tyZA8FzajsiFdCDhJ3IMa1n5auBajuj
         z6Tauu/6/Z6rEGjUtrhdbsi3CdxWjcDs5+fXr1ZSQHWLSLyGM3R7f8KoGciVBmgRWzrz
         X+U+/Ep5ks2bXCLC+d7fwkSlgm04huGI0GylcHqOQWLoJpDFUER0M2Stwwg+CV2VcY/N
         BdbrEcKO4zHnNNDDM490+d5qpN6+zS3VdlCvkXowHgA4pgjF3h+sPo1kYMz4hUmo6fMI
         ICaWsgcZhEkw786FsPqVJ/3NifdeTc2UCKDIiqfQbzg0agWPJqCN4KpxG4OP/bzghncA
         TyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1gytGHmyHCjL8inRM1pR1/xjcYMy7PWwk46/OvusrUI=;
        b=ieor0vOIAISwPZNQmfjH+BB+BsOja6ajM71d1VePJxKXNQuiS+9ygWhajuczsXLvPn
         QXZHmi+EsmFzoWDqybFxmGgmz1lCyxr4hZCDSniQS+ntjnt68P4vjvPYBnbNszvvGoED
         IGnzUfF0ptPAJURjkKkwGsAWdYAimtWG1zK3GMbotFqTcVPZ9o0w5UztlSgrFYXJI3/F
         q09xwLhF3BxgW6R0nIz9XjY2cMY4f8TLGccbxUCtxfUjhinNkiqkbdoa/0zazXWyrjlS
         pPMmiYlTgtv3V8UwPo92WrRyUncXKJWUJZPcouOSgO+3YNGrOhEDK/6Cywe1A4uTgDOz
         5xOg==
X-Gm-Message-State: AA+aEWYcAtRM1kRQyBGU5S6BjKUOpo1JLRxUe4aPAQ2etJHJH/OEnRkI
        ubgJXqI2aq5Utx+/KMyXsQNBP6/e87dpCjXRY3t6At5z
X-Google-Smtp-Source: AFSGD/U3eTxiVLuJDgf8Y1jMFdUxFVgw5drY0jHM/uWIs92QXY52aj97s71VWvMSpjTmEe7oZpUmbAUdcFVe4sIQ6i8=
X-Received: by 2002:a24:1c86:: with SMTP id c128mr6960786itc.58.1543122381088;
 Sat, 24 Nov 2018 21:06:21 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-4-deepa.kernel@gmail.com> <CAF=yD-JGh23sA_6eUtBq8=wSZ5g=nipmhdr1WwjP5th51qEtiQ@mail.gmail.com>
In-Reply-To: <CAF=yD-JGh23sA_6eUtBq8=wSZ5g=nipmhdr1WwjP5th51qEtiQ@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 24 Nov 2018 21:06:10 -0800
Message-ID: <CABeXuvqgPE_Cft+T0fSw8zT09uCKWQGUB+bVNqQDk6fOinn8rA@mail.gmail.com>
Subject: Re: [PATCH 3/8] socket: Disentangle SOCK_RCVTSTAMPNS from SOCK_RCVTSTAMP
To:     willemdebruijn.kernel@gmail.com
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Network Devel Mailing List <netdev@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 7:59 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Sat, Nov 24, 2018 at 3:59 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > SOCK_RCVTSTAMPNS is never set alone. SOCK_RCVTSTAMP
> > is always set along with SOCK_RCVTSTAMPNS. This leads to
> > checking for two flag states whenever we need to check for
> > SOCK_RCVTSTAMPS.
> >
> > Also SOCK_RCVTSTAMPS was the only flag that needed to be
> > checked in order to verify if either of the two flags are
> > set. But, the two features are not actually dependent on
> > each other. This artificial dependency creates more
> > confusion.
>
> This is done so that the hot path only has to check one flag
> in the common case where no timestamp is requested.

In that case we could just check it this way:

if (newsk->sk_flags & SK_FLAGS_TIMESTAMP)

We are already doing this in many places.

I do not see any other reason for the two timestamps to be intertwined.

Do you have any objections to using this patch and replacing the
checks as above?

-Deepa
