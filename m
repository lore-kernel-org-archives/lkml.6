Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF548C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6522084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="paTKd4nJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6522084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbeJEUjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:39:05 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45436 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbeJEUjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:39:05 -0400
Received: by mail-lf1-f67.google.com with SMTP id m80-v6so9365826lfi.12;
        Fri, 05 Oct 2018 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iOxL1Fw89+j4myCcc8niw3QsDsss42c4mJhRtaCwo6c=;
        b=paTKd4nJIJ5ossp55X9awCP8dD/W9EL2N9cNJAqxmsxKwkEgUfY7bJnCj/TpQ+WQ5S
         bS/dZZ4dz35l6SNxcB+GoGZbZDp9IwiaSA9FGQh2BWMhw4s1jdACzaqsXzZK9uJVYMgc
         Dw1zjBcqvIhCyJDqCgaAcn48bBJ2zdoeooMPYjpOUrAGQSZP7ChRnzYiEgWCRHMUCJ55
         rlajRk6hOu/d27zwhqoEu2YvfWfFhPP/akgsFKliJqY25zxhZKStCDVE6GbvIzPQjTS1
         Qhw9GP2FKPL2TiuFnphhD06VfjqvTwRS0cv5blYLcJb3K6ixFDWPrIojVSymAzMweC6g
         5nRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iOxL1Fw89+j4myCcc8niw3QsDsss42c4mJhRtaCwo6c=;
        b=derC0WqY3X6cpluTRoQRV5XHnnUArPWMy5n7WTkCxAZ+dWe2ld+1IxtlUFQiUgZ6X5
         UWGkj+VGYVL3LkUAFHijiO9jP0LBIPs/XqzLbVR+NlGV33H8iJ9aSHJkG4BL7Y3A+YjJ
         lSwqhJfeitYmKY7hL/Nkn9Jv/7l+mHy2j7DxTBfbIimq/l0gc+oKQelvsabKI+THK/0J
         7OtwLiFHPCdTTGDzEBw6dSncf55YZJH+9aDC34+qnht+dqQTsGtp0wwVXvLspoFqWw/t
         iPhL6hSMHlPExWajWaS4z/bgLP/j+V9Nosig7BLPmgNqf2/El+zeRgv2D0Bf9p72NkQc
         R/MA==
X-Gm-Message-State: ABuFfohQHGMcTQPgZbG0qSVJ62uYiTRVi+5iVOHj90R4agabVYpC12EH
        Zj8LeLZlpmIrYSRTy1bwylU=
X-Google-Smtp-Source: ACcGV60VylheG7d+dgases/TbrY4hHoV32+YWUANObz/Vile8wpPBAd0zbyOA55v4D3PgTlAhX6dMA==
X-Received: by 2002:a19:4acd:: with SMTP id x196-v6mr7002972lfa.130.1538746815295;
        Fri, 05 Oct 2018 06:40:15 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id p24-v6sm1815567ljg.57.2018.10.05.06.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 06:40:14 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g8QL0-0008SF-NS; Fri, 05 Oct 2018 15:40:14 +0200
Date:   Fri, 5 Oct 2018 15:40:14 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        pados@pados.hu, Loic Poulain <loic.poulain@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] USB: serial: gpio line-name fix and FT232R CBUS gpio
 support
Message-ID: <20181005134014.GH3774@localhost>
References: <20180930122703.7115-1-johan@kernel.org>
 <CACRpkdaG-S-6LfCKgxz4jdbD=kRO7q7k_8FAHqsSNBPdC07iDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaG-S-6LfCKgxz4jdbD=kRO7q7k_8FAHqsSNBPdC07iDA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 11:43:55AM +0200, Linus Walleij wrote:
> On Sun, Sep 30, 2018 at 2:29 PM Johan Hovold <johan@kernel.org> wrote:

> > Linus, we finally got around to adding gpio support for FTDI devices;
> > see commit
> >
> >         ba93cc7da896 ("USB: serial: ftdi_sio: implement GPIO support for FT-X devices")
> >
> > in my usb-next branch (and linux-next).
> 
> This is good news, I think it's a pretty neat way for people to get
> a few inexpensive GPIOs from their serial adapters.
> 
> > The gpiolib warnings and inability to use the legacy sysfs interface
> > prevents us from setting the line names however as someone is bound to
> > plugin more than one of these devices at some point. I think we
> > discussed this issue with the name space and hotpluggable devices a few
> > years ago, but looks like this topic may need to be revisited.
> 
> Hm I guess the right long-term fix is to allow per-gpiochip unique
> names rather than enforcing globally unique names.

Indeed.

> The idea is to make it possible for userspace to look up a GPIO
> on a chip by name, so if the gpiochip has a unique name,
> and the line name is unique on that chip it should be good
> enough.

I haven't really had time do dig into this again, but is this also an
issue with the chardev interface? I thought this was one of the things
you wanted to get right with the new interface, so hopefully that's
already taken care of.

If the flat name space is only an issue with the legacy interface we
might get away with simply not using the line names in sysfs when a new
chip flag is set (unless we can resue .can_sleep, but there seems to be
some i2c devices already using line names).

Thanks,
Johan
