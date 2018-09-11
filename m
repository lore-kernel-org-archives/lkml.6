Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D61C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6D520833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MdtbQJum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6D520833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeIKRBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:01:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60180 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbeIKRBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UsD9ORNFpRXXbhAWR383ojqn1eiqaOkl4QYAvrXisUs=; b=MdtbQJumwteHucPI79MKczM7r
        BUbGxZ8qjih5cuoXBqrkzaNM1ZNzODkImU+D5CryuIBTjhzqdvPSncGgPFoBfQXkg7uwjgv104jEq
        APFjLOSWe1qEWa20w9WPP4S8jmjIWYYZcjTb8Y7wXuZwSp4K3oxiQYDFyO6/rqxmEDw8hiqCWiP9D
        VvsNuSG8Z4e4uK3RUm/VgfrHYuzaqMdP7OlS6uBjWuf+KRSOF66Jf/XoBelBINGhB7/ahy35kTcaJ
        gMkA/eW+1iS0YbSeINgKdbI4kd5A/5O1luMAE3gXzMpyQnlAmKSJ/Ylo0/SBHzT0iCJp1FgZCiVib
        876rqyUNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzhMh-0005lO-5c; Tue, 11 Sep 2018 12:01:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C32172057F82D; Tue, 11 Sep 2018 14:01:53 +0200 (CEST)
Date:   Tue, 11 Sep 2018 14:01:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCHv3 4/6] tty/lockdep: Add ldisc_sem asserts
Message-ID: <20180911120153.GB19234@hirez.programming.kicks-ass.net>
References: <20180911014821.26286-1-dima@arista.com>
 <20180911014821.26286-5-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911014821.26286-5-dima@arista.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 02:48:19AM +0100, Dmitry Safonov wrote:
> Make sure under CONFIG_LOCKDEP that each change to line discipline
> is done with held write semaphor.

But you don't do that. You just assert it is held, not for writing.

> Otherwise potential reader will have a good time dereferencing
> incomplete/uninitialized ldisc.
> 
> Exception here is tty_ldisc_open(), as it's called without ldisc_sem
> locked by tty_init_dev() for the tty->link.

You fail to explain how that is not broken...

> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  drivers/tty/tty_ldisc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
> index fc4c97cae01e..202cb645582f 100644
> --- a/drivers/tty/tty_ldisc.c
> +++ b/drivers/tty/tty_ldisc.c
> @@ -471,6 +471,7 @@ static int tty_ldisc_open(struct tty_struct *tty, struct tty_ldisc *ld)
>  
>  static void tty_ldisc_close(struct tty_struct *tty, struct tty_ldisc *ld)
>  {
> +	lockdep_assert_held(&tty->ldisc_sem);

Did you want:

	lockdep_assert_held_exclusive(&tty->ldisc_sem);

?

>  	WARN_ON(!test_bit(TTY_LDISC_OPEN, &tty->flags));
>  	clear_bit(TTY_LDISC_OPEN, &tty->flags);
>  	if (ld->ops->close)
