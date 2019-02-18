Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10AEC10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BD6218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550492796;
	bh=lNKKnPuGUSMkXxUwapbfZcJqhufzShpsAeCuxIyiPyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=adJ8m6LxUOh/O1/YuROVJwhqdm3nr/zNGPFTii02jCamQWATJPUZ075TPh6seaWZY
	 pKRQwW0o6CZeKIwhW05XTTf09LjQLvOVETSq1/JD3ajmrFaCaMiNEQeNwHPHWDzRSz
	 FTeBfta8B+QnHxBfvDahutEF60aK30OghiMf+Jyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbfBRM0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:26:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728874AbfBRM0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:26:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8113217F5;
        Mon, 18 Feb 2019 12:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550492794;
        bh=lNKKnPuGUSMkXxUwapbfZcJqhufzShpsAeCuxIyiPyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VNic33GpUXkwI72zKwF58dPp8DN99wXqX2hiP2+lRbu6FreFoaHweKA12hvJPyhi0
         kUNAoYu7KUKiPi48F3o54fkUmqXrMq0mGByjRpEJRK68NLzUbtupEUkDiHbWrShnP9
         bxKfWXyL8XsPi4X64Ktix1IJPtfJMGnmLoowUags=
Date:   Mon, 18 Feb 2019 13:26:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        William Cohen <wcohen@redhat.com>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lttng@reliableembeddedsystems.com,
        lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: BUG: optimized kprobes illegal instructions in v4.19 stable
 kernels
Message-ID: <20190218122631.GE30260@kroah.com>
References: <342740659.2887.1549307721609.JavaMail.zimbra@efficios.com>
 <CAGXu5jJYbc0xhQGqS6L43o_1tOdWmL=rhRmu_L8qT4-tOheHPw@mail.gmail.com>
 <20190206134115.baba291e33022a2f6b6ae5f8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206134115.baba291e33022a2f6b6ae5f8@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 01:41:15PM +0900, Masami Hiramatsu wrote:
> On Tue, 5 Feb 2019 15:06:10 +0000
> Kees Cook <keescook@chromium.org> wrote:
> 
> > On Mon, Feb 4, 2019 at 7:15 PM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> > >
> > > Hi,
> > >
> > > I notice this commit as a possible culprit of the illegal instructions my lttng
> > > users are noticing on arm32 when using kprobes on a v4.19.13 Linux kernel
> > > in a Yocto environment [1]. They were able to reproduce the issue with perf
> > > as well.
> > >
> > > commit e46daee53bb50bde38805f1823a182979724c229
> > > Author: Kees Cook <keescook@chromium.org>
> > > Date:   Tue Oct 30 22:12:56 2018 +0100
> > >
> > >     ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE
> > >
> > > I *think* the intent there was to do
> > >
> > > -       memcpy(code, &optprobe_template_entry,
> > > +       memcpy(code, (unsigned long *)&optprobe_template_entry,
> > >
> > > But if you look at the commit, the "&" seems to have been stripped away,
> > > which happens to change the behavior significantly.
> > 
> > Yeah, this was a typo on my part. :(
> 
> Ah, I thought it had been fixed as same as x86.
> On x86, all optprobe_template_* are defined as kprobe_opcode_t [],
> but on arm, it still be kprobe_opcode_t.
> 
> Hmm, but I think we should use kprobe_opcode_t [] or char[] as asm/sections.h does.
> OK, I'll prepare for the change.

Did this ever get fixed in Linus's tree?  If so, what is the git commit
id, I can't seem to find anything...

thanks,

greg k-h
