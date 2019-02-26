Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E60C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 04:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C6721848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 04:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551154047;
	bh=VjPoOH/+HAWVrIll1HwhZ3tv1aOYkduvESyiKiY6pfI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2DTr88U2ipvxilVflSeUTmQOEEdRwqb/25zJqPjX5pUICVj56n8l1wDF3zm9lZ4QP
	 lZRablVYL0c4nW4a41jTTx/SxBabvTaVzvb8ELo2cR/ETCNKuYH0PpVHTRqi7XEO0t
	 qhF+SEKmPCYRTKxSUY4RSsWnQxEdWqtPsLd1LV3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfBZEHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 23:07:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:33608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfBZEHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 23:07:25 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58F7A217F5;
        Tue, 26 Feb 2019 04:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551154044;
        bh=VjPoOH/+HAWVrIll1HwhZ3tv1aOYkduvESyiKiY6pfI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KqTmpqhFi+sUqOsYydMxd/knoAkHw/DegEo0MZNGv8LJib0cCxHzRH64a9eslr42c
         H1T16PcbwYAE5kwAOcq8Lq5Slj+eoQj2wEYfeU/EGX98/t5drCJhw8uIAUwx8J2IrT
         1sDoBPzv/V403uuGPOUxO4iFM5T5gzU0kVuti1ZI=
Date:   Tue, 26 Feb 2019 13:07:20 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 2/4] uaccess: Add non-pagefault user-space read
 functions
Message-Id: <20190226130720.189c882ce8355bb605d1ca9d@kernel.org>
In-Reply-To: <CAGXu5jL+8nBen8_BjTziF=bGQm7hijV7YMa_a53vXfFT4+mwzQ@mail.gmail.com>
References: <155110348217.21156.3874419272673328527.stgit@devbox>
        <155110354092.21156.13871336589042178985.stgit@devbox>
        <CAGXu5jL+8nBen8_BjTziF=bGQm7hijV7YMa_a53vXfFT4+mwzQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Mon, 25 Feb 2019 09:06:55 -0800
Kees Cook <keescook@chromium.org> wrote:

> On Mon, Feb 25, 2019 at 6:06 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > +static __always_inline long strncpy_from_unsafe_common(char *dst,
> > +                               const char __user *unsafe_addr, long count)
> > +{
> > +       const char __user *src = unsafe_addr;
> > +       int ret;
> > +
> > +       pagefault_disable();
> > +       do {
> > +               ret = __get_user(*dst++, src++);
> > +       } while (dst[-1] && ret == 0 && src - unsafe_addr < count);
> > +       dst[-1] = '\0';
> > +       pagefault_enable();
> > +
> > +       return ret ? -EFAULT : src - unsafe_addr;
> > +}
> 
> I'm all for always NUL-truncating, but this isn't "strncpy" (which has
> the buggy maybe-I-didn't-NUL-terminate behavior). Can we call this
> strscpy_...() instead?

Yes, it is easy to me to fit it to strscpy spec and caller side too.
But if we reuse strncpy_from_user() as Linus suggested, it may be better
keep it or write a wrapper, since this function spec is still a bit
different from strscpy (this doesn't return -E2BIG but returns the
copied length of the string with NULL terminal byte).

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
