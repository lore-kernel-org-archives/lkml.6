Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0472CC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E902087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E902087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeILVLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbeILVLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:11:03 -0400
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CBFB20833;
        Wed, 12 Sep 2018 16:05:51 +0000 (UTC)
Date:   Wed, 12 Sep 2018 12:05:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        kbuild test robot <fengguang.wu@intel.com>, pmladek@suse.com,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180912120548.4280f04a@vmware.local.home>
In-Reply-To: <20180912065307.GA606@jagdpanzerIV>
References: <CACT4Y+ZGSefrYL9xtQs=yPMRNFsOUumuJXsShJPhCOBSLySxuw@mail.gmail.com>
        <20180620083126.GA477@jagdpanzerIV>
        <CACT4Y+YMubTm1xduj+XCbQnNwQxYFLjBT33cFKisN1HyeaBpZw@mail.gmail.com>
        <20180620090413.GA444@jagdpanzerIV>
        <20180620091541.GB444@jagdpanzerIV>
        <CACT4Y+bcp4fSBBq3F86T-C4+n-YkeXUGMqpvkJ6vj6mK-TU2EA@mail.gmail.com>
        <20180620110759.GD444@jagdpanzerIV>
        <CACT4Y+aER3O2x2ApM=MVFoFXhp_T_rUeyG9CBx031qyH0voSRg@mail.gmail.com>
        <20180620130628.GA1000@tigerII.localdomain>
        <CAG_fn=XuZo5yrZzVizP26iV6eFfJtAHUs4NsDFXFyvnaJkdSQw@mail.gmail.com>
        <20180912065307.GA606@jagdpanzerIV>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018 15:53:07 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> I scanned some of Linus' emails, and skimmed through previous discussions
> on this topic. Let me quote Linus:
> 
> : 
> : My preference as a user is actually to just have a dynamically
> : re-sizable buffer (that's pretty much what I've done in *every* single
> : user space project I've had in the last decade), but because some
> : users might have atomicity issues I do suspect that we should just use
> : a stack buffer.
> : 
> : And then perhaps say that the buffer size has to be capped at 80 characters.
> : 
> : Because if you're printing more than 80 characters and expecting it
> : all to fit on a line, you're doing something else wrong anyway.
> : 
> : And hide it not as a explicit "char buffer[80]]" allocation, but as a
> : "struct line_buffer" or similar, so that
> : 
> :  (a) people don't get the line size wrong
> : 
> :  (b) the buffering code can add a few fields for length etc in there too
> : 
> : Introduce a few helper functions for it:
> : 
> :  init_line_buffer(&buf);
> :  print_line(&buf, fmt, args);
> :  vprint_line(&buf, fmt, vararg);
> :  finish_line(&buf);
> : 

This sounds like seq_buf to me.

> 
> 
> 
> And this is, basically, what I have attached to this email. It's very
> simple and very short. And I think this is what Linus wanted us to do.
> 
> - usage example
> 
>        DEFINE_PR_LINE(KERN_ERR, pl);
> 
>        pr_line(&pl, "Hello, %s!\n", "buffer");
>        pr_line(&pl, "%s", "OK.\n");
>        pr_line(&pl, "Goodbye, %s", "buffer");
>        pr_line(&pl, "\n");
> 
> dmesg | tail
> 
> [   69.908542] Hello, buffer!
> [   69.908544] OK.
> [   69.908545] Goodbye, buffer
> 
> 
> - pr_cont-like usage
> 
>        DEFINE_PR_LINE(KERN_ERR, pl);
> 
>        pr_line(&pl,"%d ", 1);
>        pr_line(&pl,"%d ", 3);
>        pr_line(&pl,"%d ", 5);
>        pr_line(&pl,"%d ", 7);
>        pr_line(&pl,"%d\n", 9);
> 
> dmesg | tail
> 
> [   69.908546] 1 3 5 7 9
> 
> 
> - An explicit, aux buffer // output should be truncated
> 
>        char buf[16];
>        DEFINE_PR_LINE_BUF(KERN_ERR, ps, buf, sizeof(buf));
> 
>        pr_line(&ps, "Test test test test test test test test test\n");
>        pr_line(&ps, "\n");
> 
> 
> dmesg | tail
> 
> [   69.908547] Test test test ** truncated **
> 
> 
> Opinions? Will this work for us?
> 
> ====
> 
> >From 7fd8407e0081d8979f08dec48e88364d6210b4ab Mon Sep 17 00:00:00 2001  
> From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Subject: [PATCH] printk: add pr_line buffering API
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  include/linux/printk.h | 63 ++++++++++++++++++++++++++++++++++++++++++
>  kernel/printk/printk.c | 55 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 118 insertions(+)
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index cf3eccfe1543..fc5f11c7579c 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -157,6 +157,15 @@ static inline void printk_nmi_direct_enter(void) { }
>  static inline void printk_nmi_direct_exit(void) { }
>  #endif /* PRINTK_NMI */
>  
> +#define PRINTK_PR_LINE_BUF_SZ	80
> +
> +struct pr_line {
> +	char			*buffer;
> +	int			size;
> +	int			len;
> +	char			*level;
> +};

Can you look at implementing this with using a seq_buf?

-- Steve

> +
>  #ifdef CONFIG_PRINTK
>  asmlinkage __printf(5, 0)
>  int vprintk_emit(int facility, int level,
> @@ -209,6 +218,30 @@ extern asmlinkage void dump_stack(void) __cold;
>  extern void printk_safe_init(void);
>  extern void printk_safe_flush(void);
>  extern void printk_safe_flush_on_panic(void);
> +
> +#define DEFINE_PR_LINE(lev, name)				\
> +	char		__pr_line_buf[PRINTK_PR_LINE_BUF_SZ];	\
> +	struct pr_line	name = {				\
> +		.buffer = __pr_line_buf,			\
> +		.size 	= PRINTK_PR_LINE_BUF_SZ,		\
> +		.len 	= 0,					\
> +		.level	= lev,					\
> +	}
> +
> +#define DEFINE_PR_LINE_BUF(lev, name, buf, sz)			\
> +	struct pr_line	name = {				\
> +		.buffer = buf,					\
> +		.size 	= (sz),					\
> +		.len 	= 0,					\
> +		.level	= lev,					\
> +	}
> +
> +extern __printf(2, 3)
> +int pr_line(struct pr_line *pl, const char *fmt, ...);
> +extern __printf(2, 0)
> +int vpr_line(struct pr_line *pl, const char *fmt, va_list args);
> +extern void pr_line_flush(struct pr_line *pl);
> +
>  #else
>  static inline __printf(1, 0)
>  int vprintk(const char *s, va_list args)
> @@ -284,6 +317,36 @@ static inline void printk_safe_flush(void)
>  static inline void printk_safe_flush_on_panic(void)
>  {
>  }
> +
> +#define DEFINE_PR_LINE(lev, name)				\
> +	struct pr_line	name = {				\
> +		.buffer = NULL,					\
> +		.size 	= 0,					\
> +		.len 	= 0,					\
> +		.level	= lev,					\
> +	}
> +
> +#define DEFINE_PR_LINE_BUF(lev, name, buf, sz)			\
> +	struct pr_line	name = {				\
> +		.buffer = buf,					\
> +		.size 	= 0,					\
> +		.len 	= 0,					\
> +		.level	= lev,					\
> +	}
> +
> +static inline __printf(2, 3)
> +int pr_line(struct pr_line *pl, const char *fmt, ...)
> +{
> +	return 0;
> +}
> +static inline __printf(2, 0)
> +int vpr_line(struct pr_line *pl, const char *fmt, va_list args)
> +{
> +	return 0;
> +}
> +static inline void pr_line_flush(struct pr_line *pl)
> +{
> +}
>  #endif
>  
>  extern int kptr_restrict;
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index fd6f8ed28e01..daeb41a57929 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2004,6 +2004,61 @@ asmlinkage __visible int printk(const char *fmt, ...)
>  }
>  EXPORT_SYMBOL(printk);
>  
> +#define PR_LINE_TRUNCATED_MSG "** truncated **\n"
> +
> +int vpr_line(struct pr_line *pl, const char *fmt, va_list args)
> +{
> +	int len;
> +
> +	if (unlikely(pl->size >= LOG_LINE_MAX))
> +		pl->size = LOG_LINE_MAX - sizeof(PR_LINE_TRUNCATED_MSG);
> +
> +	if (fmt[0] == '\n') {
> +		pr_line_flush(pl);
> +		return 0;
> +	}
> +
> +	if (pl->len >= pl->size)
> +		return -1;
> +
> +	len = vsnprintf(pl->buffer + pl->len, pl->size - pl->len, fmt, args);
> +	if (pl->len + len >= pl->size) {
> +		pl->len = pl->size + 1;
> +		return -1;
> +	}
> +
> +	pl->len += len;
> +	if (pl->len && pl->buffer[pl->len - 1] == '\n')
> +		pr_line_flush(pl);
> +	return 0;
> +}
> +EXPORT_SYMBOL(vpr_line);
> +
> +int pr_line(struct pr_line *pl, const char *fmt, ...)
> +{
> +	va_list ap;
> +	int ret;
> +
> +	va_start(ap, fmt);
> +	ret = vpr_line(pl, fmt, ap);
> +	va_end(ap);
> +	return ret;
> +}
> +EXPORT_SYMBOL(pr_line);
> +
> +void pr_line_flush(struct pr_line *pl)
> +{
> +	if (!pl->len)
> +		return;
> +
> +	if (pl->len < pl->size)
> +		printk("%s%.*s", pl->level, pl->len, pl->buffer);
> +	else
> +		printk("%s%.*s%s", pl->level, pl->len, pl->buffer,
> +			PR_LINE_TRUNCATED_MSG);
> +	pl->len = 0;
> +}
> +EXPORT_SYMBOL(pr_line_flush);
>  #else /* CONFIG_PRINTK */
>  
>  #define LOG_LINE_MAX		0

