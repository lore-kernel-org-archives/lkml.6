Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3D4C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 05:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59AE20645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 05:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59AE20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeH3JlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 05:41:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:58898 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbeH3JlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 05:41:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w7U5GtDj013461;
        Thu, 30 Aug 2018 00:16:56 -0500
Message-ID: <f792d95eda677acaf5b96d54e3863eb91f92fa7b.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/4] tty: Hold tty_ldisc_lock() during tty_reopen()
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, stable@vger.kernel.org
Date:   Thu, 30 Aug 2018 15:16:55 +1000
In-Reply-To: <20180829043430.GB13049@jagdpanzerIV>
References: <20180829022353.23568-1-dima@arista.com>
         <20180829022353.23568-3-dima@arista.com>
         <20180829043430.GB13049@jagdpanzerIV>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-29 at 13:34 +0900, Sergey Senozhatsky wrote:
> Hi,
> 
> Cc-ing Benjamin on this.
> 
> On (08/29/18 03:23), Dmitry Safonov wrote:
> > BUG: unable to handle kernel paging request at 0000000000002260
> > IP: [..] n_tty_receive_buf_common+0x5f/0x86d
> > Workqueue: events_unbound flush_to_ldisc
> > Call Trace:
> >  [..] n_tty_receive_buf2
> >  [..] tty_ldisc_receive_buf
> >  [..] flush_to_ldisc
> >  [..] process_one_work
> >  [..] worker_thread
> >  [..] kthread
> >  [..] ret_from_fork
> 
> Seems that you are not the first one to hit this NULL deref.
> 
> > I think, tty_ldisc_reinit() should be called with ldisc_sem hold for
> > writing, which will protect any reader against line discipline changes.
> 
> Per https://lore.kernel.org/patchwork/patch/777220/
> 
> : Note that we noticed one path that called reinit without the ldisc lock
> : held for writing, we added that, but it didn't fix the problem.
> 
> And I guess that Ben meant the same reinit path which you patched:

This is too old for me to remember buit yes, there definitely was a bug
there...

> > @@ -1267,15 +1267,20 @@ static int tty_reopen(struct tty_struct *tty)
> >  	if (test_bit(TTY_EXCLUSIVE, &tty->flags) && !capable(CAP_SYS_ADMIN))
> >  		return -EBUSY;
> >  
> > -	tty->count++;
> > +	retval = tty_ldisc_lock(tty, 5 * HZ);
> > +	if (retval)
> > +		return retval;
> >  
> > +	tty->count++;
> >  	if (tty->ldisc)
> > -		return 0;
> > +		goto out_unlock;
> >  
> >  	retval = tty_ldisc_reinit(tty, tty->termios.c_line);
> >  	if (retval)
> >  		tty->count--;
> >  
> > +out_unlock:
> > +	tty_ldisc_unlock(tty);
> >  	return retval;
> >  }
> 
> 	-ss

