Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC17C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EAA214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfBLCCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:02:30 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:39191 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbfBLCCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 21:02:30 -0500
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1C21wUf019162;
        Tue, 12 Feb 2019 11:01:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Tue, 12 Feb 2019 11:01:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1C21w5Z019145;
        Tue, 12 Feb 2019 11:01:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x1C21wt2019144;
        Tue, 12 Feb 2019 11:01:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201902120201.x1C21wt2019144@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH v2] fs: Allow opening only regular files during execve().
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        syzbot 
        <bot+e93a80c1bb7c5c56e522461c149f8bf55eab1b2b@syzkaller.appspotmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
MIME-Version: 1.0
Date:   Tue, 12 Feb 2019 11:01:58 +0900
References: <201901220050.x0M0ommA008918@www262.sakura.ne.jp> <20190128154205.214ae010da6c2f02d379bbc8@linux-foundation.org>
In-Reply-To: <20190128154205.214ae010da6c2f02d379bbc8@linux-foundation.org>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -733,6 +733,12 @@ static int do_dentry_open(struct file *f,
> >  		return 0;
> >  	}
> >  
> > +	/* Any file opened for execve()/uselib() has to be a regular file. */
> > +	if (unlikely(f->f_flags & FMODE_EXEC && !S_ISREG(inode->i_mode))) {
> > +		error = -EACCES;
> > +		goto cleanup_file;
> > +	}
> > +
> >  	if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
> >  		error = get_write_access(inode);
> >  		if (unlikely(error))
> 
> This change sounds legitimate for various other reasons, but it's a
> concern that this locking error occurred in the first place.  There's a
> problem somewhere (probably the pipe code) which may bite us in other
> situations, even with this workaround in place.
> 
> 

This error seems to be introduced in 2.6.39-rc1 by commit a9712bc12c40c172
("deal with races in /proc/*/{syscall,stack,personality}"). Thus, I don't
think that this patch will bite us in other situations.
Al, how do you want to handle this?
