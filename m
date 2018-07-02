Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872E3C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414AB24525
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KXi7p+7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 414AB24525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753640AbeGBWJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:09:00 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36444 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752715AbeGBWIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:08:54 -0400
Received: by mail-it0-f65.google.com with SMTP id j185-v6so133232ite.1;
        Mon, 02 Jul 2018 15:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RbHcd9+k9otUzlr4s+XaqLm+1MM1do2QjKOPMM6Fd/k=;
        b=KXi7p+7Eprh56XDPvaBNMD2pFgab/kOoRnzpAtFCV0kDwSgE0DTg465d6eCkAVDRA1
         hGrfCXfOohTFILN2MOIsX9P9XlnvyhN61VNE7dLy/2LqcTHEIzt1KBkKxE+pDG/EmD5Q
         vuhSsEZpVTfMtQiPQuGfQJ5KQ5xguL3F0ioa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RbHcd9+k9otUzlr4s+XaqLm+1MM1do2QjKOPMM6Fd/k=;
        b=ZNaNkt4AzA+2PcWNn6UwM1xH7joku2Nf4AhVkwtTp/KS3DVWCShoBvWHGurQVmEGZA
         21HFQftbGwg6uOXlP7IJdxYA2us8EXc6Cuh5He3JnPQxUfu5KucVmOFWvHQHWZjjEf17
         dLIn+iIeouR5JNcl/iI91p0YIng4pvzs+IVye/LdblZcf+K0myE82fDLpVJptOoYUKxG
         mOpbjkLnr9so/gwBd07Bj5IChpJHi3cnRRS0/eD+x20gS+31d88WgjZzTRX/9i8fJRbg
         bofnNssEYa6JpiS6mwEemRDJz8sxHY9nv8c1QDenOGyTZU3J1XZps8PzFkwdbmTDX5Bm
         Jy4Q==
X-Gm-Message-State: APt69E3nJLuH8Eh93uNZzQJTmLtox8OKMw2cDq29JudxYGwAvPGwqEYW
        LSjoYSz7r6537qVVAtKJd0CpkgzJF9HMf/ORDgk=
X-Google-Smtp-Source: AAOMgpdMV6kKcRMaY8KG+1dIxuBc3Zb0pRXgFu8WWg28nqNaQ/pGL/2Gt+ml1NyUAfXOCA4TUohbrsF3ath3tHdafTw=
X-Received: by 2002:a02:1bdc:: with SMTP id 89-v6mr21855636jas.72.1530569333848;
 Mon, 02 Jul 2018 15:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180702204058.819-1-mathieu.desnoyers@efficios.com>
 <CA+55aFzH+4=Aeh_P1ptFn5nVm7yFuEGpxUJ0kNB-sUHVOv8rcw@mail.gmail.com>
 <1307337131.10790.1530565424717.JavaMail.zimbra@efficios.com>
 <CA+55aFwuBef8ajmeE-mw=6YHwYOQdnCMir7h2ebWxOzNrSQQFw@mail.gmail.com> <522686232.10814.1530569002544.JavaMail.zimbra@efficios.com>
In-Reply-To: <522686232.10814.1530569002544.JavaMail.zimbra@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 15:08:42 -0700
Message-ID: <CA+55aFz5cq5uP7VFwAmo3BimHyMdu_FQnbxZG3i66_qZXCkjNg@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: use __u64 for rseq_cs fields,
 validate abort_ip < TASK_SIZE
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>,
        Christoph Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 3:03 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
>         if (__get_user(ptr, &t->rseq->rseq_cs))
>                 return -EINVAL;
>         if (check_rseq_cs_padding(t))
>                 return -EINVAL;

Small nit.

I think the _actual_ user access faults should return -EFAULT, and
then the *validation* checks should return -EINVAL.

So when the "copy_from_user()" fails, that's -EFAULT, but when you
have (rseq_cs->start_ip >= TASK_SIZE), that's -EINVAL.

That said, nothing actually cares or exposes the error number, I
think. Afaik, all the callers just check "did it work" or not.

So this is more a "let's be consistent" than anything that matters.

             Linus
