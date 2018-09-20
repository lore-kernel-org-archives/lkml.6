Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFC4ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E1021546
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E1021546
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388470AbeIUCt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:49:29 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:47612 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeIUCt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:49:29 -0400
Received: by mail-io1-f72.google.com with SMTP id v20-v6so14873136iom.14
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 14:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2GP7Tp9j2UZ5Hsnu6bXiwIEe5pCm+ZucjWdOLtdEy8A=;
        b=At2KMryXj7iFQoLsIjwAdqRTnTV9/e/3qXNY24z7p/Tp4hPKnK/LFcQG3+3ebX/Tgr
         wefmmhlTW91JQKQ3EZDwN9dVnY3GMsaBM4ONDmr9dkme8NU05YBgZK0jCwabvGEsw8MG
         N0Tu4N6kQYwD4Xl7718BniMPgLhbDeBybCkkAtItXA6WDQfpfp46g7VB6cftYs7fr89P
         tgan7jWX4gQa98JAaNxzdgOvB9L8I2HXNGgtBTizi656sAUaCilAJdIJSENloI0UKDVV
         71OeEcgmA3ElnarhfOrQ1Tb/1jAMdfZ1P2G3EtdYNtNrAMpXbGVZHI+FiJqL9bdVSiPZ
         pTPA==
X-Gm-Message-State: ABuFfog2ZDnBg5SEjKgHhY30gogDaSBoGOVSxrwUEYKI9Hehb71w4+Q0
        HN5YBHAvvVpbLxkygpPF3LbQ/uST8ZUWHh0WC3KdQCRjd8eS
X-Google-Smtp-Source: ACcGV60quZt2ZhKnKp+EcL7cvkzjDeEr+yBOBfHiX1oD3ZcMYxbTOtHv6SLgotWqRikkJ3RTiY9Qt7IWCLPAgDGsZBJl2SEZaSBy
MIME-Version: 1.0
X-Received: by 2002:a6b:d548:: with SMTP id x8-v6mr3556740ioc.108.1537477444653;
 Thu, 20 Sep 2018 14:04:04 -0700 (PDT)
Date:   Thu, 20 Sep 2018 14:04:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0575a057653dc12@google.com>
Subject: KMSAN: uninit-value in synaptics_detect
From:   syzbot <syzbot+13cb3b01d0784e4ffc3f@syzkaller.appspotmail.com>
To:     aaron.ma@canonical.com, aduggan@synaptics.com,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        kt.liao@emc.com.tw, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter.hutterer@who-t.net,
        rydberg@bitmath.org, syzkaller-bugs@googlegroups.com,
        zhenjie.wang@sjtu.edu.cn
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    42a037ca8d9d kmsan: update README.md to reference LLVM r34..
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=1392c149400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3431f03869413153
dashboard link: https://syzkaller.appspot.com/bug?extid=13cb3b01d0784e4ffc3f
compiler:       clang version 8.0.0 (trunk 339414)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14616421400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a164d1400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+13cb3b01d0784e4ffc3f@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
psmouse serio2: Failed to reset mouse on : -5
misc userio: Buffer overflowed, userio client isn't keeping up
==================================================================
BUG: KMSAN: uninit-value in synaptics_detect+0x1fa/0x2a0  
drivers/input/mouse/synaptics.c:112
CPU: 1 PID: 41 Comm: kworker/1:2 Not tainted 4.19.0-rc1+ #42
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events_long serio_handle_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x14b/0x190 lib/dump_stack.c:113
  kmsan_report+0x183/0x2b0 mm/kmsan/kmsan.c:956
  __msan_warning+0x70/0xc0 mm/kmsan/kmsan_instr.c:645
  synaptics_detect+0x1fa/0x2a0 drivers/input/mouse/synaptics.c:112
  psmouse_do_detect drivers/input/mouse/psmouse-base.c:1011 [inline]
  psmouse_extensions+0x10fd/0x3820 drivers/input/mouse/psmouse-base.c:1106
  psmouse_switch_protocol+0x184/0xd90 drivers/input/mouse/psmouse-base.c:1544
  psmouse_connect+0x1387/0x2290 drivers/input/mouse/psmouse-base.c:1634
  serio_connect_driver drivers/input/serio/serio.c:59 [inline]
  serio_driver_probe+0xe3/0x150 drivers/input/serio/serio.c:790
  really_probe+0x19ae/0x2040 drivers/base/dd.c:500
  driver_probe_device+0x1b4/0x4f0 drivers/base/dd.c:662
  __device_attach_driver+0x632/0x750 drivers/base/dd.c:758
  bus_for_each_drv+0x27e/0x390 drivers/base/bus.c:461
  __device_attach+0x381/0x5e0 drivers/base/dd.c:815
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:862
  bus_probe_device+0x137/0x390 drivers/base/bus.c:521
  device_add+0x2687/0x2c70 drivers/base/core.c:1927
  serio_add_port drivers/input/serio/serio.c:554 [inline]
  serio_handle_event+0x1d90/0x2700 drivers/input/serio/serio.c:222
  process_one_work+0x1605/0x1f40 kernel/workqueue.c:2153
  worker_thread+0x11a2/0x2590 kernel/workqueue.c:2296
  kthread+0x465/0x4a0 kernel/kthread.c:247
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:416

Local variable description: ----param@synaptics_detect
Variable was created at:
  synaptics_detect+0x50/0x2a0 drivers/input/mouse/synaptics.c:100
  psmouse_do_detect drivers/input/mouse/psmouse-base.c:1011 [inline]
  psmouse_extensions+0x10fd/0x3820 drivers/input/mouse/psmouse-base.c:1106
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
