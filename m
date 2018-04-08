Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbeDHN2R (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 09:28:17 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:15143 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbeDHN2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 09:28:16 -0400
To: dvyukov@google.com
Cc: tiwai@suse.com, viro@zeniv.linux.org.uk,
        syzbot+4f2016cf5185da7759dc@syzkaller.appspotmail.com,
        alsa-devel@alsa-project.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        o-takashi@sakamocchi.jp, perex@perex.cz,
        syzkaller-bugs@googlegroups.com
Subject: Re: INFO: rcu detected stall in io_playback_transfer
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <00000000000014ed1e056928bb60@google.com>
        <84930b72-d55d-90a2-e0df-29279545aa25@I-love.SAKURA.ne.jp>
        <CACT4Y+a_Sm6AAK1x1o5p7MQxb+EO3ZDxhNorv98UB4kbWfRscw@mail.gmail.com>
In-Reply-To: <CACT4Y+a_Sm6AAK1x1o5p7MQxb+EO3ZDxhNorv98UB4kbWfRscw@mail.gmail.com>
Message-Id: <201804082226.AGF09317.OtLQHOFMJFSFVO@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Sun, 8 Apr 2018 22:26:21 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote:
> Takashi has already fixed this. See this thread:
> https://groups.google.com/forum/#!searchin/syzkaller-bugs/%22INFO$3A$20rcu$20detected$20stall$20in$20snd_pcm_oss_write3$20(2)%22%7Csort:date/syzkaller-bugs/D2xWV7WTRDk/sCw_gImmCAAJ

Yes, I noticed it just before I post this. But the reason I posted this anyway
is that I feel that there is some other bug revealed by this reproducer.
How can Takashi' patch explain my observation (with linux-next-20180406) ?

/* Hits the stall */
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

/* Does not hit the stall */
int main(int argc, char *argv[])
{
	const int fd = open("/dev/dsp1", O_RDWR);
	int frag = (0 << 16) | 0;
	char buf[48] = { };
	ioctl(fd, SNDCTL_DSP_SETFRAGMENT, &frag);
	write(fd, buf, sizeof(buf));
	return 0;
}

/* Does not hit the stall */
int main(int argc, char *argv[])
{
	const int fd = open("/dev/dsp1", O_RDWR);
	int frag = (0 << 16) | 0;
	char buf[48] = { };
	unshare(CLONE_NEWNS);
	ioctl(fd, SNDCTL_DSP_SETFRAGMENT, &frag);
	write(fd, buf, sizeof(buf));
	close(fd);
	return 0;
}
