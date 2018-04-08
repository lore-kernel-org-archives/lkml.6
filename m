Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeDHNKS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 09:10:18 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:38656 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbeDHNKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 09:10:17 -0400
X-Google-Smtp-Source: AIpwx49QNdM0sYTGOf4dqkXRaeLQeu+5DcsxC/WeS5Jzk5CWo1wxKiKwasRsUqfzTUa9PCVvwXiDlwK9khnChoQ3f1c=
MIME-Version: 1.0
In-Reply-To: <84930b72-d55d-90a2-e0df-29279545aa25@I-love.SAKURA.ne.jp>
References: <00000000000014ed1e056928bb60@google.com> <84930b72-d55d-90a2-e0df-29279545aa25@I-love.SAKURA.ne.jp>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sun, 8 Apr 2018 15:09:55 +0200
Message-ID: <CACT4Y+a_Sm6AAK1x1o5p7MQxb+EO3ZDxhNorv98UB4kbWfRscw@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in io_playback_transfer
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Takashi Iwai <tiwai@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+4f2016cf5185da7759dc@syzkaller.appspotmail.com>,
        alsa-devel@alsa-project.org, Dan Carpenter <dan.carpenter@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Jaroslav Kysela <perex@perex.cz>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 8, 2018 at 2:58 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> I manually simplified the reproducer.
>
> It is quite strange that removing unshare() hides this lockup bug.
> Also, explicitly closing by "close()" hides this lockup bug.
> Triggering "fput() from do_exit()" from "different namespace"
> somehow affects this lockup bug?
>
> ----------------------------------------
> #define _GNU_SOURCE
> #include <fcntl.h>
> #include <sched.h>
> #include <unistd.h>
> #include <sys/ioctl.h>
> #include <linux/soundcard.h>
>
> int main(int argc, char *argv[])
> {
>         const int fd = open("/dev/dsp1", O_RDWR);
>         int frag = (0 << 16) | 0;
>         char buf[48] = { };
>         unshare(CLONE_NEWNS);
>         ioctl(fd, SNDCTL_DSP_SETFRAGMENT, &frag);
>         write(fd, buf, sizeof(buf));
>         return 0;
> }
> ----------------------------------------


Takashi has already fixed this. See this thread:
https://groups.google.com/forum/#!searchin/syzkaller-bugs/%22INFO$3A$20rcu$20detected$20stall$20in$20snd_pcm_oss_write3$20(2)%22%7Csort:date/syzkaller-bugs/D2xWV7WTRDk/sCw_gImmCAAJ

The fix commit includes tag this bug:
Reported-by: syzbot+4f2016cf5185da7759dc@syzkaller.appspotmail.com
But it's just that it's mentioned in the thread for another bug.
