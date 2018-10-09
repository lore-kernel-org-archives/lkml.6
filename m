Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14EAC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A5F213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A5F213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeJIP36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:29:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:40408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726160AbeJIP36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:29:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D238BACA4;
        Tue,  9 Oct 2018 08:14:12 +0000 (UTC)
Date:   Tue, 9 Oct 2018 10:14:10 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 1/3] printk: keep kernel cont support always enabled
Message-ID: <20181009081410.cunmqz4zc7sdhwkx@pathway.suse.cz>
References: <20181002023836.4487-1-sergey.senozhatsky@gmail.com>
 <20181002023836.4487-2-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002023836.4487-2-sergey.senozhatsky@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-10-02 11:38:34, Sergey Senozhatsky wrote:
> Since 5c2992ee7fd8a29 ("printk: remove console flushing special
> cases for partial buffered lines") we don't print cont fragments
> to the consoles; cont lines are now proper log_buf entries and
> there is no "consecutive continuation flag" anymore: we either
> have 'c' entries that mark continuation lines without fragments;
> or '-' entries that mark normal logbuf entries. There are no '+'
> entries anymore.
> 
> However, we still have a small leftover - presence of ext_console
> drivers disables kernel cont support and we flush each pr_cont()
> and store it as a separate log_buf entry. Previously, it worked
> because msg_print_ext_header() had that "an optional external merge
> of the records" functionality:
> 
> 	if (msg->flags & LOG_CONT)
> 		cont = (prev_flags & LOG_CONT) ? '+' : 'c';
> 
> We don't do this as of now, so keep kernel cont always enabled.
>
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  kernel/printk/printk.c | 22 ++++------------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 308497194bd4..e72cb793aff1 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -192,16 +192,7 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
>  	return 0;
>  }
>  
> -/*
> - * Number of registered extended console drivers.
> - *
> - * If extended consoles are present, in-kernel cont reassembly is disabled
> - * and each fragment is stored as a separate log entry with proper
> - * continuation flag so that every emitted message has full metadata.  This
> - * doesn't change the result for regular consoles or /proc/kmsg.  For
> - * /dev/kmsg, as long as the reader concatenates messages according to
> - * consecutive continuation flags, the end result should be the same too.
> - */
> +/* Number of registered extended console drivers. */
>  static int nr_ext_console_drivers;
>  
>  /*
> @@ -1806,12 +1797,8 @@ static void cont_flush(void)
>  
>  static bool cont_add(int facility, int level, enum log_flags flags, const char *text, size_t len)
>  {
> -	/*
> -	 * If ext consoles are present, flush and skip in-kernel
> -	 * continuation.  See nr_ext_console_drivers definition.  Also, if
> -	 * the line gets too long, split it up in separate records.
> -	 */
> -	if (nr_ext_console_drivers || cont.len + len > sizeof(cont.buf)) {
> +	/* If the line gets too long, split it up in separate records. */
> +	if (cont.len + len > sizeof(cont.buf)) {
>  		cont_flush();
>  		return false;
>  	}

Just to be sure. The original purpose was to get full information
including the metadata and dictionary via extended console drivers,
see commit 6fe29354befe4c46e ("printk: implement support for extended
console drivers").

IMHO, only the dictionary was really important but it was actually
lost:

  static void cont_flush(void)
  {
  [...]
	log_store(cont.facility, cont.level, cont.flags, cont.ts_nsec,
		  NULL, 0, cont.buf, cont.len);

Nobody noticed because the only dictionary user is dev_printk()
and dev_cont() is _not_ defined.

As a result, I think that this change will rather improve things.
Well, I wonder if we should write something of the above into
the commit message. Either way:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
