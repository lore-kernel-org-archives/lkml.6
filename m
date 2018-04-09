Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754088AbeDIED5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 00:03:57 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44859 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbeDIEDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 00:03:53 -0400
X-Google-Smtp-Source: AIpwx4/L1NBGDqpnzHATCP6SyKvQKem3Ru5/SEcbPRn6yWSJy+Ul2OfB48PcHERl0jOq/79ej7QHzA==
Date: Sun, 8 Apr 2018 21:04:33 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: Kevin Easton <kevin@guarana.org>
Cc: davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com,
        syzbot
        <bot+5022a34ca5a3d49b84223653fab632dfb7b4cf37@syzkaller.appspotmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in pfkey_add
Message-ID: <20180409040433.GJ685@sol.localdomain>
References: <001a114292fadd3e2505607060a8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a114292fadd3e2505607060a8@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2017 at 11:51:01PM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
> 
> 
> audit: type=1400 audit(1513021744.055:7): avc:  denied  { map } for
> pid=3149 comm="syzkaller428285" path="/root/syzkaller428285483" dev="sda1"
> ino=16481 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:341 [inline]
> BUG: KASAN: slab-out-of-bounds in pfkey_msg2xfrm_state net/key/af_key.c:1212
> [inline]
> BUG: KASAN: slab-out-of-bounds in pfkey_add+0x1634/0x3270
> net/key/af_key.c:1491
> Read of size 8192 at addr ffff8801c5197318 by task syzkaller428285/3149
> 
> CPU: 0 PID: 3149 Comm: syzkaller428285 Not tainted 4.15.0-rc3+ #127
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  print_address_description+0x73/0x250 mm/kasan/report.c:252
>  kasan_report_error mm/kasan/report.c:351 [inline]
>  kasan_report+0x25b/0x340 mm/kasan/report.c:409
>  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
>  check_memory_region+0x137/0x190 mm/kasan/kasan.c:267
>  memcpy+0x23/0x50 mm/kasan/kasan.c:302
>  memcpy include/linux/string.h:341 [inline]
>  pfkey_msg2xfrm_state net/key/af_key.c:1212 [inline]
>  pfkey_add+0x1634/0x3270 net/key/af_key.c:1491
>  pfkey_process+0x60b/0x720 net/key/af_key.c:2809
>  pfkey_sendmsg+0x4d6/0x9f0 net/key/af_key.c:3648
>  sock_sendmsg_nosec net/socket.c:636 [inline]
>  sock_sendmsg+0xca/0x110 net/socket.c:646
>  ___sys_sendmsg+0x75b/0x8a0 net/socket.c:2026
>  __sys_sendmsg+0xe5/0x210 net/socket.c:2060
>  C_SYSC_sendmsg net/compat.c:739 [inline]
>  compat_SyS_sendmsg+0x2a/0x40 net/compat.c:737
>  do_syscall_32_irqs_on arch/x86/entry/common.c:327 [inline]
>  do_fast_syscall_32+0x3ee/0xf9d arch/x86/entry/common.c:389
>  entry_SYSENTER_compat+0x51/0x60 arch/x86/entry/entry_64_compat.S:125
> RIP: 0023:0xf7fd4c79
> RSP: 002b:00000000ff9d7c1c EFLAGS: 00000203 ORIG_RAX: 0000000000000172
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000205f5000
> RDX: 0000000000000000 RSI: 0000000000000167 RDI: 000000000000000f
> RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> 

Looks like this is going to be fixed by
https://patchwork.kernel.org/patch/10327883/ ("af_key: Always verify length of
provided sadb_key"), but it's not applied yet to the ipsec tree yet.  Kevin, for
future reference, for syzbot bugs it would be helpful to reply to the original
bug report and say that a patch was sent out, or even better send the patch as a
reply to the bug report email, e.g.

	git format-patch --in-reply-to="<001a114292fadd3e2505607060a8@google.com>"

for this one (and the Message ID can be found in the syzkaller-bugs archive even
if the email isn't in your inbox).  Otherwise people may not know that a patch
was sent out and do redundant work.  Thanks!

I also simplified the reproducer for this, so here it is just in case someone
wants it anyway:

        #include <sys/socket.h>
        #include <unistd.h>
    
        int main()
        {
                int fd = socket(AF_KEY, SOCK_RAW, 2);
                char msg[96] =
                "\x02\x03\x00\x02\x0c\x00\x00\x00\x00\x00\x00\x01\x02\x00\x00\x00"
                "\x03\x00\x05\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00"
                "\x00\x00\x00\x00\x00\x00\x00\x00"
                "\x03\x00\x06\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00"
                "\x00\x00\x00\x00\x00\x00\x00\x00"
                "\x02\x00\x01\x00\x00\x00\x00\x00\x00\x00\xfb\x00\x00\x00\x00\x00"
                "\x02\x00\x08\x00\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00";
    
                write(fd, msg, sizeof(msg));
        }

It causes a 8192-byte out-of-bounds read.

Eric
