Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94153C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3D12154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vFvFPlzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3D12154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbeI0FNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:13:42 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34099 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeI0FNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 01:13:42 -0400
Received: by mail-ot1-f66.google.com with SMTP id i12-v6so700809otl.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 15:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AwtNy1xBli3EEuuEjfCraJEsNp8HIriJJVoIpp9yEBM=;
        b=vFvFPlzlKv+cg2+g+6iLn4ZS7rMOjwIdMBPyDKDlW52wpfbSxHa+H/InrAnBHpSASa
         s42itjpXB6WZfEf7jBHMSueMMhnNs1uk7hmW35i8flszQwz2NVnLFVecw6AiNAaqe4wi
         s/Ja47ucnWoy3SLW1D2N9G7NjfQZxaUfC2vmu45kl82bIWe5eX1ydWkmhnI83xApUCP7
         GFlL39sQagztednOYi6Gm9udhpQ6RX3nn5bMsBzFdoVUiLXzZyLZOG8my9gRl0LscjLy
         FC4yPF6c6o8y45AQu1UoQEkVD4uptxSH2O6MTMwfadYNjSxpu4VAmnsKHf+4/XG0vJZ8
         r+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AwtNy1xBli3EEuuEjfCraJEsNp8HIriJJVoIpp9yEBM=;
        b=nPhzFvIxMmrv0UqiKm05x53lPWY1MNwVZNnL2scfAzYYVR9E3efbSzS+Gs1UXR5df9
         yYU4iUc6ioM1bgwO35uE89igJyKg6ja6noB6UCJSS+TEEnjkcKq1bOQj4p3h6agDKKpn
         lktMY2MdQ+A6w+2bngo7EpPG3R+0W4MR9zFe4NGHSsCok1MQSJsRbAbsZvurVdFJChmI
         uN9ka5tb2PuITIY1G1swkREH/wMoGBxRycjl2tkPsbVIeS7iEvyE/CthhiEksW7PuNfi
         xknW7lwu9ACUlNo1B3UqGkUx+P6mH9U0xqob/BPrdjkhLH165Zu+1rBWZqMnWoiP0XFY
         U+kA==
X-Gm-Message-State: ABuFfog/6Zr4y6MhA6Rp2N5MReWh+O3Cm7IEHkr77JV7VK+W4+sj/ASU
        YOnINUAiypUBe4P5ROXkRZf5soy3N7oFrbWhEV25ag==
X-Google-Smtp-Source: ACcGV62Dl7vjIOboFGmOCRxaf2IzApOGGgWsClzp9oDmZ/6rb/zId7uqWXGDxtapy909ZdLnK1awX6xCznpIsWW01Pg=
X-Received: by 2002:a9d:844:: with SMTP id 62-v6mr5234707oty.159.1538002707140;
 Wed, 26 Sep 2018 15:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180926203446.2004-1-casey.schaufler@intel.com>
 <20180926203446.2004-3-casey.schaufler@intel.com> <CAG48ez3_XJYCURiCurDeCousGguGUdPego30j5+UF8FebWxUtA@mail.gmail.com>
 <99FC4B6EFCEFD44486C35F4C281DC673214625EA@ORSMSX107.amr.corp.intel.com>
In-Reply-To: <99FC4B6EFCEFD44486C35F4C281DC673214625EA@ORSMSX107.amr.corp.intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 27 Sep 2018 00:58:00 +0200
Message-ID: <CAG48ez1+9Bfadu4y4TzPYJfFpLk+N8w7GdCE+xwNCM5TfQ8W8Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] Smack: Prepare for PTRACE_MODE_SCHED
To:     Casey Schaufler <casey.schaufler@intel.com>,
        Jiri Kosina <jikos@kernel.org>
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

+Jiri

On Thu, Sep 27, 2018 at 12:54 AM Schaufler, Casey
<casey.schaufler@intel.com> wrote:
> > -----Original Message-----
> > From: Jann Horn [mailto:jannh@google.com]
> > Sent: Wednesday, September 26, 2018 2:31 PM
> > To: Schaufler, Casey <casey.schaufler@intel.com>
> > Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>; kernel list
> > <linux-kernel@vger.kernel.org>; linux-security-module <linux-security-
> > module@vger.kernel.org>; selinux@tycho.nsa.gov; Hansen, Dave
> > <dave.hansen@intel.com>; Dock, Deneen T <deneen.t.dock@intel.com>;
> > kristen@linux.intel.com; Arjan van de Ven <arjan@linux.intel.com>
> > Subject: Re: [PATCH v5 2/5] Smack: Prepare for PTRACE_MODE_SCHED
> >
> > On Wed, Sep 26, 2018 at 10:35 PM Casey Schaufler
> > <casey.schaufler@intel.com> wrote:
> > > A ptrace access check with mode PTRACE_MODE_SCHED gets called
> > > from process switching code. This precludes the use of audit,
> > > as the locking is incompatible. Don't do audit in the PTRACE_MODE_SCHED
> > > case.
> > >
> > > Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
> > > ---
> > >  security/smack/smack_lsm.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > > index 340fc30ad85d..ffa95bcab599 100644
> > > --- a/security/smack/smack_lsm.c
> > > +++ b/security/smack/smack_lsm.c
> > > @@ -422,7 +422,8 @@ static int smk_ptrace_rule_check(struct task_struct
> > *tracer,
> > >         struct task_smack *tsp;
> > >         struct smack_known *tracer_known;
> > >
> > > -       if ((mode & PTRACE_MODE_NOAUDIT) == 0) {
> > > +       if ((mode & PTRACE_MODE_NOAUDIT) == 0 &&
> > > +           (mode & PTRACE_MODE_SCHED) == 0) {
> >
> > If you ORed PTRACE_MODE_NOAUDIT into the flags when calling the
> > security hook, you could drop this patch, right?
>
> Yes. Since the PTRACE_MODE_NOAUDIT was in PTRACE_MODE_IBPB
> in Jiri's previous patch set and not in PTRACE_MODE_SCHED in this one
> I assumed that there was a good reason for it.

Jiri, was there a good reason for it, and if so, what was it?
