Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC6AC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5F023C2D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5F023C2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934304AbeFVCFM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 22:05:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934043AbeFVCFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 22:05:11 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2271AC057F82;
        Fri, 22 Jun 2018 02:05:11 +0000 (UTC)
Received: from llong.remote.csb (ovpn-116-153.phx2.redhat.com [10.3.116.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1015B309128B;
        Fri, 22 Jun 2018 02:05:08 +0000 (UTC)
Subject: Re: [PATCH] locking/qspinlock: Fix build for anonymous union in older
 gcc compilers
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180621203526.172ab5c4@vmware.local.home>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <173298ff-4b5a-4f86-4f86-42287676e9ad@redhat.com>
Date:   Fri, 22 Jun 2018 10:05:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180621203526.172ab5c4@vmware.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 22 Jun 2018 02:05:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22/2018 08:35 AM, Steven Rostedt wrote:
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
> One of my tests compiles the kernel with gcc 4.5.3, and I hit the
> following build error:
>
> /work/git/linux-trace.git/include/linux/semaphore.h: In function 'sema_init':
> /work/git/linux-trace.git/include/linux/semaphore.h:35:17: error: unknown field 'val' specified in initializer
> /work/git/linux-trace.git/include/linux/semaphore.h:35:17: warning: missing braces around initializer
> /work/git/linux-trace.git/include/linux/semaphore.h:35:17: warning: (near initialization for '(anonymous).raw_lock.<anonymous>.val')
> In file included from /work/git/linux-trace.git/include/linux/sched/user.h:7:0,
>                  from /work/git/linux-trace.git/include/linux/cred.h:22,
>                  from /work/git/linux-trace.git/include/linux/seq_file.h:12,
>                  from /work/git/linux-trace.git/include/linux/cgroup.h:18,
>                  from /work/git/linux-trace.git/include/linux/memcontrol.h:22,
>                  from /work/git/linux-trace.git/include/linux/swap.h:9,
>                  from /work/git/linux-trace.git/include/linux/suspend.h:5,
>                  from /work/git/linux-trace.git/arch/x86/kernel/asm-offsets.c:13:
>
>
> I bisected it down to the introduction of the commit that makes
> qspinlock have an anonymous union, which makes initializing it special
> for older compilers. By adding strategic brackets, it makes the build
> happy again.
>
> Fixes: 625e88be1f41 ("locking/qspinlock: Merge 'struct __qspinlock' into 'struct qspinlock'")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
> index 0763f065b975..d10f1e7d6ba8 100644
> --- a/include/asm-generic/qspinlock_types.h
> +++ b/include/asm-generic/qspinlock_types.h
> @@ -63,7 +63,7 @@ typedef struct qspinlock {
>  /*
>   * Initializier
>   */
> -#define	__ARCH_SPIN_LOCK_UNLOCKED	{ .val = ATOMIC_INIT(0) }
> +#define	__ARCH_SPIN_LOCK_UNLOCKED	{ { .val = ATOMIC_INIT(0) } }
>  
>  /*
>   * Bitfields in the atomic value:

Acked-by: Waiman Long <longman@redhat.com>

