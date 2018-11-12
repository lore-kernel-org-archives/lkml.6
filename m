Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F4BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD83F208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD83F208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbeKLLop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:44:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729911AbeKLLop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:44:45 -0500
Received: from vmware.local.home (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AC1B2087F;
        Mon, 12 Nov 2018 01:53:54 +0000 (UTC)
Date:   Sun, 11 Nov 2018 20:53:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     kernel-hardening@lists.openwall.com,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] stackleak: Disable ftrace for stackleak.c
Message-ID: <20181111205351.1874bb1e@vmware.local.home>
In-Reply-To: <eeb7f5ee-1e2e-d37b-cca2-e0a29826e8eb@linux.com>
References: <1541887530-16610-1-git-send-email-alex.popov@linux.com>
        <20181110183011.2290fc20@gandalf.local.home>
        <eeb7f5ee-1e2e-d37b-cca2-e0a29826e8eb@linux.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2018 13:19:45 +0300
Alexander Popov <alex.popov@linux.com> wrote:

> On 11.11.2018 2:30, Steven Rostedt wrote:
> > On Sun, 11 Nov 2018 01:05:30 +0300
> > Alexander Popov <alex.popov@linux.com> wrote:
> >   
> >> The stackleak_erase() function is called on the trampoline stack at the
> >> end of syscall. This stack is not big enough for ftrace operations,
> >> e.g. it can be overflowed if we enable kprobe_events for stackleak_erase().  
> > 
> > Is the issue with kprobes or with function tracing? Because this stops
> > function tracing which I only want disabled if function tracing itself
> > is an issue, not for other things that may use the function tracing
> > infrastructure.  
> 
> Hello Steven,
> 
> I believe that stackleak erasing is not compatible with function tracing itself.
> That's what the kernel testing robot has hit:
> https://www.openwall.com/lists/kernel-hardening/2018/11/09/1
> 
> I used kprobe_events just to reproduce the problem:
> https://www.openwall.com/lists/kernel-hardening/2018/11/09/4

Have you tried adding a "notrace" to stackleak_erase()?

Not tracing the entire file is a bit of overkill. There's no reason
ftrace can't trace stack_erasing_sysctl() or perhaps even
stackleak_track_stack() as that may be very interesting to trace.

-- Steve
