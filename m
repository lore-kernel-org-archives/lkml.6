Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241B7C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 12:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73062148C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 12:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73062148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391372AbeHPPE4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 11:04:56 -0400
Received: from ozlabs.org ([203.11.71.1]:59983 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728675AbeHPPE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 11:04:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41rlS44WXRz9s3x;
        Thu, 16 Aug 2018 22:06:42 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Meelis Roos <mroos@linux.ee>, linux-powerpc@vger.kernel.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ptrace compile failure with gcc-8.2 on 32-bit powerpc
In-Reply-To: <alpine.LRH.2.21.1808161041350.16413@math.ut.ee>
References: <alpine.LRH.2.21.1808161041350.16413@math.ut.ee>
Date:   Thu, 16 Aug 2018 22:06:41 +1000
Message-ID: <87wosqa52m.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos <mroos@linux.ee> writes:
> After upgrading my distro compiler to gcc-8.2, Linux fails to compile on 
> 32-bit powerpc (tested with 4.17, 4.18 and v4.18-7873-gf91e654474d4).

Yeah I noticed this just yesterday.

>   CC      arch/powerpc/kernel/ptrace.o
> In file included from ./include/linux/bitmap.h:9,
>                  from ./include/linux/cpumask.h:12,
>                  from ./include/linux/rcupdate.h:44,
>                  from ./include/linux/rculist.h:11,
>                  from ./include/linux/pid.h:5,
>                  from ./include/linux/sched.h:14,
>                  from arch/powerpc/kernel/ptrace.c:19:
> In function ‘memcpy’,
>     inlined from ‘user_regset_copyin’ at ./include/linux/regset.h:295:4,
>     inlined from ‘vr_set’ at arch/powerpc/kernel/ptrace.c:619:9:
> ./include/linux/string.h:345:9: error: ‘__builtin_memcpy’ offset [-527, -529] is out of the bounds [0, 16] of object ‘vrsave’ with type ‘union <anonymous>’ [-Werror=array-bounds]
>   return __builtin_memcpy(p, q, size);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/kernel/ptrace.c: In function ‘vr_set’:
> arch/powerpc/kernel/ptrace.c:614:5: note: ‘vrsave’ declared here
>    } vrsave;
>      ^~~~~~

I couldn't actually work out how GCC has decided this is definitely
happening, possibly it just thinks it _could_ happen. I think it's
wrong, but admittedly the code is not easy to follow.

The patch below should fix the build error, but I haven't had time to
test it actually works at runtime:

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 9667666eb18e..607273067d3f 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -570,7 +570,8 @@ static int vr_get(struct task_struct *target, const struct user_regset *regset,
 		vrsave.word = target->thread.vrsave;
 
 		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &vrsave,
-					  33 * sizeof(vector128), -1);
+					  33 * sizeof(vector128),
+					  34 * sizeof(vector128));
 	}
 
 	return ret;
@@ -617,7 +618,8 @@ static int vr_set(struct task_struct *target, const struct user_regset *regset,
 		vrsave.word = target->thread.vrsave;
 
 		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &vrsave,
-					 33 * sizeof(vector128), -1);
+					 33 * sizeof(vector128),
+					 34 * sizeof(vector128));
 		if (!ret)
 			target->thread.vrsave = vrsave.word;
 	}


cheers
