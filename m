Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F271C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2808420870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfAUKP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:15:28 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:55888 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfAUKP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:15:27 -0500
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0LAEjd9016740;
        Mon, 21 Jan 2019 19:14:45 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp);
 Mon, 21 Jan 2019 19:14:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0LAEeUp016702
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 21 Jan 2019 19:14:45 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: [PATCH] fs: Allow opening only regular files during execve().
To:     Eric Biggers <ebiggers3@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        syzbot 
        <bot+e93a80c1bb7c5c56e522461c149f8bf55eab1b2b@syzkaller.appspotmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <001a113f711ae2110c055f45acb8@google.com>
 <20171212220647.GJ185376@gmail.com>
 <CAGXu5jLcuE-h9V04fTtoSfz9mZdVeH1zfJOpRncK2NZkv2gsnQ@mail.gmail.com>
 <CACT4Y+aeSz05wDyStT75OFFi_aTyxbfzz7Z6jJ6FJsLNN3Pdtg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <d1e2488f-a969-30d4-5023-6fa85a4e3833@I-love.SAKURA.ne.jp>
Date:   Mon, 21 Jan 2019 19:14:39 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+aeSz05wDyStT75OFFi_aTyxbfzz7Z6jJ6FJsLNN3Pdtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2017 at 2:06 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> I'm not sure what the fix will be.  Maybe the proc handlers should take a
> different lock instead of cred_guard_mutex.  Or perhaps execve should check that
> the file is a regular file before it attempts to open it.

We can easily distinguish open() from execve() and open() from others. ;-)

From a8c559566f743eeec31c3cf5bab7a90b1ff7f78b Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Mon, 21 Jan 2019 13:55:11 +0900
Subject: [PATCH] fs: Allow opening only regular files during execve().

syzbot is hitting lockdep warning [1] due to trying to open a fifo during
an execve() operation. But we don't need to open non regular files during
an execve() operation, for all files which we will need are the executable
file itself, the interpreter program, and libraries like ld-linux.so.2
required by the executable file or the interpreter program.

Since the manpage for execve(2) says that execve() returns EACCES when
the file or a script interpreter is not a regular file, and we set
current->in_execve flag during an execve() operation, let's bail out
when current thread tried to open a non regular file during an execve()
operation.

[1] https://syzkaller.appspot.com/bug?id=b5095bfec44ec84213bac54742a82483aad578ce

Reported-by: syzbot <syzbot+e93a80c1bb7c5c56e522461c149f8bf55eab1b2b@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/open.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index 0285ce7dbd51..b2e7b04ade46 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -733,6 +733,12 @@ static int do_dentry_open(struct file *f,
 		return 0;
 	}
 
+	/* The file or a script interpreter has to be a regular file. */
+	if (unlikely(current->in_execve && !S_ISREG(inode->i_mode))) {
+		error = -EACCES;
+		goto cleanup_file;
+	}
+
 	if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
 		error = get_write_access(inode);
 		if (unlikely(error))
-- 
2.17.1
