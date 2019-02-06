Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AD1C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 04:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C43A218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 04:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549428083;
	bh=/VHxJyIBpRzCH+yqtI/5Hc0l7YU9N4pdah5ExIwuEy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xGQgRb03GW8lmU3TPESpjZ8to9k0l5bwlzDeTvX0WS6aik7S7PrQGcN4kDIgnFz7F
	 Xne+3ATn2sZyPr5GemOIJ8emJvWgfog1jd3U1YWmxvT93Kp7EIHbokBR8Mn8icAMw/
	 mj3k6/eDZV4VF000CgqYZWFVYUU9m5R2OdbIQu+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfBFElT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 23:41:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:46656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbfBFElT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 23:41:19 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 525DA218A1;
        Wed,  6 Feb 2019 04:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549428078;
        bh=/VHxJyIBpRzCH+yqtI/5Hc0l7YU9N4pdah5ExIwuEy0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kJcTv9tl7kedIqQ7s/q6H0aaFwvnqvWgLC0F0CiMidsFQ8aLBdJ7aIYSnDnJQ0YxQ
         464KAtKWRM+LYt6tH0OEE3CAQMAY13H9wXOlXGRtyJULC8/OBel7jQCnahKNSVTMHH
         GxGZqXsxIZuaALjfYBIlTyqna+DLsy42viuHnOUU=
Date:   Wed, 6 Feb 2019 13:41:15 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        William Cohen <wcohen@redhat.com>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lttng@reliableembeddedsystems.com,
        lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: BUG: optimized kprobes illegal instructions in v4.19 stable
 kernels
Message-Id: <20190206134115.baba291e33022a2f6b6ae5f8@kernel.org>
In-Reply-To: <CAGXu5jJYbc0xhQGqS6L43o_1tOdWmL=rhRmu_L8qT4-tOheHPw@mail.gmail.com>
References: <342740659.2887.1549307721609.JavaMail.zimbra@efficios.com>
        <CAGXu5jJYbc0xhQGqS6L43o_1tOdWmL=rhRmu_L8qT4-tOheHPw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2019 15:06:10 +0000
Kees Cook <keescook@chromium.org> wrote:

> On Mon, Feb 4, 2019 at 7:15 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
> > Hi,
> >
> > I notice this commit as a possible culprit of the illegal instructions my lttng
> > users are noticing on arm32 when using kprobes on a v4.19.13 Linux kernel
> > in a Yocto environment [1]. They were able to reproduce the issue with perf
> > as well.
> >
> > commit e46daee53bb50bde38805f1823a182979724c229
> > Author: Kees Cook <keescook@chromium.org>
> > Date:   Tue Oct 30 22:12:56 2018 +0100
> >
> >     ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE
> >
> > I *think* the intent there was to do
> >
> > -       memcpy(code, &optprobe_template_entry,
> > +       memcpy(code, (unsigned long *)&optprobe_template_entry,
> >
> > But if you look at the commit, the "&" seems to have been stripped away,
> > which happens to change the behavior significantly.
> 
> Yeah, this was a typo on my part. :(

Ah, I thought it had been fixed as same as x86.
On x86, all optprobe_template_* are defined as kprobe_opcode_t [],
but on arm, it still be kprobe_opcode_t.

Hmm, but I think we should use kprobe_opcode_t [] or char[] as asm/sections.h does.
OK, I'll prepare for the change.

Thank you,


> 
> > Has this change ever been runtime-tested ?
> 
> I thought I had, given the details from the original bug report, but
> clearly it didn't exercise it.
> 
> Thanks for fixing this!
> 
> -Kees
> 
> >
> > It has been backported to:
> > - 4.19 stable as commit 3fe0c68aea21
> > - 4.14 stable as commit f9e0bc710347
> >
> > Thanks,
> >
> > Mathieu
> >
> > [1] https://bugs.lttng.org/issues/1174
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com
> 
> 
> 
> -- 
> Kees Cook


-- 
Masami Hiramatsu <mhiramat@kernel.org>
