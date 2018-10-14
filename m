Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46370C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA0B20835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vaXjivOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA0B20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeJNXI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:08:58 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:38409 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeJNXI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:08:58 -0400
Received: by mail-lj1-f174.google.com with SMTP id v7-v6so15266585ljg.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 08:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9QsEnsqMa++1LYUILKvBtJUI4OyKITDef/h8Jj8wjPk=;
        b=vaXjivOGOpr1jdpDMVzxS0lvG0SGmf5b5Khc3tGRlYm/yOL0ApL+7yZ4vYM9jy43tZ
         KlhyV9T3/lRAEBXfAkUfFNFc2SG9kCc2KBSKgxdRDzJ2tOVh6m6JqdARkU7U23bSDS7r
         iLb1aboCHbF6p9oGs36WruvkxGtGkVTLvRZ6RBXv2Wdbquo6yTjP75FQSfnO1OaTUsRJ
         HZOl/RZLAPUhJfE/dJTHDpudGqLEeWDZ3D/4pRcuoMli3+ma+UtgoabGgKHvRzrcsFXE
         QLtLQq0Jld9HfVm/ZeYYoOZh5w7oii8wjikiNljXU1iZ962n3mmb31cLrrHMbO7KJlLv
         HlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9QsEnsqMa++1LYUILKvBtJUI4OyKITDef/h8Jj8wjPk=;
        b=Pw2bHZQIgXjEfABzO5fj4GT03odmZ88ygL6IlBGlx+3bg+eAYC8EDO83epzS2Msqfb
         BfAuBlQiulEkZkHCG985cJu40zt8RU+XvxTfQLXRlrUR9Xpd70lCplvoSmMQI7wNomYh
         zjIMcyQFzKmMQXneZt7fIIOzdw4IjxiESMFsPZ9083ItVOTPfjMQ9/ULdkmgML3Dj+Pw
         d24BL/jkjMatWteQXmxLbeX43OTVJzWdZQg6LpOgsuZvUidY2/X3REKIlzyufAlTnsN6
         iZEuFGcYFKBQOrJyUHQu7P7rfzTMnFEZ9OnTkvnB14g69eh8nF+IvBcwACkytSl85caz
         EDPQ==
X-Gm-Message-State: ABuFfogpXtZNTqV1mN5A/QHq6A3juwp9sLrRWlu1wdRerze7ZImev8ze
        phhWM5hRihGg61tdSYf23DK6by+hXSIK3tzHtuM=
X-Google-Smtp-Source: ACcGV62W90D1F+NvyBUTYjmqnUS8J/9Abp6A0xFzdVC1gt0h8Omn12+uzh6WtytMtTyI5BhwJREZRGvtcfO7JgYs5uA=
X-Received: by 2002:a2e:7408:: with SMTP id p8-v6mr9244565ljc.101.1539530856737;
 Sun, 14 Oct 2018 08:27:36 -0700 (PDT)
MIME-Version: 1.0
From:   Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date:   Sun, 14 Oct 2018 18:27:25 +0300
Message-ID: <CAE5jQCddXGKTYV3WuCn7GUU2upvjhONVv2QojbHdp3ej200bTw@mail.gmail.com>
Subject: Unlinking a file on a broken UDF image causes kernel BUG
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d6a258057831f529"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d6a258057831f529
Content-Type: text/plain; charset="UTF-8"

When unlinking a file on a fuzzed UDF image, the kernel BUG is triggered.

How to reproduce (with kvm-xfstests):

1) Checkout udf/for_next (commit 3df77b04f)
2) Copy x86_64-config-4.14 to .config, execute `make olddefconfig`,
then enable UDF support and compile the kernel
3) Copy the attached reproducer to
/tmp/kvm-xfstests-$USER/dump_udf.img (1 Mb uncompressed)
4) Run `kvm-xfstests shell`
5) Inside the shell:

root@kvm-xfstests:~# mount /vtmp
root@kvm-xfstests:~# mount /vtmp/dump_udf.img /mnt
[   20.324420] UDF-fs: error (device loop0): udf_process_sequence:
Primary Volume Descriptor not found!
[   20.325825] UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp
2018/06/27 18:03 (1000)
root@kvm-xfstests:~# unlink /mnt/foo
[   28.638288] ------------[ cut here ]------------
[   28.638906] kernel BUG at fs/udf/truncate.c:219!
[   28.639501] invalid opcode: 0000 [#1] SMP PTI
[   28.639946] CPU: 1 PID: 365 Comm: unlink Not tainted
4.19.0-rc2-xfstests-00028-g3df77b04f62 #1
[   28.640803] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1ubuntu1 04/01/2014
[   28.641772] RIP: 0010:udf_truncate_extents+0x2f3/0x300
[   28.642293] Code: 93 d0 fe ff ff 8d b2 d8 00 00 00 81 c2 b0 00 00
00 83 e1 08 0f 45 d6 29 d0 41 89 c6 e9 17 fe ff ff 0f 0b 0f 0b e8 6d
7d d3 ff <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 53
48 89
[   28.644136] RSP: 0018:ffff9b29408d7d80 EFLAGS: 00010206
[   28.644664] RAX: 0000000000000004 RBX: ffff943c78e8d190 RCX: 0000000000000009
[   28.645376] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff943c78e8d190
[   28.646087] RBP: ffff943c7b986000 R08: 00000009676e2d1c R09: 0000000000000001
[   28.646801] R10: 0000000000000001 R11: 0000000000000000 R12: ffff943c78e8d088
[   28.647512] R13: 0000000000000000 R14: 0000000000000002 R15: ffff943c78e8d190
[   28.648223] FS:  0000000000000000(0000) GS:ffff943c7dc00000(0063)
knlGS:00000000f7f4a800
[   28.649028] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   28.649603] CR2: 00000000f7e5ae20 CR3: 000000007822e002 CR4: 00000000003606e0
[   28.650337] Call Trace:
[   28.650589]  ? udf_setsize+0x281/0x3e0
[   28.650981]  udf_setsize+0x289/0x3e0
[   28.651349]  ? evict+0xba/0x1a0
[   28.651673]  udf_evict_inode+0x86/0xe0
[   28.652057]  evict+0xd0/0x1a0
[   28.652365]  do_unlinkat+0x1ad/0x310
[   28.652732]  do_fast_syscall_32+0x9d/0x2f0
[   28.653151]  entry_SYSENTER_compat+0x84/0x96
[   28.653603] ---[ end trace 7a5c71f2169e9e21 ]---
[   28.654073] RIP: 0010:udf_truncate_extents+0x2f3/0x300
[   28.654595] Code: 93 d0 fe ff ff 8d b2 d8 00 00 00 81 c2 b0 00 00
00 83 e1 08 0f 45 d6 29 d0 41 89 c6 e9 17 fe ff ff 0f 0b 0f 0b e8 6d
7d d3 ff <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 53
48 89
[   28.656501] RSP: 0018:ffff9b29408d7d80 EFLAGS: 00010206
[   28.657038] RAX: 0000000000000004 RBX: ffff943c78e8d190 RCX: 0000000000000009
[   28.657734] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff943c78e8d190
[   28.658456] RBP: ffff943c7b986000 R08: 00000009676e2d1c R09: 0000000000000001
[   28.659172] R10: 0000000000000001 R11: 0000000000000000 R12: ffff943c78e8d088
[   28.659895] R13: 0000000000000000 R14: 0000000000000002 R15: ffff943c78e8d190
[   28.660614] FS:  0000000000000000(0000) GS:ffff943c7dc00000(0063)
knlGS:00000000f7f4a800
[   28.661425] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   28.662006] CR2: 00000000f7e5ae20 CR3: 000000007822e002 CR4: 00000000003606e0
Segmentation fault
root@kvm-xfstests:~#

Best regards
Anatoly

--000000000000d6a258057831f529
Content-Type: application/octet-stream; name="dump_udf.img.bz2"
Content-Disposition: attachment; filename="dump_udf.img.bz2"
Content-Transfer-Encoding: base64
Content-ID: <f_jn90l62y0>
X-Attachment-Id: f_jn90l62y0

QlpoOTFBWSZTWb95AkwAAVz//////33X3f/wv++/83/v3nd4xsAhe61cKSmYyAHUe/3c0ARzwGgA
ABQamlIAADRoAAA0MIyGgDQyAAAaBggGgAAAaAaAAAZAaiU2o80mo0A00AAADQBpoAAAAADQyMIA
AAAAAAAABA0MmmhiMmmgMjQGhiaDCZGEMgMhpkGjTIZAMTEMEwmCZGmmACYCBA0MmmhiMmmgMjQG
hiaDCZGEMgMhpkGjTIZAMTEMEwmCZGmmACYCASJEITTTSYCT0npoDUwjaTRiaDJiaZGQ0DIepkNB
kPUyDQA0yGQMEzU2U8pkHoRgT+CzLLQiwCIQBgUGCAYIT6kit6cg6FSeTNxEgmU9MFBjhFhM9r+q
GIRC7BFYAQwczziqUETSwgjzgqBywUhFSQUOK4JEgyBUKRBIpYoJlVc29BU51XUoJImUhhVtHMKm
VUkIweTSSSQUtJCIYgAqYCstJJC6jBJJcdoASQLQ0QlVpS4MWhaK7bunCwcIrqiRATeRVCVgaA4b
OEw4bSCgaEryIBFLGWCAk0kmxbZwmJCSSSowMmkmJVmJUbGZLWJoITEE60hyJNDYAQ0JLwxl8zaD
BjQMaOq0Wmh0kyShgkkkkr5Mi3yOzMzgnMdTbrcjL2HrHced5NWzDYrObVVopdVxQIBh8kauJWCI
gjBGh2gxijFUyjSY+pr+LN000090TouBIsNSYhMYNMRYYPgw9ltoUhGvogQ+CQgKDzSElWGK2zZF
U1IgaY8D94mmkTGNjYNwMcMaZBARCzGbtzc4hBS4GAJJJKQwXiFqy78ZtqFetX1aBMeFbIXK4EIF
NhvmVANVhwcXwLB1HGHBDpGkwr61hA4YQSGNvgEIvTzoF19JFI0xidohBftEmxjabY0222LcM3vo
pQhYjLgf3ERXy8yUi/MYYiVl2gBnGGUsoGdgP6vCsUAWf7M/WRg5//Z/slrNAYB/oDuUmfL0NQ+B
NabVLRl4cYVFgvzEKdVEJlC9rpe97E0FwAw4nBhS/DT40wLHXSp084yduSSpOElNKRzeyZpcBtsj
kZ+6oXEa6HKy7c7URl7GD3aN0Bnf5nTAzBrOOSG+W1EdEghZgK+EMVSS1ADWKG1+qWOmBzBm9YZT
pS5gYpbOcekZZ1jVheHTX5GUlyzAMgIVyeoQaQ0BhF8ZBptPqQP1Obhl0YRn2TqoW8LnNmXqFLAJ
fwkKrpPHETGgMYFHJ7VguxM54lZS6Q0VHRMuFLfEG9KlHETNxaBUI6yy0KFShUmwEWlXGJGWTy1g
tQrOZuZF03b3/HMdToOUaY5+vnrt3WEbApr0muEa8OmIsgawRTT1jWiLsRKgM4vL4JBdbMpzaTKM
5FcRY0QJUlR4IXpoVeCxAaFnGOIoVsEtAUcEQwZnIUrsI9+5L0tIVBWmlFoRy65ejGSMARhiMTAW
5t3ZXC4K1BZZvwvy7LAJdyCVNp+VvIytoRI8iDB0sdBi7TOu9y+weNEudGCCHT9A6VuDtwX4uABw
vFEcg0/ggDua0gztJOACALnDs1vhCMNitgM7LFZY+L27Pf/tk1EpSlRUQzgELMYgSSSV3co2bpfm
NLJaMFnbq1eLiXH/i7kinChIX7yBJgA=
--000000000000d6a258057831f529--
