Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C318C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19252184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548854207;
	bh=pVdtQmgZOyjcqX8J0FTHIyBrj1qymKuhAfoPYHB/Adc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sWddDaHLb2kNjKPLZyNwaXpxS6ZxoFV/tvXpC8YPN5FJxO0S/0QJy8Mw8m5n6P/q1
	 uVpDR3r7dW6PnYVWvzBM3OLoFPwVevNZu8f4HC7wWPcGWaPewPPhOReokjA0k6anlQ
	 s2EiwG0sh/WmHWMhaYeOMca9B7HEmiu7WKe9LnXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbfA3NQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:16:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:45448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730965AbfA3NQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:16:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2D6A2184D;
        Wed, 30 Jan 2019 13:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548854204;
        bh=pVdtQmgZOyjcqX8J0FTHIyBrj1qymKuhAfoPYHB/Adc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zz3ZR2oU+6u3yZtBGHq9wVo4Q2GX8ULA0F4r95qsN09+B1H04a4aJ2re1MfJuTPUL
         9VuYg7KqMG5Byrwil88TdRn71BQ1bXgDlVFvCCJBN/01ouyY2YghYk/H20WHJ5X/Lu
         77D4km34mFxLWvZZHUNfA5vgbZyIW53Sik2HJWok=
Date:   Wed, 30 Jan 2019 14:16:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Li,Rongqing" <lirongqing@baidu.com>
Cc:     "jslaby@suse.com" <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gkohli@codeaurora.org" <gkohli@codeaurora.org>,
        linux-serial@vger.kernel.org
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0hdW3Y0?= =?utf-8?Q?=5D?= tty: fix
 race between flush_to_ldisc and tty_open
Message-ID: <20190130131641.GA10795@kroah.com>
References: <1547803637-29135-1-git-send-email-lirongqing@baidu.com>
 <20190130101914.GA30587@kroah.com>
 <f13cb07ed77d428b8b43459ff71adcae@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f13cb07ed77d428b8b43459ff71adcae@baidu.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 12:48:42PM +0000, Li,Rongqing wrote:
> 
> 
> > -----邮件原件-----
> > 发件人: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org] 代表 Greg KH
> > 发送时间: 2019年1月30日 18:19
> > 收件人: Li,Rongqing <lirongqing@baidu.com>
> > 抄送: jslaby@suse.com; linux-kernel@vger.kernel.org; gkohli@codeaurora.org
> > 主题: Re: [PATCH][v4] tty: fix race between flush_to_ldisc and tty_open
> > 
> > On Fri, Jan 18, 2019 at 05:27:17PM +0800, Li RongQing wrote:
> > > There still is a race window after the commit b027e2298bd588
> > > ("tty: fix data race between tty_init_dev and flush of buf"), and we
> > > encountered this crash issue if receive_buf call comes before tty
> > > initialization completes in n_tty_open and
> > > tty->driver_data may be NULL.
> > >
> > > CPU0                                    CPU1
> > > ----                                    ----
> > >                                  n_tty_open
> > >                                    tty_init_dev
> > >                                      tty_ldisc_unlock
> > >                                        schedule flush_to_ldisc
> > > receive_buf
> > >   tty_port_default_receive_buf
> > >    tty_ldisc_receive_buf
> > >     n_tty_receive_buf_common
> > >       __receive_buf
> > >        uart_flush_chars
> > >         uart_start
> > >         /*tty->driver_data is NULL*/
> > >                                    tty->ops->open
> > >                                    /*init tty->driver_data*/
> > >
> > > it can be fixed by extending ldisc semaphore lock in tty_init_dev to
> > > driver_data initialized completely after tty->ops->open(), but this
> > > will lead to put lock on one function and unlock in some other
> > > function, and hard to maintain, so fix this race only by checking
> > > tty->driver_data when receiving, and return if tty->driver_data
> > > is NULL
> > >
> > > Signed-off-by: Wang Li <wangli39@baidu.com>
> > > Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> > > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > > ---
> > > V4: add version information
> > > V3: not used ldisc semaphore lock, only checking tty->driver_data with
> > > NULL
> > > V2: fix building error by EXPORT_SYMBOL tty_ldisc_unlock
> > > V1: extend ldisc lock to protect that tty->driver_data is inited
> > >
> > > drivers/tty/tty_port.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c index
> > > 044c3cbdcfa4..86d0bec38322 100644
> > > --- a/drivers/tty/tty_port.c
> > > +++ b/drivers/tty/tty_port.c
> > > @@ -31,6 +31,9 @@ static int tty_port_default_receive_buf(struct tty_port
> > *port,
> > >  	if (!tty)
> > >  		return 0;
> > >
> > > +	if (!tty->driver_data)
> > > +		return 0;
> > > +
> > 
> > How is this working?  What is setting driver_data to NULL to "stop" this race?
> > 
> 
> 
> if tty->driver_data is NULL and return,  tty_port_default_receive_buf will not step to
> uart_start which access tty->driver_data and trigger panic before tty_open, so it can
> fix the system panic
> 
> > There's no requirement that a tty driver set this field to NULL when it is "done"
> > with the tty device, so I think you are just getting lucky in that your specific
> > driver happens to be doing this.
> > 
> 
> when tty_open is running, tty is allocated by kzalloc in tty_init_dev which called
> by tty_open_by_driver, tty is inited to 0
> 
> > What driver are you testing this against?
> > 
> 
> 8250

Ok, as this is specific to the uart core, how about this patch instead:

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 5c01bb6d1c24..b56a6250df3f 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -130,6 +130,9 @@ static void uart_start(struct tty_struct *tty)
 	struct uart_port *port;
 	unsigned long flags;
 
+	if (!state)
+		return;
+
 	port = uart_port_lock(state, flags);
 	__uart_start(tty);
 	uart_port_unlock(port, flags);
