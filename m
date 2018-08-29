Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C69C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 04:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F103120841
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 04:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5895AXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F103120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeH2I3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 04:29:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39570 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeH2I3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 04:29:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so1684065pff.6;
        Tue, 28 Aug 2018 21:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A4cOhlwhuZetS+UJ9f3q5pGs5rbdKzbTZbLy6N4f7s4=;
        b=M5895AXKYSGkBxSt0w7/RduSUYY0GBRoX6xJoZFznICW+ojVihpBx1+Vz4x4I5V2JR
         GBCzIrRxHn9u9CY/HEygMuBLcWblZZNrPlYVze6ZaaUzbNMisbTcaQDPhcReYEYyGoNZ
         APVVAJcTfYDkOxlUw5g7PvUcnIIX0lmhClF89mTr9UbQXUhwWy1cldYSna1bg0Sx8lXj
         zH6nhRtovm49n5Q6Iux4PuDvLPrG5jC2OyHwyxfIS2rUy/yCefnwghVbyq56+WM0N8I5
         BfLsh6TvnrkTSpCK+APnNL2dbctvd1wfJF6tgnYXgKGqfVD2bepiPPcnpVxkjwBFYjp2
         RcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A4cOhlwhuZetS+UJ9f3q5pGs5rbdKzbTZbLy6N4f7s4=;
        b=Isupk+a6VJdflmCMKP8wUSc/1msxM0QT/Eal1pn9HMwmr/aDRhTdaCLpWEG3SXEiNb
         +Ofvj+559IjXhPNywgNgGwHSW92aXMpnyop3odNUYpaaz+4T5YMxifvv3f6xBzwiu2GS
         SQUdIOl8p8LW7nOUmDDa4akxomUoPIEcH60VDckHpXsad8G4Lpjw92elD3jX4MfLXKY9
         ve57ldsx4TAE+bA/KItrr+IoJiyv7cmQfpOn5Rki0XBI6AV3wizsMeCA3xWTp4zpNIDV
         4TE7rmrT5PCvlXozbKtAtaXh1UlSnPARuZZ/rNDfTaGwuzxvYwt3rr4mpE4crnd1rdf5
         PIyg==
X-Gm-Message-State: APzg51C2dgVEqoGB5JbuZo50tc0Ci2F63BQXe4erAnPET6CIYqGGtJY8
        T04rsB8MRV2ozue5bIDunjk=
X-Google-Smtp-Source: ANB0VdZXbC9WzkKJbb+RF1SL7r8nBhErJEXGSFqBdPc5blQZwLEvAvaZJTWVgumvZxVk9nfZ2J27EQ==
X-Received: by 2002:a63:d345:: with SMTP id u5-v6mr2680673pgi.330.1535517275905;
        Tue, 28 Aug 2018 21:34:35 -0700 (PDT)
Received: from localhost ([175.223.20.38])
        by smtp.gmail.com with ESMTPSA id d19-v6sm4616051pfe.42.2018.08.28.21.34.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 21:34:34 -0700 (PDT)
Date:   Wed, 29 Aug 2018 13:34:30 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, stable@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/4] tty: Hold tty_ldisc_lock() during tty_reopen()
Message-ID: <20180829043430.GB13049@jagdpanzerIV>
References: <20180829022353.23568-1-dima@arista.com>
 <20180829022353.23568-3-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829022353.23568-3-dima@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Cc-ing Benjamin on this.

On (08/29/18 03:23), Dmitry Safonov wrote:
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

Seems that you are not the first one to hit this NULL deref.

> I think, tty_ldisc_reinit() should be called with ldisc_sem hold for
> writing, which will protect any reader against line discipline changes.

Per https://lore.kernel.org/patchwork/patch/777220/

: Note that we noticed one path that called reinit without the ldisc lock
: held for writing, we added that, but it didn't fix the problem.

And I guess that Ben meant the same reinit path which you patched:

> @@ -1267,15 +1267,20 @@ static int tty_reopen(struct tty_struct *tty)
>  	if (test_bit(TTY_EXCLUSIVE, &tty->flags) && !capable(CAP_SYS_ADMIN))
>  		return -EBUSY;
>  
> -	tty->count++;
> +	retval = tty_ldisc_lock(tty, 5 * HZ);
> +	if (retval)
> +		return retval;
>  
> +	tty->count++;
>  	if (tty->ldisc)
> -		return 0;
> +		goto out_unlock;
>  
>  	retval = tty_ldisc_reinit(tty, tty->termios.c_line);
>  	if (retval)
>  		tty->count--;
>  
> +out_unlock:
> +	tty_ldisc_unlock(tty);
>  	return retval;
>  }

	-ss
