Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF57C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3404D2507F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dV/DOwc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3404D2507F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753631AbeGBXW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 19:22:28 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35609 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753384AbeGBXWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 19:22:24 -0400
Received: by mail-io0-f195.google.com with SMTP id q4-v6so78817iob.2;
        Mon, 02 Jul 2018 16:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kt0+beNA65xbcW4blsNCxlHLj1zSU8x2dO8PGgWTA/s=;
        b=dV/DOwc5CMce5MAshmhbZeE/o6q8Og5RcuniWddGzA4b8Adf9A4A4WYT7v1dAM/LaW
         Lo9Nepo31SCQxLMx8fDroFOBcfzT+ao9mCWTuYbF0aQ+pJic8pyTPsWyPwGES6iSPB9j
         tQ6pcmg+hO+uQklG7Ia6EJlrbLZqmwaTVMK68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kt0+beNA65xbcW4blsNCxlHLj1zSU8x2dO8PGgWTA/s=;
        b=oKFfztZJOvG7A9mEJXTrAFBxinLQgGv0TGANvT+k1YQhsf+40hxKp2hxK7ltDEB1iw
         3kHj6ibqofRsugGWmnhWo9Or3xp24H5HOhr2xo/6X4Vku+546rQFK/V1IIiru0+7WAun
         WjacOUw7eFBzxeZubK6D7uBildFL/UqATQBFYrXpwuwuuVhGZwv28lGM9er9AV+kxkzE
         pPVFAp3ZLv7h0bmazDuZYnX7LzwPocCip+7c7nnDfEKh8MAvkj9Ra3zbOXc9jRDyGgaz
         7Eezc8Wm49PehQws9gHFvGOdo4xkNBsGe/R/gPb/mAMB7RG9eUaVw+YWU+uWbPe5pdcg
         K9kw==
X-Gm-Message-State: APt69E0XoglaSQcqYY8uo4HT4HCLQZfeyMWikSS1YrU5HazlWTN421rd
        eLYS0Zx/7CuHZ5XA8X04MED21p94h/hhL4TXuag=
X-Google-Smtp-Source: AAOMgpfR85uYLIHadVoLp4inLK/9+SwvhMs/JwELOJXx7qtThuQdq2w3nIdCOp+pFC2OO2y46L5AHBlZoaov4S8AIek=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr23981458iov.203.1530573743364;
 Mon, 02 Jul 2018 16:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180702223143.4663-1-mathieu.desnoyers@efficios.com>
 <CA+55aFxrX+wRoe+5HDaTrRXg1K-Qpks4jJ9Buc_OevoG8hoGFw@mail.gmail.com>
 <415287289.10831.1530572418907.JavaMail.zimbra@efficios.com>
 <CA+55aFzZYOatOtjrm7fD7878_SzCAmEoEu74n0+pgd7faH-sTQ@mail.gmail.com> <825871008.10839.1530573419561.JavaMail.zimbra@efficios.com>
In-Reply-To: <825871008.10839.1530573419561.JavaMail.zimbra@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 16:22:12 -0700
Message-ID: <CA+55aFyQwfXxMnx2WQadfZKAnEfkoT+zomrRRToZz8-uWzUccQ@mail.gmail.com>
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

On Mon, Jul 2, 2018 at 4:17 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Are there any kind of guarantees that a __u64 update on a 32-bit architecture
> won't be torn into something daft like byte-per-byte stores when performed
> from C code ?

Guarantees? No. Not that there are any guarantees that the same won't
happen for a plain 32-bit value either.

Will compilers generate that kind of code? I guess some crazy compiler
could simply be really bad at handling 64-bit values, and just happen
to handle 32-bit values better. So in that sense a 64-bit entity is
certainly a bit riskier. But that would be a really bad compiler, I
have to say.

                Linus
