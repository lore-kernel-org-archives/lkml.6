Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7FFECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCB82064D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdSi0A5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCB82064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388483AbeGTUWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:22:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388212AbeGTUWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:22:13 -0400
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D42E2086B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 19:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532115152;
        bh=mV3peTbm5lguK5Ltik4c39xqYNt1dFvzd9xRyl8STFM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=rdSi0A5nhuzVRU8f2J2LEoXk9IGwVRPmZIeF8pDRNuJuU163PZpJ8XlUQiS39ue4V
         3SHx6gXOmwwMkP5rqGf/lZRUUZ+OM0loKTmbRZ2aK1VLG02+sl+VepM60b0Kxsx63k
         fJnKFNPTBhf75RwwU74V0xnOFC/6pJpO+wEVOe+8=
Received: by mail-wm0-f46.google.com with SMTP id a19-v6so10778691wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 12:32:32 -0700 (PDT)
X-Gm-Message-State: AOUpUlFx7SM63lhC/U0Ru2cMIN+Vf2c5cW2SHRkWkjiQNqWPsh3tvvxX
        hC0uZLYqncxiw0ruPCwI8jnh4RKh14Jm8qlwwgkfYQ==
X-Google-Smtp-Source: AAOMgpeNzcNC1uPKSnhzrsLUc4N9D/SXMj5dbq6k2ssom6OyGOiVb484y6pOGyiIOY8yiWZyL+N8B9MYmZYpnXnuuGI=
X-Received: by 2002:a1c:8b0d:: with SMTP id n13-v6mr2118907wmd.46.1532115150614;
 Fri, 20 Jul 2018 12:32:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 12:32:10
 -0700 (PDT)
In-Reply-To: <20180720174846.GF18541@8bytes.org>
References: <1532103744-31902-1-git-send-email-joro@8bytes.org>
 <1532103744-31902-2-git-send-email-joro@8bytes.org> <CALCETrXJX8tPVgD=Ce41534uneAAobm-HyjeGwVYgJDJ_+-bDw@mail.gmail.com>
 <20180720174846.GF18541@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 20 Jul 2018 12:32:10 -0700
X-Gmail-Original-Message-ID: <CALCETrUj4cLpOKUbJUfLqKJFkjAgeraE=ORQ-e-bKU+AHda0=Q@mail.gmail.com>
Message-ID: <CALCETrUj4cLpOKUbJUfLqKJFkjAgeraE=ORQ-e-bKU+AHda0=Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf/core: Make sure the ring-buffer is mapped in all page-tables
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        Joerg Roedel <jroedel@suse.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 10:48 AM, Joerg Roedel <joro@8bytes.org> wrote:
> On Fri, Jul 20, 2018 at 10:06:54AM -0700, Andy Lutomirski wrote:
>> > On Jul 20, 2018, at 6:22 AM, Joerg Roedel <joro@8bytes.org> wrote:
>> >
>> > From: Joerg Roedel <jroedel@suse.de>
>> >
>> > The ring-buffer is accessed in the NMI handler, so we better
>> > avoid faulting on it. Sync the vmalloc range with all
>> > page-tables in system to make sure everyone has it mapped.
>> >
>> > This fixes a WARN_ON_ONCE() that can be triggered with PTI
>> > enabled on x86-32:
>> >
>> >    WARNING: CPU: 4 PID: 0 at arch/x86/mm/fault.c:320 vmalloc_fault+0x220/0x230
>> >
>> > This triggers because with PTI enabled on an PAE kernel the
>> > PMDs are no longer shared between the page-tables, so the
>> > vmalloc changes do not propagate automatically.
>>
>> It seems like it would be much more robust to fix the vmalloc_fault()
>> code instead.
>
> The question is whether the NMI path is nesting-safe, then we can remove
> the WARN_ON_ONCE(in_nmi()) in the vmalloc_fault path. It should be
> nesting-safe on x86-32 because of the way the stack-switch happens
> there. If its also nesting-safe on x86-64 the warning there can be
> removed.
>
> Or did you think of something else to fix there?

I'm just reading your changelog, and you said the PMDs are no longer
shared between the page tables.  So this presumably means that
vmalloc_fault() no longer actually works correctly on PTI systems.  I
didn't read the code to figure out *why* it doesn't work, but throwing
random vmalloc_sync_all() calls around is wrong.

Or maybe the bug really just is the warning.  The warning can probably go.

>
>
> Thanks,
>
>         Joerg
>
