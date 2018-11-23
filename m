Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA393C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EB020820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EB020820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504238AbeKWXII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:08:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:34094 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388083AbeKWXII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:08:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8D68FAF59;
        Fri, 23 Nov 2018 12:24:06 +0000 (UTC)
Date:   Fri, 23 Nov 2018 13:24:05 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Make printk_emit() local function.
Message-ID: <20181123122405.3iqc6bvdxkngntzl@pathway.suse.cz>
References: <1542898768-5732-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542898768-5732-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-11-22 23:59:28, Tetsuo Handa wrote:
> printk_emit() is called from only devkmsg_write() in the same file.
> Save object size by making it a local function.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  include/linux/printk.h |  5 -----
>  kernel/printk/printk.c | 31 +++++++++++++++----------------
>  2 files changed, 15 insertions(+), 21 deletions(-)
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -752,6 +752,20 @@ struct devkmsg_user {
>  	char buf[CONSOLE_EXT_LOG_MAX];
>  };
>  
> +static __printf(3, 4) __cold int devkmsg_emit(int facility, int level,
> +					      const char *fmt, ...);

There is no need for the forward declaration. __printf(3, 4)
and __cold could be part of the function definition.
Or do I miss anything?

> +static int devkmsg_emit(int facility, int level, const char *fmt, ...)
> +{
> +	va_list args;
> +	int r;
> +
> +	va_start(args, fmt);
> +	r = vprintk_emit(facility, level, NULL, 0, fmt, args);
> +	va_end(args);
> +
> +	return r;
> +}
> +

Otherwise, the patch makes sense. I like that it removes one
useless EXPORT_SYMBOL().

Best Regards,
Petr
