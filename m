Return-Path: <joelaf@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518802680; cv=none;
        d=google.com; s=arc-20160816;
        b=LE9OD6WtbWaNCuSIHVzBnJWLIMSh3UD1sujcUFg5/RxMfwPdc1hTsV52TrRuUqXC1d
         7l0PFU4MJ8Dyt71Fz16KtZYPdf+JIAFagCFLXNMe2Hvq3E1Y2YZsLvgsLuWtJOHwIBXW
         nJ2370RWTwIO+YWdRAKaPwhK793HbI+tq0bd6wxv+K9pQprWom6R3zhdPdNXk1KnYsR6
         BLMf/VdWBgfT4eo97n3iNNPNg3oUpADVfKQmfuzqBHBk5hqHMLA1cWsJ9un3QATetwgQ
         c3NmCEma3DCYO22zhM+SB7JjjA077Irx4fdaWAsB0NLDbh7VemryuhD6C7sEOA4U83gu
         CuhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=LsEuHEVAI0xxwbxQ57hbUWBv30typLy1G0+ORoNWzhM=;
        b=QV4SoKs+Xv3f4CnxBujdPwiwe+pvxYCC8JlkLAHAmWRqgxBaggOg3E/XTeedGGfWDK
         wGQFLtpvWYCV9BwGOTilWsfZHlhlH0pDjTJxGrnxGbmUKcSSMGcBUDWIobYwzX77t15D
         H5G0AHhnQeNz7+phvF4O6RmKHJBCJ5JUHfyxU3rLva5Hqs4ytxRmFHFv7iKLYRCXR5yx
         R5tv/eg8WBLE+gyCUnEA19d8ds8L3aKVsDlVIgXSqmdqwmxHbU4x0oR4OeyqFiRccS4d
         hJVLYSEQma/AEzOOHO4g7IW3fk710iGMVBR2ix6fg/wvwJsO1s1bl3uRrexEeInfn0oi
         praA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ERtFEi37;
       spf=pass (google.com: domain of joelaf@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joelaf@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ERtFEi37;
       spf=pass (google.com: domain of joelaf@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joelaf@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AH8x226IjmIRwOT9ssnFB5y3N1Nw72kN8JS/cU+bnkDuKdnxjvU0Up+hDvjt+9/vJ3DD9GGxrCSuBuKQaSAXxWTxtgs=
MIME-Version: 1.0
In-Reply-To: <20180216163257.GA7752@kroah.com>
References: <20180213010125.174811-1-joelaf@google.com> <20180216163257.GA7752@kroah.com>
From: Joel Fernandes <joelaf@google.com>
Date: Fri, 16 Feb 2018 09:37:59 -0800
Message-ID: <CAJWu+oo_06XRu-NA6v0-UxjaaVbh27d4RSpO6G++nLUuLxSYGA@mail.gmail.com>
Subject: Re: [PATCH] staging: ashmem: Fix lockdep issue during llseek
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
	Arve Hjonnevag <arve@android.com>, Greg Hackmann <ghackmann@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1592580040220905079?=
X-GMAIL-MSGID: =?utf-8?q?1592580040220905079?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 8:32 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Feb 12, 2018 at 05:01:25PM -0800, Joel Fernandes wrote:
>> ashmem_mutex create a chain of dependencies like so:
>>
>> (1)
>> mmap syscall ->
>>   mmap_sem ->  (acquired)
>>   ashmem_mmap
>>   ashmem_mutex (try to acquire)
>>   (block)
>>
>> (2)
>> llseek syscall ->
>>   ashmem_llseek ->
>>   ashmem_mutex ->  (acquired)
>>   inode_lock ->
>>   inode->i_rwsem (try to acquire)
>>   (block)
>>
>> (3)
>> getdents ->
>>   iterate_dir ->
>>   inode_lock ->
>>   inode->i_rwsem   (acquired)
>>   copy_to_user ->
>>   mmap_sem         (try to acquire)
>>
>> There is a lock ordering created between mmap_sem and inode->i_rwsem
>> causing a lockdep splat [2] during a syzcaller test, this patch fixes
>> the issue by unlocking the mutex earlier. Functionally that's Ok since
>> we don't need to protect vfs_llseek.
>>
>> [1] https://patchwork.kernel.org/patch/10185031/
>> [2] https://lkml.org/lkml/2018/1/10/48
>>
>> Cc: Todd Kjos <tkjos@google.com>
>> Cc: Arve Hjonnevag <arve@android.com>
>> Cc: Greg Hackmann <ghackmann@google.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: stable@vger.kernel.org
>> Reported-by: syzbot+8ec30bb7bf1a981a2012@syzkaller.appspotmail.com
>> Signed-off-by: Joel Fernandes <joelaf@google.com>
>> ---
>>  drivers/staging/android/ashmem.c | 15 +++++++--------
>>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> Please always properly version your patches, and put what changed below
> the --- line, so I have a hint as to which patch to apply.
> Documentation/SubmittingPatches has the full details of how to do this.
>
> Can you resend me the "latest" version of this patch, so I have a chance
> of getting it right?  :)

Sorry about that :) Fixing now, and will resend. This version you're
replying to is the latest version which is the second version (v2).

- Joel
