Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4579FC04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 01:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2EDD20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 01:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2EDD20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeINGYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 02:24:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728165AbeINGYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 02:24:33 -0400
Received: from vmware.local.home (unknown [206.121.37.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C5DD20861;
        Fri, 14 Sep 2018 01:12:34 +0000 (UTC)
Date:   Thu, 13 Sep 2018 21:12:32 -0400
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
Message-ID: <20180913211232.06e6ad64@vmware.local.home>
In-Reply-To: <20180913071204.GA604@jagdpanzerIV>
References: <CACT4Y+YMubTm1xduj+XCbQnNwQxYFLjBT33cFKisN1HyeaBpZw@mail.gmail.com>
        <20180620090413.GA444@jagdpanzerIV>
        <20180620091541.GB444@jagdpanzerIV>
        <CACT4Y+bcp4fSBBq3F86T-C4+n-YkeXUGMqpvkJ6vj6mK-TU2EA@mail.gmail.com>
        <20180620110759.GD444@jagdpanzerIV>
        <CACT4Y+aER3O2x2ApM=MVFoFXhp_T_rUeyG9CBx031qyH0voSRg@mail.gmail.com>
        <20180620130628.GA1000@tigerII.localdomain>
        <CAG_fn=XuZo5yrZzVizP26iV6eFfJtAHUs4NsDFXFyvnaJkdSQw@mail.gmail.com>
        <20180912065307.GA606@jagdpanzerIV>
        <20180912120548.4280f04a@vmware.local.home>
        <20180913071204.GA604@jagdpanzerIV>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018 16:12:54 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  include/linux/seq_buf.h | 35 +++++++++++++++++++++++++++++++
>  lib/seq_buf.c           | 46 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 81 insertions(+)
> 
> diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
> index aa5deb041c25..5e9a5ff9a440 100644
> --- a/include/linux/seq_buf.h
> +++ b/include/linux/seq_buf.h
> @@ -23,6 +23,36 @@ struct seq_buf {
>  	loff_t			readpos;
>  };
>  
> +#define __SEQ_BUF_INITIALIZER(buf, length) {				\
> +	.buffer			= (buf),				\
> +	.size			= (length),				\
> +	.len			= 0,					\
> +	.readpos		= 0, }

Nit, but the end bracket '}' should be on it's own line. Even when
part of a macro.

> +
> +#ifdef CONFIG_PRINTK
> +#define __PR_LINE_BUF_SZ	80
> +#else
> +#define __PR_LINE_BUF_SZ	0
> +#endif
> +
> +struct pr_line {
> +	struct seq_buf		sb;
> +	char			*level;
> +};
> +
> +#define DEFINE_PR_LINE(lev, name)					\
> +	char		__line[__PR_LINE_BUF_SZ];			\

To protect against name space collision could you use:

	char		__line_##name[__PR_LINE_BUF_SZ];

> +	struct pr_line	name = {					\
> +		.sb = __SEQ_BUF_INITIALIZER(__line, __PR_LINE_BUF_SZ),	\
> +		.level	= lev,						\
> +	}
> +
> +#define DEFINE_PR_LINE_BUF(lev, name, buf, sz)				\
> +	struct pr_line	name = {					\
> +		.sb = __SEQ_BUF_INITIALIZER(buf, (sz)),		\
> +		.level	= lev,						\
> +	}
> +
>  static inline void seq_buf_clear(struct seq_buf *s)
>  {
>  	s->len = 0;
> @@ -131,4 +161,9 @@ extern int
>  seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary);
>  #endif
>  
> +extern __printf(2, 0)
> +int vpr_line(struct pr_line *pl, const char *fmt, va_list args);
> +extern __printf(2, 3)
> +int pr_line(struct pr_line *pl, const char *fmt, ...);
> +extern void pr_line_flush(struct pr_line *pl);
>  #endif /* _LINUX_SEQ_BUF_H */
> diff --git a/lib/seq_buf.c b/lib/seq_buf.c
> index 11f2ae0f9099..29bc4f24b83e 100644
> --- a/lib/seq_buf.c
> +++ b/lib/seq_buf.c
> @@ -324,3 +324,49 @@ int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, int cnt)
>  	s->readpos += cnt;
>  	return cnt;
>  }
> +
> +int vpr_line(struct pr_line *pl, const char *fmt, va_list args)
> +{
> +	struct seq_buf *s = &pl->sb;
> +	int ret, len;
> +
> +	if (fmt[0] == '\n') {
> +		pr_line_flush(pl);
> +		return 0;
> +	}
> +
> +	ret = seq_buf_vprintf(s, fmt, args);
> +
> +	len = seq_buf_used(s);
> +	if (len && s->buffer[len - 1] == '\n')
> +		pr_line_flush(pl);
> +
> +	return ret;
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
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(pr_line);
> +
> +void pr_line_flush(struct pr_line *pl)
> +{
> +	struct seq_buf *s = &pl->sb;
> +	int len = seq_buf_used(s);
> +
> +	if (!len)
> +		return;
> +
> +	printk("%s%.*s", pl->level, len, s->buffer);
> +	seq_buf_clear(s);
> +}
> +EXPORT_SYMBOL(pr_line_flush);

The rest looks fine to me.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
