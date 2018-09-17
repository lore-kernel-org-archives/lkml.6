Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089C2ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47592147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QwFYlP8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47592147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbeIRBlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:41:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36462 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbeIRBk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:40:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id j192-v6so31783wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 13:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7hi3CvN1Nd+o/3PPm1TcDbLUNws5AYaU/jcL5pNHJh4=;
        b=QwFYlP8mE3VKDCStuoKRuGp3vFEVSHw0RWEfFZjkxi9TCw1phRODzPRfFF17QTPpNt
         8Yrsh0MVEqAFgMcy7ptyimKD2hhKFdXhRiZwILcYXdgdu7/B62CXGiEBb+F7ChEQc9Sl
         K0sW6fWCpsIvfK2sUbw+zOY0SgUSuDA+LbBNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7hi3CvN1Nd+o/3PPm1TcDbLUNws5AYaU/jcL5pNHJh4=;
        b=ZUVmE/ZvLs5cYmjahH/fX0BsAHAZ4wyK+lu5MtEU3YYlL8IIbpm2wZWyq6stTu7yRw
         qmu1kjZIkIi3PNWtPea73uSdsgUH5r0fNd7MjKmMcIieljS+TOSHUcrgtA6nGP0nbwVR
         HH64JCJCG0Qmaj1JbE4O4ACGnabPJINQGkIpIz88ohqXlLiWDxPbz8MH+2//p41eqUJC
         5cbPQKuTmRoKH5xQ2CUWwlF0PKjigDghumUhsOoRGCACYzOkKRn8ajCQB/vKK1ZDBPfT
         m/fBpVs6MWz7o5+nwQwXGIujm9j3c5W+rgng483YEOVGOIG1zhPWIvpueaws/M+6m3Ao
         PaQg==
X-Gm-Message-State: APzg51Ccbli0xhq3cEzCazNKI8Lap1Peij0so+jcGYEtqatYQqjRg1y/
        z/KMQuobcqcKcXDd/6HEZ66BD7N9wyYjoChagE0eLg==
X-Google-Smtp-Source: ANB0VdZoLtffyu5AhHRdvJZCRUG7VrGiOiyYlE/uBF+x+m/R/wzUuzChmvLhKdylrwwWbxXSctV/SEgDqVyTPUCI6z4=
X-Received: by 2002:a1c:aa8f:: with SMTP id t137-v6mr11139638wme.54.1537215125150;
 Mon, 17 Sep 2018 13:12:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:a986:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 13:12:04
 -0700 (PDT)
In-Reply-To: <CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com>
References: <20180914125006.349747096@linutronix.de> <20180914125118.909646643@linutronix.de>
 <CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 17 Sep 2018 13:12:04 -0700
Message-ID: <CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com>
Subject: Re: [patch 09/11] x86/vdso: Simplify the invalid vclock case
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 12:25 PM, Andy Lutomirski <luto@kernel.org> wrote:
> On Fri, Sep 14, 2018 at 5:50 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> The code flow for the vclocks is convoluted as it requires the vclocks
>> which can be invalidated separately from the vsyscall_gtod_data sequence to
>> store the fact in a separate variable. That's inefficient.
>>
>
>>  notrace static int do_hres(clockid_t clk, struct timespec *ts)
>>  {
>>         struct vgtod_ts *base = &gtod->basetime[clk];
>>         unsigned int seq;
>> -       int mode;
>> -       u64 ns;
>> +       u64 cycles, ns;
>>
>>         do {
>>                 seq = gtod_read_begin(gtod);
>> -               mode = gtod->vclock_mode;
>>                 ts->tv_sec = base->sec;
>>                 ns = base->nsec;
>> -               ns += vgetsns(&mode);
>> +               cycles = vgetcyc(gtod->vclock_mode);
>> +               if (unlikely((s64)cycles < 0))
>> +                       return vdso_fallback_gettime(clk, ts);
>
> i was contemplating this, and I would suggest one of two optimizations:
>
> 1. have all the helpers return a struct containing a u64 and a bool,
> and use that bool.  The compiler should do okay.
>
> 2. Be sneaky.  Later in the series, you do:
>
>                 if (unlikely((s64)cycles < 0))
>                         return vdso_fallback_gettime(clk, ts);
> -               ns += (cycles - gtod->cycle_last) * gtod->mult;
> +               if (cycles > last)
> +                       ns += (cycles - last) * gtod->mult;
>
> How about:
>
> if (unlikely((s64)cycles <= last)) {
>   if (cycles < 0) [or cycles == -1 or whatever]
>     return vdso_fallback_gettime;
> } else {
>   ns += (cycles - last) * gtod->mult;
> }
>
> which should actually make this whole mess be essentially free.
>
> Also, I'm not entirely convinced that this "last" thing is needed at
> all.  John, what's the scenario under which we need it?

So my memory is probably a bit foggy, but I recall that as we
accelerated gettimeofday, we found that even on systems that claimed
to have synced TSCs, they were actually just slightly out of sync.
Enough that right after cycles_last had been updated, a read on
another cpu could come in just behind cycles_last, resulting in a
negative interval causing lots of havoc.

So the sanity check is needed to avoid that case.

thanks
-john
