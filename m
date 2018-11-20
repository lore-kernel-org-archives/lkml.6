Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC54C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5301208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOaP8rBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5301208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbeKUBtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:49:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:33670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbeKUBtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:49:31 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A29842148E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 15:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542727191;
        bh=8roBoGZuCicv4hoTrM6ONEj0zHK6snI9tHj+r9Z1KPw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mOaP8rBCOKdFCE2VAeZLYzRC6vjuuZbN6R+okpXzyzjpKIsr4F/nnf5zbrilMplWD
         iJQr8xzFUs5i6cjVxo4EZUm4mVjEjD9n4KcSYZSnj3IwWWuNEJ4YZD/yPbnS/kOm3x
         aGfuKRH4NTc7HiK4APd6meD99iqhCt88pfb3boP0=
Received: by mail-wr1-f52.google.com with SMTP id 96so2399469wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 07:19:51 -0800 (PST)
X-Gm-Message-State: AA+aEWaxjtCyItpv1l4ujVNGbUYFEwMvvOVgz0ikwUTdTCNKnpywFH7D
        0IM42UdJb7187YM++BTXu4RNMAxpCnIGdjURpkPs3g==
X-Google-Smtp-Source: AFSGD/VYcPShNWjh5RDBkkioQ/3SZ5Wj++iIvx/GGRJzNAN1a4vYBkeQP/gtX2DZ9DQU2WYDaLu3sw900DqTosQ7DEE=
X-Received: by 2002:a5d:5541:: with SMTP id g1mr2432718wrw.330.1542727189965;
 Tue, 20 Nov 2018 07:19:49 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrWdpoDkbZjkucKL91GWpDPG9p=VqYrULade2pFDR7S=GQ@mail.gmail.com>
 <20181118071548.GA4795@linux.intel.com> <CALCETrXSpn7QGzPgO1BjMRQ75r2i0kmACrbUM+8PyT+xi3f3Hw@mail.gmail.com>
 <20181119160204.GD13298@linux.intel.com> <CALCETrWRVgPjnDd-CknskrXfNbke=rSnr_jezszNNWJUM_YJKQ@mail.gmail.com>
 <20181120101133.GA7319@linux.intel.com>
In-Reply-To: <20181120101133.GA7319@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 20 Nov 2018 07:19:37 -0800
X-Gmail-Original-Message-ID: <CALCETrU2dy7Oh+AHDGZ2omq9p7pNbjFd8ruv5CkfJXCp5nTYBQ@mail.gmail.com>
Message-ID: <CALCETrU2dy7Oh+AHDGZ2omq9p7pNbjFd8ruv5CkfJXCp5nTYBQ@mail.gmail.com>
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

On Tue, Nov 20, 2018 at 2:11 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, Nov 19, 2018 at 09:00:08AM -0800, Andy Lutomirski wrote:
> > On Mon, Nov 19, 2018 at 8:02 AM Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> > >
> > > On Mon, Nov 19, 2018 at 07:29:36AM -0800, Andy Lutomirski wrote:
> > > > 1. The kernel needs some way to know *when* to apply this fixup.
> > > > Decoding the instruction stream and doing it to all exceptions that
> > > > hit an ENCLU instruction seems like a poor design.
> > >
> > > I'm not sure why you would ever need to do any type of fixup as the idea
> > > is to just return to AEP i.e. from chosen exceptions (EPCM, #UD) the AEP
> > > would work the same way as for exceptions that the kernel can deal with
> > > except filling the exception information to registers.
> >
> > Sure, but how does the kernel know when to do that and when to send a
> > signal?  I don't really like decoding the instruction stream to figure
> > it out.
>
> Hmm... why you have to decode instruction stream to find that out? Would
> just depend on exception type (#GP with EPCM, #UD).

What is "#GP with EPCM"?  We certainly don't want to react to #UD in
general by mucking with some regs and retrying -- that will infinite
loop and confuse everyone.  I'm not even 100% convinced that decoding
the insn stream is useful -- AEP can point to something that isn't
ENCLU.

IOW the kernel needs to know *when* to apply this special behavior.
Sadly there is no bit in the exception frame that says "came from
SGX".
