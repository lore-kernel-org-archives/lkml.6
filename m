Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7938C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5948220671
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5948220671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbeIYRcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:32:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:52674 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728421AbeIYRcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:32:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B2855AFCA;
        Tue, 25 Sep 2018 11:25:16 +0000 (UTC)
Date:   Tue, 25 Sep 2018 13:25:14 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     zhe.he@windriver.com
Cc:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] printk: Fix panic caused by passing log_buf_len
 to command line
Message-ID: <20180925112514.vpxu6ldy3r4hglj6@pathway.suse.cz>
References: <1537630852-247674-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537630852-247674-1-git-send-email-zhe.he@windriver.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2018-09-22 23:40:51, zhe.he@windriver.com wrote:
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 9bf5404..d9821c0 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1048,7 +1048,14 @@ static void __init log_buf_len_update(unsigned size)
>  /* save requested log_buf_len since it's too early to process it */
>  static int __init log_buf_len_setup(char *str)
>  {
> -	unsigned size = memparse(str, &str);
> +	unsigned int size;
> +
> +	if (!str) {
> +		pr_err("boot command line parameter value not provided\n");

This message is too generic. It would be hard to guess what parameter was
affected. Also it is not fatal, so I would just use warning,
something like:

pr_warn("Warning: No value defined for the command line parameter: log_bug_len\n");

> +		return -EINVAL;
> +	}
> +
> +	size = memparse(str, &str);
>  
>  	log_buf_len_update(size);

Best Regards,
Petr
