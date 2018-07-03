Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90D4C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88607242E5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDpiAl4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88607242E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753467AbeGCP3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:29:50 -0400
Received: from mail-yb0-f170.google.com ([209.85.213.170]:45330 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753307AbeGCP3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:29:48 -0400
Received: by mail-yb0-f170.google.com with SMTP id h127-v6so875848ybg.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DNEQ83OprQEAgHvsRU//nMlE9hnearE9ssNo4dDtMMI=;
        b=vDpiAl4OiA+ZJct1rGKre6UkfMoAU7DyPeK0M77k4YyNo6cYteFeoqx2fGEAX5/BJo
         CJEFefEEGgPmbnPPdi7SbXGOCIcAAaJOlqvY+CMIZ90ax87N02vZdagNV3TAolL5vQya
         3izesFyaSdJEJxcYdWNyvDPUrkK+RdnkcG3T1xTvc19rAAD7YQJpCXuTOpe05OJ58gBj
         2yLHKmwH2mtTtXOATbDUwRtxlAf5LIYwZESti6KU5n9NSzvB1h0bZRbr0Ixgck/OZksc
         jQc+GbiythBKSMNBY6rhUItDrZRq6N/WnmjCqDNYkZzI6sp1VwqP79xi5WwUCLCGigyc
         pgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DNEQ83OprQEAgHvsRU//nMlE9hnearE9ssNo4dDtMMI=;
        b=WsqX2tTazW7P4wcVdUQsFf5PeuSpV5sWmm/qJpY23vbHJf8F3WhNzQip8s6bz3GPg4
         ETjajUZYy+juOztofc2kbwvnfJHow4LbSrr2iZFuAjbGo+xLOg598fGo37JKYy/FsNR+
         gCeCtnj5tYJXXYCno/eZ4lWb+1iPLHY3H0yfM64XOS7Il/L893Djjp2oY8oX/Vi1oWVF
         fk4fmQ9FP2/omutzW41bVWSfxy9otDlaOaZlv1BArV/3hgCZXDn6X0EhDfNhQlA/o+xF
         0w30NVDONnePMeICrCkQVsLjzr4iy6/ZBsTZXPwJZiqDbyG9IkX7F/uV7RHJdmBBfp5Y
         qylA==
X-Gm-Message-State: APt69E1QLf320IgYqlpaX/0WJ5PFf/eCAK/zXazDN2+wD4PRzYLvVI92
        9YF1iAaPFFRbA9Tvqwj5GrM=
X-Google-Smtp-Source: AAOMgpe71xFcaCCY2gt7870sq6agEgOUQT92KizDjz/uPVBRkl5mcS60xJI78X6UU8CVwLwiGz2PcQ==
X-Received: by 2002:a25:15c3:: with SMTP id 186-v6mr1049730ybv.165.1530631787601;
        Tue, 03 Jul 2018 08:29:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:a4be])
        by smtp.gmail.com with ESMTPSA id m19-v6sm562059ywd.90.2018.07.03.08.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 08:29:46 -0700 (PDT)
Date:   Tue, 3 Jul 2018 08:29:44 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: printk() from NMI backtrace can delay a lot
Message-ID: <20180703152944.GQ533219@devbig577.frc2.facebook.com>
References: <bf037670-c647-b34a-486b-53ec3661b48e@i-love.sakura.ne.jp>
 <20180703043021.GA547@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703043021.GA547@jagdpanzerIV>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Sergey.

On Tue, Jul 03, 2018 at 01:30:21PM +0900, Sergey Senozhatsky wrote:
> Cc-ing Linus, Tejun, Andrew
> [I'll keep the entire lockdep report]
> 
> On (07/02/18 19:26), Tetsuo Handa wrote:
> [..]
> > 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606834] swapper/0/0 is trying to acquire lock:
> > 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606835] 00000000316e1432 (console_owner){-.-.}, at: console_unlock+0x1ce/0x8b0
> > 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606840] 
> > 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606841] but task is already holding lock:
> > 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606842] 000000009b45dcb4 (&(&pool->lock)->rlock){-.-.}, at: show_workqueue_state+0x3b2/0x900
> > 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606847] 
> > 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606848] which lock already depends on the new lock.
...
> But anyway. So we can have [but I'm not completely sure. Maybe lockdep has
> something else on its mind] something like this:
> 
> 	CPU1					CPU0
> 
> 	#IRQ					#soft irq
> 	serial8250_handle_irq()			wq_watchdog_timer_fn()
> 	 spin_lock(&uart_port->lock)		 show_workqueue_state()
> 	  serial8250_rx_chars()			   spin_lock(&pool->lock)
> 	   tty_flip_buffer_push()		    printk()
> 	    tty_schedule_flip()			     serial8250_console_write()
> 	     queue_work()			      spin_lock(&uart_port->lock)
> 	      __queue_work()
> 	       spin_lock(&pool->lock)
> 
> We need to break the pool->lock -> uart_port->lock chain.
> 
> - use printk_deferred() to show WQs states [show_workqueue_state() is
>   a timer callback, so local IRQs are enabled]. But show_workqueue_state()
>   is also available via sysrq.
> 
> - what Alan Cox suggested: use spin_trylock() in serial8250_console_write()
>   and just discard (do not print anything on console) console->writes() that
>   can deadlock us [uart_port->lock is already locked]. This basically means
>   that sometimes there will be no output on a serial console, or there
>   will be missing line. Which kind of contradicts the purpose of print
>   out.
> 
> We are facing the risk of no output on serial consoles in both case. Thus
> there must be some other way out of this.

show_workqueue_state() is only used when something is already horribly
broken or when invoked through sysrq.  I'm not sure it's worthwhile to
make invasive changes to avoid lockdep warnings.  If anything, we
should make show_workqueue_state() avoid grabbing pool->lock (e.g. use
trylock and fallback to probe_kernel_reads if that fails).  I'm a bit
skeptical how actually useful that'd be tho.

Thanks.

-- 
tejun
