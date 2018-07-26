Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB425C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900572088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900572088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbeGZKig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:38:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53778 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbeGZKig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:38:36 -0400
Received: from localhost (85-69-146-4.rev.numericable.fr [85.69.146.4])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6E90DC84;
        Thu, 26 Jul 2018 09:22:38 +0000 (UTC)
Date:   Thu, 26 Jul 2018 11:22:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     stable@vger.kernel.org, Michal Marek <mmarek@suse.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [stable 4.14] turn off -Wattribute-alias
Message-ID: <20180726092231.GA6916@kroah.com>
References: <20180726081358.3829157-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726081358.3829157-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 10:13:22AM +0200, Arnd Bergmann wrote:
> Starting with gcc-8.1, we get a warning about all system call definitions,
> which use an alias between functions with incompatible prototypes, e.g.:
> 
> In file included from ../mm/process_vm_access.c:19:
> ../include/linux/syscalls.h:211:18: warning: 'sys_process_vm_readv' alias between functions of incompatible types 'long int(pid_t,  const struct iovec *, long unsigned int,  const struct iovec *, long unsigned int,  long unsigned int)' {aka 'long int(int,  const struct iovec *, long unsigned int,  const struct iovec *, long unsigned int,  long unsigned int)'} and 'long int(long int,  long int,  long int,  long int,  long int,  long int)' [-Wattribute-alias]
>   asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>                   ^~~
> ../include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
>   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>   ^~~~~~~~~~~~~~~~~
> ../include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL_DEFINEx'
>  #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
>                                     ^~~~~~~~~~~~~~~
> ../mm/process_vm_access.c:300:1: note: in expansion of macro 'SYSCALL_DEFINE6'
>  SYSCALL_DEFINE6(process_vm_readv, pid_t, pid, const struct iovec __user *, lvec,
>  ^~~~~~~~~~~~~~~
> ../include/linux/syscalls.h:215:18: note: aliased declaration here
>   asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>                   ^~~
> ../include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
>   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>   ^~~~~~~~~~~~~~~~~
> ../include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL_DEFINEx'
>  #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
>                                     ^~~~~~~~~~~~~~~
> ../mm/process_vm_access.c:300:1: note: in expansion of macro 'SYSCALL_DEFINE6'
>  SYSCALL_DEFINE6(process_vm_readv, pid_t, pid, const struct iovec __user *, lvec,
> 
> This is really noisy and does not indicate a real problem. In the latest
> mainline kernel, this was addressed by commit bee20031772a ("disable
> -Wattribute-alias warning for SYSCALL_DEFINEx()"), which seems too invasive
> to backport.

Too invasive?

Here's the diffstat:
	 include/linux/compat.h   |    8 +++++++-
	 include/linux/syscalls.h |    4 ++++
	 2 files changed, 11 insertions(+), 1 deletion(-)

That seems almost trivial to backport.  Did you try it and it caused
other problems?

Where ever possible, I always want to use the upstream commits.

thanks,

greg k-h
