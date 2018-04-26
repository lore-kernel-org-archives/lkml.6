Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524729877; cv=none;
        d=google.com; s=arc-20160816;
        b=TNCQ+R1fOp6DFssn8mzZox1FAGsH7PCjzUGJZeXDVqjU35dHHA3/IO8MwxD97SGGMI
         DL0BYezT3eRcT1rwt/CIHJ1NjeikrAH12XGEyhlUDs2Ful7ol/1rhAuGdgHwdSwpxqrf
         9X3YuEupln47dsEEmqg0xDuQlyav0bZEh/CuMDCAMzxbX2MXp4XYfajaFkeBQUvMmg54
         mqXEwdI/7h/zwF/D7Unao6gvw5QuGLbhtrUju8XRROmhFG9wRZ1gLCGooa1e22wvkESH
         W2XKDzFIBddl95Qyz6Dzh5hOQvXJC5bcw/4iesCDegezlq95lPHwI0njsIaBBRwTKg2i
         tKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Vy9zaq0croSC2acavMLFSBtq9Nb0WS9kT55BZ4mrz8U=;
        b=0GQRcJDf/74SRxEFcAhxJMUHcuX7S33NKFMRRhSxtR02F4IV9IvgPHCpE+gt8OWSu6
         8XWda2mczhUB68yv2KcyZaSHC7Ecoam+0lUJeARs+p5yqjbh4LSq91z++glhPAcynS20
         yA4k3cQfjghWCi1LUI40OdC1v0d5v4IWHzjjwWLEagO4H/I6FWiPlb4tr8O38oB6okbT
         x/5oOw3kec8n43i6xuK5VfAckKXnYxkf9n2/cb7EXdLLAKockUi+4+rAC56+KefC2gye
         1kt/YHqP0fwBgMON8kXdRVPzJ85jkRVXzl0BluIy/8APeVX37kSy+EkwOKY9XLRRiDP+
         20xQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=BI87/Mx0;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=BI87/Mx0;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx48nutHnM9kQhOcInDFYwPrv0gT+qZuKXs5ni/27wezz48pu82t+GSIR10ApRSklggT6WSKeOiVCYd+F6ikY2mk=
MIME-Version: 1.0
In-Reply-To: <20180426061314.GH20683@leo.usersys.redhat.com>
References: <001a113de2d878ade40569941a21@google.com> <CACT4Y+afuYwoWEp1PJ-Noo-YBXmKKRErntBWy2fR6iz=_xFByQ@mail.gmail.com>
 <20180426061314.GH20683@leo.usersys.redhat.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 26 Apr 2018 10:04:16 +0200
Message-ID: <CACT4Y+aDko-kKP-u2S_UGBbB-uwnGw4dWTOSmXVDR3=osLJeFg@mail.gmail.com>
Subject: Re: WARNING: kobject bug in br_add_if
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: syzbot <syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com>,
	bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>,
	LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
	stephen hemminger <stephen@networkplumber.org>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1597463513858460385?=
X-GMAIL-MSGID: =?utf-8?q?1598795156382500804?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 8:13 AM, Hangbin Liu <liuhangbin@gmail.com> wrote:
> On Wed, Apr 11, 2018 at 05:18:23PM +0200, Dmitry Vyukov wrote:
>> On Wed, Apr 11, 2018 at 5:15 PM, syzbot
>> <syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com> wrote:
>> > Hello,
>> >
>> > syzbot hit the following crash on upstream commit
>> > 10b84daddbec72c6b440216a69de9a9605127f7a (Sat Mar 31 17:59:00 2018 +0000)
>> > Merge branch 'perf-urgent-for-linus' of
>> > git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>> > syzbot dashboard link:
>> > https://syzkaller.appspot.com/bug?extid=de73361ee4971b6e6f75
>> >
>> > So far this crash happened 4 times on net-next, upstream.
>> > Unfortunately, I don't have any reproducer for this crash yet.
>> > Raw console output:
>> > https://syzkaller.appspot.com/x/log.txt?id=5007286875455488
>> > Kernel config:
>> > https://syzkaller.appspot.com/x/.config?id=-2760467897697295172
>> > compiler: gcc (GCC) 7.1.1 20170620
>> >
>> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> > Reported-by: syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com
>> > It will help syzbot understand when the bug is fixed. See footer for
>> > details.
>> > If you forward the report, please keep this part and the footer.
>>
>> +Greg
>>
>> The plan is to remove this WARNING from kobject_add, if there are no objections.
>
> Hi Dmitry,
>
> For this bug, why should we remove the WARNING instead of adding a check in
> br_add_if()? Something like


Mainline because nobody wants to fix these.
If you think this is a real bug and you are ready to fix it, please
mail an official patch.


> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> index 82c1a6f..79dcc3d 100644
> --- a/net/bridge/br_if.c
> +++ b/net/bridge/br_if.c
> @@ -518,8 +518,8 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
>                 return -ELOOP;
>         }
>
> -       /* Device is already being bridged */
> -       if (br_port_exists(dev))
> +       /* Device still has master upper dev */
> +       if (netdev_master_upper_dev_get(dev))
>                 return -EBUSY;
>
>         /* No bridging devices that dislike that (e.g. wireless) */
>
> Thanks
> Hangbin
>>
>> > ------------[ cut here ]------------
>> > binder: 23650:23651 unknown command 1078223622
>> > kobject_add_internal failed for brport (error: -12 parent: bond0)
>> > binder: 23650:23651 ioctl c0306201 2000dfd0 returned -22
>> > WARNING: CPU: 1 PID: 23647 at lib/kobject.c:242
>> > kobject_add_internal+0x3f6/0xbc0 lib/kobject.c:240
>> > Kernel panic - not syncing: panic_on_warn set ...
>> >
>> > CPU: 1 PID: 23647 Comm: syz-executor7 Not tainted 4.16.0-rc7+ #374
>> > binder: BINDER_SET_CONTEXT_MGR already set
>> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> > Google 01/01/2011
>> > Call Trace:
>> >  __dump_stack lib/dump_stack.c:17 [inline]
>> >  dump_stack+0x194/0x24d lib/dump_stack.c:53
>> >  panic+0x1e4/0x41c kernel/panic.c:183
>> >  __warn+0x1dc/0x200 kernel/panic.c:547
>> >  report_bug+0x1f4/0x2b0 lib/bug.c:186
>> >  fixup_bug.part.10+0x37/0x80 arch/x86/kernel/traps.c:178
>> >  fixup_bug arch/x86/kernel/traps.c:247 [inline]
>> >  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>> >  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>> >  invalid_op+0x1b/0x40 arch/x86/entry/entry_64.S:986
>> > RIP: 0010:kobject_add_internal+0x3f6/0xbc0 lib/kobject.c:240
>> > RSP: 0018:ffff8801d089f560 EFLAGS: 00010286
>> > RAX: dffffc0000000008 RBX: ffff8801adbee178 RCX: ffffffff815b193e
>> > RDX: 0000000000040000 RSI: ffffc900022aa000 RDI: 1ffff1003a113e31
>> > RBP: ffff8801d089f658 R08: 1ffff1003a113df3 R09: 0000000000000000
>> > R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff1003a113eb2
>> > R13: 00000000fffffff4 R14: ffff8801abd88828 R15: ffff8801d75a1e00
>> >  kobject_add_varg lib/kobject.c:364 [inline]
>> >  kobject_init_and_add+0xf9/0x150 lib/kobject.c:436
>> >  br_add_if+0x79a/0x1a70 net/bridge/br_if.c:533
>> >  add_del_if+0xf4/0x140 net/bridge/br_ioctl.c:101
>> >  br_dev_ioctl+0xa2/0xc0 net/bridge/br_ioctl.c:396
>> >  dev_ifsioc+0x333/0x9b0 net/core/dev_ioctl.c:334
>> >  dev_ioctl+0x176/0xbe0 net/core/dev_ioctl.c:500
>> >  sock_do_ioctl+0x1ba/0x390 net/socket.c:981
>> >  sock_ioctl+0x367/0x670 net/socket.c:1081
>> >  vfs_ioctl fs/ioctl.c:46 [inline]
>> >  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
>> >  SYSC_ioctl fs/ioctl.c:701 [inline]
>> >  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>> >  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>> >  entry_SYSCALL_64_after_hwframe+0x42/0xb7
>> > RIP: 0033:0x454e79
>> > RSP: 002b:00007eff7dab7c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>> > RAX: ffffffffffffffda RBX: 00007eff7dab86d4 RCX: 0000000000454e79
>> > RDX: 0000000020000000 RSI: 00000000000089a2 RDI: 0000000000000014
>> > RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
>> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000015
>> > R13: 0000000000000369 R14: 00000000006f7278 R15: 0000000000000006
>> > Dumping ftrace buffer:
>> >    (ftrace buffer empty)
>> > Kernel Offset: disabled
>> > Rebooting in 86400 seconds..
