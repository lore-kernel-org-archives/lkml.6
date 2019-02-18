Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90782C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D16221934
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499113;
	bh=x5rqCCDlcQUEpfdG7Tu9J1n9e1g7uq1iRu3Dyf6UIRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NJ/HcLMYIjUg+Z74wPUb8TRIoki8bNG/qf11I3t9tV69/Q4XgKwOousvdALr2I/p6
	 9l/mR5piyYODQoqhZECN0HAhPWabwFV4Kz4B871bebabID2QLyXdyvixSEWFSYGUHv
	 0g1x7BabTIapoeYeQHXc5nurjb2sVbZly9bSYO9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391874AbfBROLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:11:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391808AbfBROLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:11:47 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D965421901;
        Mon, 18 Feb 2019 14:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499106;
        bh=x5rqCCDlcQUEpfdG7Tu9J1n9e1g7uq1iRu3Dyf6UIRo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bzKaiCzPFiID1gR6wo1YVHKIyh49p2R+LQGWYBKt4ucKyui7JDd2pAsaWtrZWI99b
         3iCBAiodeYOwHc+7/qXSqd53wwLlKaCUMX47+X3w6NL1pAfelSXY/jbTC1fV4IDNYX
         UgOdg99lyUadhutHDn6E1KxiN7hedMTzDDamKv1w=
Date:   Mon, 18 Feb 2019 23:11:42 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
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
Message-Id: <20190218231142.5952b62b7dda5ad555272bf2@kernel.org>
In-Reply-To: <20190218122631.GE30260@kroah.com>
References: <342740659.2887.1549307721609.JavaMail.zimbra@efficios.com>
        <CAGXu5jJYbc0xhQGqS6L43o_1tOdWmL=rhRmu_L8qT4-tOheHPw@mail.gmail.com>
        <20190206134115.baba291e33022a2f6b6ae5f8@kernel.org>
        <20190218122631.GE30260@kroah.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 13:26:31 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Feb 06, 2019 at 01:41:15PM +0900, Masami Hiramatsu wrote:
> > On Tue, 5 Feb 2019 15:06:10 +0000
> > Kees Cook <keescook@chromium.org> wrote:
> > 
> > > On Mon, Feb 4, 2019 at 7:15 PM Mathieu Desnoyers
> > > <mathieu.desnoyers@efficios.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I notice this commit as a possible culprit of the illegal instructions my lttng
> > > > users are noticing on arm32 when using kprobes on a v4.19.13 Linux kernel
> > > > in a Yocto environment [1]. They were able to reproduce the issue with perf
> > > > as well.
> > > >
> > > > commit e46daee53bb50bde38805f1823a182979724c229
> > > > Author: Kees Cook <keescook@chromium.org>
> > > > Date:   Tue Oct 30 22:12:56 2018 +0100
> > > >
> > > >     ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE
> > > >
> > > > I *think* the intent there was to do
> > > >
> > > > -       memcpy(code, &optprobe_template_entry,
> > > > +       memcpy(code, (unsigned long *)&optprobe_template_entry,
> > > >
> > > > But if you look at the commit, the "&" seems to have been stripped away,
> > > > which happens to change the behavior significantly.
> > > 
> > > Yeah, this was a typo on my part. :(
> > 
> > Ah, I thought it had been fixed as same as x86.
> > On x86, all optprobe_template_* are defined as kprobe_opcode_t [],
> > but on arm, it still be kprobe_opcode_t.
> > 
> > Hmm, but I think we should use kprobe_opcode_t [] or char[] as asm/sections.h does.
> > OK, I'll prepare for the change.
> 
> Did this ever get fixed in Linus's tree?  If so, what is the git commit
> id, I can't seem to find anything...

I would like to wait for picking up Mathieu's patch which I acked, since
it is simpler and minimum fix. 

https://patchwork.kernel.org/patch/10797511/

After this, I will send my update to change the optprobe_template_*
definitions which will involves wider code, and need to be tested.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
