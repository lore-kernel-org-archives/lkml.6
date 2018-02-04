Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbeBDUBm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 15:01:42 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37676 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbeBDUBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 15:01:33 -0500
X-Google-Smtp-Source: AH8x227i38XpzJNoBxugNxwGrXKsuESP8FyD792y2bcmNwPJIeH+ZbcuNYr8sSwGVtn86flehoL+GQ==
Date: Sun, 4 Feb 2018 21:01:29 +0100
From: Tycho Andersen <tycho@tycho.ws>
To: Andy Lutomirski <luto@amacapital.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
Subject: Re: [RFC 1/3] seccomp: add a return code to trap to userspace
Message-ID: <20180204200129.2bgq5yfaimg6xdg5@cisco>
References: <20180204104946.25559-1-tycho@tycho.ws>
 <20180204104946.25559-2-tycho@tycho.ws>
 <CALCETrWgu5n+SMqrsZQ7MVYPtzs8otuc7hpA5uPH+JNtFrMBkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWgu5n+SMqrsZQ7MVYPtzs8otuc7hpA5uPH+JNtFrMBkQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Sun, Feb 04, 2018 at 05:36:33PM +0000, Andy Lutomirski wrote:
> > The actual implementation of this is fairly small, although getting the
> > synchronization right was/is slightly complex. Also worth noting that there
> > is one race still present:
> >
> >   1. a task does a SECCOMP_RET_USER_NOTIF
> >   2. the userspace handler reads this notification
> >   3. the task dies
> >   4. a new task with the same pid starts
> >   5. this new task does a SECCOMP_RET_USER_NOTIF, gets the same cookie id
> >      that the previous one did
> >   6. the userspace handler writes a response
> 
> I'm slightly confused.  I thought the id was never reused for a given
> struct seccomp_filter.  (Also, shouldn't the id be u64, not u32?)

Well, what happens when u32/64 overflows? Eventually it will wrap.

> On very quick reading, I have a question.  What happens if a process
> has two seccomp_filters attached, one of them returns
> SECCOMP_RET_USER_NOTIF, and the *other* one has a listener?

Good question, in seccomp_run_filters(), the first (lowest, last
applied) filter who returns SECCOMP_RET_USER_NOTIF is the one that
gets the notification and the other receives nothing.

I don't really have any reason to prefer this behavior, it's just what
happened without much thought.

Cheers,

Tycho
