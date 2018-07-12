Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC48AC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8318D2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8318D2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732545AbeGLOu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:50:27 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36332 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732507AbeGLOu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:50:26 -0400
Received: by mail-qk0-f196.google.com with SMTP id a132-v6so15525522qkg.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 07:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BrEq3F1QBXU6rrAQkoI7g9gR0aoB8TNTFFxIFV6aaC0=;
        b=trArCMUrPk2YJPKk/tbpw9ZMXqe4OtwgK+uayJ7hfKGSqU7C7Bnlt4VVCusZFblvMb
         GD2LJht5tNIG+uVq91NaTu2aKtIUZMFkpmaQaD4Jy42N9gdn43seEA8mqqMre7rESCOp
         ryGLp2wjGmXE+JWYppcNSVnl+FvOb64d12haiAt8emSbISuJ9yO6zH+W7QaqeJOa25uf
         nFQUelAx12dOE0eOaQp89VLdlY9RvW1LpzahJ6mVH7T27zUyDulJ7zFXPi/+F/AbMUp1
         EE+j9HJq40HRoAtUr365Ez457nZlslYfLr2p0um4qSLkmeU/OWqtCflj//v1LBMjEQBy
         wkfA==
X-Gm-Message-State: AOUpUlEO9NgoSNaIIdlfnE4KfOGgJXhN4rGzwjxw17s26KoX8w4r/ooe
        45SPVDkE6IrfAMyBvhwLCGkDmA==
X-Google-Smtp-Source: AAOMgpd8uuYTy4O/S+LCFB0Fa1h3nDDMSG4hNXOtZ516SFhf+1oP4pRuw1ixEu3wkWVxPOaEKobIBw==
X-Received: by 2002:a37:ef0f:: with SMTP id j15-v6mr1904182qkk.399.1531406435307;
        Thu, 12 Jul 2018 07:40:35 -0700 (PDT)
Received: from t460s.bristot.redhat.com (nat-cataldo.sssup.it. [193.205.81.5])
        by smtp.gmail.com with ESMTPSA id v88-v6sm18424610qkv.63.2018.07.12.07.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 07:40:34 -0700 (PDT)
Subject: Re: [PATCH] sched/deadline: Fix switched_from_dl
To:     Juri Lelli <juri.lelli@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com
References: <20180711072948.27061-1-juri.lelli@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <3dc99fc3-f953-ee1f-2270-f1768327f875@redhat.com>
Date:   Thu, 12 Jul 2018 16:40:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180711072948.27061-1-juri.lelli@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 09:29 AM, Juri Lelli wrote:
> Mark noticed that syzkaller is able to reliably trigger the following
> 
>   dl_rq->running_bw > dl_rq->this_bw
>   WARNING: CPU: 1 PID: 153 at kernel/sched/deadline.c:124 switched_from_dl+0x454/0x608
>   Kernel panic - not syncing: panic_on_warn set ...
> 
>   CPU: 1 PID: 153 Comm: syz-executor253 Not tainted 4.18.0-rc3+ #29
>   Hardware name: linux,dummy-virt (DT)
>   Call trace:
>    dump_backtrace+0x0/0x458
>    show_stack+0x20/0x30
>    dump_stack+0x180/0x250
>    panic+0x2dc/0x4ec
>    __warn_printk+0x0/0x150
>    report_bug+0x228/0x2d8
>    bug_handler+0xa0/0x1a0
>    brk_handler+0x2f0/0x568
>    do_debug_exception+0x1bc/0x5d0
>    el1_dbg+0x18/0x78
>    switched_from_dl+0x454/0x608
>    __sched_setscheduler+0x8cc/0x2018
>    sys_sched_setattr+0x340/0x758
>    el0_svc_naked+0x30/0x34
> 
> syzkaller reproducer runs a bunch of threads that constantly switch
> between DEADLINE and NORMAL classes while interacting through futexes.
> 
> The splat above is caused by the fact that if a DEADLINE task is setattr
> back to NORMAL while in non_contending state (blocked on a futex -
> inactive timer armed), its contribution to running_bw is not removed
> before sub_rq_bw() gets called (!task_on_rq_queued() branch) and the
> latter sees running_bw > this_bw.
> 
> Fix it by removing a task contribution from running_bw if the task is
> not queued and in non_contending state while switched to a different
> class.
> 
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel

