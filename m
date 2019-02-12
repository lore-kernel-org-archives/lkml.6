Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DBDC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F6C214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EbHGf8ON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfBLNYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:24:39 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57340 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfBLNYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yd5bFzbLfzcGmIRsQcZn6VKCWA7VpmLLGszrSLDFzuw=; b=EbHGf8ONHQKw2fr5EwnXZzsov
        mwKwaOtJ0okVLNKoshHtFJdLCHthISpoUhk8SZ8QMKEpjeLzstb9ZBabya/kP87eeRUQitGu+0mP7
        TsJJWKVdjy84B9qqFLByqykwBF2w5y9yngECnSk0ODuTFmXYvR/xgp7hAyZNyOhu/tNAMkZfuYli8
        YPGDr8Zs3YSMKrFa2o/8I+UqPgwWEXOIJvjLZY/dytToECIzE9SwqudHZGVGphrvfuQmVwmBs/j4U
        JY9oI5j+271koi1lB6ouERBtNRoVPJHBDXS5awZ33wfPXgboq5/8Y4Gp9HMhcyFTHVjKlnJbdAOK8
        VX3dC28YQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtY2f-0004lo-KE; Tue, 12 Feb 2019 13:24:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11AA720D0C1D8; Tue, 12 Feb 2019 14:24:04 +0100 (CET)
Date:   Tue, 12 Feb 2019 14:24:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v2 2/2] locking/rwsem: Optimize down_read_trylock()
Message-ID: <20190212132404.GI32494@hirez.programming.kicks-ass.net>
References: <1549913486-16799-1-git-send-email-longman@redhat.com>
 <1549913486-16799-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549913486-16799-3-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 02:31:26PM -0500, Waiman Long wrote:
> Modify __down_read_trylock() to make it generate slightly better code
> (smaller and maybe a tiny bit faster).
> 
> Before this patch, down_read_trylock:
> 
>    0x0000000000000000 <+0>:     callq  0x5 <down_read_trylock+5>
>    0x0000000000000005 <+5>:     jmp    0x18 <down_read_trylock+24>
>    0x0000000000000007 <+7>:     lea    0x1(%rdx),%rcx
>    0x000000000000000b <+11>:    mov    %rdx,%rax
>    0x000000000000000e <+14>:    lock cmpxchg %rcx,(%rdi)
>    0x0000000000000013 <+19>:    cmp    %rax,%rdx
>    0x0000000000000016 <+22>:    je     0x23 <down_read_trylock+35>
>    0x0000000000000018 <+24>:    mov    (%rdi),%rdx
>    0x000000000000001b <+27>:    test   %rdx,%rdx
>    0x000000000000001e <+30>:    jns    0x7 <down_read_trylock+7>
>    0x0000000000000020 <+32>:    xor    %eax,%eax
>    0x0000000000000022 <+34>:    retq
>    0x0000000000000023 <+35>:    mov    %gs:0x0,%rax
>    0x000000000000002c <+44>:    or     $0x3,%rax
>    0x0000000000000030 <+48>:    mov    %rax,0x20(%rdi)
>    0x0000000000000034 <+52>:    mov    $0x1,%eax
>    0x0000000000000039 <+57>:    retq
> 
> After patch, down_read_trylock:
> 
>    0x0000000000000000 <+0>:     callq  0x5 <down_read_trylock+5>
>    0x0000000000000005 <+5>:     mov    (%rdi),%rax
>    0x0000000000000008 <+8>:     test   %rax,%rax
>    0x000000000000000b <+11>:    js     0x2f <down_read_trylock+47>
>    0x000000000000000d <+13>:    lea    0x1(%rax),%rdx
>    0x0000000000000011 <+17>:    lock cmpxchg %rdx,(%rdi)
>    0x0000000000000016 <+22>:    jne    0x8 <down_read_trylock+8>
>    0x0000000000000018 <+24>:    mov    %gs:0x0,%rax
>    0x0000000000000021 <+33>:    or     $0x3,%rax
>    0x0000000000000025 <+37>:    mov    %rax,0x20(%rdi)
>    0x0000000000000029 <+41>:    mov    $0x1,%eax
>    0x000000000000002e <+46>:    retq
>    0x000000000000002f <+47>:    xor    %eax,%eax
>    0x0000000000000031 <+49>:    retq
> 
> By using a rwsem microbenchmark, the down_read_trylock() rate on a
> x86-64 system before and after the patch were:
> 
>                  Before Patch    After Patch
>    # of Threads     rlock           rlock
>    ------------     -----           -----
>         1           27,787          28,259
>         2            8,359           9,234

From 1/2:

1        29,201  30,143  29,458    28,615  30,172  29,201
2         6,807  13,299   1,171     7,725  15,025   1,804

> 
> On a ARM64 system, the performance results were:
> 
>                  Before Patch    After Patch
>    # of Threads     rlock           rlock
>    ------------     -----           -----
>         1           24,155          25,000
>         2            6,820           8,699
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/rwsem.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
> index 067e265..028bc33 100644
> --- a/kernel/locking/rwsem.h
> +++ b/kernel/locking/rwsem.h
> @@ -175,11 +175,11 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
>  
>  static inline int __down_read_trylock(struct rw_semaphore *sem)
>  {
> -	long tmp;
> +	long tmp = atomic_long_read(&sem->count);
>  
> -	while ((tmp = atomic_long_read(&sem->count)) >= 0) {
> -		if (tmp == atomic_long_cmpxchg_acquire(&sem->count, tmp,
> -				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
> +	while (tmp >= 0) {
> +		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
> +					tmp + RWSEM_ACTIVE_READ_BIAS)) {
>  			return 1;
>  		}
>  	}
> -- 
> 1.8.3.1
> 
