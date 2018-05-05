Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
X-Google-Smtp-Source: AB8JxZp/X/0LkjHHBPoIrFuNG5WLLtU8lqt5D0N60WatFbFjormgxHO3Krg+yCveSxb9Vdj9ajfb
ARC-Seal: i=1; a=rsa-sha256; t=1525521491; cv=none;
        d=google.com; s=arc-20160816;
        b=t8VnozILBa9yFUhJL25eylgaU/PYvukOpYD6X4vKjBb+JdMJxA+9/LB1Hw3DEB4DzP
         vwNLCotkF9I63yiA4DBZ/UmuphDbEBl5sdWfeJbP/DMBGTBxCG+mT42jkvkZEMUc+E8P
         emczdbesIL/8A6DukLWBggqNbCCxWxG1Lphym19fc2kTNY4BOI356A2E829yWCCJT3U1
         JKq7ZtksNou8HFTv4DbZnnH2VrtlHjbsJjRpGWUIndVxAaDhzckFSJ36Y0C537qLdVBe
         UT5uhCDec5HCehA0G73KHNoc8Tp2RI83cp/YS7TxFGusf6JZy4s9CLOfsTVo4qhPgq8Q
         5zwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=UjuYSe/gdMxHywZT9KrDHaZvuIp8Hyh2hJPwDj71RY8=;
        b=V1Oqf7FSs7ZjB6G9vnpMpQsLCrePeCgpquc2n8grzfm48GJtqNX6Dv1+QsgyTfJpux
         ajqW1V9+f27JZc7Yd4Rov25NcIwC+mqS+nZsVoxwCea61T/YjX2jNBHR5S6ozi5Mm/+6
         +NzT0d642FwAzZdSoL1uSsDOROBDTP/9kZjfx6Lqs5hjLmHb5TdjPfrcZfWuSAOS7fS9
         ZGjWdseYmggjWSmmafiFYDRZMY0oJ3majLOJc2eW/t+jtI/amGi6TtsYKGHT+TaN4K40
         eqM9zTf2wsPw3h5ks9swL40XCm4i8NTODhc1mxUP62PzBZcMVul+VGFjKyUR0CgHtKp/
         Kfbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Subject: Re: INFO: rcu detected stall in blkdev_ioctl
To: syzbot
 <syzbot+369c35474963daf8f8eea897ecf33cb6ad6c7ea2@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Jan Kara <jack@suse.cz>
Cc: akpm@linux-foundation.org, gregkh@linuxfoundation.org, hpa@zytor.com,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, npiggin@gmail.com, pombredanne@nexb.com,
        tglx@linutronix.de, x86@kernel.org
References: <94eb2c05a38090aaeb0560706bb5@google.com>
 <0000000000001554a7056add26c6@google.com>
 <18608105-31d3-3d77-ccbb-a25bbe7e55e6@I-love.SAKURA.ne.jp>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <00724984-6edd-d0df-4c51-53be8c330234@I-love.SAKURA.ne.jp>
Date: Sat, 5 May 2018 20:57:16 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <18608105-31d3-3d77-ccbb-a25bbe7e55e6@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1586926286498565093?=
X-GMAIL-MSGID: =?utf-8?q?1599625223163227475?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If various stall reports regarding loop_set_fd() are hitting below sequence, a patch
was proposed at https://groups.google.com/d/msg/syzkaller-bugs/5pzXJ8yQFR0/vWeRytaQBAAJ .

----------
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/loop.h>

int main(int argc, char *argv[])
{
        const int fd = open("/tmp/file", O_RDWR | O_CREAT | O_TRUNC, 0600);
        const int fd0 = open("/dev/loop0", O_RDONLY);
        const int fd1 = open("/dev/loop1", O_RDONLY);
        ioctl(fd0, LOOP_SET_FD, fd);
        ioctl(fd0, LOOP_CHANGE_FD, fd0);
        ioctl(fd1, LOOP_SET_FD, fd0);
        return 0;
}
----------
