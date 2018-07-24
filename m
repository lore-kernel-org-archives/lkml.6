Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88ABECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9003820685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9003820685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388244AbeGXBhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 21:37:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388181AbeGXBhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 21:37:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F2C154023336;
        Tue, 24 Jul 2018 00:33:49 +0000 (UTC)
Received: from llong.remote.csb (ovpn-121-66.rdu2.redhat.com [10.10.121.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35A787C57;
        Tue, 24 Jul 2018 00:33:48 +0000 (UTC)
Subject: Re: [PATCH RFC] debugobjects: Make stack check warning more
 informative
To:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Thomas Gleixner <tglx@linutronix.de>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, astrachan@google.com
References: <20180723212531.202328-1-joel@joelfernandes.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <b036f4a3-1108-c117-873e-3cb0ccfcf2f3@redhat.com>
Date:   Mon, 23 Jul 2018 20:33:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180723212531.202328-1-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 24 Jul 2018 00:33:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 24 Jul 2018 00:33:50 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 05:25 PM, Joel Fernandes wrote:
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
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  lib/debugobjects.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index 994be4805cec..24c1df0d7466 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -360,9 +360,12 @@ static void debug_object_is_on_stack(void *addr, int onstack)
>  
>  	limit++;
>  	if (is_on_stack)
> -		pr_warn("object is on stack, but not annotated\n");
> +		pr_warn("object %p is on stack %p, but NOT annotated.\n", addr,
> +			 task_stack_page(current));
>  	else
> -		pr_warn("object is not on stack, but annotated\n");
> +		pr_warn("object %p is NOT on stack %p, but annotated.\n", addr,
> +			 task_stack_page(current));
> +
>  	WARN_ON(1);
>  }
>  

Acked-by: Waiman Long <longman@redhat.com>

