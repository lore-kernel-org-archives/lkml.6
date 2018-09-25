Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC05BC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D7920858
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D7920858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbeIYRl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:41:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:53866 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727606AbeIYRl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:41:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8C9F7AEB0;
        Tue, 25 Sep 2018 11:34:48 +0000 (UTC)
Date:   Tue, 25 Sep 2018 13:34:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     zhe.he@windriver.com
Cc:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] printk: Add KBUILD_MODNAME and correct wrong
 casting
Message-ID: <20180925113448.znikvm7bwz5hbwpc@pathway.suse.cz>
References: <1537630852-247674-1-git-send-email-zhe.he@windriver.com>
 <1537630852-247674-2-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537630852-247674-2-git-send-email-zhe.he@windriver.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2018-09-22 23:40:52, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> Add KBUILD_MODNAME to make prints more clear and correct wrong casting that
> might cut off the normal output.
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> Cc: pmladek@suse.com
> Cc: sergey.senozhatsky@gmail.com
> Cc: rostedt@goodmis.org
> ---
> v2:
> Correct one more place
> v3:
> Correct wrong casting
> 
>  kernel/printk/printk.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index d9821c0..6b059a0 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -16,6 +16,8 @@
>   *	01Mar01 Andrew Morton
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +

This patch should remove all explicit prefixes to avoid duplication.
I see one:

	pr_info("printk: continuation disabled due to ext consoles, expect more fragments in /dev/kmsg\n");


>  #include <linux/kernel.h>
>  #include <linux/mm.h>
>  #include <linux/tty.h>
> @@ -2358,8 +2360,9 @@ void console_unlock(void)
>  		printk_safe_enter_irqsave(flags);
>  		raw_spin_lock(&logbuf_lock);
>  		if (console_seq < log_first_seq) {
> -			len = sprintf(text, "** %u printk messages dropped **\n",
> -				      (unsigned)(log_first_seq - console_seq));
> +			len = sprintf(text,
> +				      "** %llu printk messages dropped **\n",
> +				      log_first_seq - console_seq);

On the contrary, please, put this fix into a separate patch. It is a
candidate for stable backports.

Best Regards,
Petr
