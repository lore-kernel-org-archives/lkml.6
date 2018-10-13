Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A26DC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 06:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE722064A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 06:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dzr0mVbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE722064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeJMOQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 10:16:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbeJMOQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 10:16:22 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75B61205C9;
        Sat, 13 Oct 2018 06:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539412826;
        bh=fwsRFWSwCJBasfStUyw3Uh+/7yyN0ASQwDc5TZlMQFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dzr0mVbisFs4BwFD16wok84W9hjx+Vtf4lNFEM7DXD0qKACqlO8sHbQqENBcrCd1Q
         GP3zX+ziTHq1j+/wtWefQDuyLMkNelUTl7pv4JjvyQuaCFwRcQ7xe7Y9850unNEhbx
         lhML9NGiKSMUS5GD8jSihMtqw/HCP/RHSxqejvWE=
Date:   Sat, 13 Oct 2018 08:40:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Enke Chen <enkechen@cisco.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Victor Kamensky (kamensky)" <kamensky@cisco.com>,
        xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
Message-ID: <20181013064023.GA28177@kroah.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 05:33:35PM -0700, Enke Chen wrote:
> For simplicity and consistency, this patch provides an implementation
> for signal-based fault notification prior to the coredump of a child
> process. A new prctl command, PR_SET_PREDUMP_SIG, is defined that can
> be used by an application to express its interest and to specify the
> signal (SIGCHLD or SIGUSR1 or SIGUSR2) for such a notification. A new
> signal code (si_code), CLD_PREDUMP, is also defined for SIGCHLD.
> 
> Background:
> 
> As the coredump of a process may take time, in certain time-sensitive
> applications it is necessary for a parent process (e.g., a process
> manager) to be notified of a child's imminent death before the coredump
> so that the parent process can act sooner, such as re-spawning an
> application process, or initiating a control-plane fail-over.
> 
> Currently there are two ways for a parent process to be notified of a
> child process's state change. One is to use the POSIX signal, and
> another is to use the kernel connector module. The specific events and
> actions are summarized as follows:
> 
> Process Event    POSIX Signal                Connector-based
> ----------------------------------------------------------------------
> ptrace_attach()  do_notify_parent_cldstop()  proc_ptrace_connector()
>                  SIGCHLD / CLD_STOPPED
> 
> ptrace_detach()  do_notify_parent_cldstop()  proc_ptrace_connector()
>                  SIGCHLD / CLD_CONTINUED
> 
> pre_coredump/    N/A                         proc_coredump_connector()
> get_signal()
> 
> post_coredump/   do_notify_parent()          proc_exit_connector()
> do_exit()        SIGCHLD / exit_signal
> ----------------------------------------------------------------------
> 
> As shown in the table, the signal-based pre-coredump notification is not
> currently available. In some cases using a connector-based notification
> can be quite complicated (e.g., when a process manager is written in shell
> scripts and thus is subject to certain inherent limitations), and a
> signal-based notification would be simpler and better suited.
> 
> Signed-off-by: Enke Chen <enkechen@cisco.com>
> ---
>  arch/x86/kernel/signal_compat.c    |  2 +-
>  include/linux/sched.h              |  4 ++
>  include/linux/signal.h             |  5 +++
>  include/uapi/asm-generic/siginfo.h |  3 +-
>  include/uapi/linux/prctl.h         |  4 ++
>  kernel/fork.c                      |  1 +
>  kernel/signal.c                    | 51 +++++++++++++++++++++++++
>  kernel/sys.c                       | 77 ++++++++++++++++++++++++++++++++++++++
>  8 files changed, 145 insertions(+), 2 deletions(-)

Shouldn't there also be a manpage update, and a kselftest added for this
new user/kernel api that is being created?

thanks,

greg k-h
