Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE147C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642D02081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DRVtm77J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642D02081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbeKEWMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:12:14 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38264 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbeKEWMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:12:14 -0500
Received: by mail-it1-f196.google.com with SMTP id k141-v6so10536542itk.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 04:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/6WyI/ATD7QSMCborfY7jCSrIzT9ee+6uZk7Uq/CNmM=;
        b=DRVtm77J8HLHNls0ljH5SoBR7KFWlL3CmDIwUAadwdteri7+y//w3lSp/dZg0e5RFg
         8kTFWfZLKBM5BYvuSu2DezQWq+Uqi5e1hWLObsibEd2XYlzZk0BF1NEhS+isbB1+pbAW
         R59UbCdPXbPIwSiTfKqcgAN4eE3YTZioW8Pjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/6WyI/ATD7QSMCborfY7jCSrIzT9ee+6uZk7Uq/CNmM=;
        b=p/CBgC6sJ8yP7XNn/OoaZU3jpydJiIRpgGaClXV1qKLLp5YWR6lyXNC0Up31L/3Emu
         /6+sgvnTQBVs7FY61fWq9VUlaxKrIGvQxAKeR201S+VaPQs0EwG0Dk/nMr3phsyzjWRu
         FH8oWrzIq5okViE6dgkoS1bz/xfsHgYKmzlVlPzPFZQJixH48AZFvFyjuRrG710/bC9K
         DLl/32RgHVZn8PXfRrtlgV5LO/fEZ118aLgSc2R/2AcSDyfp+H7y+Xnnix9ewP9F0Y3+
         FPt2DRRtPJXp+wc/g6067uAuvLP82Ix/iHd+uEtdIp86UaOF5RJq4jn+jPQOq7GjNtiM
         IFcw==
X-Gm-Message-State: AGRZ1gIgm/rD0uyde/7fbGysmjgOFu7uSYbnOWbqIuIEYcqte6TAX2TV
        Ht9abr+3jG+howX32JjcBK1draou0Qm1aqi1FSdXnQ==
X-Google-Smtp-Source: AJdET5dFRjtzNqQO7bckRhJVw7VxFFG7HZtdNwM39CK1zklYxPiT2JMTuxnzM7lVRciKWSNZlPCTcc42b+hCWfRxxgs=
X-Received: by 2002:a02:6f41:: with SMTP id b1-v6mr19406019jae.62.1541422355920;
 Mon, 05 Nov 2018 04:52:35 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 04:52:35 -0800 (PST)
In-Reply-To: <CA+icZUXsS53RANWBNWw7_HcRRGyzVW1EepBU-K1pumrue6bYtg@mail.gmail.com>
References: <20181013010348.6740-1-natechancellor@gmail.com>
 <20181023175309.GA3384@flashbox> <CA+icZUXsS53RANWBNWw7_HcRRGyzVW1EepBU-K1pumrue6bYtg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 5 Nov 2018 13:52:35 +0100
Message-ID: <CAKv+Gu8eJxLcNkvSzzKf0P+gjhtGRdLQW9J+gcDRhhGCi-pHJg@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Disable some warnings for x86{,_64}
To:     sedat.dilek@gmail.com
Cc:     natechancellor@gmail.com, linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 October 2018 at 09:22, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On Tue, Oct 23, 2018 at 7:53 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
>>
>> On Fri, Oct 12, 2018 at 06:03:49PM -0700, Nathan Chancellor wrote:
>> > When building the kernel with Clang, some disabled warnings appear
>> > because this Makefile overrides KBUILD_CFLAGS for x86{,_64}. Add them to
>> > this list so that the build is clean again.
>> >
>> > -Wpointer-sign was disabled for the whole kernel before the beginning
>> > of git history.
>> >
>> > -Waddress-of-packed-member was disabled for the whole kernel in
>> > commit bfb38988c51e ("kbuild: clang: Disable 'address-of-packed-member'
>> > warning") and for x86/boot/compressed in commit 20c6c1890455 ("x86/boot:
>> > Disable the address-of-packed-member compiler warning").
>> >
>> > -Wgnu was disabled for the whole kernel in commit 61163efae020 ("kbuild:
>> > LLVMLinux: Add Kbuild support for building kernel with Clang") and for
>> > x86/boot/compressed in commit 6c3b56b19730 ("x86/boot: Disable Clang
>> > warnings about GNU extensions").
>> >
>> > Link: https://github.com/ClangBuiltLinux/linux/issues/112
>> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>> > ---
>> >
>> > Nick expressed concern that this Makefile is overwriting KBUILD_CFLAGS
>> > and suggested potentially rewriting the x86 portion of this Makefile to
>> > behave like the arm/arm64 one where problematic flags are filtered out.
>> > While that comes to fruition, it would be nice for this folder to behave
>> > like the rest of the kernel when it comes to this warnings so that the
>> > build is cleaner, thus this patch.
>> >
>> >  drivers/firmware/efi/libstub/Makefile | 5 ++++-
>> >  1 file changed, 4 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
>> > index c51627660dbb..d9845099635e 100644
>> > --- a/drivers/firmware/efi/libstub/Makefile
>> > +++ b/drivers/firmware/efi/libstub/Makefile
>> > @@ -9,7 +9,10 @@ cflags-$(CONFIG_X86_32)              := -march=i386
>> >  cflags-$(CONFIG_X86_64)              := -mcmodel=small
>> >  cflags-$(CONFIG_X86)         += -m$(BITS) -D__KERNEL__ -O2 \
>> >                                  -fPIC -fno-strict-aliasing -mno-red-zone \
>> > -                                -mno-mmx -mno-sse -fshort-wchar
>> > +                                -mno-mmx -mno-sse -fshort-wchar \
>> > +                                -Wno-pointer-sign \
>> > +                                $(call cc-disable-warning, address-of-packed-member) \
>> > +                                $(call cc-disable-warning, gnu)
>> >
>> >  # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
>> >  # disable the stackleak plugin
>> > --
>> > 2.19.1
>> >
>>
>> + Sedat for review/testing.
>
> Thanks Nathan.
>
> Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> [ Reported-by: Sedat Dilek <sedat.dilek@gmail.com> ]
> [ See duplicate "arch/x86/include/asm/processor.h: Warning
> -Waddress-of-packed-member "
> <https://github.com/ClangBuiltLinux/linux/issues/234> ]
>

Queued in efi/next

Thanks
