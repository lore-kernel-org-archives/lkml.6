Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A04C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E87C2243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYhHeMWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E87C2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbeKMBcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:32:45 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43252 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbeKMBcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:32:45 -0500
Received: by mail-ot1-f67.google.com with SMTP id a11so4679635otr.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 07:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3ZmIoSqLDkxOqNv3gJoK995QMDfIAWxWuAIxVzmX8DU=;
        b=MYhHeMWkKgST/YOZx+WLnrCjZTYC2gSRcNLRDh1i82PKFBCnooDsgALInEwKW9ZWz1
         COEw6VzVHEfQ+UVuJ3WHjS3JLHf1AgkP7OmX6FYHChIiG4t6X//DSSq7/uvUgotaPMQE
         cENDSZfhMyK/3oCXyQLjOzqJQVeDPjrLL9L5i3wsBukL/3/mmgaDKYJ+PLgPhIxojHfD
         19UT0iI8Z6GsG7BbE6wPeSNrR3T+urvcNx0ZnFwlkGNbbR7AeXme1QQ4zcMKQyvXgWZN
         F9rgzjlCXGAFkd3V5Er1ygQH1L0Sao0EiadAQcpahvXGVSO4+PHf0YZgM9L/yFX1SrbM
         LlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=3ZmIoSqLDkxOqNv3gJoK995QMDfIAWxWuAIxVzmX8DU=;
        b=okXqCECT6u/TE1MZxrIOOxiKC/k/32j4eX5XBi+j87J6rJhL6UP0mk958385l4nKGP
         W9kGGkYwlQiQ7q3WefOyT6dJvu/V1ZmrclYYvr6hNvUNLoRgpFNZe1S1g02cfFniZgmk
         4sQ/kI5POK2zAU5kOzUobO+Zl+Ok8cGQrV0n+iSSWy003YsAv+GAz2lqwlAc66iFmiTK
         VjeUyI+H59QGq4Eo2D+DFyYNdmB9nqt7uPE4AsckuPfmSZZtWJlf1BDTdIg4mwlmJ/ht
         4LQEkA3CB0JkX9GcAYvp/ToGAbAKwUlipJCDLwk4spYeZdRjpiiyeGjUlaCbQmOyGtKI
         yXaQ==
X-Gm-Message-State: AGRZ1gJZk5ZGKj5aPAwIMP8hNG1E3n1QaQrd1LPl/ebkXy8ihivDPrc9
        ACQ3QdxlGSV/1n0hAtxAxQ==
X-Google-Smtp-Source: AJdET5fn2wzm8PAZCf1c4M/LVNg1nrdapLqdFxlmieUJiVYO/q1t+Ftp+b2r1keoYjgF4iCfjyF+3Q==
X-Received: by 2002:a9d:5249:: with SMTP id q9mr824046otg.160.1542037138589;
        Mon, 12 Nov 2018 07:38:58 -0800 (PST)
Received: from serve.minyard.net ([47.184.128.64])
        by smtp.gmail.com with ESMTPSA id d140-v6sm12286354oig.7.2018.11.12.07.38.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 07:38:57 -0800 (PST)
Received: from [192.168.27.3] (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPSA id 4327797E;
        Mon, 12 Nov 2018 09:38:56 -0600 (CST)
Reply-To: minyard@acm.org
Subject: Re: [PATCH tip/core/rcu 10/41] drivers/ipmi: Replace
 synchronize_sched() with synchronize_rcu()
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net
References: <20181111194104.GA4787@linux.ibm.com>
 <20181111194410.6368-10-paulmck@linux.ibm.com>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <16c19493-44b0-18e3-d3cb-4d6c2f9f9f53@acm.org>
Date:   Mon, 12 Nov 2018 09:38:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181111194410.6368-10-paulmck@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/18 1:43 PM, Paul E. McKenney wrote:
> Now that synchronize_rcu() waits for preempt-disable regions of code
> as well as RCU read-side critical sections, synchronize_sched() can be
> replaced by synchronize_rcu().  This commit therefore makes this change.


Assuming the above is true, this looks fine to me.

Acked-by: Corey MInyard <cminyard@mvista.com>

Or I can take it in my tree, either way.

-corey


> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> Cc: Corey Minyard <minyard@acm.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: <openipmi-developer@lists.sourceforge.net>
> ---
>   drivers/char/ipmi/ipmi_si_intf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index 677618e6f1f7..dc8603d34320 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -2187,7 +2187,7 @@ static void shutdown_smi(void *send_info)
>   	 * handlers might have been running before we freed the
>   	 * interrupt.
>   	 */
> -	synchronize_sched();
> +	synchronize_rcu();
>   
>   	/*
>   	 * Timeouts are stopped, now make sure the interrupts are off


