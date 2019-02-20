Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4D6C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1009B2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfBTOt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:49:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:45712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfBTOt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:49:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A61C2146E;
        Wed, 20 Feb 2019 14:49:27 +0000 (UTC)
Date:   Wed, 20 Feb 2019 09:49:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <20190220094926.0ab575b3@gandalf.local.home>
In-Reply-To: <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
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
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 17:10:19 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Let me ensure what you want. So you want to access a "string" in user-space,
> not a data structure? In that case, it is very easy to me. It is enough to
> add a "ustring" type to kprobe events. For example, do_sys_opsn's path 
> variable is one example. That will be +0(+0(%si)):ustring, and fetcher
> finally copy the string using strncpy_from_user() instead of 
> strncpy_from_unsafe(). (*)

ustring would be good.

> 
> But if you consider to access a field in a data-structure in user space,
> it might need some more work (E.g. ioctl's parameter), becase if the __user
> pointer to the data structure is on the memory, we have to dereference 
> the address inside kernel using probe_kernel_read(), but after getting 
> the data strucutre address, we have to dereference the address with copy_from_user().
> At this moment, we have no such strong syntax... 
> 
> To solve that, maybe we need to introduce something like "back reference"
> of arguments in the event, e.g.
> 
> p somewhere user_data=+0(%si) field_val=+8(\user_data):u32:user
> 
> or
> 
> p somewhere +0(%si) field_val=+8(\1):u32:user
> 
> This ":user" additional suffix tells kprobe events to change fetching method 
> to fetch the data by copy_from_user().

What about just adding 'u' to the end of the offset? Say you have a
data structure in kernel space that has a field in user space you want
to reference?


	field_val=+8u(+0(%si))

Although, I would say having ways to access current parameters may also
be a nice touch ;-)

-- Steve
