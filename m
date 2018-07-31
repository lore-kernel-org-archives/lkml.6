Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AB7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3538C20844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3538C20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbeGaStG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:49:06 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42222 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbeGaStG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:49:06 -0400
Received: by mail-qt0-f195.google.com with SMTP id z8-v6so16727453qto.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 10:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WBgbT13wNojpZXbdhEfLoJAbFCIL7AQ9HO+enE/fwio=;
        b=jisKCkbjYKMG7JLbqRXWXnpTHjGfSuUgvhlNBNX3fxmdihi+KqAxS/G+BjDZoFegqK
         XGTU5D3rI7sip/EDOrH3joutcj7JljWZ/Stmez0kqEJ8sivuyer0VSY5YDTDW/WOp+Sc
         yU32kzdpe1aJ9WMbuADK3TPKY/Rwc6EngSOR3rz+bjEwU1bed+tui9ZvlcNclhpPodnN
         2dEeqzrY42tEtHn3oBb6PYSOcMeCt4yQXc+PBv+Uqwy6aUT7jKYpaah4vzqL/odN/Aht
         JdEwew7RCNCo3faSzd+vHkBx6DX41khlZ4Asq85fVLweQRJLXftVlPd4ypP9ShhkK/5d
         qkmg==
X-Gm-Message-State: AOUpUlFsTIu2yQ8JBMbHhmXQJSClT6gizjD405JonyS1nFtQ5PkWivsH
        tOvkc3e3DbGIS7bwRNRmYfFczw==
X-Google-Smtp-Source: AAOMgpeJ7UHFmkGpYSeyL9erPMAZB2hKZb1WtLAszsnqplk19cGwyxk3nZASU/29g3vaXx16N7yWmA==
X-Received: by 2002:ac8:218d:: with SMTP id 13-v6mr21911447qty.122.1533056870950;
        Tue, 31 Jul 2018 10:07:50 -0700 (PDT)
Received: from t460s.bristot.redhat.com (host159-104-dynamic.182-80-r.retail.telecomitalia.it. [80.182.104.159])
        by smtp.gmail.com with ESMTPSA id a144-v6sm9946350qkc.84.2018.07.31.10.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 10:07:50 -0700 (PDT)
Subject: Re: [PATCH] nohz: Fix local_timer_softirq_pending()
To:     Anna-Maria Gleixner <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     bigeasy@linutronix.de, tglx@linutronix.de, frederic@kernel.org,
        paulmck@linux.vnet.ibm.com, peterz@infradead.org
References: <20180731161358.29472-1-anna-maria@linutronix.de>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <686f5d08-e910-9be1-6914-3164e723c16e@redhat.com>
Date:   Tue, 31 Jul 2018 19:07:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731161358.29472-1-anna-maria@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/2018 06:13 PM, Anna-Maria Gleixner wrote:
> local_timer_softirq_pending() checks whether the timer softirq is
> pending with: local_softirq_pending() & TIMER_SOFTIRQ.
> 
> This is wrong because TIMER_SOFTIRQ is the softirq number and not a
> bitmask. So the test checks for the wrong bit.
> 
> Use BIT(TIMER_SOFTIRQ) instead.

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel

> Fixes: 5d62c183f9e9 ("nohz: Prevent a timer interrupt storm in tick_nohz_stop_sched_tick()")
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> ---
>  kernel/time/tick-sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index da9455a6b42b..5b33e2f5c0ed 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -642,7 +642,7 @@ static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
>  
>  static inline bool local_timer_softirq_pending(void)
>  {
> -	return local_softirq_pending() & TIMER_SOFTIRQ;
> +	return local_softirq_pending() & BIT(TIMER_SOFTIRQ);
>  }
>  
>  static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
> 

