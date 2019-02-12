Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D28C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF60E222C6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbfBLTqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:46:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbfBLTqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:46:09 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2F7D222C1;
        Tue, 12 Feb 2019 19:46:07 +0000 (UTC)
Date:   Tue, 12 Feb 2019 14:46:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xiang Xiao <xiaoxiang781216@gmail.com>
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        linux-kernel@vger.kernel.org, Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: Re: [PATCH] printk: add KERN_NOTIME to skip the timestamp
Message-ID: <20190212144606.4b7cf0f8@gandalf.local.home>
In-Reply-To: <1549995065-27597-1-git-send-email-xiaoxiang@xiaomi.com>
References: <1549995065-27597-1-git-send-email-xiaoxiang@xiaomi.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 02:11:05 +0800
Xiang Xiao <xiaoxiang781216@gmail.com> wrote:

> Because log may already add the timestamp sometime

Can you be a bit more detailed on this. When and where does this
happen? If anything, I would probably prefer that we export whether
time is being printed, and have the caller not print time if printk is
doing it already, than to add the complexity into printk itself.

-- Steve

> 
> Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
> ---
>  include/linux/kern_levels.h | 2 ++
>  include/linux/printk.h      | 1 +
>  kernel/printk/printk.c      | 7 ++++++-
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/kern_levels.h b/include/linux/kern_levels.h
> index d237fe8..ed2aec6 100644
> --- a/include/linux/kern_levels.h
> +++ b/include/linux/kern_levels.h
> @@ -23,6 +23,8 @@
>   */
>  #define KERN_CONT	KERN_SOH "c"
>  
> +#define KERN_NOTIME	KERN_SOH "t"	/* don't print the timestamp */
> +
>  /* integer equivalents of KERN_<LEVEL> */
>  #define LOGLEVEL_SCHED		-2	/* Deferred messages from sched code
>  					 * are set to this special level */
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 77740a5..be12ac4 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -20,6 +20,7 @@ static inline int printk_get_level(const char *buffer)
>  		case '0' ... '7':
>  		case 'd':	/* KERN_DEFAULT */
>  		case 'c':	/* KERN_CONT */
> +		case 't':	/* KERN_NOTIME */
>  			return buffer[1];
>  		}
>  	}
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index d3d1703..0688cf2 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -346,6 +346,7 @@ enum log_flags {
>  	LOG_NEWLINE	= 2,	/* text ended with a newline */
>  	LOG_PREFIX	= 4,	/* text started with a prefix */
>  	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
> +	LOG_NOTIME	= 16,	/* don't print the timestamp */
>  };
>  
>  struct printk_log {
> @@ -1247,7 +1248,7 @@ static size_t print_prefix(const struct printk_log *msg, bool syslog,
>  
>  	if (syslog)
>  		len = print_syslog((msg->facility << 3) | msg->level, buf);
> -	if (time)
> +	if (time && !(msg->flags & LOG_NOTIME))
>  		len += print_time(msg->ts_nsec, buf + len);
>  	return len;
>  }
> @@ -1873,6 +1874,10 @@ int vprintk_store(int facility, int level,
>  				break;
>  			case 'c':	/* KERN_CONT */
>  				lflags |= LOG_CONT;
> +				break;
> +			case 't':	/* KERN_NOTIME */
> +				lflags |= LOG_NOTIME;
> +				break;
>  			}
>  
>  			text_len -= 2;

