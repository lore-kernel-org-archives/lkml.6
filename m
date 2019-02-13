Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73531C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3C921904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbfBMNgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:36:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732064AbfBMNgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:36:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5C1B217F5;
        Wed, 13 Feb 2019 13:36:36 +0000 (UTC)
Date:   Wed, 13 Feb 2019 08:36:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <miaoxie@huawei.com>
Subject: Re: [PATCH] tracing: fix incorrect tracer freeing when opening
 tracing pipe
Message-ID: <20190213083635.36f4762e@gandalf.local.home>
In-Reply-To: <1550060946-45984-1-git-send-email-yi.zhang@huawei.com>
References: <1550060946-45984-1-git-send-email-yi.zhang@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 20:29:06 +0800
"zhangyi (F)" <yi.zhang@huawei.com> wrote:

> Commit d716ff71dd12 ("tracing: Remove taking of trace_types_lock in
> pipe files") use the current tracer instead of the copy in
> tracing_open_pipe(), but it forget to remove the freeing sentence in
> the error path.
> 
> Fixes: d716ff71dd12 ("tracing: Remove taking of trace_types_lock in pipe files")

Thanks.

As this is harmless (frees to NULL is ok, and iter is allocated with
kzalloc()), I'm going to just add this for the next merge window.

-- Steve

> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> ---
>  kernel/trace/trace.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index c521b73..b583ff7 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5624,7 +5624,6 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
>  	return ret;
>  
>  fail:
> -	kfree(iter->trace);
>  	kfree(iter);
>  	__trace_array_put(tr);
>  	mutex_unlock(&trace_types_lock);

