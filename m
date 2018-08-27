Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B45CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039C8208EA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6BY4XN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039C8208EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeH1DOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:14:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbeH1DOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:14:53 -0400
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 185FC208EA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 23:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535412365;
        bh=GOZqWP2Pdcw9WdrUvNC1a992PeinjRFc1EI5GZAAZIM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=l6BY4XN8GwsO6Fop8tI5LXemOmS5XyhZqp22BgEZnS3vKM1/o/+hQx8MFKOr5rinE
         HHO99iRG45CwHityxxjqsv5BnH8YxpvW5t9nhT2Cgc1fpOntNNdQIngygLnIADg0Wt
         IMo0r7tKyTYe085FbmXDdSa0L5+hrgCpxYknj9BI=
Received: by mail-wm0-f49.google.com with SMTP id j192-v6so30964wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:26:05 -0700 (PDT)
X-Gm-Message-State: APzg51ABPQhzBjZKSlViTGbQq68OXkgXeDTjaDPA68k7WANwr0cTRIAf
        pOj8htc0hR1WS65/LeXdOG61vno0v6bAziwvYkjH5A==
X-Google-Smtp-Source: ANB0VdbkMxmocztw8hvApSaYZ4pMCvKpAROuxbz3KHemjq9/ongrV1dpvCyqA+OzjE4myxxdopWKwehPbv5jHKsBjnw=
X-Received: by 2002:a1c:8313:: with SMTP id f19-v6mr6496494wmd.144.1535412363502;
 Mon, 27 Aug 2018 16:26:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 16:25:43 -0700 (PDT)
In-Reply-To: <CAG48ez2DkjrvmP57JvbC+4ee0qCXCEXEyYuA4YApWGX_k29y_w@mail.gmail.com>
References: <c7ee1ee7a1b8d17743f7c3680ea5d2c32bf3e897.1535410956.git.luto@kernel.org>
 <CAG48ez2DkjrvmP57JvbC+4ee0qCXCEXEyYuA4YApWGX_k29y_w@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 27 Aug 2018 16:25:43 -0700
X-Gmail-Original-Message-ID: <CALCETrXHaAFARQ4Gq2ku1DMbD+78cx1JjWDpTenbNns4OWT+FA@mail.gmail.com>
Message-ID: <CALCETrXHaAFARQ4Gq2ku1DMbD+78cx1JjWDpTenbNns4OWT+FA@mail.gmail.com>
Subject: Re: [PATCH] x86/nmi: Fix some races in NMI uaccess
To:     Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 4:12 PM, Jann Horn <jannh@google.com> wrote:
> On Tue, Aug 28, 2018 at 1:04 AM Andy Lutomirski <luto@kernel.org> wrote:
>>
>> In NMI context, we might be in the middle of context switching or in
>> the middle of switch_mm_irqs_off().  In either case, CR3 might not
>> match current->mm, which could cause copy_from_user_nmi() and
>> friends to read the wrong memory.
>>
>> Fix it by adding a new nmi_uaccess_okay() helper and checking it in
>> copy_from_user_nmi() and in __copy_from_user_nmi()'s callers.
>
> What about eBPF probes (which I think can be attached to kprobe points
> / tracepoints / perf events) that perform userspace reads / userspace
> writes / kernel reads? Can those run in NMI context, and if so, do
> they also need special handling?

I assume they can run in NMI context, which might be problematic in
and of themselves.  For example, does BPF adequately protect against a
BPF program accessing a map while bpf(2) is modifying it?  It seems
like bpf_prog_active is intended to serve this purpose.

But I don't see any obvious mechanism for eBPF programs to read user memory.
