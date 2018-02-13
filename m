Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754209AbeBMTRF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 14:17:05 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46090 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbeBMTRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 14:17:02 -0500
X-Google-Smtp-Source: AH8x227DW8WYn474US0qyTEQy8+PlZ9xr51x6w/iLBa+uB4+iwg9qvp3M++3BI4PBKsYvFYhwBArOBg1nJb0fr047yo=
MIME-Version: 1.0
In-Reply-To: <20171130154641.GH21978@ZenIV.linux.org.uk>
References: <94eb2c19e756c0119b055f1afbd0@google.com> <CAM_iQpUuW=34pxJtkfw_sHTzmm3mUfrg-Fs3++kU+PktBfDJNg@mail.gmail.com>
 <CA+55aFzBAvNOsPzcf=9dO__of-jh4z7_a8BNFXzU7YHkmzYgkw@mail.gmail.com>
 <20171130020719.GE21978@ZenIV.linux.org.uk> <20171130131833.GA28908@infradead.org>
 <20171130154641.GH21978@ZenIV.linux.org.uk>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 13 Feb 2018 20:16:41 +0100
Message-ID: <CACT4Y+ZAQQW9kKWjq8HT-o878-Z=49n+JLEk+VnBSyR2E-+QFA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in sock_release
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        syzbot
        <bot+9abea25706ae35022385a41f61e579ed66e88a3f@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2017 at 4:46 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Thu, Nov 30, 2017 at 05:18:33AM -0800, Christoph Hellwig wrote:
>> On Thu, Nov 30, 2017 at 02:07:19AM +0000, Al Viro wrote:
>> > Incidentally, grepping for sys_close() shows another piece of fun in
>> > net/netfilter/xt_bpf.c.  Folks, ONCE DESCRIPTOR IS INSTALLED, THAT'S
>> > IT; THERE'S NO REMOVING IT ON FAILURE EXITS.  sys_close() should
>> > never, ever be used that way.  Sigh...
>>
>> Would be great do unexport the thing.  Except that we also have
>> binfmt_misc (which looks legit) and autofs4, which on crack decided
>> that close() isn't a fun syscall, they'd much rather have an ioctl
>> that does exactly the same..
>
> Yes, since binfmt_misc one is guaranteed that its descriptor table is
> not shared - all callchains go through do_execveat_common(), where we'd
> use unshare_files().  autofs one is... not in good taste, but still
> safe; there the descriptor is preexisting and it's essentially a weird
> way of spelling close(2).  References from syscall tables are, of course,
> OK.  init/*.c uses are done pretty much from userland - they could have
> been straight syscalls, if not for the lack of klibc in kernel tree.
> Everything else, though...
>
> IMO we need a whack-a-mole list somewhere; "new callers of sys_close()
> anywhere outside of init/* and syscall tables" definitely should be
> on it...


#syz fix: fix kcm_clone()
