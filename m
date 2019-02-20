Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7764BC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0E42147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550675329;
	bh=H4xMU4YgNwkaIhgEmxjar2r4Os3LG9Sk4j9h4UVmSqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=c78A6mHVyOxw9PJctQ/vGM2Acd5S/FNXoQp37Ni0iqavYOEjqImhcqaWSEL8sHX2P
	 oPZs0PL4CiTONnhLNdy+rUgFFQiPH5sEb63BdM+Q1perNJKn+yXMde7Sh2IwqUKIRi
	 dRgEldeoCAw3rV9K/4W8gI93++a1+n/BsFDkZeDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfBTPIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:08:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:33380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfBTPIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:08:47 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F8AD20859;
        Wed, 20 Feb 2019 15:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550675326;
        bh=H4xMU4YgNwkaIhgEmxjar2r4Os3LG9Sk4j9h4UVmSqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JCWxlWiWmb+kjT6/n6HizN9LkTnMGU+wZZnalTo1wTNNG7VFjjUb+HvMd5o5syo9i
         G8maY4PN/BQMPCwP8m8eERi9Tni+uG2z/ZsaQGCwtu17I8lFgfOWcnTpekkdKy9h5q
         1ZVH4DWqfKeVpEhVqHUk7+AXrMqVXGHL8nPxulFk=
Date:   Thu, 21 Feb 2019 00:08:42 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-Id: <20190221000842.7026d2e4d5af89602aa5013c@kernel.org>
In-Reply-To: <CAG48ez0e5b0qmW1kMVEYDKvxn=-FkfRw=0KXUm5_R3aAGU-LJA@mail.gmail.com>
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
        <CAG48ez0e5b0qmW1kMVEYDKvxn=-FkfRw=0KXUm5_R3aAGU-LJA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jann,

On Wed, 20 Feb 2019 14:57:31 +0100
Jann Horn <jannh@google.com> wrote:

> On Wed, Feb 20, 2019 at 9:10 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > On Tue, 19 Feb 2019 14:03:30 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > > > Basically, a kprobe is mostly used for debugging what's happening in a
> > > > > live kernel, to read any address.
> > > >
> > > > My point is that "any address" is not sufficient to begin with. You
> > > > need "kernel or user".
> > > >
> > > > Having a flag for what _kind_ of kernel address is ok might then be
> > > > required for other cases if they might not be ok with following page
> > > > tables to IO space..
> > > >
> > >
> > > Good point. Looks like we should add a new flag for kprobe
> > > trace parameters, that tell kprobes if the address is expected to be
> > > user or kernel. That would be good regardless of the duplicate
> > > meanings, as we could use copy_from_user without touching KERNEL_DS, if
> > > the probe argument specifically states "this is user space". For
> > > example, when probing do_sys_open, and you want to read what path string
> > > was passed into the kernel.
> > >
> > > Masami, thoughts?
> >
> > Let me ensure what you want. So you want to access a "string" in user-space,
> > not a data structure? In that case, it is very easy to me. It is enough to
> > add a "ustring" type to kprobe events. For example, do_sys_opsn's path
> > variable is one example. That will be +0(+0(%si)):ustring, and fetcher
> > finally copy the string using strncpy_from_user() instead of
> > strncpy_from_unsafe(). (*)
> [...]
> > (*) BTW, there is another concern to use _from_user APIs in kprobe. Are those
> > APIs might sleep??
> 
> If you want to access userspace without sleeping, and ignore data in
> non-present pages, you can do `pagefault_disable(); err =
> __copy_from_user_inatomic(...); pagefault_enable();`. (Actually, maybe
> the kernel should have a helper for that...)

Ok, we are going back to the start point of this thread :)

http://lkml.kernel.org/r/20190215174712.372898450@goodmis.org

So, if user tells kprobe it is user-pointer, we check it with access_ok(),
and will do something similar to the strnlen_user() and strncpy_from_user(),
but using __copy_from_user_inatomic() and pagefault_disable() for kprobes.

Thank you!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
