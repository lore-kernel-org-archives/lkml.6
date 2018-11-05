Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798A5C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2921E20831
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+doHl6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2921E20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbeKEOcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 09:32:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbeKEOcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 09:32:53 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9695920868
        for <linux-kernel@vger.kernel.org>; Mon,  5 Nov 2018 05:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541394902;
        bh=s6GeHQf0rw0c/HurOx0z354Z/cYUDQOVYpdUSGhqL/4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N+doHl6rJoJXZsA9bbvAuqU3LdKJe4u07WNLPzILufgWZqweVbRXNTjRPAzXGLzwZ
         8SeVBClbEpwFvVnMVJlYGobZnFA24QGddacczlKj8bI53I/H3PcHat3KK6nBlGNXHZ
         lv8SvXiMNjVtBslICk1KgF5/6OTkUojHCbg4nwc4=
Received: by mail-wr1-f46.google.com with SMTP id j26-v6so7985168wre.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 21:15:02 -0800 (PST)
X-Gm-Message-State: AGRZ1gKLb9j29ibOl67JtAGyf8s3ZJj6AcyB1LlOnCKRhpLuLc64j3mh
        TtrKgl4zFjykb9Fft+IOYUbFbKdHXqJDKVKoRqt5IQ==
X-Google-Smtp-Source: AJdET5et391oFODJb6Ab/AbYzbu4oVjRKgXa8myXtQ3EoEHbXB4vLHvaefZYyZ7NXPHGNLBF9GdDaqSzdSoW8mYDjZ4=
X-Received: by 2002:adf:9d4a:: with SMTP id o10-v6mr15251495wre.94.1541394900963;
 Sun, 04 Nov 2018 21:15:00 -0800 (PST)
MIME-Version: 1.0
References: <1541187610-5322-1-git-send-email-longman@redhat.com>
 <a3584dd1-c030-cebe-3f3d-eadc0744580a@intel.com> <fb715262-df9e-3e77-6964-80ec4a1c7a24@redhat.com>
 <47b1c477-46a7-6b04-7537-378e2910611b@intel.com> <CALCETrV0RYZPbZ0vyRehvS=L-yZwLQ06=eov+=GkzFm0GoQQpQ@mail.gmail.com>
In-Reply-To: <CALCETrV0RYZPbZ0vyRehvS=L-yZwLQ06=eov+=GkzFm0GoQQpQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 4 Nov 2018 21:14:49 -0800
X-Gmail-Original-Message-ID: <CALCETrXfvWiGNjyusMeOt-xo61zpmFzahnkwUwMnWjnv_gsNnA@mail.gmail.com>
Message-ID: <CALCETrXfvWiGNjyusMeOt-xo61zpmFzahnkwUwMnWjnv_gsNnA@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/mm/fault: Allow stack access below %rsp
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Waiman Long <longman@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 4, 2018 at 9:11 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Fri, Nov 2, 2018 at 3:28 PM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 11/2/18 12:50 PM, Waiman Long wrote:
> > > On 11/02/2018 03:44 PM, Dave Hansen wrote:
> > >> On 11/2/18 12:40 PM, Waiman Long wrote:
> > >>> The 64k+ limit check is kind of arbitrary. So the check is now removed
> > >>> to just let expand_stack() decide if a segmentation fault should happen.
> > >> With the 64k check removed, what's the next limit that we bump into?  Is
> > >> it just the stack_guard_gap space above the next-lowest VMA?
> > > I think it is both the stack_guard_gap space above the next lowest VMA
> > > and the rlimit(RLIMIT_STACK).
> >
> > The gap seems to be hundreds of megabytes, typically where RLIMIT_STACK
> > is 8MB by default, so RLIMIT_STACK is likely to be the practical limit
> > that will be hit.  So, practically, we've taken a ~64k area that we
> > would on-demand extend the stack into in one go, and turned that into a
> > the full ~8MB area that you could have expanded into anyway, but all at
> > once.
> >
> > That doesn't seem too insane, especially since we don't physically back
> > the 8MB or anything.  Logically, it also seems like you *should* be able
> > to touch any bit of the stack within the rlimit.
> >
> > But, on the other hand, as our comments say: "Accessing the stack below
> > %sp is always a bug."  Have we been unsuccessful in convincing our gcc
> > buddies of this?
>
> FWIW, the old code is a bit bogus.  Why are we restricting the range
> of stack expending addresses for user code without restricting the
> range of kernel uaccess addresses that would do the same thing?
>
> So I think I agree with the patch.

I should add: if this patch is *not* applied, then I think we'll need
to replace the sw_error_code check with user_mode(regs) to avoid an
info leak if CET is enabled.  Because, with CET, WRUSS will allow a
*kernel* mode access (where regs->sp is the kernel stack pointer) with
user permissions.
