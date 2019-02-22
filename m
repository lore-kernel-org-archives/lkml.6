Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97247C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6486C207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550824518;
	bh=pUxsgMpwR4AWhWWmJPuPoc4SWnqYajEMpcvywqHCdb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YpsUDAo+POZWfiPo5lqunOx3aetFoGbaSdntD8hXjT/70bxntlGGe43NinFQBq8jB
	 hYve5Obf8fd9RBT43+K7LgmkPS//2lhVi29GL2WVzrc/X7hiwyE7+vqsfUyyuleTJX
	 VgSr6asZHyBRAE+hCpgN4MwnUaxk/zprpqDpjf1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfBVIfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:35:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:36292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfBVIfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:35:16 -0500
Received: from devnote (sp49-106-215-210.msf.spmode.ne.jp [49.106.215.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67D5720700;
        Fri, 22 Feb 2019 08:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550824515;
        bh=pUxsgMpwR4AWhWWmJPuPoc4SWnqYajEMpcvywqHCdb8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w59virQTtmv/lWF2lPSHQTYaZYrecS7FyLyohlsdqVhcwpbPxfEOQgX5N7dG9OfYq
         puDErea5h5GpuE2Q+ZzQlI7UdiLF9978y3lrmsO18EOPfMjuzIdJniPiL3sW/RtQwB
         td0qwsvD2zV+RQ4lm0+vLZl31x8wGc1iK+0k+QME=
Date:   Fri, 22 Feb 2019 17:35:09 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-Id: <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org>
In-Reply-To: <20190222172745.2c7205d62003c0a858e33278@kernel.org>
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
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 17:27:45 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> On Wed, 20 Feb 2019 09:49:26 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 20 Feb 2019 17:10:19 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > Let me ensure what you want. So you want to access a "string" in user-space,
> > > not a data structure? In that case, it is very easy to me. It is enough to
> > > add a "ustring" type to kprobe events. For example, do_sys_opsn's path 
> > > variable is one example. That will be +0(+0(%si)):ustring, and fetcher
> > > finally copy the string using strncpy_from_user() instead of 
> > > strncpy_from_unsafe(). (*)
> > 
> > ustring would be good.
> 
> I've tried to implement ustring and u-offsets, but I got some issues.
> 
> - access_ok() warns if it is called in IRQ context (kprobes is.)
> - copy_from_user uses access_ok(), so it is not designed for irq handler.
> 
> Moreover, if we have different kernel/user address spaces, we have to
> assign target user-pages to kernel vma. Can we do that (doesn't it involve
> mutex locks)?

Or, can we do this?

long __probe_user_read(void *dst, const void *src, size_t size)
{
        long ret;
        mm_segment_t old_fs = get_fs();

        set_fs(USER_DS);	/* Only this is changed */
        pagefault_disable();
        current->kernel_uaccess_faults_ok++;
        ret = __copy_from_user_inatomic(dst,
                        (__force const void __user *)src, size);
        current->kernel_uaccess_faults_ok--;
        pagefault_enable();
        set_fs(old_fs);

        return ret ? -EFAULT : 0;
}


-- 
Masami Hiramatsu <mhiramat@kernel.org>
