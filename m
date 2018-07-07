Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93306C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E5F218C0
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E5F218C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932380AbeGGIo0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 04:44:26 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50782 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753977AbeGGIoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 04:44:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EB7BE207BD; Sat,  7 Jul 2018 10:44:21 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id AA4C5207BD;
        Sat,  7 Jul 2018 10:44:11 +0200 (CEST)
Date:   Sat, 7 Jul 2018 10:44:12 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Jann Horn <jannh@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtdchar: fix overflows in adjustment of `count`
Message-ID: <20180707104412.1580a285@bbrezillon>
In-Reply-To: <20180707033722.219468-1-jannh@google.com>
References: <20180707033722.219468-1-jannh@google.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  7 Jul 2018 05:37:22 +0200
Jann Horn <jannh@google.com> wrote:

> The first checks in mtdchar_read() and mtdchar_write() attempt to limit
> `count` such that `*ppos + count <= mtd->size`. However, they ignore the
> possibility of `*ppos > mtd->size`, allowing the calculation of `count` to
> wrap around. `mtdchar_lseek()` prevents seeking beyond mtd->size, but the
> pread/pwrite syscalls bypass this.
> 
> I haven't found any codepath on which this actually causes dangerous
> behavior, but it seems like a sensible change anyway.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  drivers/mtd/mtdchar.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
> index cd67c85cc87d..02389528f622 100644
> --- a/drivers/mtd/mtdchar.c
> +++ b/drivers/mtd/mtdchar.c
> @@ -160,8 +160,12 @@ static ssize_t mtdchar_read(struct file *file, char __user *buf, size_t count,
>  
>  	pr_debug("MTD_read\n");
>  
> -	if (*ppos + count > mtd->size)
> -		count = mtd->size - *ppos;
> +	if (*ppos + count > mtd->size) {
> +		if (*ppos < mtd->size)
> +			count = mtd->size - *ppos;
> +		else
> +			count = 0;
> +	}

Hm, shouldn't we return -ERANGE or -EINVAL if *ppos >= mtd->size?

>  
>  	if (!count)
>  		return 0;
> @@ -246,7 +250,7 @@ static ssize_t mtdchar_write(struct file *file, const char __user *buf, size_t c
>  
>  	pr_debug("MTD_write\n");
>  
> -	if (*ppos == mtd->size)
> +	if (*ppos >= mtd->size)
>  		return -ENOSPC;
>  
>  	if (*ppos + count > mtd->size)

