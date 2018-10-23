Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEB5C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876D6207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyNlfW0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876D6207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbeJWXRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 19:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbeJWXRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 19:17:39 -0400
Received: from localhost (unknown [185.7.230.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD07020671;
        Tue, 23 Oct 2018 14:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540306433;
        bh=JFz8FHM04e7ExSFZuStT+SdD+P10LDOVEef0HXREebg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OyNlfW0uStAuG4mgLc8upXUaonXGhtmhiz6ISzVNJ/btiKVhsvIbTYx6C+oY/cozx
         UdsQPDoY8RGa6ES+Xk/mpquGOO9yoc6BJQkxrJKSWX6yJZTkiLMngLYqj/IygyrIt2
         kwnmgjQjjUIuJ9vMmZvLkLs6ersRFlTBzAJ38vc8=
Date:   Tue, 23 Oct 2018 15:53:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "H. Peter Anvin (Intel)" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        linux-alpha@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        stable@vger.kernel.org
Subject: Re: [PATCH stable v2 1/2] termios, tty/tty_baudrate.c: fix buffer
 overrun
Message-ID: <20181023145351.GA28516@kroah.com>
References: <20181022161905.26589-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022161905.26589-1-hpa@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 09:19:04AM -0700, H. Peter Anvin (Intel) wrote:
> From: "H. Peter Anvin" <hpa@zytor.com>
> 
> On architectures with CBAUDEX == 0 (Alpha and PowerPC), the code in tty_baudrate.c does
> not do any limit checking on the tty_baudrate[] array, and in fact a
> buffer overrun is possible on both architectures. Add a limit check to
> prevent that situation.
> 
> This will be followed by a much bigger cleanup/simplification patch.
> 
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Requested-by: Cc: Johan Hovold <johan@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Eugene Syromiatnikov <esyr@redhat.com>
> Cc: <linux-alpha@vger.kernel.org>
> Cc: <linux-serial@vger.kernel.org>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/tty/tty_baudrate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

As I think Al's big termios cleanups are going to be hitting Linus's
tree soon, do you know how these patches interact with that?

This patch seems like it will not, so I'll be glad to queue that up
after my first round of patches get merged to Linus later this week, but
the second one worries me.

thanks,

greg k-h
