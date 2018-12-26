Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCD3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 15:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F972054F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 15:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nm5ZwGWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeLZPcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 10:32:12 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33022 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbeLZPcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 10:32:11 -0500
Received: by mail-io1-f65.google.com with SMTP id t24so12529932ioi.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 07:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VNidTVK9BknK48wMc2d/FhziRGCtZRNJAoalJxL7/b4=;
        b=Nm5ZwGWJMdkqCjEVY+whgnyQ+MTEuI/TPc20xQ+nY6GSGgEmNZusZIG/7FYK4nXKrD
         6rblYMPJpq13TXO9Fx/2aPiAYB5p5RaJVdbwBoJcQ6O53Q9+9yyHIhzSy2CC9BYQdLJF
         nn/Uer+CS8PECw2iNj8l4XJ85zY3S4ounApvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNidTVK9BknK48wMc2d/FhziRGCtZRNJAoalJxL7/b4=;
        b=n/qJdicz445RPCZDP16A0/+XWob7YXr0pO8i0Hf+HTJilRCqns0+CZZuGmgxCQGmaW
         W9qy+rrLPbmefv8qaujTwuSQO3tbu7ONOe6d/GX97x4CgCG6WLNCzE0b6PXsQUl998lc
         T12P9MyPgqJKcyvqluOM6aog8o2jkwZqp1DFWrPTcHeUdSJoQJMuMyxjDKyBy5uJEQRl
         +waPYnYrTTKZTQP4FPfiL71ytGW+Nzs63RtoEEtuGL9XnuNtaZivNo3M2No2Suil5H2x
         xzLeoFCIz23pKk+uFS2Zk95M+R/zfUWtCbr6zC6fQv6I8hcZvM2mzAF9lZDFWbzzeBb9
         kCRw==
X-Gm-Message-State: AJcUukeNrK74GRRv/eiAHRsG4mLuAK/XFVvKeS0dfuGUbfvU6ec53HGL
        yGbE5iueSAjLALaTYww4UqqgFWWjPxvJRyhTUPBHNA==
X-Google-Smtp-Source: ALg8bN71ryeAV+qhfPw9GFhJo3aKcTrOxuxSO1CaHSSYuptFZmyAyO2hjX80J2gNwnyQQiYLF4gdKSIOIFiZrCgVHME=
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr13163263iob.170.1545838330629;
 Wed, 26 Dec 2018 07:32:10 -0800 (PST)
MIME-Version: 1.0
References: <20181226023534.64048-1-cai@lca.pw> <CAKv+Gu_fiEDffKq_fONBYTOdSk-L7__+LgNEyVaNF3FGzBfAow@mail.gmail.com>
 <403405f1-b702-2feb-4616-35fc3dc3133e@lca.pw>
In-Reply-To: <403405f1-b702-2feb-4616-35fc3dc3133e@lca.pw>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 26 Dec 2018 16:31:59 +0100
Message-ID: <CAKv+Gu_e=NkKZ5C+KzBmgg2VMXNKPqXcPON8heRd0F_iW+aaEQ@mail.gmail.com>
Subject: Re: [PATCH -mmotm] efi: drop kmemleak_ignore() for page allocator
To:     Qian Cai <cai@lca.pw>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Dec 2018 at 16:13, Qian Cai <cai@lca.pw> wrote:
>
> On 12/26/18 7:02 AM, Ard Biesheuvel wrote:
> > On Wed, 26 Dec 2018 at 03:35, Qian Cai <cai@lca.pw> wrote:
> >>
> >> a0fc5578f1d (efi: Let kmemleak ignore false positives) is no longer
> >> needed due to efi_mem_reserve_persistent() uses __get_free_page()
> >> instead where kmemelak is not able to track regardless. Otherwise,
> >> kernel reported "kmemleak: Trying to color unknown object at
> >> 0xffff801060ef0000 as Black"
> >>
> >> Signed-off-by: Qian Cai <cai@lca.pw>
> >
> > Why are you sending this to -mmotm?
> >
> > Andrew, please disregard this patch. This is EFI/tip material.
>
> Well, I'd like to primarily develop on the -mmotm tree as it fits in a
> sweet-spot where the mainline is too slow and linux-next is too chaotic.
>
> The bug was reproduced and the patch was tested on -mmotm. If for every bugs
> people found in -mmtom, they have to check out the corresponding sub-system tree
> and reproduce/verify the bug over there, that is quite a burden to bear.
>

Yes. But you know what? We all have our burden to bear, and shifting
this burden to someone else, in this case the subsystem maintainer who
typically deals with a sizable workload already, is not a very nice
thing to do.

> That's why sub-system maintainers are copied on those patches, so they can
> decide to fix directly in the sub-system tree instead of -mmotm, and then it
> will propagate to -mmotm one way or another.
>

Please stop sending EFI patches if you can't be bothered to
test/reproduce against the EFI tree.

Thanks,
Ard.
