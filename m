Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF49C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8F424EE0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HhHEs84v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8F424EE0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932350AbeGBWpP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:45:15 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46845 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753560AbeGBWpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:45:13 -0400
Received: by mail-io0-f194.google.com with SMTP id p7-v6so918ioh.13;
        Mon, 02 Jul 2018 15:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=caasTxZhBqxjkLCAEh8AE0uTIF2HVueV0q6nVR6mG7s=;
        b=HhHEs84veCw88c1UwnMiXLJ2yoHm+DOpQLXhyABI93GhemSNeIL0L9rbGYYQpYj25L
         jFZQNI+1Egkt7ViiKFlW9Xm2r2yk1i9YxnzBMOAMW4z0O8gNEkA48EpVH0Slvkcgd0cj
         RbqoIZnFrPsmGpS2fzwD7ap5nxuFS04Isnrks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=caasTxZhBqxjkLCAEh8AE0uTIF2HVueV0q6nVR6mG7s=;
        b=PFN144M3ySm12PgJIMXkgTZhr5NHeby8YyWqXfGeJwir07nFYWXmUHbdoiPVA1N+Ms
         gQcWVQlNoPpZaKwJAj8anzFgPbYKs3y9PZOb+ysw8y9fE8ArmK/mZvqyZqCjA14dZrrG
         2wlIY/mV30hmlCmcR34yvxK7MeQcqlFe+WWcBBstT6RXV0pl2lkgFsMDpZIdCE065dJW
         XRnUcqQft3h6GQBvh4tMABo/EV8IOveeFruoBMBXB7oBAKIRSEgTr49zICYjlO5MU3LW
         5vZ9JJ/qGqyapivfiTuWzuLpO9FegxniP7vqgGI9+YJ5GW6H7W4fvmUJ7Uadak+cfxGl
         P1Kg==
X-Gm-Message-State: APt69E3sXYuh1aRimBVf6SkjnLslKJ7kdt0dICBWHe5l5mikiyYU+8To
        pV4i1zALfCB2M4dzqUO1xaGjtaoZtGGQPq0Q77s=
X-Google-Smtp-Source: AAOMgpfwyucqoLqujKgb2K6aRcepvjtn1SSVzwoHgUioX9wy+zt9YK64SDDdjLjUD9k4qTwPlVCFZ83rU6GxQaATYZk=
X-Received: by 2002:a6b:980e:: with SMTP id a14-v6mr18313109ioe.238.1530571512395;
 Mon, 02 Jul 2018 15:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180702223143.4663-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20180702223143.4663-1-mathieu.desnoyers@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 15:45:01 -0700
Message-ID: <CA+55aFxrX+wRoe+5HDaTrRXg1K-Qpks4jJ9Buc_OevoG8hoGFw@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields, validate
 user inputs
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

On Mon, Jul 2, 2018 at 3:31 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Change the rseq ABI so rseq_cs start_ip, post_commit_offset and abort_ip
> fields are seen as 64-bit fields by both 32-bit and 64-bit kernels rather
> that ignoring the 32 upper bits on 32-bit kernels. This ensures we have a
> consistent behavior for a 32-bit binary executed on 32-bit kernels and in
> compat mode on 64-bit kernels.

Actually, now that I see this again, I react to:


> +static int check_rseq_cs_padding(struct task_struct *t)
> +{
> +       u32 pad;
> +       int ret;
> +
> +       ret = __get_user(pad, &t->rseq->rseq_cs_padding);
> +       if (ret)
> +               return ret;
> +       if (pad)
> +               return -EINVAL;
> +       return 0;
> +}

This is all wrong.

Just make "rseq_cs" be an __u64" too. That will clean up everything,
and user space will have a much easier time filling it in too, since
it's just one field. Instead of having to remember about the "let's
fill in padding for 32-bit cases".

Then the rseq_get_rseq_cs() will be

        __u64 rseq_cs;

        ret = get_user(rseq_cs, &t->rseq->rseq_cs);
        if (ret)
                return ret;
        ptr = (void *)rseq_cs;
        if (rseq_cs != (unsigned long)ptr)
                return -EINVAL;

and it's all good, no #ifdef's etc needed.

Hmm?

Sorry for the bike-shedding, but this is now the last remaining user
of that LINUX_FIELD_u32_u64, so let's just get rid of it entirely, ok?

Then we can also get rid of that silly uapi/linux/types_32_64.h header
file entirely.

That would be *lovely*. Simpler code, simpler and less error-prone
interfaces, and one less specialized header file.

              Linus
