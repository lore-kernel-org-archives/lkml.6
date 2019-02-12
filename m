Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649C3C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 05:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCDC217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 05:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfBLF07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 00:26:59 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:23133 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfBLF07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 00:26:59 -0500
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1C5QYhT092674;
        Tue, 12 Feb 2019 14:26:34 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Tue, 12 Feb 2019 14:26:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1C5QYA1092668;
        Tue, 12 Feb 2019 14:26:34 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x1C5QYXX092667;
        Tue, 12 Feb 2019 14:26:34 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201902120526.x1C5QYXX092667@www262.sakura.ne.jp>
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
Date:   Tue, 12 Feb 2019 14:26:34 +0900
References: <20190128154205.214ae010da6c2f02d379bbc8@linux-foundation.org> 
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuo Handa wrote:
> Andrew Morton wrote:
> > > --- a/fs/open.c
> > > +++ b/fs/open.c
> > > @@ -733,6 +733,12 @@ static int do_dentry_open(struct file *f,
> > >  		return 0;
> > >  	}
> > >  
> > > +	/* Any file opened for execve()/uselib() has to be a regular file. */
> > > +	if (unlikely(f->f_flags & FMODE_EXEC && !S_ISREG(inode->i_mode))) {
> > > +		error = -EACCES;
> > > +		goto cleanup_file;
> > > +	}
> > > +
> > >  	if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
> > >  		error = get_write_access(inode);
> > >  		if (unlikely(error))
> > 
> > This change sounds legitimate for various other reasons, but it's a
> > concern that this locking error occurred in the first place.  There's a
> > problem somewhere (probably the pipe code) which may bite us in other
> > situations, even with this workaround in place.
> > 
> > 
> 
> This error seems to be introduced in 2.6.39-rc1 by commit a9712bc12c40c172
> ("deal with races in /proc/*/{syscall,stack,personality}"). Thus, I don't
> think that this patch will bite us in other situations.
> Al, how do you want to handle this?
> 

According to bisection, commit 8924feff66f35fe2 ("splice: lift pipe_lock out of splice_to_pipe()")
added in 4.9-rc1 is the trigger of this deadlock. Thus, the fix needs to go to 4.9+.

# bad: [abb5a14fa20fdd400995926134b7be9eb8ce6048] Merge branch 'work.misc' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
# good: [c8d2bc9bc39ebea8437fd974fdbc21847bb897a3] Linux 4.8
# good: [523d939ef98fd712632d93a5a2b588e477a7565e] Linux 4.7
# good: [2dcd0af568b0cf583645c8a317dd12e344b1c72a] Linux 4.6
# good: [b562e44f507e863c6792946e4e1b1449fbbac85d] Linux 4.5
# good: [afd2ff9b7e1b367172f18ba7f693dfb62bdcb2dc] Linux 4.4
# good: [6a13feb9c82803e2b815eca72fa7a9f5561d7861] Linux 4.3
# good: [64291f7db5bd8150a74ad2036f1037e6a0428df2] Linux 4.2
# good: [b953c0d234bc72e8489d3bf51a276c5c4ec85345] Linux 4.1
# good: [39a8804455fb23f09157341d3ba7db6d7ae6ee76] Linux 4.0
git bisect start 'HEAD' 'v4.8' 'v4.7' 'v4.6' 'v4.5' 'v4.4' 'v4.3' 'v4.2' 'v4.1' 'v4.0'
# good: [5691f0e9a3e7855832d5fd094801bf600347c2d0] Merge tag 'sound-4.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good 5691f0e9a3e7855832d5fd094801bf600347c2d0
# good: [530a70617cb6325bd7781e7a993d732d6d37915a] Merge branch 'greybus' into staging-testing
git bisect good 530a70617cb6325bd7781e7a993d732d6d37915a
# good: [bc75450cc3db3485db1e289fef8c1028ba38296a] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid
git bisect good bc75450cc3db3485db1e289fef8c1028ba38296a
# bad: [00e729c933950cda694c49260ff67855fdbfd00a] Merge tag 'armsoc-dt' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect bad 00e729c933950cda694c49260ff67855fdbfd00a
# bad: [5acb6052ce304d89e36f599f1e27a7c63d389ca0] Merge tag 'armsoc-defconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect bad 5acb6052ce304d89e36f599f1e27a7c63d389ca0
# bad: [d1f5323370fceaed43a7ee38f4c7bfc7e70f28d0] Merge branch 'work.splice_read' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect bad d1f5323370fceaed43a7ee38f4c7bfc7e70f28d0
# good: [87840a2b7e048018d18d60bdac5c09224de85370] Merge branch 'i2c/for-4.9' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
git bisect good 87840a2b7e048018d18d60bdac5c09224de85370
# good: [513a4befae06c4469abfb836e8f71977de58c636] Merge branch 'for-4.9/block' of git://git.kernel.dk/linux-block
git bisect good 513a4befae06c4469abfb836e8f71977de58c636
# good: [cca32b7eeb4ea24fa6596650e06279ad9130af98] ext4: allow DAX writeback for hole punch
git bisect good cca32b7eeb4ea24fa6596650e06279ad9130af98
# bad: [fba597db4218ac324eee34b64736ea94829c95bf] pipe: add pipe_buf_confirm() helper
git bisect bad fba597db4218ac324eee34b64736ea94829c95bf
# bad: [d82718e348fee15dbce8f578ff2588982b7cc7ca] fuse_dev_splice_read(): switch to add_to_pipe()
git bisect bad d82718e348fee15dbce8f578ff2588982b7cc7ca
# good: [db85a9eb2e364e24e71f94798e85dbaa8111bb4d] splice: switch get_iovec_page_array() to iov_iter
git bisect good db85a9eb2e364e24e71f94798e85dbaa8111bb4d
# bad: [79fddc4efd5d4de5cf210fe5ecf4d2734140849a] new helper: add_to_pipe()
git bisect bad 79fddc4efd5d4de5cf210fe5ecf4d2734140849a
# bad: [8924feff66f35fe22ce77aafe3f21eb8e5cff881] splice: lift pipe_lock out of splice_to_pipe()
git bisect bad 8924feff66f35fe22ce77aafe3f21eb8e5cff881
