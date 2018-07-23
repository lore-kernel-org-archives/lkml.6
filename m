Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D15ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23D920854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23D920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388271AbeGWW6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:58:32 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:59802 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388131AbeGWW6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:58:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0T5BkFTc_1532382910;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T5BkFTc_1532382910)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Jul 2018 05:55:12 +0800
Subject: Re: [PATCH RFC] debugobjects: Make stack check warning more
 informative
To:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, astrachan@google.com
References: <20180723212531.202328-1-joel@joelfernandes.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <f3ab8aa4-0e12-5134-009a-8300171868e7@linux.alibaba.com>
Date:   Mon, 23 Jul 2018 14:54:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180723212531.202328-1-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/23/18 2:25 PM, Joel Fernandes wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
>
> Recently we debugged an issue where debugobject tracking was telling
> us of an annotation issue. Turns out the issue was due to the object in
> concern being on a different stack which was due to another issue.
>
> Discussing with tglx, he suggested printing the pointers and the
> location of the stack for the currently running task. This helped find
> the object was on the wrong stack. I turned the resulting patch into
> something upstreamable, so that the error message is more informative
> and can help in debugging for similar issues in the future.

Acked-by: Yang Shi <yang.shi@linux.alibaba.com>

>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>   lib/debugobjects.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index 994be4805cec..24c1df0d7466 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -360,9 +360,12 @@ static void debug_object_is_on_stack(void *addr, int onstack)
>   
>   	limit++;
>   	if (is_on_stack)
> -		pr_warn("object is on stack, but not annotated\n");
> +		pr_warn("object %p is on stack %p, but NOT annotated.\n", addr,
> +			 task_stack_page(current));
>   	else
> -		pr_warn("object is not on stack, but annotated\n");
> +		pr_warn("object %p is NOT on stack %p, but annotated.\n", addr,
> +			 task_stack_page(current));
> +
>   	WARN_ON(1);
>   }
>   

