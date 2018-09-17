Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B5CECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECAFA214FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8mlRCB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECAFA214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeIRAyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 20:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbeIRAyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 20:54:44 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14795214FE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 19:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537212360;
        bh=Lv+GLupaRo5hCP9HnNMyUrPg84YJuzARl2Fo3aXm3I8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=N8mlRCB8Hwl0tqBme45Fv0emymouOnnhBP8WWS2z6Tph2XN1FGzpWaDZaF5820JMM
         xZ3qV+7rr+u6+of2xGZC+xnC/rjWeYoysNwN4idz+XFFquzI/iPVmJBYXX/c5MMdCT
         dN0o4pFQLQgkng5dCeP6XRaIHUxitvbuNlYmnwS4=
Received: by mail-wm1-f52.google.com with SMTP id c14-v6so10928058wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 12:26:00 -0700 (PDT)
X-Gm-Message-State: APzg51CYjpvdml85S9pUWnW4H6zPV6j8GLY7AOUcyCOcGXzaAq0ia5Mt
        CpuS3E7GitdUkYP9Zr01CwkFne5pWJz1Cdu8ktxIsw==
X-Google-Smtp-Source: ANB0VdatiCtrRBAEXx1fvTTo4TksfrETU4sUIxl0JmAQqF6W65na63uItz0WgyuskT6iZ+PRj/kXTGZZHXN77Hn3ips=
X-Received: by 2002:a1c:8a04:: with SMTP id m4-v6mr12554970wmd.137.1537212358434;
 Mon, 17 Sep 2018 12:25:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7810:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 12:25:38
 -0700 (PDT)
In-Reply-To: <20180914125118.909646643@linutronix.de>
References: <20180914125006.349747096@linutronix.de> <20180914125118.909646643@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 17 Sep 2018 12:25:38 -0700
X-Gmail-Original-Message-ID: <CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com>
Message-ID: <CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com>
Subject: Re: [patch 09/11] x86/vdso: Simplify the invalid vclock case
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
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

On Fri, Sep 14, 2018 at 5:50 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> The code flow for the vclocks is convoluted as it requires the vclocks
> which can be invalidated separately from the vsyscall_gtod_data sequence to
> store the fact in a separate variable. That's inefficient.
>

>  notrace static int do_hres(clockid_t clk, struct timespec *ts)
>  {
>         struct vgtod_ts *base = &gtod->basetime[clk];
>         unsigned int seq;
> -       int mode;
> -       u64 ns;
> +       u64 cycles, ns;
>
>         do {
>                 seq = gtod_read_begin(gtod);
> -               mode = gtod->vclock_mode;
>                 ts->tv_sec = base->sec;
>                 ns = base->nsec;
> -               ns += vgetsns(&mode);
> +               cycles = vgetcyc(gtod->vclock_mode);
> +               if (unlikely((s64)cycles < 0))
> +                       return vdso_fallback_gettime(clk, ts);

i was contemplating this, and I would suggest one of two optimizations:

1. have all the helpers return a struct containing a u64 and a bool,
and use that bool.  The compiler should do okay.

2. Be sneaky.  Later in the series, you do:

                if (unlikely((s64)cycles < 0))
                        return vdso_fallback_gettime(clk, ts);
-               ns += (cycles - gtod->cycle_last) * gtod->mult;
+               if (cycles > last)
+                       ns += (cycles - last) * gtod->mult;

How about:

if (unlikely((s64)cycles <= last)) {
  if (cycles < 0) [or cycles == -1 or whatever]
    return vdso_fallback_gettime;
} else {
  ns += (cycles - last) * gtod->mult;
}

which should actually make this whole mess be essentially free.

Also, I'm not entirely convinced that this "last" thing is needed at
all.  John, what's the scenario under which we need it?

--Andy

--Andy
