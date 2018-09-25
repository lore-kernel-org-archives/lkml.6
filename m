Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E775CC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0F120C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0F120C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbeIYVke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:40:34 -0400
Received: from mail5.windriver.com ([192.103.53.11]:59786 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729438AbeIYVke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:40:34 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w8PFVEQ6023180
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 25 Sep 2018 08:31:30 -0700
Received: from [128.224.162.216] (128.224.162.216) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 25 Sep
 2018 08:31:09 -0700
Subject: Re: [PATCH v2 1/2] printk: Fix panic caused by passing log_buf_len to
 command line
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <1537291068-443145-1-git-send-email-zhe.he@windriver.com>
 <20180919015030.GA423@jagdpanzerIV>
 <6c354803-5341-7237-9ee3-7882252c7483@windriver.com>
 <20180919023932.GA14090@jagdpanzerIV>
 <20180918224312.6e9aef50@vmware.local.home>
 <1545bc85-b64a-4b45-d40f-79567ac621dc@windriver.com>
 <20180920123056.27b2cf18@gandalf.local.home>
 <20180921073753.mqayzofcofpmhiyu@pathway.suse.cz>
 <20180925120135.GB523@tigerII.localdomain>
 <20180925122300.qq5w4skwmxbzi6sy@pathway.suse.cz>
 <20180925133143.GB601@tigerII.localdomain>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <656c4059-ba7b-6756-5e7c-b4cf41c62a2a@windriver.com>
Date:   Tue, 25 Sep 2018 23:31:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925133143.GB601@tigerII.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.216]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年09月25日 21:31, Sergey Senozhatsky wrote:
> On (09/25/18 14:23), Petr Mladek wrote:
>> The 32GB was mentioned as an example one year ego. This is not enough
>> for a new syscall from my point of view.
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

I agree on this idea, a good way to collect the potential requirement.
I can send v4 with it if no objection from other people.

Thanks,
Zhe

>
> 	-ss
>

