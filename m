Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D11DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C655E20850
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550893675;
	bh=V0W8KIgZfWJSdZtykwNptWp3xFo/mxNL/j4CWYzKUGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Ifm6yWUFMrUvXuGFwGnmmF3IQrbdQaCXGPfJV5ySC1F8qZrsnWRB/NLWjUAsnO8Iy
	 NNOGCACdXHXPuFhosEciPz4sO2l4ColSskrXM0GRfkvug2lxTTQUdjcYe8XYvNxY4W
	 mn2rxmyYQvlwDRxTYtespMBFcHVGN20TXi1Ou/c0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfBWDrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 22:47:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:55916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfBWDrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 22:47:52 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E22FA20675;
        Sat, 23 Feb 2019 03:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550893670;
        bh=V0W8KIgZfWJSdZtykwNptWp3xFo/mxNL/j4CWYzKUGA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aFRQALjxJuNZ9CEeV1nTrQXKb7KFX3CIWrQXH73XhWzFfVSBxkZKHEz9htJEVf9dK
         ur2ASLR4gNp5ecyveIZMF63dXGUJcGf52thQQCBQs86Er7wouo8oAwCFZZ20wQMWN/
         37z+P0OvsNwF3ImINkQGyrPoWyWJyo+RqQhes6Tg=
Date:   Sat, 23 Feb 2019 12:47:46 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Message-Id: <20190223124746.d021973004c7c892c3b3fde1@kernel.org>
In-Reply-To: <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
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
        <20190222172745.2c7205d62003c0a858e33278@kernel.org>
        <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org>
        <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 09:43:14 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Feb 22, 2019 at 12:35 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Or, can we do this?
> >
> > long __probe_user_read(void *dst, const void *src, size_t size)
> > {
> 
> Add a
> 
>         if (!access_ok(src, size))
>                 ret = -EFAULT;
>         else {
> .. do the pagefault_disable() etc ..
>         }

Since kprobes handler runs in IRQ context, we can not use access_ok() in it.
(only on x86 + CONFIG_DEBUG_ATOMIC_SLEEP=y)

In arch/x86/include/asm/uaccess.h:

#define access_ok(addr, size)                                   \
({                                                                      \
        WARN_ON_IN_IRQ();                                               \
        likely(!__range_not_ok(addr, size, user_addr_max()));           \
})

Do we need acccess_ok_inatomic()?

BTW, it seems a bit strange that this WARN_ON_IN_IRQ() is only in x86
access_ok() implementation, since CONFIG_DEBUG_ATOMIC_SLEEP(which defines
WARN_ON_IN_IRQ) doesn't depend on x86, and access_ok() is widely used
in kernel. I think it would be better that each arch provides __access_ok()
and include/linux/uaccess.h provides access_ok() with WARN_ON_IN_IRQ().


> to after the "set_fs()", and it looks good to me. Make it clear that
> yes, this works _only_ for user reads.
> 
> Adn that makes all the games with "kernel_uaccess_faults_ok"
> pointless, so you can just remove them.

OK.

> 
> (note that the "access_ok()" has to come after we've done "set_fs()",
> because it takes the address limit from that).
> 
> Also, since normally we'd expect that we already have USER_DS, it
> might be worthwhile to do this with a wrapper, something along the
> lines of
> 
>         mm_segment_t old_fs = get_fs();
> 
>         if (segment_eq(old_fs, USER_DS))
>               return __normal_probe_user_read();
>         set_fs(USER_DS);
>         ret = __normal_probe_user_read();
>         set_fs(old_fs);
>         return ret;
> 
> and have that __normal_probe_user_read() just do
> 
>         if (!access_ok(src, size))
>                 return -EFAULT;
>         pagefault_disable();
>         ret = __copy_from_user_inatomic(dst, ...);
>         pagefault_enable();
>         return ret ? -EFAULT : 0;
> 
> which looks more obvious.

OK.

> 
> Also, I would suggest that you just make the argument type be "const
> void __user *", since the whole point is that this takes a user
> pointer, and nothing else.

Ah, right.

> Then we should still probably fix up "__probe_kernel_read()" to not
> allow user accesses. The easiest way to do that is actually likely to
> use the "unsafe_get_user()" functions *without* doing a
> uaccess_begin(), which will mean that modern CPU's will simply fault
> on a kernel access to user space.

Or, use __chk_user_ptr(ptr) to check it?

Thank you,

> 
> The nice thing about that is that usually developers will have access
> to exactly those modern boxes, so the people who notice that it
> doesn't work are the right people.
> 
> Alternatively, we should just make it be architecture-specific, so
> that architectures can decide "this address cannot be a kernel
> address" and refuse to do it.
> 
>                 Linus


-- 
Masami Hiramatsu <mhiramat@kernel.org>
