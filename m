Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1CAC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94AA2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94AA2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbeGYJRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:17:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38094 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbeGYJRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:17:18 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E74F6BA9;
        Wed, 25 Jul 2018 08:06:46 +0000 (UTC)
Date:   Wed, 25 Jul 2018 10:06:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     jslaby@suse.com,
        syzbot <syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] n_tty: Protect tty->disc_data using refcount.
Message-ID: <20180725080630.GA17932@kroah.com>
References: <001a113ed31a122ced0568cc6be1@google.com>
 <db45a090-593d-23d2-e6b2-ede5b308f02f@I-love.SAKURA.ne.jp>
 <35d649ce-0c22-f839-aa4d-19733bf31a9c@I-love.SAKURA.ne.jp>
 <83fdde07-2f8e-8d20-30a2-a8f0804a5044@I-love.SAKURA.ne.jp>
 <8e83cd9a-e28c-a9f4-5f47-98f2046a5dfb@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e83cd9a-e28c-a9f4-5f47-98f2046a5dfb@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 12:22:16AM +0900, Tetsuo Handa wrote:
> >From 118c64e86641a97d44dec39e313a95b12d9bc3b2 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Wed, 25 Jul 2018 00:15:18 +0900
> Subject: [PATCH v2] n_tty: Protect tty->disc_data using refcount.
> 
> syzbot is reporting NULL pointer dereference at n_tty_set_termios() [1].
> This is because ioctl(TIOCVHANGUP) versus ioctl(TCSETS) can race.
> 
> Since we don't want to introduce new locking dependency, this patch
> converts "struct n_tty_data *ldata = tty->disc_data;" in individual
> function into a function argument which follows "struct tty *", and
> holds tty->disc_data at each "struct tty_ldisc_ops" hook using refcount
> in order to ensure that memory which contains "struct n_tty_data" will
> not be released while processing individual function.
> 
> [1] https://syzkaller.appspot.com/bug?id=1e850009fca0b64ce49dc16499bda4f7de0ab1a5
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  drivers/tty/n_tty.c | 511 ++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 314 insertions(+), 197 deletions(-)

What changed from v1?  I haven't had the chance to review your first
patch, sorry, it's still in my queue.  I was hoping that someone else
would help out with that as well :)

thanks,

greg k-h
