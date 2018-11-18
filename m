Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8443C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9165620869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mz4lMIlp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9165620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeKSGme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 01:42:34 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36154 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbeKSGme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 01:42:34 -0500
Received: by mail-qk1-f194.google.com with SMTP id o125so45588962qkf.3;
        Sun, 18 Nov 2018 12:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hW3YpOwOV7MHavGct4c1SiC54gWbITC/Pd96cayi0Xo=;
        b=Mz4lMIlpVHPrP52pqhxBHmIIJ4hgw8GnEwiNYGL9FTgsYlTaDb3Vk0PYM4fez3uUGV
         xdNcj0BK4rvrhTPAWu0Et1hNBs72DLUoGccDSqE8QySAYKlCHGPfrC/Fp/4N9atMzXVO
         tUIiuWmO2PuJOmgLN5B65uirxEYZP5ku6Y4d/oQh4vywfXulcg76SQ07mEV3xoV/6yxE
         4T7mgH8uXXNpeUypktO5SG+LQWfWb75ZWfhWlzb6nR6SmBkpF6OcxaQISE1oQqvdxXlZ
         All2Oa+tCSFVsuGoA0i8BnyyCNb8y5rdv8aPBlPhG68tA47LEUiRkVLiGNy/hGhEaL2U
         ZQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hW3YpOwOV7MHavGct4c1SiC54gWbITC/Pd96cayi0Xo=;
        b=M26pA4TrRmJKLuumLbBzVKEwxZ05f7iaXZYFyE9Wb38BP1cuUSfIAVtRh5pn2d7YfG
         JD+bkn0sMFx+NJyDTGOOrcSnqR6qS9f9D1mHGIxYbvgIHwweWvGkqcC2Z16ACIJ4BFX2
         UGU3XLuQ/jmgeZ/fgKL7RQ7Y1oRQm9Y3u4CoeauWkeU+a3YpH4cF4V5w6ESofJ00tDaB
         YcbyOJge+DtHlqDcLfsvFRF7MYap0xafxTOlUfdKbywDrERvoqY3yqEue3R8zRXsq/OS
         k2ki+WW07/INl4ZAV7mhIyvu6MijtXqd5wEQElGy3dXU0XULfB8a9jtiumBVucGeuJ43
         sTeQ==
X-Gm-Message-State: AGRZ1gL4LenIwEtTe5p/ssqFzrkv3Fal3xRV2vPALx+x13o7ws+iENHD
        AmRaaIsLjHksa+HTD+JHwwztpiEh85q3fd/S4Ew=
X-Google-Smtp-Source: AJdET5e+E9tKQsv6QteVqWmONyPKJI3b322+yZsfi+VI3OF8i8PqtMNqOZiyc3Viy1Ej5ZqieDe4yfVxpbNIH3Udxl4=
X-Received: by 2002:a37:a4cf:: with SMTP id n198mr18400351qke.101.1542572478632;
 Sun, 18 Nov 2018 12:21:18 -0800 (PST)
MIME-Version: 1.0
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
 <20181117185715.25198-3-ard.biesheuvel@linaro.org> <CAH3MdRV85imzia+=irgbjL48wqFdorB-F1=BkwBgJgi3Z-XAKA@mail.gmail.com>
 <CAKv+Gu9hB3a5LfFQskNzXZDmgps_+9dewbC1E5GFndcQZ-KgQg@mail.gmail.com>
In-Reply-To: <CAKv+Gu9hB3a5LfFQskNzXZDmgps_+9dewbC1E5GFndcQZ-KgQg@mail.gmail.com>
From:   Y Song <ys114321@gmail.com>
Date:   Sun, 18 Nov 2018 20:20:41 +0000
Message-ID: <CAH3MdRXESr62o2XnQ0L7GGZRfM_GpbFpG2xmk93LDLL2es8y3A@mail.gmail.com>
Subject: Re: [PATCH 2/4] net/bpf: refactor freeing of executable allocations
To:     ard.biesheuvel@linaro.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        rick.p.edgecombe@intel.com, eric.dumazet@gmail.com,
        jannh@google.com, Kees Cook <keescook@chromium.org>,
        jeyu@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au,
        David Miller <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 3:55 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Sat, 17 Nov 2018 at 23:47, Y Song <ys114321@gmail.com> wrote:
> >
> > On Sat, Nov 17, 2018 at 6:58 PM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > >
> > > All arch overrides of the __weak bpf_jit_free() amount to the same
> > > thing: the allocated memory was never mapped read-only, and so
> > > it does not have to be remapped to read-write before being freed.
> > >
> > > So in preparation of permitting arches to serve allocations for BPF
> > > JIT programs from other regions than the module region, refactor
> > > the existing bpf_jit_free() implementations to use the shared code
> > > where possible, and only specialize the remap and free operations.
> > >
> > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > ---
> > >  arch/mips/net/bpf_jit.c           |  7 ++-----
> > >  arch/powerpc/net/bpf_jit_comp.c   |  7 ++-----
> > >  arch/powerpc/net/bpf_jit_comp64.c |  9 +++------
> > >  arch/sparc/net/bpf_jit_comp_32.c  |  7 ++-----
> > >  kernel/bpf/core.c                 | 15 +++++----------
> > >  5 files changed, 14 insertions(+), 31 deletions(-)
> > >
> > > diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
> > > index 1b69897274a1..5696bd7dccc7 100644
> > > --- a/arch/mips/net/bpf_jit.c
> > > +++ b/arch/mips/net/bpf_jit.c
> > > @@ -1261,10 +1261,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
> > >         kfree(ctx.offsets);
> > >  }
> > >
> > > -void bpf_jit_free(struct bpf_prog *fp)
> > > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> > >  {
> > > -       if (fp->jited)
> > > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > > -
> > > -       bpf_prog_unlock_free(fp);
> > > +       module_memfree(hdr);
> > >  }
> > > diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> > > index a1ea1ea6b40d..5b5ce4a1b44b 100644
> > > --- a/arch/powerpc/net/bpf_jit_comp.c
> > > +++ b/arch/powerpc/net/bpf_jit_comp.c
> > > @@ -680,10 +680,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
> > >         return;
> > >  }
> > >
> > > -void bpf_jit_free(struct bpf_prog *fp)
> > > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> > >  {
> > > -       if (fp->jited)
> > > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > > -
> > > -       bpf_prog_unlock_free(fp);
> > > +       module_memfree(hdr);
> > >  }
> > > diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> > > index 84c8f013a6c6..f64f1294bd62 100644
> > > --- a/arch/powerpc/net/bpf_jit_comp64.c
> > > +++ b/arch/powerpc/net/bpf_jit_comp64.c
> > > @@ -1021,11 +1021,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
> > >         return fp;
> > >  }
> > >
> > > -/* Overriding bpf_jit_free() as we don't set images read-only. */
> > > -void bpf_jit_free(struct bpf_prog *fp)
> > > +/* Overriding bpf_jit_binary_free() as we don't set images read-only. */
> > > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> > >  {
> > > -       if (fp->jited)
> > > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > > -
> > > -       bpf_prog_unlock_free(fp);
> > > +       module_memfree(hdr);
> > >  }
> > > diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
> > > index 01bda6bc9e7f..589950d152cc 100644
> > > --- a/arch/sparc/net/bpf_jit_comp_32.c
> > > +++ b/arch/sparc/net/bpf_jit_comp_32.c
> > > @@ -756,10 +756,7 @@ cond_branch:                       f_offset = addrs[i + filter[i].jf];
> > >         return;
> > >  }
> > >
> > > -void bpf_jit_free(struct bpf_prog *fp)
> > > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> > >  {
> > > -       if (fp->jited)
> > > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > > -
> > > -       bpf_prog_unlock_free(fp);
> > > +       module_memfree(hdr);
> > >  }
> > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > index 1a796e0799ec..29f766dac203 100644
> > > --- a/kernel/bpf/core.c
> > > +++ b/kernel/bpf/core.c
> > > @@ -646,25 +646,20 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
> > >         return hdr;
> > >  }
> > >
> > > -void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> > > +void __weak bpf_jit_binary_free(struct bpf_binary_header *hdr)
> > >  {
> > > -       u32 pages = hdr->pages;
> > > -
> > > +       bpf_jit_binary_unlock_ro(hdr);
> > >         module_memfree(hdr);
> > > -       bpf_jit_uncharge_modmem(pages);
> > >  }
> > >
> > > -/* This symbol is only overridden by archs that have different
> > > - * requirements than the usual eBPF JITs, f.e. when they only
> > > - * implement cBPF JIT, do not set images read-only, etc.
> > > - */
> >
> > Do you want to move the above comments to
> > new weak function bpf_jit_binary_free?
> >
>
> Perhaps. But one thing I don't understand, looking at this again, is
> why we have these overrides in the first place. module_memfree() just
> calls vfree(), which takes down the mapping entirely (along with any
> updated permissions), and so remapping it back to r/w right before
> that seems rather pointless imo.
>
> Can we get rid of bpf_jit_binary_unlock_ro() entirely, and along with
> it, all these overrides for the free() path?

Maybe based on current implementation. Just a pure speculation.
module_memfree() can be overwritten by arch specific implementation.
The intention could be restoring the allocated page to its original permission
just in case arch specific implementation of module_memfree()
does different thing than default vfee().
