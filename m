Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161CAC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE39820859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfAGD6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 22:58:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfAGD6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 22:58:44 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC8A57B020;
        Mon,  7 Jan 2019 03:58:42 +0000 (UTC)
Received: from [10.72.12.172] (ovpn-12-172.pek2.redhat.com [10.72.12.172])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CCAA5D96F;
        Mon,  7 Jan 2019 03:58:25 +0000 (UTC)
Subject: Re: [PATCH RFC 3/4] barriers: convert a control to a data dependency
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org,
        netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-sparse@vger.kernel.org
References: <20190102205715.14054-1-mst@redhat.com>
 <20190102205715.14054-4-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <86023cbe-d1ae-a0d6-7b75-26556f1a0c1f@redhat.com>
Date:   Mon, 7 Jan 2019 11:58:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190102205715.14054-4-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 07 Jan 2019 03:58:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/3 上午4:57, Michael S. Tsirkin wrote:
> It's not uncommon to have two access two unrelated memory locations in a
> specific order.  At the moment one has to use a memory barrier for this.
>
> However, if the first access was a read and the second used an address
> depending on the first one we would have a data dependency and no
> barrier would be necessary.
>
> This adds a new interface: dependent_ptr_mb which does exactly this: it
> returns a pointer with a data dependency on the supplied value.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   Documentation/memory-barriers.txt | 20 ++++++++++++++++++++
>   arch/alpha/include/asm/barrier.h  |  1 +
>   include/asm-generic/barrier.h     | 18 ++++++++++++++++++
>   include/linux/compiler.h          |  4 ++++
>   4 files changed, 43 insertions(+)
>
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index c1d913944ad8..9dbaa2e1dbf6 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -691,6 +691,18 @@ case what's actually required is:
>   		p = READ_ONCE(b);
>   	}
>   
> +Alternatively, a control dependency can be converted to a data dependency,
> +e.g.:
> +
> +	q = READ_ONCE(a);
> +	if (q) {
> +		b = dependent_ptr_mb(b, q);
> +		p = READ_ONCE(b);
> +	}
> +
> +Note how the result of dependent_ptr_mb must be used with the following
> +accesses in order to have an effect.
> +
>   However, stores are not speculated.  This means that ordering -is- provided
>   for load-store control dependencies, as in the following example:
>   
> @@ -836,6 +848,12 @@ out-guess your code.  More generally, although READ_ONCE() does force
>   the compiler to actually emit code for a given load, it does not force
>   the compiler to use the results.
>   
> +Converting to a data dependency helps with this too:
> +
> +	q = READ_ONCE(a);
> +	b = dependent_ptr_mb(b, q);
> +	WRITE_ONCE(b, 1);
> +
>   In addition, control dependencies apply only to the then-clause and
>   else-clause of the if-statement in question.  In particular, it does
>   not necessarily apply to code following the if-statement:
> @@ -875,6 +893,8 @@ to the CPU containing it.  See the section on "Multicopy atomicity"
>   for more information.
>   
>   
> +
> +
>   In summary:
>   
>     (*) Control dependencies can order prior loads against later stores.
> diff --git a/arch/alpha/include/asm/barrier.h b/arch/alpha/include/asm/barrier.h
> index 92ec486a4f9e..b4934e8c551b 100644
> --- a/arch/alpha/include/asm/barrier.h
> +++ b/arch/alpha/include/asm/barrier.h
> @@ -59,6 +59,7 @@
>    * as Alpha, "y" could be set to 3 and "x" to 0.  Use rmb()
>    * in cases like this where there are no data dependencies.
>    */
> +#define ARCH_NEEDS_READ_BARRIER_DEPENDS 1
>   #define read_barrier_depends() __asm__ __volatile__("mb": : :"memory")
>   
>   #ifdef CONFIG_SMP
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index 2cafdbb9ae4c..fa2e2ef72b68 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -70,6 +70,24 @@
>   #define __smp_read_barrier_depends()	read_barrier_depends()
>   #endif
>   
> +#if defined(COMPILER_HAS_OPTIMIZER_HIDE_VAR) && \
> +	!defined(ARCH_NEEDS_READ_BARRIER_DEPENDS)
> +
> +#define dependent_ptr_mb(ptr, val) ({					\
> +	long dependent_ptr_mb_val = (long)(val);			\
> +	long dependent_ptr_mb_ptr = (long)(ptr) - dependent_ptr_mb_val;	\
> +									\
> +	BUILD_BUG_ON(sizeof(val) > sizeof(long));			\
> +	OPTIMIZER_HIDE_VAR(dependent_ptr_mb_val);			\
> +	(typeof(ptr))(dependent_ptr_mb_ptr + dependent_ptr_mb_val);	\
> +})
> +
> +#else
> +
> +#define dependent_ptr_mb(ptr, val) ({ mb(); (ptr); })


So for the example of patch 4, we'd better fall back to rmb() or need a 
dependent_ptr_rmb()?

Thanks


> +
> +#endif
> +
>   #ifdef CONFIG_SMP
>   
>   #ifndef smp_mb
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 6601d39e8c48..f599c30f1b28 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -152,9 +152,13 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>   #endif
>   
>   #ifndef OPTIMIZER_HIDE_VAR
> +
>   /* Make the optimizer believe the variable can be manipulated arbitrarily. */
>   #define OPTIMIZER_HIDE_VAR(var)						\
>   	__asm__ ("" : "=rm" (var) : "0" (var))
> +
> +#define COMPILER_HAS_OPTIMIZER_HIDE_VAR 1
> +
>   #endif
>   
>   /* Not-quite-unique ID. */
