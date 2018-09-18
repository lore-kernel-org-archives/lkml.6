Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89BBECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3772146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3772146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbeIRTUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:20:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42466 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729837AbeIRTUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:20:18 -0400
Received: from localhost (unknown [147.67.4.98])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3D167C03;
        Tue, 18 Sep 2018 13:47:36 +0000 (UTC)
Date:   Tue, 18 Sep 2018 15:47:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jiri Slaby <jslaby@suse.cz>,
        syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCHv5 3/7] tty: Hold tty_ldisc_lock() during tty_reopen()
Message-ID: <20180918134734.GE23431@kroah.com>
References: <20180917235258.5719-1-dima@arista.com>
 <20180917235258.5719-4-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917235258.5719-4-dima@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 12:52:54AM +0100, Dmitry Safonov wrote:
> tty_ldisc_reinit() doesn't race with neither tty_ldisc_hangup()
> nor set_ldisc() nor tty_ldisc_release() as they use tty lock.
> But it races with anyone who expects line discipline to be the same
> after hoding read semaphore in tty_ldisc_ref().
> 
> We've seen the following crash on v4.9.108 stable:
> 
> BUG: unable to handle kernel paging request at 0000000000002260
> IP: [..] n_tty_receive_buf_common+0x5f/0x86d
> Workqueue: events_unbound flush_to_ldisc
> Call Trace:
>  [..] n_tty_receive_buf2
>  [..] tty_ldisc_receive_buf
>  [..] flush_to_ldisc
>  [..] process_one_work
>  [..] worker_thread
>  [..] kthread
>  [..] ret_from_fork
> 
> tty_ldisc_reinit() should be called with ldisc_sem hold for writing,
> which will protect any reader against line discipline changes.
> 
> Backport-first: b027e2298bd5 ("tty: fix data race between tty_init_dev
> and flush of buf")

What does this mean?

Does this require that patch for a stable patch?  If so, just do:
 Cc: stable@vger.kernel.org  # b027e2298bd5 ("tty: fix data race between tty_init_dev and flush of buf")
in the signed-off-by area.  The stable documentation should describe
this pretty well.  If not, we can modify it to make it more obvious.

can you fix this up for the next resend of this series?

thanks,

greg k-h
