Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425CDC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087F32082D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EE7rh61V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087F32082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeLEPTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:19:17 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42067 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeLEPTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:19:16 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so18670583lja.9;
        Wed, 05 Dec 2018 07:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gpOr2zq67oHOcIG4Mz4a0XE2KlQn4N9TXqBHQHbAwD0=;
        b=EE7rh61VAJCshGniY87cHz99O76KH0FhStcFOT/xXjD5hnSKI9pbDKfJW9Slrexg52
         MvGW97bJg0ZrLs3ZeyRkCjxCPkNN+Rn6miVyMa71vWZ9GbK4Kgc5T9LGJSRhR4vYioGh
         ed3htR81sPFJNdyctFQUGfg81TQU4AZaqvZ5GZ/UF+aAZoWCpqfIqeLWd6jm50QsFtYB
         bsotS9DIajPGfkBb+uDSknnEfwFqvFZZYV085HriGHJy5vl4aEeBBPIQxpO7B49zLqa6
         897dnduW6TSHTiAhP6PlN98FBmqaeSqNyPQvJ141/iBJ34tnjPPDA1wKSYMzC9hTi8gu
         4hqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gpOr2zq67oHOcIG4Mz4a0XE2KlQn4N9TXqBHQHbAwD0=;
        b=QMYIV58stJVQp7R3h9dC8jfkmeoNS7G6tqWQ1LY4fvU6SjyXQbZNPp18VEL5lRt/wD
         5iO285hIB3tiz7l1L40CxyyC2QKDmEEPQvSS6OE74Lf4tiu1yurfOYeKHLt8gFi4mPUR
         3DSBY8KOJXAmVRtz8Vz3kh+nYBwVputjI2BNYlDbBNu9dIz156r9l+JPQEvkB9jLwp2j
         EjC3W6mqd7AFyzqoB+H1tGWlfJI8ePtOjZPeF9u7mN6PEFntuZQTOHdnOlhfcwSBb49S
         RDvn06iVS95m5k0DjRjO6QF0bMrUKOrT1OfWqLFSsC0dUQiKH69QnsvmYlv8hHEHmpgR
         2WJg==
X-Gm-Message-State: AA+aEWYxcQbmBt6zBfCK3tmxvXKzmVj3iMCKzbzXdVDMC/BRsKzSveUc
        E8BMOT5aFqYYOliJVLCN3flLym78
X-Google-Smtp-Source: AFSGD/XDubW4Uzsyek+qNWmt/U1TwemOuMWwRLu1zo86IMa3kJt5NieU8KHgFi7I5vkxU4KXRu6MXw==
X-Received: by 2002:a2e:5b1d:: with SMTP id p29-v6mr15793793ljb.176.1544023154203;
        Wed, 05 Dec 2018 07:19:14 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id x11sm4007616lfd.81.2018.12.05.07.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 07:19:13 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gUYxI-000473-1F; Wed, 05 Dec 2018 16:19:16 +0100
Date:   Wed, 5 Dec 2018 16:19:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [Letux-kernel] [PATCH 0/5] gnss: sirf: add support for w2sg0004
 + lna
Message-ID: <20181205151916.GJ15689@localhost>
References: <20181118215801.12280-1-andreas@kemnade.info>
 <3487514B-E546-4F11-8C0A-F5B4A8114376@goldelico.com>
 <20181119194414.1c7d6887@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119194414.1c7d6887@aktux>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 07:44:14PM +0100, Andreas Kemnade wrote:

> On Mon, 19 Nov 2018 09:22:59 +0100
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> > > Am 18.11.2018 um 22:57 schrieb Andreas Kemnade <andreas@kemnade.info>:
> > > 
> > > Here is another chapter of the story to get gta04 gnss power
> > > management into the mainline kernel.
> > > There is a w2sg0004 without wakeup line in there, so power state
> > > can only be determined indirectly by looking at the serial data lines.
> > > Then there as also an lna which needs to be powered for real gps
> > > reception. That part needs probably more discussion, since it might
> > > be an idea to have it more generalized since it has nothing todo
> > > with the chip itself.  
> > 
> > On the other hand if we follow the "SoC is the spider in the net"
> > way of looking at DTS hierarchy, we have the uart as a child of the
> > SoC and the gnss receiver as a serdev child of the UART. The LNA
> > is even one step more distantly connected to the gnss. So it makes
> > sense to me to have it as a property/reference of the gnss chip's
> > DTS record which is a sibling of the compatible records. So the only
> > place where it can be reasonably processed is the driver.
> > 
> Or the lna is a child of the gnss receiver. The whole thing
> should probably not be overdesigned, but it does not make sense that
> every gnss chip driver has some lna logic.

Did you mean "does make sense" here?

> Maybe the regulator should just be stored in the struct
> gnss_device and then drivers/gnss/core.c takes care.

Maybe eventually, but keeping it per driver is fine for now.

As you say above, this really isn't part of the chip itself, and
therefore should probably be a generic gnss property as it could be
required for any receiver (in principle).

But we still need driver support for coordinating it with the rest of
the receiver power management, so adding it to drivers as need arises
seems reasonable.

Thanks,
Johan
