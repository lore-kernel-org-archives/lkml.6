Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752164AbeCCQcm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 11:32:42 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:38575 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbeCCQck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 11:32:40 -0500
X-Google-Smtp-Source: AG47ELvJqIXBLK9IAOjfZv8wtkq/YcXiKNfB56WpkAia6wfzAkys1/AkNbuTOY5AqSyk4PqJJK+dxQ==
Date: Sat, 3 Mar 2018 08:32:36 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: Fugang Duan <fugang.duan@nxp.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: lost interrupts when running sabrelite images (v4.15+) in qemu
Message-ID: <20180303163236.GA29514@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since v4.15, I get the following runtime warning when running sabrelite images
in qemu.

irq 65: nobody cared (try booting with the "irqpoll" option)
...
handlers:
[<26292474>] fec_pps_interrupt
Disabling IRQ #65
fec 2188000.ethernet (unnamed net_device) (uninitialized): MDIO read timeout

Bisect points to commit 4ad1ceec05e491 ("net: fec: Let fec_ptp have its
own interrupt routine"). Analysis shows that platform_irq_count()
returns 2, which is reduced to 1 by fec_enet_get_irq_cnt().
If I let fec_enet_get_irq_cnt() return 2, the problem is gone.
Reverting commit 4ad1ceec05e491 also fixes the problem.

Bisect log is attached.

Guenter

----
# bad: [d8a5b80568a9cb66810e75b182018e9edb68e8ff] Linux 4.15
# good: [bebc6082da0a9f5d47a1ea2edc099bf671058bd4] Linux 4.14
git bisect start 'v4.15' 'v4.14'
# bad: [5d352e69c60e54b5f04d6e337a1d2bf0dbf3d94a] Merge tag 'media/v4.15-1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect bad 5d352e69c60e54b5f04d6e337a1d2bf0dbf3d94a
# good: [4e4510fec4af08ead21f6934c1410af1f19a8cad] Merge tag 'sound-4.15-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good 4e4510fec4af08ead21f6934c1410af1f19a8cad
# good: [9fb7bd77d11ab03b4a969279de9f54d8fd6fe988] mlxsw: spectrum_ipip: Split accessor functions
git bisect good 9fb7bd77d11ab03b4a969279de9f54d8fd6fe988
# bad: [22714a2ba4b55737cd7d5299db7aaf1fa8287354] Merge branch 'for-4.15' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup
git bisect bad 22714a2ba4b55737cd7d5299db7aaf1fa8287354
# bad: [f6b3716dcdcd1a4c3fa05ecb6ab0a1e52b6785d0] Merge branch 'net-devname_alloc_cleanups'
git bisect bad f6b3716dcdcd1a4c3fa05ecb6ab0a1e52b6785d0
# bad: [f938daeee95eb36ef6b431bf054a5cc6cdada112] net/mlx5e: CHECKSUM_COMPLETE offload for VLAN/QinQ packets
git bisect bad f938daeee95eb36ef6b431bf054a5cc6cdada112
# good: [6c49b5e26004eef86e7a47093a53be290554351c] Merge branch 'dsa-parsing-stage'
git bisect good 6c49b5e26004eef86e7a47093a53be290554351c
# bad: [ec5c91c6ca8b2d5ca6edfc968dbfeeaae4ed5572] net: dsa: lan9303: Replace msleep(1) with usleep_range()
git bisect bad ec5c91c6ca8b2d5ca6edfc968dbfeeaae4ed5572
# good: [fffcefe967a02997be7a296a4f0766b29dcd1a67] ipv6: addrconf: fix a lockdep splat
git bisect good fffcefe967a02997be7a296a4f0766b29dcd1a67
# bad: [aaf151b9e68101b03ba42d581e8a424bdd0110fe] bpf: Rename tcp_bbf.readme to tcp_bpf.readme
git bisect bad aaf151b9e68101b03ba42d581e8a424bdd0110fe
# bad: [3e29cd0e6563d5fefd59e7225750ee9922f2dad5] xdp: Sample xdp program implementing ip forward
git bisect bad 3e29cd0e6563d5fefd59e7225750ee9922f2dad5
# good: [0cf737808ae7cb25e952be619db46b9147a92f46] hv_netvsc: netvsc_teardown_gpadl() split
git bisect good 0cf737808ae7cb25e952be619db46b9147a92f46
# good: [ca1b17b7e843123f5a1e4c8bd2d7b6596ffe6e93] Merge branch 'hv_netvsc-fix-a-hang-on-channel-mtu-changes'
git bisect good ca1b17b7e843123f5a1e4c8bd2d7b6596ffe6e93
# bad: [4ad1ceec05e49175d0f967cc87628101e79176f6] net: fec: Let fec_ptp have its own interrupt routine
git bisect bad 4ad1ceec05e49175d0f967cc87628101e79176f6
# first bad commit: [4ad1ceec05e49175d0f967cc87628101e79176f6] net: fec: Let fec_ptp have its own interrupt routine
