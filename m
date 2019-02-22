Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E377C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D446207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550824076;
	bh=tGgWPUqyM7wjfcZnqC+wlhCFfiZucxevDE3+vs6rSSo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jf3LXTM8J92zi2lQvlehUH9yCrRRJqcZQ6WLs0e5P1aHR5Gqn9pIkPMP4BZboKydj
	 kZksXk2Xy8iPhM5lq9AWRifzq6ScGQAE699x1DDUclxzYT/DlG4Dh7CUN/wtlAWnT3
	 YvfxIvyq0SNzq/c4zZ9LkHLsLMIvtzghIoOqxC7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfBVI1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:27:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:32892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfBVI1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:27:54 -0500
Received: from devnote (sp49-106-215-210.msf.spmode.ne.jp [49.106.215.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AEFF20700;
        Fri, 22 Feb 2019 08:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550824073;
        bh=tGgWPUqyM7wjfcZnqC+wlhCFfiZucxevDE3+vs6rSSo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gmyjt723Zv6k3orjKs8o0L4j6QHcHCgxd4Woi82DBjrUS28gMP2AXpm1CeW5F5IZx
         CPhD9vP5QQLErSgRyRazM+nbppnwenEXNjamXV+puIyzgO0u5Xhwiq75xoESViUBje
         7Ku9o6YkttOeqJClCMNpIEy93CHwyqn4NMhtZBk8=
Date:   Fri, 22 Feb 2019 17:27:45 +0900
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
Message-Id: <20190222172745.2c7205d62003c0a858e33278@kernel.org>
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
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

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

I've tried to implement ustring and u-offsets, but I got some issues.

- access_ok() warns if it is called in IRQ context (kprobes is.)
- copy_from_user uses access_ok(), so it is not designed for irq handler.

Moreover, if we have different kernel/user address spaces, we have to
assign target user-pages to kernel vma. Can we do that (doesn't it involve
mutex locks)?

If not, I think what we can do "in kprobes" is only probe_kernel_read()
and strncpy_from_unsafe(). This means, on the architechture whoes kernel
address space doesn't map user space, we can not support user-space
data fetching in kprobe evevnts.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
