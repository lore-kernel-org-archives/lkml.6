Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82214C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4699D206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbWZLk47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4699D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbeLDQb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:31:59 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45283 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbeLDQb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:31:58 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so15479551ljd.12;
        Tue, 04 Dec 2018 08:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GLf7jhPRgKHtp81VkqFMGOjWO0dWtGHtzBeMcmUcCjg=;
        b=VbWZLk47768sb76OJK24tEMJ1ibD1a1O5jZ0bsZGvqPbpzxONxIDJjlPH7F3gDwxoW
         v6dOBmDM+e/kTY+CJ/r7y3zdWnc080iC9NSY6g1dcGGAPe3DuwWw67y0IJPqlcnZQ1rw
         drQfYX8SZLQe72O4say82+OK/MA4DqhNJDusHw/rtaHpSZtUdiZGCjFqHvOitGAsGeXv
         gthpUIBbd2rU9MxnJoBM2ptrG9X8bg+8ek4shDvYpIL1iWYOIHP5sJRdMRIm1l2Wx4SF
         tGByJ/BSz8+Jc/k5FFTbg3jPQk+qjk9kyqwjqYvi/5o1LyL9rWW26UDpulQKZAEli0ie
         7ffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GLf7jhPRgKHtp81VkqFMGOjWO0dWtGHtzBeMcmUcCjg=;
        b=P+ntIVcrhvtqaJvhYFRf4++PvNsPR9/IPZx31sQXQFCSh5Ko3wNbAZmmQLHl1emgFK
         Xq8uxaM5Q9QepDWTUaFnwfC5STkh8K8cGcA77t6ECKsJjNCm5xHNbVeSc560gy3OG50E
         NmTtZus9B96iG9BJuS4+oj1Onm3ycuarVuSNJkPqqNFNeFscGXpdwmx7bEOgzNf2Dynp
         erjqaErl8GXldJrhOrE2I9MrD+24HF+Ol3wm5TQy63JT/56A6UY/SENv47vHcztdQZ7q
         wup9NRAc9H//pQtcG6x53OfW0BYB3/e1R9TSQo4wImzNB45TfiGhofJm/ON48TR3c5i2
         DTOA==
X-Gm-Message-State: AA+aEWYhzyHSHPrkk2k13lAoMVgp2fhysZ2pJrC4GXAWPHQ6lFK9rcGU
        wlfEvl2fIUWyjUK79b10FLs=
X-Google-Smtp-Source: AFSGD/UmIFTzx7tKK8zsfB5+KrBx5ftopt7Mx0IpRjCGNyhx/5JoyyCnbc7R+Zesapyfi8kentDXeA==
X-Received: by 2002:a2e:5d12:: with SMTP id r18-v6mr14674323ljb.89.1543941114610;
        Tue, 04 Dec 2018 08:31:54 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id p23sm3051863lfh.47.2018.12.04.08.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 08:31:53 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gUDc3-0006cj-0n; Tue, 04 Dec 2018 17:31:55 +0100
Date:   Tue, 4 Dec 2018 17:31:55 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>,
        Florian Zumbiehl <florz@florz.de>
Subject: Re: [PATCH] USB: serial: console: fix reported terminal settings
Message-ID: <20181204163155.GD18087@localhost>
References: <20181204155904.GC18087@localhost>
 <20181204160036.24625-1-johan@kernel.org>
 <20181204161518.GA17941@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204161518.GA17941@kroah.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 05:15:18PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Dec 04, 2018 at 05:00:36PM +0100, Johan Hovold wrote:
> > The USB-serial console implementation has never reported the actual
> > terminal settings used. Despite storing the corresponding cflags in its
> > struct console, this was never honoured on later tty open() where the
> > tty termios would be left initialised to the driver defaults.
> > 
> > Unlike the serial console implementation, the USB-serial code calls
> > subdriver open() already at console setup. While calling set_termios()
> > before open() looks like it could work for some USB-serial drivers,
> > others definitely do not expect this, so modelling this after serial
> > core is going to be intrusive, if at all possible.
> > 
> > Instead, use a (renamed) tty helper to save the termios data used at
> > console setup, so that the tty termios reflects the actual terminal
> > settings after a subsequent tty open().
> > 
> > Note that the calls to tty_init_termios() (tty_driver_install()) and
> > tty_save_termios() are serialised using the disconnect mutex.
> > 
> > This specifically fixes a regression that was triggered by a recent
> > change adding software flow control to the pl2303 driver: a getty trying
> > to disable flow control while leaving the baud rate unchanged would now
> > also set the baud rate to the driver default (prior to the flow-control
> > change this had been a noop).
> > 
> > Fixes: 7041d9c3f01b ("USB: serial: pl2303: add support for tx xon/xoff flow control")
> > Cc: stable <stable@vger.kernel.org>	# 4.18
> > Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > Cc: Florian Zumbiehl <florz@florz.de>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/tty/tty_io.c         | 11 +++++++++--
> >  drivers/usb/serial/console.c |  2 +-
> >  include/linux/tty.h          |  1 +
> >  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> Ah, messy :)
> 
> Want me to take this through my tty tree?

If you prefer. I was planning on including this in a USB-serial pull
request for -rc6 since it fixes a user-reported regression, but perhaps
taking this through your tty-linus branch (which already holds a console
fix) is easier/faster.

We should wait for Jarkko to confirm that this fixes the problem he
reported first, though.

Thanks,
Johan
