Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA62C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047FF20861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v6yF+XOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047FF20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeIFLoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 07:44:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbeIFLoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 07:44:46 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D2B8206BA;
        Thu,  6 Sep 2018 07:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536217844;
        bh=rudEKqgtzdhUw82uZHfZpkn/VQReOmkZGopguZM+nqk=;
        h=From:Date:Subject:To:From;
        b=v6yF+XOKpui4LoDTTs3DVGyW+Rj32HJir7DXoTJF+MUGwbEY2dCGUxsNZgSksyn3m
         hF3jMbdd4m8f4iG+6Uk9gYwyUXU2F5RKOkJbAGe0jTeonlnTB6hrf20VdMoOpclG0K
         l7frizRa6iyxuhunpBkvpvY1p0vsu62RDxjEREsc=
Received: by mail-wr1-f52.google.com with SMTP id u12-v6so10124803wrr.4;
        Thu, 06 Sep 2018 00:10:44 -0700 (PDT)
X-Gm-Message-State: APzg51C7ceo5i2p1+6Oy6eczmHd0IiEvWlmYnDPUlS30Os9T0d50e7bO
        hF+REQtxkWZLGl0dnRpsxDpMyrC+vXoQu4aS5cQ=
X-Google-Smtp-Source: ANB0Vda+WT8AsT7oGo3O1DjRMhPueMV9seLo53WdLGZ9BwvczF1NZg3tyED1Os3m/tvxeDQSlmUeq0vzi/eP6u/d2qA=
X-Received: by 2002:adf:b726:: with SMTP id l38-v6mr1008443wre.115.1536217842701;
 Thu, 06 Sep 2018 00:10:42 -0700 (PDT)
MIME-Version: 1.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 6 Sep 2018 09:10:31 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc49jh8RCDvn2Meci9iDcnnwGEHo6F7RuhkXpen=f_E8w@mail.gmail.com>
Message-ID: <CAJKOXPc49jh8RCDvn2Meci9iDcnnwGEHo6F7RuhkXpen=f_E8w@mail.gmail.com>
Subject: [BUG BISECT] NFS root failure (NULL pointer)
To:     David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Today's next fails to mount NFS root under my ARM targets and fails to
mount root from file image under QMU.

[ 21.512866] Unable to handle kernel NULL pointer dereference at
virtual address 00000000
[ 21.695484] [<c03bcc04>] (nfs_fs_mount) from [<c02cf6a4>]
(legacy_get_tree+0x34/0xec)
[ 21.703225] [<c02cf6a4>] (legacy_get_tree) from [<c029442c>]
(vfs_get_tree+0x64/0x180)
[ 21.711119] [<c029442c>] (vfs_get_tree) from [<c02b9140>]
(do_mount+0x21c/0x958)
[ 21.718478] [<c02b9140>] (do_mount) from [<c02b9c38>] (ksys_mount+0x8c/0xbc)
[ 21.725513] [<c02b9c38>] (ksys_mount) from [<c0101000>]
(ret_fast_syscall+0x0/0x28)

Full log from ARM (NFS root):
https://krzk.eu/#/builders/25/builds/750/steps/12/logs/serial0

The NFS root failure bisected to:
bae551929c5433bd56ec4dcb97c7d4a50153d357 is the first bad commit
commit bae551929c5433bd56ec4dcb97c7d4a50153d357
Author: David Howells <dhowells@redhat.com>
Date:   Tue Jul 10 21:43:37 2018 +0100

    vfs: Separate changing mount flags full remount

    Separate just the changing of mount flags (MS_REMOUNT|MS_BIND) from full
    remount because the mount data will get parsed with the new fs_context
    stuff prior to doing a remount - and this causes the syscall to fail under
    some circumstances.

The QEMU issue seems slightly different and I did not bisect it. The
QEMU just cannot find rootfs:
[    1.008052] Filesystem requires source device
[    1.008513] VFS: Cannot open root device "mmcblk0" or
unknown-block(179,0): error -2
[    1.008790] Please append a correct "root=" boot option; here are
the available partitions:
[    1.009300] 0100           16384 ram0
[    1.009337]  (driver?)
[    1.009806] fe00            5120 vda
[    1.009843]  driver: virtio_blk
[    1.010296] b300          110592 mmcblk0
[    1.010319]  driver: mmcblk
[    1.010859] Kernel panic - not syncing: VFS: Unable to mount root
fs on unknown-block(179,0)
[    1.011580] ---[ end Kernel panic - not syncing: VFS: Unable to
mount root fs on unknown-block(179,0) ]---



Boards config:
1. Arch ARM Linux
2. exynos_defconfig
  - Odroid HC1
    ARMv7, octa-core (Cortex-A7+A15), Exynos5422 SoC
    Systemd: v239
  - Odroid U3
    ARMv7, quad-core, Exynos4412 SoC
    Systemd: v238
  - Odroid XU
    ARMv7, octa-core (Cortex-A7+A15) but only A15 working, Exynos5410 SoC
    Systemd: v236
  - Odroid XU3
    ARMv7, octa-core (Cortex-A7+A15), Exynos5422 SoC
    Systemd: v236
3. Custom VF50 defconfig
  - Toradex Colibri VF50 on Iris board
    ARMv7, UP, Cortext-A5, NXP VF500
    Systemd: v232
4. All boards boot from TFTP with NFS root (NFSv4)
5. QEMU
    ARMv7, vexpress-v2p-ca9, 128 MB RAM



Best regards,
Krzysztof
