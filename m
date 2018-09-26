Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2F2C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C83B214D5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C83B214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeIZRR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:17:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:45898 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbeIZRR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:17:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4408BACAE;
        Wed, 26 Sep 2018 11:05:02 +0000 (UTC)
Date:   Wed, 26 Sep 2018 13:05:00 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        He Zhe <zhe.he@windriver.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] printk: Fix panic caused by passing log_buf_len
 to command line
Message-ID: <20180926110500.vfroi373mookavua@pathway.suse.cz>
References: <20180919015030.GA423@jagdpanzerIV>
 <6c354803-5341-7237-9ee3-7882252c7483@windriver.com>
 <20180919023932.GA14090@jagdpanzerIV>
 <20180918224312.6e9aef50@vmware.local.home>
 <1545bc85-b64a-4b45-d40f-79567ac621dc@windriver.com>
 <20180920123056.27b2cf18@gandalf.local.home>
 <20180921073753.mqayzofcofpmhiyu@pathway.suse.cz>
 <20180925120135.GB523@tigerII.localdomain>
 <20180925122300.qq5w4skwmxbzi6sy@pathway.suse.cz>
 <20180925133143.GB601@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925133143.GB601@tigerII.localdomain>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-09-25 22:31:43, Sergey Senozhatsky wrote:
> On (09/25/18 14:23), Petr Mladek wrote:
> > The 32GB was mentioned as an example one year ego. This is not enough
> > for a new syscall from my point of view.
> 
> I agree. I didn't think of syslog(); was merely thinking about logbuf
> and flushing it to the consoles. syslog() stuff is a bit complex. We
> sort of don't expect user space to allocate 64G to read all log_buf
> messages, do we.
> 
> I'm wondering if we can do something like this
> 
> ---
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index cf275f4d7912..1b48b61da8fe 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1110,9 +1110,15 @@ static void __init log_buf_len_update(unsigned size)
>  /* save requested log_buf_len since it's too early to process it */
>  static int __init log_buf_len_setup(char *str)
>  {
> -	unsigned size = memparse(str, &str);
> +	u64 size = memparse(str, &str);
>  
> -	log_buf_len_update(size);
> +	if (size > UINT_MAX) {
> +		size = UINT_MAX;
> +		pr_err("log_buf over 4G is not supported. "
> +			"Please contact printk maintainers.\n");
> +	}
> +
> +	log_buf_len_update((unsigned int)size);
>  
>  	return 0;
>  }
> 
> ---
> 
> So we could know that "the day has come".

Sounds good to me. Just two nits.

First, I would move the check into log_buf_len_update() so that
we catch the overflow also in other situations.

Second, please, keep only the first line. It is enough to describe
the problem. Upstream kernel maintainers are not responsible
for implementing all missing features.

Best Regards,
Petr
