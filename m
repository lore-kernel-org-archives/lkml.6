Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2CDC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6A120894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0Qtz4jc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6A120894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbeG3V0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:26:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727474AbeG3V0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:26:08 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0881B208A4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 19:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532980175;
        bh=SotUQrJOELAFN9wB6Ip+Qb1yHoerjziQ1jLvoClnwf0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=0Qtz4jc0KwPOxS8sLk6sfshBXWLzO+IDUGrg7p11LZ8XoBTy7OtTqWMCuzS/pbux6
         jxPnxOpyIhDvH84Q96GBXMR7RT8Pp20pR/Y++LGMsEgpJhyDeMV4dBm1C/7azSlpkR
         vlSdi+98PkCjldDZsWvpvGzn0cRhIdTYJvPd0Fmw=
Received: by mail-wr1-f42.google.com with SMTP id e7-v6so14120882wrs.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 12:49:34 -0700 (PDT)
X-Gm-Message-State: AOUpUlFt6N2ghYpSp1eln8UcfJcH/G76K7kbTa3LJ7f0XppnrLoyTFnp
        DJ+mAUvvGdDw9/aDxR3RNHwdHYlHZjmPdpFZ8Yktdg==
X-Google-Smtp-Source: AAOMgpcT28ofYo37cPC8aSgs1BZlDkwKHAyV4pgMxHnzjxQ/II/Adw4uxxDhT+vmgUiqJoKmLWQHPtvVb7X50iPxozA=
X-Received: by 2002:adf:fe42:: with SMTP id m2-v6mr18214325wrs.171.1532980173491;
 Mon, 30 Jul 2018 12:49:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 12:49:12 -0700 (PDT)
In-Reply-To: <1532979368.28585.33.camel@surriel.com>
References: <20180728215357.3249-1-riel@surriel.com> <20180728215357.3249-11-riel@surriel.com>
 <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com>
 <20180729155452.37eddc11@imladris.surriel.com> <20180730095502.GG2494@hirez.programming.kicks-ass.net>
 <1532961011.28585.30.camel@surriel.com> <20180730162653.GM2494@hirez.programming.kicks-ass.net>
 <1532978146.28585.32.camel@surriel.com> <CALCETrXZPN6Lt55siHM__YW4jFfoy5w+Hd2aJtEi8qhsro6RMA@mail.gmail.com>
 <1532979368.28585.33.camel@surriel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 30 Jul 2018 12:49:12 -0700
X-Gmail-Original-Message-ID: <CALCETrXnG9nPzJKOtd=65BWeoTs2y=mVUAEvNGmFrD8fvg-EfQ@mail.gmail.com>
Message-ID: <CALCETrXnG9nPzJKOtd=65BWeoTs2y=mVUAEvNGmFrD8fvg-EfQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] mm,sched: conditionally skip lazy TLB mm refcounting
To:     Rik van Riel <riel@surriel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 12:36 PM, Rik van Riel <riel@surriel.com> wrote:
> On Mon, 2018-07-30 at 12:30 -0700, Andy Lutomirski wrote:
>> On Mon, Jul 30, 2018 at 12:15 PM, Rik van Riel <riel@surriel.com>
>> wrote:
>> > On Mon, 2018-07-30 at 18:26 +0200, Peter Zijlstra wrote:
>> > > On Mon, Jul 30, 2018 at 10:30:11AM -0400, Rik van Riel wrote:
>> > >
>> > > > > What happened to the rework I did there? That not only
>> > > > > avoided
>> > > > > fiddling
>> > > > > with active_mm, but also avoids grab/drop cycles for the
>> > > > > other
>> > > > > architectures when doing task->kthread->kthread->task things.
>> > > >
>> > > > I don't think I saw that. I only saw your email from
>> > > > July 20th with this fragment of code, which does not
>> > > > appear to avoid the grab/drop cycles, and still fiddles
>> > > > with active_mm:
>> > >
>> > > Yeah, that's it. Note how it doesn't do a grab+drop for kernel-
>> > > > kernel,
>> > >
>> > > where the current could would have.
>> > >
>> > > And also note that it only fiddles with active_mm if it does the
>> > > grab+drop thing (the below should have s/ifdef/ifndef/ to make
>> > > more
>> > > sense maybe).
>> >
>> > I'll kick off a test with your variant. I don't think we
>> > will see any performance difference on x86 (due to not
>> > using a refcount at all any more), but unless Ingo is in
>> > a hurry I guess there's no issue rewriting this part of
>> > the patch series :)
>> >
>> > Do the other patches look ok to you and Andy?
>> >
>>
>> The whole series other than the active_mm stuff looked okay to me.
>
> Does the active_mm stuff look like a step in the right
> direction with the bugfix, or would you prefer the code
> to go in an entirely different direction?

I think it's a big step in the right direction, but it still makes be
nervous.  I'd be more comfortable with it if you at least had a
functional set of patches that result in active_mm being gone, because
that will mean that you actually audited the whole mess and fixed
anything that might rely on active_mm pointing somewhere or that might
be putting a value you didn't take into account into active_mm.  IOW
I'm not totally thrilled by applying the patches as is if we're still
a bit unsure as to what might have gotten missed.

I don't think it's at all necessary to redo the patches.

Does that seem reasonable?

>
> If this looks like a step in the right direction, it
> may make sense to make this step before the merge window
> opens, and continue with more patches in this direction
> later.
>
> --
> All Rights Reversed.
