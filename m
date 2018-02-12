Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933430AbeBLMeD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:34:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932925AbeBLMeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:34:01 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH 0/3] simplify struct audit_krule reveals bug
Date: Mon, 12 Feb 2018 07:29:38 -0500
Message-Id: <cover.1518435853.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the process of trying to track down a potential bug altering the
registered arch for a syscall rule, a simplification of struct
audit_krule that removes a seemingly unnecessary member has revealed a
surprising NULL pointer dereference.

The struct audit_field *arch_f member should not be necessary since it
is the first field present if it is present at all, and is only
necessary for syscall rules, so iterating over the fields to find it is
simple and only happens when adding or deleting a rule.  Shrinking the
struct audit_krule seemed to be a good idea, but appears to have openned
a can of worms.  The first patch triggered this OOPS:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000009
IP: audit_match_signal+0x42/0x120
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
Modules linked in: sunrpc 8139too i2c_piix4 pcspkr virtio_balloon 8139cp i2c_core mii sch_fq_codel floppy serio_raw ata_generic pata_acpi
CPU: 1 PID: 325 Comm: auditctl Not tainted 4.15.0-bz1462178-arch-changed+ #636
Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
RIP: 0010:audit_match_signal+0x42/0x120
RSP: 0018:ffffc900003dfc08 EFLAGS: 00010202
RAX: 0000000000000003 RBX: ffff880036588000 RCX: 0000000000000003
RDX: ffff88003c7f02e0 RSI: ffff88003c7f02a0 RDI: ffff880036588000
RBP: ffff88003671de00 R08: 0000000000000001 R09: 0000000000000000
R10: ffff880036a0b190 R11: 0000000000000000 R12: 0000000000000000
R13: ffff880036588178 R14: ffff880036588000 R15: ffffffff8247f880
FS:  00007fa53c6d9740(0000) GS:ffff88003e400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000009 CR3: 00000000347ba000 CR4: 00000000000006e0
Call Trace:
 audit_rule_change+0xb32/0xce0
 audit_receive_msg+0x163/0x1090
 ? netlink_deliver_tap+0x90/0x350
 ? kvm_sched_clock_read+0x5/0x10
 ? sched_clock+0x5/0x10
 audit_receive+0x4d/0xa0
 netlink_unicast+0x195/0x250
 netlink_sendmsg+0x2fe/0x3f0
 sock_sendmsg+0x32/0x60
 SYSC_sendto+0xda/0x140
 ? syscall_trace_enter+0x2dc/0x400
 ? return_from_SYSCALL_64+0x10/0x75
 do_syscall_64+0x83/0x360
 entry_SYSCALL64_slow_path+0x25/0x25
RIP: 0033:0x7fa53bbb1607
RSP: 002b:00007fff33f48c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000444 RCX: 00007fa53bbb1607
RDX: 0000000000000444 RSI: 00007fff33f48cb0 RDI: 0000000000000003
RBP: 0000000000000431 R08: 00007fff33f48c9c R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00007fff33f48cb0 R14: 00007fff33f48c9c R15: 00000000000003f3
Code: 01 00 00 83 3e 0b 0f 84 ef 00 00 00 31 c0 eb 0f 48 63 d0 48 c1 e2 05 48 01 f2 83 3a 0b 74 7d 83 c0 01 39 c8 75 ea 4d 85 c0 74 79 <41> 8b 78 08 e8 25 ff ed ff 85 c0 74 31 83 f8 01 75 58 48 8b 0d
RIP: audit_match_signal+0x42/0x120 RSP: ffffc900003dfc08
CR2: 0000000000000009

The second patch surprisingly fixes the OOPS.

Adding debug output, the OOPS is consistently happenning in the 7th STIG rule
that includes an arch parameter, but the value that causes the OOPS
dereferences, copies and prints out fine:
-a always,exit -F arch=b32 -S adjtimex,settimeofday,stime -F key=time-change
ams_: i=0 f=00000000e5612893 type=11 op=0 val=40000003 key="time-change"
-a always,exit -F arch=b64 -S adjtimex,settimeofday -F key=time-change
ams_: i=0 f=00000000cf222aca type=11 op=0 val=c000003e key="time-change"
-a always,exit -F arch=b32 -S clock_settime -F a0=0x0 -F key=time-change
ams_: i=0 f=00000000ad39bfc6 type=11 op=0 val=40000003 key="time-change"
-a always,exit -F arch=b64 -S clock_settime -F a0=0x0 -F key=time-change
ams_: i=0 f=00000000c9f83209 type=11 op=0 val=c000003e key="time-change"
-a always,exit -F arch=b32 -S sethostname,setdomainname -F key=system-locale
ams_: i=0 f=000000005a19d216 type=11 op=0 val=40000003 key="system-locale"
-a always,exit -F arch=b64 -S sethostname,setdomainname -F key=system-locale
ams_: i=0 f=000000003280e47a type=11 op=0 val=c000003e key="system-locale"
OOPS
-a always,exit -F arch=b32 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=4294967295 -F key=perm_mod
ams_: i=0 f=000000008368170a type=11 op=0 val=40000003 key="perm_mod"

I'd let sleeping dogs lie, but I haven't tracked down the source of the
original rule that changes arch between addition and listing (nor reproduced it
yet since I don't have access to that HW arch), and it seems to reveal
potentially another bug.

Help!  Any observations or hints?

Richard Guy Briggs (3):
  audit: remove arch_f pointer from struct audit_krule
  fixup! audit: remove arch_f pointer from struct audit_krule
  debug! audit: remove arch_f pointer from struct audit_krule

 include/linux/audit.h |  1 -
 kernel/auditfilter.c  | 18 +++++++++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

-- 
1.8.3.1
