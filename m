Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB95C37123
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A3B2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfAUVSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:18:10 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:47864 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfAUVSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:18:10 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1glgxF-0000Oc-6T; Mon, 21 Jan 2019 21:18:01 +0000
Date:   Mon, 21 Jan 2019 21:18:01 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        syzbot 
        <bot+e93a80c1bb7c5c56e522461c149f8bf55eab1b2b@syzkaller.appspotmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] fs: Allow opening only regular files during execve().
Message-ID: <20190121211800.GC2217@ZenIV.linux.org.uk>
References: <001a113f711ae2110c055f45acb8@google.com>
 <20171212220647.GJ185376@gmail.com>
 <CAGXu5jLcuE-h9V04fTtoSfz9mZdVeH1zfJOpRncK2NZkv2gsnQ@mail.gmail.com>
 <CACT4Y+aeSz05wDyStT75OFFi_aTyxbfzz7Z6jJ6FJsLNN3Pdtg@mail.gmail.com>
 <d1e2488f-a969-30d4-5023-6fa85a4e3833@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1e2488f-a969-30d4-5023-6fa85a4e3833@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 07:14:39PM +0900, Tetsuo Handa wrote:
> On Tue, Dec 12, 2017 at 2:06 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> > I'm not sure what the fix will be.  Maybe the proc handlers should take a
> > different lock instead of cred_guard_mutex.  Or perhaps execve should check that
> > the file is a regular file before it attempts to open it.
> 
> We can easily distinguish open() from execve() and open() from others. ;-)

> +	/* The file or a script interpreter has to be a regular file. */
> +	if (unlikely(current->in_execve && !S_ISREG(inode->i_mode))) {
> +		error = -EACCES;
> +		goto cleanup_file;
> +	}

We are *NOT* going to use current->in_execve to propagate that information.
Come up with a cleaner solution, if you care, but this one is a non-starter.
Too ugly to live.  Sorry.
