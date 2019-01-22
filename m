Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDBDC37122
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F1A2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfAVAvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 19:51:13 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:20745 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfAVAvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 19:51:12 -0500
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0M0omc4008936;
        Tue, 22 Jan 2019 09:50:48 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Tue, 22 Jan 2019 09:50:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0M0omTO008923;
        Tue, 22 Jan 2019 09:50:48 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x0M0ommA008918;
        Tue, 22 Jan 2019 09:50:48 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201901220050.x0M0ommA008918@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: [PATCH v2] fs: Allow opening only regular files during execve().
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        syzbot 
        <bot+e93a80c1bb7c5c56e522461c149f8bf55eab1b2b@syzkaller.appspotmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
MIME-Version: 1.0
Date:   Tue, 22 Jan 2019 09:50:48 +0900
References: <d1e2488f-a969-30d4-5023-6fa85a4e3833@I-love.SAKURA.ne.jp> <20190121211800.GC2217@ZenIV.linux.org.uk>
In-Reply-To: <20190121211800.GC2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Mon, Jan 21, 2019 at 07:14:39PM +0900, Tetsuo Handa wrote:
> > On Tue, Dec 12, 2017 at 2:06 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> > > I'm not sure what the fix will be.  Maybe the proc handlers should take a
> > > different lock instead of cred_guard_mutex.  Or perhaps execve should check that
> > > the file is a regular file before it attempts to open it.
> > 
> > We can easily distinguish open() from execve() and open() from others. ;-)
> 
> > +	/* The file or a script interpreter has to be a regular file. */
> > +	if (unlikely(current->in_execve && !S_ISREG(inode->i_mode))) {
> > +		error = -EACCES;
> > +		goto cleanup_file;
> > +	}
> 
> We are *NOT* going to use current->in_execve to propagate that information.

You mean check FMODE_EXEC instead of current->in_execve ?

From f80b32e1c3fbd65672387ee441a32ab58db456f8 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Tue, 22 Jan 2019 09:34:35 +0900
Subject: [PATCH v2] fs: Allow opening only regular files during execve().

syzbot is hitting lockdep warning [1] due to trying to open a fifo during
an execve() operation. But we don't need to open non regular files during
an execve() operation, for all files which we will need are the executable
file itself and the interpreter programs like /bin/sh and ld-linux.so.2 .

Since the manpage for execve(2) says that execve() returns EACCES when
the file or a script interpreter is not a regular file, and the manpage
for uselib(2) says that uselib() can return EACCES, and we use FMODE_EXEC
when opening for execve()/uselib(), let's bail out if a non regular file
is requested with FMODE_EXEC set.

[1] https://syzkaller.appspot.com/bug?id=b5095bfec44ec84213bac54742a82483aad578ce

Reported-by: syzbot <syzbot+e93a80c1bb7c5c56e522461c149f8bf55eab1b2b@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/open.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index 0285ce7..ee719c2 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -733,6 +733,12 @@ static int do_dentry_open(struct file *f,
 		return 0;
 	}
 
+	/* Any file opened for execve()/uselib() has to be a regular file. */
+	if (unlikely(f->f_flags & FMODE_EXEC && !S_ISREG(inode->i_mode))) {
+		error = -EACCES;
+		goto cleanup_file;
+	}
+
 	if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
 		error = get_write_access(inode);
 		if (unlikely(error))
-- 
1.8.3.1
