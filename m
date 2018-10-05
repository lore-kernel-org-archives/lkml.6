Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574FAC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4BD208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5DVC8zt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4BD208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbeJFFLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 01:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbeJFFLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 01:11:34 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40C9A21479
        for <linux-kernel@vger.kernel.org>; Fri,  5 Oct 2018 22:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538777451;
        bh=OT51Cl0fHtT/qzIbEubgRMTMGIgd1EHPmCzfLKMih4U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m5DVC8ztAIZzV5IfVXmBFMnWa/wNJz2q7jWaK8ogulSgZUHJU1OF4vESXPHF4WxF8
         TNqa+FZM0nR/XJvPZZooNnIpxvh3ouYw4wjZAPgPnStRxxc89I0bxpcy1YIjgjBk1p
         znyf4ICB+cIBGbJInSgGing0NJ0jR2RtsdO3+a3U=
Received: by mail-wr1-f42.google.com with SMTP id a13-v6so14940378wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 15:10:51 -0700 (PDT)
X-Gm-Message-State: ABuFfogPhMI1xkqtnlUjUSSI2M2nyV8HE3cXxgTQJHSl/SfXR8A8p9+Q
        8liJDGVqEHm4mZrqt+0RCzljTiyQ5GZwsXSVsQJp+A==
X-Google-Smtp-Source: ACcGV63wF0KfcfgMcZHLlmZX+W14moNV7/sFOheS1fftTxRtWMO4v3F2PNUfyKpjXy79crAALDwvo12gq4qtpKqM9qI=
X-Received: by 2002:adf:82e3:: with SMTP id 90-v6mr9147900wrc.131.1538777449643;
 Fri, 05 Oct 2018 15:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181004045948.129142-1-namit@vmware.com> <72B0B378-9515-47C4-8937-9F1E823DD236@amacapital.net>
 <CE9C4B9C-3B11-45D0-812A-F074D687084D@vmware.com> <CALCETrVkE9eV0b2-wfq4Y9iK+YVJ4JBL7_rk_A8-7EhtuBbncA@mail.gmail.com>
 <2A4D16C3-CBE2-490F-8C7A-F5FE437ACC34@vmware.com>
In-Reply-To: <2A4D16C3-CBE2-490F-8C7A-F5FE437ACC34@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 5 Oct 2018 15:10:38 -0700
X-Gmail-Original-Message-ID: <CALCETrUnN-sQErp+q=RZU-9Gwg6GaDaoQzSjNv2=hcLej3NfsQ@mail.gmail.com>
Message-ID: <CALCETrUnN-sQErp+q=RZU-9Gwg6GaDaoQzSjNv2=hcLej3NfsQ@mail.gmail.com>
Subject: Re: [RFC] x86/cpu_entry_area: move part of it back to fixmap
To:     Nadav Amit <namit@vmware.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 3:08 PM Nadav Amit <namit@vmware.com> wrote:
>
> at 10:02 AM, Andy Lutomirski <luto@kernel.org> wrote:
>
> > On Thu, Oct 4, 2018 at 9:31 AM Nadav Amit <namit@vmware.com> wrote:
> >> at 7:11 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> >>
> >>> On Oct 3, 2018, at 9:59 PM, Nadav Amit <namit@vmware.com> wrote:
> >>>
> >>>> This RFC proposes to return part of the entry-area back to the fixma=
p to
> >>>> improve system-call performance. Currently, since the entry-area is
> >>>> mapped far (more than 2GB) away from the kernel text, an indirect br=
anch
> >>>> is needed to jump from the trampoline into the kernel. Due to Spectr=
e
> >>>> v2, vulnerable CPUs need to use a retpoline, which introduces an
> >>>> overhead of >20 cycles.
> >>>
> >>> That retpoline is gone in -tip. Can you see how your code stacks up a=
gainst -tip?  If it=E2=80=99s enough of a win to justify the added complexi=
ty, we can try it.
> >>>
> >>> You can see some pros and cons in the changelog:
> >>>
> >>> https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
t.kernel.org%2Ftip%2Fbf904d2762ee6fc1e4acfcb0772bbfb4a27ad8a6&amp;data=3D02=
%7C01%7Cnamit%40vmware.com%7C9996b2dd6f1745dce10b08d62a1b3f3e%7Cb39138ca3ce=
e4b4aa4d6cd83d9dd62f0%7C1%7C0%7C636742693864878787&amp;sdata=3DNW0R%2Fv5Oah=
ZlTbbNgnFk20sF4Wt1W0MDjtv9g1k%2BWdg%3D&amp;reserved=3D0
> >>
> >> Err.. That=E2=80=99s what I get for not following lkml. Very nice disc=
ussion.
> >> Based on it, I may be able to do an additional micro-optimizations or
> >> two. Let me give it a try.
> >
> > I think you should at least try to benchmark your code against mine,
> > since you more or less implemented the alternative I suggested. :)
>
> That=E2=80=99s what I meant. So I made a couple of tweaksin my implementa=
tion to
> make as performant as possible. Eventually, there is a 2ns benefit for th=
e
> trampoline over the unified entry-path on average on my Haswell VM (254ns=
 vs
> 256ns), yet there is some variance (1.2 & 1.5ns stdev correspondingly).
>
> I don=E2=80=99t know whether such a difference should make one option to =
be preferred
> over the other. I think it boils down to whether:
>
> 1. KASLR is needed.

Why?  KASLR is basically worthless on any existing CPU against
attackers who can run local code.

>
> 2. Can you specialize the code-paths of trampoline/non-trampoline to gain
> better performance. For example, by removing the ALTERNATIVE from
> SWITCH_TO_KERNEL_CR3 and not reload CR3 on the non-trampoline path, you c=
an
> avoid an unconditional jmp on machines which are not vulnerable to Meltdo=
wn.
>
> So I can guess what you=E2=80=99d prefer. Let=E2=80=99s see if I=E2=80=99=
m right.
>

2 ns isn't bad, at least on a non-PTI system.  Which, I suppose, means
that you should benchmark on AMD :)

If the code is reasonably clean, I could get on board.
