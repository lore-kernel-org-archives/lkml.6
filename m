Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25ECBC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 00:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCED52083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 00:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="st+Ksekr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCED52083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeLGAfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 19:35:08 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46604 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeLGAfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 19:35:08 -0500
Received: by mail-ua1-f68.google.com with SMTP id v24so821358uap.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 16:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6AWiUbgcB+1AYhEhEAdTigTRPux67uFQPFh3IOaNKtc=;
        b=st+KsekrPteo1KyInJ7JUhFD+nG/UsTb7j7/If+IUU6VMRkI23wqokeLxpVe/SEZBc
         TgpJO4fTk7Hc1V8UMz24jLIsaxcvsN6utytMrqZ+uY46f6z+dbqqXuJnz+c+mI0L/cUq
         G7hyQEo21ckeY1dIEjvMbSWiESdaLoILchnMf8uUV4U6wHEZKdZFxXDopOHhii9eGl6b
         EK43XdaAaQqQvLjwfbo8gzOtSaOHfJPULzWaZhW630Yo31IwbO5HBZV4SB9tGCWpn2fQ
         VCXeDDafN1zHSJ5txrHViNtdzRZAjETMj5yZ61njssQw5bkFve22bjC5UUCHpTg9qmWq
         gAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6AWiUbgcB+1AYhEhEAdTigTRPux67uFQPFh3IOaNKtc=;
        b=mLPmqiDfl0KqkQE8nv07Flcz6tZSjWalak3m6MLu65Y3G/tesUgwabLxcqeieLgtbD
         n+mgvcacO7D69TLJg9c69IVW3ANTkmatGqwianiwIjINJ+Jv7260Ww89xYItlDGu/FH2
         kbiAeqeTmC6J/ETZOyv2X4Z+fmUdkMGp78zJH24DihniXNfuvPOG63zh/KzziWMnD+oZ
         /8s2Lbxpnk/+Q+YZ0+CDLoPxHb9dF4WveQDzzCtLnqeTdk+oT+Q0hdLvyxT05qpcyTQf
         01fpD+uDHIK73l0K26wSDmqvZRos6HfHgjmkecAInBMgb3lOI94qcQ8/jAxDL4dop7GK
         UlWA==
X-Gm-Message-State: AA+aEWZxi45pQ2bKLtzWeHI470vRofsp4tWX/7hPVuCvETjr0P847Mpv
        uX89ueZ0U+o1vxj5lytf0TdbWF749N3p1YTHxryXHg==
X-Google-Smtp-Source: AFSGD/WKOwNhXUMuUdAH0pMj1A4THRD3OEDkmwYKdH303vO+vLztS6RE9+d5YKxJaLPZgWphYx2yX+cYTAGywFmS8L4=
X-Received: by 2002:ab0:225a:: with SMTP id z26mr48109uan.100.1544142906665;
 Thu, 06 Dec 2018 16:35:06 -0800 (PST)
MIME-Version: 1.0
References: <20181206121858.12215-1-christian@brauner.io> <87sgzahf7k.fsf@xmission.com>
 <D372C766-572C-4897-8F02-2FD0E72CCFAC@brauner.io> <875zw6bh2z.fsf@xmission.com>
 <20181206193017.wpxls5p3zgjd6rv2@brauner.io> <871s6u9z6u.fsf@xmission.com>
 <20181206213152.gvci7ijr3dokew7w@brauner.io> <87o99y72gi.fsf@xmission.com>
 <20181206223948.gyfdtkgbhtozmpsp@brauner.io> <20181206231742.xxi4ghn24z4h2qki@brauner.io>
 <20181207003124.GA11160@mail.hallyn.com>
In-Reply-To: <20181207003124.GA11160@mail.hallyn.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Thu, 6 Dec 2018 16:34:54 -0800
Message-ID: <CAKOZuevgF7ObKcVvu-iuNK3xLMX2Ze_S+adBEGNZCdfXRibh1A@mail.gmail.com>
Subject: Re: [PATCH v4] signal: add taskfd_send_signal() syscall
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>, tglx@linutronix.de,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 4:31 PM Serge E. Hallyn <serge@hallyn.com> wrote:
>
> On Fri, Dec 07, 2018 at 12:17:45AM +0100, Christian Brauner wrote:
> > On Thu, Dec 06, 2018 at 11:39:48PM +0100, Christian Brauner wrote:
> > > On Thu, Dec 06, 2018 at 03:46:53PM -0600, Eric W. Biederman wrote:
> > > > Christian Brauner <christian@brauner.io> writes:
> > > >
> > > > >> Your intention is to add the thread case to support pthreads once the
> > > > >> process case is sorted out.  So this is something that needs to be made
> > > > >> clear.  Did I miss how you plan to handle threads?
> > > > >
> > > > > Yeah, maybe you missed it in the commit message [2] which is based on a
> > > > > discussion with Andy [3] and Arnd [4]:
> > > >
> > > > Looking at your references I haven't missed it.  You are not deciding
> > > > anything as of yet to keep it simple.  Except you are returning
> > > > EOPNOTSUPP.  You are very much intending to do something.
> > >
> > > That was clear all along and was pointed at every occassion in the
> > > threads. I even went through the hazzle to give you all of the
> > > references when there's lore.kernel.org.
> > >
> > > >
> > > > Decide.  Do you use the flags parameter or is the width of the
> > > > target depending on the flags.
> >
> > Ok, let's try to be constructive. I understand the general concern for
> > the future so let's put a contract into the commit message stating that
> > the width of the target aka *what is signaled* will be based on a flag
> > parameter if we ever extend it:
> >
> > taskfd_send_signal(fd, SIGSTOP, NULL, TASKFD_PGID);
> > taskfd_send_signal(fd, SIGSTOP, NULL, TASKFD_TID);
> >
> > with the current default being
> >
> > taskfd_send_signal(fd, SIGSTOP, NULL, TASKFD_PID);
> >
> > This seems to me the cleanest solution as we only use one type of file
> > descriptor. Can everyone be on board with this? If so I'm going to send
> > out a new version of the patch.
> >
> > Christian
>
> I'm on board with this, but I think you need to also clarify what exactly
> the fd stands for.  I think that (a) userspace should not have to care
> about the struct pid implementation, and so (b) the procfd should stand
> for all the pids.  So when taskfd_send_signal(fd, SIGSTOP, NULL, TASKFD_PGID)
> becomes implemented, then open(/proc/5) will pin all three pids, as will
> open(/proc/5/task/6).

This change doesn't "pin" any PID, and it makes no sense to make a
process FD stand for all its threads. What does that even mean?
