Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A34C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC6220850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC6220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbeLCXqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:46:35 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37064 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCXqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:46:34 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so7289542plr.4;
        Mon, 03 Dec 2018 15:46:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tNc78mhpc6WKfwdLM4Nks85v2+hkCSmRaIJzKiGfIcI=;
        b=ZXNc33Hahf4fq0o/xWXpqDQeZyNi4DSD/5fFxXUnmaE7kdElVVIofnMW7QWzcs5BV5
         G2XwjEk9XgsOyZmDqiYVjuYXIfl4PEWRpc60zEu0M3xdQixPC88R0LK+EHwymLGYznHQ
         7aJ9ShJiPMKblQm+KlQ+7nlEEjMh0VIQNDxcBvM0hYnZb9B9/RPUY1o+1dtu/jNAkT+5
         wLKLe1STa4A/5GnpuEbQTf0yQq5YwqOsu3Rt/rHvur3N66uSwT6neucwbXL+jTmTMUo1
         Q0W/SeyGOdu9M57gqU3pFll0Vtr8LIoJpMFRr9wT4cQLsJgtU6NmWyhGklk01BNPVGRo
         9Kjg==
X-Gm-Message-State: AA+aEWbnJrJo5KpB+QuDnIlTlQ4bUPzoQ1S8GOrp6RSYYXfwlFy390jn
        Wk6nagUg7QwIFE6h4y0DQsg=
X-Google-Smtp-Source: AFSGD/UZ6G0AErnQoHzUlXf6WmINBQZAfhplFN6H+iOT8dv44xKiKAdw1j5dgGOu+YGL/bkYO6KDhw==
X-Received: by 2002:a17:902:2aaa:: with SMTP id j39mr18333934plb.335.1543880793764;
        Mon, 03 Dec 2018 15:46:33 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id y184sm18229297pgd.71.2018.12.03.15.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 15:46:32 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Mon, 03 Dec 2018 15:46:28 -0800
Date:   Mon, 3 Dec 2018 15:46:28 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
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
Subject: Re: [RFC v3 08/19] arch: um: add shim to trap to allow installing a
 fault catcher for tests
Message-ID: <20181203234628.GR28501@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-9-brendanhiggins@google.com>
 <20181130033429.GK18410@garbanzo.do-not-panic.com>
 <CAFd5g45+MAVaSW8HN9x57Y8Um=TV1Oa=-K8yExPBS-4KjLyciQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g45+MAVaSW8HN9x57Y8Um=TV1Oa=-K8yExPBS-4KjLyciQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 03:34:57PM -0800, Brendan Higgins wrote:
> On Thu, Nov 29, 2018 at 7:34 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Wed, Nov 28, 2018 at 11:36:25AM -0800, Brendan Higgins wrote:
> > > diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
> > > index cced829460427..bf90e678b3d71 100644
> > > --- a/arch/um/kernel/trap.c
> > > +++ b/arch/um/kernel/trap.c
> > > @@ -201,6 +201,12 @@ void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
> > >       segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs);
> > >  }
> > >
> > > +static void segv_run_catcher(jmp_buf *catcher, void *fault_addr)
> > > +{
> > > +     current->thread.fault_addr = fault_addr;
> > > +     UML_LONGJMP(catcher, 1);
> > > +}
> > > +
> > >  /*
> > >   * We give a *copy* of the faultinfo in the regs to segv.
> > >   * This must be done, since nesting SEGVs could overwrite
> > > @@ -219,7 +225,10 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
> > >       if (!is_user && regs)
> > >               current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
> > >
> > > -     if (!is_user && (address >= start_vm) && (address < end_vm)) {
> > > +     catcher = current->thread.fault_catcher;
> >
> > This and..
> >
> > > +     if (catcher && current->thread.is_running_test)
> > > +             segv_run_catcher(catcher, (void *) address);
> > > +     else if (!is_user && (address >= start_vm) && (address < end_vm)) {
> > >               flush_tlb_kernel_vm();
> > >               goto out;
> > >       }
> >
> > *not this*
> 
> I don't understand. Are you saying the previous block of code is good
> and this one is bad?

No, I was saying that the above block of code is a functional change,
but I was also pointing out other areas which were not and could be
folded into a separate atomic patch where no functionality changes.

> > > @@ -246,12 +255,10 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
> > >               address = 0;
> > >       }
> > >
> > > -     catcher = current->thread.fault_catcher;
> > >       if (!err)
> > >               goto out;
> > >       else if (catcher != NULL) {
> > > -             current->thread.fault_addr = (void *) address;
> > > -             UML_LONGJMP(catcher, 1);
> > > +             segv_run_catcher(catcher, (void *) address);
> > >       }
> > >       else if (current->thread.fault_addr != NULL)
> > >               panic("fault_addr set but no fault catcher");
> >
> > But with this seems one atomic change which should be submitted
> > separately, its just a helper. Think it would make the actual
> > change needed easier to review, ie, your needed changes would
> > be smaller and clearer for what you need.
> 
> Are you suggesting that I pull out the bits needed to implement abort
> in the next patch and squash it into this one?

No, I'm suggesting you can probably split this patch in 2, one which
wraps things with no functional changes, and another which adds your
changes.

  Luis
