Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B0FC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC8F20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdC899Ki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC8F20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeJDX5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:57:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbeJDX5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:57:10 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01EDF2147C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Oct 2018 17:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538672582;
        bh=ol8BHC63Ir3s0RKsDIqa25WPm1fThf+YjqMxf1oWjOo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GdC899KiS21jVyEHghYNKi3IKyckyj9wm2YkHDiinh/FWCRsupEG6JDKpPI0y+OEq
         GU6YnwMvluEcRtyRvLV72RFpr1lG9zCiwCUsoRays7PnUwObMdl+VXNMXZO0NsPJW8
         N9YA+ipIQcUmR/NTlt6BT+DijZf1PGFMVb9jEfF4=
Received: by mail-wr1-f53.google.com with SMTP id w5-v6so10737932wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 10:03:01 -0700 (PDT)
X-Gm-Message-State: ABuFfojcckdndQarsSqi5+A4lHGsACHYoESGuU6daDYEgvcO6BjieZ9d
        bJRD8FI6IVzVI/ivZv6LLmuLplQwpDsF2Vr8GBPXEw==
X-Google-Smtp-Source: ACcGV61G37sjPsIyGkqT8CZvYYRkwbny8YTrHzxVaMgPNSj33jYP3CLOx3Wrgt9AN37ewn9Tu+Vg8bDczGMknijSv/Y=
X-Received: by 2002:adf:b188:: with SMTP id q8-v6mr5516838wra.95.1538672580381;
 Thu, 04 Oct 2018 10:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20181004045948.129142-1-namit@vmware.com> <72B0B378-9515-47C4-8937-9F1E823DD236@amacapital.net>
 <CE9C4B9C-3B11-45D0-812A-F074D687084D@vmware.com>
In-Reply-To: <CE9C4B9C-3B11-45D0-812A-F074D687084D@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 4 Oct 2018 10:02:48 -0700
X-Gmail-Original-Message-ID: <CALCETrVkE9eV0b2-wfq4Y9iK+YVJ4JBL7_rk_A8-7EhtuBbncA@mail.gmail.com>
Message-ID: <CALCETrVkE9eV0b2-wfq4Y9iK+YVJ4JBL7_rk_A8-7EhtuBbncA@mail.gmail.com>
Subject: Re: [RFC] x86/cpu_entry_area: move part of it back to fixmap
To:     Nadav Amit <namit@vmware.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 9:31 AM Nadav Amit <namit@vmware.com> wrote:
>
> at 7:11 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>
> >
> >
> > On Oct 3, 2018, at 9:59 PM, Nadav Amit <namit@vmware.com> wrote:
> >
> >> This RFC proposes to return part of the entry-area back to the fixmap =
to
> >> improve system-call performance. Currently, since the entry-area is
> >> mapped far (more than 2GB) away from the kernel text, an indirect bran=
ch
> >> is needed to jump from the trampoline into the kernel. Due to Spectre
> >> v2, vulnerable CPUs need to use a retpoline, which introduces an
> >> overhead of >20 cycles.
> >
> > That retpoline is gone in -tip. Can you see how your code stacks up aga=
inst -tip?  If it=E2=80=99s enough of a win to justify the added complexity=
, we can try it.
> >
> > You can see some pros and cons in the changelog:
> >
> > https://git.kernel.org/tip/bf904d2762ee6fc1e4acfcb0772bbfb4a27ad8a6
>
> Err.. That=E2=80=99s what I get for not following lkml. Very nice discuss=
ion.
> Based on it, I may be able to do an additional micro-optimizations or
> two. Let me give it a try.
>

I think you should at least try to benchmark your code against mine,
since you more or less implemented the alternative I suggested. :)
