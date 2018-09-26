Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37065C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB99421527
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gabM9oFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB99421527
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeI0Ddz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:33:55 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42155 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeI0Ddy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:33:54 -0400
Received: by mail-oi1-f194.google.com with SMTP id v198-v6so363172oif.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 14:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VveqmYfiSAjXWcfyZDEn8gk0gnucVYuXcZ87TnB95DE=;
        b=gabM9oFNo3AOmU9Tur9V/zHlRr+9W+nY+SMadKSSwkvFIEI5FXVgFbFce2Je8oaQuX
         d51DC/wvvfy3rCNPqHvZ4V0wSUuErvl8VYqWP4HEXcqCyhly+DTggVxvgrCDyGObinEg
         yUrRm/Jiyl8In5bFEwSQvo8K9ycebUoIt87tGbs5z8zBlA6bqeMvh7lgqXdmxMwYGtQo
         YsbbLQNJp2t0jl9M+dQhw6zMqbWZ5QKljyHps22ifOZrjI/q0EToRTFh8umxb+JEdFCo
         6AxgfACVP8cRMooBjas02RjAfsDKd9YQkkKXgp1Fy7uCoSU4SUTtD7lLMXxy0sD9oDeX
         lxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VveqmYfiSAjXWcfyZDEn8gk0gnucVYuXcZ87TnB95DE=;
        b=XM396UY3yDiQzyDqQKSz/AEDMpM7xxJceYJJ0uQfuMDiajMUF2fEIN4LWF1oQEws8C
         JN7QN2xE9gAwws+kE62nwaMGVDbI7j1sHA3WGSm8QparWXDxrVQ/FUAtITJTINYNIrup
         nX7N+PJi3/Xl0O/QURftm5RqhR/rGvRHf9IdEm/trXGeOHMFqVkw3g8IlHNHt7rKktI6
         S+gfSSUghuIJJiLFt02170WV7J0qy1vdbTCQBUA2IbWeNGgV6sI/g/toJJopXAUO7BnF
         qxZzMMaheUU7u4Wm29zEBYP8cg9fJZ1g+YHnmakcQv++CRtDcDEcC008eYxycTnpUHiX
         sbjw==
X-Gm-Message-State: ABuFfogEhw3wSLB/2PSuCVQmqAoBBk2LOAj366yACCdFNrTnnDBgWYn+
        q/w8pqDR7s0A2f6Efl4yM6dszwdRJPCbpGyaEUx8QQ==
X-Google-Smtp-Source: ACcGV61sWvWcw0PdH0AD6TC5BkOLZOjETxk0bScQTymDCW45P6y2pQo2zhqtl2NBjWS3IymiKUv+wxpSbI64t7PXa5E=
X-Received: by 2002:aca:b844:: with SMTP id i65-v6mr1659834oif.177.1537996741600;
 Wed, 26 Sep 2018 14:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180926203446.2004-1-casey.schaufler@intel.com>
 <20180926203446.2004-2-casey.schaufler@intel.com> <CAG48ez1xu_WJi5_UZvrTO_H6o=DHRvm5LMp_jg=GauLbpkYARg@mail.gmail.com>
In-Reply-To: <CAG48ez1xu_WJi5_UZvrTO_H6o=DHRvm5LMp_jg=GauLbpkYARg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 26 Sep 2018 23:18:35 +0200
Message-ID: <CAG48ez15jcFQT1NdZekRuo9_GKLru_R1HpgF0TNKUKAZ8_6UNA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] AppArmor: Prepare for PTRACE_MODE_SCHED
To:     Casey Schaufler <casey.schaufler@intel.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, Dave Hansen <dave.hansen@intel.com>,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 11:16 PM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Sep 26, 2018 at 10:35 PM Casey Schaufler
> <casey.schaufler@intel.com> wrote:
> > A ptrace access check with mode PTRACE_MODE_SCHED gets called
> > from process switching code. This precludes the use of audit,
> > as the locking is incompatible. Don't do audit in the PTRACE_MODE_SCHED
> > case.
>
> Why is this separate from PTRACE_MODE_NOAUDIT? It looks like
> apparmor_ptrace_access_check() currently ignores PTRACE_MODE_NOAUDIT.
> Could you, instead of adding a new flag, fix the handling of
> PTRACE_MODE_NOAUDIT?

Er, after looking at more of the series, I see that PTRACE_MODE_SCHED
is necessary; but could you handle the "don't audit" part for AppArmor
using PTRACE_MODE_NOAUDIT instead?

> > Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
> > ---
> >  security/apparmor/domain.c      | 2 +-
> >  security/apparmor/include/ipc.h | 2 +-
> >  security/apparmor/ipc.c         | 8 +++++---
> >  security/apparmor/lsm.c         | 5 +++--
> >  4 files changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
> > index 08c88de0ffda..28300f4c3ef9 100644
> > --- a/security/apparmor/domain.c
> > +++ b/security/apparmor/domain.c
> > @@ -77,7 +77,7 @@ static int may_change_ptraced_domain(struct aa_label *to_label,
> >         if (!tracer || unconfined(tracerl))
> >                 goto out;
> >
> > -       error = aa_may_ptrace(tracerl, to_label, PTRACE_MODE_ATTACH);
> > +       error = aa_may_ptrace(tracerl, to_label, PTRACE_MODE_ATTACH, true);
> >
> >  out:
> >         rcu_read_unlock();
> > diff --git a/security/apparmor/include/ipc.h b/security/apparmor/include/ipc.h
> > index 5ffc218d1e74..299d1c45fef0 100644
> > --- a/security/apparmor/include/ipc.h
> > +++ b/security/apparmor/include/ipc.h
> > @@ -34,7 +34,7 @@ struct aa_profile;
> >         "xcpu xfsz vtalrm prof winch io pwr sys emt lost"
> >
> >  int aa_may_ptrace(struct aa_label *tracer, struct aa_label *tracee,
> > -                 u32 request);
> > +                 u32 request, bool audit);
> >  int aa_may_signal(struct aa_label *sender, struct aa_label *target, int sig);
> >
> >  #endif /* __AA_IPC_H */
> > diff --git a/security/apparmor/ipc.c b/security/apparmor/ipc.c
> > index 527ea1557120..9ed110afc822 100644
> > --- a/security/apparmor/ipc.c
> > +++ b/security/apparmor/ipc.c
> > @@ -121,15 +121,17 @@ static int profile_tracer_perm(struct aa_profile *tracer,
> >   * Returns: %0 else error code if permission denied or error
> >   */
> >  int aa_may_ptrace(struct aa_label *tracer, struct aa_label *tracee,
> > -                 u32 request)
> > +                 u32 request, bool audit)
> >  {
> >         struct aa_profile *profile;
> >         u32 xrequest = request << PTRACE_PERM_SHIFT;
> >         DEFINE_AUDIT_DATA(sa, LSM_AUDIT_DATA_NONE, OP_PTRACE);
> >
> >         return xcheck_labels(tracer, tracee, profile,
> > -                       profile_tracer_perm(profile, tracee, request, &sa),
> > -                       profile_tracee_perm(profile, tracer, xrequest, &sa));
> > +                       profile_tracer_perm(profile, tracee, request,
> > +                                           audit ? &sa : NULL),
> > +                       profile_tracee_perm(profile, tracer, xrequest,
> > +                                           audit ? &sa : NULL));
> >  }
> >
> >
> > diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> > index 8b8b70620bbe..da9d0b228857 100644
> > --- a/security/apparmor/lsm.c
> > +++ b/security/apparmor/lsm.c
> > @@ -118,7 +118,8 @@ static int apparmor_ptrace_access_check(struct task_struct *child,
> >         tracee = aa_get_task_label(child);
> >         error = aa_may_ptrace(tracer, tracee,
> >                         (mode & PTRACE_MODE_READ) ? AA_PTRACE_READ
> > -                                                 : AA_PTRACE_TRACE);
> > +                                                 : AA_PTRACE_TRACE,
> > +                       !(mode & PTRACE_MODE_SCHED));
> >         aa_put_label(tracee);
> >         end_current_label_crit_section(tracer);
> >
> > @@ -132,7 +133,7 @@ static int apparmor_ptrace_traceme(struct task_struct *parent)
> >
> >         tracee = begin_current_label_crit_section();
> >         tracer = aa_get_task_label(parent);
> > -       error = aa_may_ptrace(tracer, tracee, AA_PTRACE_TRACE);
> > +       error = aa_may_ptrace(tracer, tracee, AA_PTRACE_TRACE, true);
> >         aa_put_label(tracer);
> >         end_current_label_crit_section(tracee);
> >
> > --
> > 2.17.1
> >
