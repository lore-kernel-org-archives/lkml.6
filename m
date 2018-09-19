Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35ACC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772D7214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772D7214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbeISQ5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:57:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:52306 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727948AbeISQ5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:57:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A030DB032;
        Wed, 19 Sep 2018 11:20:19 +0000 (UTC)
Date:   Wed, 19 Sep 2018 13:20:18 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     zhe.he@windriver.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] printk: Add KBUILD_MODNAME and correct bare use
 of unsigned
Message-ID: <20180919112018.fvncsxc7goffdhpo@pathway.suse.cz>
References: <1537291068-443145-1-git-send-email-zhe.he@windriver.com>
 <1537291068-443145-2-git-send-email-zhe.he@windriver.com>
 <20180919020621.GA390@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919020621.GA390@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-09-19 11:06:21, Sergey Senozhatsky wrote:
> On (09/19/18 01:17), zhe.he@windriver.com wrote:
> > Add KBUILD_MODNAME to make prints more clear.
> 
> No strong opinion. I'm OK with this change.
> 
> > And use 'unsigned int' intead of 'unsigned' according to
> > checkpatch.pl's suggestion.
> 
> I don't think that "unsigned int" is the right thing to use there.
> 
> >  		if (console_seq < log_first_seq) {
> >  			len = sprintf(text, "** %u printk messages dropped **\n",
> > -				      (unsigned)(log_first_seq - console_seq));
> > +				   (unsigned int)(log_first_seq - console_seq));
> 
> Both log_first_seq and console_seq are u64.
> 
> 	log_first_seq - console_seq
> 
> thus, *in theory*, can be larger than "unsigned int". So I'd just avoid cast
> and use an appropriate for u64 %llu sprintf() specifier. Something like below,
> perhaps:
> 
> ---
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index f73ea9dd6f46..4b8c5832bf14 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2408,8 +2408,9 @@ void console_unlock(void)
>  		printk_safe_enter_irqsave(flags);
>  		raw_spin_lock(&logbuf_lock);
>  		if (console_seq < log_first_seq) {
> -			len = sprintf(text, "** %u printk messages dropped **\n",
> -				   (unsigned int)(log_first_seq - console_seq));
> +			len = sprintf(text,
> +				      "** %llu printk messages dropped **\n",
> +				      log_first_seq - console_seq);

This looks like a better solution.

Also please, define pr_fmt and fix the casting in separate patches.

Best Regards,
Petr
