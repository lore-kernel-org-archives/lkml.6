Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DADC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A40420881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nzgiy88B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A40420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeJPPQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:16:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51216 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbeJPPQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B+vNUJtfQjaHJQGUC7SAo0gIOlD56IjSa/2Zqx2Dkss=; b=Nzgiy88BIqTWQcoAe+iOhPrlB
        3GjdJXxmpFJINvQbxTyJCtGAqctwV0nJFO5x6HwKvW+QD+KRlNsdmlATqzZPIXQup5hiiAeKhJsgF
        cYzeOeuwRgTy1xnOFn0hduXKe5SfR51dRfTIQcxRaPzCIhEka1Q/POHto51jB7PIcF7orGo4nmrgX
        TU9/vwU/Lo5p5W5TOZbkEYiBHfCwbhDuI2lkJY3t8ZaBXLe9BWHcZcylvt5/L1mvAtXExq2kNsiFB
        5blk64i0ReApCx4lmH1UXluuObqPRBjExqGYBR/U26OSLSCr8zfz8ZTjpxloa5gs/6Vh18oc/QqdG
        0T+/v4C1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCJlD-000083-TD; Tue, 16 Oct 2018 07:27:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D86420297B77; Tue, 16 Oct 2018 09:27:19 +0200 (CEST)
Date:   Tue, 16 Oct 2018 09:27:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCHv2 2/4] printk: move printk_safe macros to printk
 header
Message-ID: <20181016072719.GB4030@hirez.programming.kicks-ass.net>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 02:04:26PM +0900, Sergey Senozhatsky wrote:
> Make printk_safe_enter_irqsave()/etc macros available to the
> rest of the kernel.
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  include/linux/printk.h      | 40 +++++++++++++++++++++++++++++++++++++
>  kernel/printk/internal.h    | 37 ----------------------------------
>  kernel/printk/printk_safe.c |  6 ++++--
>  3 files changed, 44 insertions(+), 39 deletions(-)
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index cf3eccfe1543..75f99441fd54 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -157,6 +157,46 @@ static inline void printk_nmi_direct_enter(void) { }
>  static inline void printk_nmi_direct_exit(void) { }
>  #endif /* PRINTK_NMI */
>  
> +#ifdef CONFIG_PRINTK
> +extern void printk_safe_enter(void);
> +extern void printk_safe_exit(void);
> +
> +#define printk_safe_enter_irqsave(flags)	\
> +	do {					\
> +		local_irq_save(flags);		\
> +		printk_safe_enter();		\
> +	} while (0)
> +
> +#define printk_safe_exit_irqrestore(flags)	\
> +	do {					\
> +		printk_safe_exit();		\
> +		local_irq_restore(flags);	\
> +	} while (0)
> +
> +#define printk_safe_enter_irq()		\
> +	do {					\
> +		local_irq_disable();		\
> +		printk_safe_enter();		\
> +	} while (0)
> +
> +#define printk_safe_exit_irq()			\
> +	do {					\
> +		printk_safe_exit();		\
> +		local_irq_enable();		\
> +	} while (0)

So I really _really_ hate all this. Utterly detest it.

That whole magic 'safe' printk buffer crap is just that crap.

Instead of this tinkering around the edges, why don't you make the main
logbuf a lockless ringbuffer and then delegate the actual printing of
that buffer to a kthread, except for earlycon, which can do synchronous
output.
