Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23815C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20AB20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gx0r0HHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20AB20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbeLDApK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:45:10 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45262 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeLDApK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:45:10 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so13518597ota.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 16:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=87OqF1uN7d9ACrdQgcSiuLKj9o8edBytZUSUFVSbdVQ=;
        b=Gx0r0HHKhggQcs6zw3DjJ/vh1cZISrIVYZJUPPJ6VC59gGtDeeIs9JmqkIirdq0TF8
         O0TFo/t5TDXd3666I61W8BTr5TEchOKVb87N75wWA4sK98X30ojBc/8gLbncKHlUQOH2
         JCkoTmpyndohEUzELTDk+ae0pqdDBd2t8ovX7UOp7OgDD9TwDNSnSmVebbdQE7heGIPG
         MOjsWsIFJh9S/x3gnlFvx8fdowcoBfz6NiADBiGIxj0nho8MdOOc4DHXGqGAjFcmDOSE
         qSX3T8cD6aoTCgeZCkGpoFFwsHspBsfmZb4EeMNw2Rh4zPybO2MZePAk448/apws2NbE
         T+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87OqF1uN7d9ACrdQgcSiuLKj9o8edBytZUSUFVSbdVQ=;
        b=dgRHRHElsxTmDZ/MuKfc30+cy8uxT6fySfiN+Auinq9kxGbqES+S1g846CqSCZDF3Z
         oqnSZw92qjlMkdzE7/uw2U/4pmEtjp441KfQakwp/iGKUeJyWzbDMEiXh/tbP8YammEa
         3JOMaoC0Nv91hN1yNhNFeOsEn12oAxo4NQb5qWxheEu4Dve7OnOChBYWLglaugFdbkXa
         Lca5qTAQmwO+Y9gB1gMcMF6q4N3Agsjb3ngd1PlmUFJjaa7OTQtr/PTyKIaCRIO9utsQ
         Zwb6j93ESuWSqXoe4/sBYJQcZ653beuc3IezuPTXalZlxIJtvDP0o0yJAsVRLnhGjgRp
         IEbQ==
X-Gm-Message-State: AA+aEWY/eWSfpfINmynUMTFQGO5bSwPscY8zgC3VXSyUQZD487vlPylz
        heB61KgCL5Mgz2HXK7zjXsjSiC+Vqc9mzS2dMeKAdw==
X-Google-Smtp-Source: AFSGD/WiTXVM7tkyprqyOi+ZZg+FoEpb+/k1WBB7d2LXKD8cFi0IoptFjbBhS/BpMctaGqFORjA8PV/MUAg1MQxK7MQ=
X-Received: by 2002:a9d:3ac:: with SMTP id f41mr11002653otf.98.1543884307981;
 Mon, 03 Dec 2018 16:45:07 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-9-brendanhiggins@google.com> <20181130033429.GK18410@garbanzo.do-not-panic.com>
 <CAFd5g45+MAVaSW8HN9x57Y8Um=TV1Oa=-K8yExPBS-4KjLyciQ@mail.gmail.com> <20181203234628.GR28501@garbanzo.do-not-panic.com>
In-Reply-To: <20181203234628.GR28501@garbanzo.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 3 Dec 2018 16:44:56 -0800
Message-ID: <CAFd5g45p55GXuk-PcaknVHywJ25LsM+7N83L_g0ob6Q0FTwSrg@mail.gmail.com>
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

On Mon, Dec 3, 2018 at 3:46 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Dec 03, 2018 at 03:34:57PM -0800, Brendan Higgins wrote:
> > On Thu, Nov 29, 2018 at 7:34 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Wed, Nov 28, 2018 at 11:36:25AM -0800, Brendan Higgins wrote:
> > > > diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
> > > > index cced829460427..bf90e678b3d71 100644
> > > > --- a/arch/um/kernel/trap.c
> > > > +++ b/arch/um/kernel/trap.c
> > > > @@ -201,6 +201,12 @@ void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
> > > >       segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs);
> > > >  }
> > > >
> > > > +static void segv_run_catcher(jmp_buf *catcher, void *fault_addr)
> > > > +{
> > > > +     current->thread.fault_addr = fault_addr;
> > > > +     UML_LONGJMP(catcher, 1);
> > > > +}
> > > > +
> > > >  /*
> > > >   * We give a *copy* of the faultinfo in the regs to segv.
> > > >   * This must be done, since nesting SEGVs could overwrite
> > > > @@ -219,7 +225,10 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
> > > >       if (!is_user && regs)
> > > >               current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
> > > >
> > > > -     if (!is_user && (address >= start_vm) && (address < end_vm)) {
> > > > +     catcher = current->thread.fault_catcher;
> > >
> > > This and..
> > >
> > > > +     if (catcher && current->thread.is_running_test)
> > > > +             segv_run_catcher(catcher, (void *) address);
> > > > +     else if (!is_user && (address >= start_vm) && (address < end_vm)) {
> > > >               flush_tlb_kernel_vm();
> > > >               goto out;
> > > >       }
> > >
> > > *not this*
> >
> > I don't understand. Are you saying the previous block of code is good
> > and this one is bad?
>
> No, I was saying that the above block of code is a functional change,
> but I was also pointing out other areas which were not and could be
> folded into a separate atomic patch where no functionality changes.
>
> > > > @@ -246,12 +255,10 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
> > > >               address = 0;
> > > >       }
> > > >
> > > > -     catcher = current->thread.fault_catcher;
> > > >       if (!err)
> > > >               goto out;
> > > >       else if (catcher != NULL) {
> > > > -             current->thread.fault_addr = (void *) address;
> > > > -             UML_LONGJMP(catcher, 1);
> > > > +             segv_run_catcher(catcher, (void *) address);
> > > >       }
> > > >       else if (current->thread.fault_addr != NULL)
> > > >               panic("fault_addr set but no fault catcher");
> > >
> > > But with this seems one atomic change which should be submitted
> > > separately, its just a helper. Think it would make the actual
> > > change needed easier to review, ie, your needed changes would
> > > be smaller and clearer for what you need.
> >
> > Are you suggesting that I pull out the bits needed to implement abort
> > in the next patch and squash it into this one?
>
> No, I'm suggesting you can probably split this patch in 2, one which
> wraps things with no functional changes, and another which adds your
> changes.
>

That makes sense.

Thanks for the clarification!
