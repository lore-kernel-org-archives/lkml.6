Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694F6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 01:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E342184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 01:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551144972;
	bh=6DcnrVghzZeTUybLqN1CTvs941b+DR8H4duXbM6skL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dWC+EEkru45nfn5157ZxGbAWeOJZjplqwqq9+MWwW5YCQpYqgld8ZOyLpwNKQP3ts
	 x9g/fg7kRppGMZB/Md7TrY+bztQsNIpry58QMCCADZHPqM8jH/ShLFH+WzB+YH9j3H
	 s1MSM+vB/05SwKyoQQD6e/O2t5HmadrX4yFpytp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfBZBgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 20:36:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfBZBgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 20:36:02 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C878217F4;
        Tue, 26 Feb 2019 01:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551144961;
        bh=6DcnrVghzZeTUybLqN1CTvs941b+DR8H4duXbM6skL4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AqR5fd0XNuGwc7qwPKs4qZS6nlkOZpTIxsoFYLIaU15o2KD3Z7ziGitcQRtTmB/Uc
         r7P2XOQuSllDJWBlaXzDaVtYvJQDMEHn7//oXOwtq5fg3HBV2hOJv7rSoqZM5DAkgx
         yEBTaCvULPlcOG+PGfKjxe6Kw09fXPvuUJD1zCmE=
Date:   Tue, 26 Feb 2019 10:35:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-Id: <20190226103558.db7c6b472fccad6e4bca8f56@kernel.org>
In-Reply-To: <20190225114018.4d6b17d4@vmware.local.home>
References: <20190215174712.372898450@goodmis.org>
        <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
        <20190219140330.5dd9e876@gandalf.local.home>
        <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
        <20190220094926.0ab575b3@gandalf.local.home>
        <20190222172745.2c7205d62003c0a858e33278@kernel.org>
        <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org>
        <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
        <20190223124746.d021973004c7c892c3b3fde1@kernel.org>
        <20190223194421.725a03fd@oasis.local.home>
        <CALCETrVDMhpA-oJnpuEP2j21aK5ZosW2PNskVDxm4MSR6Afqug@mail.gmail.com>
        <20190225001757.519f40cd088c05fdd00a9397@kernel.org>
        <CAHk-=wjBD+MQfWP2Q4Zp8FP4HR4MdPACw1=iMbDZANdiBwXDAQ@mail.gmail.com>
        <20190225114025.902c9031075e2f1fc55369a3@kernel.org>
        <CALCETrUHASYthoWGB-CLcvtNEhAp83aA4+iGHtqjtX4ML6chfA@mail.gmail.com>
        <20190225170945.d808659362b364298c3206e9@kernel.org>
        <20190225114018.4d6b17d4@vmware.local.home>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019 11:40:18 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 25 Feb 2019 17:09:45 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > This should probably go with whatever effort makes nmi_uaccess_ok()
> > > available on all architectures.  That being said, how about just
> > > making copy_from_user_nmi() work on all architectures, even if it just
> > > fails unconditionally on some of them?  
> > 
> > I think even if we have copy_from_user_nmi(), we need something like
> > nmi_uaccess_ok() because without it we can not correctly use
> > __copy_from_user_inatomic()...
> 
> But wouldn't that just be part of the implementation of
> "copy_from_user_nmi()" as being in an NMI just assumes being inatomic?

Yes for copy_from_user_nmi(). But there are some other fundamental
functions, like __get_user(). And when we optimize the loop in
strncpy/strnlen from user in atomic, I think one nmi_access_ok() at
entry is enough.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
