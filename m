Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC03C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253042083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253042083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbeIFVRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:17:23 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:34916 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbeIFVRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:17:23 -0400
Received: by mail-it0-f71.google.com with SMTP id h17-v6so12963763itj.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 09:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UYPaiGvrpuBD/UQnSuVALDgXA/08768ffcehKnjDNZ4=;
        b=sDdC5TB6RKrGBeGakm8QbODJAkrRPX2vjWmlT8M0BkW/THR/wSyS8YoavtLTITA2jS
         s4kJ+HwW2HhnUmErFxqxcoajbCMCcRQ5lZEzq9Zg8OPiXKa0B9LUzk2UMi7zFtg/w2ZN
         canmgBZmcV19epkCoDST44Y/g77yzCGk+qlphurFaZbxB4A4woUAKq8M+/vIE0KDlv2x
         lQwPXHKSWgLEMz/aq17cx0P/CD5tbdQ7tgSQ37ihK5s3l8rttr4BZcFCne5OhdX3wE65
         XL3vvHDo88EGw0sj2FzcUxAMMcqhoUnAp0oSTqP1JnBHQ2IsgcBjuQ59MjvXSlW72DlB
         pb7A==
X-Gm-Message-State: APzg51C9ku2C4cH7sWvao8FtLM+KJN/ow6u7gmGGnXVZieWRBq8nQiqY
        nfKsaKeRXw1nkDnChppz3r7JTLMcqznvxhWtF6CrJc2kXjzR
X-Google-Smtp-Source: ANB0VdZdKTxu8TCvh6iJqOvpVjzAVlyc7tlfFWpIp1G3md0lQBP/0DZaT9+V4u1e9CxbACxXXIe1FgEGqwHpUR+yl3ueh7qVQX+d
MIME-Version: 1.0
X-Received: by 2002:a6b:5a19:: with SMTP id o25-v6mr2715869iob.67.1536252063862;
 Thu, 06 Sep 2018 09:41:03 -0700 (PDT)
Date:   Thu, 06 Sep 2018 09:41:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d5a360575368e31@google.com>
Subject: KASAN: use-after-free Read in _decode_session6
From:   syzbot <syzbot+e8c1d30881266e47eb33@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b36fdc6853a3 Merge tag 'gpio-v4.19-2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1556a396400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c7e83258d6e0156
dashboard link: https://syzkaller.appspot.com/bug?extid=e8c1d30881266e47eb33
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d42021400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d09f1e400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e8c1d30881266e47eb33@syzkaller.appspotmail.com

audit: type=1400 audit(1536202560.246:9): avc:  denied  { prog_run } for   
pid=4752 comm="syz-executor726"  
scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023  
tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 tclass=bpf  
permissive=1
==================================================================
BUG: KASAN: use-after-free in _decode_session6+0x1331/0x14e0  
net/ipv6/xfrm6_policy.c:161
Read of size 1 at addr ffff8801bb87e97f by task syz-executor726/4752

CPU: 0 PID: 4752 Comm: syz-executor726 Not tainted 4.19.0-rc2+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  _decode_session6+0x1331/0x14e0 net/ipv6/xfrm6_policy.c:161
  __xfrm_decode_session+0x71/0x140 net/xfrm/xfrm_policy.c:2299
  xfrm_decode_session include/net/xfrm.h:1232 [inline]
  vti6_tnl_xmit+0x3fc/0x1bb1 net/ipv6/ip6_vti.c:542
  __netdev_start_xmit include/linux/netdevice.h:4287 [inline]
  netdev_start_xmit include/linux/netdevice.h:4296 [inline]
  xmit_one net/core/dev.c:3216 [inline]
  dev_hard_start_xmit+0x272/0xc10 net/core/dev.c:3232
  __dev_queue_xmit+0x2ab2/0x3870 net/core/dev.c:3802
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3835
  __bpf_tx_skb net/core/filter.c:2012 [inline]
  __bpf_redirect_common net/core/filter.c:2050 [inline]
  __bpf_redirect+0x5b7/0xae0 net/core/filter.c:2057
  ____bpf_clone_redirect net/core/filter.c:2090 [inline]
  bpf_clone_redirect+0x2f6/0x490 net/core/filter.c:2062
  bpf_prog_c39d1ba309a769f7+0xd1e/0x1000

Allocated by task 4752:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc_node mm/slab.c:3682 [inline]
  __kmalloc_node_track_caller+0x47/0x70 mm/slab.c:3696
  __kmalloc_reserve.isra.41+0x3a/0xe0 net/core/skbuff.c:137
  pskb_expand_head+0x230/0x10e0 net/core/skbuff.c:1463
  skb_ensure_writable+0x3dd/0x640 net/core/skbuff.c:5129
  __bpf_try_make_writable net/core/filter.c:1633 [inline]
  bpf_try_make_writable net/core/filter.c:1639 [inline]
  bpf_try_make_head_writable net/core/filter.c:1647 [inline]
  ____bpf_clone_redirect net/core/filter.c:2084 [inline]
  bpf_clone_redirect+0x14a/0x490 net/core/filter.c:2062
  bpf_prog_c39d1ba309a769f7+0xd1e/0x1000

Freed by task 4752:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x210 mm/slab.c:3813
  skb_free_head+0x99/0xc0 net/core/skbuff.c:550
  skb_release_data+0x6a4/0x880 net/core/skbuff.c:570
  skb_release_all+0x4a/0x60 net/core/skbuff.c:627
  __kfree_skb net/core/skbuff.c:641 [inline]
  kfree_skb+0x19d/0x4e0 net/core/skbuff.c:659
  vti6_tnl_xmit+0x387/0x1bb1 net/ipv6/ip6_vti.c:561
  __netdev_start_xmit include/linux/netdevice.h:4287 [inline]
  netdev_start_xmit include/linux/netdevice.h:4296 [inline]
  xmit_one net/core/dev.c:3216 [inline]
  dev_hard_start_xmit+0x272/0xc10 net/core/dev.c:3232
  __dev_queue_xmit+0x2ab2/0x3870 net/core/dev.c:3802
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3835
  __bpf_tx_skb net/core/filter.c:2012 [inline]
  __bpf_redirect_common net/core/filter.c:2050 [inline]
  __bpf_redirect+0x5b7/0xae0 net/core/filter.c:2057
  ____bpf_clone_redirect net/core/filter.c:2090 [inline]
  bpf_clone_redirect+0x2f6/0x490 net/core/filter.c:2062
  bpf_prog_c39d1ba309a769f7+0xd1e/0x1000

The buggy address belongs to the object at ffff8801bb87e780
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 511 bytes inside of
  512-byte region [ffff8801bb87e780, ffff8801bb87e980)
The buggy address belongs to the page:
page:ffffea0006ee1f80 count:1 mapcount:0 mapping:ffff8801dac00940 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0006eefd48 ffffea00073f5f08 ffff8801dac00940
raw: 0000000000000000 ffff8801bb87e000 0000000100000006 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801bb87e800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801bb87e880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801bb87e900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                 ^
  ffff8801bb87e980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801bb87ea00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
