Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0B2C4646D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 01:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4100F21745
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 01:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4100F21745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbeHNEO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 00:14:56 -0400
Received: from smtprelay0202.hostedemail.com ([216.40.44.202]:42177 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725778AbeHNEOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 00:14:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id C1B21180A844B;
        Tue, 14 Aug 2018 01:30:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: twist79_1df67b9bb1959
X-Filterd-Recvd-Size: 2353
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Aug 2018 01:30:05 +0000 (UTC)
Message-ID: <702abadd074f1aefc8d4566c4da72284a5dd3ec6.camel@perches.com>
Subject: Re: [PATCH 8/9] platform: goldfish: pipe: Replace pr_ with dev_ for
 logging
From:   Joe Perches <joe@perches.com>
To:     rkir@google.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com
Date:   Mon, 13 Aug 2018 18:30:04 -0700
In-Reply-To: <20180813233839.190855-8-rkir@google.com>
References: <20180813233839.190855-1-rkir@google.com>
         <20180813233839.190855-8-rkir@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-13 at 16:38 -0700, rkir@google.com wrote:
> dev_ is preferred if struct device is available.
[]
> diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
[]
> @@ -384,6 +384,7 @@ static ssize_t goldfish_pipe_read_write(struct file *filp,
>  	int count = 0, ret = -EINVAL;
>  	unsigned long address, address_end, last_page;
>  	unsigned int last_page_size;
> +	struct device *pdev_dev;
>  
>  	/* If the emulator already closed the pipe, no need to go further */
>  	if (unlikely(test_bit(BIT_CLOSED_ON_HOST, &pipe->flags)))
> @@ -401,6 +402,8 @@ static ssize_t goldfish_pipe_read_write(struct file *filp,
>  	last_page = (address_end - 1) & PAGE_MASK;
>  	last_page_size = ((address_end - 1) & ~PAGE_MASK) + 1;
>  
> +	pdev_dev = pipe->dev->pdev_dev;
> +
>  	while (address < address_end) {
>  		s32 consumed_size;
>  		int status;
> @@ -433,7 +436,8 @@ static ssize_t goldfish_pipe_read_write(struct file *filp,
>  			 * err.
>  			 */
>  			if (status != PIPE_ERROR_AGAIN)
> -				pr_info_ratelimited("goldfish_pipe: backend error %d on %s\n",
> +				dev_err_ratelimited(pdev_dev,
> +					"goldfish_pipe: backend error %d on %s\n",
>  					status, is_write ? "write" : "read");
>  			break;
>  		}

Wouldn't it be simpler to use pipe->dev->pdev_dev here instead
of creating and assigning a probably unused use-once pointer?

What does the output look like now?

Is the "pipe->dev->pdev_dev->name" then "goldfish_pipe: " output
useful?

