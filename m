Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522919129; cv=none;
        d=google.com; s=arc-20160816;
        b=J1a7ZhVRJaRs/kfxo9kXoF6niVU73VOEpwEQ0he982IEzLrlxWj664ddi2BLecKitb
         WoUiSDS3uJUfNpfs4rDNLCIZrGRP8uU1Esh9MA0ybpisFwpMlR+yBtIkCfWc7P2dLkZr
         ty+H33JgFfvHcCvJTwcT76FoJaVnjHY5NQ4xSVTiBvFC3mXkVjchFp+x3XxOI0urVV/w
         MTMh0aQbe6CsRD0hbEZGX/6sF3+9jR5TiCKYFgAobchTJ5JuS237Zy0rnNqGr3G+9nEh
         triyV0/quSQg2pnJxZMIT/Qai9pUHq5TSZPaOinRjHjs9bgc+A4XvETZzJsSslYhuV+Y
         jE9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=KDqfwSoU6mnREvK2q/bimhUpUMY0NbHCk0+fELizw0c=;
        b=MPTDXOOU+2cKmLH2tQvj/wg6SE/KTr4SyLmZ/ROSJD4YochmJPe43tR4EZlzKirPaO
         EiIRnDuSYsIgqtPdfCdHAc9zzDGWzVL5gW1vhQhAyX4UstmgoN0fh1OcM02eN9VpDlwF
         3c30wVW9cQU+yGMM0BlRIXFHaFrvsc+AnM/3EZaYSziQoyAYR1ZTwJ1Bm/YlqUN4jaYv
         PP1MNj41PCfDww7eNZs09kTOzu9zycTdOAQcNAClgsUa5BfOUBo952/Y1jIDbD6Sa8nZ
         0rH3iYhBAjnanrQJHpGLRrXt+Zhiex3Tow1p6cM1r8Bws+32sRMOeFR7VzuGFFLgcFX5
         lSEw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=rLjW0wyq;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=rLjW0wyq;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4+bdn/+kEhFj286LgCLExx8YMLrSJixESGz/ZLqp7ifERJlPXdmfGYa+5ww6RRBrdVe/zeA1nDhsHwTloMv/lY=
MIME-Version: 1.0
In-Reply-To: <97ada9f8-93e0-b321-e588-2d3b34b10ef8@redhat.com>
References: <f4f5e80803d0503e760569105376@google.com> <20180405063444.GA5877@kroah.com>
 <CACT4Y+Yi1QoM_NAWp8e6MvyCOBhFedL30-uKzuM6h8pG=ftu0w@mail.gmail.com>
 <26e497b0-1e10-d9c6-73eb-e0feed9a60ea@redhat.com> <CACT4Y+bvwtV=AT1R48k0WfODQYOZgNC-tSHcGBBoMpT6gQH5QQ@mail.gmail.com>
 <97ada9f8-93e0-b321-e588-2d3b34b10ef8@redhat.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 5 Apr 2018 11:05:07 +0200
Message-ID: <CACT4Y+ZoOS770-gnQ-dmBvQaLQrr=dAvKOOuxP7OK=J85RP8Lw@mail.gmail.com>
Subject: Re: WARNING: kobject bug in sysfs_warn_dup
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, rpeterso@redhat.com,
	cluster-devel@redhat.com,
	syzbot <syzbot+ff87a28e665c163aa7f5@syzkaller.appspotmail.com>,
	LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596869807528039825?=
X-GMAIL-MSGID: =?utf-8?q?1596896449175583948?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 11:00 AM, Steven Whitehouse <swhiteho@redhat.com> wrote:
> Hi,
>
>
>
> On 05/04/18 09:52, Dmitry Vyukov wrote:
>>
>> On Thu, Apr 5, 2018 at 10:36 AM, Steven Whitehouse <swhiteho@redhat.com>
>> wrote:
>>>
>>> Hi,
>>>
>>>
>>>
>>> On 05/04/18 09:19, Dmitry Vyukov wrote:
>>>>
>>>> On Thu, Apr 5, 2018 at 8:34 AM, Greg KH <gregkh@linuxfoundation.org>
>>>> wrote:
>>>>>
>>>>> On Wed, Apr 04, 2018 at 07:02:01PM -0700, syzbot wrote:
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> syzbot hit the following crash on upstream commit
>>>>>> 3e968c9f1401088abc9a19ae6ff571644d37a355 (Wed Apr 4 21:19:24 2018
>>>>>> +0000)
>>>>>> Merge tag 'ext4_for_linus' of
>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
>>>>>> syzbot dashboard link:
>>>>>> https://syzkaller.appspot.com/bug?extid=ff87a28e665c163aa7f5
>>>>>>
>>>>>> C reproducer:
>>>>>> https://syzkaller.appspot.com/x/repro.c?id=5104666266304512
>>>>>> syzkaller reproducer:
>>>>>> https://syzkaller.appspot.com/x/repro.syz?id=5683447737614336
>>>>>> Raw console output:
>>>>>> https://syzkaller.appspot.com/x/log.txt?id=5104818200772608
>>>>>> Kernel config:
>>>>>> https://syzkaller.appspot.com/x/.config?id=9118669095563550941
>>>>>> compiler: gcc (GCC) 7.1.1 20170620
>>>>>>
>>>>>> IMPORTANT: if you fix the bug, please add the following tag to the
>>>>>> commit:
>>>>>> Reported-by: syzbot+ff87a28e665c163aa7f5@syzkaller.appspotmail.com
>>>>>> It will help syzbot understand when the bug is fixed. See footer for
>>>>>> details.
>>>>>> If you forward the report, please keep this part and the footer.
>>>>>>
>>>>>> R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000003
>>>>>> R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
>>>>>> ------------[ cut here ]------------
>>>>>> kobject_add_internal failed for nodev( with -EEXIST, don't try to
>>>>>> register
>>>>>> things with the same name in the same directory.
>>>>>> sysfs: cannot create duplicate filename '/fs/gfs2/nodev('
>>>>>> WARNING: CPU: 1 PID: 4473 at lib/kobject.c:238
>>>>>> kobject_add_internal+0x8d4/0xbc0 lib/kobject.c:235
>>>>>> CPU: 0 PID: 4474 Comm: syzkaller533472 Not tainted 4.16.0+ #15
>>>>>> Kernel panic - not syncing: panic_on_warn set ...
>>>>>>
>>>>>> Hardware name: Google Google Compute Engine/Google Compute Engine,
>>>>>> BIOS
>>>>>> Google 01/01/2011
>>>>>> Call Trace:
>>>>>>    __dump_stack lib/dump_stack.c:17 [inline]
>>>>>>    dump_stack+0x1a7/0x27d lib/dump_stack.c:53
>>>>>>    sysfs_warn_dup+0x83/0xa0 fs/sysfs/dir.c:30
>>>>>>    sysfs_create_dir_ns+0x178/0x1d0 fs/sysfs/dir.c:58
>>>>>>    create_dir lib/kobject.c:69 [inline]
>>>>>>    kobject_add_internal+0x335/0xbc0 lib/kobject.c:227
>>>>>>    kobject_add_varg lib/kobject.c:364 [inline]
>>>>>>    kobject_init_and_add+0xf9/0x150 lib/kobject.c:436
>>>>>>    gfs2_sys_fs_add+0x1ff/0x580 fs/gfs2/sys.c:652
>>>>>>    fill_super+0x86f/0x1d70 fs/gfs2/ops_fstype.c:1118
>>>>>>    gfs2_mount+0x587/0x6e0 fs/gfs2/ops_fstype.c:1321
>>>>>
>>>>> gfs2 bug, not a sysfs bug, we are correctly warning about an incorrect
>>>>> usage of the api.
>>>>
>>>> Then +gfs2 maintainers.
>>>>
>>>>> Now if we should turn this into a non-WARN message, that's a different
>>>>> thing, I'll gladly take a patch for that.
>>>>
>>>> If it's API usage bug in higher level code, then I think WARN is a
>>>> proper thing. We already had similar ones and they were fixed.
>>>
>>>
>>> I'm trying to figure out what the test is doing, but it is not very
>>> clear.
>>> At a guess I'd say that perhaps it is trying to mount multiple
>>> filesystems
>>> with the same label? If that is the case then it is not allowed, and it
>>> should be caught be the sysfs code and result in a refusal to mount,
>>> which
>>> is what I think I see here. Knowing which sysfs directory is involved
>>> would
>>> allow us to confirm, but I suspect that the test needs altering to give
>>> each
>>> gfs2 mount a different label at an initial guess,
>>
>>
>> Hi Steve,
>>
>> But Greg claims that this is incorrect usage of sysfs API:
>>
>>> gfs2 bug, not a sysfs bug, we are correctly warning about an incorrect
>>> usage of the api.
>>
>> I think this means that sysfs callers must not try to create the same
>> thing twice.
>>
>> Either way user-space code must not be able to triggers WARNINGs in
>> kernel. If it does than this is something to fix in kernel.
>
>
> I guess that this warning was added more recently as I've not seen it
> before. My expectation is that it will return -EEXIST and not print a
> warning there. To avoid that we would have to create a new list of GFS2
> superblocks, and check the list for each mount I think. We could do that,
> but it seems a bit odd to duplicate code that is already there and working.
>
> So it sounds like a case of differing assumptions about what is a valid use
> of the sysfs api. Shouldn't be too hard to fix though,


Greg?

Should we go with your other option of demoting WARNING to pr_err
then? I don't how many real bugs that warning caught versus callers
just properly handle EEXIST.
