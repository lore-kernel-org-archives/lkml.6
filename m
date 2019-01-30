Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84DFC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BA42184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388147AbfA3Vab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:30:31 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35143 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732048AbfA3Vaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:30:30 -0500
Received: by mail-qk1-f195.google.com with SMTP id w204so695859qka.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 13:30:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uY8T3GlPQudUWKbMemLAjOad846iQpF0yrDVmtvchx4=;
        b=prUwiIUriFOXGr5AWnu+6eaxa4BBrqixoBJHr+srYUKrnOEj58eg85dP7/p9oI1O8W
         qsIU2vGIZdlv8uR7i6osM5gpmDqWmCcGn6FBCQIVMFJTvvxPukANhUXYY9aJ9nLwxXmZ
         m1MleVDeT4e5l7UFR+w5rr4bNX2CxHLNPnVMAD9I4mbCEJhslrf80C4gY8wkHOA/3MRv
         2DC3xacjDZroHs2pzZsM8SxS6pqwO8xn7J9xpoBGdxNaB5C7zXGzVQ8YtJz1q/ov6EM9
         hSK3B+kqOjpBqJGaGHc8XTTXfhhGzvQ0OVc2uak1vbE6KysrXjCNYXI1tilrdEFaYKka
         Wjuw==
X-Gm-Message-State: AJcUukddnlAiGyhaOonBbC0iEPMg2bcKUGWNPLUegZ8Clxb5JdYGr095
        BSAF8lkmLu7HkZxUflyp3Da5S6p5OmKfpfoFf+I=
X-Google-Smtp-Source: ALg8bN4oo9v6azmI6+LemsgLtoZOvdHjKhdbTVy81pdrf3aW/xDiV+JdmfV5CPQvA98X3QTL+cVbQ5c5Y2ghEQ8ZW+A=
X-Received: by 2002:a37:9a89:: with SMTP id c131mr29322048qke.173.1548883829455;
 Wed, 30 Jan 2019 13:30:29 -0800 (PST)
MIME-Version: 1.0
References: <20181217150326.30933-1-anders.roxell@linaro.org>
 <8bc73bbf-6c12-7fd1-3253-676731bf5ae5@virtuozzo.com> <20190129173634.ee579795b227b141efc8bd30@linux-foundation.org>
 <2370bfbc-762f-fb3f-79b1-483a095fdf7c@virtuozzo.com>
In-Reply-To: <2370bfbc-762f-fb3f-79b1-483a095fdf7c@virtuozzo.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 30 Jan 2019 22:30:12 +0100
Message-ID: <CAK8P3a1ZKyaDUjz3Zvxr0REQxyu8vWGHAbpfJ=w_XGyohe2bnw@mail.gmail.com>
Subject: Re: [PATCH] lib/ubsan: default UBSAN_ALIGNMENT to not set
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 6:12 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> On 1/30/19 4:36 AM, Andrew Morton wrote:
> > On Fri, 11 Jan 2019 22:01:16 +0300 Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> >> On 12/17/18 6:03 PM, Anders Roxell wrote:
> >>> When booting an allmodconfig kernel, there are a lot of false-positives.
> >>> With a message like this 'UBSAN: Undefined behaviour in...' with a call
> >>> trace that follows.
> >>>
> >>> Reworked so that when building a allmodconfig kernel that turns
> >>> everything into '=m' or '=y' will turn off UBSAN_ALIGNMENT.
> >>>
> >>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> >>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> >>> ---
> >>
> >> Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> >>
> >
> > Confused.  Why does allmodconfig result in UBSAN warnings?
> >
>
> UBSAN warnings is a result of enabling noisy CONFIG_UBSAN_ALIGNMENT which is disabled
> by default if HAVE_EFFICIENT_UNALIGNED_ACCESS=y.
> It's noisy even if don't have efficient unaligned access, e.g. people often add
>  __cacheline_aligned_in_smp in structs, but forget to align allocations of such struct
> (kmalloc() give 8-byte alignment in worst case).

That would be a fixable issue, but there is another one that I looked at
with Anders: We have a number of list_for_each_entry_safe() loops
that use a list_head on the stack and add objects of a type with
large alignment. When list_for_each_entry_safe() gets to the end of
that list, it sees a pointer to an unaligned structure starting  few bytes
before the list_head on stack. The only element of that structure that
is ever used is that list_head, so there is no actual problem, but the
warning triggers nonetheless.

      Arnd
