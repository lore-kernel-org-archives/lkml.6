Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524478696; cv=none;
        d=google.com; s=arc-20160816;
        b=MjJRQirahXaP37KeJGawIcrizrb24v808kJVjGoGBDrlVwZD1cazPo05X14VQIeFoQ
         7ojZPcnxTH4mSXCqm1ing2Bbg/Kgj8hfeMNbK2dKl7Gqch90Lc6rezPsStE0/9fLd1RK
         8jAjLjwfIy2UlEogv6GvX08ZDrGZ+z2FA/Xw37ryim1JrcUUy5lSN5KySTt5BOo3mHCt
         fF/TGEz4/ENHbQ3ft7jcmZbbtdfST5X/Ox7XnuWg+dWyV8+q2gd6VWFEg2c14zP4cA4I
         M0wEblfSfiG1pjUk8XXgWukqr1bHMOITrXWYiortJLsJ/mQW6BhYHwfw5YOMdBzTGh/Y
         3e7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=DOx9y6LkNzQAwDDVsLc9e2N+ipuXVq218G5ZyeEKlVw=;
        b=k+hT7TsvH3eJpWNLkBWeElv0ztCwebz0vxsM9yVMIgxiNV0bvF+0m/iZ1oj6+LHRjz
         +E+393H48Wvor7NGja33kNUXiX6h3Z2+tFGJIUqMQBjm4Jd+qRRy/cpfH+ZUUqSswmsy
         ujcNjLpVfp1nT7PLhFQS5lhgZjZA7PNdpM7a+QdtlbaWg6Y06SQki36umTk7HCPPtLQu
         YokWBU+fIPKMqw5WdGNyrovUmo8ydlKISctK00UdaPQOlcJWMEu/Enlh71FwG6/YUMIa
         TmonpmxiQxsU/0QZ3F5vNs/nKDFkqCnDLj5Sf7mA7Fm/XgVSWGE1X6l3Lo+b+WAqOH+Q
         L+dQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=uCG17X0S;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=uCG17X0S;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4/bX8WoY5NiZ7ojJyYGcYsEU6ntF8ZLg9PXepfLHC8g6ID7Zpa873GfilGIFXWWKUs1oLHf2C0MPBhqa0pyL4E=
MIME-Version: 1.0
In-Reply-To: <CAB0TPYGxrDF+egw9GUXhWaDnj6wkH8gKd=htyujUH4jzwSE8zA@mail.gmail.com>
References: <001a113f8f14113e790568fd0c02@google.com> <20180419213517.GA13221@gmail.com>
 <CAB0TPYGC_e9FZfDzVRQEJbjB7HfRvHZ+TUGAySzhOT3AHUUq8w@mail.gmail.com>
 <CACT4Y+YcODNPLzx5Zjjswz4mCcoootVQQGgwfsta+f8Vxn0RUA@mail.gmail.com>
 <CAB0TPYHLxjfmisvmVLOw+6XjV+mt=buZPJFCpg44JZpGimjLjw@mail.gmail.com>
 <CACT4Y+Y6cOgF4+TnFuU6NO8-ycpmo5=Ma-Dg+nAp71iTK64-Lw@mail.gmail.com> <CAB0TPYGxrDF+egw9GUXhWaDnj6wkH8gKd=htyujUH4jzwSE8zA@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 23 Apr 2018 12:17:55 +0200
Message-ID: <CACT4Y+YBGFBuMFUXYgOPCStfvAMNqxHmK_51zYev6GS-PmkcCw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in binder_release_work
To: Martijn Coenen <maco@android.com>
Cc: Eric Biggers <ebiggers3@gmail.com>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
	"open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>, Greg KH <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Todd Kjos <tkjos@android.com>,
	syzbot <syzbot+0cf1f1aa154f56ff2e8d@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596782986279945239?=
X-GMAIL-MSGID: =?utf-8?q?1598531773924972674?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 12:00 PM, Martijn Coenen <maco@android.com> wrote:
> On Mon, Apr 23, 2018 at 11:49 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> Since it's already in Greg's queue, it's not worth bothering. We can
>> fix up things here with these "#syz fix" tags in emails, which
>> associate fixes with bugs.
>
> I meant, when I sent the original patch a month or so ago, could
> syzbot have replied saying "The reported-by tag you used belongs to a
> bug that was already marked as closed by this other commit?".

syzbot does not extract this info from patch emails.
First of all, it's not possible to discover them all.
Second, a mailed patch does not mean committed patch. v2 can be resent
and potentially change title too.

syzbot takes this info from commits in the tree it tests. It probably
could extract some emails from the commit. But they can come months
later, so their value will be questionable. Also consider that 2
commits in different trees mention the same bug. syzbot generally
overwrites old info with new info, because that's the only way to fix
up things. Now this can lead to infinite stream of emails saying that
this commit fixes this bug, no that commit fixes this bug, no this
commit fixes this bug, etc.
Also consider that a bug is first marked as fixed with some commit,
bug later is marked as dup of another or re-marked as fixed with
another commit. You won't get a notification, because the whole
sequence looks reasonable.
This can also lead to problems when commits backported to
android/chromeos trees that syzbot also tests. There these fix tags
look plain bogus because they reference upstream bug, not
android/chromeos bugs.

By default we try to keep syzbot silent and non-spammy. And we do not
seem to have lots of such cases where things are somewhat messed. And
in all cases it should come to eventual consistency. If something is
marked as fixed prematurely, syzbot will open another bug. If
something is not marked as fixed (or marked as fixed with a
non-existent commit), then these bugs still hang on the dashboard and
visible.


>>> Thanks,
>>> Martijn
>>>
>>>> Now syzbot already skips list_del frame and takes the next one, so it
>>>> should become slightly better.
>>>>
>>>> Let's close this one with the binder fix (since that one was closed
>>>> with an rdma fix):
>>>>
>>>> #syz fix: ANDROID: binder: prevent transactions into own process.
