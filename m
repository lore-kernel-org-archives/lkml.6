Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CEEECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06F520877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06F520877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbeIYDEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:04:22 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45542 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeIYDEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:04:21 -0400
Received: by mail-qt1-f193.google.com with SMTP id l2-v6so11083355qtr.12;
        Mon, 24 Sep 2018 14:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZohGzcrTiBsTOwa+P4pwEo79Dicf7FpF4YEBL2IJEUU=;
        b=XY00VzyQF5qSTV7daN9qVf/SLaxDvrxGLQJet3JKDv1splPDhKdYFnKbFGBfUG+T6L
         xIY51KINIvNUsIUG2Y0PpXQkHw8o85EjzHBHJm+Q1XfklimcGUlNbtXLZbYbePwciEP3
         2igUIt3WVrWoDh3vB6ybgt5LMIfGYLUMtbDvJDKJQfUdxNHJS5htPfl43LcwuA4klqdK
         cdb0Kh3KY52qRRJauXe1LSxQLC9HOYA1zHarjtjwsjY7+pr3t6mZP8MS/p/9qeJrlhiN
         3BNE7WoeG5gTQHrgXq979Ukzvxog/RFjSux7RNQY3jlakcHXlRRCWdWckPuWkpkd/8Ev
         Jljg==
X-Gm-Message-State: ABuFfoh3VS6u48BEGTBsznmAZMkHMMNpDG7YXwzQczOWWcmkflWxWo/A
        yaTOWKw6pgZNlP1cGS6r3ahCdJXi6SxcU4/rvrw=
X-Google-Smtp-Source: ACcGV60nqtwdVp6Uh9dNfWiLDw48CfbR2IWiXDWKJOHSGX4Y0aWRlXzSuDJnR6oEoCAkhNUh/xVzqlJIGqER63F0GsI=
X-Received: by 2002:a0c:8834:: with SMTP id 49-v6mr550962qvl.40.1537822815934;
 Mon, 24 Sep 2018 14:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <1536913980-4811-1-git-send-email-firoz.khan@linaro.org>
 <1536913980-4811-3-git-send-email-firoz.khan@linaro.org> <CAK8P3a1PCnHy1JX4T21LjOr3ZGAVLdqxQaPYfLHAgM-9Y5yxVg@mail.gmail.com>
 <CALxhOngVYQRwbcUg6c_3LcKAEoBwyN1B478LqRGmWEGL004--w@mail.gmail.com>
In-Reply-To: <CALxhOngVYQRwbcUg6c_3LcKAEoBwyN1B478LqRGmWEGL004--w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 24 Sep 2018 22:59:59 +0200
Message-ID: <CAK8P3a2hi-Ndh7X-9r3NhBUJXQBTBFsTU==GbHesy6YD9idCJA@mail.gmail.com>
Subject: Re: [PATCH 2/3] powerpc: Add system call table generation support
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linuxram@us.ibm.com,
        leitao@debian.org, Boqun Feng <boqun.feng@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 2:15 PM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> On 14 September 2018 at 15:31, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Fri, Sep 14, 2018 at 10:33 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> >> ---
> >>  arch/powerpc/kernel/syscalls/Makefile       |  51 ++++
> >>  arch/powerpc/kernel/syscalls/syscall_32.tbl | 378 ++++++++++++++++++++++++++++
> >>  arch/powerpc/kernel/syscalls/syscall_64.tbl | 372 +++++++++++++++++++++++++++
> >>  arch/powerpc/kernel/syscalls/syscallhdr.sh  |  37 +++
> >>  arch/powerpc/kernel/syscalls/syscalltbl.sh  |  38 +++
> >
> > I think you should only need a single .tbl  input file here.
>
> Yes, we can do that way also.As I mentioned, it will add
> more complexity in the script.
>
>  The script has to be smart enough to parse the
> .tbl if we add more thing in the .tble file. It need more
> logic in the scripts. This is not common. So if you keep
> separate .tbl we can avoid this.

But all three existing architectures (x86, s390 and arm) already
have the capability to parse the table and generate different output
from that.

> ABI flag is serving *nothing* in all other architecture including
> SPARC.

If you don't use it in sparc, I think that's a bug, see e.g.

#ifdef __32bit_syscall_numbers__
#define __NR_setresuid32        108 /* Linux Specific, sigvec under
SunOS          */
#else
#define __NR_setresuid          108 /* Linux Specific, sigvec under
SunOS          */
#endif

> But as I told in the cover letter, I followed x86/arm/
> s390 architecture's system table generation implementation.
> They are keeping ABI flag. In our case we can delete this
> flag completely from all architectures.
>
> Most of the architecture these 32/64 similarity is absent.
> So it would be better keep separate files to maintain a
> generic script across all architecture.

There are a couple of architectures that definitely need it:
ARM for oabi, x86 for x32, s390, parisc and sparc for compat,
asm-generic for compat, powerpc for compat and spu,
and arm64 if we want to share the arm32 syscall table
for compat mode later.

      Arnd
