Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161165AbeBNRXH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:23:07 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45556 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033384AbeBNRXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:23:05 -0500
X-Google-Smtp-Source: AH8x227jxeCtrxJW1Q0Al1bD/3SMLKMfbmoD2JHUVogvyGqCFzUIh9ZSjzgxpFTGkFCZQdkCoyGwXg==
Date: Wed, 14 Feb 2018 10:23:00 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Sargun Dhillon <sargun@sargun.me>, Paul Moore <pmoore@redhat.com>
Subject: Re: [RFC 1/3] seccomp: add a return code to trap to userspace
Message-ID: <20180214172300.7v2pre4rv4zzrj3s@cisco>
References: <20180204104946.25559-1-tycho@tycho.ws>
 <20180204104946.25559-2-tycho@tycho.ws>
 <CAGXu5jLAAKY19a9iC1PmXRyuwdn1Zxr2Cb318zdzkqgYt8vtdg@mail.gmail.com>
 <20180214152958.cjgwh2k52zji2jxk@cisco>
 <CALCETrXeZZfVzXh7SwKhyB=+ySDk5fhrrdrXrcABsQ=JpQT7Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXeZZfVzXh7SwKhyB=+ySDk5fhrrdrXrcABsQ=JpQT7Tg@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 05:19:52PM +0000, Andy Lutomirski wrote:
> On Wed, Feb 14, 2018 at 3:29 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> > Hey Kees,
> >
> > Thanks for taking a look!
> >
> > On Tue, Feb 13, 2018 at 01:09:20PM -0800, Kees Cook wrote:
> >> On Sun, Feb 4, 2018 at 2:49 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> >> > This patch introduces a means for syscalls matched in seccomp to notify
> >> > some other task that a particular filter has been triggered.
> >> >
> >> > The motivation for this is primarily for use with containers. For example,
> >> > if a container does an init_module(), we obviously don't want to load this
> >> > untrusted code, which may be compiled for the wrong version of the kernel
> >> > anyway. Instead, we could parse the module image, figure out which module
> >> > the container is trying to load and load it on the host.
> >> >
> >> > As another example, containers cannot mknod(), since this checks
> >> > capable(CAP_SYS_ADMIN). However, harmless devices like /dev/null or
> >> > /dev/zero should be ok for containers to mknod, but we'd like to avoid hard
> >> > coding some whitelist in the kernel. Another example is mount(), which has
> >> > many security restrictions for good reason, but configuration or runtime
> >> > knowledge could potentially be used to relax these restrictions.
> >>
> >> Related to the eBPF seccomp thread, can the logic for these things be
> >> handled entirely by eBPF? My assumption is that you still need to stop
> >> the process to do something (i.e. do a mknod, or a mount) before
> >> letting it continue. Is there some "wait for notification" system in
> >> eBPF?
> >
> > I replied in the other thread
> > (https://patchwork.ozlabs.org/cover/872938/#1856642 for those
> > following along at home), but no, at least not that I know of.
> 
> eBPF can call functions.  One of those functions could put the caller
> to sleep.  In fact, I think I once proposed doing this for the seccomp
> logging action as well.

Yes, true. We could always add a bpf_func_map_lookup_wait or
something. I can look into that if it's preferable.
