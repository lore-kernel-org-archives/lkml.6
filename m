Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CE2C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188A520874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188A520874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754238AbeFTNnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:43:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750852AbeFTNnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:43:32 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17EAE20846;
        Wed, 20 Jun 2018 13:43:31 +0000 (UTC)
Date:   Wed, 20 Jun 2018 09:43:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Namit Gupta <gupta.namit@samsung.com>
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        linux-kernel@vger.kernel.org, pankaj.m@samsung.com,
        a.sahrawat@samsung.com, himanshu.m@samsung.com
Subject: Re: [PATCH 1/1] remove unnecessary calls of kmalloc and kfree from
 syslog.
Message-ID: <20180620094329.66f76dcd@gandalf.local.home>
In-Reply-To: <20180620102111epcas5p43b88ec3765ff3b088a8ec1c9e97dd71b~51x3osnzY2939929399epcas5p4V@epcas5p4.samsung.com>
References: <CGME20180620102111epcas5p43b88ec3765ff3b088a8ec1c9e97dd71b@epcas5p4.samsung.com>
        <20180620102111epcas5p43b88ec3765ff3b088a8ec1c9e97dd71b~51x3osnzY2939929399epcas5p4V@epcas5p4.samsung.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018 15:46:24 +0530
Namit Gupta <gupta.namit@samsung.com> wrote:

> Below are the actual changes, rest all other visible changes are because of indentation.
> ==========================================================================================
> @@ -1348,16 +1348,23 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
>  {
>     char *text;
>     int len = 0;
> +   u64 next_seq;
> +   u64 seq;
> +   u32 idx;

Please don't do this. We can figure out that the code is indented.
You can mention that the patch is mostly made up of changes because of
indention, but don't add a diff in the change log. Just explain what
and more importantly why you are making your changes here.

Also, the subject is wrong. It should include a topic like "printk:".
Please read Documentation/process/submitting-patches.rst for more
information.

That said, the patch looks fine to me. But please resubmit with a
proper change log.

Thanks,

-- Steve


> 
> Signed-off-by: Namit Gupta <gupta.namit@samsung.com>
> Signed-off-by: Himanshu Maithani <himanshu.m@samsung.com>
> 
> ---
>  kernel/printk/printk.c | 111 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 60 insertions(+), 51 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 512f7c2..53952ce 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1348,71 +1348,80 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
>  {
>  	char *text;
>  	int len = 0;
> +	u64 next_seq;
> +	u64 seq;
> +	u32 idx;
> +
> +	if (!buf) {
> +		if (clear) {
> +			logbuf_lock_irq();
> +			clear_seq = log_next_seq;
> +			clear_idx = log_next_idx;
> +			logbuf_unlock_irq();
> +		}
> +		return 0;
> +	}
> +
>  
>  	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
>  	if (!text)
>  		return -ENOMEM;
>  
>  	logbuf_lock_irq();
> -	if (buf) {
> -		u64 next_seq;
> -		u64 seq;
> -		u32 idx;
>  
> -		/*
> -		 * Find first record that fits, including all following records,
> -		 * into the user-provided buffer for this dump.
> -		 */
> -		seq = clear_seq;
> -		idx = clear_idx;
> -		while (seq < log_next_seq) {
> -			struct printk_log *msg = log_from_idx(idx);
> -
> -			len += msg_print_text(msg, true, NULL, 0);
> -			idx = log_next(idx);
> -			seq++;
> -		}
> +	/*
> +	 * Find first record that fits, including all following records,
> +	 * into the user-provided buffer for this dump.
> +	 */
> +	seq = clear_seq;
> +	idx = clear_idx;
> +	while (seq < log_next_seq) {
> +		struct printk_log *msg = log_from_idx(idx);
>  
> -		/* move first record forward until length fits into the buffer */
> -		seq = clear_seq;
> -		idx = clear_idx;
> -		while (len > size && seq < log_next_seq) {
> -			struct printk_log *msg = log_from_idx(idx);
> +		len += msg_print_text(msg, true, NULL, 0);
> +		idx = log_next(idx);
> +		seq++;
> +	}
>  
> -			len -= msg_print_text(msg, true, NULL, 0);
> -			idx = log_next(idx);
> -			seq++;
> -		}
> +	/* move first record forward until length fits into the buffer */
> +	seq = clear_seq;
> +	idx = clear_idx;
> +	while (len > size && seq < log_next_seq) {
> +		struct printk_log *msg = log_from_idx(idx);
>  
> -		/* last message fitting into this dump */
> -		next_seq = log_next_seq;
> +		len -= msg_print_text(msg, true, NULL, 0);
> +		idx = log_next(idx);
> +		seq++;
> +	}
>  
> -		len = 0;
> -		while (len >= 0 && seq < next_seq) {
> -			struct printk_log *msg = log_from_idx(idx);
> -			int textlen;
> +	/* last message fitting into this dump */
> +	next_seq = log_next_seq;
>  
> -			textlen = msg_print_text(msg, true, text,
> -						 LOG_LINE_MAX + PREFIX_MAX);
> -			if (textlen < 0) {
> -				len = textlen;
> -				break;
> -			}
> -			idx = log_next(idx);
> -			seq++;
> +	len = 0;
> +	while (len >= 0 && seq < next_seq) {
> +		struct printk_log *msg = log_from_idx(idx);
> +		int textlen;
>  
> -			logbuf_unlock_irq();
> -			if (copy_to_user(buf + len, text, textlen))
> -				len = -EFAULT;
> -			else
> -				len += textlen;
> -			logbuf_lock_irq();
> +		textlen = msg_print_text(msg, true, text,
> +				LOG_LINE_MAX + PREFIX_MAX);
> +		if (textlen < 0) {
> +			len = textlen;
> +			break;
> +		}
> +		idx = log_next(idx);
> +		seq++;
>  
> -			if (seq < log_first_seq) {
> -				/* messages are gone, move to next one */
> -				seq = log_first_seq;
> -				idx = log_first_idx;
> -			}
> +		logbuf_unlock_irq();
> +		if (copy_to_user(buf + len, text, textlen))
> +			len = -EFAULT;
> +		else
> +			len += textlen;
> +		logbuf_lock_irq();
> +
> +		if (seq < log_first_seq) {
> +			/* messages are gone, move to next one */
> +			seq = log_first_seq;
> +			idx = log_first_idx;
>  		}
>  	}
>  

