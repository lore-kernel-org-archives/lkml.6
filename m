Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E3EC282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 00:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD60218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 00:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q12ZbKAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfAYAXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 19:23:55 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41092 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfAYAXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 19:23:55 -0500
Received: by mail-io1-f66.google.com with SMTP id s22so6364810ioc.8;
        Thu, 24 Jan 2019 16:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=73k+BWFaW/DZeQ0Dj/QD13DUf5RT0juCc27+LwxACCQ=;
        b=Q12ZbKAcyj3MAUsORbaUAC3NfaIHFwTNrZA7VznT5HWutq573tH/zpX1KeDIYYZUqo
         ooQHUF2R1KMBefTz52N8iyp2rASSNdDpOnd6lNGleU0hGweIuaAdjG7BtD6M2sZDCSfh
         La5YJUs0WTDTz3VWT+RB9yl/2xgwMDVt0Lx3bFDUYo6FSsFhAoy7za63n1rqHIS6R89O
         pBCzraqVWfPXzbK0MFASYZJh5fjRMotal8+gxmgjz7zmM7pcvRMZq1qeXVOrd6WWTIKl
         8M5CVsx6BZap7mDJREj28sx5i2zmrwA5b12sunlWWhWyV3Grl8Tm2QjHjVrcUunJqWuY
         C63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=73k+BWFaW/DZeQ0Dj/QD13DUf5RT0juCc27+LwxACCQ=;
        b=WoAryGGC373Z9y+cn53RlBSdv/tNci6iaa5vnyhh2wqyFCsvspQ1yN0byNf9HiIvdf
         OyTMYs8JZtDipiJ0vJ3kWoVWIe+4BwYgbBfIWCtCzAx6PceW0dNIHLiyXjPOvNcv5wI8
         YmMUNt8UsaOIDaYya/TIQ2Ukg425r/QCkGu2HtdHEm0A/Ke0+ZzL8GhFjUh9V5Hdui1+
         R/TMRd1buXSYQNoFI2Rq1EZXmqBNrpdWfbTAnL3RZsrdRQP6XBbwmCueEr9KemkzUiL8
         lwJzgEvXvZLDOeW98gEI+WM9BH3BRHSSoh7NDfQ4ostKOaTXZRf9as+50QNXr8ZfO9dx
         05wg==
X-Gm-Message-State: AHQUAub4b2MCAvzsX60a7W3OiCKANYTnmGIojwll9QlcveSu/Q7ryEYV
        e3rxVSzJIWCrOxm6Bx0UZCzZwS6qBLTbdBR2rSo=
X-Google-Smtp-Source: AHgI3IaQ0nvqKm6IPBiRpHv2MfeCQRFvZrtpztWChAdkSh5Clb1VvVSZTNXbal3UeckSBU7aNrQx3//VyTjgNHW2TGg=
X-Received: by 2002:a6b:6111:: with SMTP id v17mr5773753iob.107.1548375833931;
 Thu, 24 Jan 2019 16:23:53 -0800 (PST)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Thu, 24 Jan 2019 19:23:43 -0500
Message-ID: <CAEAjamuFYNYTn8eqNZg-VU9A2=hrHxarhoFz+JEMmx0yVm40LQ@mail.gmail.com>
Subject: UBSAN: Undefined behaviour in drivers/scsi/sr_ioctl.c
To:     Jens Axboe <axboe@kernel.dk>, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm reporting a bug in linux-5.0-rc2: "UBSAN: Undefined behaviour in
drivers/scsi/sr_ioctl.c"

kernel config: https://kt0755.github.io/etc/config-5.0-rc2
repro: https://kt0755.github.io/etc/repro.01311.c (need to provide cdrom image)

Integer overflow arose in sr_select_speed() when "speed *= 177"
is larger than the size of the type "int".
A sanity check right before it would help.

=========================================
UBSAN: Undefined behaviour in drivers/scsi/sr_ioctl.c:424:9
signed integer overflow:
-2147483648 * 177 cannot be represented in type 'int'
CPU: 0 PID: 22452 Comm: syz-executor4 Not tainted 5.0.0-rc2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xb1/0x118 lib/dump_stack.c:113
 ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
 handle_overflow+0x1cf/0x21a lib/ubsan.c:190
 __ubsan_handle_mul_overflow+0x2a/0x35 lib/ubsan.c:214
 sr_select_speed+0x179/0x1a0 drivers/scsi/sr_ioctl.c:424
 cdrom_ioctl_select_speed drivers/cdrom/cdrom.c:2435 [inline]
 cdrom_ioctl+0x850/0x2ffa drivers/cdrom/cdrom.c:3347
 sr_block_ioctl+0x129/0x180 drivers/scsi/sr.c:587
 __blkdev_driver_ioctl block/ioctl.c:303 [inline]
 blkdev_ioctl+0x1378/0x1b50 block/ioctl.c:605
 block_ioctl+0x105/0x150 fs/block_dev.c:1906
 vfs_ioctl fs/ioctl.c:46 [inline]
 do_vfs_ioctl+0x1aa/0x1160 fs/ioctl.c:698
 ksys_ioctl+0x9e/0xb0 fs/ioctl.c:713
 __do_sys_ioctl fs/ioctl.c:720 [inline]
 __se_sys_ioctl fs/ioctl.c:718 [inline]
 __x64_sys_ioctl+0x7e/0xc0 fs/ioctl.c:718
 do_syscall_64+0xbe/0x4f0 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4a70139c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4a7013a6cc RCX: 00000000004497b9
RDX: 0000000080000000 RSI: 0000000000005322 RDI: 0000000000000013
RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000002dd8 R14: 00000000006ebe78 R15: 00007f4a7013a700
=========================================

Thanks,
Kyungtae Kim
