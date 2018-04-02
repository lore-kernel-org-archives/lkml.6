Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756963AbeDBTJp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 15:09:45 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34260 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754430AbeDBTJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 15:09:39 -0400
X-Google-Smtp-Source: AIpwx4//9chit0fCh81tdhrAB35TF7P/KazfrCndwG34woDRuzIPkOZndzS8G/f8atNcCA1gQaz7Lw==
Date: Mon, 2 Apr 2018 12:09:36 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        syzbot
        <bot+ab09454bf4b7a7f8ce7e5e8d97e644d3314a0799@syzkaller.appspotmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Jim Mattson <jmattson@google.com>
Subject: Re: general protection fault in native_write_cr4
Message-ID: <20180402190936.GB59810@gmail.com>
References: <f403043a9be41c978c0560c0d164@google.com>
 <CANRm+Cy9-R=hBNwwUptVk_f8keX40-9yHkpqstWMP3pLSKpLGw@mail.gmail.com>
 <CACT4Y+ZxPD_6JEntRVGdngn2QBzABwubYohpKVcWJy0Hv-jXBg@mail.gmail.com>
 <CACT4Y+Zto0DQLwFtSxZbbkexqDeCwvJ4ks-QHAMn9=o6zxShnw@mail.gmail.com>
 <CACT4Y+ZvP=TqBhEG1iagYMFbwhAr6jXwXgUvkukrrRg+qaJLQw@mail.gmail.com>
 <37306EFA9975BE469F115FDE982C075BCE92C301@ORSMSX114.amr.corp.intel.com>
 <CACT4Y+b5KggyrgHAtBaL4svYjgQU_WZ3f5uCjmwiQnoYRQdbMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+b5KggyrgHAtBaL4svYjgQU_WZ3f5uCjmwiQnoYRQdbMQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 08:04:24PM +0200, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> On Mon, Apr 2, 2018 at 6:36 PM, Christopherson, Sean J
> <sean.j.christopherson@intel.com> wrote:
> > On Sat, 2018-03-31, Dmitry Vyukov wrote:
> >> On Wed, Dec 27, 2017 at 7:31 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> >> > On Tue, Dec 26, 2017 at 9:52 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> >> >> On Wed, Dec 20, 2017 at 8:54 AM, Wanpeng Li <kernellwp@gmail.com> wrote:
> >> >>> 2017-12-20 15:49 GMT+08:00 syzbot
> >> >>> <bot+ab09454bf4b7a7f8ce7e5e8d97e644d3314a0799@syzkaller.appspotmail.com>:
> >> >>>> Hello,
> >> >>>>
> >> >>>> syzkaller hit the following crash on
> >> >>>> f6f3732162b5ae3c771b9285a5a32d72b8586920
> >> >>>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
> >> >>>> compiler: gcc (GCC) 7.1.1 20170620
> >> >>>> .config is attached
> >> >>>> Raw console output is attached.
> >> >>>> C reproducer is attached
> >> >>>> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> >> >>>> for information about syzkaller reproducers
> >> >>>>
> >> >>>>
> >> >>>
> >> >>> I will have a look again, you continue to run it in kvm guest, right?
> >> >>
> >> >>
> >> >> Our test machines are GCE VMs, so yes, the kernel that catches GPF is
> >> >> run as kvm guest.
> >> >
> >> > up
> >> >
> >> > one of top crashers with 50K crashes
> >>
> >>
> >> This sets a new record of 130000 crashed machines on syzbot infrastructure:
> >>
> >> https://syzkaller.appspot.com/bug?id=2bf7b7983c2398ec6f0c4c6c87cb50223e8873f8
> >
> > This is more than likely a known bug in the GCE kernel, i.e. the L0
> > kernel.  The fix that Haozhong referenced needs to be applied to the
> > L0 kernel (GCE), the L1 kernel (Syzkaller) is irrelevant.  You said
> > that you double checked an upstream kernel, but I'm assuming you were
> > referring to patching the L1 kernel (Syzkaller).
> >
> > https://lkml.org/lkml/2017/10/31/432
> 
> Hi Sean,
> 
> Thanks! Either I did not associate these 2 threads as we shuffle
> hundreds of bugs, or I did not realize that this needs to be applied
> to L0. Anyway...
> 
> I will check with GCE folks.
> 

Some hosts have already been updated with the referenced commit but not all yet.
So assuming that was really the problem, syzbot should stop hitting this crash
eventually.  (For any Googlers following along, see Google-Bug-Id 72171735.)

Eric
