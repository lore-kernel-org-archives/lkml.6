Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B79ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED542208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Bg0+IZEn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED542208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeGPTJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:09:19 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53684 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeGPTJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:09:19 -0400
Received: by mail-it0-f65.google.com with SMTP id 72-v6so6131419itw.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 11:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rIuem2LHYEgzvUTjtjC92XuTnDP8G2FEpbMGmRDfISU=;
        b=Bg0+IZEn6R3Vj+745Mj8BGaKI6r7W1v2NbzjA8YghgDW5jIu1VrD9TbidcQYZzWsck
         rlw51DqdFmdTit10OzcuYSDCL3/c7dxgWTQy7j712WBgByHC4JITGOR7KIfCWxnYzBHL
         xTiOfklFnXedQXsu5gIDYVgh/lpJyuYcz0O3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rIuem2LHYEgzvUTjtjC92XuTnDP8G2FEpbMGmRDfISU=;
        b=PZH36Yi2t/O2zknteYYRcf+I/Fe3sleVmUBEMiTmV+SOcwCk60RV+ThmIipJ/BBW8u
         AgxuBBT0DhrEDEMXsPrkzu7j2nE51UC5m8gx6tOV4qhxi2fvhesCAtarGrSmXuBayxSE
         nrSPCyDys3iM5Gq6m4mD9kJQf3CHv+wNgw8ioLnUnXREZu05v0MbVC6AngvYyob0YNVD
         Cs1VaJBs9MSMyreTH7MwqYeBUkZhEQ34beQnU9y3J82HKyYwtFkwjhgbfMI738rU/L2t
         rJhSlKdHFzdRhWXGiv5hNeJ/qbLwmio6+1wWCXvgIOr7Yj48I362C0wWgdJ4061MRo+l
         f3ag==
X-Gm-Message-State: AOUpUlHRLVlMU63peCid+E/riANZGiazSjUd5siNAOXYiEciqWYShf26
        Vw3mhZ1Y7w1wJI+CGx8EZtmWYUC127OtJHfDwSQ=
X-Google-Smtp-Source: AAOMgpfcJXQiKfcpAL+mYwpQ/Sl3Ac/0UqVQNQfuSDsZqLfvkDogB0k0dHG/BY4Ib9sdpV0mLnu1qwqFz/GqYTiZNcg=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr13363364itb.16.1531766437491;
 Mon, 16 Jul 2018 11:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <877em2jxyr.fsf_-_@xmission.com> <20180711024459.10654-7-ebiederm@xmission.com>
 <20180716125144.GA18262@redhat.com> <8736wjtetv.fsf@xmission.com>
 <CA+55aFxDsE8sb5wQQNJdxvt8m6n6aVpOo1yVpk1BEzXDv8XzaQ@mail.gmail.com> <87bmb7oy94.fsf@xmission.com>
In-Reply-To: <87bmb7oy94.fsf@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Jul 2018 11:40:26 -0700
Message-ID: <CA+55aFymtpNNnfrJDmTLBC8ga_L_ww+yz2VQttWq8+9fzp23YQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 07/11] signal: Deliver group signals via PIDTYPE_TGID
 not PIDTYPE_PID
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 11:02 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> There are two questions.
> a) Can we use the pid of a thread to find the thread group?

Yes. Just find the thread, and then use p->tgid.

However, that's not what the code used to do. It used to just find the
thread, and then do "do_send_sig_info()" on it.

And it's actually *slightly* different than "find the thread group
based on the thread". At least the permission checks are different.
The permission checks are done on the thread.

> b) Will the signal be queued in the thread group?

Yes.

        pending = group ? &t->signal->shared_pending : &t->pending;

and "group" is true.

> > Now, it is possible that at none of the legacy uses use CLONE_THREAD
> > and thus aren't affected (because tgid will always be pid). So maybe
> > nobody notices.
>
> That is what I expect.  I don't know think legacy is a good description.
> Calling other uses of CLONE_THREAD non-glibc seems better.  The old
> LinuxThreads did not use CLONE_THREAD because it did not exist.

Again, don't get hung up about different libc implementations.

People have literally used clone() directly. And some of them use CLONE_THREAD.

Just google it. I guarantee you'll find examples of it, because I
found examples.

So stop the whole "libc" argument. That's not the point, and as long
as you make that argument, your argument is simply not valid.

People use clone() directly. Really. Really really.

            Linus
