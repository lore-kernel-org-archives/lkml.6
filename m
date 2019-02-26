Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AB3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 04:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001E421848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 04:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551154576;
	bh=FBt/HHAcXOadsFZiYpiSp4/wgWVVMKwh8p2g1a1IpDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Sq+Yc52ALt9+Ng23a9kyaODO52py7zrqg8nUdIj+KCu8se+28cf/6vVZK5na1RhJn
	 eEMSvqtTFh7JP2dBslU8CL3Z42NS1zhbO/n84Pm32xi9oB9q7H+jQpSNqrWVRRN7Yh
	 NU95UjlRq33FXBMibDpB/9ZhB3qvVeUnj2B7M7FQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfBZEQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 23:16:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfBZEQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 23:16:14 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 980B1206B8;
        Tue, 26 Feb 2019 04:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551154573;
        bh=FBt/HHAcXOadsFZiYpiSp4/wgWVVMKwh8p2g1a1IpDY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ff7ZKrHNaK13iiLSl6nSBfDHkQmO6GotP2SfI9UPxBDUn2ztwZB6lD1ZmutlrgqJv
         pDCSt/n8uaASOqHPRU7L2WLIk9L2FfU+38F3EREPbIE8Oz8qCRZ9DVNHsUn5Ft9FzR
         k8czYzVCoazHjpz1cMuTK966UWaDQIJcysbMrqGM=
Date:   Tue, 26 Feb 2019 13:16:05 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [RFC PATCH 2/4] uaccess: Add non-pagefault user-space read
 functions
Message-Id: <20190226131605.fa3969d542c6b13ed86e06f0@kernel.org>
In-Reply-To: <CAHk-=wgNctC6PoCH9HE3hWFGq+5qBt0nsh+STDguD=jV9ovcag@mail.gmail.com>
References: <155110348217.21156.3874419272673328527.stgit@devbox>
        <155110354092.21156.13871336589042178985.stgit@devbox>
        <20190225150603.GE32494@hirez.programming.kicks-ass.net>
        <CAHk-=wgNctC6PoCH9HE3hWFGq+5qBt0nsh+STDguD=jV9ovcag@mail.gmail.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, 25 Feb 2019 09:00:57 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Feb 25, 2019 at 7:06 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Would something like so work for people?
> 
> Looks reasonable to me.
> 
> > Why not keep it simple:
> >
> >         mm_segment_t old_fs = get_fs();
> >
> >         set_fs(USER_DS);
> >         ret = __strncpy...();
> >         set_fs(old_fd);
> >
> >         return ret;
> 
> So none of this code looks sane. First odd, there's no real reason to
> use __get_user(). The thing should never be used. It does the whole
> stac/clac for every byte.

Ah, I got it. I just followed the commit bd28b14591b9 ("x86: remove more
uaccess_32.h complexity") as same as strnlen_from_unsafe(). No special
reason.

> 
> In the copy_from_user() case, I suggested re-doing it as one common
> routine without the set_fs() dance for the "already there" case to
> simplify error handling. Here it doesn't do that.
> 
> But honestly, I think for the strncpy case, we could just do
> 
>   long strncpy_from_unsafe_user(char *dst, const void __user *src, long count)
>   {
>       long ret;
>       mm_segment_t old_fs = get_fs();
> 
>       set_fs(USER_DS);
>       pagefault_disable();
>       ret = strncpy_from_user(dst, src, count);
>       pagefault_enable();
>       set_fs(old_fs);
>       return ret;
>   }
> 
> and be done with it. Efficient and simple.

Yes, it looks good to me :)

> 
> Note: the above will *only* work for actual user addresses, because
> strncpy_from_user() does that proper range check.

I think we can reuse do_strncpy_from_user() for strncpy_from_unsafe().
(so maybe we should move it from mm/maccess.c to lib/strncpy_from_user.c?)

As Kees pointed out, I think it is a good chance to sort the behavior of
these strXcpy APIs to match their names.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
