Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbeDHNA3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 09:00:29 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59235 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeDHNA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 09:00:28 -0400
Subject: Re: INFO: rcu detected stall in io_playback_transfer
To: tiwai@suse.com, viro@zeniv.linux.org.uk
References: <00000000000014ed1e056928bb60@google.com>
Cc: syzbot <syzbot+4f2016cf5185da7759dc@syzkaller.appspotmail.com>,
        alsa-devel@alsa-project.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        o-takashi@sakamocchi.jp, perex@perex.cz,
        syzkaller-bugs@googlegroups.com
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <84930b72-d55d-90a2-e0df-29279545aa25@I-love.SAKURA.ne.jp>
Date: Sun, 8 Apr 2018 21:58:44 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <00000000000014ed1e056928bb60@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I manually simplified the reproducer.

It is quite strange that removing unshare() hides this lockup bug.
Also, explicitly closing by "close()" hides this lockup bug.
Triggering "fput() from do_exit()" from "different namespace"
somehow affects this lockup bug?

----------------------------------------
#define _GNU_SOURCE
#include <fcntl.h>
#include <sched.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <linux/soundcard.h>

int main(int argc, char *argv[])
{
	const int fd = open("/dev/dsp1", O_RDWR);
	int frag = (0 << 16) | 0;
	char buf[48] = { };
	unshare(CLONE_NEWNS);
	ioctl(fd, SNDCTL_DSP_SETFRAGMENT, &frag);
	write(fd, buf, sizeof(buf));
	return 0;
}
----------------------------------------
