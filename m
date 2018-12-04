Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DF5C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1BE2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsTFXI0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1BE2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbeLDQPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:15:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:57412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeLDQPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:15:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86B4220659;
        Tue,  4 Dec 2018 16:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543940121;
        bh=JQnLjUmPw1yLQJ2dKbTFKt1TNQpyVvPTycBj/3G4WrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BsTFXI0WNPgZPuhU46e/HZUBy1ROfLXFNSnR0EK99050hBs8oWI9dstVslQh7DW1/
         iUd3norUUNnk2C5RV0GGyVwpNMQkFMd9KK+WfnAidZSZVDbzrD+jCDZUmTpnvcA4O2
         Z8uArFLeeORU8+OmRMQUOmWCg6qAQhpMSoxHcNpQ=
Date:   Tue, 4 Dec 2018 17:15:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>,
        Florian Zumbiehl <florz@florz.de>
Subject: Re: [PATCH] USB: serial: console: fix reported terminal settings
Message-ID: <20181204161518.GA17941@kroah.com>
References: <20181204155904.GC18087@localhost>
 <20181204160036.24625-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204160036.24625-1-johan@kernel.org>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 05:00:36PM +0100, Johan Hovold wrote:
> The USB-serial console implementation has never reported the actual
> terminal settings used. Despite storing the corresponding cflags in its
> struct console, this was never honoured on later tty open() where the
> tty termios would be left initialised to the driver defaults.
> 
> Unlike the serial console implementation, the USB-serial code calls
> subdriver open() already at console setup. While calling set_termios()
> before open() looks like it could work for some USB-serial drivers,
> others definitely do not expect this, so modelling this after serial
> core is going to be intrusive, if at all possible.
> 
> Instead, use a (renamed) tty helper to save the termios data used at
> console setup, so that the tty termios reflects the actual terminal
> settings after a subsequent tty open().
> 
> Note that the calls to tty_init_termios() (tty_driver_install()) and
> tty_save_termios() are serialised using the disconnect mutex.
> 
> This specifically fixes a regression that was triggered by a recent
> change adding software flow control to the pl2303 driver: a getty trying
> to disable flow control while leaving the baud rate unchanged would now
> also set the baud rate to the driver default (prior to the flow-control
> change this had been a noop).
> 
> Fixes: 7041d9c3f01b ("USB: serial: pl2303: add support for tx xon/xoff flow control")
> Cc: stable <stable@vger.kernel.org>	# 4.18
> Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Florian Zumbiehl <florz@florz.de>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/tty/tty_io.c         | 11 +++++++++--
>  drivers/usb/serial/console.c |  2 +-
>  include/linux/tty.h          |  1 +
>  3 files changed, 11 insertions(+), 3 deletions(-)

Ah, messy :)

Want me to take this through my tty tree?

thanks,

greg k-h
