Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B82ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8BF2064D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZelORvcm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8BF2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388541AbeGTUXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:23:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388373AbeGTUXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:23:18 -0400
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E63D20661
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 19:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532115216;
        bh=R2xB6ZQTcZjMOoSoFxJSgJIp/oHChEfTojGQz5QPSU4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ZelORvcmQC9qOndIu1isBSGbv8La9ETNVqioAGdx4x3NvqQlmjz0UxWvWxPG3lQFH
         kdlcT3LPTZ5FvUA8NXZ8bSTrzqtAIWYHLxnds4i5khd6ZEHbg9KAAJTDuzBoNWK+ux
         CjJvDzVhG+ZoxbDCS75k4nWogbWy3EVSwlCgEtXM=
Received: by mail-wm0-f50.google.com with SMTP id y22-v6so10875599wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 12:33:36 -0700 (PDT)
X-Gm-Message-State: AOUpUlHVwwR/CPlJ2KQEnkz5h/XUvNUKdK+rx2G38e/7jCiobFRDYvjH
        PQODWFoK6xstfjaLcxMIHZDWRnFZ92qxKbGKEoma+g==
X-Google-Smtp-Source: AAOMgpfjIaueWkYMO4G07PQ9QTao+tMg+56l+mkjo+jJcgk8ferSyCsQC41l4sh0JuijSNgjyZVi8RgOVOJe59s2srY=
X-Received: by 2002:a1c:8313:: with SMTP id f19-v6mr2173409wmd.144.1532115215169;
 Fri, 20 Jul 2018 12:33:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 12:33:14
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1807202126400.1694@nanos.tec.linutronix.de>
References: <1532103744-31902-1-git-send-email-joro@8bytes.org>
 <1532103744-31902-2-git-send-email-joro@8bytes.org> <CALCETrXJX8tPVgD=Ce41534uneAAobm-HyjeGwVYgJDJ_+-bDw@mail.gmail.com>
 <alpine.DEB.2.21.1807202126400.1694@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 20 Jul 2018 12:33:14 -0700
X-Gmail-Original-Message-ID: <CALCETrW7o=s7esmE4+SxLPsLv2SvJZU6f7jfsedazZVrot2EqA@mail.gmail.com>
Message-ID: <CALCETrW7o=s7esmE4+SxLPsLv2SvJZU6f7jfsedazZVrot2EqA@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf/core: Make sure the ring-buffer is mapped in all page-tables
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>,
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

On Fri, Jul 20, 2018 at 12:27 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 20 Jul 2018, Andy Lutomirski wrote:
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
> Right, but now the obvious fix for the issue at hand is this. We surely
> should revisit this.

If you commit this under this reasoning, then please at least make it say:

/* XXX: The vmalloc_fault() code is buggy on PTI+PAE systems, and this
is a workaround. */

Let's not have code in the kernel that pretends to make sense but is
actually voodoo magic that works around bugs elsewhere.  It's no fun
to maintain down the road.
