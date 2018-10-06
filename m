Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A798DC65C30
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 12:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610B22087D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 12:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610B22087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeJFTnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 15:43:40 -0400
Received: from ozlabs.org ([203.11.71.1]:59835 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbeJFTnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 15:43:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42S5nV0RS2z9s55;
        Sat,  6 Oct 2018 22:40:30 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 3/9] powerpc: Prepare for moving thread_info into task_struct
In-Reply-To: <65eac9f906b12b55010a00b477619f7739c1cac5.1538687075.git.christophe.leroy@c-s.fr>
References: <cover.1538687073.git.christophe.leroy@c-s.fr> <65eac9f906b12b55010a00b477619f7739c1cac5.1538687075.git.christophe.leroy@c-s.fr>
Date:   Sat, 06 Oct 2018 22:40:29 +1000
Message-ID: <87tvlzi6yq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
> index 47a03b9b528b..818451bf629c 100644
> --- a/arch/powerpc/include/asm/livepatch.h
> +++ b/arch/powerpc/include/asm/livepatch.h
> @@ -49,7 +49,7 @@ static inline void klp_init_thread_info(struct thread_info *ti)
>  	ti->livepatch_sp = (unsigned long *)(ti + 1) + 1;

We need to do something about this.

Currently the thread_info sits at the low address of the stack, and we
use the space immediately above that as a miniature upward growing stack
for livepatching.

If we keep the livepatch_sp in the thread_info then we need to
initialise it somewhere when the task starts running on a stack. And I
don't know how that works if we end up running on the emergency stack
for example.

So I'm not sure that makes much sense.

Instead we might need to keep the livepatch_sp on the stack page at the
base, where thread_info currently lives.

That obviously sucks because you can still overflow into it and trash
it, but it's no worse than what we have now for livepatching.

Need to think about it some more.

cheers
