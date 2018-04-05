Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522936820; cv=none;
        d=google.com; s=arc-20160816;
        b=yFCXA09yhYudEhTLhSv+B2xl9B3hbSfoJcT07OZezVUMDTn5pEUU2jKELqZSGgu0eV
         FkuBBnik9v3hDbXhTw3bvRYNYxuZhDeyiZCJ1XXO8hOSB+G9VkAZQnEc1jF42a62KPfj
         1Bs1TAMSWwSVTCR9lQ7FdwmTtIVwBBYmFc4omuyCS5O42nEbQSK2H/1aHyBT49648n5z
         cpMjEl9XjI+MjeIjRMLf4zOjGdZYnpzdA/CW21D6SIlDey60joyFLSMzlxujWyLH/pFn
         MAxjsc/kl90NHY9Ocu62FEhElieC0pC6sDn1BB1a8uZvnqWpy6l3hHeLQjaedqbXwyBh
         X92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=XAz8RXy8yD7XoNdCJTGLCFIOX8AjEIhZ3FVWBb0AfjU=;
        b=uvgwv/Vht9y+1KGEbQQRxML0irIfqWdRzqnk0Q4s2FcwbC0B0xdVR1o+KjsV3gkKOd
         8PQqBoKJF9ydLZTh5eSFIG8YAb9NqZmTqdw1jCd1xu53Q24eZzl28D0UMAr1vGiqFLTu
         xlitpEvND6NrxiLSrKme4InsnLeDVG70WHvEMs/kjm9gWkzim4t8/58il/Y6fxXATlWF
         hkT6gHowAdOtqAxmkRk6onb1BCCJVpoBTUAJXLBWe8phjysiCm6ikn7dQE+ms0IPXq2A
         W2DpLg36nbTdg86mHaIX91ChULiw8TuZ9zqxYXS+8p6YlnEvPePtF00qlSMWoN5+lVXK
         4HQg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=CFL8qwJJ;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=CFL8qwJJ;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx48BZHLimKtiUw8V+6kMF1SFakJE9NsjDCmW+gDEKCYXbFxBcbfTw+rYaBMCgXQxUgj7cEJFVOErF2133t/XNLw=
MIME-Version: 1.0
In-Reply-To: <20180405133430.GA21390@kroah.com>
References: <f4f5e80803d0503e760569105376@google.com> <20180405063444.GA5877@kroah.com>
 <CACT4Y+Yi1QoM_NAWp8e6MvyCOBhFedL30-uKzuM6h8pG=ftu0w@mail.gmail.com>
 <26e497b0-1e10-d9c6-73eb-e0feed9a60ea@redhat.com> <CACT4Y+bvwtV=AT1R48k0WfODQYOZgNC-tSHcGBBoMpT6gQH5QQ@mail.gmail.com>
 <97ada9f8-93e0-b321-e588-2d3b34b10ef8@redhat.com> <20180405133430.GA21390@kroah.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 5 Apr 2018 15:59:58 +0200
Message-ID: <CACT4Y+Z4jyhBQ4R5cGgR=g2=fOLKtbZUneryYOZY3uqPXoZMzg@mail.gmail.com>
Subject: Re: WARNING: kobject bug in sysfs_warn_dup
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Steven Whitehouse <swhiteho@redhat.com>, rpeterso@redhat.com, cluster-devel@redhat.com,
	syzbot <syzbot+ff87a28e665c163aa7f5@syzkaller.appspotmail.com>,
	LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596869807528039825?=
X-GMAIL-MSGID: =?utf-8?q?1596914999718561300?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 3:34 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Apr 05, 2018 at 10:00:04AM +0100, Steven Whitehouse wrote:
>> Hi,
>>
>>
>> On 05/04/18 09:52, Dmitry Vyukov wrote:
>> > On Thu, Apr 5, 2018 at 10:36 AM, Steven Whitehouse <swhiteho@redhat.com> wrote:
>> > > Hi,
>> > >
>> > >
>> > >
>> > > On 05/04/18 09:19, Dmitry Vyukov wrote:
>> > > > On Thu, Apr 5, 2018 at 8:34 AM, Greg KH <gregkh@linuxfoundation.org>
>> > > > wrote:
>> > > > > On Wed, Apr 04, 2018 at 07:02:01PM -0700, syzbot wrote:
>> > > > > > Hello,
>> > > > > >
>> > > > > > syzbot hit the following crash on upstream commit
>> > > > > > 3e968c9f1401088abc9a19ae6ff571644d37a355 (Wed Apr 4 21:19:24 2018 +0000)
>> > > > > > Merge tag 'ext4_for_linus' of
>> > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
>> > > > > > syzbot dashboard link:
>> > > > > > https://syzkaller.appspot.com/bug?extid=ff87a28e665c163aa7f5
>> > > > > >
>> > > > > > C reproducer:
>> > > > > > https://syzkaller.appspot.com/x/repro.c?id=5104666266304512
>> > > > > > syzkaller reproducer:
>> > > > > > https://syzkaller.appspot.com/x/repro.syz?id=5683447737614336
>> > > > > > Raw console output:
>> > > > > > https://syzkaller.appspot.com/x/log.txt?id=5104818200772608
>> > > > > > Kernel config:
>> > > > > > https://syzkaller.appspot.com/x/.config?id=9118669095563550941
>> > > > > > compiler: gcc (GCC) 7.1.1 20170620
>> > > > > >
>> > > > > > IMPORTANT: if you fix the bug, please add the following tag to the
>> > > > > > commit:
>> > > > > > Reported-by: syzbot+ff87a28e665c163aa7f5@syzkaller.appspotmail.com
>> > > > > > It will help syzbot understand when the bug is fixed. See footer for
>> > > > > > details.
>> > > > > > If you forward the report, please keep this part and the footer.
>> > > > > >
>> > > > > > R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000003
>> > > > > > R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
>> > > > > > ------------[ cut here ]------------
>> > > > > > kobject_add_internal failed for nodev( with -EEXIST, don't try to
>> > > > > > register
>> > > > > > things with the same name in the same directory.
>> > > > > > sysfs: cannot create duplicate filename '/fs/gfs2/nodev('
>> > > > > > WARNING: CPU: 1 PID: 4473 at lib/kobject.c:238
>> > > > > > kobject_add_internal+0x8d4/0xbc0 lib/kobject.c:235
>> > > > > > CPU: 0 PID: 4474 Comm: syzkaller533472 Not tainted 4.16.0+ #15
>> > > > > > Kernel panic - not syncing: panic_on_warn set ...
>> > > > > >
>> > > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> > > > > > Google 01/01/2011
>> > > > > > Call Trace:
>> > > > > >    __dump_stack lib/dump_stack.c:17 [inline]
>> > > > > >    dump_stack+0x1a7/0x27d lib/dump_stack.c:53
>> > > > > >    sysfs_warn_dup+0x83/0xa0 fs/sysfs/dir.c:30
>> > > > > >    sysfs_create_dir_ns+0x178/0x1d0 fs/sysfs/dir.c:58
>> > > > > >    create_dir lib/kobject.c:69 [inline]
>> > > > > >    kobject_add_internal+0x335/0xbc0 lib/kobject.c:227
>> > > > > >    kobject_add_varg lib/kobject.c:364 [inline]
>> > > > > >    kobject_init_and_add+0xf9/0x150 lib/kobject.c:436
>> > > > > >    gfs2_sys_fs_add+0x1ff/0x580 fs/gfs2/sys.c:652
>> > > > > >    fill_super+0x86f/0x1d70 fs/gfs2/ops_fstype.c:1118
>> > > > > >    gfs2_mount+0x587/0x6e0 fs/gfs2/ops_fstype.c:1321
>> > > > > gfs2 bug, not a sysfs bug, we are correctly warning about an incorrect
>> > > > > usage of the api.
>> > > > Then +gfs2 maintainers.
>> > > >
>> > > > > Now if we should turn this into a non-WARN message, that's a different
>> > > > > thing, I'll gladly take a patch for that.
>> > > > If it's API usage bug in higher level code, then I think WARN is a
>> > > > proper thing. We already had similar ones and they were fixed.
>> > >
>> > > I'm trying to figure out what the test is doing, but it is not very clear.
>> > > At a guess I'd say that perhaps it is trying to mount multiple filesystems
>> > > with the same label? If that is the case then it is not allowed, and it
>> > > should be caught be the sysfs code and result in a refusal to mount, which
>> > > is what I think I see here. Knowing which sysfs directory is involved would
>> > > allow us to confirm, but I suspect that the test needs altering to give each
>> > > gfs2 mount a different label at an initial guess,
>> >
>> > Hi Steve,
>> >
>> > But Greg claims that this is incorrect usage of sysfs API:
>> >
>> > > gfs2 bug, not a sysfs bug, we are correctly warning about an incorrect
>> > > usage of the api.
>> > I think this means that sysfs callers must not try to create the same
>> > thing twice.
>> >
>> > Either way user-space code must not be able to triggers WARNINGs in
>> > kernel. If it does than this is something to fix in kernel.
>>
>> I guess that this warning was added more recently as I've not seen it
>> before.
>
> No, it has been there since at least the 3.13 kernel release (back in
> 2013), which is where it got moved to a separate function, but the logic
> has been around in the kernel tree for much longer than that as seen in
> commit d1c1459e4594 ("sysfs: separate out dup filename warning into a
> separate function")
>
>> My expectation is that it will return -EEXIST and not print a
>> warning there. To avoid that we would have to create a new list of GFS2
>> superblocks, and check the list for each mount I think. We could do that,
>> but it seems a bit odd to duplicate code that is already there and working.
>
> Don't you have a list of the "names" of the things you are creating
> somewhere?  Or are you relying on sysfs to do your housekeeping for you?
>
> Also, why did this trigger a syzbot report?  It's only a dump_stack()
> reference, one showing that yes, this is something that should not be
> done, but the kernel keeps on working afterward.

There is a WARN(), not just dump_stack():

                        WARN(1, "%s failed for %s with "
                             "-EEXIST, don't try to register things with "
                             "the same name in the same directory.\n",
                             __func__, kobject_name(kobj));
