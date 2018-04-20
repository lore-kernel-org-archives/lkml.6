Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
X-Google-Smtp-Source: AIpwx4/jQmxf07bEkGadZrIAGqbifDOcSTmFr3TiBMVAIEocp4RbT3LmfDAmcAC3JaBw62DP25uz
ARC-Seal: i=1; a=rsa-sha256; t=1524202236; cv=none;
        d=google.com; s=arc-20160816;
        b=IMA4M2hIMFoS/rZFPDeowkVvdnnmkeE/hjTcgpvdx2cmOJuGSl4dNiY+n3q5Re7qSS
         KlvQSSNLEpP+VMzdwEZ1Bym1Otbw8SBG9mFo76F3j73O9hGbOQVcFfzYLvgmR+xagGfF
         i2f1iTcTxuRuZ+0FOmdZpi7B8RiD+g0TMfRiOg42fCAY3RzJ5IQSHfPgl/6hkB3mvtpC
         XclqHfamFiNjx2wMZbQNTh+A4+3YuCz2flEiPsfY9bQSkSI66oVOf5t8NvpKu6RSy6so
         Vo2JFZobVprSA3+r2XYJv6plnfDdJ+KWLSZllnmzvWf0y4C7JwIkxSKby1lg6Oiw6HQ/
         pUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:references:date:mime-version
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=1ISGE0/IbgiyTbfY1oJq8SBlrsspUJzdTCTXA2QymoA=;
        b=Sndrd3AL6awSY73E8pQMe8BUuQ13s7QBqP+w4FVkLkxMvHAMb0NUvZ/DFfP28Q79v9
         r7rvh4Xmx9yLRMRoBcSWb9UmP3gjohjQnKqH8SLoMiP7PAXJ79HTwfpTQmum+TP16C3Y
         nUYvxVRmC5GBJ/WyD+VWckn5U+YJLZYygoR2Pcii9l7k/BWaSqg8AgGOebCpLdXTJbCZ
         b6jqmzJZlpKwJpu9KJKzDmSEKcbsdYDgxBNEk5YtOo4+Hm5lqwP6YK9l7IGUAQAJePb5
         4IuSHfJ0lPe8OOA9EN9LnHCuEfOzi+w3qFI1Os9k1PitG+eBhIzLG+GPrg16+dxzvfeh
         CCYw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Message-Id: <201804200529.w3K5TdvM009951@www262.sakura.ne.jp>
Subject: Re: general protection fault in =?ISO-2022-JP?B?a2VybmZzX2tpbGxfc2I=?=
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To: Eric Biggers <ebiggers3@gmail.com>, Michal Hocko <mhocko@kernel.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+151de3f2be6b40ac8026@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, pombredanne@nexb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Date: Fri, 20 Apr 2018 14:29:39 +0900
References: <20180420024440.GB686@sol.localdomain> <20180420033450.GC686@sol.localdomain>
In-Reply-To: <20180420033450.GC686@sol.localdomain>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596563980561316248?=
X-GMAIL-MSGID: =?utf-8?q?1598241883666301249?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Eric Biggers wrote:
> But, there is still a related bug: when mounting sysfs, if register_shrinker()
> fails in sget_userns(), then kernfs_kill_sb() gets called, which frees the
> 'struct kernfs_super_info'.  But, the 'struct kernfs_super_info' is also freed
> in kernfs_mount_ns() by:
> 
>         sb = sget_userns(fs_type, kernfs_test_super, kernfs_set_super, flags,
>                          &init_user_ns, info);
>         if (IS_ERR(sb) || sb->s_fs_info != info)
>                 kfree(info);
>         if (IS_ERR(sb))
>                 return ERR_CAST(sb);
> 
> I guess the problem is that sget_userns() shouldn't take ownership of the 'info'
> if it returns an error -- but, it actually does if register_shrinker() fails,
> resulting in a double free.
> 
> Here is a reproducer and the KASAN splat.  This is on Linus' tree (87ef12027b9b)
> with vfs/for-linus merged in.

I'm waiting for response from Michal Hocko regarding
http://lkml.kernel.org/r/201804111909.EGC64586.QSFLFJFOVHOOtM@I-love.SAKURA.ne.jp .

> 
> #define _GNU_SOURCE
> #include <fcntl.h>
> #include <sched.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/mount.h>
> #include <sys/stat.h>
> #include <unistd.h>
> 
> int main()
> {
>         int fd, i;
>         char buf[16];
> 
>         unshare(CLONE_NEWNET);
>         system("echo N > /sys/kernel/debug/failslab/ignore-gfp-wait");
>         system("echo 0 | tee /sys/kernel/debug/fail*/verbose");
>         fd = open("/proc/thread-self/fail-nth", O_WRONLY);
>         for (i = 0; ; i++) {
>                 write(fd, buf, sprintf(buf, "%d", i));
>                 mount("sysfs", "mnt", "sysfs", 0, NULL);
>                 umount("mnt");
>         }
> }
