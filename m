Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B185C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C19D2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550678700;
	bh=TNODcwapPqxUHfshxdDeOHr9xdhiqqns8TC6/oTJLO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=okxjgHYlOOMPlzn2SE86LlFVkP2/S4I2Dw/+AvCBeLE+qYvyI3C22XKNSf1lvzmIR
	 T4fKCHRS16hMkUpbj5Vv2sui58EQWfxHd4XI97PKJiCOidU+9TZvkzuryxuN4W09w4
	 Afni2YUxA4lD8qQCP7cUQozYMTY+bjRDqG21EF2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfBTQE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:04:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:37380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfBTQE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:04:58 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49BFF2084D;
        Wed, 20 Feb 2019 16:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550678696;
        bh=TNODcwapPqxUHfshxdDeOHr9xdhiqqns8TC6/oTJLO0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GD2Hw11P8TF/GJf5gacE9LF9pD+ZzEBdBwsU8ae9bpC/CRd6LxBoWxKozXgzctf3c
         TvwY+Wej925OWh6vuER+DTmORIwniGCtCayLHVs+aKJpNe9KGakyPO3RKHHg3KLVxk
         xnCCiba2YXQbnN3P2Ch602g2wtAuf4k1z1ajhUZY=
Date:   Thu, 21 Feb 2019 01:04:53 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-Id: <20190221010453.19538ae7ef2667371dcec34f@kernel.org>
In-Reply-To: <20190220094926.0ab575b3@gandalf.local.home>
References: <20190215174712.372898450@goodmis.org>
        <20190215174945.557218316@goodmis.org>
        <CAHk-=wjP4bEYCFaKZVG4kLWmYBctyfsW9jjhC91tiTk9WwB8Rg@mail.gmail.com>
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
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 09:49:26 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 20 Feb 2019 17:10:19 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Let me ensure what you want. So you want to access a "string" in user-space,
> > not a data structure? In that case, it is very easy to me. It is enough to
> > add a "ustring" type to kprobe events. For example, do_sys_opsn's path 
> > variable is one example. That will be +0(+0(%si)):ustring, and fetcher
> > finally copy the string using strncpy_from_user() instead of 
> > strncpy_from_unsafe(). (*)
> 
> ustring would be good.

OK.

> 
> > 
> > But if you consider to access a field in a data-structure in user space,
> > it might need some more work (E.g. ioctl's parameter), becase if the __user
> > pointer to the data structure is on the memory, we have to dereference 
> > the address inside kernel using probe_kernel_read(), but after getting 
> > the data strucutre address, we have to dereference the address with copy_from_user().
> > At this moment, we have no such strong syntax... 
> > 
> > To solve that, maybe we need to introduce something like "back reference"
> > of arguments in the event, e.g.
> > 
> > p somewhere user_data=+0(%si) field_val=+8(\user_data):u32:user
> > 
> > or
> > 
> > p somewhere +0(%si) field_val=+8(\1):u32:user
> > 
> > This ":user" additional suffix tells kprobe events to change fetching method 
> > to fetch the data by copy_from_user().
> 
> What about just adding 'u' to the end of the offset? Say you have a
> data structure in kernel space that has a field in user space you want
> to reference?
> 
> 
> 	field_val=+8u(+0(%si))

Ah, that looks good :~) thank you for this idea!

> 
> Although, I would say having ways to access current parameters may also
> be a nice touch ;-)

Hehe, OK, let's implement both.

Thanks!

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
