Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8080EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380E525C01
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RV2Ki7kE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380E525C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753397AbeGBUwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:52:51 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45730 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752636AbeGBUws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:52:48 -0400
Received: by mail-io0-f196.google.com with SMTP id l25-v6so15861896ioh.12;
        Mon, 02 Jul 2018 13:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGrd6unPpJVY1IWOm7oS5EFzFdLQA69N/5PjRQVodAg=;
        b=RV2Ki7kEuiqhJDD9JVDjxLKVGdrzSVUWI7iT8mapkrMQBqGLu9PRy9tHQ7MCm4If++
         nulTvZkbgFLEYfEpN0uNLgp8wEvoxzCCZW03SnGMKO2uoFagE+APtdqDwMvclzyY/3BU
         bCCP5X8zYAbbz2TGdI2NqewtvhynYfxb/xsX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGrd6unPpJVY1IWOm7oS5EFzFdLQA69N/5PjRQVodAg=;
        b=F6V5attyN110Zfs9dQsv+zTiI1gRziky02FuwlKXt/L2JKYVqabvB959zmWji2Go44
         Kab3kC8evBHmI8lV4T3Npc6Om2Hai56ugSwkEP/Xk0aqPwR3pbC8Sa+sOuo178oOBDUY
         iTuJtO0Fww+tgJjuRQb9raW+QQUMFgpxOU97L1dUORziKsRcnEM6LjLfudRXSTa4BIVN
         PD45uoBP/X+kygNQSMBgugRPX+2POCroOKUcijvyohe8vXjEiXMPifjBJn0BSeGhSE1a
         ijnLFZOYxppUYuraLnMcYqLiGld0xBvyuB1RVLjvG03CCFlbLU7QnGR3qNMZrILOxj+b
         VWSw==
X-Gm-Message-State: APt69E0ysTqgAGT3B3POIQr/fbrki4K9OcU+TqR0oTWr6f1VEuoG/KPx
        WR8jLNZlZejUia05wqgG/E495uzAzxMiSFR6kV0=
X-Google-Smtp-Source: AAOMgpf+QgTQWG5VGxupDFVgkIwmqo27K1Rrn4JExIp0+jvb/2TnScBtpJoWBesB6ffPpOoiqTbm9nxW5QlENpupzoE=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr23296102ion.259.1530564767841;
 Mon, 02 Jul 2018 13:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180702204058.819-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20180702204058.819-1-mathieu.desnoyers@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 13:52:36 -0700
Message-ID: <CA+55aFzH+4=Aeh_P1ptFn5nVm7yFuEGpxUJ0kNB-sUHVOv8rcw@mail.gmail.com>
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

On Mon, Jul 2, 2018 at 1:41 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> -       if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)))
> +       if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)) ||
> +           rseq_cs->abort_ip >= TASK_SIZE)
>                 return -EFAULT;

I think the abort_ip check should have the same error value as the
other sanity checks, ie just be of this format:

>         if (rseq_cs->version > 0)
>                 return -EINVAL;

also, I think you should check start_ip to be consistent. You kind of
accidentally do it with the check for

        if (rseq_cs->abort_ip - rseq_cs->start_ip - rseq_cs->post_commit_offset)

but honestly, that has underflow issues already, so I think you want
to basically make the check be

        if (rseq_cs->abort_ip >= TASK_SIZE)
                return -EINVAL;

        if (rseq_cs->start_ip >= rseq_cs->abort_ip)
                return -EINVAL;

which takes care of checkint  start_ip, and also the underflow for the
post_commit_offset check.

If somebody is depending on negative offsets, then that
post_commit_offset logic is already wrong.

> +       usig = (u32 __user *)(unsigned long)(rseq_cs->abort_ip - sizeof(u32));
>         ret = get_user(sig, usig);

That can underflow too, but I guess we can just rely on get_user()
getting it right.

               Linus
