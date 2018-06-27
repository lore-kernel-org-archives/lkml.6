Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713F7C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11502678E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkyDhocs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11502678E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934487AbeF0At1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 20:49:27 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:41531 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbeF0AtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 20:49:24 -0400
Received: by mail-ot0-f194.google.com with SMTP id d19-v6so324148oti.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 17:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eWT0iF/ykrSv5vam1wDrdkYPZ0e8GpaGQ6zY5l3Aoc0=;
        b=jkyDhocsFVgs/Pl9QJ32q0uNIb3HDy4lCuRi2q1+f5gR1YCP5nBZiy9uyzEGIXzoNw
         lTBrmpFr/JmuXirMU10OqX6JSukRpFwn4EhO6vWYtSJu8Okt8T24mAIYm/lSvhq5onQE
         sDgC0FpZQXnK9m1srsdIFxAsvqtC2zqvuRZIqazxDdvFxe0W490qac6DnM/8r3WeD9Bz
         4rZij47OVdjLmI0InFMr5BlkR5Sc7ZOb7kQI/nrHCRWcXh7LIZco6b/ei2tCGVTmJrZO
         LEcwdDTSr1cCdPXQm/ik77cPE6W25nkAKx4w/rCs0BdprwS2q/ignwiOu3yS5VmXkq4X
         MSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eWT0iF/ykrSv5vam1wDrdkYPZ0e8GpaGQ6zY5l3Aoc0=;
        b=CFWkvQWCeKm4tDEK5rnTyhEBQ5KVq55T35j3xZoC4idBjPct8E7pvM4/dpkj9cPp9a
         sp7K+FvCWBE3/8j6e2MM6rMBzAwHui0CgDG7obI83maZBtkrw4MzqideT0znhwswNLQp
         NIzZQu/DhL0OrrG0hnVo0GIDKQNBbTGC1FayTp3ELAFC0GoaCIVccDCwBtpNasUxWln4
         sWNjs6tMXelV+IElKy/q0MZK5Qo+A4ep2h9YH8ovCnxNOqtyp6VaaE6h9V0nAyCzXAgK
         FMfYaIhPpZIXO5RkRABEECUzhmBFra/ezFznqmRMYEA2cJqSPv8xk7VZQ9u1Pf5vXVrW
         Q0cQ==
X-Gm-Message-State: APt69E3M6o/eTMJEEcWD7orcWQuWUkz5W+xuHa5uIXQ16MNWB4+4VxbD
        WWa38Zyek4A20cGcj9r6heScbkNqxG6fEEbqv8g=
X-Google-Smtp-Source: AAOMgpcyu4KYlhI3J20yPUpekPqCZO7lo8O2aVuJuVuzGeuwS/F1vfPde1r1ig9I6dt6+KhsOR106bz+ySHnQsT75pM=
X-Received: by 2002:a9d:419c:: with SMTP id p28-v6mr2361030ote.2.1530060564308;
 Tue, 26 Jun 2018 17:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180622170625.30688-1-vkuznets@redhat.com>
In-Reply-To: <20180622170625.30688-1-vkuznets@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Wed, 27 Jun 2018 08:49:08 +0800
Message-ID: <CANRm+CwNfOkosECeSGaXXDaqTDvh1u228ztU8C5Xe95FGgNsFQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] x86/hyper-v: optimize PV IPIs
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        devel@linuxdriverproject.org, LKML <linux-kernel@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tianyu.Lan@microsoft.com,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitaly, (fix my reply mess this time)
On Sat, 23 Jun 2018 at 01:09, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> When reviewing my "x86/hyper-v: use cheaper HVCALL_FLUSH_VIRTUAL_ADDRESS_
> {LIST,SPACE} hypercalls when possible" patch Michael suggested to apply the
> same idea to PV IPIs. Here we go!
>
> Despite what Hyper-V TLFS says about HVCALL_SEND_IPI hypercall, it can
> actually be 'fast' (passing parameters through registers). Use that too.
>
> This series can collide with my "KVM: x86: hyperv: PV IPI support for
> Windows guests" series as I rename ipi_arg_non_ex/ipi_arg_ex structures
> there. Depending on which one gets in first we may need to do tiny
> adjustments.

As hyperv PV TLB flush has already been merged, is there any other
obvious multicast IPIs scenarios? qemu supports interrupt remapping
since two years ago, I think windows guest can switch to cluster mode
after entering x2APIC, so sending IPI per cluster. In addition, you
can also post the benchmark result for this PV IPI optimization,
although it also fixes the bug which you mentioned above.

I can post one variant for Linux guest PV IPI if it also makes sense. :)

Regards,
Wanpeng Li
