Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA1DECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F8521473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F8521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeJRKd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 06:33:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbeJRKd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 06:33:29 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E70C521470;
        Thu, 18 Oct 2018 02:34:48 +0000 (UTC)
Date:   Wed, 17 Oct 2018 22:34:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC][PATCH] x86: ptrace: Add function argument access API
Message-ID: <20181017223447.0cdcd422@vmware.local.home>
In-Reply-To: <20181015235646.2cbb7dc9bc4b7b54f900e0fb@kernel.org>
References: <20181011230021.0a7604fa@vmware.local.home>
        <20181012122641.3d87ed29@gandalf.local.home>
        <CALCETrXn9zKTb9i1LP3qoFcpqZHF34BdkuZ5D3N0uCmRr+VnbA@mail.gmail.com>
        <20181012155439.59f77556@gandalf.local.home>
        <20181015235646.2cbb7dc9bc4b7b54f900e0fb@kernel.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018 23:56:46 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Fri, 12 Oct 2018 15:54:39 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 12 Oct 2018 11:21:28 -0700
> > Andy Lutomirski <luto@amacapital.net> wrote:
> >   
> > > On Fri, Oct 12, 2018 at 9:26 AM Steven Rostedt <rostedt@goodmis.org> wrote:  
> > > >
> > > >
> > > > Anyone have any issues with this patch?
> > > >    
> > > 
> > > I'm conceptually okay with it.  That being said,
> > > regs_within_kernel_stack(), which you're indirectly using, is
> > > off-by-a-few.  And updating it to use probe_kernel_read() might be
> > > nice for robustness.
> > >   
> > 
> > Something like this?
> > 
> > -- Steve
> > 
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > Date: Fri, 12 Oct 2018 15:44:20 -0400
> > Subject: [PATCH] x86: ptrace.h: Add regs_get_kernel_stack_nth_safe() function
> > 
> > Andy had some concerns about using regs_get_kernel_stack_nth() in a new
> > function regs_get_kernel_argument() as if there's any error in the stack
> > code, it could cause a bad memory access. Instead, add a new function called
> > regs_get_kernel_stack_nth_safe() that does a probe_kernel_read() on the
> > stack address to be extra careful in accessing the memory. To share the
> > code, regs_get_kernel_stack_nth_addr() was added to just return the stack
> > address (or NULL if not on the stack), that both regs_get_kernel_stack_nth()
> > and the _safe() version can use.  
> 
> This patch looks good to me.
> But if the concern is real, all regs_get_kernel_stack_nth() user must move
> onto _safe() version, at least all tracers code.
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> 

Hi Masami,

Can you review my v2 version which implements what you suggest.

Thanks,

-- Steve
