Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0EBC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F43A20817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bMQ2odlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F43A20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeKSIVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 03:21:54 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:42661 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeKSIVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 03:21:54 -0500
Received: by mail-lj1-f177.google.com with SMTP id l15-v6so16299218lja.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 14:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5bj5rrlbW7BtQ4+yq6AMumnTIpUMq4U5nAKgTonCCHU=;
        b=bMQ2odlhahXQKIvmjC3QxV5PTiqiDzxKi0x24C2hSVO/y0qqRi3PWCAkN1mIgbfhb4
         9KngNoM/WeQF0ZI+65/fh+7hUkktkaSbUHFiutT1P92V1yNzNeT+XPxNgGIC9iGg4bu+
         kri0snCrgfCdoK7fWvmMw9B5z15SR/cLgrrkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5bj5rrlbW7BtQ4+yq6AMumnTIpUMq4U5nAKgTonCCHU=;
        b=rNqe1PvYXyGNjqpckybY5gmdSVLe86suJcs/KBn0zAnLmnmMNyt6bXe634Ed2ZGwKr
         0mu+uNqZotoUKcjfCSTtM6bHRp/VqfGAp5VDdw2lehqQk4vC1/FwXn9O/PgIq9dkWa+Q
         KTJDM/8OvsmNcSE/e9HOj7tIcAI4js3DF2IsIC5R9xGk6vRSZiTZrTL4NHiKW1RN4dV0
         EzX41ZC5nVrB1n9Yt2WZ/GixXegKQSDQLdkpMm3DqBdFK1t0cQt+smSe+G+Mlrmdl9LH
         jDQTB7e6612Xb1LwJktFxxlo3ML0N1V5FwdJUd/nqFZb9SlFs/TBfK9wxWM+oKg5KC9a
         6Neg==
X-Gm-Message-State: AGRZ1gKebk4sI3sLMrmfXW2us6w7hRaLZlzMyXQeRLbYaiuWxrGqVv5f
        bryQ/3iaWDLnWnRwKzC/osnapzi3Gig=
X-Google-Smtp-Source: AJdET5caxIGL1pdhBPy153oBAJQe7zozWjEpMoisvtzYZNLJQTnDH0ZeC8rc/X4Bdp32Ad33Q3s3Aw==
X-Received: by 2002:a2e:2e1a:: with SMTP id u26-v6mr11287076lju.8.1542578421773;
        Sun, 18 Nov 2018 14:00:21 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id q8-v6sm4128415lji.69.2018.11.18.14.00.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 14:00:20 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id v5so19952013lfe.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 14:00:20 -0800 (PST)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr9034917lfa.106.1542578419958;
 Sun, 18 Nov 2018 14:00:19 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wg-9FUGU=grF4gKDq1sm1m39Jbs3A_iyLbSSntU47ncwg@mail.gmail.com>
 <nycvar.YFH.7.76.1811182222230.21108@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1811182222230.21108@cbobk.fhfr.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 18 Nov 2018 14:00:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=whH2daKsZTqVPb-G9mJ1g15XMse7j-9YqN+yBYk7M9=Dw@mail.gmail.com>
Message-ID: <CAHk-=whH2daKsZTqVPb-G9mJ1g15XMse7j-9YqN+yBYk7M9=Dw@mail.gmail.com>
Subject: Re: STIBP by default.. Revert?
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 1:49 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> > So why do that STIBP slow-down by default when the people who *really*
> > care already disabled SMT?
>
> BTW for them, there is no impact at all.

Right. People who really care about security and are anal about it do
not see *any* advantage of the patch.

But people who aren't that worried suddenly see potentially huge slowdowns.

In other words, the behavior of the patch is basically essentially
exactly the reverse of what you'd want. You penalize the people who
don't even want it and don't care.

> STIBP is only activated on systems with HT on; plus odds are that people
> who don't care about spectrev2 already have 'nospectre_v2' on their
> command-line, so they are fine as well.

I'm talking about *normal* people. People who simply aren't all that
invested in this all. People who just want to get their work done.

> So, I think it's as theoretical as any other spectrev2 (only with the
> extra "HT" condition added on top).

What? No.

It's *way* more theoretical than something like meltdown, which could
be trivially used to get data from another protection domain.

Have you seen any actual realistic attacks for normal human users?
Things where the *kernel* should actually care?

The javascript thing is for the browser to fix up, not for the kernel
to say "now everything should run up to 50% slower".

                       Linus
