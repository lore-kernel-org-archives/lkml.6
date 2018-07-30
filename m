Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E1D16256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E82820893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XEozG7dk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E82820893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbeG3SC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:02:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46332 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeG3SC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8JNH8wh6d/fdHM0JnjGlO3CfUiTjQD86h9nXFLQokgo=; b=XEozG7dkYw6Wox5VAJoMxBWaaA
        Wwuyuf96TQZ8HdC0rNBMHXltopMNO2B8SL6kHCxaBnOjzcZT1tJ/1LcehIvjm39qsCAnFM4fB48I5
        Pkv34x8edSl9slopu8MauSf71kVZ5utVoAWJljVn3T9ilNdwn+4ysQKknmapUI8Qm05b77notg8UW
        NVJc4/HkoKlCvAsq+s5bqRveGQO3Cg5gzMZxnEosDnfUBznloF0WbyVLbFcFehUUeUG6VLpgzk59p
        TkE7uBMg4gcr74QuM+VSeEF6XrwvnMbDGg+Pm2CDnv8rN3cAwi8oxHvtL7JZ37Ahv9bpSOnhhJ4o/
        ayhmiUbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkB0Z-0007bn-GQ; Mon, 30 Jul 2018 16:26:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11A9320275F3E; Mon, 30 Jul 2018 18:26:53 +0200 (CEST)
Date:   Mon, 30 Jul 2018 18:26:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 11/11] mm,sched: conditionally skip lazy TLB mm
 refcounting
Message-ID: <20180730162653.GM2494@hirez.programming.kicks-ass.net>
References: <20180728215357.3249-1-riel@surriel.com>
 <20180728215357.3249-11-riel@surriel.com>
 <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com>
 <20180729155452.37eddc11@imladris.surriel.com>
 <20180730095502.GG2494@hirez.programming.kicks-ass.net>
 <1532961011.28585.30.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1532961011.28585.30.camel@surriel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 10:30:11AM -0400, Rik van Riel wrote:

> > What happened to the rework I did there? That not only avoided
> > fiddling
> > with active_mm, but also avoids grab/drop cycles for the other
> > architectures when doing task->kthread->kthread->task things.
>=20
> I don't think I saw that. I only saw your email from
> July 20th with this fragment of code, which does not
> appear to avoid the grab/drop cycles, and still fiddles
> with active_mm:

Yeah, that's it. Note how it doesn't do a grab+drop for kernel->kernel,
where the current could would have.

And also note that it only fiddles with active_mm if it does the
grab+drop thing (the below should have s/ifdef/ifndef/ to make more
sense maybe).

So for ARCH_NO_ACTIVE_MM we never touch ->active_mm and therefore
->active_mm =3D=3D ->mm.

> +       /*
> +        * kernel -> kernel   lazy + transfer active
> +        *   user -> kernel   lazy + mmgrab() active
> +        *
> +        * kernel ->   user   switch + mmdrop() active
> +        *   user ->   user   switch
> +        */
> +       if (!next->mm) {                                // to kernel
> +               enter_lazy_tlb(prev->active_mm, next);
> +
#ifndef ARCH_NO_ACTIVE_MM
> +               next->active_mm =3D prev->active_mm;
> +               if (prev->mm)                           // from user
> +                       mmgrab(prev->active_mm);
		else
			prev->active_mm =3D NULL;
> +#endif
> +       } else {                                        // to user
> +               switch_mm_irqs_off(prev->active_mm, next->mm, next);
> +
#ifndef ARCH_NO_ACTIVE_MM
> +               if (!prev->mm) {                        // from kernel
> +                       /* will mmdrop() in finish_task_switch(). */
> +                       rq->prev_mm =3D prev->active_mm;
> +                       prev->active_mm =3D NULL;
> +               }
> +#endif


