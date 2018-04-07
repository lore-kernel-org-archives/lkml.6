Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523102347; cv=none;
        d=google.com; s=arc-20160816;
        b=Toms/tqkTOJzNec/NWRth4qYIVQYDekjzoswlY+sAN4yxtwosI6Tw2fUpGWvZmIUvz
         rVuUZJIElbx/Ph30lZbzq8yxAvgEx2PPMyXBQ2p6ReKDmZd9v8YcwkqB/dY4mBg8zLRG
         jHkA+kj/N4BjTOFPwcY/g5dA6G9lX8UpDai77lBcxpgDue+lk2dj6yzx7b6D3mTmKzYd
         mof1etRiTA5yuePzMxQp9r1sliMy+zgwearnXNAMPioPPnE9b2iHioTIo7g5iI81iE4t
         Y/D3PCyOx3FRn/Z4OqRm1L46A3KRiRAGp3shBXZBYw9wzQtVB66tLp16HmHlUNBGaqvt
         wS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=45jfvBxAwxpQECb2aWnOwNmCTqWZU0gbDkyY4Eyjov8=;
        b=cv4Hz5Jd6EeuEP9aeG5QUbgDckotCrde7TaRDeRvG2DC/tYT9MQim/a+/5gTY1K9Xe
         jlhHf+BrTGz+hrxVuoRDt9RR35EhH3N9J9idQyeaO8zf/mlYng+515tsaoV3HnVk3QOd
         z6Vwp4IXMzXwSHwWT3f6K9NK8KlvrNdSZVjawsZsGSz2mskSpsaLFZnUfISRNRVpMFd6
         bEwoTnlO85cOueUxartc44Cl9BXgJpbKDSMWlyU2IAFA1MsjcMTT9peGYceCUkXsbsuy
         nWm9LvI86jpAU88dJax6HHIJ8llDXNhXH0UCPsljR4q8xKUP7lLZQeZ6U20okjNqs4MK
         PLdg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=meV6kEPz;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=meV6kEPz;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx49Z0CY/KNO2Rr3V6x/aQGviZxcnmAXpB3In2Ik0DEWGTxWwjEncq7T9bnfrlR3BPpieErgHPsAaItKIyR545J4=
MIME-Version: 1.0
In-Reply-To: <s5hin93gu2x.wl-tiwai@suse.de>
References: <000000000000118a9a056928bbd9@google.com> <00000000000004c1de05693489a8@google.com>
 <s5hlgdzgx0k.wl-tiwai@suse.de> <CACT4Y+aTGHDimPZzeAi+QyJNio_NGTWfFM8xvndP9NceEPRwOQ@mail.gmail.com>
 <s5hin93gu2x.wl-tiwai@suse.de>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sat, 7 Apr 2018 13:58:46 +0200
Message-ID: <CACT4Y+YC7W2fTCaGAs081NQCzkA-nJxjMb7SZxouYkLDRFmUTA@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in snd_pcm_oss_write3 (2)
To: Takashi Iwai <tiwai@suse.de>
Cc: syzbot <syzbot+150189c103427d31a053@syzkaller.appspotmail.com>,
	alsa-devel@alsa-project.org, Victor Chibotaru <tchibo@google.com>,
	syzkaller-bugs@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	LKML <linux-kernel@vger.kernel.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596979719194785856?=
X-GMAIL-MSGID: =?utf-8?q?1597088566350928289?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

#syz dup: INFO: rcu detected stall in io_playback_transfer

On Sat, Apr 7, 2018 at 1:00 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Sat, 07 Apr 2018 12:19:33 +0200,
> Dmitry Vyukov wrote:
>>
>> On Sat, Apr 7, 2018 at 11:56 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > On Fri, 06 Apr 2018 23:14:01 +0200,
>> > syzbot wrote:
>> >>
>> >> syzbot has found reproducer for the following crash on upstream commit
>> >> 38c23685b273cfb4ccf31a199feccce3bdcb5d83 (Fri Apr 6 04:29:35 2018 +0000)
>> >> Merge tag 'armsoc-drivers' of
>> >> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
>> >> syzbot dashboard link:
>> >> https://syzkaller.appspot.com/bug?extid=150189c103427d31a053
>> >>
>> >> So far this crash happened 15 times on upstream.
>> >> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5405588854931456
>> >> syzkaller reproducer:
>> >> https://syzkaller.appspot.com/x/repro.syz?id=5561439796330496
>> >> Raw console output:
>> >> https://syzkaller.appspot.com/x/log.txt?id=5697900571000832
>> >> Kernel config:
>> >> https://syzkaller.appspot.com/x/.config?id=-5813481738265533882
>> >> compiler: gcc (GCC) 8.0.1 20180301 (experimental)
>> >
>> > Thanks to the reproducer, I could spot out now.
>> > Below is the patch (which was submitted as well).
>>
>> Great!
>>
>> There are 3 more recent stalls in sound, does this fix them as well?
>>
>> https://groups.google.com/forum/#!msg/syzkaller-bugs/MGfk8WH3O6k/ja2xKpdcCAAJ
>> https://groups.google.com/forum/#!msg/syzkaller-bugs/74HglwU94go/T89ohzlYCAAJ
>> https://groups.google.com/forum/#!msg/syzkaller-bugs/D2xWV7WTRDk/5y2kZyBICAAJ
>
> Yes, very likely.
>
>
> Takashi
