Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EE3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8A1222D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438666AbfBNNEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:04:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:53560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391390AbfBNNEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:04:21 -0500
Received: from vmware.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D0B1222B6;
        Thu, 14 Feb 2019 13:04:20 +0000 (UTC)
Date:   Thu, 14 Feb 2019 08:04:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] kprobe: safely access memory specified by userspace
Message-ID: <20190214080418.0f12923f@vmware.local.home>
In-Reply-To: <20190214000522.n7ltwbnjl3kufdsn@mail.google.com>
References: <20190125151051.7381-1-changbin.du@gmail.com>
        <20190213143638.y54hghilbyastlpo@mail.google.com>
        <20190213104143.5c390b28@gandalf.local.home>
        <20190214000522.n7ltwbnjl3kufdsn@mail.google.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 08:05:24 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> On Wed, Feb 13, 2019 at 10:41:43AM -0500, Steven Rostedt wrote:
> > On Wed, 13 Feb 2019 22:36:40 +0800
> > Changbin Du <changbin.du@gmail.com> wrote:
> >   
> > > Hi Steven,
> > > I think this is a critical issue. Could you give priority to this fix?
> > > 
> > > On Fri, Jan 25, 2019 at 11:10:50PM +0800, Changbin Du wrote:  
> > > > The userspace can ask kprobe to intercept strings at any memory address,
> > > > including invalid kernel address. In this case, fetch_store_strlen()
> > > > would crash since it uses general usercopy function.
> > > > 
> > > > For example, we can crash the kernel by doing something as below:
> > > > 
> > > > $ sudo kprobe 'p:do_sys_open +0(+0(%si)):string'  
> > 
> > Note, I'm not able to reproduce this.
> > 
> > I just get:
> > 
> >         sendmail-1085  [001] ....   277.344573: open: (do_sys_open+0x0/0x210) arg1=(fault)
> >            <...>-1550  [003] ....   279.879011: open: (do_sys_open+0x0/0x210) arg1=(fault)
> >            <...>-1550  [003] ....   279.879056: open: (do_sys_open+0x0/0x210) arg1=(fault)
> >            <...>-1550  [003] ....   279.879079: open: (do_sys_open+0x0/0x210) arg1=(fault)
> >            <...>-1550  [003] ....   279.879132: open: (do_sys_open+0x0/0x210) arg1=(fault)
> >            <...>-1550  [003] ....   279.879683: open: (do_sys_open+0x0/0x210) arg1=(fault)
> >            <...>-1550  [003] ....   279.881521: open: (do_sys_open+0x0/0x210) arg1=(fault)
> >            <...>-1550  [003] ....   279.881541: open: (do_sys_open+0x0/0x210) arg1=""
> >            <...>-1597  [005] ....   280.907662: open: (do_sys_open+0x0/0x210) arg1=(fault)
> >            <...>-1597  [005] ....   280.907694: open: (do_sys_open+0x0/0x210) arg1=(fault)
> >            <...>-1597  [005] ....   280.907772: open: (do_sys_open+0x0/0x210) arg1=(fault)
> >            <...>-1597  [005] ....   280.907825: open: (do_sys_open+0x0/0x210) arg1=(fault)
> >            <...>-1597  [005] ....   280.907891: open: (do_sys_open+0x0/0x210) arg1=(fault)
> >            <...>-1597  [005] ....   280.907947: open: (do_sys_open+0x0/0x210) arg1=(fault)
> > 
> >   
> > > > 
> > > > [  103.620391] BUG: GPF in non-whitelisted uaccess (non-canonical address?)
> > > > [  103.622104] general protection fault: 0000 [#1] SMP PTI
> > > > [  103.623424] CPU: 10 PID: 1046 Comm: cat Not tainted 5.0.0-rc3-00130-gd73aba1-dirty #96
> > > > [  103.625321] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-2-g628b2e6-dirty-20190104_103505-linux 04/01/2014
> > > > [  103.628284] RIP: 0010:process_fetch_insn+0x1ab/0x4b0  
> > 
> > What line number is the RIP on?
> >  
> I still can reproduce this bug on mainline (1f947a7a011fcceb14cb912f5481a53b18f1879a).
> But it seems your linux has already fix this issue.


No I didn't have the fix. I was running an older kernel actually. One
before commit 9da3f2b74054406f87dff7101a569217ffceb29b was added.
There's nothing actually wrong with that code, since kprobes is allowed
to poke at anything. But that commit considers the kernel using copy
from user to poke kernel address space is a security bug.

So yeah, I agree your patch should be added with a stable tag, with a
Fixes: with that commit, since that commit is what causes it to bug.

I'll apply it and start testing it.

-- Steve
