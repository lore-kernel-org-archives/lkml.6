Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D2AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F5C20895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F5C20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbeG0Kkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:40:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47398 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730340AbeG0Kkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:40:41 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EBA9FAF8;
        Fri, 27 Jul 2018 09:19:41 +0000 (UTC)
Date:   Fri, 27 Jul 2018 11:19:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "# 3.4.x" <stable@vger.kernel.org>, Michal Marek <mmarek@suse.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [stable 4.14] turn off -Wattribute-alias
Message-ID: <20180727091939.GA12736@kroah.com>
References: <20180726081358.3829157-1-arnd@arndb.de>
 <20180726092231.GA6916@kroah.com>
 <CAK8P3a3g7VSu3W0DiMcUdLB0b1fmUaHJxEyC30K8EfP5a9T1ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3g7VSu3W0DiMcUdLB0b1fmUaHJxEyC30K8EfP5a9T1ig@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 12:02:42PM +0200, Arnd Bergmann wrote:
> On Thu, Jul 26, 2018 at 11:22 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Thu, Jul 26, 2018 at 10:13:22AM +0200, Arnd Bergmann wrote:
> >> Starting with gcc-8.1, we get a warning about all system call definitions,
> >> which use an alias between functions with incompatible prototypes, e.g.:
> >>
> >> In file included from ../mm/process_vm_access.c:19:
> >> ../include/linux/syscalls.h:211:18: warning: 'sys_process_vm_readv' alias between functions of incompatible types 'long int(pid_t,  const struct iovec *, long unsigned int,  const struct iovec *, long unsigned int,  long unsigned int)' {aka 'long int(int,  const struct iovec *, long unsigned int,  const struct iovec *, long unsigned int,  long unsigned int)'} and 'long int(long int,  long int,  long int,  long int,  long int,  long int)' [-Wattribute-alias]
> >>   asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
> >>                   ^~~
> >> ../include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
> >>   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
> >>   ^~~~~~~~~~~~~~~~~
> >> ../include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL_DEFINEx'
> >>  #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
> >>                                     ^~~~~~~~~~~~~~~
> >> ../mm/process_vm_access.c:300:1: note: in expansion of macro 'SYSCALL_DEFINE6'
> >>  SYSCALL_DEFINE6(process_vm_readv, pid_t, pid, const struct iovec __user *, lvec,
> >>  ^~~~~~~~~~~~~~~
> >> ../include/linux/syscalls.h:215:18: note: aliased declaration here
> >>   asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
> >>                   ^~~
> >> ../include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
> >>   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
> >>   ^~~~~~~~~~~~~~~~~
> >> ../include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL_DEFINEx'
> >>  #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
> >>                                     ^~~~~~~~~~~~~~~
> >> ../mm/process_vm_access.c:300:1: note: in expansion of macro 'SYSCALL_DEFINE6'
> >>  SYSCALL_DEFINE6(process_vm_readv, pid_t, pid, const struct iovec __user *, lvec,
> >>
> >> This is really noisy and does not indicate a real problem. In the latest
> >> mainline kernel, this was addressed by commit bee20031772a ("disable
> >> -Wattribute-alias warning for SYSCALL_DEFINEx()"), which seems too invasive
> >> to backport.
> >
> > Too invasive?
> >
> > Here's the diffstat:
> >          include/linux/compat.h   |    8 +++++++-
> >          include/linux/syscalls.h |    4 ++++
> >          2 files changed, 11 insertions(+), 1 deletion(-)
> >
> > That seems almost trivial to backport.  Did you try it and it caused
> > other problems?
> >
> > Where ever possible, I always want to use the upstream commits.
> 
> I forward ported that patch a few times across kernels when that macro
> changed in subtle ways. This was particularly tricky as some using the
> new macro inside of another macro sometimes has different effects
> based on seemingly unrelated changes: in particular the addition of
> __MAP() in COMPAT_SYSCALL_DEFINEx that I had to do to work
> around gcc pr83256 can easily break.
> 
> It also depends on commit 8793bb7f4a9d ("kbuild: add macro for
> controlling warnings to linux/compiler.h") before it, which is not long
> but does add new infrastructure.

Ah, yeah, that's a mess.  Ok, I'll go queue these up, thanks.  Maybe I
can finally move to gcc-8 now :)

thanks,

greg k-h
