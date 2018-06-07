Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /5mhJK8tGVtwJAAAmS7hNA
	; Thu, 07 Jun 2018 13:07:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 568906089E; Thu,  7 Jun 2018 13:07:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=2.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEXHASH_WORD,MAILING_LIST_MULTI,SORTED_RECIPS autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8800E601C3;
	Thu,  7 Jun 2018 13:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8800E601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753664AbeFGNHW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:07:22 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:35194 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753327AbeFGNHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:07:03 -0400
Received: by mail-it0-f72.google.com with SMTP id k18-v6so3506333itb.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 06:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=B6AbsOZF5fKnooCsCC3p7ea1kEZvuvVF1bQvVqAF5ik=;
        b=sAjvoXlkTl7EXhGx4rsrRqgNgtDquQz3HT09yL0GeH+GEqYLSh+wHe+218k8CZpvlm
         Tf9eq4GjHx+jMYSs2nHCV84Rbxh4xhT57tmn95YaLb4amTT969bTZM+1MUoBxLaLGQtV
         bpyJW6O5D/iQqdLwlRZsmdNvnKOjLtqFeNtLciQ4ofY32pxQvQX9Ji6ic8SAgBmeoJxN
         iT5TGEPeFUcKZEK1qGlwFPHDRkthrXvUIlIqUcDEGOGvbSMvJJ5NUGN0TO6NSft5lQaa
         PjLuH/1maGok5zbRoytc7tesMTqcvDlrPboxOqqjKEohWGGgAmobKQ8+r2I0GMcqRdGl
         g6Pg==
X-Gm-Message-State: APt69E2tW+Q63FTgkIRQtAXC+a02Yt+uL75pxUEu1026lA0/NIzNmlM+
        veW4/x17YtXfzKcpqN2PMevc8Pq4ShzjvJMRFZkBNJ+n2myY
X-Google-Smtp-Source: ADUXVKKx7rxFKFLE2/n1iOROTmz7ZjNQmyhd64mtxxRc0MK2VnyZ8zoxglAlAOzpqdyPsB8VMDoG2LgngcY37pH63hscFQKVfWY6
MIME-Version: 1.0
X-Received: by 2002:a24:190b:: with SMTP id b11-v6mr1038523itb.36.1528376822863;
 Thu, 07 Jun 2018 06:07:02 -0700 (PDT)
Date: Thu, 07 Jun 2018 06:07:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c221d056e0cf53a@google.com>
Subject: KASAN: slab-out-of-bounds Write in sha1_finup
From: syzbot <syzbot+486f97f892efeb2075a3@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au, hpa@zytor.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1c8c5a9d38f6 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16289b9f800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e1a31e8576e013a
dashboard link: https://syzkaller.appspot.com/bug?extid=486f97f892efeb2075a3
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=122bb5df800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+486f97f892efeb2075a3@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KASAN: slab-out-of-bounds in put_unaligned_be32  
include/linux/unaligned/access_ok.h:60 [inline]
BUG: KASAN: slab-out-of-bounds in sha1_base_finish  
include/crypto/sha1_base.h:102 [inline]
BUG: KASAN: slab-out-of-bounds in sha1_finup+0x44e/0x4b0  
arch/x86/crypto/sha1_ssse3_glue.c:70
Write of size 4 at addr ffff8801d7130ed8 by task syz-executor0/4761

CPU: 0 PID: 4761 Comm: syz-executor0 Not tainted 4.17.0+ #113
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_store4_noabort+0x17/0x20 mm/kasan/report.c:437
  put_unaligned_be32 include/linux/unaligned/access_ok.h:60 [inline]
  sha1_base_finish include/crypto/sha1_base.h:102 [inline]
  sha1_finup+0x44e/0x4b0 arch/x86/crypto/sha1_ssse3_glue.c:70
  sha1_avx2_finup arch/x86/crypto/sha1_ssse3_glue.c:232 [inline]
  sha1_avx2_final+0x28/0x30 arch/x86/crypto/sha1_ssse3_glue.c:238
  crypto_shash_final+0x104/0x260 crypto/shash.c:152
  kdf_ctr security/keys/dh.c:186 [inline]
  keyctl_dh_compute_kdf security/keys/dh.c:217 [inline]
  __keyctl_dh_compute+0x1184/0x1bc0 security/keys/dh.c:389
  compat_keyctl_dh_compute+0x2c8/0x3e0 security/keys/compat_dh.c:39
  __do_compat_sys_keyctl security/keys/compat.c:136 [inline]
  __se_compat_sys_keyctl security/keys/compat.c:59 [inline]
  __ia32_compat_sys_keyctl+0x137/0x3b0 security/keys/compat.c:59
  do_syscall_32_irqs_on arch/x86/entry/common.c:323 [inline]
  do_fast_syscall_32+0x345/0xf9b arch/x86/entry/common.c:394
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7fbdcb9
Code: 55 08 8b 88 64 cd ff ff 8b 98 68 cd ff ff 89 c8 85 d2 74 02 89 0a 5b  
5d c3 8b 04 24 c3 8b 1c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000ffdb494c EFLAGS: 00000286 ORIG_RAX: 0000000000000120
RAX: ffffffffffffffda RBX: 0000000000000017 RCX: 0000000020000100
RDX: 0000000020a53ffb RSI: 0000000000000005 RDI: 0000000020c61fc8
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 4761:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc mm/slab.c:3718 [inline]
  __kmalloc+0x14e/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:518 [inline]
  keyctl_dh_compute_kdf security/keys/dh.c:211 [inline]
  __keyctl_dh_compute+0xfe9/0x1bc0 security/keys/dh.c:389
  compat_keyctl_dh_compute+0x2c8/0x3e0 security/keys/compat_dh.c:39
  __do_compat_sys_keyctl security/keys/compat.c:136 [inline]
  __se_compat_sys_keyctl security/keys/compat.c:59 [inline]
  __ia32_compat_sys_keyctl+0x137/0x3b0 security/keys/compat.c:59
  do_syscall_32_irqs_on arch/x86/entry/common.c:323 [inline]
  do_fast_syscall_32+0x345/0xf9b arch/x86/entry/common.c:394
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

Freed by task 1:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  acpi_os_free include/acpi/platform/aclinuxex.h:62 [inline]
  acpi_ns_get_node_unlocked+0x2b1/0x2ee drivers/acpi/acpica/nsutils.c:698
  acpi_ns_get_node+0x4d/0x6b drivers/acpi/acpica/nsutils.c:738
  acpi_get_handle+0x153/0x24b drivers/acpi/acpica/nsxfname.c:98
  acpi_has_method+0x68/0xa0 drivers/acpi/utils.c:555
  acpi_device_setup_files+0x393/0x820 drivers/acpi/device_sysfs.c:565
  acpi_device_add+0x8af/0x1240 drivers/acpi/scan.c:700
  acpi_add_single_object+0xaa5/0x1e70 drivers/acpi/scan.c:1620
  acpi_bus_check_add+0x5fa/0xb40 drivers/acpi/scan.c:1860
  acpi_ns_walk_namespace+0x224/0x400 drivers/acpi/acpica/nswalk.c:237
  acpi_walk_namespace+0xf2/0x12c drivers/acpi/acpica/nsxfeval.c:606
  acpi_bus_scan+0x138/0x160 drivers/acpi/scan.c:2041
  acpi_scan_init+0x404/0x8df drivers/acpi/scan.c:2198
  acpi_init+0x936/0x9fa drivers/acpi/bus.c:1284
  do_one_initcall+0x127/0x913 init/main.c:884
  do_initcall_level init/main.c:952 [inline]
  do_initcalls init/main.c:960 [inline]
  do_basic_setup init/main.c:978 [inline]
  kernel_init_freeable+0x49b/0x58e init/main.c:1135
  kernel_init+0x11/0x1b3 init/main.c:1061
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

The buggy address belongs to the object at ffff8801d7130ec0
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 24 bytes inside of
  32-byte region [ffff8801d7130ec0, ffff8801d7130ee0)
The buggy address belongs to the page:
page:ffffea00075c4c00 count:1 mapcount:0 mapping:ffff8801d7130000  
index:0xffff8801d7130fc1
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801d7130000 ffff8801d7130fc1 0000000100000036
raw: ffffea00076061e0 ffffea0007633a60 ffff8801da8001c0 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d7130d80: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8801d7130e00: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
> ffff8801d7130e80: fb fb fb fb fc fc fc fc 00 00 00 fc fc fc fc fc
                                                     ^
  ffff8801d7130f00: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8801d7130f80: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
