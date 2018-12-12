Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE4AC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F4A20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="D96pbrvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F4A20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbeLLU34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:29:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38746 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbeLLU34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:29:56 -0500
Received: from zn.tnic (p200300EC2BCDD800543C0EB17EF60A9B.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:d800:543c:eb1:7ef6:a9b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 100951EC096B;
        Wed, 12 Dec 2018 21:29:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544646594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ggmE/5lvHT18ASZGhoGLrs+s6sE8u4CFLciXoiKkWw4=;
        b=D96pbrvlbkg26pDKDjIkrByfsqAgwsPIAQvEwit0vvQ243Pf0DnhB6Zt6OcRiB6TAQvU99
        8RRxI2MmpH2qFTTPgANIEx+OWauOz/K3iuZKnIrYRwElf5VbC7WvtwVM/Sy9slxB333o+S
        ubBJKQJcDd8GUdxsLVJkl1/6bXnaZvg=
Date:   Wed, 12 Dec 2018 21:29:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Tom Lendacky <Thomas.Lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [RFC PATCH 4/4] x86/TSC: Use RDTSCP
Message-ID: <20181212202945.GH6653@zn.tnic>
References: <CALCETrVArfAAbQKJ-g_5pOy6dMVgx-FC_mjdC9xzL1jU9T07jw@mail.gmail.com>
 <59aad362-4a5b-dd8b-642f-0dc3f83cf7ee@amd.com>
 <20181211233901.GV27375@zn.tnic>
 <CALCETrXvZ4avdUh2bTLVTTz3Jxogo3zK5akWTsJ=rkJpf1XiDg@mail.gmail.com>
 <20181212100814.GB6653@zn.tnic>
 <CALCETrWSG5825HrxwEJGqbSoRz=A_2O-GSBD+K_q9YPHu2TB6A@mail.gmail.com>
 <20181212184459.GE6653@zn.tnic>
 <CALCETrXcBa3eUN2okedig+sECnQ8zuSWojahqWLR4vWqD8mEhg@mail.gmail.com>
 <20181212200005.GF6653@zn.tnic>
 <CALCETrWnYT1P0yPRkbubigvYRxesqYi4OJV-YxO9jzWqgCJBdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrWnYT1P0yPRkbubigvYRxesqYi4OJV-YxO9jzWqgCJBdg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 12:09:00PM -0800, Andy Lutomirski wrote:
> Also that the uarch doesn't turn:
> 
> LFENCE
> RDTSC
> load some memory
> 
> into a load followed a cycle later by RDTSC.  If that happened, then
> some cooperating CPUs could observe time going backwards.

How so? Details?

Because I wouldn't be surprised at all if the logical CPUs on the same
node would see actually the same timestamp counter which is propagated
from the northbridge into the cores instead of maintaining it in each
core and having to synchronize it periodically.

But maybe you mean something completely different...

> But RDTSC has no dependencies, so, barring odd register renaming
> effects or similar, this isn't going to be a problem in practice.

Did you talk to hw guys about it? Because I don't see anything blocking
the CPU from reordering those...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
