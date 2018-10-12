Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15CEC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5063C2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5063C2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeJLQd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:33:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:56760 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727819AbeJLQd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:33:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1F26CAD9C;
        Fri, 12 Oct 2018 09:02:00 +0000 (UTC)
Date:   Fri, 12 Oct 2018 11:01:59 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] printk: fix integer overflow in setup_log_buf()
Message-ID: <20181012090159.nmqcrodrxi66n2lz@pathway.suse.cz>
References: <20181010103808.882-1-sergey.senozhatsky@gmail.com>
 <20181010113308.9337-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010113308.9337-1-sergey.senozhatsky@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-10-10 20:33:08, Sergey Senozhatsky wrote:
> The way we calculate logbuf free space percentage overflows signed
> integer:
> 
> 	int free;
> 
> 	free = __LOG_BUF_LEN - log_next_idx;
> 	pr_info("early log buf free: %u(%u%%)\n",
> 		free, (free * 100) / __LOG_BUF_LEN);
> 
> We support LOG_BUF_LEN of up to 1<<25 bytes. Since setup_log_buf() is
> called during early init, logbuf is mostly empty, so
> 
> 	__LOG_BUF_LEN - log_next_idx
> 
> is close to 1<<25. Thus when we multiply it by 100, we overflow signed
> integer value range: 100 is 2^6 + 2^5 + 2^2.
> 
> Example, booting with LOG_BUF_LEN 1<<25 and log_buf_len=2G
> boot param:
> 
> [    0.075317] log_buf_len: -2147483648 bytes
> [    0.075319] early log buf free: 33549896(-28%)
> 
> Make "free" unsigned integer and use appropriate printk() specifier.
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

I have pushed this fix into printk.git, for-4.20 branch.

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1116,8 +1116,8 @@ void __init setup_log_buf(int early)
>  	memcpy(log_buf, __log_buf, __LOG_BUF_LEN);
>  	logbuf_unlock_irqrestore(flags);
>  
> -	pr_info("log_buf_len: %d bytes\n", log_buf_len);
> -	pr_info("early log buf free: %d(%d%%)\n",
> +	pr_info("log_buf_len: %u bytes\n", log_buf_len);
> +	pr_info("early log buf free: %u(%u%%)\n",
>  		free, (free * 100) / __LOG_BUF_LEN);
>  }

Please note that this 2nd hunk was already part of the commit
e6fe3e5b7d16e8f14 ("printk: Give error on attempt to set log
buffer length to over 2G"), see
https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/commit/?h=for-4.20&id=e6fe3e5b7d16e8f146a4ae7fe481bc6e97acde1e

Best Regards,
Petr
