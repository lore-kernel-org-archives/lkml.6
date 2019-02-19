Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6228DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EA42146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfBSJwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:52:23 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:52993 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfBSJwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:52:23 -0500
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1J9pr7E029192;
        Tue, 19 Feb 2019 18:51:53 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp);
 Tue, 19 Feb 2019 18:51:53 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1J9plbl029168
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 19 Feb 2019 18:51:53 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH v2] fs: Allow opening only regular files during execve().
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        syzbot 
        <bot+e93a80c1bb7c5c56e522461c149f8bf55eab1b2b@syzkaller.appspotmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <20190128154205.214ae010da6c2f02d379bbc8@linux-foundation.org>
 <201902120526.x1C5QYXX092667@www262.sakura.ne.jp>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <41c0632d-ba5e-35be-a44f-c918fe6fd8dd@I-love.SAKURA.ne.jp>
Date:   Tue, 19 Feb 2019 18:51:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <201902120526.x1C5QYXX092667@www262.sakura.ne.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Al.

What would you suggest if FMODE_EXEC is not the right choice?

On 2019/01/22 9:51, Kees Cook wrote:
> On Tue, Jan 22, 2019 at 10:18 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>> We are *NOT* going to use current->in_execve to propagate that information.
>> Come up with a cleaner solution, if you care, but this one is a non-starter.
>> Too ugly to live.  Sorry.
> 
> What would you suggest for a cleaner indication of being in an execve?
> 

On 2019/02/12 14:26, Tetsuo Handa wrote:
> Tetsuo Handa wrote:
>> Andrew Morton wrote:
>>>> --- a/fs/open.c
>>>> +++ b/fs/open.c
>>>> @@ -733,6 +733,12 @@ static int do_dentry_open(struct file *f,
>>>>  		return 0;
>>>>  	}
>>>>  
>>>> +	/* Any file opened for execve()/uselib() has to be a regular file. */
>>>> +	if (unlikely(f->f_flags & FMODE_EXEC && !S_ISREG(inode->i_mode))) {
>>>> +		error = -EACCES;
>>>> +		goto cleanup_file;
>>>> +	}
>>>> +
>>>>  	if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
>>>>  		error = get_write_access(inode);
>>>>  		if (unlikely(error))
>>>
>>> This change sounds legitimate for various other reasons, but it's a
>>> concern that this locking error occurred in the first place.  There's a
>>> problem somewhere (probably the pipe code) which may bite us in other
>>> situations, even with this workaround in place.
>>>
>>>
>>
>> This error seems to be introduced in 2.6.39-rc1 by commit a9712bc12c40c172
>> ("deal with races in /proc/*/{syscall,stack,personality}"). Thus, I don't
>> think that this patch will bite us in other situations.
>> Al, how do you want to handle this?
>>
> 
> According to bisection, commit 8924feff66f35fe2 ("splice: lift pipe_lock out of splice_to_pipe()")
> added in 4.9-rc1 is the trigger of this deadlock. Thus, the fix needs to go to 4.9+.
