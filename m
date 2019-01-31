Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603BEC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBDB218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548960255;
	bh=li/wbQZqLc2GiajeYDvMLcmv5dmFcHfzQsmFERlq8k4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OwjjuoJQRKfUTkhI+FpwqbYQcBCTZcZS6wghTZcvdBD6RsvA11oLzaqmqvzQdnbK0
	 ZHz151UNAsuf9j8Q8U/uwxxJgLqiEpy6rDkyuN4ohAG/xZ0qniit7JeVtMukF0QXIB
	 f+eykvgFVR72YBoCgKklKpYgOSQ1nYIuE2EDODeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfAaSoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:44:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:60902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfAaSoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:44:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EF5A218AC;
        Thu, 31 Jan 2019 18:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548960251;
        bh=li/wbQZqLc2GiajeYDvMLcmv5dmFcHfzQsmFERlq8k4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qv4sOcLMVTmjxvIJ70UkJJRo7fLlkII4yZB7PNdrbh74IT/N+x9bWF0coIWefczps
         h2MwrYXrAGx9yzcVydGQE0OceLWKwptifYoejapP0lR6pxQ+h7aqqBjt9Y7oohUI+k
         U+XTDL7hHCI1sXbmflnqFL9SqhdwZcAeT3x8drT8=
Date:   Thu, 31 Jan 2019 19:44:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Li,Rongqing" <lirongqing@baidu.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "gkohli@codeaurora.org" <gkohli@codeaurora.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0hdW1Y1?= =?utf-8?Q?=5D?= tty: fix
 race between flush_to_ldisc and tty_open
Message-ID: <20190131184409.GA5238@kroah.com>
References: <1548927796-11348-1-git-send-email-lirongqing@baidu.com>
 <20190131105527.GB8271@kroah.com>
 <22a5d8639b154119af7d7661e17025f2@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22a5d8639b154119af7d7661e17025f2@baidu.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:15:48AM +0000, Li,Rongqing wrote:
> 
> 
> > -----邮件原件-----
> > 发件人: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org] 代表 Greg Kroah-Hartman
> > 发送时间: 2019年1月31日 18:55
> > 收件人: Li,Rongqing <lirongqing@baidu.com>
> > 抄送: linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org;
> > jslaby@suse.com; gkohli@codeaurora.org
> > 主题: Re: [PATCH][V5] tty: fix race between flush_to_ldisc and tty_open
> > 
> > On Thu, Jan 31, 2019 at 05:43:16PM +0800, Li RongQing wrote:
> > > There still is a race window after the commit b027e2298bd588
> > > ("tty: fix data race between tty_init_dev and flush of buf"), and we
> > > encountered this crash issue if receive_buf call comes before tty
> > > initialization completes in tty_open and
> > > tty->driver_data may be NULL.
> > >
> > > CPU0                                    CPU1
> > > ----                                    ----
> > >                                   tty_open
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
> > > will lead to get lock on one function and unlock in some other
> > > function, and hard to maintain, so fix this race only by checking
> > > tty->driver_data when receiving, and return if tty->driver_data
> > > is NULL, and n_tty_receive_buf_common maybe calls uart_unthrottle, so
> > > add the same check
> > >
> > > Signed-off-by: Wang Li <wangli39@baidu.com>
> > > Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> > > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > > ---
> > > V5: move check into uart_start from n_tty_receive_buf_common
> > > V4: add version information
> > > V3: not used ldisc semaphore lock, only checking tty->driver_data with
> > > NULL
> > > V2: fix building error by EXPORT_SYMBOL tty_ldisc_unlock
> > > V1: extend ldisc lock to protect that tty->driver_data is inited
> > >
> > >  drivers/tty/serial/serial_core.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/tty/serial/serial_core.c
> > > b/drivers/tty/serial/serial_core.c
> > > index 5c01bb6d1c24..556f50aa1b58 100644
> > > --- a/drivers/tty/serial/serial_core.c
> > > +++ b/drivers/tty/serial/serial_core.c
> > > @@ -130,6 +130,9 @@ static void uart_start(struct tty_struct *tty)
> > >  	struct uart_port *port;
> > >  	unsigned long flags;
> > >
> > > +	if (!state)
> > > +		return;
> > > +
> > >  	port = uart_port_lock(state, flags);
> > >  	__uart_start(tty);
> > >  	uart_port_unlock(port, flags);
> > > @@ -727,6 +730,9 @@ static void uart_unthrottle(struct tty_struct *tty)
> > >  	upstat_t mask = UPSTAT_SYNC_FIFO;
> > >  	struct uart_port *port;
> > >
> > > +	if (!state)
> > > +		return;
> > > +
> > >  	port = uart_port_ref(state);
> > >  	if (!port)
> > >  		return;
> > > --
> > > 2.16.2
> > 
> > 
> > Hm, I wrote this patch, not you, right?  So shouldn't I get the
> > credit/blame for it?  :)
> > 
> 
> Welcome you to add your credit/blame/signature
> and I am not clear the rule, and be afraid to become fake

No problem, I've fixed this up when committing this, and added some
wording change to the changelog text.

Thanks so much for working through all of this, it's a bug that has
always been there for forever it seems, nice catch!

greg k-h
