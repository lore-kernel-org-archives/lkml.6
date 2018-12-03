Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F589C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83772087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mHlF9LhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83772087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbeLCXfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:35:11 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39450 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbeLCXfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:35:09 -0500
Received: by mail-oi1-f196.google.com with SMTP id i6so12623598oia.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 15:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=38k7rZwJNLxxc4f21ycUViN8yfN3idwZwlptx9wU7K8=;
        b=mHlF9LhPQVVdGeHWJrlMMLWsq2gtxQG+t2nIcBK1eqDKVMwqhQqgPvsd6mFQQe32b0
         HJjhYi6yExRc2HxOImrFe6sJR0JOCOozoRTFxGza0lDXGUuUkjq7DLu8R1RuBj+oNC+1
         iMFSAuDDMwtO+T8KqKKp0UQfaDHiX8eFM2n8GaMaUXn3qt+RC2ArBTPyV3mjC/Mg5q57
         KGz7L3HbbiEpuriI97x+t7xq+3aKEd4yJDw/Li8mRtVFjpXeX4QJPMp49vKq3mdge3wJ
         iwtcVhMFRfYnxMYj/cuZ6CmQzak/BYiQIXPFamn1rux3yYUU7YsX/apyIvHh7hDryikf
         c0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=38k7rZwJNLxxc4f21ycUViN8yfN3idwZwlptx9wU7K8=;
        b=p12YTs0LiNQM8KdmK71aRvnUkzewGyJ44ZSkYbwo7rrBsMefkB2jeSmpW7JfHv3CMV
         hC/K6bJLxio1vlrgvJPy7BCgeia1MpPYQgfO1LnhH9TP5oMjHcRhAqpsa7cyf46dTALc
         PdGouoCd+zCaeZ/zytu5iI1oUByLhv3mY8i+CF53PAtTkBMsc5CNyJXB0KcGS7o5kYSg
         IVgi2bTYpaj6dWIDAT+ajrQODPX5mihMQqX70Msj/K9aF5K1UdPZ/OH+5M4KeIaQtyin
         cPItQ9auE6s6T2F2+90Qi0LsvWhai09RIH5C3LksA+b0brA28iZoXtGRvg4uEGCere/0
         0zuQ==
X-Gm-Message-State: AA+aEWahYcgpyDJnU8ilZvVCS/kwKwjbe7dGCFfRreHTaDZxx2EA9jOC
        /VpRA/HMpO+fPAQn2QKNt2jFUVY8pCOOmab6k5AVuQ==
X-Google-Smtp-Source: AFSGD/W0BFXXUL2Lh3yc7nGBi+5N6UYv4AdtbgLaodHaz98HlNT8E7YWnBRNfaCGnXXPYoeboOt195NoTleLDpkaINg=
X-Received: by 2002:aca:54c4:: with SMTP id i187mr10652530oib.238.1543880108311;
 Mon, 03 Dec 2018 15:35:08 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-9-brendanhiggins@google.com> <20181130033429.GK18410@garbanzo.do-not-panic.com>
In-Reply-To: <20181130033429.GK18410@garbanzo.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 3 Dec 2018 15:34:57 -0800
Message-ID: <CAFd5g45+MAVaSW8HN9x57Y8Um=TV1Oa=-K8yExPBS-4KjLyciQ@mail.gmail.com>
Subject: Re: [RFC v3 08/19] arch: um: add shim to trap to allow installing a
 fault catcher for tests
To:     mcgrof@kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com,
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 7:34 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Nov 28, 2018 at 11:36:25AM -0800, Brendan Higgins wrote:
> > diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
> > index cced829460427..bf90e678b3d71 100644
> > --- a/arch/um/kernel/trap.c
> > +++ b/arch/um/kernel/trap.c
> > @@ -201,6 +201,12 @@ void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
> >       segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs);
> >  }
> >
> > +static void segv_run_catcher(jmp_buf *catcher, void *fault_addr)
> > +{
> > +     current->thread.fault_addr = fault_addr;
> > +     UML_LONGJMP(catcher, 1);
> > +}
> > +
> >  /*
> >   * We give a *copy* of the faultinfo in the regs to segv.
> >   * This must be done, since nesting SEGVs could overwrite
> > @@ -219,7 +225,10 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
> >       if (!is_user && regs)
> >               current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
> >
> > -     if (!is_user && (address >= start_vm) && (address < end_vm)) {
> > +     catcher = current->thread.fault_catcher;
>
> This and..
>
> > +     if (catcher && current->thread.is_running_test)
> > +             segv_run_catcher(catcher, (void *) address);
> > +     else if (!is_user && (address >= start_vm) && (address < end_vm)) {
> >               flush_tlb_kernel_vm();
> >               goto out;
> >       }
>
> *not this*

I don't understand. Are you saying the previous block of code is good
and this one is bad?

>
> > @@ -246,12 +255,10 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
> >               address = 0;
> >       }
> >
> > -     catcher = current->thread.fault_catcher;
> >       if (!err)
> >               goto out;
> >       else if (catcher != NULL) {
> > -             current->thread.fault_addr = (void *) address;
> > -             UML_LONGJMP(catcher, 1);
> > +             segv_run_catcher(catcher, (void *) address);
> >       }
> >       else if (current->thread.fault_addr != NULL)
> >               panic("fault_addr set but no fault catcher");
>
> But with this seems one atomic change which should be submitted
> separately, its just a helper. Think it would make the actual
> change needed easier to review, ie, your needed changes would
> be smaller and clearer for what you need.

Are you suggesting that I pull out the bits needed to implement abort
in the next patch and squash it into this one?
