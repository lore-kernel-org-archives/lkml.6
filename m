Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80921C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F6F20870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwtB8YMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F6F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbeKTBxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:53:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729710AbeKTBxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:53:47 -0500
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 571A5214D9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 15:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542641390;
        bh=4ArSSgLvYbln2z+xtgBfTKwMGLB3G7ywEbt69m03hR8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UwtB8YMvWHhR1oe8I8LevWmTxy5vfHK/VaHldN6gWx+8yzLStmGw2I9Aj5z0gq65U
         MhHmgOKTL7Uk3IREYdjqMlJQhiP1SryVuwxDfD7lmBWQjMc+6DSkIvRKQNoACkFfNp
         vw5rOSrPXERO7X6cS8hqMWBbbIjVHSc6ql8INzKE=
Received: by mail-wr1-f51.google.com with SMTP id t3so2321218wrr.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 07:29:50 -0800 (PST)
X-Gm-Message-State: AGRZ1gJ+auNCbuM3DoA+w/8NaF7VquRvBMdStHjGYkZsQYY44xlp0N95
        6RwtNNGgl0RawoBjzP/Rb1iujXMuMd20uTZwN83aag==
X-Google-Smtp-Source: AJdET5dycq0bVkF+VUNKU9L4Pdz2FtjptGEEF2z93ehVrY9Y+OXprP7hE7juHxk9zZZWu256DHo/uMKdKhcyAajfAQY=
X-Received: by 2002:adf:afdc:: with SMTP id y28-v6mr18038620wrd.176.1542641388634;
 Mon, 19 Nov 2018 07:29:48 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrWdpoDkbZjkucKL91GWpDPG9p=VqYrULade2pFDR7S=GQ@mail.gmail.com>
 <20181118071548.GA4795@linux.intel.com>
In-Reply-To: <20181118071548.GA4795@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 19 Nov 2018 07:29:36 -0800
X-Gmail-Original-Message-ID: <CALCETrXSpn7QGzPgO1BjMRQ75r2i0kmACrbUM+8PyT+xi3f3Hw@mail.gmail.com>
Message-ID: <CALCETrXSpn7QGzPgO1BjMRQ75r2i0kmACrbUM+8PyT+xi3f3Hw@mail.gmail.com>
Subject: Re: RFC: userspace exception fixups
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Florian Weimer <fweimer@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rich Felker <dalias@libc.org>, nhorman@redhat.com,
        npmccallum@redhat.com, "Ayoun, Serge" <serge.ayoun@intel.com>,
        shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 11:16 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Nov 01, 2018 at 10:53:40AM -0700, Andy Lutomirski wrote:
> > Hi all-
> >
> > The people working on SGX enablement are grappling with a somewhat
> > annoying issue: the x86 EENTER instruction is used from user code and
> > can, as part of its normal-ish operation, raise an exception.  It is
> > also highly likely to be used from a library, and signal handling in
> > libraries is unpleasant at best.
> >
> > There's been some discussion of adding a vDSO entry point to wrap
> > EENTER and do something sensible with the exceptions, but I'm
> > wondering if a more general mechanism would be helpful.
>
> I haven't really followed all of this discussion because I've been busy
> working on the patch set but for me all of these approaches look awfully
> complicated.
>
> I'll throw my own suggestion and apologize if this has been already
> suggested and discarded: return-to-AEP.
>
> My idea is to do just a small extension to SGX AEX handling. At the
> moment hardware will RAX, RBX and RCX with ERESUME parameters. We can
> fill extend this by filling other three spare registers with exception
> information.

I have two issues with this approach:

1. The kernel needs some way to know *when* to apply this fixup.
Decoding the instruction stream and doing it to all exceptions that
hit an ENCLU instruction seems like a poor design.

2. It starts exposing what looks like a more generic exception
handling mechanism to userspace, except that it's nonsensical for
anything other than ENCLU.
