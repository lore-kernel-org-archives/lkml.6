Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751720AbeBAWWR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 17:22:17 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:39722 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeBAWWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 17:22:10 -0500
X-Google-Smtp-Source: AH8x225cYGaeWWbQFth8lEE1h2JGJzpG4hubrGQD5uO2O1WZAupEFWDauWFfcjhNJeM8c2cZE00fBg==
Date: Thu, 1 Feb 2018 14:22:06 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot <syzbot+6345fd433db009b29413@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net,
        ying.xue@windriver.com
Subject: Re: suspicious RCU usage at net/tipc/bearer.c:LINE
Message-ID: <20180201222206.mc2ecgu32pbzea4m@gmail.com>
References: <001a113ee06adadb9b0561a771a3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a113ee06adadb9b0561a771a3@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2017 at 10:58:01AM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> 5aa90a84589282b87666f92b6c3c917c8080a9bf
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
> 
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+6345fd433db009b29413@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> audit: type=1400 audit(1514679888.244:9): avc:  denied  { write } for
> pid=3194 comm="syzkaller021477" path="socket:[11143]" dev="sockfs" ino=11143
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tclass=netlink_generic_socket permissive=1
> =============================
> WARNING: suspicious RCU usage
> 4.15.0-rc5+ #152 Not tainted
> -----------------------------
> net/tipc/bearer.c:177 suspicious rcu_dereference_protected() usage!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> 2 locks held by syzkaller021477/3194:
>  #0:  (cb_lock){++++}, at: [<00000000d20133ea>] genl_rcv+0x19/0x40
> net/netlink/genetlink.c:634
>  #1:  (genl_mutex){+.+.}, at: [<00000000fcc5d1bc>] genl_lock
> net/netlink/genetlink.c:33 [inline]
>  #1:  (genl_mutex){+.+.}, at: [<00000000fcc5d1bc>] genl_rcv_msg+0x115/0x140
> net/netlink/genetlink.c:622
> 
> stack backtrace:
> CPU: 1 PID: 3194 Comm: syzkaller021477 Not tainted 4.15.0-rc5+ #152
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  lockdep_rcu_suspicious+0x123/0x170 kernel/locking/lockdep.c:4585
>  tipc_bearer_find+0x2b4/0x3b0 net/tipc/bearer.c:177
>  tipc_nl_compat_link_set+0x329/0x9f0 net/tipc/netlink_compat.c:729
>  __tipc_nl_compat_doit net/tipc/netlink_compat.c:288 [inline]
>  tipc_nl_compat_doit+0x15b/0x660 net/tipc/netlink_compat.c:335
>  tipc_nl_compat_handle net/tipc/netlink_compat.c:1119 [inline]
>  tipc_nl_compat_recv+0x112f/0x18f0 net/tipc/netlink_compat.c:1201
>  genl_family_rcv_msg+0x7b7/0xfb0 net/netlink/genetlink.c:599
>  genl_rcv_msg+0xb2/0x140 net/netlink/genetlink.c:624
>  netlink_rcv_skb+0x21e/0x460 net/netlink/af_netlink.c:2408
>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:635
>  netlink_unicast_kernel net/netlink/af_netlink.c:1275 [inline]
>  netlink_unicast+0x4e8/0x6f0 net/netlink/af_netlink.c:1301
>  netlink_sendmsg+0xa4a/0xe60 net/netlink/af_netlink.c:1864
>  sock_sendmsg_nosec net/socket.c:636 [inline]
>  sock_sendmsg+0xca/0x110 net/socket.c:646
>  sock_write_iter+0x31a/0x5d0 net/socket.c:915
>  call_write_iter include/linux/fs.h:1772 [inline]
>  new_sync_write fs/read_write.c:469 [inline]
>  __vfs_write+0x684/0x970 fs/read_write.c:482
>  vfs_write+0x189/0x510 fs/read_write.c:544
>  SYSC_write fs/read_write.c:589 [inline]
>  SyS_write+0xef/0x220 fs/read_write.c:581
>  do_syscall_32_irqs_on arch/x86/entry/common.c:327 [inline]
>  do_fast_syscall_32+0x3ee/0xf9d arch/x86/entry/common.c:389
>  entry_SYSENTER_compat+0x54/0x63 arch/x86/entry/entry_64_compat.S:129
> 

This is still happening; looks like a missing lock in tipc_nl_compat_link_set().
Note that the reproducer isn't guaranteed to work as-is because the message it
sends to the netlink socket assumes that the "TIPC" generic netlink family was
assigned ID 31, when actually it is a dynamically assigned ID.  But it will
trigger if you adjust the message's ->nlmsg_type accordingly.

- Eric
