Return-Path: <maco@android.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524476465; cv=none;
        d=google.com; s=arc-20160816;
        b=vfjxJuf3npflnI1ZOtsHvKdpA/T/J3bXX6gaqS1JGIj/d4lekg/qRIQhepj06uVvif
         adfHYoxYIR4kURUXCkqDXX7F40KKhE+UPOC1JOXdbBehSv1OMOIUDND1cYqGU1HNbsQ2
         5Dvkcv+lb9pVchFE/lTLlH/lUnzxq/LMkENlzQyHxT3gxPRmQxiXGPVxU2uUooEMdTEy
         cIkZJWA+9FsJHgKh7xoXfS5ggRW88GK3t5gXIU1mVl8RIc+319rNFLuDo/O6JQ3tSeB5
         jBZJbBWi0fXj9KJZehwkF/cBwb6eM+iVBpSSgCnTLQFjO2gYI71Ge89uvROti2nFTeae
         zAQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=goX6+SZhn6hnD8M7/lfEsIGTWUjenvD354YXEoZooPM=;
        b=DigdL2T3o9trtEwd6fpgD8aloYJvCI1ZYlYVasQTX72fqBxRzI56YITR7T8x3BmpL/
         NT13TJL0pVcrJNXpOOp1Yn5slmWNfJmSullBWrdOfPnv+vdjE8/D/0/oWT+5TY0bezBz
         sOaAnbwKKE75rBzvmLty+KgKXie7kDm94/ECpjpAaCdv1fhp58jvFp/7C1bE6VJZtNQu
         AiWC7pR4iLFQDfeTW69pRRsb02rsnw2nvjdhNMCAdkbVRGXaxy939f58F5o0vxskHLmI
         +ZXA5biZWsLRts4ibiWuRrefR75BqdLMmNRhHtWEpDD+3Xq2vpri2fKQ6t9fdwadztO+
         pgag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=ALQFdfdR;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=ALQFdfdR;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
X-Google-Smtp-Source: AB8JxZo+hcCDDLan9x+rdjBcMGKnNj+5oaG21WldxOKhpB+qc+M+6Iow66FnRkJRyGyw6tZkNeTthWFlePaHjKyo7SY=
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YcODNPLzx5Zjjswz4mCcoootVQQGgwfsta+f8Vxn0RUA@mail.gmail.com>
References: <001a113f8f14113e790568fd0c02@google.com> <20180419213517.GA13221@gmail.com>
 <CAB0TPYGC_e9FZfDzVRQEJbjB7HfRvHZ+TUGAySzhOT3AHUUq8w@mail.gmail.com> <CACT4Y+YcODNPLzx5Zjjswz4mCcoootVQQGgwfsta+f8Vxn0RUA@mail.gmail.com>
From: Martijn Coenen <maco@android.com>
Date: Mon, 23 Apr 2018 11:41:04 +0200
Message-ID: <CAB0TPYHLxjfmisvmVLOw+6XjV+mt=buZPJFCpg44JZpGimjLjw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in binder_release_work
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Eric Biggers <ebiggers3@gmail.com>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
	"open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>, Greg KH <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Todd Kjos <tkjos@android.com>,
	syzbot <syzbot+0cf1f1aa154f56ff2e8d@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596782986279945239?=
X-GMAIL-MSGID: =?utf-8?q?1598529434430643153?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 11:28 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> https://syzkaller.appspot.com/bug?extid=09e05aba06723a94d43d
> and that happened in binder. But then syzkaller found a reproducer for
> it, but it turned out to be in rdma subsystem. It's generally not
> possible to properly distinguish different bugs that look similar, and
> if syzbot does more sensitive bug classification, then it will also
> inevitably report more duplicates. So that bug was closed as an rdma
> bug.

Thanks for the clarification! It looks like I sent the patch with the
original reported-by tag after it was closed as an rdma issue; would
it help if syzbot sent a reply saying this bug was already marked as
closed with a different commit, or are there other complications with
that?

Thanks,
Martijn

> Now syzbot already skips list_del frame and takes the next one, so it
> should become slightly better.
>
> Let's close this one with the binder fix (since that one was closed
> with an rdma fix):
>
> #syz fix: ANDROID: binder: prevent transactions into own process.
