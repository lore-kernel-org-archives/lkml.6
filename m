Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6DDC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FE72184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfADAsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 19:48:02 -0500
Received: from gate.crashing.org ([63.228.1.57]:58433 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbfADAsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 19:48:01 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x040ldeW028655;
        Thu, 3 Jan 2019 18:47:40 -0600
Message-ID: <0adee96b58a533bc8c5927039e96b5ed77c9bbad.camel@kernel.crashing.org>
Subject: Re: [PATCH] fsi:fsi-sbefifo: Fix possible concurrency
 use-after-free bugs in sbefifo_user_release
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, dhowells@redhat.com,
        joel@jms.id.au, eajames@linux.vnet.ibm.com, andrew@aj.id.au
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 04 Jan 2019 11:47:38 +1100
In-Reply-To: <20181226135618.12784-1-baijiaju1990@gmail.com>
References: <20181226135618.12784-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-26 at 21:56 +0800, Jia-Ju Bai wrote:
> In drivers/fsi/fsi-sbefifo.c, the functions sbefifo_user_release(), 
> sbefifo_user_read() and sbefifo_user_write() may be concurrently executed.

So after refreshing my mind, looking at the code and talking with Al, I
really dont' see what race you are trying to fix here.

read/write should never be concurrent with release for a given file and
the stuff we are protecting here is local to the file instance.

Do you have an actual problem you observed ?

Cheers,
Ben.

> sbefifo_user_release()
>   sbefifo_release_command()
>     vfree(user->pending_cmd);
> 
> sbefifo_user_read()
>   mutex_lock();
>   rc = __sbefifo_submit(sbefifo, user->pending_cmd, ...);
> 
> sbefifo_user_write()
>   mutex_lock();
>   user->pending_cmd = user->cmd_page;
>   user->pending_cmd = vmalloc(len);
> 
> Thus, possible concurrency use-after-free bugs may occur in
> sbefifo_user_release().
> 
> To fix these bugs, the calls to mutex_lock() and mutex_unlock() are
> added in sbefifo_user_release().
> 
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/fsi/fsi-sbefifo.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
> index d92f5b87c251..e278a9014b8f 100644
> --- a/drivers/fsi/fsi-sbefifo.c
> +++ b/drivers/fsi/fsi-sbefifo.c
> @@ -900,8 +900,10 @@ static int sbefifo_user_release(struct inode *inode, struct file *file)
>  	if (!user)
>  		return -EINVAL;
>  
> +	mutex_lock(&user->file_lock);
>  	sbefifo_release_command(user);
>  	free_page((unsigned long)user->cmd_page);
> +	mutex_unlock(&user->file_lock);
>  	kfree(user);
>  
>  	return 0;

