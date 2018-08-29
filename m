Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9100C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704F52064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+Mojrlj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704F52064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbeH2UMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:12:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbeH2UMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:12:02 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7A9A20676
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 16:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535559263;
        bh=nOF8DzPeeNxXqdzpwiOb8cgeHKppQzTV+WqFCOyyxpw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=t+MojrljNpPF/pr5Zto1ytzQ6L4u23P2OGvsgxldZAuNNe9GhFBsTqIQxOzeTSq3D
         QYcBT2nGv2RC6kfyhTobraEO2Ebd3YwM/LsUNa0EqTwYJmKwcZBYHj3PP+6n5ojbf9
         ijEhmiRAICIkPfAT6rMGJ2+4bb7FYlZkr7Q92Cf8=
Received: by mail-wr1-f41.google.com with SMTP id m27-v6so5386365wrf.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 09:14:22 -0700 (PDT)
X-Gm-Message-State: APzg51A3Z0VSJg9cLyFf1sG+Op0MYm3Rp7Zoi62aX98bURjCsi8JOEx+
        dSaVgxj48VhOngJbERniK5xaJzHAJMZZywTi/oMr1w==
X-Google-Smtp-Source: ANB0VdbO0/K/+FTqxhQubw1aVORKeked6QIJ1RXbhvrf6roKNGOPiUBEeuwOLvgoJN0S0GDyYZK/WefNtD/a8Xedv1U=
X-Received: by 2002:adf:c98d:: with SMTP id f13-v6mr4988120wrh.148.1535559261209;
 Wed, 29 Aug 2018 09:14:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Wed, 29 Aug 2018 09:14:00 -0700 (PDT)
In-Reply-To: <041532109326b7bd3e67087808fee9d3289f9682.camel@surriel.com>
References: <c7ee1ee7a1b8d17743f7c3680ea5d2c32bf3e897.1535410956.git.luto@kernel.org>
 <20180828135647.6d516048@imladris.surriel.com> <CALCETrX2v_g_+TpX1DEZasHGi=8Y3w3ka=yYEaTxgFDnPy67nw@mail.gmail.com>
 <e9d62b33d43f99570b14c73e1519b13021ea3a95.camel@surriel.com>
 <CALCETrXjH175OLPRCwA8=Stbq1KmJwwvkZ36Y74=hF_i8GFWCw@mail.gmail.com> <041532109326b7bd3e67087808fee9d3289f9682.camel@surriel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 29 Aug 2018 09:14:00 -0700
X-Gmail-Original-Message-ID: <CALCETrXnomJYQkm5o87TodxA8F2eJHu0Hir0hUR_i8f0snFPqA@mail.gmail.com>
Message-ID: <CALCETrXnomJYQkm5o87TodxA8F2eJHu0Hir0hUR_i8f0snFPqA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/nmi: Fix some races in NMI uaccess
To:     Rik van Riel <riel@surriel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 8:49 AM, Rik van Riel <riel@surriel.com> wrote:
> On Wed, 2018-08-29 at 08:36 -0700, Andy Lutomirski wrote:
>> On Wed, Aug 29, 2018 at 8:17 AM, Rik van Riel <riel@surriel.com>
>> wrote:
>> > On Tue, 2018-08-28 at 20:46 -0700, Andy Lutomirski wrote:
>> > > On Tue, Aug 28, 2018 at 10:56 AM, Rik van Riel <riel@surriel.com>
>> > > wrote:
>> > > > On Mon, 27 Aug 2018 16:04:16 -0700
>> > > > Andy Lutomirski <luto@kernel.org> wrote:
>> > > >
>> > > > > The 0day bot is still chewing on this, but I've tested it a
>> > > > > bit
>> > > > > locally
>> > > > > and it seems to do the right thing.
>> > > >
>> > > > Hi Andy,
>> > > >
>> > > > the version of the patch below should fix the bug we talked
>> > > > about
>> > > > in email yesterday.  It should automatically cover kernel
>> > > > threads
>> > > > in lazy TLB mode, because current->mm will be NULL, while the
>> > > > cpu_tlbstate.loaded_mm should never be NULL.
>> > > >
>> > >
>> > > That's better than mine.  I tweaked it a bit and added some
>> > > debugging,
>> > > and I got this:
>> > >
>> > >
>> >
>> >
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/fixes&id=dd956eba16646fd0b15c3c0741269dfd84452dac
>> > >
>> > > I made the loaded_mm handling a little more conservative to make
>> > > it
>> > > more obvious that switch_mm_irqs_off() is safe regardless of
>> > > exactly
>> > > when it gets called relative to switching current.
>> >
>> > I am not convinced that the dance of writing
>> > cpu_tlbstate.loaded_mm twice, with a barrier on
>> > each end, is useful or necessary.
>> >
>> > At the time switch_mm_irqs_off returns, nmi_uaccess_ok()
>> > will still return false, because we have not switched
>> > "current" to the task that owns the next mm_struct yet.
>> >
>> > We just have to make sure to:
>> > 1) Change cpu_tlbstate.loaded_mm before we manipulate
>> >    CR3, and
>> > 2) Change "current" only once enough of the mm stuff has
>> >    been switched, __switch_to seems to get that right.
>> >
>> > Between the time switch_mm_irqs_off() sets cpu_tlbstate
>> > to the next mm, and __switch_to moves() over current,
>> > nmi_uaccess_ok() will return false.
>>
>> All true, but I think it stops working as soon as someone starts
>> calling switch_mm_irqs_off() for some other reason, such as during
>> text_poke().  And that was the original motivation for this patch.
>
> How does calling switch_mm_irqs_off() for text_poke()
> change around current->mm and cpu_tlbstate.loaded_mm?
>
> Does current->mm stay the same throughout the entire
> text_poke() chain, while cpustate.loaded_mm is the
> only thing that is changed out?

This is exactly what happens.  It seemed considerably more complicated
and error-prone to fiddle with current->mm.  Instead the idea was to
turn off IRQs, get NMI to stay out of the way, and put everything back
the way it was before the scheduler, any syscalls, etc could notice
that we were messing around.

--Andy
