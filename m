Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932381AbeEHJhc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 05:37:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58015 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932190AbeEHJha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 05:37:30 -0400
Date: Tue, 8 May 2018 06:37:24 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To: linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Problem with global pages changeset and kvm
Message-ID: <20180508093723.GA4529@calabresa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running a 4.15 kernel on top of 4.17-rc3, I noticed a problem on the guest:

[    4.836637] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[    4.839290] IP: 0xffffffff8a00147e
[    4.840300] PGD 0 P4D 0
[    4.840510] Oops: 0000 [#1] SMP PTI
[    4.840510] Modules linked in: psmouse e1000 i2c_piix4 pata_acpi floppy
[    4.840510] CPU: 0 PID: 177 Comm: exe Not tainted 4.15.0-20-generic #21-Ubuntu
[    4.840510] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
[    4.840510] RIP: 0010:0xffffffff8a00147e
[    4.840510] RSP: 0018:ffff9ea680413ee0 EFLAGS: 00010246
[    4.840510] RAX: 0000000000000000 RBX: ffff9ea680413f58 RCX: 0000000000000000
[    4.840510] RDX: 0000000000000000 RSI: ffff9ea680413f58 RDI: 00000000000000e7
[    4.840510] RBP: ffff9ea680413f48 R08: 0000000000000000 R09: 0000000000000000
[    4.840510] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000000e7
[    4.840510] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    4.840510] FS:  00007f42a6ea7580(0000) GS:ffff91513c800000(0000) knlGS:0000000000000000
[    4.840510] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.840510] CR2: ffffffff8a00147e CR3: 000000003f84e000 CR4: 00000000000006f0
[    4.840510] Call Trace:
[    4.840510]  ? SyS_nanosleep+0x72/0xa0
[    4.840510] Code:  Bad RIP value.
[    4.840510] RIP: 0xffffffff8a00147e RSP: ffff9ea680413ee0
[    4.840510] CR2: 0000000000000000
[    4.898894] ---[ end trace f77f825085f5973c ]---


After a bisection and a little investigation, I realized:

1) The first commit where it happens is
0f561fce4d6979a50415616896512f87a6d1d5c8 ("x86/pti: Enable global pages for
shared areas"). Though reverting it on top of 4.17-rc3 will cause other
problems.

2) The bad address is next to do_syscall_64 on the host.

3) I have a non-PCID host, likely:
model name      : Intel(R) Core(TM)2 CPU         P8600  @ 2.40GHz
00:00.0 Host bridge: Intel Corporation Mobile 4 Series Chipset Memory Controller Hub (rev 07)

4) On the host, I also see:
[48162.554505] ------------[ cut here ]------------
[48162.554512] Bad FPU state detected at __switch_to+0x1d7/0x3a0, reinitializing FPU registers.
[48162.554518] WARNING: CPU: 1 PID: 0 at arch/x86/mm/extable.c:104 ex_handler_fprestore+0x60/0x70
[48162.554519] Modules linked in: ccm iptable_filter arc4 binfmt_misc ip6table_filter ip6_tables kvm_intel kvm irqbypass input_leds ath5k mac80211 ath cfg80211 thinkpad_acpi hwmon nvram battery ac acpi_cpufreq ip_tables x_tables dm_crypt psmouse ahci libahci i915 e1000e video intel_gtt i2c_algo_bit drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fops cfbcopyarea drm drm_panel_orientation_quirks
[48162.554551] CPU: 1 PID: 0 Comm: swapper/1 Kdump: loaded Not tainted 4.17.0-rc2-00003-ga44ca8f5a30c #17
[48162.554552] Hardware name: LENOVO 7458CJ3/7458CJ3, BIOS CBET4000 3774c98 09/07/2016
[48162.554555] RIP: 0010:ex_handler_fprestore+0x60/0x70
[48162.554556] RSP: 0018:ffffa5f88186b818 EFLAGS: 00010086
[48162.554558] RAX: 0000000000000000 RBX: ffffa5f88186b878 RCX: ffffffff8ae226b8
[48162.554559] RDX: 0000000000000001 RSI: 0000000000000086 RDI: ffffffff8af8a64c
[48162.554560] RBP: ffffa5f88186b818 R08: 000000000000025e R09: ffffffff8af8caa0
[48162.554561] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000d
[48162.554562] R13: ffff960266cf0b80 R14: 0000000000000000 R15: 0000000000000000
[48162.554564] FS:  00007f304bd72580(0000) GS:ffff96026fd00000(0000) knlGS:0000000000000000
[48162.554565] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[48162.554567] CR2: 00007f3ae3f5c00c CR3: 0000000168482000 CR4: 00000000000426a0
[48162.554567] Call Trace:
[48162.554569] Code: 01 00 00 00 5d c3 48 0f ae 0d cd 49 e4 00 b8 01 00 00 00 5d c3 48 89 c6 48 c7 c7 00 ba b9 8a c6 05 ba b8 e2 00 01 e8 20 bf 00 00 <0f> 0b eb b9 66 90 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 e8
[48162.554605] ---[ end trace 0107e9bc595237bb ]---

5) When disabling pti on the guest, the failure goes away. It also happens with
a 4.16, or 4.17-rc2 kernel, so not specific to the 4.15 Ubuntu kernel on the guest.

Let me know how I can help investigate this further, or test fixes for this.

Cascardo.
