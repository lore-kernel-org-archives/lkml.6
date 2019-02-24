Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C02CC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF8020842
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551021484;
	bh=cHXgS7TKCxc4NPIVMdxzPzCkvuVf4rFr+Yq/ZtTF+Rs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=BxqSL7MwLUJFJlEgHEWZ3YsvvS1icyHNrTZjL30dNQm5IegWF4OlxM2U00i9ZzA0E
	 q+lB99kRj7sKRSBTS4JzSm/hJ1QW4bbWKwtg0PvdgFgV0Kvh4c3audXBAi+06pJm12
	 p7bOp5M3y4VxDibxshE1F23B1myKMsZmvnwdKnOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfBXPSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 10:18:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbfBXPSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 10:18:02 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37CE020663;
        Sun, 24 Feb 2019 15:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551021481;
        bh=cHXgS7TKCxc4NPIVMdxzPzCkvuVf4rFr+Yq/ZtTF+Rs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zfH+J/KDlFiHOKFAd7P87d3iuSMA6jVTiSsBeutHHdTe9ljV03Lmw7eHj87pAbOJe
         5JUGEu6HPCitxTqDtlo/J2L/drETuWXi+63jGdypa6Zk3KqBhMZ1O4XtCNE8g7qIWm
         YoL018m6d4qP8rYxcQDKJNDJZxpRL+4s4IA4Z4oY=
Date:   Mon, 25 Feb 2019 00:17:57 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-Id: <20190225001757.519f40cd088c05fdd00a9397@kernel.org>
In-Reply-To: <CALCETrVDMhpA-oJnpuEP2j21aK5ZosW2PNskVDxm4MSR6Afqug@mail.gmail.com>
References: <20190215174712.372898450@goodmis.org>
        <20190215171539.4682f0b4@gandalf.local.home>
        <300C4516-A093-43AE-8707-1C42486807A4@amacapital.net>
        <20190215191949.04604191@gandalf.local.home>
        <CAHk-=wgJzNp0R3cVhjBPHTR4X9sOvHdqK4UVFfbsOKQ6L=A_eQ@mail.gmail.com>
        <CAHk-=wh9XrOykA5J9RQ7zaBio-S_D+1AE+rGnBYWSd==pCXh+w@mail.gmail.com>
        <20190219111802.1d6dbaa3@gandalf.local.home>
        <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
        <20190219140330.5dd9e876@gandalf.local.home>
        <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
        <20190220094926.0ab575b3@gandalf.local.home>
        <20190222172745.2c7205d62003c0a858e33278@kernel.org>
        <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org>
        <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
        <20190223124746.d021973004c7c892c3b3fde1@kernel.org>
        <20190223194421.725a03fd@oasis.local.home>
        <CALCETrVDMhpA-oJnpuEP2j21aK5ZosW2PNskVDxm4MSR6Afqug@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Feb 2019 20:38:03 -0800
Andy Lutomirski <luto@kernel.org> wrote:

> On Sat, Feb 23, 2019 at 4:44 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Sat, 23 Feb 2019 12:47:46 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > > Since kprobes handler runs in IRQ context, we can not use access_ok() in it.
> > > (only on x86 + CONFIG_DEBUG_ATOMIC_SLEEP=y)
> >
> > Is it really IRQ context or exception context? That is, one
> > (interrupts) happen for any task, but exceptions happen because of the
> > software that is executed (like a breakpoint). Although you can have a
> > kprobe trigger in an interrupt handler (where user access wouldn't make
> > sense anyway). But there should be no problem with user access from an
> > exception handler.
> >
> 
> Can we just get rid of this might_sleep()?  access_ok() doesn't sleep
> as far as I know.

Hmm, which might_sleep() would you pointed? What I talked was a 
WARN_ON_ONCE(!in_task()) in access_ok() on x86 (only!), and in_task() just
checks preempt_count.

I guess PeterZ assumed that access_ok() is used only with user space access
APIs (e.g. copy_from_user) which can cause page-fault and locks mm (and might
sleep :)), but now we are trying to use access_ok() with new functions which
disables page-fault and just return -EFAULT.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
