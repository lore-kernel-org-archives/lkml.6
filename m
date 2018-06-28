Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320CBC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D198626FEA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D198626FEA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964824AbeF1HB5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:01:57 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:40064 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933361AbeF1HBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:01:54 -0400
Received: by mail-vk0-f68.google.com with SMTP id s23-v6so291350vks.7;
        Thu, 28 Jun 2018 00:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aAkg1L20ZteRX9kI12vsvdtXsfSm8eM3tTDFiVV+IZY=;
        b=UqNHvgyTDLTLJlBtWUEX9Tl+/fxnMKAL7WDXvEapBV2MMezA2dBE21cZF5fLStyTYK
         /EHqbvEAogl+239Ki/x8Ba8iUmP+QXZ2xvOUx8syKI0R5dEN1szeIcujJOXDSiaGp4xs
         hsB+xTtUZTeMXZqbtxke1k8Ui1CESLErFBOYldb5Nf+ecW1Y6YLV1pcA+MXK0qVwffpQ
         5Axdy47LXlcWkrElWVjfFkfPCT5RMinbQuFYjLQu4dGyE2qyf7vkFvZo8MnNVBmrQGc4
         cj0KhU5V7/8oWF6J9r0WDeFBifbWQ5+sqPSkqsIm11ttj89TTrg+61oG1XfHoEkttRD8
         JaVg==
X-Gm-Message-State: APt69E0k0nWTBO1ceZw2iomQRlB6Vc7uyuBkWHpMY3jgYVIiDUCiXXWz
        12CCA3Xy0zUl7gubMw0AkC4r5mX28oGTydg+JiJfNw==
X-Google-Smtp-Source: AAOMgpfe8xhTqMhhrc7i4WKZdhAAZZIGRNZgT4CVFl4u9uF0GHoOUdtvfOJg529H4rHXyjiqqHyvqyJ+0dgL1spkZPk=
X-Received: by 2002:a1f:644:: with SMTP id 65-v6mr4445163vkg.159.1530169313568;
 Thu, 28 Jun 2018 00:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1530018818.git.andreyknvl@google.com> <20180627160800.3dc7f9ee41c0badbf7342520@linux-foundation.org>
 <CAN=P9pivApAo76Kjc0TUDE0kvJn0pET=47xU6e=ioZV2VqO0Rg@mail.gmail.com>
In-Reply-To: <CAN=P9pivApAo76Kjc0TUDE0kvJn0pET=47xU6e=ioZV2VqO0Rg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Jun 2018 09:01:42 +0200
Message-ID: <CAMuHMdVVutxU3paxcjsuLVjCuooHqs61o0DEySkOK1zUeMj2tw@mail.gmail.com>
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address sanitizer
To:     Kostya Serebryany <kcc@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>, cpandya@codeaurora.org,
        vishwath@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kostya,

On Thu, Jun 28, 2018 at 2:04 AM Kostya Serebryany <kcc@google.com> wrote:
> On Wed, Jun 27, 2018 at 4:08 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Tue, 26 Jun 2018 15:15:10 +0200 Andrey Konovalov <andreyknvl@google.com> wrote:
> > > This patchset adds a new mode to KASAN [1], which is called KHWASAN
> > > (Kernel HardWare assisted Address SANitizer).
> > >
> > > The plan is to implement HWASan [2] for the kernel with the incentive,
> > > that it's going to have comparable to KASAN performance, but in the same
> > > time consume much less memory, trading that off for somewhat imprecise
> > > bug detection and being supported only for arm64.
> >
> > Why do we consider this to be a worthwhile change?
> >
> > Is KASAN's memory consumption actually a significant problem?  Some
> > data regarding that would be very useful.
>
> On mobile, ASAN's and KASAN's memory usage is a significant problem.
> Not sure if I can find scientific evidence of that.
> CC-ing Vishwath Mohan who deals with KASAN on Android to provide
> anecdotal evidence.
>
> There are several other benefits too:
> * HWASAN more reliably detects non-linear-buffer-overflows compared to
> ASAN (same for kernel-HWASAN vs kernel-ASAN)
> * Same for detecting use-after-free (since HWASAN doesn't rely on quarantine).
> * Much easier to implement stack-use-after-return detection (which
> IIRC KASAN doesn't have yet, because in KASAN it's too hard)
>
> > If it is a large problem then we still have that problem on x86, so the
> > problem remains largely unsolved?
>
> The problem is more significant on mobile devices than on desktop/server.
> I'd love to have [K]HWASAN on x86_64 as well, but it's less trivial since x86_64
> doesn't have an analog of aarch64's top-byte-ignore hardware feature.

This depends on your mobile devices and desktops and servers.
There exist mobile devices with more memory than some desktops or servers.

So actual numbers (O(KiB)? O(MiB)? O(GiB)?) would be nice to have.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
