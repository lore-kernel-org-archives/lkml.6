Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EEDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EEE214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2L9sN0Kq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EEE214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbeKLMmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 07:42:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:49610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730260AbeKLMmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 07:42:06 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE68120881;
        Mon, 12 Nov 2018 02:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541991063;
        bh=8ZP9A9bYAHBJPDaWSaqzCqZIJ2bVA0w1izDTg1cOkdI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2L9sN0KqZH0YkM8jeYL/bs7dkmk0oNI7sNfszQxPMeo6cx42mTXkBHgrrF84VqCxB
         cdJyAjEXzEC+UB3PnIY20lz14qicPy63rEEjv1lNvKIoEcoNfDGR95Pf/rkS8Pq5Tr
         nOyP4FwXxng5mkEMgPNvw6h460Ridm1eCt6CNiPM=
Date:   Mon, 12 Nov 2018 11:50:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        kernel-hardening@lists.openwall.com,
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
Message-Id: <20181112115058.39e98750750c91eeb349cfdf@kernel.org>
In-Reply-To: <20181111205351.1874bb1e@vmware.local.home>
References: <1541887530-16610-1-git-send-email-alex.popov@linux.com>
        <20181110183011.2290fc20@gandalf.local.home>
        <eeb7f5ee-1e2e-d37b-cca2-e0a29826e8eb@linux.com>
        <20181111205351.1874bb1e@vmware.local.home>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander and Steve,

On Sun, 11 Nov 2018 20:53:51 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 11 Nov 2018 13:19:45 +0300
> Alexander Popov <alex.popov@linux.com> wrote:
> 
> > On 11.11.2018 2:30, Steven Rostedt wrote:
> > > On Sun, 11 Nov 2018 01:05:30 +0300
> > > Alexander Popov <alex.popov@linux.com> wrote:
> > >   
> > >> The stackleak_erase() function is called on the trampoline stack at the
> > >> end of syscall. This stack is not big enough for ftrace operations,
> > >> e.g. it can be overflowed if we enable kprobe_events for stackleak_erase().  
> > > 
> > > Is the issue with kprobes or with function tracing? Because this stops
> > > function tracing which I only want disabled if function tracing itself
> > > is an issue, not for other things that may use the function tracing
> > > infrastructure.  
> > 
> > Hello Steven,
> > 
> > I believe that stackleak erasing is not compatible with function tracing itself.
> > That's what the kernel testing robot has hit:
> > https://www.openwall.com/lists/kernel-hardening/2018/11/09/1
> > 
> > I used kprobe_events just to reproduce the problem:
> > https://www.openwall.com/lists/kernel-hardening/2018/11/09/4
> 
> Have you tried adding a "notrace" to stackleak_erase()?
> 
> Not tracing the entire file is a bit of overkill. There's no reason
> ftrace can't trace stack_erasing_sysctl() or perhaps even
> stackleak_track_stack() as that may be very interesting to trace.

I think it is not enough for stopping kprobes. If you want to stop the kprobes
(int3 version) on stackleak_erase(), you should use NOKPROBE_SYMBOL(stackleak_erase),
since kprobes can work without ftrace. 

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
