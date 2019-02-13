Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227EDC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA474222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392332AbfBMOos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:44:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:59154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728867AbfBMOos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:44:48 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF09F2075D;
        Wed, 13 Feb 2019 14:44:46 +0000 (UTC)
Date:   Wed, 13 Feb 2019 09:44:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Slavomir Kaslev <kaslevs@vmware.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: Make splice() and tee() take into account
 O_NONBLOCK flag on pipes
Message-ID: <20190213094445.1774f959@gandalf.local.home>
In-Reply-To: <20190207154519.8635-1-kaslevs@vmware.com>
References: <20190207154519.8635-1-kaslevs@vmware.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Feb 2019 17:45:19 +0200
Slavomir Kaslev <kaslevs@vmware.com> wrote:

> The current implementation of splice() and tee() ignores O_NONBLOCK set on pipe
> file descriptors and checks only the SPLICE_F_NONBLOCK flag for blocking on pipe
> arguments. This is inconsistent since splice()-ing from/to non-pipe file
> descriptors does take O_NONBLOCK into consideration.
> 
> Fix this by promoting O_NONBLOCK, when set on a pipe, to SPLICE_F_NONBLOCK.
> 
> Some context for how the current implementation of splice() leads to
> inconsistent behavior. In the ongoing work[1] to add VM tracing capability to
> trace-cmd we stream tracing data over named FIFOs or vsockets from guests back
> to the host.
> 
> When we receive SIGINT from user to stop tracing, we set O_NONBLOCK on the input
> file descriptor and set SPLICE_F_NONBLOCK for the next call to splice(). If
> splice() was blocked waiting on data from the input FIFO, after SIGINT splice()
> restarts with the same arguments (no SPLICE_F_NONBLOCK) and blocks again instead
> of returning -EAGAIN when no data is available.
> 
> This differs from the splice() behavior when reading from a vsocket or when
> we're doing a traditional read()/write() loop (trace-cmd's --nosplice argument).
> 
> With this patch applied we get the same behavior in all situations after setting
> O_NONBLOCK which also matches the behavior of doing a read()/write() loop
> instead of splice().
> 
> This change does have potential of breaking users who don't expect EAGAIN from
> splice() when SPLICE_F_NONBLOCK is not set. OTOH programs that set O_NONBLOCK
> and don't anticipate EAGAIN are arguably buggy[2].

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Does anyone have any issues or comments about this patch?

Thanks!

-- Steve

> 
> [1] https://github.com/skaslev/trace-cmd/tree/vsock
> [2] https://github.com/torvalds/linux/blob/d47e3da1759230e394096fd742aad423c291ba48/fs/read_write.c#L1425
> 
> Signed-off-by: Slavomir Kaslev <kaslevs@vmware.com>
> ---
>  fs/splice.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/fs/splice.c b/fs/splice.c
> index de2ede048473..6a1761b74f8d 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1123,6 +1123,9 @@ static long do_splice(struct file *in, loff_t __user *off_in,
>  		if (ipipe == opipe)
>  			return -EINVAL;
>  
> +		if ((in->f_flags | out->f_flags) & O_NONBLOCK)
> +			flags |= SPLICE_F_NONBLOCK;
> +
>  		return splice_pipe_to_pipe(ipipe, opipe, len, flags);
>  	}
>  
> @@ -1148,6 +1151,9 @@ static long do_splice(struct file *in, loff_t __user *off_in,
>  		if (unlikely(ret < 0))
>  			return ret;
>  
> +		if (in->f_flags & O_NONBLOCK)
> +			flags |= SPLICE_F_NONBLOCK;
> +
>  		file_start_write(out);
>  		ret = do_splice_from(ipipe, out, &offset, len, flags);
>  		file_end_write(out);
> @@ -1172,6 +1178,9 @@ static long do_splice(struct file *in, loff_t __user *off_in,
>  			offset = in->f_pos;
>  		}
>  
> +		if (out->f_flags & O_NONBLOCK)
> +			flags |= SPLICE_F_NONBLOCK;
> +
>  		pipe_lock(opipe);
>  		ret = wait_for_space(opipe, flags);
>  		if (!ret)
> @@ -1717,6 +1726,9 @@ static long do_tee(struct file *in, struct file *out, size_t len,
>  	 * copying the data.
>  	 */
>  	if (ipipe && opipe && ipipe != opipe) {
> +		if ((in->f_flags | out->f_flags) & O_NONBLOCK)
> +			flags |= SPLICE_F_NONBLOCK;
> +
>  		/*
>  		 * Keep going, unless we encounter an error. The ipipe/opipe
>  		 * ordering doesn't really matter.

