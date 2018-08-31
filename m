Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B880C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C0B20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C0B20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbeHaSIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:08:17 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44010 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbeHaSIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:08:16 -0400
Received: by mail-qt0-f195.google.com with SMTP id g53-v6so14574732qtg.10;
        Fri, 31 Aug 2018 07:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7FRvFbXtOvn8P5ZHvWPRUY4/cfx0+zZ3/J9PKl4QuPM=;
        b=XSENr6duXpLrdfRrteFknRdTF67ATCCHGFHW0p24ffIsxf64/vBZ5D4H68QR61i3c4
         eIYqETF+ifvM28fPy1Tb6eABBZQCfDZPxHoBO3BUy7Yw/wx9+LWSjZopG7SDgraD2Prc
         08iCCxIZNZNsUerZqYrMwP6aH3T3bIpZ/jSKLi7snS/ULOnq8lZEDmTb0Wb33uXAVTkg
         2g6JK/UOd81dUvA4EwPyTjeLMQTKRxlvZqixr1yaLTY80PncAO/KytrQK2Sqbmpev8KM
         Zabl7TgAHK6P9ZctYEEGTDCdivaUsG/0CNkll26g36XhkiqfISHGebXam2iavuCyo8bw
         S3TA==
X-Gm-Message-State: APzg51BonHwRVyLuObPO0vCene+15vUks/VDn2wzvURStwupRXZ3zzQ7
        LK6+lJo7H4c6yW8/pvRAWLB0XHK8NiTSJixfVefDWg==
X-Google-Smtp-Source: ANB0VdYnlDSva9ruwfBYXS1727hVkGDoWZ5hvO5q2b66nePQO5oKveLWKNuerimUxYc25fIKtoai4SPqM26Awr6wWJQ=
X-Received: by 2002:aed:3f22:: with SMTP id p31-v6mr15850685qtf.185.1535724038135;
 Fri, 31 Aug 2018 07:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180829130308.3504560-1-arnd@arndb.de> <CAF=yD-J7-GumUmonrZt7s44e3bsjY2DCD6ZpmhtCx6FOBV5BNA@mail.gmail.com>
 <CAK8P3a2XTUZJUqGu6v=SZqcoJTqM3fgtDAWBnBopX3=4NJYcRA@mail.gmail.com> <CAF=yD-+9yc838Y_DO1S4HsBpLrBk8iNt0oAj1ceO1S6sE+tCdg@mail.gmail.com>
In-Reply-To: <CAF=yD-+9yc838Y_DO1S4HsBpLrBk8iNt0oAj1ceO1S6sE+tCdg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 Aug 2018 16:00:21 +0200
Message-ID: <CAK8P3a00DLR9JyfKwbYXnKCpRf+YWuUyMbC+UfXZTfdnAJxRtg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: rework SIOCGSTAMP ioctl handling
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        linux-arch <linux-arch@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hams@vger.kernel.org,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-can@vger.kernel.org, dccp@vger.kernel.org,
        linux-wpan@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-x25@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 3:38 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> On Fri, Aug 31, 2018 at 6:31 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Aug 30, 2018 at 10:10 PM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > > On Wed, Aug 29, 2018 at 9:05 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > If this is the only valid implementation of .gettstamp, the indirect
> > > call could be avoided in favor of a simple branch.
> >
> > I thought about that as well, but I could not come up with a
> > good way to encode the difference between socket protocols
> > that allow timestamping and those that don't.
> >
> > I think ideally we would just call sock_gettstamp() unconditonally
> > on every socket, and have that function decide whether timestamps
> > make sense or not. The part I did not understand is which ones
> > actually want the timestamps or not. Most protocols that
> > implement the ioctls also assign skb->tstamp, but there are some
> > protocols in which I could not see skb->tstamp ever being set,
> > and some that set it but don't seem to have the ioctls.
>
> These probably only use cmsgs SCM_TIMESTAMP(NS|IMG)
> to read timestamps.

Good point. FWIW, I have discussed with Deepa how those should
be modified for y2038, but we don't have any current patches for
those.

> > Looking at it again, it seems that sock_gettstamp() should
> > actually deal with this gracefully: it will return a -EINVAL
> > error condition if the timestamp remains at the
> > SK_DEFAULT_STAMP initial value, which is probably
> > just as appropriate (or better) as the current -ENOTTY
> > default, and if we are actually recording timestamps, we
> > might just as well report them.
>
> Yes, that's a nice solution. There is always some risk in changing
> error codes. But ioctl callers should be able to support newly
> implemented functionality. Even if partially implemented and
> returning ENOENT instead of ENOIOCTLCMD.

Ok, so do you think we should stay with the current version
for now, and change the two points later, or should I rework
it to integrate the locking and removing the callback?

I suppose the series actually gets nicer without the
callback, since I can simply add the generic timestamping
implementation first, and then remove the dead ioctl
handlers.

        Arnd
