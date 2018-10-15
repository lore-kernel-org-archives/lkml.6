Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C72C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C462064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C462064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeJOSSh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 14:18:37 -0400
Received: from ozlabs.org ([203.11.71.1]:44751 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbeJOSSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 14:18:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42YZYH3f5sz9s55;
        Mon, 15 Oct 2018 21:33:52 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: 32-bit poweroc compile failure in v4.19-rc7-166-g7ec21823634d
In-Reply-To: <17d36e6c-f99a-abfb-12cd-fa4b14bc7e09@linux.ee>
References: <17d36e6c-f99a-abfb-12cd-fa4b14bc7e09@linux.ee>
Date:   Mon, 15 Oct 2018 21:33:49 +1100
Message-ID: <87tvlnzegi.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos <mroos@linux.ee> writes:
> I tried to test the fix to 32-bit poweroc boot hang but found that current git does not compile on 32bit poweroc at all for me:

That's GCC 8 I think?

I have seen that but couldn't work out what the hell GCC is thinking.

I don't think there's an actual bug, the size of the copy is bounded by
the count parameter, which *doesn't* come from user space, it's hard
coded.

I suspect the logic is just to convoluted for GCC.

We should fix it somehow, but I haven't worked out what's the best option.

cheers


>    CC      arch/powerpc/kernel/ptrace.o
> In file included from ./include/linux/bitmap.h:9,
>                   from ./include/linux/cpumask.h:12,
>                   from ./include/linux/rcupdate.h:44,
>                   from ./include/linux/rculist.h:11,
>                   from ./include/linux/pid.h:5,
>                   from ./include/linux/sched.h:14,
>                   from arch/powerpc/kernel/ptrace.c:19:
> In function ‘memcpy’,
>      inlined from ‘user_regset_copyin’ at ./include/linux/regset.h:295:4,
>      inlined from ‘vr_set’ at arch/powerpc/kernel/ptrace.c:619:9:
> ./include/linux/string.h:345:9: error: ‘__builtin_memcpy’ offset [-527, -529] is out of the bounds [0, 16] of object ‘vrsave’ with type ‘union <anonymous>’ [-Werror=array-bounds]
>    return __builtin_memcpy(p, q, size);
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/kernel/ptrace.c: In function ‘vr_set’:
> arch/powerpc/kernel/ptrace.c:614:5: note: ‘vrsave’ declared here
>     } vrsave;
>       ^~~~~~
> In file included from ./include/linux/bitmap.h:9,
>                   from ./include/linux/cpumask.h:12,
>                   from ./include/linux/rcupdate.h:44,
>                   from ./include/linux/rculist.h:11,
>                   from ./include/linux/pid.h:5,
>                   from ./include/linux/sched.h:14,
>                   from arch/powerpc/kernel/ptrace.c:19:
> In function ‘memcpy’,
>      inlined from ‘user_regset_copyout’ at ./include/linux/regset.h:270:4,
>      inlined from ‘vr_get’ at arch/powerpc/kernel/ptrace.c:572:9:
> ./include/linux/string.h:345:9: error: ‘__builtin_memcpy’ offset [-527, -529] is out of the bounds [0, 16] of object ‘vrsave’ with type ‘union <anonymous>’ [-Werror=array-bounds]
>    return __builtin_memcpy(p, q, size);
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/kernel/ptrace.c: In function ‘vr_get’:
> arch/powerpc/kernel/ptrace.c:567:5: note: ‘vrsave’ declared here
>     } vrsave;
>       ^~~~~~
> cc1: all warnings being treated as errors
> make[1]: *** [scripts/Makefile.build:306: arch/powerpc/kernel/ptrace.o] Error 1
> make: *** [Makefile:1052: arch/powerpc/kernel] Error 2
>
> -- 
> Meelis Roos <mroos@linux.ee>
