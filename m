Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AEDC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D1520815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfACVp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:45:56 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:44681 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727243AbfACVp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 16:45:56 -0500
Received: from [10.0.99.136] (unknown [62.214.191.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A97B120135342D;
        Thu,  3 Jan 2019 22:45:19 +0100 (CET)
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: General protection fault in `switch_mm_irqs_off()`
Message-ID: <784ab00e-ed72-c1bc-bc0c-31264deb7726@molgen.mpg.de>
Date:   Thu, 3 Jan 2019 22:45:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------977E1A8B6201E06D1B9C18A4"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------977E1A8B6201E06D1B9C18A4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Linux folks,


On the server board Asus KGPE-D16 with AMD Opteron 6278 processor 
updating the microcode update in the firmware from 0x0600062e to 
0x0600063e seems to cause a general protection fault with Linux 4.14.87 
and 4.20-rc7.

> 46.859: [    7.573240] microcode: CPU31: patch_level=0x0600063e
> 46.859: [    7.578507] microcode: Microcode Update Driver: v2.2.
> 46.860: [    7.578539] sched_clock: Marking stable (6510054745, 1068444659)->(7999876773, -421377369)
> 46.860: [    7.593013] registered taskstats version 1
> 46.861: [    7.598091] rtc_cmos 00:00: setting system clock to 2000-01-01 08:01:51 UTC (946713711)
> 46.862: [    7.606575] ALSA device list:
> 46.862: [    7.609802]   No soundcards found.
> 46.865: [    7.615887] Freeing unused kernel image memory: 1564K
> 46.871: [    7.627073] Write protecting the kernel read-only data: 20480k
> 46.872: [    7.634366] Freeing unused kernel image memory: 2016K
> 46.873: [    7.640297] Freeing unused kernel image memory: 584K
> 46.874: [    7.645521] Run /init as init process
> 46.877: [    7.652262] general protection fault: 0000 [#1] SMP NOPTI
> 46.877: [    7.657931] CPU: 18 PID: 0 Comm: swapper/18 Not tainted 4.20.0-rc7.mx64.237 #1
> 46.877: [    7.665514] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-103-g637bef2037 01/02/2019
> 46.878: [    7.673804] RIP: 0010:switch_mm_irqs_off+0xb2/0x640
> 46.878: [    7.678948] Code: 48 c1 ef 09 83 e7 01 48 09 c7 65 48 8b 05 8e 34 fc 7e 48 39 c7 74 15 48 09 f8 a8 01 74 0e b9 49 00 00 00 b8 01 00 00 00 31 d2 <0f> 30 65 48 89 3d 6c 34 fc 7e 8b 05 9a ef a7 01 85 c0 0f 8f 41 04
> 46.879: [    7.698394] RSP: 0018:ffffc90006343e20 EFLAGS: 00010046
> 46.879: [    7.703844] RAX: 0000000000000001 RBX: ffff88981ca0b800 RCX: 0000000000000049
> 46.879: [    7.711238] RDX: 0000000000000000 RSI: ffff88981b87cf80 RDI: ffff88981ca0b800
> 46.880: [    7.718665] RBP: ffffc90006343e70 R08: 00000001c81bec00 R09: 0000000000000000
> 46.880: [    7.726092] R10: ffffc90006343e88 R11: 0000000000000000 R12: ffffffff82479b40
> 46.880: [    7.733494] R13: 0000000000000000 R14: 0000000000000012 R15: ffff88981dd50080
> 46.881: [    7.740853] FS:  0000000000000000(0000) GS:ffff88981fa80000(0000) knlGS:0000000000000000
> 46.881: [    7.749318] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 46.881: [    7.755281] CR2: 0000000000000000 CR3: 000000000240a000 CR4: 00000000000406e0
> 46.881: [    7.762761] Call Trace:
> 46.881: [    7.765369]  ? __schedule+0x1b9/0x7b0
> 46.882: [    7.769253]  __schedule+0x1b9/0x7b0
> 46.882: [    7.772930]  schedule_idle+0x1e/0x40
> 46.882: [    7.776744]  do_idle+0x146/0x200
> 46.882: [    7.780181]  cpu_startup_entry+0x19/0x20
> 46.883: [    7.784274]  start_secondary+0x183/0x1b0
> 46.883: [    7.788409]  secondary_startup_64+0xa4/0xb0
> 46.883: [    7.792766] Modules linked in:
> 46.883: [    7.796105] ---[ end trace a423e363fe1ecf67 ]---
> 46.884: [    7.800939] RIP: 0010:switch_mm_irqs_off+0xb2/0x640
> 46.884: [    7.806048] Code: 48 c1 ef 09 83 e7 01 48 09 c7 65 48 8b 05 8e 34 fc 7e 48 39 c7 74 15 48 09 f8 a8 01 74 0e b9 49 00 00 00 b8 01 00 00 00 31 d2 <0f> 30 65 48 89 3d 6c 34 fc 7e 8b 05 9a ef a7 01 85 c0 0f 8f 41 04
> 46.884: [    7.825440] RSP: 0018:ffffc90006343e20 EFLAGS: 00010046
> 46.885: [    7.830855] RAX: 0000000000000001 RBX: ffff88981ca0b800 RCX: 0000000000000049
> 46.885: [    7.838230] RDX: 0000000000000000 RSI: ffff88981b87cf80 RDI: ffff88981ca0b800
> 46.885: [    7.845614] RBP: ffffc90006343e70 R08: 00000001c81bec00 R09: 0000000000000000
> 46.886: [    7.853047] R10: ffffc90006343e88 R11: 0000000000000000 R12: ffffffff82479b40
> 46.886: [    7.860427] R13: 0000000000000000 R14: 0000000000000012 R15: ffff88981dd50080
> 46.886: [    7.867862] FS:  0000000000000000(0000) GS:ffff88981fa80000(0000) knlGS:0000000000000000
> 46.886: [    7.876320] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 46.887: [    7.882351] CR2: 0000000000000000 CR3: 000000000240a000 CR4: 00000000000406e0
> 46.887: [    7.889746] Kernel panic - not syncing: Attempted to kill the idle task!
> 46.888: [    7.896907] Kernel Offset: disabled
> 46.888: [    7.900558] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

Please find the whole log, including the coreboot messages, attached. 
The time stamps in the beginning are from the script `readserial.py` 
from the SeaBIOS repository.

Do you have an idea what is going on, and how to fix it?


Kind regards,

Paul

--------------977E1A8B6201E06D1B9C18A4
Content-Type: text/x-log;
 name="seriallog-20190103_175452.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="seriallog-20190103_175452.log"



=3D=3D=3D=3D=3D=3D=3D Thu Jan  3 17:55:21 2019 (adjust=3D86.8us)
00.000: <00>
00.308:=20
00.308:=20
00.308: coreboot-4.9-103-g637bef2037 Wed Jan  2 12:01:08 UTC 2019 romstag=
e starting...
00.316: CPU APICID 00 start flag set
00.319: BSP Family_Model: 00600f12
00.320: *sysinfo range: [000c2e40,000cd3ac]
00.320: bsp_apicid =3D 00
00.320: cpu_init_detectedx =3D 00000000
00.320: sb700 reset flags: 0000
00.323: CBFS: 'Master Header Locator' located CBFS at [200:200000)
00.323: CBFS: Locating 'microcode_amd.bin'
00.324: CBFS: Found @ offset 6d980 size 318c
00.325: CBFS: 'Master Header Locator' located CBFS at [200:200000)
00.325: CBFS: Locating 'microcode_amd_fam15h.bin'
00.326: CBFS: Found @ offset 70b80 size 1ec4
00.350: [microcode] patch id to apply =3D 0x0600063e
00.351: [microcode] updated to patch id =3D 0x0600063e success
00.352: cpuSetAMDMSR FMAP: Found "FLASH" version 1.1 at 0.
00.357: FMAP: base =3D ffe00000 size =3D 200000 #areas =3D 3
00.357: FMAP: area COREBOOT found @ 200 (2096640 bytes)
00.358: CBFS: Locating 'cmos_layout.bin'
00.358: CBFS: Found @ offset 2adc0 size dc4
00.360: FMAP: area COREBOOT found @ 200 (2096640 bytes)
00.360: CBFS: Locating 'cmos_layout.bin'
00.360: CBFS: Found @ offset 2adc0 size dc4
00.361:  done
00.361: Enter amd_ht_init
00.368: AMD_CB_EventNotify: INFO: HT_EVENT_COH_NODE_DISCOVERED: node 0 li=
nk 2 new node: 1
00.368: AMD_CB_EventNotify: INFO: HT_EVENT_COH_NODE_DISCOVERED: node 0 li=
nk 0 new node: 2
00.369: AMD_CB_EventNotify: INFO: HT_EVENT_COH_NODE_DISCOVERED: node 0 li=
nk 3 new node: 3
00.374: FMAP: area COREBOOT found @ 200 (2096640 bytes)
00.375: CBFS: Locating 'cmos_layout.bin'
00.375: CBFS: Found @ offset 2adc0 size dc4
00.376: Forcing HT links to isochronous mode due to enabled IOMMU
00.376: FMAP: area COREBOOT found @ 200 (2096640 bytes)
00.376: CBFS: Locating 'cmos_layout.bin'
00.377: CBFS: Found @ offset 2adc0 size dc4
00.379: Exit amd_ht_init
00.379: amd_ht_fixup
00.379: amd_ht_fixup: node 0 (internal node ID 0): disabling defective HT=
 link (L3 connected: 1)
00.380: amd_ht_fixup: node 1 (internal node ID 1): disabling defective HT=
 link (L3 connected: 1)
00.380: amd_ht_fixup: node 2 (internal node ID 0): disabling defective HT=
 link (L3 connected: 1)
00.380: amd_ht_fixup: node 3 (internal node ID 1): disabling defective HT=
 link (L3 connected: 1)
00.381: cpuSetAMDPCI 00 done
00.386: cpuSetAMDPCI 01 done
00.386: cpuSetAMDPCI 02 done
00.387: cpuSetAMDPCI 03 done
00.387: Prep FID/VID Node:00
00.388:   F3x80: e20be281
00.388:   F3x84: 01e200e2
00.388:   F3xD4: c3312f18
00.388:   F3xD8: 03000016
00.388:   F3xDC: 05475632
00.388: Prep FID/VID Node:01
00.389:   F3x80: e20be281
00.389:   F3x84: 01e200e2
00.389:   F3xD4: c3312f18
00.389:   F3xD8: 03000016
00.389:   F3xDC: 05475632
00.389: Prep FID/VID Node:02
00.389:   F3x80: e20be281
00.389:   F3x84: 01e200e2
00.389:   F3xD4: c3312f18
00.389:   F3xD8: 03000016
00.389:   F3xDC: 05475632
00.389: Prep FID/VID Node:03
00.389:   F3x80: e20be281
00.389:   F3x84: 01e200e2
00.390:   F3xD4: c3312f18
00.390:   F3xD8: 03000016
00.390:   F3xDC: 05475632
00.390: setup_remote_node: 01 done
00.390: Start node 01 done.
00.390: setup_remote_node: 02 done
00.391: Start node 02 done.
00.392: setup_remote_node: 03 done
00.396: Start node 03 done.
00.404: core0 started:  01 02 03
00.427: sr5650_early_setup()
00.428: get_cpu_rev EAX=3D0x600f12.
00.428: CPU Rev is Fam 15.
00.428: NB Revision is A12.
00.429: fam10_optimization()
00.429: sr5650_por_init
00.429: FMAP: area COREBOOT found @ 200 (2096640 bytes)
00.430: CBFS: Locating 'cmos_layout.bin'
00.434: CBFS: Found @ offset 2adc0 size dc4
00.442: Enabling IOMMU
00.449: sb700_early_setup()
00.451: FMAP: area COREBOOT found @ 200 (2096640 bytes)
00.451: CBFS: Locating 'cmos_layout.bin'
00.451: CBFS: Found @ offset 2adc0 size dc4
00.452: sb700_devices_por_init()
00.452: sb700_devices_por_init(): SMBus Device, BDF:0-20-0
00.464: SMBus controller enabled, sb revision is A15
00.466: sb700_devices_por_init: Disabling ISA DMA support
00.467: sb700_devices_por_init(): IDE Device, BDF:0-20-1
00.467: sb700_devices_por_init(): LPC Device, BDF:0-20-3
00.467: sb700_devices_por_init(): P2P Bridge, BDF:0-20-4
00.474: sb700_devices_por_init(): SATA Device, BDF:0-17-0
00.475: FMAP: area COREBOOT found @ 200 (2096640 bytes)
00.475: CBFS: Locating 'cmos_layout.bin'
00.476: CBFS: Found @ offset 2adc0 size dc4
00.476: sb700_pmio_por_init()
00.477: start_other_cores()
00.477: NOTICE: read_option() used to access CMOS from non-ROMCC code, pl=
ease use get_option() instead.
00.477: init node: 00  cores: 07 pass 1
00.478: Start other core - nodeid: 00  cores: 07
00.478: get_boot_apic_id: using 2 as APIC ID for node 0, core 2
00.613: get_boot_apic_id: using 4 as APIC ID for node 0, core 4
00.613: get_boot_apic_id: using 6 as APIC ID for node 0, core 6
00.613: init node: 01  cores: 07 pass 1
00.618: Start other core - nodeid: 01  cores: 07
00.629: get_boot_apic_id: using 10 as APIC ID for node 1, core 2
00.790: get_boot_apic_id: using 12 as APIC ID for node 1, core 4
00.796: get_boot_apic_id: using 14 as APIC ID for node 1, core 6
00.828: init node: 02  cores: 07 pass 1
00.832: Start other core - nodeid: 02  cores: 07
00.838: get_boot_apic_id: using 34 as APIC ID for node 2, core 2
01.067: get_boot_apic_id: using 36 as APIC ID for node 2, core 4
01.134: get_boot_apic_id: using 38 as APIC ID for node 2, core 6
01.135: init node: 03  cores: 07 pass 1
01.137: Start other core - nodeid: 03  cores: 07
01.152: get_boot_apic_id: using 42 as APIC ID for node 3, core 2
01.403: get_boot_apic_id: using 44 as APIC ID for node 3, core 4
01.429: get_boot_apic_id: using 46 as APIC ID for node 3, core 6
01.430: started ap apicid: NOTICE: read_option() used to access CMOS from=
 non-ROMCC code, please use get_option() instead.
01.443: get_boot_apic_id: using 1 as APIC ID for node 0, core 1
01.444: * AP 01started
01.444: get_boot_apic_id: using 2 as APIC ID for node 0, core 2
01.444: * AP 02started
01.445: get_boot_apic_id: using 3 as APIC ID for node 0, core 3
01.445: * AP 03started
01.445: get_boot_apic_id: using 4 as APIC ID for node 0, core 4
01.453: * AP 04started
01.454: get_boot_apic_id: using 5 as APIC ID for node 0, core 5
01.456: * AP 05started
01.456: get_boot_apic_id: using 6 as APIC ID for node 0, core 6
01.456: * AP 06started
01.457: get_boot_apic_id: using 7 as APIC ID for node 0, core 7
01.457: * AP 07started
01.457: get_boot_apic_id: using 9 as APIC ID for node 1, core 1
01.465: * AP 09started
01.466: get_boot_apic_id: using 10 as APIC ID for node 1, core 2
01.468: * AP 0astarted
01.469: get_boot_apic_id: using 11 as APIC ID for node 1, core 3
01.469: * AP 0bstarted
01.469: get_boot_apic_id: using 12 as APIC ID for node 1, core 4
01.469: * AP 0cstarted
01.469: get_boot_apic_id: using 13 as APIC ID for node 1, core 5
01.477: * AP 0dstarted
01.478: get_boot_apic_id: using 14 as APIC ID for node 1, core 6
01.480: * AP 0estarted
01.480: get_boot_apic_id: using 15 as APIC ID for node 1, core 7
01.480: * AP 0fstarted
01.481: get_boot_apic_id: using 33 as APIC ID for node 2, core 1
01.481: * AP 21started
01.481: get_boot_apic_id: using 34 as APIC ID for node 2, core 2
01.486: * AP 22started
01.488: get_boot_apic_id: using 35 as APIC ID for node 2, core 3
01.488: * AP 23started
01.488: get_boot_apic_id: using 36 as APIC ID for node 2, core 4
01.488: * AP 24started
01.488: get_boot_apic_id: using 37 as APIC ID for node 2, core 5
01.488: * AP 25started
01.488: get_boot_apic_id: using 38 as APIC ID for node 2, core 6
01.488: * AP 26started
01.488: get_boot_apic_id: using 39 as APIC ID for node 2, core 7
01.489: * AP 27started
01.489: get_boot_apic_id: using 41 as APIC ID for node 3, core 1
01.489: * AP 29started
01.489: get_boot_apic_id: using 42 as APIC ID for node 3, core 2
01.489: * AP 2astarted
01.489: get_boot_apic_id: using 43 as APIC ID for node 3, core 3
01.489: * AP 2bstarted
01.489: get_boot_apic_id: using 44 as APIC ID for node 3, core 4
01.489: * AP 2cstarted
01.489: get_boot_apic_id: using 45 as APIC ID for node 3, core 5
01.489: * AP 2dstarted
01.490: get_boot_apic_id: using 46 as APIC ID for node 3, core 6
01.490: * AP 2estarted
01.490: get_boot_apic_id: using 47 as APIC ID for node 3, core 7
01.490: * AP 2fstarted
01.490:=20
01.490:=20
01.490: Begin FIDVID MSR 0xc0010071 0x52c2009e 0x3c06644c
01.491: FIDVID on BSP, APIC_id: 00
01.491: BSP fid =3D 0
01.491: NOTICE: read_option() used to access CMOS from non-ROMCC code, pl=
ease use get_option() instead.
01.492: get_boot_apic_id: using 0 as APIC ID for node 0, core 0
01.492: get_boot_apic_id: using 1 as APIC ID for node 0, core 1
01.492: get_boot_apic_id: using 2 as APIC ID for node 0, core 2
01.492: get_boot_apic_id: using 3 as APIC ID for node 0, core 3
01.492: get_boot_apic_id: using 4 as APIC ID for node 0, core 4
01.492: get_boot_apic_id: using 5 as APIC ID for node 0, core 5
01.492: get_boot_apic_id: using 6 as APIC ID for node 0, core 6
01.493: get_boot_apic_id: using 7 as APIC ID for node 0, core 7
01.493: get_boot_apic_id: using 8 as APIC ID for node 1, core 0
01.493: get_boot_apic_id: using 9 as APIC ID for node 1, core 1
01.493: get_boot_apic_id: using 10 as APIC ID for node 1, core 2
01.493: get_boot_apic_id: using 11 as APIC ID for node 1, core 3
01.493: get_boot_apic_id: using 12 as APIC ID for node 1, core 4
01.493: get_boot_apic_id: using 13 as APIC ID for node 1, core 5
01.494: get_boot_apic_id: using 14 as APIC ID for node 1, core 6
01.494: get_boot_apic_id: using 15 as APIC ID for node 1, core 7
01.494: get_boot_apic_id: using 32 as APIC ID for node 2, core 0
01.494: get_boot_apic_id: using 33 as APIC ID for node 2, core 1
01.494: get_boot_apic_id: using 34 as APIC ID for node 2, core 2
01.494: get_boot_apic_id: using 35 as APIC ID for node 2, core 3
01.494: get_boot_apic_id: using 36 as APIC ID for node 2, core 4
01.495: get_boot_apic_id: using 37 as APIC ID for node 2, core 5
01.495: get_boot_apic_id: using 38 as APIC ID for node 2, core 6
01.495: get_boot_apic_id: using 39 as APIC ID for node 2, core 7
01.495: get_boot_apic_id: using 40 as APIC ID for node 3, core 0
01.495: get_boot_apic_id: using 41 as APIC ID for node 3, core 1
01.495: get_boot_apic_id: using 42 as APIC ID for node 3, core 2
01.495: get_boot_apic_id: using 43 as APIC ID for node 3, core 3
01.496: get_boot_apic_id: using 44 as APIC ID for node 3, core 4
01.496: get_boot_apic_id: using 45 as APIC ID for node 3, core 5
01.496: get_boot_apic_id: using 46 as APIC ID for node 3, core 6
01.496: get_boot_apic_id: using 47 as APIC ID for node 3, core 7
01.496: Wait for AP stage 1: ap_apicid =3D 1
01.496: <09>readback =3D 1000014
01.497: <09>common_fid(packed) =3D 0
01.497: Wait for AP stage 1: ap_apicid =3D 2
01.497: <09>readback =3D 2000014
01.497: <09>common_fid(packed) =3D 0
01.497: Wait for AP stage 1: ap_apicid =3D 3
01.497: <09>readback =3D 3000014
01.497: <09>common_fid(packed) =3D 0
01.497: Wait for AP stage 1: ap_apicid =3D 4
01.497: <09>readback =3D 4000014
01.497: <09>common_fid(packed) =3D 0
01.497: Wait for AP stage 1: ap_apicid =3D 5
01.497: <09>readback =3D 5000014
01.497: <09>common_fid(packed) =3D 0
01.497: Wait for AP stage 1: ap_apicid =3D 6
01.498: <09>readback =3D 6000014
01.498: <09>common_fid(packed) =3D 0
01.498: Wait for AP stage 1: ap_apicid =3D 7
01.498: <09>readback =3D 7000014
01.498: <09>common_fid(packed) =3D 0
01.498: Wait for AP stage 1: ap_apicid =3D 8
01.498: <09>readback =3D 8000014
01.498: <09>common_fid(packed) =3D 0
01.498: Wait for AP stage 1: ap_apicid =3D 9
01.498: <09>readback =3D 9000014
01.498: <09>common_fid(packed) =3D 0
01.498: Wait for AP stage 1: ap_apicid =3D a
01.498: <09>readback =3D a000014
01.499: <09>common_fid(packed) =3D 0
01.499: Wait for AP stage 1: ap_apicid =3D b
01.499: <09>readback =3D b000014
01.499: <09>common_fid(packed) =3D 0
01.499: Wait for AP stage 1: ap_apicid =3D c
01.499: <09>readback =3D c000014
01.499: <09>common_fid(packed) =3D 0
01.499: Wait for AP stage 1: ap_apicid =3D d
01.499: <09>readback =3D d000014
01.499: <09>common_fid(packed) =3D 0
01.499: Wait for AP stage 1: ap_apicid =3D e
01.499: <09>readback =3D e000014
01.499: <09>common_fid(packed) =3D 0
01.499: Wait for AP stage 1: ap_apicid =3D f
01.500: <09>readback =3D f000014
01.500: <09>common_fid(packed) =3D 0
01.500: Wait for AP stage 1: ap_apicid =3D 20
01.500: <09>readback =3D 20000014
01.500: <09>common_fid(packed) =3D 0
01.500: Wait for AP stage 1: ap_apicid =3D 21
01.500: <09>readback =3D 21000014
01.500: <09>common_fid(packed) =3D 0
01.500: Wait for AP stage 1: ap_apicid =3D 22
01.500: <09>readback =3D 22000014
01.500: <09>common_fid(packed) =3D 0
01.500: Wait for AP stage 1: ap_apicid =3D 23
01.501: <09>readback =3D 23000014
01.501: <09>common_fid(packed) =3D 0
01.501: Wait for AP stage 1: ap_apicid =3D 24
01.501: <09>readback =3D 24000014
01.501: <09>common_fid(packed) =3D 0
01.501: Wait for AP stage 1: ap_apicid =3D 25
01.501: <09>readback =3D 25000014
01.501: <09>common_fid(packed) =3D 0
01.501: Wait for AP stage 1: ap_apicid =3D 26
01.501: <09>readback =3D 26000014
01.501: <09>common_fid(packed) =3D 0
01.501: Wait for AP stage 1: ap_apicid =3D 27
01.501: <09>readback =3D 27000014
01.501: <09>common_fid(packed) =3D 0
01.502: Wait for AP stage 1: ap_apicid =3D 28
01.502: <09>readback =3D 28000014
01.502: <09>common_fid(packed) =3D 0
01.502: Wait for AP stage 1: ap_apicid =3D 29
01.502: <09>readback =3D 29000014
01.502: <09>common_fid(packed) =3D 0
01.502: Wait for AP stage 1: ap_apicid =3D 2a
01.502: <09>readback =3D 2a000014
01.502: <09>common_fid(packed) =3D 0
01.502: Wait for AP stage 1: ap_apicid =3D 2b
01.502: <09>readback =3D 2b000014
01.502: <09>common_fid(packed) =3D 0
01.502: Wait for AP stage 1: ap_apicid =3D 2c
01.503: <09>readback =3D 2c000014
01.503: <09>common_fid(packed) =3D 0
01.503: Wait for AP stage 1: ap_apicid =3D 2d
01.503: <09>readback =3D 2d000014
01.503: <09>common_fid(packed) =3D 0
01.503: Wait for AP stage 1: ap_apicid =3D 2e
01.503: <09>readback =3D 2e000014
01.503: <09>common_fid(packed) =3D 0
01.503: Wait for AP stage 1: ap_apicid =3D 2f
01.503: <09>readback =3D 2f000014
01.503: <09>common_fid(packed) =3D 0
01.503: common_fid =3D 0
01.504: End FIDVIDMSR 0xc0010071 0x52c2009e 0x3c06644c
01.504: sr5650_htinit: Node 0 Link 1, HT freq=3De.
01.504: sr5650_htinit: HT3 mode
01.505: ...WARM RESET...
01.505:=20
01.505:=20
01.505: soft_reset() called!
01.505: <00>
01.665:=20
01.666:=20
01.666: coreboot-4.9-103-g637bef2037 Wed Jan  2 12:01:08 UTC 2019 romstag=
e starting...
01.673: CPU APICID 00 start flag set
01.676: BSP Family_Model: 00600f12
01.676: *sysinfo range: [000c2e40,000cd3ac]
01.676: bsp_apicid =3D 00
01.676: cpu_init_detectedx =3D 00000000
01.677: sb700 reset flags: 0004
01.679: CBFS: 'Master Header Locator' located CBFS at [200:200000)
01.679: CBFS: Locating 'microcode_amd.bin'
01.680: CBFS: Found @ offset 6d980 size 318c
01.681: CBFS: 'Master Header Locator' located CBFS at [200:200000)
01.681: CBFS: Locating 'microcode_amd_fam15h.bin'
01.681: CBFS: Found @ offset 70b80 size 1ec4
01.705: [microcode] patch id to apply =3D 0x0600063e
01.706: [microcode] updated to patch id =3D 0x0600063e success
01.707: cpuSetAMDMSR FMAP: Found "FLASH" version 1.1 at 0.
01.711: FMAP: base =3D ffe00000 size =3D 200000 #areas =3D 3
01.711: FMAP: area COREBOOT found @ 200 (2096640 bytes)
01.712: CBFS: Locating 'cmos_layout.bin'
01.712: CBFS: Found @ offset 2adc0 size dc4
01.714: FMAP: area COREBOOT found @ 200 (2096640 bytes)
01.714: CBFS: Locating 'cmos_layout.bin'
01.714: CBFS: Found @ offset 2adc0 size dc4
01.714:  done
01.715: Enter amd_ht_init
01.721: AMD_CB_EventNotify: INFO: HT_EVENT_COH_NODE_DISCOVERED: node 0 li=
nk 2 new node: 1
01.721: AMD_CB_EventNotify: INFO: HT_EVENT_COH_NODE_DISCOVERED: node 0 li=
nk 0 new node: 2
01.722: AMD_CB_EventNotify: INFO: HT_EVENT_COH_NODE_DISCOVERED: node 0 li=
nk 3 new node: 3
01.726: FMAP: area COREBOOT found @ 200 (2096640 bytes)
01.726: CBFS: Locating 'cmos_layout.bin'
01.727: CBFS: Found @ offset 2adc0 size dc4
01.727: Forcing HT links to isochronous mode due to enabled IOMMU
01.727: FMAP: area COREBOOT found @ 200 (2096640 bytes)
01.728: CBFS: Locating 'cmos_layout.bin'
01.728: CBFS: Found @ offset 2adc0 size dc4
01.729: Exit amd_ht_init
01.729: amd_ht_fixup
01.730: amd_ht_fixup: node 0 (internal node ID 0): disabling defective HT=
 link (L3 connected: 1)
01.730: amd_ht_fixup: node 1 (internal node ID 1): disabling defective HT=
 link (L3 connected: 1)
01.730: amd_ht_fixup: node 2 (internal node ID 0): disabling defective HT=
 link (L3 connected: 1)
01.730: amd_ht_fixup: node 3 (internal node ID 1): disabling defective HT=
 link (L3 connected: 1)
01.731: cpuSetAMDPCI 00 done
01.735: cpuSetAMDPCI 01 done
01.736: cpuSetAMDPCI 02 done
01.736: cpuSetAMDPCI 03 done
01.736: Prep FID/VID Node:00
01.737:   F3x80: e20be281
01.737:   F3x84: 01e200e2
01.737:   F3xD4: c3312f18
01.737:   F3xD8: 03000016
01.737:   F3xDC: 05475632
01.737: Prep FID/VID Node:01
01.737:   F3x80: e20be281
01.737:   F3x84: 01e200e2
01.737:   F3xD4: c3312f18
01.737:   F3xD8: 03000016
01.737:   F3xDC: 05475632
01.737: Prep FID/VID Node:02
01.737:   F3x80: e20be281
01.737:   F3x84: 01e200e2
01.737:   F3xD4: c3312f18
01.737:   F3xD8: 03000016
01.737:   F3xDC: 05475632
01.737: Prep FID/VID Node:03
01.737:   F3x80: e20be281
01.737:   F3x84: 01e200e2
01.737:   F3xD4: c3312f18
01.737:   F3xD8: 03000016
01.737:   F3xDC: 05475632
01.737: setup_remote_node: 01 done
01.738: Start node 01 done.
01.738: setup_remote_node: 02 done
01.739: Start node 02 done.
01.740: setup_remote_node: 03 done
01.744: Start node 03 done.
01.750: core0 started:  01 02 03
01.753: sr5650_early_setup()
01.755: get_cpu_rev EAX=3D0x600f12.
01.759: CPU Rev is Fam 15.
01.762: NB Revision is A12.
01.765: fam10_optimization()
01.766: sr5650_por_init
01.767: FMAP: area COREBOOT found @ 200 (2096640 bytes)
01.767: CBFS: Locating 'cmos_layout.bin'
01.767: CBFS: Found @ offset 2adc0 size dc4
01.768: Enabling IOMMU
01.769: sb700_early_setup()
01.771: FMAP: area COREBOOT found @ 200 (2096640 bytes)
01.778: CBFS: Locating 'cmos_layout.bin'
01.779: CBFS: Found @ offset 2adc0 size dc4
01.780: sb700_devices_por_init()
01.783: sb700_devices_por_init(): SMBus Device, BDF:0-20-0
01.785: SMBus controller enabled, sb revision is A15
01.792: sb700_devices_por_init: Disabling ISA DMA support
01.795: sb700_devices_por_init(): IDE Device, BDF:0-20-1
01.796: sb700_devices_por_init(): LPC Device, BDF:0-20-3
01.796: sb700_devices_por_init(): P2P Bridge, BDF:0-20-4
01.796: sb700_devices_por_init(): SATA Device, BDF:0-17-0
01.804: FMAP: area COREBOOT found @ 200 (2096640 bytes)
01.804: CBFS: Locating 'cmos_layout.bin'
01.804: CBFS: Found @ offset 2adc0 size dc4
01.804: sb700_pmio_por_init()
01.806: start_other_cores()
01.807: NOTICE: read_option() used to access CMOS from non-ROMCC code, pl=
ease use get_option() instead.
01.807: init node: 00  cores: 07 pass 1
01.807: Start other core - nodeid: 00  cores: 07
01.807: get_boot_apic_id: using 2 as APIC ID for node 0, core 2
01.873: get_boot_apic_id: using 4 as APIC ID for node 0, core 4
01.931: get_boot_apic_id: using 6 as APIC ID for node 0, core 6
01.931: init node: 01  cores: 07 pass 1
01.935: Start other core - nodeid: 01  cores: 07
01.948: get_boot_apic_id: using 10 as APIC ID for node 1, core 2
02.101: get_boot_apic_id: using 12 as APIC ID for node 1, core 4
02.102: get_boot_apic_id: using 14 as APIC ID for node 1, core 6
02.127: init node: 02  cores: 07 pass 1
02.130: Start other core - nodeid: 02  cores: 07
02.136: get_boot_apic_id: using 34 as APIC ID for node 2, core 2
02.368: get_boot_apic_id: using 36 as APIC ID for node 2, core 4
02.400: get_boot_apic_id: using 38 as APIC ID for node 2, core 6
02.426: init node: 03  cores: 07 pass 1
02.429: Start other core - nodeid: 03  cores: 07
02.439: get_boot_apic_id: using 42 as APIC ID for node 3, core 2
02.654: get_boot_apic_id: using 44 as APIC ID for node 3, core 4
02.654: get_boot_apic_id: using 46 as APIC ID for node 3, core 6
02.674: started ap apicid: NOTICE: read_option() used to access CMOS from=
 non-ROMCC code, please use get_option() instead.
02.691: get_boot_apic_id: using 1 as APIC ID for node 0, core 1
02.692: * AP 01started
02.692: get_boot_apic_id: using 2 as APIC ID for node 0, core 2
02.692: * AP 02started
02.692: get_boot_apic_id: using 3 as APIC ID for node 0, core 3
02.700: * AP 03started
02.700: get_boot_apic_id: using 4 as APIC ID for node 0, core 4
02.703: * AP 04started
02.703: get_boot_apic_id: using 5 as APIC ID for node 0, core 5
02.703: * AP 05started
02.703: get_boot_apic_id: using 6 as APIC ID for node 0, core 6
02.711: * AP 06started
02.712: get_boot_apic_id: using 7 as APIC ID for node 0, core 7
02.715: * AP 07started
02.715: get_boot_apic_id: using 9 as APIC ID for node 1, core 1
02.715: * AP 09started
02.715: get_boot_apic_id: using 10 as APIC ID for node 1, core 2
02.723: * AP 0astarted
02.723: get_boot_apic_id: using 11 as APIC ID for node 1, core 3
02.726: * AP 0bstarted
02.726: get_boot_apic_id: using 12 as APIC ID for node 1, core 4
02.726: * AP 0cstarted
02.726: get_boot_apic_id: using 13 as APIC ID for node 1, core 5
02.732: * AP 0dstarted
02.733: get_boot_apic_id: using 14 as APIC ID for node 1, core 6
02.733: * AP 0estarted
02.733: get_boot_apic_id: using 15 as APIC ID for node 1, core 7
02.733: * AP 0fstarted
02.733: get_boot_apic_id: using 33 as APIC ID for node 2, core 1
02.733: * AP 21started
02.733: get_boot_apic_id: using 34 as APIC ID for node 2, core 2
02.733: * AP 22started
02.733: get_boot_apic_id: using 35 as APIC ID for node 2, core 3
02.733: * AP 23started
02.733: get_boot_apic_id: using 36 as APIC ID for node 2, core 4
02.733: * AP 24started
02.733: get_boot_apic_id: using 37 as APIC ID for node 2, core 5
02.733: * AP 25started
02.733: get_boot_apic_id: using 38 as APIC ID for node 2, core 6
02.733: * AP 26started
02.733: get_boot_apic_id: using 39 as APIC ID for node 2, core 7
02.733: * AP 27started
02.733: get_boot_apic_id: using 41 as APIC ID for node 3, core 1
02.733: * AP 29started
02.733: get_boot_apic_id: using 42 as APIC ID for node 3, core 2
02.733: * AP 2astarted
02.733: get_boot_apic_id: using 43 as APIC ID for node 3, core 3
02.733: * AP 2bstarted
02.733: get_boot_apic_id: using 44 as APIC ID for node 3, core 4
02.733: * AP 2cstarted
02.733: get_boot_apic_id: using 45 as APIC ID for node 3, core 5
02.733: * AP 2dstarted
02.733: get_boot_apic_id: using 46 as APIC ID for node 3, core 6
02.733: * AP 2estarted
02.733: get_boot_apic_id: using 47 as APIC ID for node 3, core 7
02.733: * AP 2fstarted
02.733:=20
02.733:=20
02.733: Begin FIDVID MSR 0xc0010071 0x52c2009e 0x3c025408
02.734: End FIDVIDMSR 0xc0010071 0x52c2009e 0x3c025408
02.734: sr5650_htinit: Node 0 Link 1, HT freq=3De.
02.734: sr5650_htinit: HT3 mode
02.735: FMAP: area COREBOOT found @ 200 (2096640 bytes)
02.735: CBFS: Locating 'cmos_layout.bin'
02.735: CBFS: Found @ offset 2adc0 size dc4
02.736: ...WARM RESET...
02.736:=20
02.736:=20
02.736: soft_reset() called!
02.736: <00>
02.891:=20
02.891:=20
02.891: coreboot-4.9-103-g637bef2037 Wed Jan  2 12:01:08 UTC 2019 romstag=
e starting...
02.898: CPU APICID 00 start flag set
02.901: BSP Family_Model: 00600f12
02.902: *sysinfo range: [000c2e40,000cd3ac]
02.902: bsp_apicid =3D 00
02.902: cpu_init_detectedx =3D 00000000
02.902: sb700 reset flags: 0004
02.904: CBFS: 'Master Header Locator' located CBFS at [200:200000)
02.904: CBFS: Locating 'microcode_amd.bin'
02.905: CBFS: Found @ offset 6d980 size 318c
02.906: CBFS: 'Master Header Locator' located CBFS at [200:200000)
02.906: CBFS: Locating 'microcode_amd_fam15h.bin'
02.906: CBFS: Found @ offset 70b80 size 1ec4
02.924: [microcode] patch id to apply =3D 0x0600063e
02.924: [microcode] updated to patch id =3D 0x0600063e success
02.925: cpuSetAMDMSR FMAP: Found "FLASH" version 1.1 at 0.
02.929: FMAP: base =3D ffe00000 size =3D 200000 #areas =3D 3
02.930: FMAP: area COREBOOT found @ 200 (2096640 bytes)
02.930: CBFS: Locating 'cmos_layout.bin'
02.930: CBFS: Found @ offset 2adc0 size dc4
02.932: FMAP: area COREBOOT found @ 200 (2096640 bytes)
02.932: CBFS: Locating 'cmos_layout.bin'
02.932: CBFS: Found @ offset 2adc0 size dc4
02.932:  done
02.933: Enter amd_ht_init
02.939: AMD_CB_EventNotify: INFO: HT_EVENT_COH_NODE_DISCOVERED: node 0 li=
nk 2 new node: 1
02.939: AMD_CB_EventNotify: INFO: HT_EVENT_COH_NODE_DISCOVERED: node 0 li=
nk 0 new node: 2
02.939: AMD_CB_EventNotify: INFO: HT_EVENT_COH_NODE_DISCOVERED: node 0 li=
nk 3 new node: 3
02.945: FMAP: area COREBOOT found @ 200 (2096640 bytes)
02.945: CBFS: Locating 'cmos_layout.bin'
02.945: CBFS: Found @ offset 2adc0 size dc4
02.945: Forcing HT links to isochronous mode due to enabled IOMMU
02.946: FMAP: area COREBOOT found @ 200 (2096640 bytes)
02.946: CBFS: Locating 'cmos_layout.bin'
02.946: CBFS: Found @ offset 2adc0 size dc4
02.947: Exit amd_ht_init
02.948: amd_ht_fixup
02.948: amd_ht_fixup: node 0 (internal node ID 0): disabling defective HT=
 link (L3 connected: 1)
02.948: amd_ht_fixup: node 1 (internal node ID 1): disabling defective HT=
 link (L3 connected: 1)
02.948: amd_ht_fixup: node 2 (internal node ID 0): disabling defective HT=
 link (L3 connected: 1)
02.948: amd_ht_fixup: node 3 (internal node ID 1): disabling defective HT=
 link (L3 connected: 1)
02.949: cpuSetAMDPCI 00 done
02.953: cpuSetAMDPCI 01 done
02.954: cpuSetAMDPCI 02 done
02.954: cpuSetAMDPCI 03 done
02.954: Prep FID/VID Node:00
02.955:   F3x80: e20be281
02.955:   F3x84: 01e200e2
02.955:   F3xD4: c3312f18
02.955:   F3xD8: 03000016
02.955:   F3xDC: 05475632
02.955: Prep FID/VID Node:01
02.955:   F3x80: e20be281
02.955:   F3x84: 01e200e2
02.955:   F3xD4: c3312f18
02.955:   F3xD8: 03000016
02.955:   F3xDC: 05475632
02.955: Prep FID/VID Node:02
02.955:   F3x80: e20be281
02.955:   F3x84: 01e200e2
02.955:   F3xD4: c3312f18
02.955:   F3xD8: 03000016
02.955:   F3xDC: 05475632
02.955: Prep FID/VID Node:03
02.955:   F3x80: e20be281
02.955:   F3x84: 01e200e2
02.955:   F3xD4: c3312f18
02.955:   F3xD8: 03000016
02.955:   F3xDC: 05475632
02.955: setup_remote_node: 01 done
02.955: Start node 01 done.
02.956: setup_remote_node: 02 done
02.957: Start node 02 done.
02.958: setup_remote_node: 03 done
02.962: Start node 03 done.
02.968: core0 started:  01 02 03
02.971: sr5650_early_setup()
02.973: get_cpu_rev EAX=3D0x600f12.
02.976: CPU Rev is Fam 15.
02.979: NB Revision is A12.
02.982: fam10_optimization()
02.983: sr5650_por_init
02.984: FMAP: area COREBOOT found @ 200 (2096640 bytes)
02.984: CBFS: Locating 'cmos_layout.bin'
02.984: CBFS: Found @ offset 2adc0 size dc4
02.995: Enabling IOMMU
03.001: sb700_early_setup()
03.003: FMAP: area COREBOOT found @ 200 (2096640 bytes)
03.004: CBFS: Locating 'cmos_layout.bin'
03.004: CBFS: Found @ offset 2adc0 size dc4
03.004: sb700_devices_por_init()
03.006: sb700_devices_por_init(): SMBus Device, BDF:0-20-0
03.016: SMBus controller enabled, sb revision is A15
03.017: sb700_devices_por_init: Disabling ISA DMA support
03.017: sb700_devices_por_init(): IDE Device, BDF:0-20-1
03.024: sb700_devices_por_init(): LPC Device, BDF:0-20-3
03.024: sb700_devices_por_init(): P2P Bridge, BDF:0-20-4
03.025: sb700_devices_por_init(): SATA Device, BDF:0-17-0
03.025: FMAP: area COREBOOT found @ 200 (2096640 bytes)
03.025: CBFS: Locating 'cmos_layout.bin'
03.025: CBFS: Found @ offset 2adc0 size dc4
03.025: sb700_pmio_por_init()
03.026: start_other_cores()
03.026: NOTICE: read_option() used to access CMOS from non-ROMCC code, pl=
ease use get_option() instead.
03.026: init node: 00  cores: 07 pass 1
03.026: Start other core - nodeid: 00  cores: 07
03.027: get_boot_apic_id: using 2 as APIC ID for node 0, core 2
03.116: get_boot_apic_id: using 4 as APIC ID for node 0, core 4
03.116: get_boot_apic_id: using 6 as APIC ID for node 0, core 6
03.129: init node: 01  cores: 07 pass 1
03.133: Start other core - nodeid: 01  cores: 07
03.144: get_boot_apic_id: using 10 as APIC ID for node 1, core 2
03.288: get_boot_apic_id: using 12 as APIC ID for node 1, core 4
03.289: get_boot_apic_id: using 14 as APIC ID for node 1, core 6
03.307: init node: 02  cores: 07 pass 1
03.309: Start other core - nodeid: 02  cores: 07
03.319: get_boot_apic_id: using 34 as APIC ID for node 2, core 2
03.509: get_boot_apic_id: using 36 as APIC ID for node 2, core 4
03.575: get_boot_apic_id: using 38 as APIC ID for node 2, core 6
03.582: init node: 03  cores: 07 pass 1
03.584: Start other core - nodeid: 03  cores: 07
03.594: get_boot_apic_id: using 42 as APIC ID for node 3, core 2
03.794: get_boot_apic_id: using 44 as APIC ID for node 3, core 4
03.812: get_boot_apic_id: using 46 as APIC ID for node 3, core 6
03.813: started ap apicid: NOTICE: read_option() used to access CMOS from=
 non-ROMCC code, please use get_option() instead.
03.825: get_boot_apic_id: using 1 as APIC ID for node 0, core 1
03.826: * AP 01started
03.826: get_boot_apic_id: using 2 as APIC ID for node 0, core 2
03.826: * AP 02started
03.831: get_boot_apic_id: using 3 as APIC ID for node 0, core 3
03.836: * AP 03started
03.837: get_boot_apic_id: using 4 as APIC ID for node 0, core 4
03.838: * AP 04started
03.838: get_boot_apic_id: using 5 as APIC ID for node 0, core 5
03.838: * AP 05started
03.842: get_boot_apic_id: using 6 as APIC ID for node 0, core 6
03.847: * AP 06started
03.849: get_boot_apic_id: using 7 as APIC ID for node 0, core 7
03.849: * AP 07started
03.849: get_boot_apic_id: using 9 as APIC ID for node 1, core 1
03.849: * AP 09started
03.852: get_boot_apic_id: using 10 as APIC ID for node 1, core 2
03.858: * AP 0astarted
03.860: get_boot_apic_id: using 11 as APIC ID for node 1, core 3
03.861: * AP 0bstarted
03.861: get_boot_apic_id: using 12 as APIC ID for node 1, core 4
03.861: * AP 0cstarted
03.863: get_boot_apic_id: using 13 as APIC ID for node 1, core 5
03.867: * AP 0dstarted
03.867: get_boot_apic_id: using 14 as APIC ID for node 1, core 6
03.867: * AP 0estarted
03.867: get_boot_apic_id: using 15 as APIC ID for node 1, core 7
03.867: * AP 0fstarted
03.867: get_boot_apic_id: using 33 as APIC ID for node 2, core 1
03.867: * AP 21started
03.867: get_boot_apic_id: using 34 as APIC ID for node 2, core 2
03.867: * AP 22started
03.867: get_boot_apic_id: using 35 as APIC ID for node 2, core 3
03.867: * AP 23started
03.867: get_boot_apic_id: using 36 as APIC ID for node 2, core 4
03.868: * AP 24started
03.868: get_boot_apic_id: using 37 as APIC ID for node 2, core 5
03.868: * AP 25started
03.868: get_boot_apic_id: using 38 as APIC ID for node 2, core 6
03.868: * AP 26started
03.868: get_boot_apic_id: using 39 as APIC ID for node 2, core 7
03.868: * AP 27started
03.868: get_boot_apic_id: using 41 as APIC ID for node 3, core 1
03.868: * AP 29started
03.868: get_boot_apic_id: using 42 as APIC ID for node 3, core 2
03.868: * AP 2astarted
03.868: get_boot_apic_id: using 43 as APIC ID for node 3, core 3
03.868: * AP 2bstarted
03.868: get_boot_apic_id: using 44 as APIC ID for node 3, core 4
03.868: * AP 2cstarted
03.868: get_boot_apic_id: using 45 as APIC ID for node 3, core 5
03.868: * AP 2dstarted
03.868: get_boot_apic_id: using 46 as APIC ID for node 3, core 6
03.868: * AP 2estarted
03.868: get_boot_apic_id: using 47 as APIC ID for node 3, core 7
03.868: * AP 2fstarted
03.868:=20
03.868:=20
03.868: Begin FIDVID MSR 0xc0010071 0x52c2009e 0x3c025408
03.869: End FIDVIDMSR 0xc0010071 0x52c2009e 0x3c025408
03.869: sr5650_htinit: Node 0 Link 1, HT freq=3De.
03.869: sr5650_htinit: HT3 mode
03.870: FMAP: area COREBOOT found @ 200 (2096640 bytes)
03.870: CBFS: Locating 'cmos_layout.bin'
03.870: CBFS: Found @ offset 2adc0 size dc4
03.871: Node 00 DIMM voltage set to index 00
03.871: Node 01 DIMM voltage set to index 00
03.871: FMAP: area COREBOOT found @ 200 (2096640 bytes)
03.871: CBFS: Locating 'cmos_layout.bin'
03.871: CBFS: Found @ offset 2adc0 size dc4
03.872: stopped ap apicid: NOTICE: read_option() used to access CMOS from=
 non-ROMCC code, please use get_option() instead.
03.872: get_boot_apic_id: using 1 as APIC ID for node 0, core 1
03.872: * AP 01stopped
03.872: get_boot_apic_id: using 2 as APIC ID for node 0, core 2
03.872: * AP 02stopped
03.872: get_boot_apic_id: using 3 as APIC ID for node 0, core 3
03.872: * AP 03stopped
03.872: get_boot_apic_id: using 4 as APIC ID for node 0, core 4
03.872: * AP 04stopped
03.872: get_boot_apic_id: using 5 as APIC ID for node 0, core 5
03.872: * AP 05stopped
03.872: get_boot_apic_id: using 6 as APIC ID for node 0, core 6
03.872: * AP 06stopped
03.872: get_boot_apic_id: using 7 as APIC ID for node 0, core 7
03.872: * AP 07stopped
03.872: get_boot_apic_id: using 9 as APIC ID for node 1, core 1
03.872: * AP 09stopped
03.872: get_boot_apic_id: using 10 as APIC ID for node 1, core 2
03.872: * AP 0astopped
03.872: get_boot_apic_id: using 11 as APIC ID for node 1, core 3
03.872: * AP 0bstopped
03.872: get_boot_apic_id: using 12 as APIC ID for node 1, core 4
03.872: * AP 0cstopped
03.872: get_boot_apic_id: using 13 as APIC ID for node 1, core 5
03.872: * AP 0dstopped
03.872: get_boot_apic_id: using 14 as APIC ID for node 1, core 6
03.872: * AP 0estopped
03.872: get_boot_apic_id: using 15 as APIC ID for node 1, core 7
03.872: * AP 0fstopped
03.872: get_boot_apic_id: using 33 as APIC ID for node 2, core 1
03.872: * AP 21stopped
03.872: get_boot_apic_id: using 34 as APIC ID for node 2, core 2
03.872: * AP 22stopped
03.872: get_boot_apic_id: using 35 as APIC ID for node 2, core 3
03.872: * AP 23stopped
03.872: get_boot_apic_id: using 36 as APIC ID for node 2, core 4
03.872: * AP 24stopped
03.872: get_boot_apic_id: using 37 as APIC ID for node 2, core 5
03.872: * AP 25stopped
03.872: get_boot_apic_id: using 38 as APIC ID for node 2, core 6
03.872: * AP 26stopped
03.872: get_boot_apic_id: using 39 as APIC ID for node 2, core 7
03.872: * AP 27stopped
03.873: get_boot_apic_id: using 41 as APIC ID for node 3, core 1
03.872: * AP 29stopped
03.873: get_boot_apic_id: using 42 as APIC ID for node 3, core 2
03.873: * AP 2astopped
03.873: get_boot_apic_id: using 43 as APIC ID for node 3, core 3
03.873: * AP 2bstopped
03.873: get_boot_apic_id: using 44 as APIC ID for node 3, core 4
03.873: * AP 2cstopped
03.873: get_boot_apic_id: using 45 as APIC ID for node 3, core 5
03.873: * AP 2dstopped
03.873: get_boot_apic_id: using 46 as APIC ID for node 3, core 6
03.873: * AP 2estopped
03.873: get_boot_apic_id: using 47 as APIC ID for node 3, core 7
03.873: * AP 2fstopped
03.873:=20
03.873: fill_mem_ctrl() detected 4 nodes
03.873: raminit_amdmct()
03.873: raminit_amdmct begin:
03.875: FMAP: area COREBOOT found @ 200 (2096640 bytes)
03.875: CBFS: Locating 'cmos_layout.bin'
03.875: CBFS: Found @ offset 2adc0 size dc4
03.876: mctAutoInitMCT_D: mct_init Node 0
03.877: mctAutoInitMCT_D: mct_InitialMCT_D
03.877: mct_InitialMCT_D: mct_ForceNBPState0_En_Fam15
03.877: mctAutoInitMCT_D: mctSMBhub_Init
03.877: activate_spd_rom() for node 00
03.877: enable_spd_node0()
03.878: mctAutoInitMCT_D: mct_preInitDCT
03.880: FMAP: area COREBOOT found @ 200 (2096640 bytes)
03.880: CBFS: Locating 'cmos_layout.bin'
03.880: CBFS: Found @ offset 2adc0 size dc4
04.687: <09> DIMMPresence: DIMMValid=3Dc
04.687: <09> DIMMPresence: DIMMPresent=3Dc
04.687: <09> DIMMPresence: RegDIMMPresent=3Dc
04.687: <09> DIMMPresence: LRDIMMPresent=3D0
04.687: <09> DIMMPresence: DimmECCPresent=3Dc
04.687: <09> DIMMPresence: DimmPARPresent=3D0
04.687: <09> DIMMPresence: Dimmx4Present=3Dc
04.687: <09> DIMMPresence: Dimmx8Present=3D0
04.687: <09> DIMMPresence: Dimmx16Present=3D0
04.687: <09> DIMMPresence: DimmPlPresent=3D0
04.687: <09> DIMMPresence: DimmDRPresent=3Dc
04.687: <09> DIMMPresence: DimmQRPresent=3D0
04.687: <09> DIMMPresence: DATAload[0]=3D2
04.687: <09> DIMMPresence: MAload[0]=3D20
04.687: <09> DIMMPresence: MAdimms[0]=3D1
04.687: <09> DIMMPresence: DATAload[1]=3D2
04.688: <09> DIMMPresence: MAload[1]=3D20
04.688: <09> DIMMPresence: MAdimms[1]=3D1
04.688: <09> DIMMPresence: Status 2005
04.688: <09> DIMMPresence: ErrStatus 0
04.688: <09> DIMMPresence: ErrCode 0
04.688: <09> DIMMPresence: Done
04.688:=20
04.688: <09><09>DCTPreInit_D: mct_DIMMPresence Done
04.689: CBFS: 'Master Header Locator' located CBFS at [200:200000)
04.689: CBFS: Locating 's3nv'
04.689: CBFS: Found @ offset 2fdc0 size 10000
04.689: CBFS: 'Master Header Locator' located CBFS at [200:200000)
04.689: CBFS: Locating 's3nv'
04.689: CBFS: Found @ offset 2fdc0 size 10000
04.690: FMAP: area COREBOOT found @ 200 (2096640 bytes)
04.690: CBFS: Locating 'cmos_layout.bin'
04.690: CBFS: Found @ offset 2adc0 size dc4
04.691: FMAP: area COREBOOT found @ 200 (2096640 bytes)
04.691: CBFS: Locating 'cmos_layout.bin'
04.691: CBFS: Found @ offset 2adc0 size dc4
04.691: FMAP: area COREBOOT found @ 200 (2096640 bytes)
04.691: CBFS: Locating 'cmos_layout.bin'
04.691: CBFS: Found @ offset 2adc0 size dc4
04.692: FMAP: area COREBOOT found @ 200 (2096640 bytes)
04.692: CBFS: Locating 'cmos_layout.bin'
04.692: CBFS: Found @ offset 2adc0 size dc4
04.692: FMAP: area COREBOOT found @ 200 (2096640 bytes)
04.692: CBFS: Locating 'cmos_layout.bin'
04.692: CBFS: Found @ offset 2adc0 size dc4
04.692: FMAP: area COREBOOT found @ 200 (2096640 bytes)
04.693: CBFS: Locating 'cmos_layout.bin'
04.693: CBFS: Found @ offset 2adc0 size dc4
04.693: FMAP: area COREBOOT found @ 200 (2096640 bytes)
04.693: CBFS: Locating 'cmos_layout.bin'
04.693: CBFS: Found @ offset 2adc0 size dc4
04.693: FMAP: area COREBOOT found @ 200 (2096640 bytes)
04.693: CBFS: Locating 'cmos_layout.bin'
04.693: CBFS: Found @ offset 2adc0 size dc4
04.693: FMAP: area COREBOOT found @ 200 (2096640 bytes)
04.693: CBFS: Locating 'cmos_layout.bin'
04.694: CBFS: Found @ offset 2adc0 size dc4
04.694: FMAP: area COREBOOT found @ 200 (2096640 bytes)
04.694: CBFS: Locating 'cmos_layout.bin'
04.694: CBFS: Found @ offset 2adc0 size dc4
04.694: FMAP: area COREBOOT found @ 200 (2096640 bytes)
04.694: CBFS: Locating 'cmos_layout.bin'
04.694: CBFS: Found @ offset 2adc0 size dc4
04.695: mctAutoInitMCT_D: mct_init Node 1
04.695: mctAutoInitMCT_D: mct_InitialMCT_D
04.695: mct_InitialMCT_D: mct_ForceNBPState0_En_Fam15
04.695: mctAutoInitMCT_D: mctSMBhub_Init
04.695: activate_spd_rom() for node 01
04.695: enable_spd_node1()
04.695: mctAutoInitMCT_D: mct_preInitDCT
04.695: FMAP: area COREBOOT found @ 200 (2096640 bytes)
04.695: CBFS: Locating 'cmos_layout.bin'
04.695: CBFS: Found @ offset 2adc0 size dc4
05.502: <09> DIMMPresence: DIMMValid=3Dc
05.502: <09> DIMMPresence: DIMMPresent=3Dc
05.502: <09> DIMMPresence: RegDIMMPresent=3Dc
05.502: <09> DIMMPresence: LRDIMMPresent=3D0
05.502: <09> DIMMPresence: DimmECCPresent=3Dc
05.502: <09> DIMMPresence: DimmPARPresent=3D0
05.502: <09> DIMMPresence: Dimmx4Present=3Dc
05.502: <09> DIMMPresence: Dimmx8Present=3D0
05.502: <09> DIMMPresence: Dimmx16Present=3D0
05.502: <09> DIMMPresence: DimmPlPresent=3D0
05.502: <09> DIMMPresence: DimmDRPresent=3Dc
05.502: <09> DIMMPresence: DimmQRPresent=3D0
05.502: <09> DIMMPresence: DATAload[0]=3D2
05.502: <09> DIMMPresence: MAload[0]=3D20
05.502: <09> DIMMPresence: MAdimms[0]=3D1
05.502: <09> DIMMPresence: DATAload[1]=3D2
05.502: <09> DIMMPresence: MAload[1]=3D20
05.502: <09> DIMMPresence: MAdimms[1]=3D1
05.502: <09> DIMMPresence: Status 2005
05.502: <09> DIMMPresence: ErrStatus 0
05.502: <09> DIMMPresence: ErrCode 0
05.502: <09> DIMMPresence: Done
05.502:=20
05.502: <09><09>DCTPreInit_D: mct_DIMMPresence Done
05.502: CBFS: 'Master Header Locator' located CBFS at [200:200000)
05.502: CBFS: Locating 's3nv'
05.503: CBFS: Found @ offset 2fdc0 size 10000
05.503: CBFS: 'Master Header Locator' located CBFS at [200:200000)
05.503: CBFS: Locating 's3nv'
05.503: CBFS: Found @ offset 2fdc0 size 10000
05.503: FMAP: area COREBOOT found @ 200 (2096640 bytes)
05.503: CBFS: Locating 'cmos_layout.bin'
05.503: CBFS: Found @ offset 2adc0 size dc4
05.504: FMAP: area COREBOOT found @ 200 (2096640 bytes)
05.504: CBFS: Locating 'cmos_layout.bin'
05.504: CBFS: Found @ offset 2adc0 size dc4
05.504: FMAP: area COREBOOT found @ 200 (2096640 bytes)
05.504: CBFS: Locating 'cmos_layout.bin'
05.504: CBFS: Found @ offset 2adc0 size dc4
05.505: FMAP: area COREBOOT found @ 200 (2096640 bytes)
05.505: CBFS: Locating 'cmos_layout.bin'
05.505: CBFS: Found @ offset 2adc0 size dc4
05.505: FMAP: area COREBOOT found @ 200 (2096640 bytes)
05.505: CBFS: Locating 'cmos_layout.bin'
05.505: CBFS: Found @ offset 2adc0 size dc4
05.505: FMAP: area COREBOOT found @ 200 (2096640 bytes)
05.505: CBFS: Locating 'cmos_layout.bin'
05.505: CBFS: Found @ offset 2adc0 size dc4
05.506: FMAP: area COREBOOT found @ 200 (2096640 bytes)
05.506: CBFS: Locating 'cmos_layout.bin'
05.506: CBFS: Found @ offset 2adc0 size dc4
05.506: FMAP: area COREBOOT found @ 200 (2096640 bytes)
05.506: CBFS: Locating 'cmos_layout.bin'
05.506: CBFS: Found @ offset 2adc0 size dc4
05.506: FMAP: area COREBOOT found @ 200 (2096640 bytes)
05.506: CBFS: Locating 'cmos_layout.bin'
05.507: CBFS: Found @ offset 2adc0 size dc4
05.507: FMAP: area COREBOOT found @ 200 (2096640 bytes)
05.507: CBFS: Locating 'cmos_layout.bin'
05.507: CBFS: Found @ offset 2adc0 size dc4
05.507: FMAP: area COREBOOT found @ 200 (2096640 bytes)
05.507: CBFS: Locating 'cmos_layout.bin'
05.507: CBFS: Found @ offset 2adc0 size dc4
05.508: mctAutoInitMCT_D: mct_init Node 2
05.508: mctAutoInitMCT_D: mct_InitialMCT_D
05.508: mct_InitialMCT_D: mct_ForceNBPState0_En_Fam15
05.508: mctAutoInitMCT_D: mctSMBhub_Init
05.508: activate_spd_rom() for node 02
05.508: enable_spd_node2()
05.508: mctAutoInitMCT_D: mct_preInitDCT
05.508: FMAP: area COREBOOT found @ 200 (2096640 bytes)
05.508: CBFS: Locating 'cmos_layout.bin'
05.508: CBFS: Found @ offset 2adc0 size dc4
06.315: <09> DIMMPresence: DIMMValid=3Dc
06.315: <09> DIMMPresence: DIMMPresent=3Dc
06.315: <09> DIMMPresence: RegDIMMPresent=3Dc
06.315: <09> DIMMPresence: LRDIMMPresent=3D0
06.315: <09> DIMMPresence: DimmECCPresent=3Dc
06.315: <09> DIMMPresence: DimmPARPresent=3D0
06.315: <09> DIMMPresence: Dimmx4Present=3Dc
06.315: <09> DIMMPresence: Dimmx8Present=3D0
06.315: <09> DIMMPresence: Dimmx16Present=3D0
06.315: <09> DIMMPresence: DimmPlPresent=3D0
06.315: <09> DIMMPresence: DimmDRPresent=3Dc
06.315: <09> DIMMPresence: DimmQRPresent=3D0
06.315: <09> DIMMPresence: DATAload[0]=3D2
06.315: <09> DIMMPresence: MAload[0]=3D20
06.315: <09> DIMMPresence: MAdimms[0]=3D1
06.315: <09> DIMMPresence: DATAload[1]=3D2
06.315: <09> DIMMPresence: MAload[1]=3D20
06.315: <09> DIMMPresence: MAdimms[1]=3D1
06.315: <09> DIMMPresence: Status 2005
06.315: <09> DIMMPresence: ErrStatus 0
06.315: <09> DIMMPresence: ErrCode 0
06.315: <09> DIMMPresence: Done
06.315:=20
06.315: <09><09>DCTPreInit_D: mct_DIMMPresence Done
06.315: CBFS: 'Master Header Locator' located CBFS at [200:200000)
06.315: CBFS: Locating 's3nv'
06.315: CBFS: Found @ offset 2fdc0 size 10000
06.315: CBFS: 'Master Header Locator' located CBFS at [200:200000)
06.315: CBFS: Locating 's3nv'
06.315: CBFS: Found @ offset 2fdc0 size 10000
06.315: FMAP: area COREBOOT found @ 200 (2096640 bytes)
06.315: CBFS: Locating 'cmos_layout.bin'
06.315: CBFS: Found @ offset 2adc0 size dc4
06.316: FMAP: area COREBOOT found @ 200 (2096640 bytes)
06.316: CBFS: Locating 'cmos_layout.bin'
06.316: CBFS: Found @ offset 2adc0 size dc4
06.316: FMAP: area COREBOOT found @ 200 (2096640 bytes)
06.317: CBFS: Locating 'cmos_layout.bin'
06.316: CBFS: Found @ offset 2adc0 size dc4
06.317: FMAP: area COREBOOT found @ 200 (2096640 bytes)
06.317: CBFS: Locating 'cmos_layout.bin'
06.317: CBFS: Found @ offset 2adc0 size dc4
06.317: FMAP: area COREBOOT found @ 200 (2096640 bytes)
06.317: CBFS: Locating 'cmos_layout.bin'
06.317: CBFS: Found @ offset 2adc0 size dc4
06.317: FMAP: area COREBOOT found @ 200 (2096640 bytes)
06.318: CBFS: Locating 'cmos_layout.bin'
06.317: CBFS: Found @ offset 2adc0 size dc4
06.318: FMAP: area COREBOOT found @ 200 (2096640 bytes)
06.318: CBFS: Locating 'cmos_layout.bin'
06.318: CBFS: Found @ offset 2adc0 size dc4
06.318: FMAP: area COREBOOT found @ 200 (2096640 bytes)
06.318: CBFS: Locating 'cmos_layout.bin'
06.318: CBFS: Found @ offset 2adc0 size dc4
06.318: FMAP: area COREBOOT found @ 200 (2096640 bytes)
06.318: CBFS: Locating 'cmos_layout.bin'
06.318: CBFS: Found @ offset 2adc0 size dc4
06.318: FMAP: area COREBOOT found @ 200 (2096640 bytes)
06.318: CBFS: Locating 'cmos_layout.bin'
06.318: CBFS: Found @ offset 2adc0 size dc4
06.319: FMAP: area COREBOOT found @ 200 (2096640 bytes)
06.319: CBFS: Locating 'cmos_layout.bin'
06.319: CBFS: Found @ offset 2adc0 size dc4
06.319: mctAutoInitMCT_D: mct_init Node 3
06.319: mctAutoInitMCT_D: mct_InitialMCT_D
06.319: mct_InitialMCT_D: mct_ForceNBPState0_En_Fam15
06.319: mctAutoInitMCT_D: mctSMBhub_Init
06.319: activate_spd_rom() for node 03
06.319: enable_spd_node3()
06.320: mctAutoInitMCT_D: mct_preInitDCT
06.320: FMAP: area COREBOOT found @ 200 (2096640 bytes)
06.320: CBFS: Locating 'cmos_layout.bin'
06.320: CBFS: Found @ offset 2adc0 size dc4
07.126: <09> DIMMPresence: DIMMValid=3Dc
07.126: <09> DIMMPresence: DIMMPresent=3Dc
07.126: <09> DIMMPresence: RegDIMMPresent=3Dc
07.126: <09> DIMMPresence: LRDIMMPresent=3D0
07.126: <09> DIMMPresence: DimmECCPresent=3Dc
07.126: <09> DIMMPresence: DimmPARPresent=3D0
07.126: <09> DIMMPresence: Dimmx4Present=3Dc
07.126: <09> DIMMPresence: Dimmx8Present=3D0
07.126: <09> DIMMPresence: Dimmx16Present=3D0
07.126: <09> DIMMPresence: DimmPlPresent=3D0
07.126: <09> DIMMPresence: DimmDRPresent=3Dc
07.126: <09> DIMMPresence: DimmQRPresent=3D0
07.126: <09> DIMMPresence: DATAload[0]=3D2
07.126: <09> DIMMPresence: MAload[0]=3D20
07.126: <09> DIMMPresence: MAdimms[0]=3D1
07.126: <09> DIMMPresence: DATAload[1]=3D2
07.126: <09> DIMMPresence: MAload[1]=3D20
07.126: <09> DIMMPresence: MAdimms[1]=3D1
07.126: <09> DIMMPresence: Status 2005
07.126: <09> DIMMPresence: ErrStatus 0
07.126: <09> DIMMPresence: ErrCode 0
07.126: <09> DIMMPresence: Done
07.126:=20
07.126: <09><09>DCTPreInit_D: mct_DIMMPresence Done
07.126: CBFS: 'Master Header Locator' located CBFS at [200:200000)
07.127: CBFS: Locating 's3nv'
07.127: CBFS: Found @ offset 2fdc0 size 10000
07.127: CBFS: 'Master Header Locator' located CBFS at [200:200000)
07.127: CBFS: Locating 's3nv'
07.127: CBFS: Found @ offset 2fdc0 size 10000
07.127: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.127: CBFS: Locating 'cmos_layout.bin'
07.127: CBFS: Found @ offset 2adc0 size dc4
07.128: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.128: CBFS: Locating 'cmos_layout.bin'
07.128: CBFS: Found @ offset 2adc0 size dc4
07.128: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.128: CBFS: Locating 'cmos_layout.bin'
07.128: CBFS: Found @ offset 2adc0 size dc4
07.129: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.129: CBFS: Locating 'cmos_layout.bin'
07.129: CBFS: Found @ offset 2adc0 size dc4
07.129: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.129: CBFS: Locating 'cmos_layout.bin'
07.129: CBFS: Found @ offset 2adc0 size dc4
07.129: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.129: CBFS: Locating 'cmos_layout.bin'
07.129: CBFS: Found @ offset 2adc0 size dc4
07.130: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.130: CBFS: Locating 'cmos_layout.bin'
07.130: CBFS: Found @ offset 2adc0 size dc4
07.130: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.130: CBFS: Locating 'cmos_layout.bin'
07.130: CBFS: Found @ offset 2adc0 size dc4
07.130: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.130: CBFS: Locating 'cmos_layout.bin'
07.131: CBFS: Found @ offset 2adc0 size dc4
07.131: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.131: CBFS: Locating 'cmos_layout.bin'
07.131: CBFS: Found @ offset 2adc0 size dc4
07.131: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.131: CBFS: Locating 'cmos_layout.bin'
07.131: CBFS: Found @ offset 2adc0 size dc4
07.132: mctAutoInitMCT_D: mct_init Node 4
07.132: mctAutoInitMCT_D: mct_init Node 5
07.132: mctAutoInitMCT_D: mct_init Node 6
07.132: mctAutoInitMCT_D: mct_init Node 7
07.132: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.132: CBFS: Locating 'cmos_layout.bin'
07.133: CBFS: Found @ offset 2adc0 size dc4
07.134: mctAutoInitMCT_D: DIMMSetVoltage
07.134: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.134: CBFS: Locating 'cmos_layout.bin'
07.134: CBFS: Found @ offset 2adc0 size dc4
07.135: Node 00 DIMM voltage set to index 00
07.135: Node 01 DIMM voltage set to index 00
07.235: mctAutoInitMCT_D: mctSMBhub_Init
07.235: activate_spd_rom() for node 00
07.235: enable_spd_node0()
07.235: mctAutoInitMCT_D: mct_initDCT
07.235: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.235: CBFS: Locating 'cmos_layout.bin'
07.236: CBFS: Found @ offset 2adc0 size dc4
07.236: SPDCalcWidth: Status 2005
07.236: SPDCalcWidth: ErrStatus 0
07.236: SPDCalcWidth: ErrCode 0
07.236: SPDCalcWidth: Done
07.236: <09><09>DCTInit_D: mct_SPDCalcWidth Done
07.236: AutoCycTiming_D: Start
07.237: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.237: CBFS: Locating 'cmos_layout.bin'
07.237: CBFS: Found @ offset 2adc0 size dc4
07.238: GetPresetmaxF_D: Start
07.238: GetPresetmaxF_D: Done
07.238: SPDGetTCL_D: Start
07.238: SPDGetTCL_D: DIMMCASL 5
07.238: SPDGetTCL_D: DIMMAutoSpeed 4
07.238: SPDGetTCL_D: Status 2005
07.238: SPDGetTCL_D: ErrStatus 0
07.238: SPDGetTCL_D: ErrCode 0
07.238: SPDGetTCL_D: Done
07.238:=20
07.238: SPD2ndTiming: Start
07.240: SPD2ndTiming: Done
07.240: AutoCycTiming: Status 2005
07.240: AutoCycTiming: ErrStatus 0
07.240: AutoCycTiming: ErrCode 0
07.240: AutoCycTiming: Done
07.240:=20
07.240: <09><09>DCTInit_D: AutoCycTiming_D Done
07.242: SPDSetBanks: CSPresent c
07.242: SPDSetBanks: Status 2005
07.242: SPDSetBanks: ErrStatus 0
07.242: SPDSetBanks: ErrCode 0
07.242: SPDSetBanks: Done
07.242:=20
07.243: AfterStitch pDCTstat->NodeSysBase =3D 0
07.243: mct_AfterStitchMemory: pDCTstat->NodeSysLimit =3D 3ffffff
07.243: StitchMemory: Status 2005
07.243: StitchMemory: ErrStatus 0
07.243: StitchMemory: ErrCode 0
07.243: StitchMemory: Done
07.243:=20
07.243: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.243: CBFS: Locating 'cmos_layout.bin'
07.243: CBFS: Found @ offset 2adc0 size dc4
07.244: InterleaveBanks_D: Status 2005
07.244: InterleaveBanks_D: ErrStatus 0
07.244: InterleaveBanks_D: ErrCode 0
07.244: InterleaveBanks_D: Done
07.244:=20
07.245: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.245: CBFS: Locating 'cmos_layout.bin'
07.245: CBFS: Found @ offset 2adc0 size dc4
07.246: AutoConfig_D: DramControl:     00002a06
07.246: AutoConfig_D: DramTimingLo:    00000000
07.246: AutoConfig_D: DramConfigMisc:  00000000
07.246: AutoConfig_D: DramConfigMisc2: 00000000
07.246: AutoConfig_D: DramConfigLo:    03082000
07.246: AutoConfig_D: DramConfigHi:    0f090084
07.247: InitDDRPhy: Start
07.247: InitDDRPhy: Done
07.247: mct_SetDramConfigHi_D: Start
07.249: set_2t_configuration: Start
07.249: set_2t_configuration: Done
07.249: mct_BeforePlatformSpec: Start
07.249: mct_BeforePlatformSpec: Done
07.249: mct_PlatformSpec: Start
07.249: mct_PlatformSpec: Done
07.249: mct_SetDramConfigHi_D: DramConfigHi:    0f090084
07.249: *
07.249: mct_SetDramConfigHi_D: Done
07.250: mct_EarlyArbEn_D: Start
07.249: mct_EarlyArbEn_D: Done
07.250: AutoConfig: Status 2005
07.250: AutoConfig: ErrStatus 0
07.250: AutoConfig: ErrCode 0
07.250: AutoConfig: Done
07.250:=20
07.250: <09><09>DCTInit_D: AutoConfig_D Done
07.250: <09><09>DCTInit_D: PlatformSpec_D Done
07.250: <09><09>DCTFinalInit_D: StartupDCT_D Start
07.250: mct_BeforeDramInit_Prod_D: Start
07.250: mct_ProgramODT_D: Start
07.251: mct_ProgramODT_D: Done
07.251: mct_BeforeDramInit_Prod_D: Done
07.251: mct_DramInit_Sw_D: Start
07.252: mct_DCTAccessDone: Start
07.252: mct_DCTAccessDone: Done
07.256: DIMM 1 RttWr: 0
07.256: mct_SendMrsCmd: Start
07.256: mct_SendMrsCmd: Done
07.256: mct_SendMrsCmd: Start
07.256: mct_SendMrsCmd: Done
07.256: DIMM 1 RttNom: 2
07.257: mct_SendMrsCmd: Start
07.257: mct_SendMrsCmd: Done
07.257: mct_SendMrsCmd: Start
07.257: mct_SendMrsCmd: Done
07.257: DIMM 1 RttWr: 0
07.257: mct_SendMrsCmd: Start
07.257: mct_SendMrsCmd: Done
07.257: mct_SendMrsCmd: Start
07.257: mct_SendMrsCmd: Done
07.257: DIMM 1 RttNom: 2
07.257: mct_SendMrsCmd: Start
07.257: mct_SendMrsCmd: Done
07.257: mct_SendMrsCmd: Start
07.257: mct_SendMrsCmd: Done
07.257: mct_SendZQCmd: Start
07.257: mct_SendZQCmd: Done
07.257: mct_SendZQCmd: Start
07.257: mct_SendZQCmd: Done
07.257: mct_DCTAccessDone: Start
07.257: mct_DCTAccessDone: Done
07.258: mct_DramInit_Sw_D: Done
07.258: <09><09>DCTFinalInit_D: StartupDCT_D Done
07.258: SPDCalcWidth: Status 2005
07.258: SPDCalcWidth: ErrStatus 0
07.258: SPDCalcWidth: ErrCode 0
07.258: SPDCalcWidth: Done
07.258: <09><09>DCTInit_D: mct_SPDCalcWidth Done
07.258: AutoCycTiming_D: Start
07.258: SPD2ndTiming: Start
07.258: SPD2ndTiming: Done
07.258: AutoCycTiming: Status 2005
07.258: AutoCycTiming: ErrStatus 0
07.258: AutoCycTiming: ErrCode 0
07.258: AutoCycTiming: Done
07.258:=20
07.258: <09><09>DCTInit_D: AutoCycTiming_D Done
07.259: <09><09>DCTInit_D: enabling intra-channel clock skew
07.259: SPDSetBanks: CSPresent c
07.259: SPDSetBanks: Status 2005
07.259: SPDSetBanks: ErrStatus 0
07.259: SPDSetBanks: ErrCode 0
07.259: SPDSetBanks: Done
07.259:=20
07.259: AfterStitch pDCTstat->NodeSysBase =3D 0
07.259: mct_AfterStitchMemory: pDCTstat->NodeSysLimit =3D 7fffffe
07.259: StitchMemory: Status 2005
07.259: StitchMemory: ErrStatus 0
07.259: StitchMemory: ErrCode 0
07.259: StitchMemory: Done
07.259:=20
07.260: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.260: CBFS: Locating 'cmos_layout.bin'
07.260: CBFS: Found @ offset 2adc0 size dc4
07.260: InterleaveBanks_D: Status 2005
07.260: InterleaveBanks_D: ErrStatus 0
07.260: InterleaveBanks_D: ErrCode 0
07.260: InterleaveBanks_D: Done
07.260:=20
07.261: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.261: CBFS: Locating 'cmos_layout.bin'
07.261: CBFS: Found @ offset 2adc0 size dc4
07.261: AutoConfig_D: DramControl:     00002a06
07.261: AutoConfig_D: DramTimingLo:    00000000
07.261: AutoConfig_D: DramConfigMisc:  00000000
07.261: AutoConfig_D: DramConfigMisc2: 00000000
07.261: AutoConfig_D: DramConfigLo:    03082000
07.261: AutoConfig_D: DramConfigHi:    0f090084
07.261: InitDDRPhy: Start
07.261: InitDDRPhy: Done
07.261: mct_SetDramConfigHi_D: Start
07.261: set_2t_configuration: Start
07.261: set_2t_configuration: Done
07.262: mct_BeforePlatformSpec: Start
07.262: mct_BeforePlatformSpec: Done
07.262: mct_PlatformSpec: Start
07.262: mct_PlatformSpec: Done
07.262: mct_SetDramConfigHi_D: DramConfigHi:    0f090084
07.262: *
07.262: mct_SetDramConfigHi_D: Done
07.262: mct_EarlyArbEn_D: Start
07.262: mct_EarlyArbEn_D: Done
07.262: AutoConfig: Status 2005
07.262: AutoConfig: ErrStatus 0
07.262: AutoConfig: ErrCode 0
07.262: AutoConfig: Done
07.262:=20
07.262: <09><09>DCTInit_D: AutoConfig_D Done
07.262: <09><09>DCTInit_D: PlatformSpec_D Done
07.262: <09><09>DCTFinalInit_D: StartupDCT_D Start
07.262: mct_BeforeDramInit_Prod_D: Start
07.262: mct_ProgramODT_D: Start
07.262: mct_ProgramODT_D: Done
07.262: mct_BeforeDramInit_Prod_D: Done
07.262: mct_DramInit_Sw_D: Start
07.263: mct_DCTAccessDone: Start
07.262: mct_DCTAccessDone: Done
07.264: DIMM 1 RttWr: 0
07.264: mct_SendMrsCmd: Start
07.264: mct_SendMrsCmd: Done
07.264: mct_SendMrsCmd: Start
07.264: mct_SendMrsCmd: Done
07.264: DIMM 1 RttNom: 2
07.264: mct_SendMrsCmd: Start
07.264: mct_SendMrsCmd: Done
07.265: mct_SendMrsCmd: Start
07.265: mct_SendMrsCmd: Done
07.265: DIMM 1 RttWr: 0
07.265: mct_SendMrsCmd: Start
07.265: mct_SendMrsCmd: Done
07.265: mct_SendMrsCmd: Start
07.265: mct_SendMrsCmd: Done
07.265: DIMM 1 RttNom: 2
07.265: mct_SendMrsCmd: Start
07.265: mct_SendMrsCmd: Done
07.265: mct_SendMrsCmd: Start
07.265: mct_SendMrsCmd: Done
07.265: mct_SendZQCmd: Start
07.265: mct_SendZQCmd: Done
07.265: mct_SendZQCmd: Start
07.265: mct_SendZQCmd: Done
07.265: mct_DCTAccessDone: Start
07.265: mct_DCTAccessDone: Done
07.265: mct_DramInit_Sw_D: Done
07.265: <09><09>DCTFinalInit_D: StartupDCT_D Done
07.265: mctAutoInitMCT_D: mctSMBhub_Init
07.265: activate_spd_rom() for node 01
07.265: enable_spd_node1()
07.265: mctAutoInitMCT_D: mct_initDCT
07.266: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.266: CBFS: Locating 'cmos_layout.bin'
07.266: CBFS: Found @ offset 2adc0 size dc4
07.266: SPDCalcWidth: Status 2005
07.266: SPDCalcWidth: ErrStatus 0
07.266: SPDCalcWidth: ErrCode 0
07.266: SPDCalcWidth: Done
07.266: <09><09>DCTInit_D: mct_SPDCalcWidth Done
07.266: AutoCycTiming_D: Start
07.266: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.266: CBFS: Locating 'cmos_layout.bin'
07.266: CBFS: Found @ offset 2adc0 size dc4
07.267: GetPresetmaxF_D: Start
07.267: GetPresetmaxF_D: Done
07.267: SPDGetTCL_D: Start
07.267: SPDGetTCL_D: DIMMCASL 5
07.267: SPDGetTCL_D: DIMMAutoSpeed 4
07.267: SPDGetTCL_D: Status 2005
07.267: SPDGetTCL_D: ErrStatus 0
07.267: SPDGetTCL_D: ErrCode 0
07.267: SPDGetTCL_D: Done
07.267:=20
07.267: SPD2ndTiming: Start
07.267: SPD2ndTiming: Done
07.267: AutoCycTiming: Status 2005
07.267: AutoCycTiming: ErrStatus 0
07.267: AutoCycTiming: ErrCode 0
07.267: AutoCycTiming: Done
07.267:=20
07.267: <09><09>DCTInit_D: AutoCycTiming_D Done
07.268: SPDSetBanks: CSPresent c
07.268: SPDSetBanks: Status 2005
07.268: SPDSetBanks: ErrStatus 0
07.268: SPDSetBanks: ErrCode 0
07.268: SPDSetBanks: Done
07.268:=20
07.268: AfterStitch pDCTstat->NodeSysBase =3D 0
07.268: mct_AfterStitchMemory: pDCTstat->NodeSysLimit =3D 3ffffff
07.268: StitchMemory: Status 2005
07.268: StitchMemory: ErrStatus 0
07.268: StitchMemory: ErrCode 0
07.268: StitchMemory: Done
07.268:=20
07.268: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.268: CBFS: Locating 'cmos_layout.bin'
07.268: CBFS: Found @ offset 2adc0 size dc4
07.269: InterleaveBanks_D: Status 2005
07.269: InterleaveBanks_D: ErrStatus 0
07.269: InterleaveBanks_D: ErrCode 0
07.269: InterleaveBanks_D: Done
07.269:=20
07.269: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.269: CBFS: Locating 'cmos_layout.bin'
07.269: CBFS: Found @ offset 2adc0 size dc4
07.269: AutoConfig_D: DramControl:     00002a06
07.269: AutoConfig_D: DramTimingLo:    00000000
07.269: AutoConfig_D: DramConfigMisc:  00000000
07.269: AutoConfig_D: DramConfigMisc2: 00000000
07.269: AutoConfig_D: DramConfigLo:    03082000
07.269: AutoConfig_D: DramConfigHi:    0f090084
07.270: InitDDRPhy: Start
07.270: InitDDRPhy: Done
07.270: mct_SetDramConfigHi_D: Start
07.270: set_2t_configuration: Start
07.270: set_2t_configuration: Done
07.270: mct_BeforePlatformSpec: Start
07.270: mct_BeforePlatformSpec: Done
07.270: mct_PlatformSpec: Start
07.270: mct_PlatformSpec: Done
07.270: mct_SetDramConfigHi_D: DramConfigHi:    0f090084
07.270: *
07.270: mct_SetDramConfigHi_D: Done
07.270: mct_EarlyArbEn_D: Start
07.270: mct_EarlyArbEn_D: Done
07.270: AutoConfig: Status 2005
07.270: AutoConfig: ErrStatus 0
07.270: AutoConfig: ErrCode 0
07.270: AutoConfig: Done
07.270:=20
07.270: <09><09>DCTInit_D: AutoConfig_D Done
07.270: <09><09>DCTInit_D: PlatformSpec_D Done
07.270: <09><09>DCTFinalInit_D: StartupDCT_D Start
07.270: mct_BeforeDramInit_Prod_D: Start
07.270: mct_ProgramODT_D: Start
07.270: mct_ProgramODT_D: Done
07.270: mct_BeforeDramInit_Prod_D: Done
07.270: mct_DramInit_Sw_D: Start
07.270: mct_DCTAccessDone: Start
07.270: mct_DCTAccessDone: Done
07.272: DIMM 1 RttWr: 0
07.272: mct_SendMrsCmd: Start
07.272: mct_SendMrsCmd: Done
07.272: mct_SendMrsCmd: Start
07.272: mct_SendMrsCmd: Done
07.273: DIMM 1 RttNom: 2
07.273: mct_SendMrsCmd: Start
07.273: mct_SendMrsCmd: Done
07.273: mct_SendMrsCmd: Start
07.273: mct_SendMrsCmd: Done
07.273: DIMM 1 RttWr: 0
07.273: mct_SendMrsCmd: Start
07.273: mct_SendMrsCmd: Done
07.273: mct_SendMrsCmd: Start
07.273: mct_SendMrsCmd: Done
07.273: DIMM 1 RttNom: 2
07.273: mct_SendMrsCmd: Start
07.273: mct_SendMrsCmd: Done
07.273: mct_SendMrsCmd: Start
07.273: mct_SendMrsCmd: Done
07.273: mct_SendZQCmd: Start
07.273: mct_SendZQCmd: Done
07.273: mct_SendZQCmd: Start
07.273: mct_SendZQCmd: Done
07.273: mct_DCTAccessDone: Start
07.273: mct_DCTAccessDone: Done
07.273: mct_DramInit_Sw_D: Done
07.273: <09><09>DCTFinalInit_D: StartupDCT_D Done
07.274: SPDCalcWidth: Status 2005
07.274: SPDCalcWidth: ErrStatus 0
07.274: SPDCalcWidth: ErrCode 0
07.274: SPDCalcWidth: Done
07.274: <09><09>DCTInit_D: mct_SPDCalcWidth Done
07.274: AutoCycTiming_D: Start
07.274: SPD2ndTiming: Start
07.274: SPD2ndTiming: Done
07.274: AutoCycTiming: Status 2005
07.274: AutoCycTiming: ErrStatus 0
07.274: AutoCycTiming: ErrCode 0
07.274: AutoCycTiming: Done
07.274:=20
07.274: <09><09>DCTInit_D: AutoCycTiming_D Done
07.274: <09><09>DCTInit_D: enabling intra-channel clock skew
07.275: SPDSetBanks: CSPresent c
07.275: SPDSetBanks: Status 2005
07.275: SPDSetBanks: ErrStatus 0
07.275: SPDSetBanks: ErrCode 0
07.275: SPDSetBanks: Done
07.275:=20
07.275: AfterStitch pDCTstat->NodeSysBase =3D 0
07.275: mct_AfterStitchMemory: pDCTstat->NodeSysLimit =3D 7fffffe
07.275: StitchMemory: Status 2005
07.275: StitchMemory: ErrStatus 0
07.275: StitchMemory: ErrCode 0
07.275: StitchMemory: Done
07.275:=20
07.275: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.275: CBFS: Locating 'cmos_layout.bin'
07.275: CBFS: Found @ offset 2adc0 size dc4
07.276: InterleaveBanks_D: Status 2005
07.276: InterleaveBanks_D: ErrStatus 0
07.276: InterleaveBanks_D: ErrCode 0
07.276: InterleaveBanks_D: Done
07.276:=20
07.276: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.276: CBFS: Locating 'cmos_layout.bin'
07.276: CBFS: Found @ offset 2adc0 size dc4
07.276: AutoConfig_D: DramControl:     00002a06
07.276: AutoConfig_D: DramTimingLo:    00000000
07.276: AutoConfig_D: DramConfigMisc:  00000000
07.276: AutoConfig_D: DramConfigMisc2: 00000000
07.276: AutoConfig_D: DramConfigLo:    03082000
07.276: AutoConfig_D: DramConfigHi:    0f090084
07.277: InitDDRPhy: Start
07.277: InitDDRPhy: Done
07.277: mct_SetDramConfigHi_D: Start
07.277: set_2t_configuration: Start
07.277: set_2t_configuration: Done
07.277: mct_BeforePlatformSpec: Start
07.277: mct_BeforePlatformSpec: Done
07.277: mct_PlatformSpec: Start
07.277: mct_PlatformSpec: Done
07.277: mct_SetDramConfigHi_D: DramConfigHi:    0f090084
07.277: *
07.277: mct_SetDramConfigHi_D: Done
07.277: mct_EarlyArbEn_D: Start
07.277: mct_EarlyArbEn_D: Done
07.277: AutoConfig: Status 2005
07.277: AutoConfig: ErrStatus 0
07.277: AutoConfig: ErrCode 0
07.277: AutoConfig: Done
07.277:=20
07.277: <09><09>DCTInit_D: AutoConfig_D Done
07.277: <09><09>DCTInit_D: PlatformSpec_D Done
07.277: <09><09>DCTFinalInit_D: StartupDCT_D Start
07.277: mct_BeforeDramInit_Prod_D: Start
07.277: mct_ProgramODT_D: Start
07.277: mct_ProgramODT_D: Done
07.277: mct_BeforeDramInit_Prod_D: Done
07.277: mct_DramInit_Sw_D: Start
07.277: mct_DCTAccessDone: Start
07.277: mct_DCTAccessDone: Done
07.279: DIMM 1 RttWr: 0
07.279: mct_SendMrsCmd: Start
07.279: mct_SendMrsCmd: Done
07.279: mct_SendMrsCmd: Start
07.279: mct_SendMrsCmd: Done
07.280: DIMM 1 RttNom: 2
07.280: mct_SendMrsCmd: Start
07.280: mct_SendMrsCmd: Done
07.280: mct_SendMrsCmd: Start
07.280: mct_SendMrsCmd: Done
07.280: DIMM 1 RttWr: 0
07.280: mct_SendMrsCmd: Start
07.280: mct_SendMrsCmd: Done
07.280: mct_SendMrsCmd: Start
07.280: mct_SendMrsCmd: Done
07.280: DIMM 1 RttNom: 2
07.280: mct_SendMrsCmd: Start
07.280: mct_SendMrsCmd: Done
07.280: mct_SendMrsCmd: Start
07.280: mct_SendMrsCmd: Done
07.280: mct_SendZQCmd: Start
07.280: mct_SendZQCmd: Done
07.280: mct_SendZQCmd: Start
07.280: mct_SendZQCmd: Done
07.280: mct_DCTAccessDone: Start
07.280: mct_DCTAccessDone: Done
07.280: mct_DramInit_Sw_D: Done
07.280: <09><09>DCTFinalInit_D: StartupDCT_D Done
07.280: mctAutoInitMCT_D: mctSMBhub_Init
07.280: activate_spd_rom() for node 02
07.280: enable_spd_node2()
07.280: mctAutoInitMCT_D: mct_initDCT
07.281: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.281: CBFS: Locating 'cmos_layout.bin'
07.281: CBFS: Found @ offset 2adc0 size dc4
07.281: SPDCalcWidth: Status 2005
07.281: SPDCalcWidth: ErrStatus 0
07.281: SPDCalcWidth: ErrCode 0
07.281: SPDCalcWidth: Done
07.281: <09><09>DCTInit_D: mct_SPDCalcWidth Done
07.281: AutoCycTiming_D: Start
07.281: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.281: CBFS: Locating 'cmos_layout.bin'
07.281: CBFS: Found @ offset 2adc0 size dc4
07.282: GetPresetmaxF_D: Start
07.282: GetPresetmaxF_D: Done
07.282: SPDGetTCL_D: Start
07.282: SPDGetTCL_D: DIMMCASL 5
07.282: SPDGetTCL_D: DIMMAutoSpeed 4
07.282: SPDGetTCL_D: Status 2005
07.282: SPDGetTCL_D: ErrStatus 0
07.282: SPDGetTCL_D: ErrCode 0
07.282: SPDGetTCL_D: Done
07.282:=20
07.282: SPD2ndTiming: Start
07.282: SPD2ndTiming: Done
07.282: AutoCycTiming: Status 2005
07.282: AutoCycTiming: ErrStatus 0
07.282: AutoCycTiming: ErrCode 0
07.282: AutoCycTiming: Done
07.282:=20
07.282: <09><09>DCTInit_D: AutoCycTiming_D Done
07.283: SPDSetBanks: CSPresent c
07.283: SPDSetBanks: Status 2005
07.283: SPDSetBanks: ErrStatus 0
07.283: SPDSetBanks: ErrCode 0
07.283: SPDSetBanks: Done
07.283:=20
07.283: AfterStitch pDCTstat->NodeSysBase =3D 0
07.283: mct_AfterStitchMemory: pDCTstat->NodeSysLimit =3D 3ffffff
07.283: StitchMemory: Status 2005
07.283: StitchMemory: ErrStatus 0
07.283: StitchMemory: ErrCode 0
07.283: StitchMemory: Done
07.283:=20
07.283: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.283: CBFS: Locating 'cmos_layout.bin'
07.283: CBFS: Found @ offset 2adc0 size dc4
07.284: InterleaveBanks_D: Status 2005
07.284: InterleaveBanks_D: ErrStatus 0
07.284: InterleaveBanks_D: ErrCode 0
07.284: InterleaveBanks_D: Done
07.284:=20
07.284: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.284: CBFS: Locating 'cmos_layout.bin'
07.284: CBFS: Found @ offset 2adc0 size dc4
07.284: AutoConfig_D: DramControl:     00002a06
07.284: AutoConfig_D: DramTimingLo:    00000000
07.284: AutoConfig_D: DramConfigMisc:  00000000
07.284: AutoConfig_D: DramConfigMisc2: 00000000
07.284: AutoConfig_D: DramConfigLo:    03082000
07.284: AutoConfig_D: DramConfigHi:    0f090084
07.285: InitDDRPhy: Start
07.285: InitDDRPhy: Done
07.285: mct_SetDramConfigHi_D: Start
07.285: set_2t_configuration: Start
07.285: set_2t_configuration: Done
07.285: mct_BeforePlatformSpec: Start
07.285: mct_BeforePlatformSpec: Done
07.285: mct_PlatformSpec: Start
07.285: mct_PlatformSpec: Done
07.285: mct_SetDramConfigHi_D: DramConfigHi:    0f090084
07.285: *
07.285: mct_SetDramConfigHi_D: Done
07.285: mct_EarlyArbEn_D: Start
07.285: mct_EarlyArbEn_D: Done
07.285: AutoConfig: Status 2005
07.285: AutoConfig: ErrStatus 0
07.285: AutoConfig: ErrCode 0
07.285: AutoConfig: Done
07.285:=20
07.285: <09><09>DCTInit_D: AutoConfig_D Done
07.285: <09><09>DCTInit_D: PlatformSpec_D Done
07.285: <09><09>DCTFinalInit_D: StartupDCT_D Start
07.285: mct_BeforeDramInit_Prod_D: Start
07.285: mct_ProgramODT_D: Start
07.285: mct_ProgramODT_D: Done
07.285: mct_BeforeDramInit_Prod_D: Done
07.285: mct_DramInit_Sw_D: Start
07.285: mct_DCTAccessDone: Start
07.285: mct_DCTAccessDone: Done
07.287: DIMM 1 RttWr: 0
07.287: mct_SendMrsCmd: Start
07.287: mct_SendMrsCmd: Done
07.287: mct_SendMrsCmd: Start
07.287: mct_SendMrsCmd: Done
07.288: DIMM 1 RttNom: 2
07.288: mct_SendMrsCmd: Start
07.288: mct_SendMrsCmd: Done
07.288: mct_SendMrsCmd: Start
07.288: mct_SendMrsCmd: Done
07.288: DIMM 1 RttWr: 0
07.288: mct_SendMrsCmd: Start
07.288: mct_SendMrsCmd: Done
07.288: mct_SendMrsCmd: Start
07.288: mct_SendMrsCmd: Done
07.288: DIMM 1 RttNom: 2
07.288: mct_SendMrsCmd: Start
07.288: mct_SendMrsCmd: Done
07.288: mct_SendMrsCmd: Start
07.288: mct_SendMrsCmd: Done
07.288: mct_SendZQCmd: Start
07.288: mct_SendZQCmd: Done
07.288: mct_SendZQCmd: Start
07.288: mct_SendZQCmd: Done
07.288: mct_DCTAccessDone: Start
07.288: mct_DCTAccessDone: Done
07.288: mct_DramInit_Sw_D: Done
07.288: <09><09>DCTFinalInit_D: StartupDCT_D Done
07.288: SPDCalcWidth: Status 2005
07.289: SPDCalcWidth: ErrStatus 0
07.289: SPDCalcWidth: ErrCode 0
07.289: SPDCalcWidth: Done
07.289: <09><09>DCTInit_D: mct_SPDCalcWidth Done
07.289: AutoCycTiming_D: Start
07.289: SPD2ndTiming: Start
07.289: SPD2ndTiming: Done
07.289: AutoCycTiming: Status 2005
07.289: AutoCycTiming: ErrStatus 0
07.289: AutoCycTiming: ErrCode 0
07.289: AutoCycTiming: Done
07.289:=20
07.289: <09><09>DCTInit_D: AutoCycTiming_D Done
07.289: <09><09>DCTInit_D: enabling intra-channel clock skew
07.289: SPDSetBanks: CSPresent c
07.289: SPDSetBanks: Status 2005
07.289: SPDSetBanks: ErrStatus 0
07.289: SPDSetBanks: ErrCode 0
07.289: SPDSetBanks: Done
07.289:=20
07.290: AfterStitch pDCTstat->NodeSysBase =3D 0
07.290: mct_AfterStitchMemory: pDCTstat->NodeSysLimit =3D 7fffffe
07.290: StitchMemory: Status 2005
07.290: StitchMemory: ErrStatus 0
07.290: StitchMemory: ErrCode 0
07.290: StitchMemory: Done
07.290:=20
07.290: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.290: CBFS: Locating 'cmos_layout.bin'
07.290: CBFS: Found @ offset 2adc0 size dc4
07.291: InterleaveBanks_D: Status 2005
07.291: InterleaveBanks_D: ErrStatus 0
07.291: InterleaveBanks_D: ErrCode 0
07.291: InterleaveBanks_D: Done
07.291:=20
07.291: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.291: CBFS: Locating 'cmos_layout.bin'
07.291: CBFS: Found @ offset 2adc0 size dc4
07.291: AutoConfig_D: DramControl:     00002a06
07.291: AutoConfig_D: DramTimingLo:    00000000
07.291: AutoConfig_D: DramConfigMisc:  00000000
07.291: AutoConfig_D: DramConfigMisc2: 00000000
07.291: AutoConfig_D: DramConfigLo:    03082000
07.291: AutoConfig_D: DramConfigHi:    0f090084
07.292: InitDDRPhy: Start
07.292: InitDDRPhy: Done
07.292: mct_SetDramConfigHi_D: Start
07.292: set_2t_configuration: Start
07.292: set_2t_configuration: Done
07.292: mct_BeforePlatformSpec: Start
07.292: mct_BeforePlatformSpec: Done
07.292: mct_PlatformSpec: Start
07.292: mct_PlatformSpec: Done
07.292: mct_SetDramConfigHi_D: DramConfigHi:    0f090084
07.292: *
07.292: mct_SetDramConfigHi_D: Done
07.292: mct_EarlyArbEn_D: Start
07.292: mct_EarlyArbEn_D: Done
07.292: AutoConfig: Status 2005
07.292: AutoConfig: ErrStatus 0
07.292: AutoConfig: ErrCode 0
07.292: AutoConfig: Done
07.292:=20
07.292: <09><09>DCTInit_D: AutoConfig_D Done
07.292: <09><09>DCTInit_D: PlatformSpec_D Done
07.292: <09><09>DCTFinalInit_D: StartupDCT_D Start
07.292: mct_BeforeDramInit_Prod_D: Start
07.292: mct_ProgramODT_D: Start
07.292: mct_ProgramODT_D: Done
07.292: mct_BeforeDramInit_Prod_D: Done
07.292: mct_DramInit_Sw_D: Start
07.292: mct_DCTAccessDone: Start
07.292: mct_DCTAccessDone: Done
07.294: DIMM 1 RttWr: 0
07.294: mct_SendMrsCmd: Start
07.294: mct_SendMrsCmd: Done
07.294: mct_SendMrsCmd: Start
07.294: mct_SendMrsCmd: Done
07.294: DIMM 1 RttNom: 2
07.295: mct_SendMrsCmd: Start
07.295: mct_SendMrsCmd: Done
07.295: mct_SendMrsCmd: Start
07.295: mct_SendMrsCmd: Done
07.295: DIMM 1 RttWr: 0
07.295: mct_SendMrsCmd: Start
07.295: mct_SendMrsCmd: Done
07.295: mct_SendMrsCmd: Start
07.295: mct_SendMrsCmd: Done
07.295: DIMM 1 RttNom: 2
07.295: mct_SendMrsCmd: Start
07.295: mct_SendMrsCmd: Done
07.295: mct_SendMrsCmd: Start
07.295: mct_SendMrsCmd: Done
07.295: mct_SendZQCmd: Start
07.295: mct_SendZQCmd: Done
07.295: mct_SendZQCmd: Start
07.295: mct_SendZQCmd: Done
07.295: mct_DCTAccessDone: Start
07.295: mct_DCTAccessDone: Done
07.295: mct_DramInit_Sw_D: Done
07.295: <09><09>DCTFinalInit_D: StartupDCT_D Done
07.295: mctAutoInitMCT_D: mctSMBhub_Init
07.295: activate_spd_rom() for node 03
07.295: enable_spd_node3()
07.295: mctAutoInitMCT_D: mct_initDCT
07.296: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.296: CBFS: Locating 'cmos_layout.bin'
07.296: CBFS: Found @ offset 2adc0 size dc4
07.296: SPDCalcWidth: Status 2005
07.296: SPDCalcWidth: ErrStatus 0
07.296: SPDCalcWidth: ErrCode 0
07.296: SPDCalcWidth: Done
07.296: <09><09>DCTInit_D: mct_SPDCalcWidth Done
07.296: AutoCycTiming_D: Start
07.296: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.296: CBFS: Locating 'cmos_layout.bin'
07.296: CBFS: Found @ offset 2adc0 size dc4
07.296: GetPresetmaxF_D: Start
07.297: GetPresetmaxF_D: Done
07.296: SPDGetTCL_D: Start
07.297: SPDGetTCL_D: DIMMCASL 5
07.297: SPDGetTCL_D: DIMMAutoSpeed 4
07.297: SPDGetTCL_D: Status 2005
07.297: SPDGetTCL_D: ErrStatus 0
07.297: SPDGetTCL_D: ErrCode 0
07.297: SPDGetTCL_D: Done
07.297:=20
07.297: SPD2ndTiming: Start
07.297: SPD2ndTiming: Done
07.297: AutoCycTiming: Status 2005
07.297: AutoCycTiming: ErrStatus 0
07.297: AutoCycTiming: ErrCode 0
07.297: AutoCycTiming: Done
07.297:=20
07.297: <09><09>DCTInit_D: AutoCycTiming_D Done
07.297: SPDSetBanks: CSPresent c
07.297: SPDSetBanks: Status 2005
07.297: SPDSetBanks: ErrStatus 0
07.297: SPDSetBanks: ErrCode 0
07.297: SPDSetBanks: Done
07.297:=20
07.298: AfterStitch pDCTstat->NodeSysBase =3D 0
07.298: mct_AfterStitchMemory: pDCTstat->NodeSysLimit =3D 3ffffff
07.298: StitchMemory: Status 2005
07.298: StitchMemory: ErrStatus 0
07.298: StitchMemory: ErrCode 0
07.298: StitchMemory: Done
07.298:=20
07.298: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.298: CBFS: Locating 'cmos_layout.bin'
07.298: CBFS: Found @ offset 2adc0 size dc4
07.298: InterleaveBanks_D: Status 2005
07.298: InterleaveBanks_D: ErrStatus 0
07.298: InterleaveBanks_D: ErrCode 0
07.298: InterleaveBanks_D: Done
07.298:=20
07.298: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.298: CBFS: Locating 'cmos_layout.bin'
07.299: CBFS: Found @ offset 2adc0 size dc4
07.299: AutoConfig_D: DramControl:     00002a06
07.299: AutoConfig_D: DramTimingLo:    00000000
07.299: AutoConfig_D: DramConfigMisc:  00000000
07.299: AutoConfig_D: DramConfigMisc2: 00000000
07.299: AutoConfig_D: DramConfigLo:    03082000
07.299: AutoConfig_D: DramConfigHi:    0f090084
07.299: InitDDRPhy: Start
07.299: InitDDRPhy: Done
07.299: mct_SetDramConfigHi_D: Start
07.299: set_2t_configuration: Start
07.299: set_2t_configuration: Done
07.299: mct_BeforePlatformSpec: Start
07.299: mct_BeforePlatformSpec: Done
07.299: mct_PlatformSpec: Start
07.299: mct_PlatformSpec: Done
07.299: mct_SetDramConfigHi_D: DramConfigHi:    0f090084
07.299: *
07.299: mct_SetDramConfigHi_D: Done
07.300: mct_EarlyArbEn_D: Start
07.300: mct_EarlyArbEn_D: Done
07.300: AutoConfig: Status 2005
07.300: AutoConfig: ErrStatus 0
07.300: AutoConfig: ErrCode 0
07.300: AutoConfig: Done
07.300:=20
07.300: <09><09>DCTInit_D: AutoConfig_D Done
07.300: <09><09>DCTInit_D: PlatformSpec_D Done
07.300: <09><09>DCTFinalInit_D: StartupDCT_D Start
07.300: mct_BeforeDramInit_Prod_D: Start
07.300: mct_ProgramODT_D: Start
07.300: mct_ProgramODT_D: Done
07.300: mct_BeforeDramInit_Prod_D: Done
07.300: mct_DramInit_Sw_D: Start
07.300: mct_DCTAccessDone: Start
07.300: mct_DCTAccessDone: Done
07.301: DIMM 1 RttWr: 0
07.301: mct_SendMrsCmd: Start
07.302: mct_SendMrsCmd: Done
07.302: mct_SendMrsCmd: Start
07.302: mct_SendMrsCmd: Done
07.302: DIMM 1 RttNom: 2
07.302: mct_SendMrsCmd: Start
07.302: mct_SendMrsCmd: Done
07.302: mct_SendMrsCmd: Start
07.302: mct_SendMrsCmd: Done
07.302: DIMM 1 RttWr: 0
07.302: mct_SendMrsCmd: Start
07.302: mct_SendMrsCmd: Done
07.302: mct_SendMrsCmd: Start
07.302: mct_SendMrsCmd: Done
07.302: DIMM 1 RttNom: 2
07.302: mct_SendMrsCmd: Start
07.302: mct_SendMrsCmd: Done
07.302: mct_SendMrsCmd: Start
07.302: mct_SendMrsCmd: Done
07.302: mct_SendZQCmd: Start
07.302: mct_SendZQCmd: Done
07.302: mct_SendZQCmd: Start
07.302: mct_SendZQCmd: Done
07.302: mct_DCTAccessDone: Start
07.302: mct_DCTAccessDone: Done
07.302: mct_DramInit_Sw_D: Done
07.303: <09><09>DCTFinalInit_D: StartupDCT_D Done
07.303: SPDCalcWidth: Status 2005
07.303: SPDCalcWidth: ErrStatus 0
07.303: SPDCalcWidth: ErrCode 0
07.303: SPDCalcWidth: Done
07.303: <09><09>DCTInit_D: mct_SPDCalcWidth Done
07.303: AutoCycTiming_D: Start
07.303: SPD2ndTiming: Start
07.303: SPD2ndTiming: Done
07.303: AutoCycTiming: Status 2005
07.303: AutoCycTiming: ErrStatus 0
07.303: AutoCycTiming: ErrCode 0
07.303: AutoCycTiming: Done
07.303:=20
07.303: <09><09>DCTInit_D: AutoCycTiming_D Done
07.303: <09><09>DCTInit_D: enabling intra-channel clock skew
07.304: SPDSetBanks: CSPresent c
07.304: SPDSetBanks: Status 2005
07.304: SPDSetBanks: ErrStatus 0
07.304: SPDSetBanks: ErrCode 0
07.304: SPDSetBanks: Done
07.304:=20
07.304: AfterStitch pDCTstat->NodeSysBase =3D 0
07.304: mct_AfterStitchMemory: pDCTstat->NodeSysLimit =3D 7fffffe
07.304: StitchMemory: Status 2005
07.304: StitchMemory: ErrStatus 0
07.304: StitchMemory: ErrCode 0
07.304: StitchMemory: Done
07.304:=20
07.305: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.305: CBFS: Locating 'cmos_layout.bin'
07.305: CBFS: Found @ offset 2adc0 size dc4
07.305: InterleaveBanks_D: Status 2005
07.305: InterleaveBanks_D: ErrStatus 0
07.305: InterleaveBanks_D: ErrCode 0
07.305: InterleaveBanks_D: Done
07.305:=20
07.305: FMAP: area COREBOOT found @ 200 (2096640 bytes)
07.305: CBFS: Locating 'cmos_layout.bin'
07.305: CBFS: Found @ offset 2adc0 size dc4
07.305: AutoConfig_D: DramControl:     00002a06
07.305: AutoConfig_D: DramTimingLo:    00000000
07.305: AutoConfig_D: DramConfigMisc:  00000000
07.305: AutoConfig_D: DramConfigMisc2: 00000000
07.305: AutoConfig_D: DramConfigLo:    03082000
07.306: AutoConfig_D: DramConfigHi:    0f090084
07.306: InitDDRPhy: Start
07.306: InitDDRPhy: Done
07.306: mct_SetDramConfigHi_D: Start
07.306: set_2t_configuration: Start
07.306: set_2t_configuration: Done
07.306: mct_BeforePlatformSpec: Start
07.306: mct_BeforePlatformSpec: Done
07.306: mct_PlatformSpec: Start
07.306: mct_PlatformSpec: Done
07.306: mct_SetDramConfigHi_D: DramConfigHi:    0f090084
07.306: *
07.306: mct_SetDramConfigHi_D: Done
07.306: mct_EarlyArbEn_D: Start
07.306: mct_EarlyArbEn_D: Done
07.306: AutoConfig: Status 2005
07.306: AutoConfig: ErrStatus 0
07.306: AutoConfig: ErrCode 0
07.306: AutoConfig: Done
07.306:=20
07.306: <09><09>DCTInit_D: AutoConfig_D Done
07.306: <09><09>DCTInit_D: PlatformSpec_D Done
07.306: <09><09>DCTFinalInit_D: StartupDCT_D Start
07.306: mct_BeforeDramInit_Prod_D: Start
07.306: mct_ProgramODT_D: Start
07.306: mct_ProgramODT_D: Done
07.306: mct_BeforeDramInit_Prod_D: Done
07.306: mct_DramInit_Sw_D: Start
07.307: mct_DCTAccessDone: Start
07.307: mct_DCTAccessDone: Done
07.308: DIMM 1 RttWr: 0
07.308: mct_SendMrsCmd: Start
07.308: mct_SendMrsCmd: Done
07.308: mct_SendMrsCmd: Start
07.308: mct_SendMrsCmd: Done
07.309: DIMM 1 RttNom: 2
07.309: mct_SendMrsCmd: Start
07.309: mct_SendMrsCmd: Done
07.309: mct_SendMrsCmd: Start
07.309: mct_SendMrsCmd: Done
07.309: DIMM 1 RttWr: 0
07.309: mct_SendMrsCmd: Start
07.309: mct_SendMrsCmd: Done
07.309: mct_SendMrsCmd: Start
07.309: mct_SendMrsCmd: Done
07.309: DIMM 1 RttNom: 2
07.309: mct_SendMrsCmd: Start
07.309: mct_SendMrsCmd: Done
07.309: mct_SendMrsCmd: Start
07.309: mct_SendMrsCmd: Done
07.309: mct_SendZQCmd: Start
07.309: mct_SendZQCmd: Done
07.309: mct_SendZQCmd: Start
07.309: mct_SendZQCmd: Done
07.309: mct_DCTAccessDone: Start
07.309: mct_DCTAccessDone: Done
07.309: mct_DramInit_Sw_D: Done
07.309: <09><09>DCTFinalInit_D: StartupDCT_D Done
07.309: mctAutoInitMCT_D: SyncDCTsReady_D
07.310: mctAutoInitMCT_D: HTMemMapInit_D
07.310:  Node: 00  base: 00  limit: 7ffffff  BottomIO: c00000
07.310:  Node: 00  base: 03  limit: 83fffff
07.310:  Node: 01  base: 8400000  limit: 103fffff  BottomIO: c00000
07.310:  Node: 01  base: 8400003  limit: 103fffff
07.310:  Node: 02  base: 10400000  limit: 183fffff  BottomIO: c00000
07.310:  Node: 02  base: 10400003  limit: 183fffff
07.310:  Node: 03  base: 18400000  limit: 203fffff  BottomIO: c00000
07.310:  Node: 03  base: 18400003  limit: 203fffff
07.310:  Node: 04  base: 00  limit: 00
07.310:  Node: 05  base: 00  limit: 00
07.310:  Node: 06  base: 00  limit: 00
07.310:  Node: 07  base: 00  limit: 00
07.310:  Copy dram map from Node 0 to Node 01
07.310:  Copy dram map from Node 0 to Node 02
07.310:  Copy dram map from Node 0 to Node 03
07.310: mctAutoInitMCT_D: mctHookAfterCPU
07.310: mctAutoInitMCT_D: DQSTiming_D
07.311: phyAssistedMemFnceTraining: Start
07.313: phyAssistedMemFnceTraining: Done
07.313: InitPhyCompensation: DCT 0: Start
07.315: Waiting for predriver calibration to be applied...done!
07.315: InitPhyCompensation: DCT 0: Done
07.315: InitPhyCompensation: DCT 1: Start
07.315: Waiting for predriver calibration to be applied...done!
07.315: InitPhyCompensation: DCT 1: Done
07.315: InitPhyCompensation: DCT 0: Start
07.315: Waiting for predriver calibration to be applied...done!
07.315: InitPhyCompensation: DCT 0: Done
07.315: InitPhyCompensation: DCT 1: Start
07.315: Waiting for predriver calibration to be applied...done!
07.315: InitPhyCompensation: DCT 1: Done
07.315: InitPhyCompensation: DCT 0: Start
07.315: Waiting for predriver calibration to be applied...done!
07.315: InitPhyCompensation: DCT 0: Done
07.315: InitPhyCompensation: DCT 1: Start
07.315: Waiting for predriver calibration to be applied...done!
07.315: InitPhyCompensation: DCT 1: Done
07.315: InitPhyCompensation: DCT 0: Start
07.315: Waiting for predriver calibration to be applied...done!
07.316: InitPhyCompensation: DCT 0: Done
07.315: InitPhyCompensation: DCT 1: Start
07.316: Waiting for predriver calibration to be applied...done!
07.316: InitPhyCompensation: DCT 1: Done
07.316: activate_spd_rom() for node 00
07.316: enable_spd_node0()
07.320: DIMM 1 RttNom: 2
07.320: DIMM 1 RttNom: 2
07.320: DIMM 1 RttWr: 0
07.320: DIMM 1 RttWr: 0
07.321: DIMM 1 RttNom: 2
07.321: DIMM 1 RttNom: 2
07.321: DIMM 1 RttWr: 0
07.321: DIMM 1 RttWr: 0
07.324: DIMM 1 RttNom: 2
07.324: DIMM 1 RttNom: 2
07.324: DIMM 1 RttWr: 0
07.324: DIMM 1 RttWr: 0
07.324: DIMM 1 RttNom: 2
07.324: DIMM 1 RttNom: 2
07.324: DIMM 1 RttWr: 0
07.324: DIMM 1 RttWr: 0
07.324: DIMM 1 RttNom: 2
07.324: DIMM 1 RttNom: 2
07.324: DIMM 1 RttWr: 0
07.324: DIMM 1 RttWr: 0
07.324: DIMM 1 RttNom: 2
07.324: DIMM 1 RttNom: 2
07.324: DIMM 1 RttWr: 0
07.324: DIMM 1 RttWr: 0
07.324: DIMM 1 RttNom: 2
07.324: DIMM 1 RttNom: 2
07.324: DIMM 1 RttWr: 0
07.324: DIMM 1 RttWr: 0
07.324: DIMM 1 RttNom: 2
07.324: DIMM 1 RttNom: 2
07.324: DIMM 1 RttWr: 0
07.324: DIMM 1 RttWr: 0
07.325: DIMM 1 RttNom: 2
07.325: DIMM 1 RttNom: 2
07.325: DIMM 1 RttWr: 0
07.325: DIMM 1 RttWr: 0
07.325: DIMM 1 RttNom: 2
07.325: DIMM 1 RttNom: 2
07.325: DIMM 1 RttWr: 0
07.325: DIMM 1 RttWr: 0
07.325: activate_spd_rom() for node 01
07.326: enable_spd_node1()
07.326: DIMM 1 RttNom: 2
07.326: DIMM 1 RttNom: 2
07.326: DIMM 1 RttWr: 0
07.326: DIMM 1 RttWr: 0
07.326: DIMM 1 RttNom: 2
07.326: DIMM 1 RttNom: 2
07.326: DIMM 1 RttWr: 0
07.326: DIMM 1 RttWr: 0
07.326: DIMM 1 RttNom: 2
07.326: DIMM 1 RttNom: 2
07.326: DIMM 1 RttWr: 0
07.326: DIMM 1 RttWr: 0
07.326: DIMM 1 RttNom: 2
07.326: DIMM 1 RttNom: 2
07.326: DIMM 1 RttWr: 0
07.326: DIMM 1 RttWr: 0
07.326: DIMM 1 RttNom: 2
07.326: DIMM 1 RttNom: 2
07.326: DIMM 1 RttWr: 0
07.326: DIMM 1 RttWr: 0
07.326: DIMM 1 RttNom: 2
07.326: DIMM 1 RttNom: 2
07.326: DIMM 1 RttWr: 0
07.326: DIMM 1 RttWr: 0
07.327: DIMM 1 RttNom: 2
07.327: DIMM 1 RttNom: 2
07.327: DIMM 1 RttWr: 0
07.327: DIMM 1 RttWr: 0
07.327: DIMM 1 RttNom: 2
07.327: DIMM 1 RttNom: 2
07.327: DIMM 1 RttWr: 0
07.327: DIMM 1 RttWr: 0
07.327: DIMM 1 RttNom: 2
07.327: DIMM 1 RttNom: 2
07.327: DIMM 1 RttWr: 0
07.327: DIMM 1 RttWr: 0
07.327: DIMM 1 RttNom: 2
07.327: DIMM 1 RttNom: 2
07.327: DIMM 1 RttWr: 0
07.327: DIMM 1 RttWr: 0
07.327: activate_spd_rom() for node 02
07.327: enable_spd_node2()
07.328: DIMM 1 RttNom: 2
07.328: DIMM 1 RttNom: 2
07.328: DIMM 1 RttWr: 0
07.328: DIMM 1 RttWr: 0
07.328: DIMM 1 RttNom: 2
07.328: DIMM 1 RttNom: 2
07.328: DIMM 1 RttWr: 0
07.328: DIMM 1 RttWr: 0
07.328: DIMM 1 RttNom: 2
07.328: DIMM 1 RttNom: 2
07.328: DIMM 1 RttWr: 0
07.328: DIMM 1 RttWr: 0
07.328: DIMM 1 RttNom: 2
07.328: DIMM 1 RttNom: 2
07.328: DIMM 1 RttWr: 0
07.328: DIMM 1 RttWr: 0
07.328: DIMM 1 RttNom: 2
07.328: DIMM 1 RttNom: 2
07.328: DIMM 1 RttWr: 0
07.328: DIMM 1 RttWr: 0
07.328: DIMM 1 RttNom: 2
07.328: DIMM 1 RttNom: 2
07.328: DIMM 1 RttWr: 0
07.328: DIMM 1 RttWr: 0
07.328: DIMM 1 RttNom: 2
07.328: DIMM 1 RttNom: 2
07.328: DIMM 1 RttWr: 0
07.328: DIMM 1 RttWr: 0
07.328: DIMM 1 RttNom: 2
07.328: DIMM 1 RttNom: 2
07.328: DIMM 1 RttWr: 0
07.329: DIMM 1 RttWr: 0
07.329: DIMM 1 RttNom: 2
07.329: DIMM 1 RttNom: 2
07.329: DIMM 1 RttWr: 0
07.329: DIMM 1 RttWr: 0
07.329: DIMM 1 RttNom: 2
07.329: DIMM 1 RttNom: 2
07.329: DIMM 1 RttWr: 0
07.329: DIMM 1 RttWr: 0
07.329: activate_spd_rom() for node 03
07.329: enable_spd_node3()
07.329: DIMM 1 RttNom: 2
07.329: DIMM 1 RttNom: 2
07.329: DIMM 1 RttWr: 0
07.329: DIMM 1 RttWr: 0
07.329: DIMM 1 RttNom: 2
07.329: DIMM 1 RttNom: 2
07.329: DIMM 1 RttWr: 0
07.329: DIMM 1 RttWr: 0
07.330: DIMM 1 RttNom: 2
07.330: DIMM 1 RttNom: 2
07.330: DIMM 1 RttWr: 0
07.330: DIMM 1 RttWr: 0
07.330: DIMM 1 RttNom: 2
07.330: DIMM 1 RttNom: 2
07.330: DIMM 1 RttWr: 0
07.330: DIMM 1 RttWr: 0
07.330: DIMM 1 RttNom: 2
07.330: DIMM 1 RttNom: 2
07.330: DIMM 1 RttWr: 0
07.330: DIMM 1 RttWr: 0
07.330: DIMM 1 RttNom: 2
07.330: DIMM 1 RttNom: 2
07.330: DIMM 1 RttWr: 0
07.330: DIMM 1 RttWr: 0
07.330: DIMM 1 RttNom: 2
07.330: DIMM 1 RttNom: 2
07.330: DIMM 1 RttWr: 0
07.330: DIMM 1 RttWr: 0
07.330: DIMM 1 RttNom: 2
07.330: DIMM 1 RttNom: 2
07.330: DIMM 1 RttWr: 0
07.330: DIMM 1 RttWr: 0
07.331: DIMM 1 RttNom: 2
07.331: DIMM 1 RttNom: 2
07.331: DIMM 1 RttWr: 0
07.331: DIMM 1 RttWr: 0
07.331: DIMM 1 RttNom: 2
07.331: DIMM 1 RttNom: 2
07.331: DIMM 1 RttWr: 0
07.331: DIMM 1 RttWr: 0
07.335: fam15_receiver_enable_training_seed: using seed: 0054
07.336: fam15_receiver_enable_training_seed: using seed: 0054
07.337: fam15_receiver_enable_training_seed: using seed: 004d
07.337: fam15_receiver_enable_training_seed: using seed: 004d
07.337: fam15_receiver_enable_training_seed: using seed: 004d
07.337: fam15_receiver_enable_training_seed: using seed: 004d
07.338: TrainRcvrEn: Status 2205
07.338: TrainRcvrEn: ErrStatus 0
07.338: TrainRcvrEn: ErrCode 0
07.338: TrainRcvrEn: Done
07.338:=20
07.338: fam15_receiver_enable_training_seed: using seed: 0045
07.338: fam15_receiver_enable_training_seed: using seed: 0045
07.338: fam15_receiver_enable_training_seed: using seed: 0040
07.338: fam15_receiver_enable_training_seed: using seed: 0040
07.339: fam15_receiver_enable_training_seed: using seed: 0040
07.339: fam15_receiver_enable_training_seed: using seed: 0040
07.339: TrainRcvrEn: Status 2005
07.339: TrainRcvrEn: ErrStatus 0
07.339: TrainRcvrEn: ErrCode 0
07.339: TrainRcvrEn: Done
07.339:=20
07.339: fam15_receiver_enable_training_seed: using seed: 0054
07.339: fam15_receiver_enable_training_seed: using seed: 0054
07.339: fam15_receiver_enable_training_seed: using seed: 004d
07.339: fam15_receiver_enable_training_seed: using seed: 004d
07.339: fam15_receiver_enable_training_seed: using seed: 004d
07.340: fam15_receiver_enable_training_seed: using seed: 004d
07.340: TrainRcvrEn: Status 2005
07.340: TrainRcvrEn: ErrStatus 0
07.340: TrainRcvrEn: ErrCode 0
07.340: TrainRcvrEn: Done
07.340:=20
07.340: fam15_receiver_enable_training_seed: using seed: 0045
07.340: fam15_receiver_enable_training_seed: using seed: 0045
07.340: fam15_receiver_enable_training_seed: using seed: 0040
07.340: fam15_receiver_enable_training_seed: using seed: 0040
07.340: fam15_receiver_enable_training_seed: using seed: 0040
07.340: fam15_receiver_enable_training_seed: using seed: 0040
07.341: TrainRcvrEn: Status 2005
07.341: TrainRcvrEn: ErrStatus 0
07.341: TrainRcvrEn: ErrCode 0
07.341: TrainRcvrEn: Done
07.341:=20
07.341: activate_spd_rom() for node 00
07.341: enable_spd_node0()
07.342: SetTargetFreq: Start
07.341: SetTargetFreq: Node 0: New frequency code: 0006
07.342: ChangeMemClk: Start
07.342: set_2t_configuration: Start
07.342: set_2t_configuration: Done
07.343: mct_BeforePlatformSpec: Start
07.343: mct_BeforePlatformSpec: Done
07.343: mct_PlatformSpec: Start
07.343: mct_PlatformSpec: Done
07.343: set_2t_configuration: Start
07.343: set_2t_configuration: Done
07.343: mct_BeforePlatformSpec: Start
07.343: mct_BeforePlatformSpec: Done
07.343: mct_PlatformSpec: Start
07.343: mct_PlatformSpec: Done
07.343: ChangeMemClk: Done
07.343: phyAssistedMemFnceTraining: Start
07.343: phyAssistedMemFnceTraining: Done
07.343: InitPhyCompensation: DCT 0: Start
07.344: Waiting for predriver calibration to be applied...done!
07.344: InitPhyCompensation: DCT 0: Done
07.344: phyAssistedMemFnceTraining: Start
07.344: phyAssistedMemFnceTraining: Done
07.344: InitPhyCompensation: DCT 1: Start
07.344: Waiting for predriver calibration to be applied...done!
07.344: InitPhyCompensation: DCT 1: Done
07.345: SetTargetFreq: Done
07.345: SPD2ndTiming: Start
07.346: SPD2ndTiming: Done
07.346: mct_BeforeDramInit_Prod_D: Start
07.346: mct_ProgramODT_D: Start
07.346: mct_ProgramODT_D: Done
07.346: mct_BeforeDramInit_Prod_D: Done
07.346: mct_DramInit_Sw_D: Start
07.346: DIMM 1 RttWr: 0
07.346: mct_SendMrsCmd: Start
07.346: mct_SendMrsCmd: Done
07.346: mct_SendMrsCmd: Start
07.346: mct_SendMrsCmd: Done
07.346: DIMM 1 RttNom: 2
07.346: mct_SendMrsCmd: Start
07.347: mct_SendMrsCmd: Done
07.346: mct_SendMrsCmd: Start
07.346: mct_SendMrsCmd: Done
07.347: DIMM 1 RttWr: 0
07.347: mct_SendMrsCmd: Start
07.347: mct_SendMrsCmd: Done
07.347: mct_SendMrsCmd: Start
07.347: mct_SendMrsCmd: Done
07.347: DIMM 1 RttNom: 2
07.347: mct_SendMrsCmd: Start
07.347: mct_SendMrsCmd: Done
07.347: mct_SendMrsCmd: Start
07.347: mct_SendMrsCmd: Done
07.347: mct_DramInit_Sw_D: Done
07.347: DIMM 1 RttNom: 2
07.347: DIMM 1 RttNom: 2
07.347: DIMM 1 RttWr: 0
07.347: DIMM 1 RttWr: 0
07.347: DIMM 1 RttNom: 2
07.347: DIMM 1 RttNom: 2
07.347: DIMM 1 RttWr: 0
07.347: DIMM 1 RttWr: 0
07.349: DIMM 1 RttNom: 2
07.349: DIMM 1 RttNom: 2
07.349: DIMM 1 RttWr: 0
07.349: DIMM 1 RttWr: 0
07.349: DIMM 1 RttNom: 2
07.349: DIMM 1 RttNom: 2
07.349: DIMM 1 RttWr: 0
07.349: DIMM 1 RttWr: 0
07.349: SPD2ndTiming: Start
07.349: SPD2ndTiming: Done
07.349: mct_BeforeDramInit_Prod_D: Start
07.349: mct_ProgramODT_D: Start
07.349: mct_ProgramODT_D: Done
07.349: mct_BeforeDramInit_Prod_D: Done
07.349: mct_DramInit_Sw_D: Start
07.349: DIMM 1 RttWr: 0
07.349: mct_SendMrsCmd: Start
07.349: mct_SendMrsCmd: Done
07.349: mct_SendMrsCmd: Start
07.349: mct_SendMrsCmd: Done
07.349: DIMM 1 RttNom: 2
07.349: mct_SendMrsCmd: Start
07.349: mct_SendMrsCmd: Done
07.350: mct_SendMrsCmd: Start
07.350: mct_SendMrsCmd: Done
07.350: DIMM 1 RttWr: 0
07.350: mct_SendMrsCmd: Start
07.350: mct_SendMrsCmd: Done
07.350: mct_SendMrsCmd: Start
07.350: mct_SendMrsCmd: Done
07.350: DIMM 1 RttNom: 2
07.350: mct_SendMrsCmd: Start
07.350: mct_SendMrsCmd: Done
07.350: mct_SendMrsCmd: Start
07.350: mct_SendMrsCmd: Done
07.350: mct_DramInit_Sw_D: Done
07.350: DIMM 1 RttNom: 2
07.350: DIMM 1 RttNom: 2
07.350: DIMM 1 RttWr: 0
07.350: DIMM 1 RttWr: 0
07.350: DIMM 1 RttNom: 2
07.350: DIMM 1 RttNom: 2
07.350: DIMM 1 RttWr: 0
07.350: DIMM 1 RttWr: 0
07.351: DIMM 1 RttNom: 2
07.351: DIMM 1 RttNom: 2
07.351: DIMM 1 RttWr: 0
07.351: DIMM 1 RttWr: 0
07.351: DIMM 1 RttNom: 2
07.351: DIMM 1 RttNom: 2
07.351: DIMM 1 RttWr: 0
07.351: DIMM 1 RttWr: 0
07.351: DIMM 1 RttNom: 2
07.351: DIMM 1 RttNom: 2
07.351: DIMM 1 RttWr: 0
07.351: DIMM 1 RttWr: 0
07.351: DIMM 1 RttNom: 2
07.351: DIMM 1 RttNom: 2
07.351: DIMM 1 RttWr: 0
07.351: DIMM 1 RttWr: 0
07.351: SetTargetFreq: Start
07.351: SetTargetFreq: Node 0: New frequency code: 000a
07.351: ChangeMemClk: Start
07.352: set_2t_configuration: Start
07.352: set_2t_configuration: Done
07.352: mct_BeforePlatformSpec: Start
07.352: mct_BeforePlatformSpec: Done
07.352: mct_PlatformSpec: Start
07.352: mct_PlatformSpec: Done
07.352: set_2t_configuration: Start
07.352: set_2t_configuration: Done
07.352: mct_BeforePlatformSpec: Start
07.352: mct_BeforePlatformSpec: Done
07.352: mct_PlatformSpec: Start
07.352: mct_PlatformSpec: Done
07.352: ChangeMemClk: Done
07.352: phyAssistedMemFnceTraining: Start
07.352: phyAssistedMemFnceTraining: Done
07.352: InitPhyCompensation: DCT 0: Start
07.353: Waiting for predriver calibration to be applied...done!
07.352: InitPhyCompensation: DCT 0: Done
07.352: phyAssistedMemFnceTraining: Start
07.353: phyAssistedMemFnceTraining: Done
07.353: InitPhyCompensation: DCT 1: Start
07.353: Waiting for predriver calibration to be applied...done!
07.353: InitPhyCompensation: DCT 1: Done
07.353: SetTargetFreq: Done
07.353: SPD2ndTiming: Start
07.353: SPD2ndTiming: Done
07.354: mct_BeforeDramInit_Prod_D: Start
07.354: mct_ProgramODT_D: Start
07.354: mct_ProgramODT_D: Done
07.354: mct_BeforeDramInit_Prod_D: Done
07.354: mct_DramInit_Sw_D: Start
07.354: DIMM 1 RttWr: 0
07.354: mct_SendMrsCmd: Start
07.354: mct_SendMrsCmd: Done
07.354: mct_SendMrsCmd: Start
07.354: mct_SendMrsCmd: Done
07.354: DIMM 1 RttNom: 1
07.354: mct_SendMrsCmd: Start
07.354: mct_SendMrsCmd: Done
07.354: mct_SendMrsCmd: Start
07.354: mct_SendMrsCmd: Done
07.354: DIMM 1 RttWr: 0
07.354: mct_SendMrsCmd: Start
07.354: mct_SendMrsCmd: Done
07.354: mct_SendMrsCmd: Start
07.354: mct_SendMrsCmd: Done
07.354: DIMM 1 RttNom: 1
07.354: mct_SendMrsCmd: Start
07.354: mct_SendMrsCmd: Done
07.354: mct_SendMrsCmd: Start
07.354: mct_SendMrsCmd: Done
07.354: mct_DramInit_Sw_D: Done
07.355: DIMM 1 RttNom: 1
07.355: DIMM 1 RttNom: 1
07.355: DIMM 1 RttWr: 0
07.355: DIMM 1 RttWr: 0
07.355: DIMM 1 RttNom: 1
07.355: DIMM 1 RttNom: 1
07.355: DIMM 1 RttWr: 0
07.355: DIMM 1 RttWr: 0
07.355: DIMM 1 RttNom: 1
07.355: DIMM 1 RttNom: 1
07.355: DIMM 1 RttWr: 0
07.355: DIMM 1 RttWr: 0
07.355: DIMM 1 RttNom: 1
07.355: DIMM 1 RttNom: 1
07.355: DIMM 1 RttWr: 0
07.355: DIMM 1 RttWr: 0
07.355: SPD2ndTiming: Start
07.356: SPD2ndTiming: Done
07.356: mct_BeforeDramInit_Prod_D: Start
07.356: mct_ProgramODT_D: Start
07.356: mct_ProgramODT_D: Done
07.356: mct_BeforeDramInit_Prod_D: Done
07.356: mct_DramInit_Sw_D: Start
07.356: DIMM 1 RttWr: 0
07.356: mct_SendMrsCmd: Start
07.356: mct_SendMrsCmd: Done
07.356: mct_SendMrsCmd: Start
07.356: mct_SendMrsCmd: Done
07.356: DIMM 1 RttNom: 1
07.356: mct_SendMrsCmd: Start
07.356: mct_SendMrsCmd: Done
07.356: mct_SendMrsCmd: Start
07.356: mct_SendMrsCmd: Done
07.356: DIMM 1 RttWr: 0
07.356: mct_SendMrsCmd: Start
07.356: mct_SendMrsCmd: Done
07.356: mct_SendMrsCmd: Start
07.356: mct_SendMrsCmd: Done
07.356: DIMM 1 RttNom: 1
07.356: mct_SendMrsCmd: Start
07.356: mct_SendMrsCmd: Done
07.356: mct_SendMrsCmd: Start
07.356: mct_SendMrsCmd: Done
07.356: mct_DramInit_Sw_D: Done
07.356: DIMM 1 RttNom: 1
07.356: DIMM 1 RttNom: 1
07.356: DIMM 1 RttWr: 0
07.356: DIMM 1 RttWr: 0
07.356: DIMM 1 RttNom: 1
07.356: DIMM 1 RttNom: 1
07.356: DIMM 1 RttWr: 0
07.356: DIMM 1 RttWr: 0
07.357: DIMM 1 RttNom: 1
07.357: DIMM 1 RttNom: 1
07.357: DIMM 1 RttWr: 0
07.357: DIMM 1 RttWr: 0
07.357: DIMM 1 RttNom: 1
07.357: DIMM 1 RttNom: 1
07.357: DIMM 1 RttWr: 0
07.357: DIMM 1 RttWr: 0
07.357: DIMM 1 RttNom: 1
07.357: DIMM 1 RttNom: 1
07.357: DIMM 1 RttWr: 0
07.357: DIMM 1 RttWr: 0
07.357: DIMM 1 RttNom: 1
07.357: DIMM 1 RttNom: 1
07.357: DIMM 1 RttWr: 0
07.357: DIMM 1 RttWr: 0
07.357: SetTargetFreq: Start
07.358: SetTargetFreq: Node 0: New frequency code: 000e
07.358: ChangeMemClk: Start
07.358: set_2t_configuration: Start
07.358: set_2t_configuration: Done
07.358: mct_BeforePlatformSpec: Start
07.358: mct_BeforePlatformSpec: Done
07.358: mct_PlatformSpec: Start
07.358: mct_PlatformSpec: Done
07.358: set_2t_configuration: Start
07.358: set_2t_configuration: Done
07.358: mct_BeforePlatformSpec: Start
07.358: mct_BeforePlatformSpec: Done
07.358: mct_PlatformSpec: Start
07.358: mct_PlatformSpec: Done
07.358: ChangeMemClk: Done
07.358: phyAssistedMemFnceTraining: Start
07.358: phyAssistedMemFnceTraining: Done
07.358: InitPhyCompensation: DCT 0: Start
07.358: Waiting for predriver calibration to be applied...done!
07.358: InitPhyCompensation: DCT 0: Done
07.358: phyAssistedMemFnceTraining: Start
07.358: phyAssistedMemFnceTraining: Done
07.358: InitPhyCompensation: DCT 1: Start
07.359: Waiting for predriver calibration to be applied...done!
07.359: InitPhyCompensation: DCT 1: Done
07.359: SetTargetFreq: Done
07.359: SPD2ndTiming: Start
07.359: SPD2ndTiming: Done
07.359: mct_BeforeDramInit_Prod_D: Start
07.359: mct_ProgramODT_D: Start
07.359: mct_ProgramODT_D: Done
07.359: mct_BeforeDramInit_Prod_D: Done
07.359: mct_DramInit_Sw_D: Start
07.359: DIMM 1 RttWr: 2
07.360: mct_SendMrsCmd: Start
07.360: mct_SendMrsCmd: Done
07.360: mct_SendMrsCmd: Start
07.360: mct_SendMrsCmd: Done
07.360: DIMM 1 RttNom: 1
07.360: mct_SendMrsCmd: Start
07.360: mct_SendMrsCmd: Done
07.360: mct_SendMrsCmd: Start
07.360: mct_SendMrsCmd: Done
07.360: DIMM 1 RttWr: 2
07.360: mct_SendMrsCmd: Start
07.360: mct_SendMrsCmd: Done
07.360: mct_SendMrsCmd: Start
07.360: mct_SendMrsCmd: Done
07.360: DIMM 1 RttNom: 1
07.360: mct_SendMrsCmd: Start
07.360: mct_SendMrsCmd: Done
07.360: mct_SendMrsCmd: Start
07.360: mct_SendMrsCmd: Done
07.360: mct_DramInit_Sw_D: Done
07.360: DIMM 1 RttNom: 1
07.360: DIMM 1 RttNom: 1
07.360: DIMM 1 RttWr: 2
07.360: DIMM 1 RttWr: 2
07.360: DIMM 1 RttNom: 1
07.360: DIMM 1 RttNom: 1
07.360: DIMM 1 RttWr: 2
07.360: DIMM 1 RttWr: 2
07.361: DIMM 1 RttNom: 1
07.361: DIMM 1 RttNom: 1
07.361: DIMM 1 RttWr: 2
07.361: DIMM 1 RttWr: 2
07.361: DIMM 1 RttNom: 1
07.361: DIMM 1 RttNom: 1
07.361: DIMM 1 RttWr: 2
07.361: DIMM 1 RttWr: 2
07.361: SPD2ndTiming: Start
07.361: SPD2ndTiming: Done
07.361: mct_BeforeDramInit_Prod_D: Start
07.361: mct_ProgramODT_D: Start
07.361: mct_ProgramODT_D: Done
07.361: mct_BeforeDramInit_Prod_D: Done
07.361: mct_DramInit_Sw_D: Start
07.361: DIMM 1 RttWr: 2
07.361: mct_SendMrsCmd: Start
07.361: mct_SendMrsCmd: Done
07.361: mct_SendMrsCmd: Start
07.361: mct_SendMrsCmd: Done
07.361: DIMM 1 RttNom: 1
07.362: mct_SendMrsCmd: Start
07.362: mct_SendMrsCmd: Done
07.362: mct_SendMrsCmd: Start
07.362: mct_SendMrsCmd: Done
07.362: DIMM 1 RttWr: 2
07.362: mct_SendMrsCmd: Start
07.362: mct_SendMrsCmd: Done
07.362: mct_SendMrsCmd: Start
07.362: mct_SendMrsCmd: Done
07.362: DIMM 1 RttNom: 1
07.362: mct_SendMrsCmd: Start
07.362: mct_SendMrsCmd: Done
07.362: mct_SendMrsCmd: Start
07.362: mct_SendMrsCmd: Done
07.362: mct_DramInit_Sw_D: Done
07.362: DIMM 1 RttNom: 1
07.362: DIMM 1 RttNom: 1
07.362: DIMM 1 RttWr: 2
07.362: DIMM 1 RttWr: 2
07.362: DIMM 1 RttNom: 1
07.362: DIMM 1 RttNom: 1
07.362: DIMM 1 RttWr: 2
07.362: DIMM 1 RttWr: 2
07.362: DIMM 1 RttNom: 1
07.362: DIMM 1 RttNom: 1
07.362: DIMM 1 RttWr: 2
07.362: DIMM 1 RttWr: 2
07.362: DIMM 1 RttNom: 1
07.362: DIMM 1 RttNom: 1
07.362: DIMM 1 RttWr: 2
07.362: DIMM 1 RttWr: 2
07.363: DIMM 1 RttNom: 1
07.363: DIMM 1 RttNom: 1
07.363: DIMM 1 RttWr: 2
07.363: DIMM 1 RttWr: 2
07.363: DIMM 1 RttNom: 1
07.363: DIMM 1 RttNom: 1
07.363: DIMM 1 RttWr: 2
07.363: DIMM 1 RttWr: 2
07.363: SetTargetFreq: Start
07.363: SetTargetFreq: Node 0: New frequency code: 0012
07.363: ChangeMemClk: Start
07.363: set_2t_configuration: Start
07.363: set_2t_configuration: Done
07.363: mct_BeforePlatformSpec: Start
07.363: mct_BeforePlatformSpec: Done
07.363: mct_PlatformSpec: Start
07.363: mct_PlatformSpec: Done
07.363: set_2t_configuration: Start
07.363: set_2t_configuration: Done
07.363: mct_BeforePlatformSpec: Start
07.363: mct_BeforePlatformSpec: Done
07.363: mct_PlatformSpec: Start
07.363: mct_PlatformSpec: Done
07.363: ChangeMemClk: Done
07.363: phyAssistedMemFnceTraining: Start
07.364: phyAssistedMemFnceTraining: Done
07.364: InitPhyCompensation: DCT 0: Start
07.364: Waiting for predriver calibration to be applied...done!
07.364: InitPhyCompensation: DCT 0: Done
07.364: phyAssistedMemFnceTraining: Start
07.364: phyAssistedMemFnceTraining: Done
07.364: InitPhyCompensation: DCT 1: Start
07.364: Waiting for predriver calibration to be applied...done!
07.364: InitPhyCompensation: DCT 1: Done
07.364: SetTargetFreq: Done
07.364: SPD2ndTiming: Start
07.365: SPD2ndTiming: Done
07.365: mct_BeforeDramInit_Prod_D: Start
07.365: mct_ProgramODT_D: Start
07.365: mct_ProgramODT_D: Done
07.365: mct_BeforeDramInit_Prod_D: Done
07.365: mct_DramInit_Sw_D: Start
07.365: DIMM 1 RttWr: 0
07.365: mct_SendMrsCmd: Start
07.365: mct_SendMrsCmd: Done
07.365: mct_SendMrsCmd: Start
07.365: mct_SendMrsCmd: Done
07.365: DIMM 1 RttNom: 3
07.365: mct_SendMrsCmd: Start
07.365: mct_SendMrsCmd: Done
07.365: mct_SendMrsCmd: Start
07.365: mct_SendMrsCmd: Done
07.365: DIMM 1 RttWr: 0
07.365: mct_SendMrsCmd: Start
07.365: mct_SendMrsCmd: Done
07.365: mct_SendMrsCmd: Start
07.365: mct_SendMrsCmd: Done
07.365: DIMM 1 RttNom: 3
07.365: mct_SendMrsCmd: Start
07.365: mct_SendMrsCmd: Done
07.365: mct_SendMrsCmd: Start
07.365: mct_SendMrsCmd: Done
07.365: mct_DramInit_Sw_D: Done
07.366: DIMM 1 RttNom: 3
07.366: DIMM 1 RttNom: 3
07.366: DIMM 1 RttWr: 0
07.366: DIMM 1 RttWr: 0
07.366: DIMM 1 RttNom: 3
07.366: DIMM 1 RttNom: 3
07.366: DIMM 1 RttWr: 0
07.366: DIMM 1 RttWr: 0
07.366: DIMM 1 RttNom: 3
07.366: DIMM 1 RttNom: 3
07.366: DIMM 1 RttWr: 0
07.366: DIMM 1 RttWr: 0
07.366: DIMM 1 RttNom: 3
07.366: DIMM 1 RttNom: 3
07.366: DIMM 1 RttWr: 0
07.366: DIMM 1 RttWr: 0
07.366: SPD2ndTiming: Start
07.367: SPD2ndTiming: Done
07.367: mct_BeforeDramInit_Prod_D: Start
07.367: mct_ProgramODT_D: Start
07.367: mct_ProgramODT_D: Done
07.367: mct_BeforeDramInit_Prod_D: Done
07.367: mct_DramInit_Sw_D: Start
07.367: DIMM 1 RttWr: 0
07.367: mct_SendMrsCmd: Start
07.367: mct_SendMrsCmd: Done
07.367: mct_SendMrsCmd: Start
07.367: mct_SendMrsCmd: Done
07.367: DIMM 1 RttNom: 3
07.367: mct_SendMrsCmd: Start
07.367: mct_SendMrsCmd: Done
07.367: mct_SendMrsCmd: Start
07.367: mct_SendMrsCmd: Done
07.367: DIMM 1 RttWr: 0
07.367: mct_SendMrsCmd: Start
07.367: mct_SendMrsCmd: Done
07.367: mct_SendMrsCmd: Start
07.367: mct_SendMrsCmd: Done
07.367: DIMM 1 RttNom: 3
07.367: mct_SendMrsCmd: Start
07.367: mct_SendMrsCmd: Done
07.367: mct_SendMrsCmd: Start
07.367: mct_SendMrsCmd: Done
07.367: mct_DramInit_Sw_D: Done
07.367: DIMM 1 RttNom: 3
07.367: DIMM 1 RttNom: 3
07.367: DIMM 1 RttWr: 0
07.367: DIMM 1 RttWr: 0
07.367: DIMM 1 RttNom: 3
07.367: DIMM 1 RttNom: 3
07.367: DIMM 1 RttWr: 0
07.367: DIMM 1 RttWr: 0
07.368: DIMM 1 RttNom: 3
07.368: DIMM 1 RttNom: 3
07.368: DIMM 1 RttWr: 0
07.368: DIMM 1 RttWr: 0
07.368: DIMM 1 RttNom: 3
07.368: DIMM 1 RttNom: 3
07.368: DIMM 1 RttWr: 0
07.368: DIMM 1 RttWr: 0
07.368: DIMM 1 RttNom: 3
07.368: DIMM 1 RttNom: 3
07.368: DIMM 1 RttWr: 0
07.368: DIMM 1 RttWr: 0
07.368: DIMM 1 RttNom: 3
07.368: DIMM 1 RttNom: 3
07.368: DIMM 1 RttWr: 0
07.368: DIMM 1 RttWr: 0
07.369: activate_spd_rom() for node 01
07.369: enable_spd_node1()
07.369: SetTargetFreq: Start
07.369: SetTargetFreq: Node 1: New frequency code: 0006
07.369: ChangeMemClk: Start
07.369: set_2t_configuration: Start
07.369: set_2t_configuration: Done
07.369: mct_BeforePlatformSpec: Start
07.369: mct_BeforePlatformSpec: Done
07.369: mct_PlatformSpec: Start
07.369: mct_PlatformSpec: Done
07.369: set_2t_configuration: Start
07.369: set_2t_configuration: Done
07.369: mct_BeforePlatformSpec: Start
07.369: mct_BeforePlatformSpec: Done
07.369: mct_PlatformSpec: Start
07.370: mct_PlatformSpec: Done
07.370: ChangeMemClk: Done
07.370: phyAssistedMemFnceTraining: Start
07.370: phyAssistedMemFnceTraining: Done
07.370: InitPhyCompensation: DCT 0: Start
07.370: Waiting for predriver calibration to be applied...done!
07.370: InitPhyCompensation: DCT 0: Done
07.370: phyAssistedMemFnceTraining: Start
07.370: phyAssistedMemFnceTraining: Done
07.370: InitPhyCompensation: DCT 1: Start
07.370: Waiting for predriver calibration to be applied...done!
07.370: InitPhyCompensation: DCT 1: Done
07.371: SetTargetFreq: Done
07.371: SPD2ndTiming: Start
07.371: SPD2ndTiming: Done
07.371: mct_BeforeDramInit_Prod_D: Start
07.371: mct_ProgramODT_D: Start
07.371: mct_ProgramODT_D: Done
07.371: mct_BeforeDramInit_Prod_D: Done
07.372: mct_DramInit_Sw_D: Start
07.371: DIMM 1 RttWr: 0
07.371: mct_SendMrsCmd: Start
07.371: mct_SendMrsCmd: Done
07.371: mct_SendMrsCmd: Start
07.372: mct_SendMrsCmd: Done
07.372: DIMM 1 RttNom: 2
07.372: mct_SendMrsCmd: Start
07.372: mct_SendMrsCmd: Done
07.372: mct_SendMrsCmd: Start
07.372: mct_SendMrsCmd: Done
07.372: DIMM 1 RttWr: 0
07.372: mct_SendMrsCmd: Start
07.372: mct_SendMrsCmd: Done
07.372: mct_SendMrsCmd: Start
07.372: mct_SendMrsCmd: Done
07.372: DIMM 1 RttNom: 2
07.372: mct_SendMrsCmd: Start
07.372: mct_SendMrsCmd: Done
07.372: mct_SendMrsCmd: Start
07.372: mct_SendMrsCmd: Done
07.372: mct_DramInit_Sw_D: Done
07.372: DIMM 1 RttNom: 2
07.372: DIMM 1 RttNom: 2
07.372: DIMM 1 RttWr: 0
07.372: DIMM 1 RttWr: 0
07.372: DIMM 1 RttNom: 2
07.372: DIMM 1 RttNom: 2
07.372: DIMM 1 RttWr: 0
07.372: DIMM 1 RttWr: 0
07.373: DIMM 1 RttNom: 2
07.373: DIMM 1 RttNom: 2
07.373: DIMM 1 RttWr: 0
07.373: DIMM 1 RttWr: 0
07.373: DIMM 1 RttNom: 2
07.373: DIMM 1 RttNom: 2
07.373: DIMM 1 RttWr: 0
07.373: DIMM 1 RttWr: 0
07.373: SPD2ndTiming: Start
07.373: SPD2ndTiming: Done
07.373: mct_BeforeDramInit_Prod_D: Start
07.373: mct_ProgramODT_D: Start
07.373: mct_ProgramODT_D: Done
07.373: mct_BeforeDramInit_Prod_D: Done
07.373: mct_DramInit_Sw_D: Start
07.373: DIMM 1 RttWr: 0
07.373: mct_SendMrsCmd: Start
07.374: mct_SendMrsCmd: Done
07.374: mct_SendMrsCmd: Start
07.374: mct_SendMrsCmd: Done
07.374: DIMM 1 RttNom: 2
07.374: mct_SendMrsCmd: Start
07.374: mct_SendMrsCmd: Done
07.374: mct_SendMrsCmd: Start
07.374: mct_SendMrsCmd: Done
07.374: DIMM 1 RttWr: 0
07.374: mct_SendMrsCmd: Start
07.374: mct_SendMrsCmd: Done
07.374: mct_SendMrsCmd: Start
07.374: mct_SendMrsCmd: Done
07.374: DIMM 1 RttNom: 2
07.374: mct_SendMrsCmd: Start
07.374: mct_SendMrsCmd: Done
07.374: mct_SendMrsCmd: Start
07.374: mct_SendMrsCmd: Done
07.374: mct_DramInit_Sw_D: Done
07.374: DIMM 1 RttNom: 2
07.374: DIMM 1 RttNom: 2
07.374: DIMM 1 RttWr: 0
07.374: DIMM 1 RttWr: 0
07.374: DIMM 1 RttNom: 2
07.374: DIMM 1 RttNom: 2
07.374: DIMM 1 RttWr: 0
07.374: DIMM 1 RttWr: 0
07.374: DIMM 1 RttNom: 2
07.375: DIMM 1 RttNom: 2
07.375: DIMM 1 RttWr: 0
07.375: DIMM 1 RttWr: 0
07.375: DIMM 1 RttNom: 2
07.375: DIMM 1 RttNom: 2
07.375: DIMM 1 RttWr: 0
07.375: DIMM 1 RttWr: 0
07.375: DIMM 1 RttNom: 2
07.375: DIMM 1 RttNom: 2
07.375: DIMM 1 RttWr: 0
07.375: DIMM 1 RttWr: 0
07.375: DIMM 1 RttNom: 2
07.375: DIMM 1 RttNom: 2
07.375: DIMM 1 RttWr: 0
07.375: DIMM 1 RttWr: 0
07.375: SetTargetFreq: Start
07.375: SetTargetFreq: Node 1: New frequency code: 000a
07.375: ChangeMemClk: Start
07.375: set_2t_configuration: Start
07.375: set_2t_configuration: Done
07.375: mct_BeforePlatformSpec: Start
07.375: mct_BeforePlatformSpec: Done
07.376: mct_PlatformSpec: Start
07.376: mct_PlatformSpec: Done
07.376: set_2t_configuration: Start
07.376: set_2t_configuration: Done
07.376: mct_BeforePlatformSpec: Start
07.376: mct_BeforePlatformSpec: Done
07.376: mct_PlatformSpec: Start
07.376: mct_PlatformSpec: Done
07.376: ChangeMemClk: Done
07.376: phyAssistedMemFnceTraining: Start
07.376: phyAssistedMemFnceTraining: Done
07.376: InitPhyCompensation: DCT 0: Start
07.376: Waiting for predriver calibration to be applied...done!
07.376: InitPhyCompensation: DCT 0: Done
07.376: phyAssistedMemFnceTraining: Start
07.376: phyAssistedMemFnceTraining: Done
07.376: InitPhyCompensation: DCT 1: Start
07.377: Waiting for predriver calibration to be applied...done!
07.377: InitPhyCompensation: DCT 1: Done
07.377: SetTargetFreq: Done
07.377: SPD2ndTiming: Start
07.377: SPD2ndTiming: Done
07.377: mct_BeforeDramInit_Prod_D: Start
07.377: mct_ProgramODT_D: Start
07.377: mct_ProgramODT_D: Done
07.377: mct_BeforeDramInit_Prod_D: Done
07.377: mct_DramInit_Sw_D: Start
07.377: DIMM 1 RttWr: 0
07.377: mct_SendMrsCmd: Start
07.377: mct_SendMrsCmd: Done
07.377: mct_SendMrsCmd: Start
07.377: mct_SendMrsCmd: Done
07.378: DIMM 1 RttNom: 1
07.378: mct_SendMrsCmd: Start
07.378: mct_SendMrsCmd: Done
07.378: mct_SendMrsCmd: Start
07.378: mct_SendMrsCmd: Done
07.378: DIMM 1 RttWr: 0
07.378: mct_SendMrsCmd: Start
07.378: mct_SendMrsCmd: Done
07.378: mct_SendMrsCmd: Start
07.378: mct_SendMrsCmd: Done
07.378: DIMM 1 RttNom: 1
07.378: mct_SendMrsCmd: Start
07.378: mct_SendMrsCmd: Done
07.378: mct_SendMrsCmd: Start
07.378: mct_SendMrsCmd: Done
07.378: mct_DramInit_Sw_D: Done
07.378: DIMM 1 RttNom: 1
07.378: DIMM 1 RttNom: 1
07.378: DIMM 1 RttWr: 0
07.378: DIMM 1 RttWr: 0
07.378: DIMM 1 RttNom: 1
07.378: DIMM 1 RttNom: 1
07.378: DIMM 1 RttWr: 0
07.378: DIMM 1 RttWr: 0
07.379: DIMM 1 RttNom: 1
07.379: DIMM 1 RttNom: 1
07.379: DIMM 1 RttWr: 0
07.379: DIMM 1 RttWr: 0
07.379: DIMM 1 RttNom: 1
07.379: DIMM 1 RttNom: 1
07.379: DIMM 1 RttWr: 0
07.379: DIMM 1 RttWr: 0
07.379: SPD2ndTiming: Start
07.379: SPD2ndTiming: Done
07.379: mct_BeforeDramInit_Prod_D: Start
07.379: mct_ProgramODT_D: Start
07.379: mct_ProgramODT_D: Done
07.379: mct_BeforeDramInit_Prod_D: Done
07.379: mct_DramInit_Sw_D: Start
07.379: DIMM 1 RttWr: 0
07.379: mct_SendMrsCmd: Start
07.379: mct_SendMrsCmd: Done
07.379: mct_SendMrsCmd: Start
07.379: mct_SendMrsCmd: Done
07.379: DIMM 1 RttNom: 1
07.379: mct_SendMrsCmd: Start
07.379: mct_SendMrsCmd: Done
07.379: mct_SendMrsCmd: Start
07.380: mct_SendMrsCmd: Done
07.379: DIMM 1 RttWr: 0
07.380: mct_SendMrsCmd: Start
07.380: mct_SendMrsCmd: Done
07.380: mct_SendMrsCmd: Start
07.380: mct_SendMrsCmd: Done
07.380: DIMM 1 RttNom: 1
07.380: mct_SendMrsCmd: Start
07.380: mct_SendMrsCmd: Done
07.380: mct_SendMrsCmd: Start
07.380: mct_SendMrsCmd: Done
07.380: mct_DramInit_Sw_D: Done
07.380: DIMM 1 RttNom: 1
07.380: DIMM 1 RttNom: 1
07.380: DIMM 1 RttWr: 0
07.380: DIMM 1 RttWr: 0
07.380: DIMM 1 RttNom: 1
07.380: DIMM 1 RttNom: 1
07.380: DIMM 1 RttWr: 0
07.380: DIMM 1 RttWr: 0
07.380: DIMM 1 RttNom: 1
07.380: DIMM 1 RttNom: 1
07.380: DIMM 1 RttWr: 0
07.380: DIMM 1 RttWr: 0
07.380: DIMM 1 RttNom: 1
07.380: DIMM 1 RttNom: 1
07.380: DIMM 1 RttWr: 0
07.380: DIMM 1 RttWr: 0
07.381: DIMM 1 RttNom: 1
07.381: DIMM 1 RttNom: 1
07.381: DIMM 1 RttWr: 0
07.381: DIMM 1 RttWr: 0
07.381: DIMM 1 RttNom: 1
07.381: DIMM 1 RttNom: 1
07.381: DIMM 1 RttWr: 0
07.381: DIMM 1 RttWr: 0
07.381: SetTargetFreq: Start
07.381: SetTargetFreq: Node 1: New frequency code: 000e
07.381: ChangeMemClk: Start
07.381: set_2t_configuration: Start
07.381: set_2t_configuration: Done
07.381: mct_BeforePlatformSpec: Start
07.381: mct_BeforePlatformSpec: Done
07.381: mct_PlatformSpec: Start
07.381: mct_PlatformSpec: Done
07.381: set_2t_configuration: Start
07.381: set_2t_configuration: Done
07.381: mct_BeforePlatformSpec: Start
07.381: mct_BeforePlatformSpec: Done
07.381: mct_PlatformSpec: Start
07.381: mct_PlatformSpec: Done
07.381: ChangeMemClk: Done
07.381: phyAssistedMemFnceTraining: Start
07.382: phyAssistedMemFnceTraining: Done
07.381: InitPhyCompensation: DCT 0: Start
07.382: Waiting for predriver calibration to be applied...done!
07.382: InitPhyCompensation: DCT 0: Done
07.382: phyAssistedMemFnceTraining: Start
07.382: phyAssistedMemFnceTraining: Done
07.382: InitPhyCompensation: DCT 1: Start
07.382: Waiting for predriver calibration to be applied...done!
07.382: InitPhyCompensation: DCT 1: Done
07.382: SetTargetFreq: Done
07.382: SPD2ndTiming: Start
07.383: SPD2ndTiming: Done
07.383: mct_BeforeDramInit_Prod_D: Start
07.383: mct_ProgramODT_D: Start
07.383: mct_ProgramODT_D: Done
07.383: mct_BeforeDramInit_Prod_D: Done
07.383: mct_DramInit_Sw_D: Start
07.383: DIMM 1 RttWr: 2
07.383: mct_SendMrsCmd: Start
07.383: mct_SendMrsCmd: Done
07.383: mct_SendMrsCmd: Start
07.383: mct_SendMrsCmd: Done
07.383: DIMM 1 RttNom: 1
07.383: mct_SendMrsCmd: Start
07.383: mct_SendMrsCmd: Done
07.383: mct_SendMrsCmd: Start
07.383: mct_SendMrsCmd: Done
07.383: DIMM 1 RttWr: 2
07.383: mct_SendMrsCmd: Start
07.383: mct_SendMrsCmd: Done
07.383: mct_SendMrsCmd: Start
07.383: mct_SendMrsCmd: Done
07.383: DIMM 1 RttNom: 1
07.383: mct_SendMrsCmd: Start
07.383: mct_SendMrsCmd: Done
07.383: mct_SendMrsCmd: Start
07.383: mct_SendMrsCmd: Done
07.383: mct_DramInit_Sw_D: Done
07.384: DIMM 1 RttNom: 1
07.384: DIMM 1 RttNom: 1
07.384: DIMM 1 RttWr: 2
07.384: DIMM 1 RttWr: 2
07.384: DIMM 1 RttNom: 1
07.384: DIMM 1 RttNom: 1
07.384: DIMM 1 RttWr: 2
07.384: DIMM 1 RttWr: 2
07.384: DIMM 1 RttNom: 1
07.384: DIMM 1 RttNom: 1
07.384: DIMM 1 RttWr: 2
07.384: DIMM 1 RttWr: 2
07.384: DIMM 1 RttNom: 1
07.384: DIMM 1 RttNom: 1
07.384: DIMM 1 RttWr: 2
07.384: DIMM 1 RttWr: 2
07.384: SPD2ndTiming: Start
07.385: SPD2ndTiming: Done
07.385: mct_BeforeDramInit_Prod_D: Start
07.385: mct_ProgramODT_D: Start
07.385: mct_ProgramODT_D: Done
07.385: mct_BeforeDramInit_Prod_D: Done
07.385: mct_DramInit_Sw_D: Start
07.385: DIMM 1 RttWr: 2
07.385: mct_SendMrsCmd: Start
07.385: mct_SendMrsCmd: Done
07.385: mct_SendMrsCmd: Start
07.385: mct_SendMrsCmd: Done
07.385: DIMM 1 RttNom: 1
07.385: mct_SendMrsCmd: Start
07.385: mct_SendMrsCmd: Done
07.385: mct_SendMrsCmd: Start
07.385: mct_SendMrsCmd: Done
07.385: DIMM 1 RttWr: 2
07.385: mct_SendMrsCmd: Start
07.385: mct_SendMrsCmd: Done
07.385: mct_SendMrsCmd: Start
07.385: mct_SendMrsCmd: Done
07.385: DIMM 1 RttNom: 1
07.385: mct_SendMrsCmd: Start
07.385: mct_SendMrsCmd: Done
07.385: mct_SendMrsCmd: Start
07.385: mct_SendMrsCmd: Done
07.385: mct_DramInit_Sw_D: Done
07.385: DIMM 1 RttNom: 1
07.385: DIMM 1 RttNom: 1
07.385: DIMM 1 RttWr: 2
07.385: DIMM 1 RttWr: 2
07.385: DIMM 1 RttNom: 1
07.385: DIMM 1 RttNom: 1
07.385: DIMM 1 RttWr: 2
07.385: DIMM 1 RttWr: 2
07.386: DIMM 1 RttNom: 1
07.386: DIMM 1 RttNom: 1
07.386: DIMM 1 RttWr: 2
07.386: DIMM 1 RttWr: 2
07.386: DIMM 1 RttNom: 1
07.386: DIMM 1 RttNom: 1
07.386: DIMM 1 RttWr: 2
07.386: DIMM 1 RttWr: 2
07.386: DIMM 1 RttNom: 1
07.386: DIMM 1 RttNom: 1
07.386: DIMM 1 RttWr: 2
07.386: DIMM 1 RttWr: 2
07.386: DIMM 1 RttNom: 1
07.386: DIMM 1 RttNom: 1
07.386: DIMM 1 RttWr: 2
07.386: DIMM 1 RttWr: 2
07.386: SetTargetFreq: Start
07.386: SetTargetFreq: Node 1: New frequency code: 0012
07.387: ChangeMemClk: Start
07.387: set_2t_configuration: Start
07.387: set_2t_configuration: Done
07.387: mct_BeforePlatformSpec: Start
07.387: mct_BeforePlatformSpec: Done
07.387: mct_PlatformSpec: Start
07.387: mct_PlatformSpec: Done
07.387: set_2t_configuration: Start
07.387: set_2t_configuration: Done
07.387: mct_BeforePlatformSpec: Start
07.387: mct_BeforePlatformSpec: Done
07.387: mct_PlatformSpec: Start
07.387: mct_PlatformSpec: Done
07.387: ChangeMemClk: Done
07.387: phyAssistedMemFnceTraining: Start
07.387: phyAssistedMemFnceTraining: Done
07.387: InitPhyCompensation: DCT 0: Start
07.387: Waiting for predriver calibration to be applied...done!
07.387: InitPhyCompensation: DCT 0: Done
07.387: phyAssistedMemFnceTraining: Start
07.388: phyAssistedMemFnceTraining: Done
07.388: InitPhyCompensation: DCT 1: Start
07.388: Waiting for predriver calibration to be applied...done!
07.388: InitPhyCompensation: DCT 1: Done
07.388: SetTargetFreq: Done
07.388: SPD2ndTiming: Start
07.388: SPD2ndTiming: Done
07.388: mct_BeforeDramInit_Prod_D: Start
07.388: mct_ProgramODT_D: Start
07.389: mct_ProgramODT_D: Done
07.388: mct_BeforeDramInit_Prod_D: Done
07.389: mct_DramInit_Sw_D: Start
07.389: DIMM 1 RttWr: 0
07.389: mct_SendMrsCmd: Start
07.389: mct_SendMrsCmd: Done
07.389: mct_SendMrsCmd: Start
07.389: mct_SendMrsCmd: Done
07.389: DIMM 1 RttNom: 3
07.389: mct_SendMrsCmd: Start
07.389: mct_SendMrsCmd: Done
07.389: mct_SendMrsCmd: Start
07.389: mct_SendMrsCmd: Done
07.389: DIMM 1 RttWr: 0
07.389: mct_SendMrsCmd: Start
07.389: mct_SendMrsCmd: Done
07.389: mct_SendMrsCmd: Start
07.389: mct_SendMrsCmd: Done
07.389: DIMM 1 RttNom: 3
07.389: mct_SendMrsCmd: Start
07.389: mct_SendMrsCmd: Done
07.389: mct_SendMrsCmd: Start
07.389: mct_SendMrsCmd: Done
07.389: mct_DramInit_Sw_D: Done
07.389: DIMM 1 RttNom: 3
07.389: DIMM 1 RttNom: 3
07.389: DIMM 1 RttWr: 0
07.389: DIMM 1 RttWr: 0
07.389: DIMM 1 RttNom: 3
07.389: DIMM 1 RttNom: 3
07.389: DIMM 1 RttWr: 0
07.389: DIMM 1 RttWr: 0
07.390: DIMM 1 RttNom: 3
07.390: DIMM 1 RttNom: 3
07.390: DIMM 1 RttWr: 0
07.390: DIMM 1 RttWr: 0
07.390: DIMM 1 RttNom: 3
07.390: DIMM 1 RttNom: 3
07.390: DIMM 1 RttWr: 0
07.390: DIMM 1 RttWr: 0
07.390: SPD2ndTiming: Start
07.390: SPD2ndTiming: Done
07.390: mct_BeforeDramInit_Prod_D: Start
07.390: mct_ProgramODT_D: Start
07.390: mct_ProgramODT_D: Done
07.390: mct_BeforeDramInit_Prod_D: Done
07.390: mct_DramInit_Sw_D: Start
07.390: DIMM 1 RttWr: 0
07.390: mct_SendMrsCmd: Start
07.390: mct_SendMrsCmd: Done
07.390: mct_SendMrsCmd: Start
07.390: mct_SendMrsCmd: Done
07.391: DIMM 1 RttNom: 3
07.390: mct_SendMrsCmd: Start
07.390: mct_SendMrsCmd: Done
07.391: mct_SendMrsCmd: Start
07.391: mct_SendMrsCmd: Done
07.391: DIMM 1 RttWr: 0
07.391: mct_SendMrsCmd: Start
07.391: mct_SendMrsCmd: Done
07.391: mct_SendMrsCmd: Start
07.391: mct_SendMrsCmd: Done
07.391: DIMM 1 RttNom: 3
07.391: mct_SendMrsCmd: Start
07.391: mct_SendMrsCmd: Done
07.391: mct_SendMrsCmd: Start
07.391: mct_SendMrsCmd: Done
07.391: mct_DramInit_Sw_D: Done
07.391: DIMM 1 RttNom: 3
07.391: DIMM 1 RttNom: 3
07.391: DIMM 1 RttWr: 0
07.391: DIMM 1 RttWr: 0
07.391: DIMM 1 RttNom: 3
07.391: DIMM 1 RttNom: 3
07.391: DIMM 1 RttWr: 0
07.391: DIMM 1 RttWr: 0
07.391: DIMM 1 RttNom: 3
07.391: DIMM 1 RttNom: 3
07.391: DIMM 1 RttWr: 0
07.391: DIMM 1 RttWr: 0
07.391: DIMM 1 RttNom: 3
07.391: DIMM 1 RttNom: 3
07.391: DIMM 1 RttWr: 0
07.391: DIMM 1 RttWr: 0
07.392: DIMM 1 RttNom: 3
07.392: DIMM 1 RttNom: 3
07.392: DIMM 1 RttWr: 0
07.392: DIMM 1 RttWr: 0
07.392: DIMM 1 RttNom: 3
07.392: DIMM 1 RttNom: 3
07.392: DIMM 1 RttWr: 0
07.392: DIMM 1 RttWr: 0
07.392: activate_spd_rom() for node 02
07.392: enable_spd_node2()
07.392: SetTargetFreq: Start
07.393: SetTargetFreq: Node 2: New frequency code: 0006
07.393: ChangeMemClk: Start
07.393: set_2t_configuration: Start
07.393: set_2t_configuration: Done
07.393: mct_BeforePlatformSpec: Start
07.393: mct_BeforePlatformSpec: Done
07.393: mct_PlatformSpec: Start
07.393: mct_PlatformSpec: Done
07.393: set_2t_configuration: Start
07.393: set_2t_configuration: Done
07.393: mct_BeforePlatformSpec: Start
07.393: mct_BeforePlatformSpec: Done
07.393: mct_PlatformSpec: Start
07.393: mct_PlatformSpec: Done
07.393: ChangeMemClk: Done
07.393: phyAssistedMemFnceTraining: Start
07.393: phyAssistedMemFnceTraining: Done
07.393: InitPhyCompensation: DCT 0: Start
07.393: Waiting for predriver calibration to be applied...done!
07.393: InitPhyCompensation: DCT 0: Done
07.393: phyAssistedMemFnceTraining: Start
07.394: phyAssistedMemFnceTraining: Done
07.394: InitPhyCompensation: DCT 1: Start
07.394: Waiting for predriver calibration to be applied...done!
07.394: InitPhyCompensation: DCT 1: Done
07.394: SetTargetFreq: Done
07.394: SPD2ndTiming: Start
07.395: SPD2ndTiming: Done
07.395: mct_BeforeDramInit_Prod_D: Start
07.395: mct_ProgramODT_D: Start
07.395: mct_ProgramODT_D: Done
07.395: mct_BeforeDramInit_Prod_D: Done
07.395: mct_DramInit_Sw_D: Start
07.395: DIMM 1 RttWr: 0
07.395: mct_SendMrsCmd: Start
07.395: mct_SendMrsCmd: Done
07.395: mct_SendMrsCmd: Start
07.395: mct_SendMrsCmd: Done
07.395: DIMM 1 RttNom: 2
07.395: mct_SendMrsCmd: Start
07.395: mct_SendMrsCmd: Done
07.395: mct_SendMrsCmd: Start
07.395: mct_SendMrsCmd: Done
07.395: DIMM 1 RttWr: 0
07.395: mct_SendMrsCmd: Start
07.395: mct_SendMrsCmd: Done
07.395: mct_SendMrsCmd: Start
07.395: mct_SendMrsCmd: Done
07.395: DIMM 1 RttNom: 2
07.395: mct_SendMrsCmd: Start
07.395: mct_SendMrsCmd: Done
07.395: mct_SendMrsCmd: Start
07.395: mct_SendMrsCmd: Done
07.395: mct_DramInit_Sw_D: Done
07.396: DIMM 1 RttNom: 2
07.396: DIMM 1 RttNom: 2
07.396: DIMM 1 RttWr: 0
07.396: DIMM 1 RttWr: 0
07.396: DIMM 1 RttNom: 2
07.396: DIMM 1 RttNom: 2
07.396: DIMM 1 RttWr: 0
07.396: DIMM 1 RttWr: 0
07.396: DIMM 1 RttNom: 2
07.396: DIMM 1 RttNom: 2
07.396: DIMM 1 RttWr: 0
07.396: DIMM 1 RttWr: 0
07.396: DIMM 1 RttNom: 2
07.396: DIMM 1 RttNom: 2
07.397: DIMM 1 RttWr: 0
07.397: DIMM 1 RttWr: 0
07.397: SPD2ndTiming: Start
07.397: SPD2ndTiming: Done
07.397: mct_BeforeDramInit_Prod_D: Start
07.397: mct_ProgramODT_D: Start
07.397: mct_ProgramODT_D: Done
07.397: mct_BeforeDramInit_Prod_D: Done
07.397: mct_DramInit_Sw_D: Start
07.397: DIMM 1 RttWr: 0
07.397: mct_SendMrsCmd: Start
07.397: mct_SendMrsCmd: Done
07.397: mct_SendMrsCmd: Start
07.397: mct_SendMrsCmd: Done
07.397: DIMM 1 RttNom: 2
07.397: mct_SendMrsCmd: Start
07.397: mct_SendMrsCmd: Done
07.397: mct_SendMrsCmd: Start
07.397: mct_SendMrsCmd: Done
07.397: DIMM 1 RttWr: 0
07.397: mct_SendMrsCmd: Start
07.397: mct_SendMrsCmd: Done
07.397: mct_SendMrsCmd: Start
07.397: mct_SendMrsCmd: Done
07.397: DIMM 1 RttNom: 2
07.397: mct_SendMrsCmd: Start
07.397: mct_SendMrsCmd: Done
07.397: mct_SendMrsCmd: Start
07.397: mct_SendMrsCmd: Done
07.397: mct_DramInit_Sw_D: Done
07.398: DIMM 1 RttNom: 2
07.398: DIMM 1 RttNom: 2
07.398: DIMM 1 RttWr: 0
07.398: DIMM 1 RttWr: 0
07.398: DIMM 1 RttNom: 2
07.398: DIMM 1 RttNom: 2
07.398: DIMM 1 RttWr: 0
07.398: DIMM 1 RttWr: 0
07.398: DIMM 1 RttNom: 2
07.398: DIMM 1 RttNom: 2
07.398: DIMM 1 RttWr: 0
07.398: DIMM 1 RttWr: 0
07.398: DIMM 1 RttNom: 2
07.398: DIMM 1 RttNom: 2
07.398: DIMM 1 RttWr: 0
07.398: DIMM 1 RttWr: 0
07.398: DIMM 1 RttNom: 2
07.399: DIMM 1 RttNom: 2
07.399: DIMM 1 RttWr: 0
07.399: DIMM 1 RttWr: 0
07.399: DIMM 1 RttNom: 2
07.399: DIMM 1 RttNom: 2
07.399: DIMM 1 RttWr: 0
07.399: DIMM 1 RttWr: 0
07.399: SetTargetFreq: Start
07.399: SetTargetFreq: Node 2: New frequency code: 000a
07.399: ChangeMemClk: Start
07.399: set_2t_configuration: Start
07.399: set_2t_configuration: Done
07.399: mct_BeforePlatformSpec: Start
07.399: mct_BeforePlatformSpec: Done
07.399: mct_PlatformSpec: Start
07.399: mct_PlatformSpec: Done
07.399: set_2t_configuration: Start
07.399: set_2t_configuration: Done
07.399: mct_BeforePlatformSpec: Start
07.399: mct_BeforePlatformSpec: Done
07.399: mct_PlatformSpec: Start
07.399: mct_PlatformSpec: Done
07.399: ChangeMemClk: Done
07.399: phyAssistedMemFnceTraining: Start
07.400: phyAssistedMemFnceTraining: Done
07.400: InitPhyCompensation: DCT 0: Start
07.400: Waiting for predriver calibration to be applied...done!
07.400: InitPhyCompensation: DCT 0: Done
07.400: phyAssistedMemFnceTraining: Start
07.400: phyAssistedMemFnceTraining: Done
07.400: InitPhyCompensation: DCT 1: Start
07.400: Waiting for predriver calibration to be applied...done!
07.400: InitPhyCompensation: DCT 1: Done
07.400: SetTargetFreq: Done
07.400: SPD2ndTiming: Start
07.401: SPD2ndTiming: Done
07.401: mct_BeforeDramInit_Prod_D: Start
07.401: mct_ProgramODT_D: Start
07.401: mct_ProgramODT_D: Done
07.401: mct_BeforeDramInit_Prod_D: Done
07.401: mct_DramInit_Sw_D: Start
07.401: DIMM 1 RttWr: 0
07.401: mct_SendMrsCmd: Start
07.401: mct_SendMrsCmd: Done
07.401: mct_SendMrsCmd: Start
07.401: mct_SendMrsCmd: Done
07.401: DIMM 1 RttNom: 1
07.401: mct_SendMrsCmd: Start
07.401: mct_SendMrsCmd: Done
07.401: mct_SendMrsCmd: Start
07.401: mct_SendMrsCmd: Done
07.401: DIMM 1 RttWr: 0
07.401: mct_SendMrsCmd: Start
07.401: mct_SendMrsCmd: Done
07.401: mct_SendMrsCmd: Start
07.401: mct_SendMrsCmd: Done
07.401: DIMM 1 RttNom: 1
07.401: mct_SendMrsCmd: Start
07.401: mct_SendMrsCmd: Done
07.401: mct_SendMrsCmd: Start
07.401: mct_SendMrsCmd: Done
07.401: mct_DramInit_Sw_D: Done
07.401: DIMM 1 RttNom: 1
07.401: DIMM 1 RttNom: 1
07.402: DIMM 1 RttWr: 0
07.402: DIMM 1 RttWr: 0
07.402: DIMM 1 RttNom: 1
07.402: DIMM 1 RttNom: 1
07.402: DIMM 1 RttWr: 0
07.402: DIMM 1 RttWr: 0
07.402: DIMM 1 RttNom: 1
07.402: DIMM 1 RttNom: 1
07.402: DIMM 1 RttWr: 0
07.402: DIMM 1 RttWr: 0
07.402: DIMM 1 RttNom: 1
07.402: DIMM 1 RttNom: 1
07.402: DIMM 1 RttWr: 0
07.402: DIMM 1 RttWr: 0
07.402: SPD2ndTiming: Start
07.403: SPD2ndTiming: Done
07.403: mct_BeforeDramInit_Prod_D: Start
07.403: mct_ProgramODT_D: Start
07.403: mct_ProgramODT_D: Done
07.403: mct_BeforeDramInit_Prod_D: Done
07.403: mct_DramInit_Sw_D: Start
07.403: DIMM 1 RttWr: 0
07.403: mct_SendMrsCmd: Start
07.403: mct_SendMrsCmd: Done
07.403: mct_SendMrsCmd: Start
07.403: mct_SendMrsCmd: Done
07.403: DIMM 1 RttNom: 1
07.403: mct_SendMrsCmd: Start
07.403: mct_SendMrsCmd: Done
07.403: mct_SendMrsCmd: Start
07.403: mct_SendMrsCmd: Done
07.403: DIMM 1 RttWr: 0
07.403: mct_SendMrsCmd: Start
07.403: mct_SendMrsCmd: Done
07.403: mct_SendMrsCmd: Start
07.403: mct_SendMrsCmd: Done
07.403: DIMM 1 RttNom: 1
07.403: mct_SendMrsCmd: Start
07.403: mct_SendMrsCmd: Done
07.403: mct_SendMrsCmd: Start
07.403: mct_SendMrsCmd: Done
07.403: mct_DramInit_Sw_D: Done
07.403: DIMM 1 RttNom: 1
07.403: DIMM 1 RttNom: 1
07.403: DIMM 1 RttWr: 0
07.403: DIMM 1 RttWr: 0
07.403: DIMM 1 RttNom: 1
07.403: DIMM 1 RttNom: 1
07.403: DIMM 1 RttWr: 0
07.403: DIMM 1 RttWr: 0
07.404: DIMM 1 RttNom: 1
07.404: DIMM 1 RttNom: 1
07.404: DIMM 1 RttWr: 0
07.404: DIMM 1 RttWr: 0
07.404: DIMM 1 RttNom: 1
07.404: DIMM 1 RttNom: 1
07.404: DIMM 1 RttWr: 0
07.404: DIMM 1 RttWr: 0
07.404: DIMM 1 RttNom: 1
07.404: DIMM 1 RttNom: 1
07.404: DIMM 1 RttWr: 0
07.404: DIMM 1 RttWr: 0
07.404: DIMM 1 RttNom: 1
07.404: DIMM 1 RttNom: 1
07.404: DIMM 1 RttWr: 0
07.404: DIMM 1 RttWr: 0
07.404: SetTargetFreq: Start
07.404: SetTargetFreq: Node 2: New frequency code: 000e
07.404: ChangeMemClk: Start
07.405: set_2t_configuration: Start
07.404: set_2t_configuration: Done
07.405: mct_BeforePlatformSpec: Start
07.405: mct_BeforePlatformSpec: Done
07.405: mct_PlatformSpec: Start
07.405: mct_PlatformSpec: Done
07.405: set_2t_configuration: Start
07.405: set_2t_configuration: Done
07.405: mct_BeforePlatformSpec: Start
07.405: mct_BeforePlatformSpec: Done
07.405: mct_PlatformSpec: Start
07.405: mct_PlatformSpec: Done
07.405: ChangeMemClk: Done
07.405: phyAssistedMemFnceTraining: Start
07.405: phyAssistedMemFnceTraining: Done
07.405: InitPhyCompensation: DCT 0: Start
07.405: Waiting for predriver calibration to be applied...done!
07.405: InitPhyCompensation: DCT 0: Done
07.405: phyAssistedMemFnceTraining: Start
07.405: phyAssistedMemFnceTraining: Done
07.405: InitPhyCompensation: DCT 1: Start
07.406: Waiting for predriver calibration to be applied...done!
07.406: InitPhyCompensation: DCT 1: Done
07.406: SetTargetFreq: Done
07.406: SPD2ndTiming: Start
07.406: SPD2ndTiming: Done
07.406: mct_BeforeDramInit_Prod_D: Start
07.406: mct_ProgramODT_D: Start
07.406: mct_ProgramODT_D: Done
07.406: mct_BeforeDramInit_Prod_D: Done
07.406: mct_DramInit_Sw_D: Start
07.406: DIMM 1 RttWr: 2
07.406: mct_SendMrsCmd: Start
07.406: mct_SendMrsCmd: Done
07.406: mct_SendMrsCmd: Start
07.406: mct_SendMrsCmd: Done
07.407: DIMM 1 RttNom: 1
07.407: mct_SendMrsCmd: Start
07.407: mct_SendMrsCmd: Done
07.407: mct_SendMrsCmd: Start
07.407: mct_SendMrsCmd: Done
07.407: DIMM 1 RttWr: 2
07.407: mct_SendMrsCmd: Start
07.407: mct_SendMrsCmd: Done
07.407: mct_SendMrsCmd: Start
07.407: mct_SendMrsCmd: Done
07.407: DIMM 1 RttNom: 1
07.407: mct_SendMrsCmd: Start
07.407: mct_SendMrsCmd: Done
07.407: mct_SendMrsCmd: Start
07.407: mct_SendMrsCmd: Done
07.407: mct_DramInit_Sw_D: Done
07.407: DIMM 1 RttNom: 1
07.407: DIMM 1 RttNom: 1
07.407: DIMM 1 RttWr: 2
07.407: DIMM 1 RttWr: 2
07.407: DIMM 1 RttNom: 1
07.407: DIMM 1 RttNom: 1
07.407: DIMM 1 RttWr: 2
07.407: DIMM 1 RttWr: 2
07.408: DIMM 1 RttNom: 1
07.408: DIMM 1 RttNom: 1
07.408: DIMM 1 RttWr: 2
07.408: DIMM 1 RttWr: 2
07.408: DIMM 1 RttNom: 1
07.408: DIMM 1 RttNom: 1
07.408: DIMM 1 RttWr: 2
07.408: DIMM 1 RttWr: 2
07.408: SPD2ndTiming: Start
07.408: SPD2ndTiming: Done
07.408: mct_BeforeDramInit_Prod_D: Start
07.408: mct_ProgramODT_D: Start
07.408: mct_ProgramODT_D: Done
07.408: mct_BeforeDramInit_Prod_D: Done
07.408: mct_DramInit_Sw_D: Start
07.408: DIMM 1 RttWr: 2
07.408: mct_SendMrsCmd: Start
07.408: mct_SendMrsCmd: Done
07.408: mct_SendMrsCmd: Start
07.408: mct_SendMrsCmd: Done
07.408: DIMM 1 RttNom: 1
07.408: mct_SendMrsCmd: Start
07.408: mct_SendMrsCmd: Done
07.408: mct_SendMrsCmd: Start
07.408: mct_SendMrsCmd: Done
07.408: DIMM 1 RttWr: 2
07.408: mct_SendMrsCmd: Start
07.408: mct_SendMrsCmd: Done
07.408: mct_SendMrsCmd: Start
07.408: mct_SendMrsCmd: Done
07.408: DIMM 1 RttNom: 1
07.408: mct_SendMrsCmd: Start
07.408: mct_SendMrsCmd: Done
07.408: mct_SendMrsCmd: Start
07.408: mct_SendMrsCmd: Done
07.408: mct_DramInit_Sw_D: Done
07.408: DIMM 1 RttNom: 1
07.408: DIMM 1 RttNom: 1
07.408: DIMM 1 RttWr: 2
07.408: DIMM 1 RttWr: 2
07.409: DIMM 1 RttNom: 1
07.409: DIMM 1 RttNom: 1
07.409: DIMM 1 RttWr: 2
07.409: DIMM 1 RttWr: 2
07.409: DIMM 1 RttNom: 1
07.409: DIMM 1 RttNom: 1
07.409: DIMM 1 RttWr: 2
07.409: DIMM 1 RttWr: 2
07.409: DIMM 1 RttNom: 1
07.409: DIMM 1 RttNom: 1
07.409: DIMM 1 RttWr: 2
07.409: DIMM 1 RttWr: 2
07.409: DIMM 1 RttNom: 1
07.409: DIMM 1 RttNom: 1
07.409: DIMM 1 RttWr: 2
07.409: DIMM 1 RttWr: 2
07.410: DIMM 1 RttNom: 1
07.410: DIMM 1 RttNom: 1
07.410: DIMM 1 RttWr: 2
07.410: DIMM 1 RttWr: 2
07.410: SetTargetFreq: Start
07.410: SetTargetFreq: Node 2: New frequency code: 0012
07.410: ChangeMemClk: Start
07.410: set_2t_configuration: Start
07.410: set_2t_configuration: Done
07.410: mct_BeforePlatformSpec: Start
07.410: mct_BeforePlatformSpec: Done
07.410: mct_PlatformSpec: Start
07.410: mct_PlatformSpec: Done
07.410: set_2t_configuration: Start
07.410: set_2t_configuration: Done
07.410: mct_BeforePlatformSpec: Start
07.410: mct_BeforePlatformSpec: Done
07.410: mct_PlatformSpec: Start
07.410: mct_PlatformSpec: Done
07.410: ChangeMemClk: Done
07.410: phyAssistedMemFnceTraining: Start
07.410: phyAssistedMemFnceTraining: Done
07.410: InitPhyCompensation: DCT 0: Start
07.411: Waiting for predriver calibration to be applied...done!
07.411: InitPhyCompensation: DCT 0: Done
07.411: phyAssistedMemFnceTraining: Start
07.411: phyAssistedMemFnceTraining: Done
07.411: InitPhyCompensation: DCT 1: Start
07.411: Waiting for predriver calibration to be applied...done!
07.411: InitPhyCompensation: DCT 1: Done
07.411: SetTargetFreq: Done
07.411: SPD2ndTiming: Start
07.412: SPD2ndTiming: Done
07.412: mct_BeforeDramInit_Prod_D: Start
07.412: mct_ProgramODT_D: Start
07.412: mct_ProgramODT_D: Done
07.412: mct_BeforeDramInit_Prod_D: Done
07.412: mct_DramInit_Sw_D: Start
07.412: DIMM 1 RttWr: 0
07.412: mct_SendMrsCmd: Start
07.412: mct_SendMrsCmd: Done
07.412: mct_SendMrsCmd: Start
07.412: mct_SendMrsCmd: Done
07.412: DIMM 1 RttNom: 3
07.412: mct_SendMrsCmd: Start
07.412: mct_SendMrsCmd: Done
07.412: mct_SendMrsCmd: Start
07.412: mct_SendMrsCmd: Done
07.412: DIMM 1 RttWr: 0
07.412: mct_SendMrsCmd: Start
07.412: mct_SendMrsCmd: Done
07.412: mct_SendMrsCmd: Start
07.412: mct_SendMrsCmd: Done
07.412: DIMM 1 RttNom: 3
07.412: mct_SendMrsCmd: Start
07.412: mct_SendMrsCmd: Done
07.412: mct_SendMrsCmd: Start
07.412: mct_SendMrsCmd: Done
07.412: mct_DramInit_Sw_D: Done
07.412: DIMM 1 RttNom: 3
07.412: DIMM 1 RttNom: 3
07.413: DIMM 1 RttWr: 0
07.413: DIMM 1 RttWr: 0
07.413: DIMM 1 RttNom: 3
07.413: DIMM 1 RttNom: 3
07.413: DIMM 1 RttWr: 0
07.413: DIMM 1 RttWr: 0
07.413: DIMM 1 RttNom: 3
07.413: DIMM 1 RttNom: 3
07.413: DIMM 1 RttWr: 0
07.413: DIMM 1 RttWr: 0
07.413: DIMM 1 RttNom: 3
07.413: DIMM 1 RttNom: 3
07.413: DIMM 1 RttWr: 0
07.413: DIMM 1 RttWr: 0
07.413: SPD2ndTiming: Start
07.414: SPD2ndTiming: Done
07.414: mct_BeforeDramInit_Prod_D: Start
07.414: mct_ProgramODT_D: Start
07.414: mct_ProgramODT_D: Done
07.414: mct_BeforeDramInit_Prod_D: Done
07.414: mct_DramInit_Sw_D: Start
07.414: DIMM 1 RttWr: 0
07.414: mct_SendMrsCmd: Start
07.414: mct_SendMrsCmd: Done
07.414: mct_SendMrsCmd: Start
07.414: mct_SendMrsCmd: Done
07.414: DIMM 1 RttNom: 3
07.414: mct_SendMrsCmd: Start
07.414: mct_SendMrsCmd: Done
07.414: mct_SendMrsCmd: Start
07.414: mct_SendMrsCmd: Done
07.414: DIMM 1 RttWr: 0
07.414: mct_SendMrsCmd: Start
07.414: mct_SendMrsCmd: Done
07.414: mct_SendMrsCmd: Start
07.414: mct_SendMrsCmd: Done
07.414: DIMM 1 RttNom: 3
07.414: mct_SendMrsCmd: Start
07.414: mct_SendMrsCmd: Done
07.414: mct_SendMrsCmd: Start
07.414: mct_SendMrsCmd: Done
07.414: mct_DramInit_Sw_D: Done
07.414: DIMM 1 RttNom: 3
07.414: DIMM 1 RttNom: 3
07.414: DIMM 1 RttWr: 0
07.414: DIMM 1 RttWr: 0
07.414: DIMM 1 RttNom: 3
07.414: DIMM 1 RttNom: 3
07.414: DIMM 1 RttWr: 0
07.414: DIMM 1 RttWr: 0
07.415: DIMM 1 RttNom: 3
07.415: DIMM 1 RttNom: 3
07.415: DIMM 1 RttWr: 0
07.415: DIMM 1 RttWr: 0
07.415: DIMM 1 RttNom: 3
07.415: DIMM 1 RttNom: 3
07.415: DIMM 1 RttWr: 0
07.415: DIMM 1 RttWr: 0
07.415: DIMM 1 RttNom: 3
07.415: DIMM 1 RttNom: 3
07.415: DIMM 1 RttWr: 0
07.415: DIMM 1 RttWr: 0
07.415: DIMM 1 RttNom: 3
07.415: DIMM 1 RttNom: 3
07.415: DIMM 1 RttWr: 0
07.415: DIMM 1 RttWr: 0
07.416: activate_spd_rom() for node 03
07.416: enable_spd_node3()
07.416: SetTargetFreq: Start
07.416: SetTargetFreq: Node 3: New frequency code: 0006
07.416: ChangeMemClk: Start
07.416: set_2t_configuration: Start
07.416: set_2t_configuration: Done
07.416: mct_BeforePlatformSpec: Start
07.416: mct_BeforePlatformSpec: Done
07.416: mct_PlatformSpec: Start
07.416: mct_PlatformSpec: Done
07.416: set_2t_configuration: Start
07.416: set_2t_configuration: Done
07.416: mct_BeforePlatformSpec: Start
07.416: mct_BeforePlatformSpec: Done
07.416: mct_PlatformSpec: Start
07.416: mct_PlatformSpec: Done
07.416: ChangeMemClk: Done
07.416: phyAssistedMemFnceTraining: Start
07.417: phyAssistedMemFnceTraining: Done
07.417: InitPhyCompensation: DCT 0: Start
07.417: Waiting for predriver calibration to be applied...done!
07.417: InitPhyCompensation: DCT 0: Done
07.417: phyAssistedMemFnceTraining: Start
07.417: phyAssistedMemFnceTraining: Done
07.417: InitPhyCompensation: DCT 1: Start
07.417: Waiting for predriver calibration to be applied...done!
07.417: InitPhyCompensation: DCT 1: Done
07.418: SetTargetFreq: Done
07.418: SPD2ndTiming: Start
07.418: SPD2ndTiming: Done
07.418: mct_BeforeDramInit_Prod_D: Start
07.418: mct_ProgramODT_D: Start
07.418: mct_ProgramODT_D: Done
07.418: mct_BeforeDramInit_Prod_D: Done
07.418: mct_DramInit_Sw_D: Start
07.418: DIMM 1 RttWr: 0
07.418: mct_SendMrsCmd: Start
07.418: mct_SendMrsCmd: Done
07.418: mct_SendMrsCmd: Start
07.418: mct_SendMrsCmd: Done
07.418: DIMM 1 RttNom: 2
07.418: mct_SendMrsCmd: Start
07.418: mct_SendMrsCmd: Done
07.418: mct_SendMrsCmd: Start
07.418: mct_SendMrsCmd: Done
07.418: DIMM 1 RttWr: 0
07.418: mct_SendMrsCmd: Start
07.418: mct_SendMrsCmd: Done
07.418: mct_SendMrsCmd: Start
07.419: mct_SendMrsCmd: Done
07.419: DIMM 1 RttNom: 2
07.419: mct_SendMrsCmd: Start
07.419: mct_SendMrsCmd: Done
07.419: mct_SendMrsCmd: Start
07.419: mct_SendMrsCmd: Done
07.419: mct_DramInit_Sw_D: Done
07.419: DIMM 1 RttNom: 2
07.419: DIMM 1 RttNom: 2
07.419: DIMM 1 RttWr: 0
07.419: DIMM 1 RttWr: 0
07.419: DIMM 1 RttNom: 2
07.419: DIMM 1 RttNom: 2
07.419: DIMM 1 RttWr: 0
07.419: DIMM 1 RttWr: 0
07.420: DIMM 1 RttNom: 2
07.420: DIMM 1 RttNom: 2
07.420: DIMM 1 RttWr: 0
07.420: DIMM 1 RttWr: 0
07.420: DIMM 1 RttNom: 2
07.420: DIMM 1 RttNom: 2
07.420: DIMM 1 RttWr: 0
07.420: DIMM 1 RttWr: 0
07.420: SPD2ndTiming: Start
07.420: SPD2ndTiming: Done
07.420: mct_BeforeDramInit_Prod_D: Start
07.420: mct_ProgramODT_D: Start
07.420: mct_ProgramODT_D: Done
07.420: mct_BeforeDramInit_Prod_D: Done
07.420: mct_DramInit_Sw_D: Start
07.420: DIMM 1 RttWr: 0
07.420: mct_SendMrsCmd: Start
07.420: mct_SendMrsCmd: Done
07.420: mct_SendMrsCmd: Start
07.420: mct_SendMrsCmd: Done
07.420: DIMM 1 RttNom: 2
07.420: mct_SendMrsCmd: Start
07.420: mct_SendMrsCmd: Done
07.420: mct_SendMrsCmd: Start
07.420: mct_SendMrsCmd: Done
07.421: DIMM 1 RttWr: 0
07.420: mct_SendMrsCmd: Start
07.420: mct_SendMrsCmd: Done
07.420: mct_SendMrsCmd: Start
07.421: mct_SendMrsCmd: Done
07.421: DIMM 1 RttNom: 2
07.421: mct_SendMrsCmd: Start
07.421: mct_SendMrsCmd: Done
07.421: mct_SendMrsCmd: Start
07.421: mct_SendMrsCmd: Done
07.421: mct_DramInit_Sw_D: Done
07.421: DIMM 1 RttNom: 2
07.421: DIMM 1 RttNom: 2
07.421: DIMM 1 RttWr: 0
07.421: DIMM 1 RttWr: 0
07.421: DIMM 1 RttNom: 2
07.421: DIMM 1 RttNom: 2
07.421: DIMM 1 RttWr: 0
07.421: DIMM 1 RttWr: 0
07.421: DIMM 1 RttNom: 2
07.421: DIMM 1 RttNom: 2
07.421: DIMM 1 RttWr: 0
07.421: DIMM 1 RttWr: 0
07.421: DIMM 1 RttNom: 2
07.421: DIMM 1 RttNom: 2
07.421: DIMM 1 RttWr: 0
07.421: DIMM 1 RttWr: 0
07.422: DIMM 1 RttNom: 2
07.422: DIMM 1 RttNom: 2
07.422: DIMM 1 RttWr: 0
07.422: DIMM 1 RttWr: 0
07.422: DIMM 1 RttNom: 2
07.422: DIMM 1 RttNom: 2
07.422: DIMM 1 RttWr: 0
07.422: DIMM 1 RttWr: 0
07.422: SetTargetFreq: Start
07.422: SetTargetFreq: Node 3: New frequency code: 000a
07.422: ChangeMemClk: Start
07.422: set_2t_configuration: Start
07.422: set_2t_configuration: Done
07.422: mct_BeforePlatformSpec: Start
07.422: mct_BeforePlatformSpec: Done
07.422: mct_PlatformSpec: Start
07.422: mct_PlatformSpec: Done
07.422: set_2t_configuration: Start
07.422: set_2t_configuration: Done
07.422: mct_BeforePlatformSpec: Start
07.422: mct_BeforePlatformSpec: Done
07.422: mct_PlatformSpec: Start
07.422: mct_PlatformSpec: Done
07.422: ChangeMemClk: Done
07.422: phyAssistedMemFnceTraining: Start
07.423: phyAssistedMemFnceTraining: Done
07.423: InitPhyCompensation: DCT 0: Start
07.423: Waiting for predriver calibration to be applied...done!
07.423: InitPhyCompensation: DCT 0: Done
07.423: phyAssistedMemFnceTraining: Start
07.423: phyAssistedMemFnceTraining: Done
07.423: InitPhyCompensation: DCT 1: Start
07.423: Waiting for predriver calibration to be applied...done!
07.423: InitPhyCompensation: DCT 1: Done
07.424: SetTargetFreq: Done
07.424: SPD2ndTiming: Start
07.424: SPD2ndTiming: Done
07.424: mct_BeforeDramInit_Prod_D: Start
07.424: mct_ProgramODT_D: Start
07.424: mct_ProgramODT_D: Done
07.424: mct_BeforeDramInit_Prod_D: Done
07.424: mct_DramInit_Sw_D: Start
07.424: DIMM 1 RttWr: 0
07.424: mct_SendMrsCmd: Start
07.424: mct_SendMrsCmd: Done
07.424: mct_SendMrsCmd: Start
07.424: mct_SendMrsCmd: Done
07.424: DIMM 1 RttNom: 1
07.424: mct_SendMrsCmd: Start
07.424: mct_SendMrsCmd: Done
07.424: mct_SendMrsCmd: Start
07.424: mct_SendMrsCmd: Done
07.424: DIMM 1 RttWr: 0
07.424: mct_SendMrsCmd: Start
07.424: mct_SendMrsCmd: Done
07.424: mct_SendMrsCmd: Start
07.424: mct_SendMrsCmd: Done
07.424: DIMM 1 RttNom: 1
07.424: mct_SendMrsCmd: Start
07.424: mct_SendMrsCmd: Done
07.424: mct_SendMrsCmd: Start
07.424: mct_SendMrsCmd: Done
07.424: mct_DramInit_Sw_D: Done
07.425: DIMM 1 RttNom: 1
07.425: DIMM 1 RttNom: 1
07.425: DIMM 1 RttWr: 0
07.425: DIMM 1 RttWr: 0
07.425: DIMM 1 RttNom: 1
07.425: DIMM 1 RttNom: 1
07.425: DIMM 1 RttWr: 0
07.425: DIMM 1 RttWr: 0
07.425: DIMM 1 RttNom: 1
07.425: DIMM 1 RttNom: 1
07.425: DIMM 1 RttWr: 0
07.425: DIMM 1 RttWr: 0
07.425: DIMM 1 RttNom: 1
07.425: DIMM 1 RttNom: 1
07.425: DIMM 1 RttWr: 0
07.425: DIMM 1 RttWr: 0
07.425: SPD2ndTiming: Start
07.426: SPD2ndTiming: Done
07.426: mct_BeforeDramInit_Prod_D: Start
07.426: mct_ProgramODT_D: Start
07.426: mct_ProgramODT_D: Done
07.426: mct_BeforeDramInit_Prod_D: Done
07.426: mct_DramInit_Sw_D: Start
07.426: DIMM 1 RttWr: 0
07.426: mct_SendMrsCmd: Start
07.426: mct_SendMrsCmd: Done
07.426: mct_SendMrsCmd: Start
07.426: mct_SendMrsCmd: Done
07.426: DIMM 1 RttNom: 1
07.426: mct_SendMrsCmd: Start
07.426: mct_SendMrsCmd: Done
07.426: mct_SendMrsCmd: Start
07.426: mct_SendMrsCmd: Done
07.426: DIMM 1 RttWr: 0
07.426: mct_SendMrsCmd: Start
07.426: mct_SendMrsCmd: Done
07.426: mct_SendMrsCmd: Start
07.426: mct_SendMrsCmd: Done
07.426: DIMM 1 RttNom: 1
07.426: mct_SendMrsCmd: Start
07.426: mct_SendMrsCmd: Done
07.426: mct_SendMrsCmd: Start
07.426: mct_SendMrsCmd: Done
07.426: mct_DramInit_Sw_D: Done
07.426: DIMM 1 RttNom: 1
07.426: DIMM 1 RttNom: 1
07.426: DIMM 1 RttWr: 0
07.426: DIMM 1 RttWr: 0
07.426: DIMM 1 RttNom: 1
07.426: DIMM 1 RttNom: 1
07.426: DIMM 1 RttWr: 0
07.426: DIMM 1 RttWr: 0
07.427: DIMM 1 RttNom: 1
07.427: DIMM 1 RttNom: 1
07.427: DIMM 1 RttWr: 0
07.427: DIMM 1 RttWr: 0
07.427: DIMM 1 RttNom: 1
07.427: DIMM 1 RttNom: 1
07.427: DIMM 1 RttWr: 0
07.427: DIMM 1 RttWr: 0
07.427: DIMM 1 RttNom: 1
07.427: DIMM 1 RttNom: 1
07.427: DIMM 1 RttWr: 0
07.427: DIMM 1 RttWr: 0
07.427: DIMM 1 RttNom: 1
07.427: DIMM 1 RttNom: 1
07.427: DIMM 1 RttWr: 0
07.427: DIMM 1 RttWr: 0
07.427: SetTargetFreq: Start
07.428: SetTargetFreq: Node 3: New frequency code: 000e
07.428: ChangeMemClk: Start
07.428: set_2t_configuration: Start
07.428: set_2t_configuration: Done
07.428: mct_BeforePlatformSpec: Start
07.428: mct_BeforePlatformSpec: Done
07.428: mct_PlatformSpec: Start
07.428: mct_PlatformSpec: Done
07.428: set_2t_configuration: Start
07.428: set_2t_configuration: Done
07.428: mct_BeforePlatformSpec: Start
07.428: mct_BeforePlatformSpec: Done
07.428: mct_PlatformSpec: Start
07.428: mct_PlatformSpec: Done
07.428: ChangeMemClk: Done
07.428: phyAssistedMemFnceTraining: Start
07.428: phyAssistedMemFnceTraining: Done
07.428: InitPhyCompensation: DCT 0: Start
07.428: Waiting for predriver calibration to be applied...done!
07.428: InitPhyCompensation: DCT 0: Done
07.428: phyAssistedMemFnceTraining: Start
07.429: phyAssistedMemFnceTraining: Done
07.429: InitPhyCompensation: DCT 1: Start
07.429: Waiting for predriver calibration to be applied...done!
07.429: InitPhyCompensation: DCT 1: Done
07.429: SetTargetFreq: Done
07.429: SPD2ndTiming: Start
07.429: SPD2ndTiming: Done
07.429: mct_BeforeDramInit_Prod_D: Start
07.429: mct_ProgramODT_D: Start
07.429: mct_ProgramODT_D: Done
07.429: mct_BeforeDramInit_Prod_D: Done
07.429: mct_DramInit_Sw_D: Start
07.430: DIMM 1 RttWr: 2
07.430: mct_SendMrsCmd: Start
07.430: mct_SendMrsCmd: Done
07.430: mct_SendMrsCmd: Start
07.430: mct_SendMrsCmd: Done
07.430: DIMM 1 RttNom: 1
07.430: mct_SendMrsCmd: Start
07.430: mct_SendMrsCmd: Done
07.430: mct_SendMrsCmd: Start
07.430: mct_SendMrsCmd: Done
07.430: DIMM 1 RttWr: 2
07.430: mct_SendMrsCmd: Start
07.430: mct_SendMrsCmd: Done
07.430: mct_SendMrsCmd: Start
07.430: mct_SendMrsCmd: Done
07.430: DIMM 1 RttNom: 1
07.430: mct_SendMrsCmd: Start
07.430: mct_SendMrsCmd: Done
07.430: mct_SendMrsCmd: Start
07.430: mct_SendMrsCmd: Done
07.430: mct_DramInit_Sw_D: Done
07.430: DIMM 1 RttNom: 1
07.430: DIMM 1 RttNom: 1
07.430: DIMM 1 RttWr: 2
07.430: DIMM 1 RttWr: 2
07.430: DIMM 1 RttNom: 1
07.430: DIMM 1 RttNom: 1
07.430: DIMM 1 RttWr: 2
07.430: DIMM 1 RttWr: 2
07.431: DIMM 1 RttNom: 1
07.431: DIMM 1 RttNom: 1
07.431: DIMM 1 RttWr: 2
07.431: DIMM 1 RttWr: 2
07.431: DIMM 1 RttNom: 1
07.431: DIMM 1 RttNom: 1
07.431: DIMM 1 RttWr: 2
07.431: DIMM 1 RttWr: 2
07.431: SPD2ndTiming: Start
07.431: SPD2ndTiming: Done
07.431: mct_BeforeDramInit_Prod_D: Start
07.431: mct_ProgramODT_D: Start
07.431: mct_ProgramODT_D: Done
07.431: mct_BeforeDramInit_Prod_D: Done
07.431: mct_DramInit_Sw_D: Start
07.431: DIMM 1 RttWr: 2
07.431: mct_SendMrsCmd: Start
07.432: mct_SendMrsCmd: Done
07.432: mct_SendMrsCmd: Start
07.432: mct_SendMrsCmd: Done
07.432: DIMM 1 RttNom: 1
07.432: mct_SendMrsCmd: Start
07.432: mct_SendMrsCmd: Done
07.432: mct_SendMrsCmd: Start
07.432: mct_SendMrsCmd: Done
07.432: DIMM 1 RttWr: 2
07.432: mct_SendMrsCmd: Start
07.432: mct_SendMrsCmd: Done
07.432: mct_SendMrsCmd: Start
07.432: mct_SendMrsCmd: Done
07.432: DIMM 1 RttNom: 1
07.432: mct_SendMrsCmd: Start
07.432: mct_SendMrsCmd: Done
07.432: mct_SendMrsCmd: Start
07.432: mct_SendMrsCmd: Done
07.432: mct_DramInit_Sw_D: Done
07.432: DIMM 1 RttNom: 1
07.432: DIMM 1 RttNom: 1
07.432: DIMM 1 RttWr: 2
07.432: DIMM 1 RttWr: 2
07.432: DIMM 1 RttNom: 1
07.432: DIMM 1 RttNom: 1
07.432: DIMM 1 RttWr: 2
07.432: DIMM 1 RttWr: 2
07.432: DIMM 1 RttNom: 1
07.432: DIMM 1 RttNom: 1
07.432: DIMM 1 RttWr: 2
07.433: DIMM 1 RttWr: 2
07.432: DIMM 1 RttNom: 1
07.432: DIMM 1 RttNom: 1
07.433: DIMM 1 RttWr: 2
07.433: DIMM 1 RttWr: 2
07.433: DIMM 1 RttNom: 1
07.433: DIMM 1 RttNom: 1
07.433: DIMM 1 RttWr: 2
07.433: DIMM 1 RttWr: 2
07.433: DIMM 1 RttNom: 1
07.433: DIMM 1 RttNom: 1
07.433: DIMM 1 RttWr: 2
07.433: DIMM 1 RttWr: 2
07.433: SetTargetFreq: Start
07.433: SetTargetFreq: Node 3: New frequency code: 0012
07.433: ChangeMemClk: Start
07.433: set_2t_configuration: Start
07.433: set_2t_configuration: Done
07.433: mct_BeforePlatformSpec: Start
07.433: mct_BeforePlatformSpec: Done
07.433: mct_PlatformSpec: Start
07.433: mct_PlatformSpec: Done
07.433: set_2t_configuration: Start
07.433: set_2t_configuration: Done
07.433: mct_BeforePlatformSpec: Start
07.433: mct_BeforePlatformSpec: Done
07.433: mct_PlatformSpec: Start
07.434: mct_PlatformSpec: Done
07.434: ChangeMemClk: Done
07.434: phyAssistedMemFnceTraining: Start
07.434: phyAssistedMemFnceTraining: Done
07.434: InitPhyCompensation: DCT 0: Start
07.434: Waiting for predriver calibration to be applied...done!
07.434: InitPhyCompensation: DCT 0: Done
07.434: phyAssistedMemFnceTraining: Start
07.434: phyAssistedMemFnceTraining: Done
07.434: InitPhyCompensation: DCT 1: Start
07.434: Waiting for predriver calibration to be applied...done!
07.434: InitPhyCompensation: DCT 1: Done
07.435: SetTargetFreq: Done
07.435: SPD2ndTiming: Start
07.435: SPD2ndTiming: Done
07.435: mct_BeforeDramInit_Prod_D: Start
07.435: mct_ProgramODT_D: Start
07.435: mct_ProgramODT_D: Done
07.435: mct_BeforeDramInit_Prod_D: Done
07.435: mct_DramInit_Sw_D: Start
07.435: DIMM 1 RttWr: 0
07.435: mct_SendMrsCmd: Start
07.435: mct_SendMrsCmd: Done
07.435: mct_SendMrsCmd: Start
07.435: mct_SendMrsCmd: Done
07.435: DIMM 1 RttNom: 3
07.435: mct_SendMrsCmd: Start
07.435: mct_SendMrsCmd: Done
07.435: mct_SendMrsCmd: Start
07.435: mct_SendMrsCmd: Done
07.435: DIMM 1 RttWr: 0
07.435: mct_SendMrsCmd: Start
07.435: mct_SendMrsCmd: Done
07.436: mct_SendMrsCmd: Start
07.436: mct_SendMrsCmd: Done
07.436: DIMM 1 RttNom: 3
07.436: mct_SendMrsCmd: Start
07.436: mct_SendMrsCmd: Done
07.436: mct_SendMrsCmd: Start
07.436: mct_SendMrsCmd: Done
07.436: mct_DramInit_Sw_D: Done
07.436: DIMM 1 RttNom: 3
07.436: DIMM 1 RttNom: 3
07.436: DIMM 1 RttWr: 0
07.436: DIMM 1 RttWr: 0
07.436: DIMM 1 RttNom: 3
07.436: DIMM 1 RttNom: 3
07.436: DIMM 1 RttWr: 0
07.436: DIMM 1 RttWr: 0
07.437: DIMM 1 RttNom: 3
07.437: DIMM 1 RttNom: 3
07.437: DIMM 1 RttWr: 0
07.437: DIMM 1 RttWr: 0
07.437: DIMM 1 RttNom: 3
07.437: DIMM 1 RttNom: 3
07.437: DIMM 1 RttWr: 0
07.437: DIMM 1 RttWr: 0
07.437: SPD2ndTiming: Start
07.437: SPD2ndTiming: Done
07.437: mct_BeforeDramInit_Prod_D: Start
07.437: mct_ProgramODT_D: Start
07.437: mct_ProgramODT_D: Done
07.437: mct_BeforeDramInit_Prod_D: Done
07.437: mct_DramInit_Sw_D: Start
07.437: DIMM 1 RttWr: 0
07.437: mct_SendMrsCmd: Start
07.437: mct_SendMrsCmd: Done
07.437: mct_SendMrsCmd: Start
07.437: mct_SendMrsCmd: Done
07.437: DIMM 1 RttNom: 3
07.437: mct_SendMrsCmd: Start
07.437: mct_SendMrsCmd: Done
07.437: mct_SendMrsCmd: Start
07.437: mct_SendMrsCmd: Done
07.437: DIMM 1 RttWr: 0
07.437: mct_SendMrsCmd: Start
07.437: mct_SendMrsCmd: Done
07.438: mct_SendMrsCmd: Start
07.438: mct_SendMrsCmd: Done
07.438: DIMM 1 RttNom: 3
07.438: mct_SendMrsCmd: Start
07.438: mct_SendMrsCmd: Done
07.438: mct_SendMrsCmd: Start
07.438: mct_SendMrsCmd: Done
07.438: mct_DramInit_Sw_D: Done
07.438: DIMM 1 RttNom: 3
07.438: DIMM 1 RttNom: 3
07.438: DIMM 1 RttWr: 0
07.438: DIMM 1 RttWr: 0
07.438: DIMM 1 RttNom: 3
07.438: DIMM 1 RttNom: 3
07.438: DIMM 1 RttWr: 0
07.438: DIMM 1 RttWr: 0
07.438: DIMM 1 RttNom: 3
07.438: DIMM 1 RttNom: 3
07.438: DIMM 1 RttWr: 0
07.438: DIMM 1 RttWr: 0
07.438: DIMM 1 RttNom: 3
07.438: DIMM 1 RttNom: 3
07.438: DIMM 1 RttWr: 0
07.438: DIMM 1 RttWr: 0
07.439: DIMM 1 RttNom: 3
07.439: DIMM 1 RttNom: 3
07.439: DIMM 1 RttWr: 0
07.439: DIMM 1 RttWr: 0
07.439: DIMM 1 RttNom: 3
07.439: DIMM 1 RttNom: 3
07.439: DIMM 1 RttWr: 0
07.439: DIMM 1 RttWr: 0
07.440: fam15_receiver_enable_training_seed: using seed: 0054
07.440: fam15_receiver_enable_training_seed: using seed: 0054
07.440: fam15_receiver_enable_training_seed: using seed: 004d
07.440: fam15_receiver_enable_training_seed: using seed: 004d
07.440: fam15_receiver_enable_training_seed: using seed: 004d
07.440: fam15_receiver_enable_training_seed: using seed: 004d
07.440: TrainRcvrEn: Status 2205
07.441: TrainRcvrEn: ErrStatus 0
07.440: TrainRcvrEn: ErrCode 0
07.440: TrainRcvrEn: Done
07.441:=20
07.441: fam15_receiver_enable_training_seed: using seed: 0045
07.441: fam15_receiver_enable_training_seed: using seed: 0045
07.441: fam15_receiver_enable_training_seed: using seed: 0040
07.441: fam15_receiver_enable_training_seed: using seed: 0040
07.441: fam15_receiver_enable_training_seed: using seed: 0040
07.441: fam15_receiver_enable_training_seed: using seed: 0040
07.441: TrainRcvrEn: Status 2005
07.441: TrainRcvrEn: ErrStatus 0
07.441: TrainRcvrEn: ErrCode 0
07.441: TrainRcvrEn: Done
07.441:=20
07.441: fam15_receiver_enable_training_seed: using seed: 0054
07.442: fam15_receiver_enable_training_seed: using seed: 0054
07.442: fam15_receiver_enable_training_seed: using seed: 004d
07.442: fam15_receiver_enable_training_seed: using seed: 004d
07.442: fam15_receiver_enable_training_seed: using seed: 004d
07.442: fam15_receiver_enable_training_seed: using seed: 004d
07.442: TrainRcvrEn: Status 2005
07.442: TrainRcvrEn: ErrStatus 0
07.442: TrainRcvrEn: ErrCode 0
07.442: TrainRcvrEn: Done
07.442:=20
07.442: fam15_receiver_enable_training_seed: using seed: 0045
07.442: fam15_receiver_enable_training_seed: using seed: 0045
07.442: fam15_receiver_enable_training_seed: using seed: 0040
07.443: fam15_receiver_enable_training_seed: using seed: 0040
07.443: fam15_receiver_enable_training_seed: using seed: 0040
07.443: fam15_receiver_enable_training_seed: using seed: 0040
07.443: TrainRcvrEn: Status 2005
07.443: TrainRcvrEn: ErrStatus 0
07.443: TrainRcvrEn: ErrCode 0
07.443: TrainRcvrEn: Done
07.443:=20
12.057: TrainDQSReceiverEnCyc: Status 2205
12.057: TrainDQSReceiverEnCyc: TrainErrors 4000
12.057: TrainDQSReceiverEnCyc: ErrStatus 4000
12.057: TrainDQSReceiverEnCyc: ErrCode 0
12.057: TrainDQSReceiverEnCyc: Done
12.057:=20
17.138: TrainDQSReceiverEnCyc: Status 2005
17.138: TrainDQSReceiverEnCyc: TrainErrors 4000
17.138: TrainDQSReceiverEnCyc: ErrStatus 4000
17.138: TrainDQSReceiverEnCyc: ErrCode 0
17.138: TrainDQSReceiverEnCyc: Done
17.138:=20
23.771: TrainDQSReceiverEnCyc: Status 2005
23.771: TrainDQSReceiverEnCyc: TrainErrors 4000
23.771: TrainDQSReceiverEnCyc: ErrStatus 4000
23.771: TrainDQSReceiverEnCyc: ErrCode 0
23.771: TrainDQSReceiverEnCyc: Done
23.771:=20
29.866: TrainDQSReceiverEnCyc: Status 2005
29.866: TrainDQSReceiverEnCyc: TrainErrors 4000
29.866: TrainDQSReceiverEnCyc: ErrStatus 4000
29.866: TrainDQSReceiverEnCyc: ErrCode 0
29.866: TrainDQSReceiverEnCyc: Done
29.866:=20
29.867: TrainMaxRdLatency: Status 2205
29.868: TrainMaxRdLatency: ErrStatus 4000
29.868: TrainMaxRdLatency: ErrCode 0
29.868: TrainMaxRdLatency: Done
29.868:=20
29.868: TrainMaxRdLatency: Status 2005
29.868: TrainMaxRdLatency: ErrStatus 4000
29.868: TrainMaxRdLatency: ErrCode 0
29.868: TrainMaxRdLatency: Done
29.868:=20
29.869: TrainMaxRdLatency: Status 2005
29.869: TrainMaxRdLatency: ErrStatus 4000
29.869: TrainMaxRdLatency: ErrCode 0
29.869: TrainMaxRdLatency: Done
29.869:=20
29.870: TrainMaxRdLatency: Status 2005
29.870: TrainMaxRdLatency: ErrStatus 4000
29.870: TrainMaxRdLatency: ErrCode 0
29.870: TrainMaxRdLatency: Done
29.870:=20
29.871: FMAP: area COREBOOT found @ 200 (2096640 bytes)
29.871: CBFS: Locating 'cmos_layout.bin'
29.872: CBFS: Found @ offset 2adc0 size dc4
29.874: FMAP: area COREBOOT found @ 200 (2096640 bytes)
29.874: CBFS: Locating 'cmos_layout.bin'
29.874: CBFS: Found @ offset 2adc0 size dc4
29.875: FMAP: area COREBOOT found @ 200 (2096640 bytes)
29.875: CBFS: Locating 'cmos_layout.bin'
29.875: CBFS: Found @ offset 2adc0 size dc4
29.875: FMAP: area COREBOOT found @ 200 (2096640 bytes)
29.875: CBFS: Locating 'cmos_layout.bin'
29.875: CBFS: Found @ offset 2adc0 size dc4
29.876: FMAP: area COREBOOT found @ 200 (2096640 bytes)
29.876: CBFS: Locating 'cmos_layout.bin'
29.876: CBFS: Found @ offset 2adc0 size dc4
29.876: FMAP: area COREBOOT found @ 200 (2096640 bytes)
29.876: CBFS: Locating 'cmos_layout.bin'
29.876: CBFS: Found @ offset 2adc0 size dc4
29.877: FMAP: area COREBOOT found @ 200 (2096640 bytes)
29.877: CBFS: Locating 'cmos_layout.bin'
29.877: CBFS: Found @ offset 2adc0 size dc4
29.877: FMAP: area COREBOOT found @ 200 (2096640 bytes)
29.877: CBFS: Locating 'cmos_layout.bin'
29.877: CBFS: Found @ offset 2adc0 size dc4
29.878: mctAutoInitMCT_D: :OtherTiming
29.880: FMAP: area COREBOOT found @ 200 (2096640 bytes)
29.880: CBFS: Locating 'cmos_layout.bin'
29.880: CBFS: Found @ offset 2adc0 size dc4
29.880: InterleaveNodes_D: Status 2005
29.880: InterleaveNodes_D: ErrStatus 4000
29.881: InterleaveNodes_D: ErrCode 0
29.881: InterleaveNodes_D: Done
29.881:=20
29.881: InterleaveChannels_D: Node 0
29.881: InterleaveChannels_D: Status 2205
29.881: InterleaveChannels_D: ErrStatus 4000
29.881: InterleaveChannels_D: ErrCode 0
29.881: InterleaveChannels_D: Node 1
29.881: InterleaveChannels_D: Status 2005
29.881: InterleaveChannels_D: ErrStatus 4000
29.881: InterleaveChannels_D: ErrCode 0
29.881: InterleaveChannels_D: Node 2
29.881: InterleaveChannels_D: Status 2005
29.881: InterleaveChannels_D: ErrStatus 4000
29.881: InterleaveChannels_D: ErrCode 0
29.881: InterleaveChannels_D: Node 3
29.881: InterleaveChannels_D: Status 2005
29.881: InterleaveChannels_D: ErrStatus 4000
29.881: InterleaveChannels_D: ErrCode 0
29.881: InterleaveChannels_D: Node 4
29.881: InterleaveChannels_D: Status 2000
29.881: InterleaveChannels_D: ErrStatus 0
29.881: InterleaveChannels_D: ErrCode 0
29.881: InterleaveChannels_D: Node 5
29.881: InterleaveChannels_D: Status 2000
29.881: InterleaveChannels_D: ErrStatus 0
29.882: InterleaveChannels_D: ErrCode 0
29.881: InterleaveChannels_D: Node 6
29.881: InterleaveChannels_D: Status 2000
29.881: InterleaveChannels_D: ErrStatus 0
29.882: InterleaveChannels_D: ErrCode 0
29.882: InterleaveChannels_D: Node 7
29.882: InterleaveChannels_D: Status 2000
29.882: InterleaveChannels_D: ErrStatus 0
29.882: InterleaveChannels_D: ErrCode 0
29.882: InterleaveChannels_D: Done
29.882:=20
29.882: mctAutoInitMCT_D: ECCInit_D
29.882: FMAP: area COREBOOT found @ 200 (2096640 bytes)
29.882: CBFS: Locating 'cmos_layout.bin'
29.882: CBFS: Found @ offset 2adc0 size dc4
29.883: FMAP: area COREBOOT found @ 200 (2096640 bytes)
29.883: CBFS: Locating 'cmos_layout.bin'
29.883: CBFS: Found @ offset 2adc0 size dc4
29.884:   ECC enabled on node: 00
29.884: DCTMemClr_Sync_D: Start
29.884: DCTMemClr_Sync_D: Waiting for memory clear to complete...........=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E........................................................
30.373: .
30.373: DCTMemClr_Sync_D: Done
30.373:   ECC enabled on node: 01
30.373: DCTMemClr_Sync_D: Start
30.373: DCTMemClr_Sync_D: Waiting for memory clear to complete...........=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E..........................................................
30.861: .
30.861: DCTMemClr_Sync_D: Done
30.861:   ECC enabled on node: 02
30.861: DCTMemClr_Sync_D: Start
30.861: DCTMemClr_Sync_D: Waiting for memory clear to complete...........=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E..........................................................
31.349: .
31.349: DCTMemClr_Sync_D: Done
31.349:   ECC enabled on node: 03
31.349: DCTMemClr_Sync_D: Start
31.349: DCTMemClr_Sync_D: Waiting for memory clear to complete...........=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E..........................................................
31.838: .
31.838: DCTMemClr_Sync_D: Done
31.838: FMAP: area COREBOOT found @ 200 (2096640 bytes)
31.838: CBFS: Locating 'cmos_layout.bin'
31.838: CBFS: Found @ offset 2adc0 size dc4
31.839: FMAP: area COREBOOT found @ 200 (2096640 bytes)
31.839: CBFS: Locating 'cmos_layout.bin'
31.839: CBFS: Found @ offset 2adc0 size dc4
31.839: FMAP: area COREBOOT found @ 200 (2096640 bytes)
31.839: CBFS: Locating 'cmos_layout.bin'
31.839: CBFS: Found @ offset 2adc0 size dc4
31.839: FMAP: area COREBOOT found @ 200 (2096640 bytes)
31.839: CBFS: Locating 'cmos_layout.bin'
31.840: CBFS: Found @ offset 2adc0 size dc4
31.840: ECCInit: Node 00
31.840: ECCInit: Status 2205
31.840: ECCInit: ErrStatus 4000
31.840: ECCInit: ErrCode 0
31.840: ECCInit: Done
31.840: ECCInit: Node 01
31.840: ECCInit: Status 2005
31.840: ECCInit: ErrStatus 4000
31.840: ECCInit: ErrCode 0
31.840: ECCInit: Done
31.840: ECCInit: Node 02
31.840: ECCInit: Status 2005
31.840: ECCInit: ErrStatus 4000
31.840: ECCInit: ErrCode 0
31.840: ECCInit: Done
31.840: ECCInit: Node 03
31.840: ECCInit: Status 2005
31.840: ECCInit: ErrStatus 4000
31.840: ECCInit: ErrCode 0
31.840: ECCInit: Done
31.840: mctAutoInitMCT_D: CPUMemTyping_D
31.841: <09> CPUMemTyping: Cache32bTOP:c00000
31.841: <09> CPUMemTyping: Bottom32bIO:c00000
31.841: <09> CPUMemTyping: Bottom40bIO:20400000
31.841: mctAutoInitMCT_D: UMAMemTyping_D
31.841: mctAutoInitMCT_D: mct_ForceNBPState0_Dis_Fam15
31.842: FMAP: area COREBOOT found @ 200 (2096640 bytes)
31.842: CBFS: Locating 'cmos_layout.bin'
31.842: CBFS: Found @ offset 2adc0 size dc4
31.843: set_up_cc6_storage_fam15: Initializing CC6 DRAM storage area for =
node 0 (interleaved: 0)
31.843: set_up_cc6_storage_fam15:<09>original (node 3) max_range_limit:  =
     203fffffff DRAM limit:        83fffffff
31.843: set_up_cc6_storage_fam15:<09>new max_range_limit:       203efffff=
f
31.843: set_up_cc6_storage_fam15:<09>Target node: 3
31.843: set_up_cc6_storage_fam15:<09>Done
31.843: set_up_cc6_storage_fam15: Initializing CC6 DRAM storage area for =
node 1 (interleaved: 0)
31.843: set_up_cc6_storage_fam15:<09>original (node 3) max_range_limit:  =
     203fffffff DRAM limit:       103fffffff
31.843: set_up_cc6_storage_fam15:<09>new max_range_limit:       203efffff=
f
31.843: set_up_cc6_storage_fam15:<09>Target node: 3
31.843: set_up_cc6_storage_fam15:<09>Done
31.843: set_up_cc6_storage_fam15: Initializing CC6 DRAM storage area for =
node 2 (interleaved: 0)
31.843: set_up_cc6_storage_fam15:<09>original (node 3) max_range_limit:  =
     203fffffff DRAM limit:       183fffffff
31.843: set_up_cc6_storage_fam15:<09>new max_range_limit:       203efffff=
f
31.843: set_up_cc6_storage_fam15:<09>Target node: 3
31.843: set_up_cc6_storage_fam15:<09>Done
31.843: set_up_cc6_storage_fam15: Initializing CC6 DRAM storage area for =
node 3 (interleaved: 0)
31.843: set_up_cc6_storage_fam15:<09>original (node 3) max_range_limit:  =
     203fffffff DRAM limit:       203fffffff
31.843: set_up_cc6_storage_fam15:<09>new max_range_limit:       203efffff=
f
31.843: set_up_cc6_storage_fam15:<09>Target node: 3
31.843: set_up_cc6_storage_fam15:<09>Done
31.844: FMAP: area COREBOOT found @ 200 (2096640 bytes)
31.844: CBFS: Locating 'cmos_layout.bin'
31.844: CBFS: Found @ offset 2adc0 size dc4
31.844: FMAP: area COREBOOT found @ 200 (2096640 bytes)
31.844: CBFS: Locating 'cmos_layout.bin'
31.844: CBFS: Found @ offset 2adc0 size dc4
31.845: FMAP: area COREBOOT found @ 200 (2096640 bytes)
31.845: CBFS: Locating 'cmos_layout.bin'
31.845: CBFS: Found @ offset 2adc0 size dc4
31.845: FMAP: area COREBOOT found @ 200 (2096640 bytes)
31.845: CBFS: Locating 'cmos_layout.bin'
31.845: CBFS: Found @ offset 2adc0 size dc4
31.846: mctAutoInitMCT_D Done: Global Status: 12
31.846: raminit_amdmct end:
31.847: CBMEM:
31.848: IMD: root @ b7fff000 254 entries.
31.848: IMD: root @ b7ffec00 62 entries.
31.851: amdmct_cbmem_store_info: Storing AMDMCT configuration in CBMEM
31.851: FMAP: area COREBOOT found @ 200 (2096640 bytes)
31.851: CBFS: Locating 'cmos_layout.bin'
31.851: CBFS: Found @ offset 2adc0 size dc4
31.852: disable_spd()
31.979: CBFS: 'Master Header Locator' located CBFS at [200:200000)
31.981: CBFS: Locating 'fallback/ramstage'
31.982: CBFS: Found @ offset 3fe00 size 16233
32.052:=20
32.052:=20
32.052: coreboot-4.9-103-g637bef2037 Wed Jan  2 12:01:08 UTC 2019 ramstag=
e starting...
32.052: Moving GDT to b7ffe9e0...ok
32.052: Normal boot.
32.052: BS: BS_PRE_DEVICE times (us): entry 0 run 1 exit 0
32.052: BS: BS_DEV_INIT_CHIPS times (us): entry 0 run 2 exit 0
32.052: Enumerating buses...
32.052: Mainboard KGPE-D16 Enable. dev=3D0x00e2e260
32.052: mainboard_enable, TOP MEM: msr.lo =3D 0xc0000000, msr.hi =3D 0x00=
000000
32.052: mainboard_enable, TOP MEM2: msr2.lo =3D 0x40000000, msr2.hi =3D 0=
x00000020
32.052: setup_bsp_ramtop, TOP MEM: msr.lo =3D 0xc0000000, msr.hi =3D 0x00=
000000
32.052: setup_bsp_ramtop, TOP MEM2: msr.lo =3D 0x40000000, msr.hi =3D 0x0=
0000020
32.052: CPU_CLUSTER: 0 enabled
32.052: DOMAIN: 0000 enabled
32.052: FMAP: area COREBOOT found @ 200 (2096640 bytes)
32.052: CBFS: Locating 'cmos_layout.bin'
32.053: CBFS: Found @ offset 2adc0 size dc4
32.053: FMAP: area COREBOOT found @ 200 (2096640 bytes)
32.053: CBFS: Locating 'cmos_layout.bin'
32.053: CBFS: Found @ offset 2adc0 size dc4
32.054:   PCI: 00:18.5 siblings=3D7
32.054: CPU: APIC: 00 enabled
32.054: CPU: APIC: 01 enabled
32.054: CPU: APIC: 02 enabled
32.054: CPU: APIC: 03 enabled
32.054: CPU: APIC: 04 enabled
32.054: CPU: APIC: 05 enabled
32.054: CPU: APIC: 06 enabled
32.054: CPU: APIC: 07 enabled
32.054:   PCI: 00:19.5 siblings=3D7
32.054: CPU: APIC: 08 enabled
32.054: CPU: APIC: 09 enabled
32.054: CPU: APIC: 0a enabled
32.054: CPU: APIC: 0b enabled
32.054: CPU: APIC: 0c enabled
32.054: CPU: APIC: 0d enabled
32.054: CPU: APIC: 0e enabled
32.054: CPU: APIC: 0f enabled
32.054:   PCI: 00:1a.5 siblings=3D7
32.054: CPU: APIC: 20 enabled
32.054: CPU: APIC: 21 enabled
32.054: CPU: APIC: 22 enabled
32.054: CPU: APIC: 23 enabled
32.054: CPU: APIC: 24 enabled
32.054: CPU: APIC: 25 enabled
32.054: CPU: APIC: 26 enabled
32.054: CPU: APIC: 27 enabled
32.054:   PCI: 00:1b.5 siblings=3D7
32.054: CPU: APIC: 28 enabled
32.054: CPU: APIC: 29 enabled
32.054: CPU: APIC: 2a enabled
32.054: CPU: APIC: 2b enabled
32.054: CPU: APIC: 2c enabled
32.054: CPU: APIC: 2d enabled
32.054: CPU: APIC: 2e enabled
32.054: CPU: APIC: 2f enabled
32.054: scan_bus: scanning of bus CPU_CLUSTER: 0 took 69977 usecs
32.054: PCI: pci_scan_bus for bus 00
32.055: PCI: 00:18.0 [1022/1600] enabled
32.055: PCI: 00:18.1 [1022/1601] enabled
32.055: PCI: 00:18.2 [1022/1602] enabled
32.055: PCI: 00:18.3 [1022/1603] enabled
32.055: PCI: 00:18.4 [1022/1604] enabled
32.055: PCI: 00:18.5 [1022/1605] enabled
32.055: PCI: 00:19.0 [1022/1600] enabled
32.055: PCI: 00:19.1 [1022/1601] enabled
32.055: PCI: 00:19.2 [1022/1602] enabled
32.055: PCI: 00:19.3 [1022/1603] enabled
32.055: PCI: 00:19.4 [1022/1604] enabled
32.055: PCI: 00:19.5 [1022/1605] enabled
32.055: PCI: 00:1a.0 [1022/1600] enabled
32.055: PCI: 00:1a.1 [1022/1601] enabled
32.055: PCI: 00:1a.2 [1022/1602] enabled
32.055: PCI: 00:1a.3 [1022/1603] enabled
32.055: PCI: 00:1a.4 [1022/1604] enabled
32.055: PCI: 00:1a.5 [1022/1605] enabled
32.055: PCI: 00:1b.0 [1022/1600] enabled
32.055: PCI: 00:1b.1 [1022/1601] enabled
32.055: PCI: 00:1b.2 [1022/1602] enabled
32.055: PCI: 00:1b.3 [1022/1603] enabled
32.055: PCI: 00:1b.4 [1022/1604] enabled
32.055: PCI: 00:1b.5 [1022/1605] enabled
32.055: sr5650_enable: dev=3D00e30b80, VID_DID=3D0x5a101002
32.055: Bus-0, Dev-0, Fun-0.
32.055: enable_pcie_bar3
32.058: sr5650_gpp_sb_init: nb_dev=3D0x00e30b80, dev=3D0x00e305e0, port=3D=
0x8
32.058: PciePowerOffGppPorts() port 8
32.058: NB_PCI_REG04 =3D 2.
32.058: NB_PCI_REG84 =3D 3000010.
32.058: NB_PCI_REG4C =3D 52042.
32.058: Sysmem TOM =3D 0_c0000000
32.058: Sysmem TOM2 =3D 20_40000000
32.058: PCI: 00:00.0 [1002/5a10] enabled
32.058: PCI: 00:00.0 [1002/5a10] enabled next_unitid: 0015
32.058: PCI: pci_scan_bus for bus 00
32.058: sr5650_enable: dev=3D00e30b80, VID_DID=3D0x5a101002
32.058: Bus-0, Dev-0, Fun-0.
32.058: enable_pcie_bar3
32.061: sr5650_gpp_sb_init: nb_dev=3D0x00e30b80, dev=3D0x00e305e0, port=3D=
0x8
32.061: PciePowerOffGppPorts() port 8
32.061: NB_PCI_REG04 =3D 2.
32.061: NB_PCI_REG84 =3D 3000010.
32.061: NB_PCI_REG4C =3D 52042.
32.061: Sysmem TOM =3D 0_c0000000
32.061: Sysmem TOM2 =3D 20_40000000
32.061: PCI: 00:00.0 [1002/5a10] enabled
32.061: sr5650_enable: dev=3D00e30ae0, VID_DID=3D0xffffffff
32.061: Bus-0, Dev-0, Fun-1.
32.062: PCI: Static device PCI: 00:00.1 not found, disabling it.
32.062: sr5650_enable: dev=3D00e30a40, VID_DID=3D0x5a231002
32.062: Bus-0, Dev-0, Fun-2.
32.062: PCI: 00:00.2 [1002/5a23] enabled
32.062: sr5650_enable: dev=3D00e309a0, VID_DID=3D0xffffffff
32.062: Bus-0, Dev-2,3, Fun-0. enable=3D1
32.062: sr5650_gpp_sb_init: nb_dev=3D0x00e30b80, dev=3D0x00e309a0, port=3D=
0x2
32.102: PcieLinkTraining port=3D2:lc current state=3D2030400
32.103: sr5650_gpp_sb_init: port=3D0x2 hw_port=3D0x2 result=3D0
32.103: PciePowerOffGppPorts() port 2
32.103: PCI: 00:02.0 subordinate bus PCI Express
32.103: PCI: 00:02.0 [1002/5a16] enabled
32.103: sr5650_enable: dev=3D00e30900, VID_DID=3D0xffffffff
32.103: Bus-0, Dev-2,3, Fun-0. enable=3D0
32.103: sr5650_enable: dev=3D00e30860, VID_DID=3D0xffffffff
32.103: enable_pcie_bar3
32.103: Bus-0, Dev-4,5,6,7, Fun-0. enable=3D1
32.103: sr5650_gpp_sb_init: nb_dev=3D0x00e30b80, dev=3D0x00e30860, port=3D=
0x4
32.143: PcieLinkTraining port=3D4:lc current state=3D2030400
32.144: sr5650_gpp_sb_init: port=3D0x4 hw_port=3D0x4 result=3D0
32.144: PciePowerOffGppPorts() port 4
32.144: PCI: 00:04.0 subordinate bus PCI Express
32.144: PCI: 00:04.0 [1002/5a18] enabled
32.144: sr5650_enable: dev=3D00e307c0, VID_DID=3D0xffffffff
32.144: enable_pcie_bar3
32.144: Bus-0, Dev-4,5,6,7, Fun-0. enable=3D0
32.144: sr5650_enable: dev=3D00e30720, VID_DID=3D0xffffffff
32.144: enable_pcie_bar3
32.144: Bus-0, Dev-4,5,6,7, Fun-0. enable=3D0
32.144: sr5650_enable: dev=3D00e30680, VID_DID=3D0xffffffff
32.144: enable_pcie_bar3
32.144: Bus-0, Dev-4,5,6,7, Fun-0. enable=3D0
32.144: sr5650_enable: dev=3D00e305e0, VID_DID=3D0xffffffff
32.145: Bus-0, Dev-8, Fun-0. enable=3D0
32.144: disable_pcie_bar3
32.145: sr5650_enable: dev=3D00e30540, VID_DID=3D0xffffffff
32.145: Bus-0, Dev-9, 10, Fun-0. enable=3D1
32.145: enable_pcie_bar3
32.145: sr5650_gpp_sb_init: nb_dev=3D0x00e30b80, dev=3D0x00e30540, port=3D=
0x9
32.185: PcieLinkTraining port=3D5:lc current state=3Da0b0f10
32.185: addr=3Dc0000000,bus=3D0,devfn=3D48
32.185: PcieTrainPort reg=3D0x10000
32.185: sr5650_gpp_sb_init: port=3D0x9 hw_port=3D0x5 result=3D1
32.185: PCI: 00:09.0 subordinate bus PCI Express
32.185: PCI: 00:09.0 [1002/5a1c] enabled
32.185: sr5650_enable: dev=3D00e304a0, VID_DID=3D0xffffffff
32.185: Bus-0, Dev-9, 10, Fun-0. enable=3D1
32.185: enable_pcie_bar3
32.185: sr5650_gpp_sb_init: nb_dev=3D0x00e30b80, dev=3D0x00e304a0, port=3D=
0xa
32.225: PcieLinkTraining port=3D6:lc current state=3Da0b0f10
32.225: addr=3Dc0000000,bus=3D0,devfn=3D50
32.225: PcieTrainPort reg=3D0x10000
32.225: sr5650_gpp_sb_init: port=3D0xa hw_port=3D0x6 result=3D1
32.225: PCI: 00:0a.0 subordinate bus PCI Express
32.225: PCI: 00:0a.0 [1002/5a1d] enabled
32.225: sr5650_enable: dev=3D00e30400, VID_DID=3D0xffffffff
32.225: Bus-0, Dev-11,12, Fun-0. enable=3D1
32.225: sr5650_gpp_sb_init: nb_dev=3D0x00e30b80, dev=3D0x00e30400, port=3D=
0xb
32.266: PcieLinkTraining port=3Db:lc current state=3D2030400
32.267: sr5650_gpp_sb_init: port=3D0xb hw_port=3D0xb result=3D0
32.266: PciePowerOffGppPorts() port 11
32.266: PCI: 00:0b.0 subordinate bus PCI Express
32.266: PCI: 00:0b.0 [1002/5a1f] enabled
32.267: sr5650_enable: dev=3D00e30360, VID_DID=3D0xffffffff
32.267: Bus-0, Dev-11,12, Fun-0. enable=3D1
32.267: sr5650_gpp_sb_init: nb_dev=3D0x00e30b80, dev=3D0x00e30360, port=3D=
0xc
32.307: PcieLinkTraining port=3Dc:lc current state=3D2030400
32.308: sr5650_gpp_sb_init: port=3D0xc hw_port=3D0xc result=3D0
32.308: PciePowerOffGppPorts() port 12
32.308: PCI: 00:0c.0 subordinate bus PCI Express
32.308: PCI: 00:0c.0 [1002/5a20] enabled
32.308: sr5650_enable: dev=3D00e302c0, VID_DID=3D0xffffffff
32.308: sr5650_gpp_sb_init: nb_dev=3D0x00e30b80, dev=3D0x00e302c0, port=3D=
0xd
32.348: PcieLinkTraining port=3Dd:lc current state=3D20212210
32.348: addr=3Dc0000000,bus=3D0,devfn=3D68
32.348: PcieTrainPort reg=3D0x10000
32.348: sr5650_gpp_sb_init: port=3D0xd hw_port=3D0xd result=3D1
33.348: PCI: 00:0d.0 subordinate bus PCI Express
33.348: PCI: 00:0d.0 [1002/5a1e] enabled
33.348: sb7xx_51xx_enable()
33.348: PCI: 00:11.0 [1002/4394] enabled
33.348: sb7xx_51xx_enable()
33.348: PCI: 00:12.0 [1002/4397] enabled
33.348: sb7xx_51xx_enable()
33.348: PCI: 00:12.1 [1002/4398] enabled
33.348: sb7xx_51xx_enable()
33.348: PCI: 00:12.2 [1002/4396] enabled
33.348: sb7xx_51xx_enable()
33.348: PCI: 00:13.0 [1002/4397] enabled
33.348: sb7xx_51xx_enable()
33.348: PCI: 00:13.1 [1002/4398] enabled
33.348: sb7xx_51xx_enable()
33.348: PCI: 00:13.2 [1002/4396] enabled
33.348: sb7xx_51xx_enable()
33.348: PCI: 00:14.0 [1002/4385] enabled
33.348: sb7xx_51xx_enable()
33.348: PCI: 00:14.1 [1002/439c] enabled
33.348: sb7xx_51xx_enable()
33.348: PCI: 00:14.2 [1002/4383] enabled
33.348: sb7xx_51xx_enable()
33.348: PCI: 00:14.3 [1002/439d] enabled
33.348: sb7xx_51xx_enable()
33.348: PCI: 00:14.4 [1002/4384] enabled
33.348: sb7xx_51xx_enable()
33.348: PCI: 00:14.5 [1002/4399] enabled
33.349: PCI: pci_scan_bus for bus 01
33.349: scan_bus: scanning of bus PCI: 00:02.0 took 1976 usecs
33.349: PCI: pci_scan_bus for bus 02
33.349: scan_bus: scanning of bus PCI: 00:04.0 took 1927 usecs
33.349: PCI: pci_scan_bus for bus 03
33.349: PCI: 03:00.0 [8086/10d3] enabled
33.349: Enabling Common Clock Configuration
33.349: PCIE CLK PM is not supported by endpoint
33.349: ASPM: Enabled None
33.349: Failed to enable LTR for dev =3D PCI: 03:00.0
33.349: scan_bus: scanning of bus PCI: 00:09.0 took 13349 usecs
33.349: PCI: pci_scan_bus for bus 04
33.349: PCI: 04:00.0 [8086/10d3] enabled
33.349: Enabling Common Clock Configuration
33.349: PCIE CLK PM is not supported by endpoint
33.349: ASPM: Enabled None
33.349: Failed to enable LTR for dev =3D PCI: 04:00.0
33.349: scan_bus: scanning of bus PCI: 00:0a.0 took 13325 usecs
33.349: PCI: pci_scan_bus for bus 05
33.349: scan_bus: scanning of bus PCI: 00:0b.0 took 1927 usecs
33.349: PCI: pci_scan_bus for bus 06
33.350: scan_bus: scanning of bus PCI: 00:0c.0 took 1927 usecs
33.350: PCI: pci_scan_bus for bus 07
33.350: PCI: 07:00.0 [8086/10fb] enabled
33.350: PCI: 07:00.1 [8086/10fb] enabled
33.350: Enabling Common Clock Configuration
33.350: PCIE CLK PM is not supported by endpoint
33.350: ASPM: Enabled None
33.350: Enabling Common Clock Configuration
33.350: PCIE CLK PM is not supported by endpoint
33.350: ASPM: Enabled None
33.350: Failed to enable LTR for dev =3D PCI: 07:00.0
33.350: Failed to enable LTR for dev =3D PCI: 07:00.1
33.350: scan_bus: scanning of bus PCI: 00:0d.0 took 24638 usecs
33.350: bus: PCI: 00:14.0[0]->I2C: 01:50 enabled
33.350: bus: PCI: 00:14.0[0]->I2C: 01:51 enabled
33.350: bus: PCI: 00:14.0[0]->I2C: 01:52 enabled
33.350: bus: PCI: 00:14.0[0]->I2C: 01:53 enabled
33.350: bus: PCI: 00:14.0[0]->I2C: 01:54 enabled
33.350: bus: PCI: 00:14.0[0]->I2C: 01:55 enabled
33.350: bus: PCI: 00:14.0[0]->I2C: 01:56 enabled
33.350: bus: PCI: 00:14.0[0]->I2C: 01:57 enabled
33.350: bus: PCI: 00:14.0[0]->I2C: 01:2f enabled
33.350: scan_bus: scanning of bus PCI: 00:14.0 took 24052 usecs
33.350: PNP: 002e.0 disabled
33.351: PNP: 002e.1 disabled
33.350: PNP: 002e.2 enabled
33.351: PNP: 002e.3 enabled
33.351: PNP: 002e.5 enabled
33.351: PNP: 002e.106 disabled
33.351: PNP: 002e.107 disabled
33.351: PNP: 002e.207 disabled
33.351: PNP: 002e.307 disabled
33.351: PNP: 002e.407 disabled
33.351: PNP: 002e.8 disabled
33.351: PNP: 002e.108 disabled
33.351: PNP: 002e.9 disabled
33.351: PNP: 002e.109 disabled
33.351: PNP: 002e.209 disabled
33.351: PNP: 002e.309 disabled
33.351: PNP: 002e.a enabled
33.351: PNP: 002e.b enabled
33.351: PNP: 002e.c disabled
33.351: PNP: 002e.d disabled
33.351: PNP: 002e.f disabled
33.351: PNP: 004e.0 enabled
33.351: scan_bus: scanning of bus PCI: 00:14.3 took 31893 usecs
33.351: PCI: pci_scan_bus for bus 08
33.351: sb7xx_51xx_enable()
33.351: PCI: 08:01.0 [1a03/2000] enabled
33.351: sb7xx_51xx_enable()
33.351: PCI: 08:02.0 [11c1/5811] enabled
33.351: sb7xx_51xx_enable()
33.351: PCI: Static device PCI: 08:03.0 not found, disabling it.
33.351: scan_bus: scanning of bus PCI: 00:14.4 took 13927 usecs
33.351: scan_bus: scanning of bus PCI: 00:18.0 took 1408637 usecs
33.351: scan_bus: scanning of bus PCI: 00:19.0 took 1 usecs
33.351: scan_bus: scanning of bus PCI: 00:1a.0 took 1 usecs
33.351: scan_bus: scanning of bus PCI: 00:1b.0 took 1 usecs
33.351: scan_bus: scanning of bus DOMAIN: 0000 took 1476255 usecs
33.351: scan_bus: scanning of bus Root Device took 1565718 usecs
33.351: done
33.351: BS: BS_DEV_ENUMERATE times (us): entry 0 run 1582995 exit 0
33.351: found VGA at PCI: 08:01.0
33.351: Setting up VGA for PCI: 08:01.0
33.351: Setting PCI_BRIDGE_CTL_VGA for bridge PCI: 00:14.4
33.351: Setting PCI_BRIDGE_CTL_VGA for bridge PCI: 00:18.0
33.351: Setting PCI_BRIDGE_CTL_VGA for bridge DOMAIN: 0000
33.351: Setting PCI_BRIDGE_CTL_VGA for bridge Root Device
33.351: Allocating resources...
33.351: Reading resources...
33.351: Adding PCIe enhanced config space BAR 0xc0000000-0xd0000000.
33.352: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.352: CBFS: Locating 'cmos_layout.bin'
33.352: CBFS: Found @ offset 2adc0 size dc4
33.353: Reserving CC6 save segment base: 2038000000 size: 08000000
33.353: sr5690_read_resource: PCI: 00:00.0
33.353: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.353: CBFS: Locating 'cmos_layout.bin'
33.353: CBFS: Found @ offset 2adc0 size dc4
33.354: I2C: 01:50 missing read_resources
33.354: I2C: 01:51 missing read_resources
33.354: I2C: 01:52 missing read_resources
33.354: I2C: 01:53 missing read_resources
33.354: I2C: 01:54 missing read_resources
33.354: I2C: 01:55 missing read_resources
33.354: I2C: 01:56 missing read_resources
33.354: I2C: 01:57 missing read_resources
33.355: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.355: CBFS: Locating 'cmos_layout.bin'
33.355: CBFS: Found @ offset 2adc0 size dc4
33.356: Done reading resources.
33.356: Setting resources...
33.356: 0: mmio_basek=3D00300000, basek=3D00400000, limitk=3D02100000
33.356: 1: mmio_basek=3D00300000, basek=3D02100000, limitk=3D04100000
33.356: 2: mmio_basek=3D00300000, basek=3D04100000, limitk=3D06100000
33.356: 3: mmio_basek=3D00300000, basek=3D06100000, limitk=3D08100000
33.356: VGA: PCI: 00:18.0 (aka node 0) link 1 has VGA device
33.356: PCI: 00:18.0 111b8 <- [0x00000a0000 - 0x00000bffff] size 0x000200=
00 gran 0x00 mem <node 0 link 1>
33.356: PCI: 00:18.0 110b0 <- [0x00fcc00000 - 0x00fcefffff] size 0x003000=
00 gran 0x14 prefmem <node 0 link 1>
33.356: PCI: 00:18.0 110b8 <- [0x00fc000000 - 0x00fcbfffff] size 0x00c000=
00 gran 0x14 mem <node 0 link 1>
33.356: PCI: 00:18.0 110d8 <- [0x0000001000 - 0x0000005fff] size 0x000050=
00 gran 0x0c io <node 0 link 1>
33.356: PCI: 00:00.0 sr5690_set_resources
33.356: sr5690_set_resources: PCI: 00:00.0[0x1c] base =3D c0000000 limit =
=3D cfffffff
33.356: PCI: 00:00.0 c0010058 <- [0x00c0000000 - 0x00cfffffff] size 0x100=
00000 gran 0x00 mem <mmconfig>
33.356: sr5690_set_resources: PCI: 00:18.1 <- index a8 base c00003 limit =
cfff90
33.356: PCI: 00:00.0 fc <- [0x00fce00000 - 0x00fce000ff] size 0x00000100 =
gran 0x08 prefmem
33.356: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.356: CBFS: Locating 'cmos_layout.bin'
33.356: CBFS: Found @ offset 2adc0 size dc4
33.357: PCI: 00:00.2 44 <- [0x00fcb00000 - 0x00fcb03fff] size 0x00004000 =
gran 0x0e mem
33.357: PCI: 00:02.0 1c <- [0x0000005fff - 0x0000005ffe] size 0x00000000 =
gran 0x0c bus 01 io
33.357: PCI: 00:02.0 24 <- [0x00fcefffff - 0x00fceffffe] size 0x00000000 =
gran 0x14 bus 01 prefmem
33.357: PCI: 00:02.0 20 <- [0x00fcbfffff - 0x00fcbffffe] size 0x00000000 =
gran 0x14 bus 01 mem
33.357: PCI: 00:04.0 1c <- [0x0000005fff - 0x0000005ffe] size 0x00000000 =
gran 0x0c bus 02 io
33.357: PCI: 00:04.0 24 <- [0x00fcefffff - 0x00fceffffe] size 0x00000000 =
gran 0x14 bus 02 prefmem
33.357: PCI: 00:04.0 20 <- [0x00fcbfffff - 0x00fcbffffe] size 0x00000000 =
gran 0x14 bus 02 mem
33.357: PCI: 00:09.0 1c <- [0x0000001000 - 0x0000001fff] size 0x00001000 =
gran 0x0c bus 03 io
33.357: PCI: 00:09.0 24 <- [0x00fcefffff - 0x00fceffffe] size 0x00000000 =
gran 0x14 bus 03 prefmem
33.357: PCI: 00:09.0 20 <- [0x00fc900000 - 0x00fc9fffff] size 0x00100000 =
gran 0x14 bus 03 mem
33.357: PCI: 03:00.0 10 <- [0x00fc900000 - 0x00fc91ffff] size 0x00020000 =
gran 0x11 mem
33.357: PCI: 03:00.0 18 <- [0x0000001000 - 0x000000101f] size 0x00000020 =
gran 0x05 io
33.357: PCI: 03:00.0 1c <- [0x00fc920000 - 0x00fc923fff] size 0x00004000 =
gran 0x0e mem
33.357: PCI: 00:0a.0 1c <- [0x0000002000 - 0x0000002fff] size 0x00001000 =
gran 0x0c bus 04 io
33.357: PCI: 00:0a.0 24 <- [0x00fcefffff - 0x00fceffffe] size 0x00000000 =
gran 0x14 bus 04 prefmem
33.357: PCI: 00:0a.0 20 <- [0x00fca00000 - 0x00fcafffff] size 0x00100000 =
gran 0x14 bus 04 mem
33.358: PCI: 04:00.0 10 <- [0x00fca00000 - 0x00fca1ffff] size 0x00020000 =
gran 0x11 mem
33.358: PCI: 04:00.0 18 <- [0x0000002000 - 0x000000201f] size 0x00000020 =
gran 0x05 io
33.358: PCI: 04:00.0 1c <- [0x00fca20000 - 0x00fca23fff] size 0x00004000 =
gran 0x0e mem
33.358: PCI: 00:0b.0 1c <- [0x0000005fff - 0x0000005ffe] size 0x00000000 =
gran 0x0c bus 05 io
33.358: PCI: 00:0b.0 24 <- [0x00fcefffff - 0x00fceffffe] size 0x00000000 =
gran 0x14 bus 05 prefmem
33.358: PCI: 00:0b.0 20 <- [0x00fcbfffff - 0x00fcbffffe] size 0x00000000 =
gran 0x14 bus 05 mem
33.358: PCI: 00:0c.0 1c <- [0x0000005fff - 0x0000005ffe] size 0x00000000 =
gran 0x0c bus 06 io
33.358: PCI: 00:0c.0 24 <- [0x00fcefffff - 0x00fceffffe] size 0x00000000 =
gran 0x14 bus 06 prefmem
33.358: PCI: 00:0c.0 20 <- [0x00fcbfffff - 0x00fcbffffe] size 0x00000000 =
gran 0x14 bus 06 mem
33.358: PCI: 00:0d.0 1c <- [0x0000003000 - 0x0000003fff] size 0x00001000 =
gran 0x0c bus 07 io
33.358: PCI: 00:0d.0 24 <- [0x00fcc00000 - 0x00fcdfffff] size 0x00200000 =
gran 0x14 bus 07 prefmem
33.358: PCI: 00:0d.0 20 <- [0x00fcbfffff - 0x00fcbffffe] size 0x00000000 =
gran 0x14 bus 07 mem
33.358: PCI: 07:00.0 10 <- [0x00fcc00000 - 0x00fcc7ffff] size 0x00080000 =
gran 0x13 prefmem64
33.358: PCI: 07:00.0 18 <- [0x0000003000 - 0x000000301f] size 0x00000020 =
gran 0x05 io
33.358: PCI: 07:00.0 20 <- [0x00fcd00000 - 0x00fcd03fff] size 0x00004000 =
gran 0x0e prefmem64
33.358: PCI: 07:00.1 10 <- [0x00fcc80000 - 0x00fccfffff] size 0x00080000 =
gran 0x13 prefmem64
33.358: PCI: 07:00.1 18 <- [0x0000003020 - 0x000000303f] size 0x00000020 =
gran 0x05 io
33.358: PCI: 07:00.1 20 <- [0x00fcd04000 - 0x00fcd07fff] size 0x00004000 =
gran 0x0e prefmem64
33.358: PCI: 00:11.0 10 <- [0x0000005020 - 0x0000005027] size 0x00000008 =
gran 0x03 io
33.358: PCI: 00:11.0 14 <- [0x0000005040 - 0x0000005043] size 0x00000004 =
gran 0x02 io
33.358: PCI: 00:11.0 18 <- [0x0000005028 - 0x000000502f] size 0x00000008 =
gran 0x03 io
33.358: PCI: 00:11.0 1c <- [0x0000005044 - 0x0000005047] size 0x00000004 =
gran 0x02 io
33.358: PCI: 00:11.0 20 <- [0x0000005000 - 0x000000500f] size 0x00000010 =
gran 0x04 io
33.358: PCI: 00:11.0 24 <- [0x00fcb0d000 - 0x00fcb0d3ff] size 0x00000400 =
gran 0x0a mem
33.358: PCI: 00:12.0 10 <- [0x00fcb08000 - 0x00fcb08fff] size 0x00001000 =
gran 0x0c mem
33.358: PCI: 00:12.1 10 <- [0x00fcb09000 - 0x00fcb09fff] size 0x00001000 =
gran 0x0c mem
33.358: PCI: 00:12.2 10 <- [0x00fcb0e000 - 0x00fcb0e0ff] size 0x00000100 =
gran 0x08 mem
33.358: PCI: 00:13.0 10 <- [0x00fcb0a000 - 0x00fcb0afff] size 0x00001000 =
gran 0x0c mem
33.358: PCI: 00:13.1 10 <- [0x00fcb0b000 - 0x00fcb0bfff] size 0x00001000 =
gran 0x0c mem
33.358: PCI: 00:13.2 10 <- [0x00fcb0f000 - 0x00fcb0f0ff] size 0x00000100 =
gran 0x08 mem
33.358: PCI: 00:14.1 10 <- [0x0000005030 - 0x0000005037] size 0x00000008 =
gran 0x03 io
33.358: PCI: 00:14.1 14 <- [0x0000005048 - 0x000000504b] size 0x00000004 =
gran 0x02 io
33.358: PCI: 00:14.1 18 <- [0x0000005038 - 0x000000503f] size 0x00000008 =
gran 0x03 io
33.358: PCI: 00:14.1 1c <- [0x000000504c - 0x000000504f] size 0x00000004 =
gran 0x02 io
33.358: PCI: 00:14.1 20 <- [0x0000005010 - 0x000000501f] size 0x00000010 =
gran 0x04 io
33.358: PCI: 00:14.2 10 <- [0x00fcb04000 - 0x00fcb07fff] size 0x00004000 =
gran 0x0e mem64
33.358: PCI: 00:14.3 a0 <- [0x00fcb10000 - 0x00fcb10000] size 0x00000001 =
gran 0x00 mem
33.358: PNP: 002e.2 60 <- [0x00000003f8 - 0x00000003ff] size 0x00000008 g=
ran 0x03 io
33.358: PNP: 002e.2 70 <- [0x0000000004 - 0x0000000004] size 0x00000001 g=
ran 0x00 irq
33.358: PNP: 002e.3 60 <- [0x00000002f8 - 0x00000002ff] size 0x00000008 g=
ran 0x03 io
33.358: PNP: 002e.3 70 <- [0x0000000003 - 0x0000000003] size 0x00000001 g=
ran 0x00 irq
33.358: PNP: 002e.5 60 <- [0x0000000060 - 0x0000000060] size 0x00000001 g=
ran 0x00 io
33.358: PNP: 002e.5 62 <- [0x0000000064 - 0x0000000064] size 0x00000001 g=
ran 0x00 io
33.358: PNP: 002e.5 70 <- [0x0000000001 - 0x0000000001] size 0x00000001 g=
ran 0x00 irq
33.358: PNP: 002e.5 72 <- [0x000000000c - 0x000000000c] size 0x00000001 g=
ran 0x00 irq
33.358: PNP: 002e.b 60 <- [0x0000000290 - 0x0000000291] size 0x00000002 g=
ran 0x01 io
33.358: ERROR: PNP: 002e.b 70 irq size: 0x0000000001 not assigned
33.358: PCI: 00:14.4 1c <- [0x0000004000 - 0x0000004fff] size 0x00001000 =
gran 0x0c bus 08 io
33.358: PCI: 00:14.4 24 <- [0x00fcefffff - 0x00fceffffe] size 0x00000000 =
gran 0x14 bus 08 prefmem
33.358: PCI: 00:14.4 20 <- [0x00fc000000 - 0x00fc8fffff] size 0x00900000 =
gran 0x14 bus 08 mem
33.358: PCI: 08:01.0 10 <- [0x00fc000000 - 0x00fc7fffff] size 0x00800000 =
gran 0x17 mem
33.358: PCI: 08:01.0 14 <- [0x00fc800000 - 0x00fc81ffff] size 0x00020000 =
gran 0x11 mem
33.358: PCI: 08:01.0 18 <- [0x0000004000 - 0x000000407f] size 0x00000080 =
gran 0x07 io
33.358: PCI: 08:02.0 10 <- [0x00fc820000 - 0x00fc820fff] size 0x00001000 =
gran 0x0c mem
33.358: PCI: 00:14.5 10 <- [0x00fcb0c000 - 0x00fcb0cfff] size 0x00001000 =
gran 0x0c mem
33.358: PCI: 00:18.3 94 <- [0x00f8000000 - 0x00fbffffff] size 0x04000000 =
gran 0x1a mem <gart>
33.358: PCI: 00:19.3 94 <- [0x00f8000000 - 0x00fbffffff] size 0x04000000 =
gran 0x1a mem <gart>
33.358: PCI: 00:1a.3 94 <- [0x00f8000000 - 0x00fbffffff] size 0x04000000 =
gran 0x1a mem <gart>
33.358: PCI: 00:1b.3 94 <- [0x00f8000000 - 0x00fbffffff] size 0x04000000 =
gran 0x1a mem <gart>
33.358: Done setting resources.
33.358: Done allocating resources.
33.358: BS: BS_DEV_RESOURCES times (us): entry 0 run 546101 exit 0
33.358: Enabling resources...
33.358: PCI: 00:18.0 cmd <- 00
33.358: PCI: 00:18.1 subsystem <- 1043/8163
33.358: PCI: 00:18.1 cmd <- 00
33.358: PCI: 00:18.2 subsystem <- 1043/8163
33.358: PCI: 00:18.2 cmd <- 00
33.358: PCI: 00:18.3 cmd <- 00
33.358: PCI: 00:18.4 cmd <- 00
33.358: PCI: 00:18.5 cmd <- 00
33.358: PCI: 00:19.0 cmd <- 00
33.358: PCI: 00:19.1 subsystem <- 1043/8163
33.358: PCI: 00:19.1 cmd <- 00
33.358: PCI: 00:19.2 subsystem <- 1043/8163
33.358: PCI: 00:19.2 cmd <- 00
33.358: PCI: 00:19.3 cmd <- 00
33.358: PCI: 00:19.4 cmd <- 00
33.358: PCI: 00:19.5 cmd <- 00
33.358: PCI: 00:1a.0 cmd <- 00
33.358: PCI: 00:1a.1 subsystem <- 1043/8163
33.358: PCI: 00:1a.1 cmd <- 00
33.358: PCI: 00:1a.2 subsystem <- 1043/8163
33.358: PCI: 00:1a.2 cmd <- 00
33.358: PCI: 00:1a.3 cmd <- 00
33.358: PCI: 00:1a.4 cmd <- 00
33.358: PCI: 00:1a.5 cmd <- 00
33.358: PCI: 00:1b.0 cmd <- 00
33.358: PCI: 00:1b.1 subsystem <- 1043/8163
33.358: PCI: 00:1b.1 cmd <- 00
33.359: PCI: 00:1b.2 subsystem <- 1043/8163
33.359: PCI: 00:1b.2 cmd <- 00
33.359: PCI: 00:1b.3 cmd <- 00
33.359: PCI: 00:1b.4 cmd <- 00
33.359: PCI: 00:1b.5 cmd <- 00
33.359: PCI: 00:00.0 subsystem <- 1043/8163
33.359: PCI: 00:00.0 cmd <- 02
33.359: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.359: CBFS: Locating 'cmos_layout.bin'
33.359: CBFS: Found @ offset 2adc0 size dc4
33.360: Initializing IOMMU
33.360: PCI: 00:02.0 bridge ctrl <- 0003
33.360: PCI: 00:02.0 cmd <- 00
33.360: PCI: 00:04.0 bridge ctrl <- 0003
33.360: PCI: 00:04.0 cmd <- 00
33.360: PCI: 00:09.0 bridge ctrl <- 0003
33.360: PCI: 00:09.0 cmd <- 07
33.360: PCI: 00:0a.0 bridge ctrl <- 0003
33.360: PCI: 00:0a.0 cmd <- 07
33.360: PCI: 00:0b.0 bridge ctrl <- 0003
33.360: PCI: 00:0b.0 cmd <- 00
33.360: PCI: 00:0c.0 bridge ctrl <- 0003
33.360: PCI: 00:0c.0 cmd <- 00
33.360: PCI: 00:0d.0 bridge ctrl <- 0003
33.360: PCI: 00:0d.0 cmd <- 07
33.360: PCI: 00:11.0 subsystem <- 1043/8163
33.360: PCI: 00:11.0 cmd <- 03
33.360: PCI: 00:12.0 subsystem <- 1043/8163
33.360: PCI: 00:12.0 cmd <- 02
33.360: PCI: 00:12.1 subsystem <- 1043/8163
33.360: PCI: 00:12.1 cmd <- 02
33.360: PCI: 00:12.2 subsystem <- 1043/8163
33.360: PCI: 00:12.2 cmd <- 02
33.360: PCI: 00:13.0 subsystem <- 1043/8163
33.360: PCI: 00:13.0 cmd <- 02
33.360: PCI: 00:13.1 subsystem <- 1043/8163
33.360: PCI: 00:13.1 cmd <- 02
33.360: PCI: 00:13.2 subsystem <- 1043/8163
33.360: PCI: 00:13.2 cmd <- 02
33.360: PCI: 00:14.0 subsystem <- 1043/8163
33.360: PCI: 00:14.0 cmd <- 403
33.360: PCI: 00:14.1 subsystem <- 1043/8163
33.360: PCI: 00:14.1 cmd <- 01
33.360: PCI: 00:14.2 subsystem <- 1043/8163
33.360: PCI: 00:14.2 cmd <- 02
33.360: PCI: 00:14.3 subsystem <- 1043/8163
33.360: PCI: 00:14.3 cmd <- 0f
33.360: sb700 lpc decode:PNP: 002e.2, base=3D0x000003f8, end=3D0x000003ff=

33.360: sb700 lpc decode:PNP: 002e.3, base=3D0x000002f8, end=3D0x000002ff=

33.360: sb700 lpc decode:PNP: 002e.5, base=3D0x00000060, end=3D0x00000060=

33.360: sb700 lpc decode:PNP: 002e.5, base=3D0x00000064, end=3D0x00000064=

33.360: sb700 lpc decode:PNP: 002e.b, base=3D0x00000290, end=3D0x00000291=

33.360: PCI: 00:14.4 bridge ctrl <- 000b
33.360: PCI: 00:14.4 cmd <- 07
33.360: PCI: 00:14.5 subsystem <- 1043/8163
33.360: PCI: 00:14.5 cmd <- 02
33.361: PCI: 03:00.0 cmd <- 03
33.361: PCI: 04:00.0 cmd <- 03
33.361: PCI: 07:00.0 cmd <- 03
33.361: PCI: 07:00.1 cmd <- 03
33.361: PCI: 08:01.0 cmd <- 03
33.361: PCI: 08:02.0 subsystem <- 1043/8163
33.361: PCI: 08:02.0 cmd <- 02
33.361: done.
33.361: BS: BS_DEV_ENABLE times (us): entry 0 run 178472 exit 0
33.361: Initializing devices...
33.361: Root Device init ...
33.361: Root Device init finished in 1398 usecs
33.361: CPU_CLUSTER: 0 init ...
33.361: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.361: CBFS: Locating 'cmos_layout.bin'
33.361: CBFS: Found @ offset 2adc0 size dc4
33.362: Enabling probe filter
33.366: Enabling ATM mode
33.367: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.367: CBFS: Locating 'cmos_layout.bin'
33.367: CBFS: Found @ offset 2adc0 size dc4
33.368: start_eip=3D0x00001000, code_size=3D0x00000031
33.368: Initializing CPU #1
33.368: Initializing CPU #2
33.368: CPU: vendor AMD device 600f12
33.368: Initializing CPU #6
33.368: CPU: family 15, model 01, stepping 02
33.368: CPU: vendor AMD device 600f12
33.368: nodeid =3D 00, coreid =3D 01
33.368: Initializing CPU #12
33.368: Enabling cache
33.368: Initializing CPU #4
33.368: CPU: vendor AMD device 600f12
33.368: Initializing CPU #22
33.368: Initializing CPU #0
33.368: CPU: vendor AMD device 600f12
33.368: CPU: family 15, model 01, stepping 02
33.368: Initializing CPU #29
33.368: nodeid =3D 00, coreid =3D 00
33.368: Enabling cache
33.368: Initializing CPU #14
33.368: CPU: vendor AMD device 600f12
33.368: CPU is Fam 0Fh rev.F or later. We can use TOM2WB for any memory a=
bove 4GB
33.368: Initializing CPU #18
33.368: Initializing CPU #27
33.368: MTRR: Physical address space:
33.368: 0x0000000000000000 - 0x00000000000a0000 size 0x000a0000 type 6
33.368: 0x00000000000a0000 - 0x00000000000c0000 size 0x00020000 type 0
33.368: 0x00000000000c0000 - 0x00000000c0000000 size 0xbff40000 type 6
33.368: 0x00000000c0000000 - 0x0000000100000000 size 0x40000000 type 0
33.368: 0x0000000100000000 - 0x0000002040000000 size 0x1f40000000 type 6
33.368: Initializing CPU #17
33.368: MTRR: Fixed MSR 0x250 0x1e1e1e1e1e1e1e1e
33.368: MTRR: Fixed MSR 0x258 0x1e1e1e1e1e1e1e1e
33.369: MTRR: Fixed MSR 0x259 0x0000000000000000
33.369: MTRR: Fixed MSR 0x268 0x1e1e1e1e1e1e1e1e
33.369: MTRR: Fixed MSR 0x269 0x1e1e1e1e1e1e1e1e
33.369: MTRR: Fixed MSR 0x26a 0x1e1e1e1e1e1e1e1e
33.369: MTRR: Fixed MSR 0x26b 0x1e1e1e1e1e1e1e1e
33.369: MTRR: Fixed MSR 0x26c 0x1e1e1e1e1e1e1e1e
33.369: MTRR: Fixed MSR 0x26d 0x1e1e1e1e1e1e1e1e
33.369: MTRR: Fixed MSR 0x26e 0x1e1e1e1e1e1e1e1e
33.369: MTRR: Fixed MSR 0x26f 0x1e1e1e1e1e1e1e1e
33.369: Initializing CPU #5
33.369: CPU: family 15, model 01, stepping 02
33.369: MTRR: default type WB/UC MTRR counts: 1/2.
33.369: MTRR: WB selected as default type.
33.369: MTRR: 0 base 0x00000000c0000000 mask 0x0000ffffc0000000 type 0
33.369: CPU: family 15, model 01, stepping 02
33.369:=20
33.369: MTRR check
33.369: Fixed MTRRs   : Enabled
33.369: Variable MTRRs: Enabled
33.369:=20
33.369: Initializing CPU #16
33.369: Initializing CPU #7
33.369: Setting up local APIC...Initializing CPU #11
33.369:  apic_id: 0x00 done.
33.369: Initializing CPU #10
33.369: CPU model: AMD Opteron(tm) Processor 6278
33.369: siblings =3D 15, Disabling SMM ASeg memory
33.369: CPU #0 initialized
33.369:=20
33.369: MTRR check
33.369: Waiting for 31 CPUS to stop
33.369: Fixed MTRRs   : Enabled
33.369: Variable MTRRs: Enabled
33.369:=20
33.369: Initializing CPU #15
33.369: CPU: vendor AMD device 600f12
33.369: Setting up local APIC...CPU: family 15, model 01, stepping 02
33.369:  apic_id: 0x01 done.
33.369: Initializing CPU #25
33.369: CPU model: AMD Opteron(tm) Processor 6278
33.369: siblings =3D 15, Disabling SMM ASeg memory
33.369: CPU #1 initialized
33.369: CPU: vendor AMD device 600f12
33.370: Waiting for 30 CPUS to stop
33.370: Initializing CPU #24
33.370: Initializing CPU #31
33.370: Initializing CPU #30
33.370: CPU: vendor AMD device 600f12
33.370: CPU: vendor AMD device 600f12
33.370: CPU: family 15, model 01, stepping 02
33.370: CPU: vendor AMD device 600f12
33.370: nodeid =3D 03, coreid =3D 05
33.370: CPU: vendor AMD device 600f12
33.370: Initializing CPU #19
33.370: nodeid =3D 00, coreid =3D 06
33.370: Initializing CPU #26
33.370: CPU: vendor AMD device 600f12
33.370: CPU: vendor AMD device 600f12
33.370: Initializing CPU #8
33.370: CPU: family 15, model 01, stepping 02
33.370: Initializing CPU #21
33.370: Initializing CPU #20
33.370: CPU: vendor AMD device 600f12
33.370: Initializing CPU #9
33.370: CPU: family 15, model 01, stepping 02
33.370: CPU: vendor AMD device 600f12
33.370: Enabling cache
33.373: CPU: vendor AMD device 600f12
33.373: CPU is Fam 0Fh rev.F or later. We can use TOM2WB for any memory a=
bove 4GB
33.373: CPU: family 15, model 01, stepping 02
33.373: CPU: family 15, model 01, stepping 02
33.373: MTRR: Fixed MSR 0x250 0x1e1e1e1e1e1e1e1e
33.373: nodeid =3D 00, coreid =3D 07
33.373: MTRR: Fixed MSR 0x258 0x1e1e1e1e1e1e1e1e
33.373: MTRR: Fixed MSR 0x259 0x0000000000000000
33.373: MTRR: Fixed MSR 0x268 0x1e1e1e1e1e1e1e1e
33.373: MTRR: Fixed MSR 0x269 0x1e1e1e1e1e1e1e1e
33.373: MTRR: Fixed MSR 0x26a 0x1e1e1e1e1e1e1e1e
33.373: MTRR: Fixed MSR 0x26b 0x1e1e1e1e1e1e1e1e
33.373: MTRR: Fixed MSR 0x26c 0x1e1e1e1e1e1e1e1e
33.373: MTRR: Fixed MSR 0x26d 0x1e1e1e1e1e1e1e1e
33.373: MTRR: Fixed MSR 0x26e 0x1e1e1e1e1e1e1e1e
33.373: MTRR: Fixed MSR 0x26f 0x1e1e1e1e1e1e1e1e
33.373: CPU: vendor AMD device 600f12
33.373: Initializing CPU #28
33.373: CPU: family 15, model 01, stepping 02
33.373: Enabling cache
33.373:=20
33.373: MTRR check
33.373: Fixed MTRRs   : Enabled
33.373: Variable MTRRs: Enabled
33.373:=20
33.373: CPU: vendor AMD device 600f12
33.373: Setting up local APIC...CPU: vendor AMD device 600f12
33.373:  apic_id: 0x06 done.
33.373: CPU: family 15, model 01, stepping 02
33.373: CPU model: AMD Opteron(tm) Processor 6278
33.373: siblings =3D 15, Disabling SMM ASeg memory
33.373: CPU #6 initialized
33.373:=20
33.373: MTRR check
33.373: Fixed MTRRs   : Enabled
33.373: Waiting for 29 CPUS to stop
33.373: Variable MTRRs: Enabled
33.374:=20
33.374: nodeid =3D 03, coreid =3D 03
33.374: CPU: vendor AMD device 600f12
33.374: Setting up local APIC...CPU: family 15, model 01, stepping 02
33.374:  apic_id: 0x07 done.
33.374: nodeid =3D 03, coreid =3D 07
33.374: CPU model: AMD Opteron(tm) Processor 6278
33.374: siblings =3D 15, Disabling SMM ASeg memory
33.374: CPU #7 initialized
33.374: CPU: vendor AMD device 600f12
33.374: Waiting for 28 CPUS to stop
33.374: CPU: family 15, model 01, stepping 02
33.374: CPU: family 15, model 01, stepping 02
33.374: CPU: vendor AMD device 600f12
33.374: nodeid =3D 01, coreid =3D 04
33.374: CPU: family 15, model 01, stepping 02
33.374: CPU: vendor AMD device 600f12
33.374: CPU: vendor AMD device 600f12
33.374: Initializing CPU #23
33.374: Enabling cache
33.374: CPU: vendor AMD device 600f12
33.374: nodeid =3D 02, coreid =3D 00
33.374: Enabling cache
33.374: nodeid =3D 01, coreid =3D 03
33.374: nodeid =3D 03, coreid =3D 04
33.374: Initializing CPU #3
33.374: CPU: family 15, model 01, stepping 02
33.374: CPU: vendor AMD device 600f12
33.374: nodeid =3D 03, coreid =3D 02
33.375: CPU: family 15, model 01, stepping 02
33.375: Enabling cache
33.375: Enabling cache
33.375: nodeid =3D 00, coreid =3D 02
33.375: CPU is Fam 0Fh rev.F or later. We can use TOM2WB for any memory a=
bove 4GB
33.375: CPU is Fam 0Fh rev.F or later. We can use TOM2WB for any memory a=
bove 4GB
33.375: MTRR: Fixed MSR 0x250 0x1e1e1e1e1e1e1e1e
33.375: MTRR: Fixed MSR 0x258 0x1e1e1e1e1e1e1e1e
33.375: MTRR: Fixed MSR 0x259 0x0000000000000000
33.375: MTRR: Fixed MSR 0x268 0x1e1e1e1e1e1e1e1e
33.375: MTRR: Fixed MSR 0x269 0x1e1e1e1e1e1e1e1e
33.375: MTRR: Fixed MSR 0x26a 0x1e1e1e1e1e1e1e1e
33.375: MTRR: Fixed MSR 0x26b 0x1e1e1e1e1e1e1e1e
33.375: MTRR: Fixed MSR 0x26c 0x1e1e1e1e1e1e1e1e
33.375: MTRR: Fixed MSR 0x26d 0x1e1e1e1e1e1e1e1e
33.375: MTRR: Fixed MSR 0x26e 0x1e1e1e1e1e1e1e1e
33.375: MTRR: Fixed MSR 0x26f 0x1e1e1e1e1e1e1e1e
33.375: MTRR: Fixed MSR 0x250 0x1e1e1e1e1e1e1e1e
33.375: MTRR: Fixed MSR 0x258 0x1e1e1e1e1e1e1e1e
33.375: MTRR: Fixed MSR 0x259 0x0000000000000000
33.375: MTRR: Fixed MSR 0x268 0x1e1e1e1e1e1e1e1e
33.375: MTRR: Fixed MSR 0x269 0x1e1e1e1e1e1e1e1e
33.375: MTRR: Fixed MSR 0x26a 0x1e1e1e1e1e1e1e1e
33.375: MTRR: Fixed MSR 0x26b 0x1e1e1e1e1e1e1e1e
33.375: MTRR: Fixed MSR 0x26c 0x1e1e1e1e1e1e1e1e
33.375: MTRR: Fixed MSR 0x26d 0x1e1e1e1e1e1e1e1e
33.375: MTRR: Fixed MSR 0x26e 0x1e1e1e1e1e1e1e1e
33.375: MTRR: Fixed MSR 0x26f 0x1e1e1e1e1e1e1e1e
33.375:=20
33.375: MTRR check
33.375: Fixed MTRRs   : Enabled
33.375: Variable MTRRs: Enabled
33.375:=20
33.375: Enabling cache
33.375:=20
33.375: MTRR check
33.375: Fixed MTRRs   : Enabled
33.375: Variable MTRRs: Enabled
33.375:=20
33.375: Setting up local APIC...CPU: family 15, model 01, stepping 02
33.375:  apic_id: 0x2a done.
33.375: Setting up local APIC...CPU model: AMD Opteron(tm) Processor 6278=

33.375:  apic_id: 0x2c done.
33.375: siblings =3D 15, CPU model: AMD Opteron(tm) Processor 6278
33.375: Disabling SMM ASeg memory
33.375: siblings =3D 15,=20
33.375: MTRR check
33.375: Fixed MTRRs   : Enabled
33.375: Variable MTRRs: Enabled
33.375:=20
33.375: Disabling SMM ASeg memory
33.375: Setting up local APIC...CPU #26 initialized
33.375:  apic_id: 0x2b done.
33.375: Waiting for 27 CPUS to stop
33.375:=20
33.375: MTRR check
33.375: Fixed MTRRs   : Enabled
33.376: Variable MTRRs: Enabled
33.376:=20
33.376: CPU model: AMD Opteron(tm) Processor 6278
33.376: Setting up local APIC...CPU #28 initialized
33.376:  apic_id: 0x2d done.
33.376: siblings =3D 15, CPU model: AMD Opteron(tm) Processor 6278
33.376: Waiting for 26 CPUS to stop
33.376: Disabling SMM ASeg memory
33.376: siblings =3D 15, CPU #27 initialized
33.376: Disabling SMM ASeg memory
33.376: Waiting for 25 CPUS to stop
33.376: CPU #29 initialized
33.376: nodeid =3D 00, coreid =3D 03
33.376: Waiting for 24 CPUS to stop
33.376: Enabling cache
33.376: CPU is Fam 0Fh rev.F or later. We can use TOM2WB for any memory a=
bove 4GB
33.376: CPU: family 15, model 01, stepping 02
33.376: MTRR: Fixed MSR 0x250 0x1e1e1e1e1e1e1e1e
33.376: MTRR: Fixed MSR 0x258 0x1e1e1e1e1e1e1e1e
33.376: MTRR: Fixed MSR 0x259 0x0000000000000000
33.376: MTRR: Fixed MSR 0x268 0x1e1e1e1e1e1e1e1e
33.376: MTRR: Fixed MSR 0x269 0x1e1e1e1e1e1e1e1e
33.376: MTRR: Fixed MSR 0x26a 0x1e1e1e1e1e1e1e1e
33.376: MTRR: Fixed MSR 0x26b 0x1e1e1e1e1e1e1e1e
33.376: MTRR: Fixed MSR 0x26c 0x1e1e1e1e1e1e1e1e
33.376: MTRR: Fixed MSR 0x26d 0x1e1e1e1e1e1e1e1e
33.376: MTRR: Fixed MSR 0x26e 0x1e1e1e1e1e1e1e1e
33.376: MTRR: Fixed MSR 0x26f 0x1e1e1e1e1e1e1e1e
33.376: CPU: family 15, model 01, stepping 02
33.376: nodeid =3D 01, coreid =3D 01
33.376: CPU: vendor AMD device 600f12
33.376:=20
33.376: MTRR check
33.376: Fixed MTRRs   : Enabled
33.376: Variable MTRRs: Enabled
33.376:=20
33.376: Enabling cache
33.376: nodeid =3D 03, coreid =3D 01
33.376: Setting up local APIC...Enabling cache
33.376: CPU is Fam 0Fh rev.F or later. We can use TOM2WB for any memory a=
bove 4GB
33.376:  apic_id: 0x02 done.
33.376: CPU: family 15, model 01, stepping 02
33.376: CPU model: AMD Opteron(tm) Processor 6278
33.376: nodeid =3D 02, coreid =3D 01
33.376: siblings =3D 15, CPU: vendor AMD device 600f12
33.376: CPU is Fam 0Fh rev.F or later. We can use TOM2WB for any memory a=
bove 4GB
33.376: Disabling SMM ASeg memory
33.376: CPU: vendor AMD device 600f12
33.377: CPU: vendor AMD device 600f12
33.377: Enabling cache
33.377: CPU: family 15, model 01, stepping 02
33.377: CPU #2 initialized
33.377:=20
33.377: MTRR check
33.377: Fixed MTRRs   : Enabled
33.377: Variable MTRRs: Enabled
33.377:=20
33.377: Waiting for 23 CPUS to stop
33.377: Setting up local APIC...nodeid =3D 01, coreid =3D 00
33.377:  apic_id: 0x03 done.
33.377: Enabling cache
33.377: CPU: family 15, model 01, stepping 02
33.377: CPU is Fam 0Fh rev.F or later. We can use TOM2WB for any memory a=
bove 4GB
33.377: nodeid =3D 02, coreid =3D 07
33.377: CPU model: AMD Opteron(tm) Processor 6278
33.377: MTRR: Fixed MSR 0x250 0x1e1e1e1e1e1e1e1e
33.377: MTRR: Fixed MSR 0x258 0x1e1e1e1e1e1e1e1e
33.377: MTRR: Fixed MSR 0x259 0x0000000000000000
33.377: MTRR: Fixed MSR 0x268 0x1e1e1e1e1e1e1e1e
33.377: MTRR: Fixed MSR 0x269 0x1e1e1e1e1e1e1e1e
33.377: MTRR: Fixed MSR 0x26a 0x1e1e1e1e1e1e1e1e
33.377: MTRR: Fixed MSR 0x26b 0x1e1e1e1e1e1e1e1e
33.377: MTRR: Fixed MSR 0x26c 0x1e1e1e1e1e1e1e1e
33.377: MTRR: Fixed MSR 0x26d 0x1e1e1e1e1e1e1e1e
33.377: MTRR: Fixed MSR 0x26e 0x1e1e1e1e1e1e1e1e
33.377: MTRR: Fixed MSR 0x26f 0x1e1e1e1e1e1e1e1e
33.377: nodeid =3D 02, coreid =3D 03
33.377: siblings =3D 15, Enabling cache
33.377: Disabling SMM ASeg memory
33.377: CPU: family 15, model 01, stepping 02
33.377: Enabling cache
33.377: CPU #3 initialized
33.377:=20
33.377: MTRR check
33.377: Fixed MTRRs   : Enabled
33.377: Variable MTRRs: Enabled
33.377:=20
33.377: CPU: vendor AMD device 600f12
33.377: Waiting for 22 CPUS to stop
33.377: Setting up local APIC...nodeid =3D 03, coreid =3D 06
33.377: nodeid =3D 03, coreid =3D 00
33.377: CPU: family 15, model 01, stepping 02
33.377:  apic_id: 0x08 done.
33.378: CPU: family 15, model 01, stepping 02
33.378: nodeid =3D 00, coreid =3D 04
33.378: CPU model: AMD Opteron(tm) Processor 6278
33.378: Enabling cache
33.378: nodeid =3D 02, coreid =3D 06
33.378: CPU: family 15, model 01, stepping 02
33.378: siblings =3D 15, Enabling cache
33.378: Disabling SMM ASeg memory
33.378: CPU is Fam 0Fh rev.F or later. We can use TOM2WB for any memory a=
bove 4GB
33.378: CPU #8 initialized
33.378:=20
33.378: MTRR check
33.378: Fixed MTRRs   : Enabled
33.378: Variable MTRRs: Enabled
33.378:=20
33.378: nodeid =3D 01, coreid =3D 02
33.378: Waiting for 21 CPUS to stop
33.378: Setting up local APIC...MTRR: Fixed MSR 0x250 0x1e1e1e1e1e1e1e1e
33.378: MTRR: Fixed MSR 0x258 0x1e1e1e1e1e1e1e1e
33.378: MTRR: Fixed MSR 0x259 0x0000000000000000
33.378: MTRR: Fixed MSR 0x268 0x1e1e1e1e1e1e1e1e
33.378: MTRR: Fixed MSR 0x269 0x1e1e1e1e1e1e1e1e
33.378: MTRR: Fixed MSR 0x26a 0x1e1e1e1e1e1e1e1e
33.378: MTRR: Fixed MSR 0x26b 0x1e1e1e1e1e1e1e1e
33.378: MTRR: Fixed MSR 0x26c 0x1e1e1e1e1e1e1e1e
33.378: MTRR: Fixed MSR 0x26d 0x1e1e1e1e1e1e1e1e
33.378: MTRR: Fixed MSR 0x26e 0x1e1e1e1e1e1e1e1e
33.378: MTRR: Fixed MSR 0x26f 0x1e1e1e1e1e1e1e1e
33.378: nodeid =3D 01, coreid =3D 07
33.378:  apic_id: 0x09 done.
33.378: Enabling cache
33.378: CPU model: AMD Opteron(tm) Processor 6278
33.378: CPU: family 15, model 01, stepping 02
33.378: siblings =3D 15, Enabling cache
33.378: Disabling SMM ASeg memory
33.378: Enabling cache
33.378: CPU #9 initialized
33.378: Enabling cache
33.378: CPU is Fam 0Fh rev.F or later. We can use TOM2WB for any memory a=
bove 4GB
33.378:=20
33.378: MTRR check
33.378: Fixed MTRRs   : Enabled
33.378: Variable MTRRs: Enabled
33.378:=20
33.378: CPU is Fam 0Fh rev.F or later. We can use TOM2WB for any memory a=
bove 4GB
33.378: MTRR: Fixed MSR 0x250 0x1e1e1e1e1e1e1e1e
33.378: MTRR: Fixed MSR 0x258 0x1e1e1e1e1e1e1e1e
33.378: MTRR: Fixed MSR 0x259 0x0000000000000000
33.379: MTRR: Fixed MSR 0x268 0x1e1e1e1e1e1e1e1e
33.379: MTRR: Fixed MSR 0x269 0x1e1e1e1e1e1e1e1e
33.379: MTRR: Fixed MSR 0x26a 0x1e1e1e1e1e1e1e1e
33.379: MTRR: Fixed MSR 0x26b 0x1e1e1e1e1e1e1e1e
33.379: MTRR: Fixed MSR 0x26c 0x1e1e1e1e1e1e1e1e
33.379: MTRR: Fixed MSR 0x26d 0x1e1e1e1e1e1e1e1e
33.379: MTRR: Fixed MSR 0x26e 0x1e1e1e1e1e1e1e1e
33.379: MTRR: Fixed MSR 0x26f 0x1e1e1e1e1e1e1e1e
33.379: MTRR: Fixed MSR 0x250 0x1e1e1e1e1e1e1e1e
33.379: MTRR: Fixed MSR 0x258 0x1e1e1e1e1e1e1e1e
33.379: MTRR: Fixed MSR 0x259 0x0000000000000000
33.379: MTRR: Fixed MSR 0x268 0x1e1e1e1e1e1e1e1e
33.379: MTRR: Fixed MSR 0x269 0x1e1e1e1e1e1e1e1e
33.379: MTRR: Fixed MSR 0x26a 0x1e1e1e1e1e1e1e1e
33.379: MTRR: Fixed MSR 0x26b 0x1e1e1e1e1e1e1e1e
33.379: MTRR: Fixed MSR 0x26c 0x1e1e1e1e1e1e1e1e
33.379: MTRR: Fixed MSR 0x26d 0x1e1e1e1e1e1e1e1e
33.379: MTRR: Fixed MSR 0x26e 0x1e1e1e1e1e1e1e1e
33.379: MTRR: Fixed MSR 0x26f 0x1e1e1e1e1e1e1e1e
33.379:=20
33.379: MTRR check
33.379: Fixed MTRRs   : Enabled
33.379: Variable MTRRs: Enabled
33.379:=20
33.379: Setting up local APIC...
33.379: MTRR check
33.379: Fixed MTRRs   : Enabled
33.379: Variable MTRRs: Enabled
33.379:=20
33.379: Setting up local APIC...Waiting for 20 CPUS to stop
33.379: Setting up local APIC... apic_id: 0x28 done.
33.379:  apic_id: 0x0a done.
33.379: CPU model: AMD Opteron(tm) Processor 6278
33.379: CPU model: AMD Opteron(tm) Processor 6278
33.379: siblings =3D 15, siblings =3D 15, Disabling SMM ASeg memory
33.379: Disabling SMM ASeg memory
33.379:  apic_id: 0x26 done.
33.379: CPU #10 initialized
33.379:=20
33.379: MTRR check
33.379: Fixed MTRRs   : Enabled
33.379: Variable MTRRs: Enabled
33.379:=20
33.379: CPU model: AMD Opteron(tm) Processor 6278
33.379: Waiting for 19 CPUS to stop
33.379:=20
33.379: MTRR check
33.379: Fixed MTRRs   : Enabled
33.379: Variable MTRRs: Enabled
33.379:=20
33.379: CPU #24 initialized
33.379: siblings =3D 15, Setting up local APIC...Setting up local APIC...=
 apic_id: 0x0b done.
33.379: Waiting for 18 CPUS to stop
33.380: CPU model: AMD Opteron(tm) Processor 6278
33.379:  apic_id: 0x29 done.
33.380: siblings =3D 15, Disabling SMM ASeg memory
33.380: Disabling SMM ASeg memory
33.380: CPU model: AMD Opteron(tm) Processor 6278
33.380: CPU #11 initialized
33.380: siblings =3D 15, CPU #22 initialized
33.380:=20
33.380: MTRR check
33.380: Fixed MTRRs   : Enabled
33.380: Variable MTRRs: Enabled
33.380:=20
33.380: Waiting for 17 CPUS to stop
33.380: Disabling SMM ASeg memory
33.380: Setting up local APIC...Waiting for 16 CPUS to stop
33.380: CPU #25 initialized
33.380:  apic_id: 0x27 done.
33.380: Waiting for 15 CPUS to stop
33.380: CPU model: AMD Opteron(tm) Processor 6278
33.380: CPU: family 15, model 01, stepping 02
33.380: MTRR: Fixed MSR 0x250 0x1e1e1e1e1e1e1e1e
33.380: MTRR: Fixed MSR 0x258 0x1e1e1e1e1e1e1e1e
33.380: MTRR: Fixed MSR 0x259 0x0000000000000000
33.380: MTRR: Fixed MSR 0x268 0x1e1e1e1e1e1e1e1e
33.380: MTRR: Fixed MSR 0x269 0x1e1e1e1e1e1e1e1e
33.380: MTRR: Fixed MSR 0x26a 0x1e1e1e1e1e1e1e1e
33.380: MTRR: Fixed MSR 0x26b 0x1e1e1e1e1e1e1e1e
33.380: MTRR: Fixed MSR 0x26c 0x1e1e1e1e1e1e1e1e
33.380: MTRR: Fixed MSR 0x26d 0x1e1e1e1e1e1e1e1e
33.380: MTRR: Fixed MSR 0x26e 0x1e1e1e1e1e1e1e1e
33.380: MTRR: Fixed MSR 0x26f 0x1e1e1e1e1e1e1e1e
33.380: siblings =3D 15, nodeid =3D 02, coreid =3D 02
33.380: Disabling SMM ASeg memory
33.380: Enabling cache
33.380: CPU #23 initialized
33.380: CPU is Fam 0Fh rev.F or later. We can use TOM2WB for any memory a=
bove 4GB
33.380: Waiting for 14 CPUS to stop
33.380: MTRR: Fixed MSR 0x250 0x1e1e1e1e1e1e1e1e
33.380: MTRR: Fixed MSR 0x258 0x1e1e1e1e1e1e1e1e
33.380: MTRR: Fixed MSR 0x259 0x0000000000000000
33.380: MTRR: Fixed MSR 0x268 0x1e1e1e1e1e1e1e1e
33.380: MTRR: Fixed MSR 0x269 0x1e1e1e1e1e1e1e1e
33.380: MTRR: Fixed MSR 0x26a 0x1e1e1e1e1e1e1e1e
33.380: MTRR: Fixed MSR 0x26b 0x1e1e1e1e1e1e1e1e
33.380: MTRR: Fixed MSR 0x26c 0x1e1e1e1e1e1e1e1e
33.380: MTRR: Fixed MSR 0x26d 0x1e1e1e1e1e1e1e1e
33.380: MTRR: Fixed MSR 0x26e 0x1e1e1e1e1e1e1e1e
33.380: MTRR: Fixed MSR 0x26f 0x1e1e1e1e1e1e1e1e
33.380: CPU: family 15, model 01, stepping 02
33.380: Initializing CPU #13
33.380:=20
33.380: MTRR check
33.380: nodeid =3D 02, coreid =3D 05
33.380:=20
33.380: MTRR check
33.380: Fixed MTRRs   : Enabled
33.380: Variable MTRRs: Enabled
33.380:=20
33.381: nodeid =3D 00, coreid =3D 05
33.381: MTRR: Fixed MSR 0x250 0x1e1e1e1e1e1e1e1e
33.381: MTRR: Fixed MSR 0x258 0x1e1e1e1e1e1e1e1e
33.381: MTRR: Fixed MSR 0x259 0x0000000000000000
33.381: MTRR: Fixed MSR 0x268 0x1e1e1e1e1e1e1e1e
33.381: MTRR: Fixed MSR 0x269 0x1e1e1e1e1e1e1e1e
33.381: MTRR: Fixed MSR 0x26a 0x1e1e1e1e1e1e1e1e
33.381: MTRR: Fixed MSR 0x26b 0x1e1e1e1e1e1e1e1e
33.381: MTRR: Fixed MSR 0x26c 0x1e1e1e1e1e1e1e1e
33.381: MTRR: Fixed MSR 0x26d 0x1e1e1e1e1e1e1e1e
33.381: MTRR: Fixed MSR 0x26e 0x1e1e1e1e1e1e1e1e
33.381: MTRR: Fixed MSR 0x26f 0x1e1e1e1e1e1e1e1e
33.381: Enabling cache
33.381: Setting up local APIC...CPU: vendor AMD device 600f12
33.381:  apic_id: 0x2e done.
33.381: nodeid =3D 01, coreid =3D 06
33.381: CPU model: AMD Opteron(tm) Processor 6278
33.381: nodeid =3D 02, coreid =3D 04
33.381: siblings =3D 15, Enabling cache
33.381: Disabling SMM ASeg memory
33.381: CPU is Fam 0Fh rev.F or later. We can use TOM2WB for any memory a=
bove 4GB
33.381: Enabling cache
33.381:=20
33.381: MTRR check
33.381: Fixed MTRRs   : Enabled
33.381: Variable MTRRs: Enabled
33.381:=20
33.381: MTRR: Fixed MSR 0x250 0x1e1e1e1e1e1e1e1e
33.381: MTRR: Fixed MSR 0x258 0x1e1e1e1e1e1e1e1e
33.381: MTRR: Fixed MSR 0x259 0x0000000000000000
33.381: MTRR: Fixed MSR 0x268 0x1e1e1e1e1e1e1e1e
33.381: MTRR: Fixed MSR 0x269 0x1e1e1e1e1e1e1e1e
33.381: MTRR: Fixed MSR 0x26a 0x1e1e1e1e1e1e1e1e
33.381: MTRR: Fixed MSR 0x26b 0x1e1e1e1e1e1e1e1e
33.381: MTRR: Fixed MSR 0x26c 0x1e1e1e1e1e1e1e1e
33.381: MTRR: Fixed MSR 0x26d 0x1e1e1e1e1e1e1e1e
33.381: MTRR: Fixed MSR 0x26e 0x1e1e1e1e1e1e1e1e
33.381: MTRR: Fixed MSR 0x26f 0x1e1e1e1e1e1e1e1e
33.381: Setting up local APIC...CPU #30 initialized
33.381:  apic_id: 0x2f done.
33.381:=20
33.381: MTRR check
33.381: Fixed MTRRs   : Enabled
33.381: Variable MTRRs: Enabled
33.381:=20
33.381: Waiting for 13 CPUS to stop
33.381: CPU model: AMD Opteron(tm) Processor 6278
33.381:=20
33.381: MTRR check
33.381: Fixed MTRRs   : Enabled
33.381: Variable MTRRs: Enabled
33.381:=20
33.381: siblings =3D 15, Setting up local APIC...Enabling cache
33.381: Fixed MTRRs   : Enabled
33.381: Variable MTRRs: Enabled
33.382:=20
33.382: Disabling SMM ASeg memory
33.382: Enabling cache
33.382: CPU #31 initialized
33.382: Setting up local APIC...CPU is Fam 0Fh rev.F or later. We can use=
 TOM2WB for any memory above 4GB
33.382:  apic_id: 0x20 done.
33.382: Waiting for 12 CPUS to stop
33.382: MTRR: Fixed MSR 0x250 0x1e1e1e1e1e1e1e1e
33.382: MTRR: Fixed MSR 0x258 0x1e1e1e1e1e1e1e1e
33.382: MTRR: Fixed MSR 0x259 0x0000000000000000
33.382: MTRR: Fixed MSR 0x268 0x1e1e1e1e1e1e1e1e
33.382: MTRR: Fixed MSR 0x269 0x1e1e1e1e1e1e1e1e
33.382: MTRR: Fixed MSR 0x26a 0x1e1e1e1e1e1e1e1e
33.382: MTRR: Fixed MSR 0x26b 0x1e1e1e1e1e1e1e1e
33.382: MTRR: Fixed MSR 0x26c 0x1e1e1e1e1e1e1e1e
33.382: MTRR: Fixed MSR 0x26d 0x1e1e1e1e1e1e1e1e
33.382: MTRR: Fixed MSR 0x26e 0x1e1e1e1e1e1e1e1e
33.382: MTRR: Fixed MSR 0x26f 0x1e1e1e1e1e1e1e1e
33.382:  apic_id: 0x22 done.
33.382: CPU model: AMD Opteron(tm) Processor 6278
33.382: CPU model: AMD Opteron(tm) Processor 6278
33.382:=20
33.382: MTRR check
33.382: Fixed MTRRs   : Enabled
33.382: Variable MTRRs: Enabled
33.382:=20
33.382: siblings =3D 15, siblings =3D 15, Setting up local APIC...Disabli=
ng SMM ASeg memory
33.382:  apic_id: 0x0e done.
33.382: Disabling SMM ASeg memory
33.382: CPU model: AMD Opteron(tm) Processor 6278
33.382: CPU #18 initialized
33.382: siblings =3D 15, Waiting for 11 CPUS to stop
33.382: Disabling SMM ASeg memory
33.382:=20
33.382: MTRR check
33.382: Fixed MTRRs   : Enabled
33.382: Variable MTRRs: Enabled
33.382:=20
33.382: CPU #14 initialized
33.382:=20
33.382: MTRR check
33.382: Fixed MTRRs   : Enabled
33.382: Variable MTRRs: Enabled
33.382:=20
33.382:=20
33.382: MTRR check
33.382: Fixed MTRRs   : Enabled
33.382: Variable MTRRs: Enabled
33.382:=20
33.382: Setting up local APIC...Waiting for 10 CPUS to stop
33.382:  apic_id: 0x0f done.
33.383: Setting up local APIC...CPU #16 initialized
33.383:  apic_id: 0x21 done.
33.383: CPU model: AMD Opteron(tm) Processor 6278
33.383: Waiting for 9 CPUS to stop
33.383: siblings =3D 15, Setting up local APIC...Disabling SMM ASeg memor=
y
33.383:  apic_id: 0x23 done.
33.383: CPU #15 initialized
33.383: CPU model: AMD Opteron(tm) Processor 6278
33.383: CPU is Fam 0Fh rev.F or later. We can use TOM2WB for any memory a=
bove 4GB
33.383: Waiting for 8 CPUS to stop
33.383: CPU model: AMD Opteron(tm) Processor 6278
33.383: siblings =3D 15, siblings =3D 15, Disabling SMM ASeg memory
33.383: Disabling SMM ASeg memory
33.383: CPU #19 initialized
33.383: CPU #17 initialized
33.383: Waiting for 7 CPUS to stop
33.383: Enabling cache
33.383: Waiting for 6 CPUS to stop
33.383: Enabling cache
33.383: CPU is Fam 0Fh rev.F or later. We can use TOM2WB for any memory a=
bove 4GB
33.383: CPU: family 15, model 01, stepping 02
33.383: MTRR: Fixed MSR 0x250 0x1e1e1e1e1e1e1e1e
33.383: MTRR: Fixed MSR 0x258 0x1e1e1e1e1e1e1e1e
33.383: MTRR: Fixed MSR 0x259 0x0000000000000000
33.383: MTRR: Fixed MSR 0x268 0x1e1e1e1e1e1e1e1e
33.383: MTRR: Fixed MSR 0x269 0x1e1e1e1e1e1e1e1e
33.383: MTRR: Fixed MSR 0x26a 0x1e1e1e1e1e1e1e1e
33.383: MTRR: Fixed MSR 0x26b 0x1e1e1e1e1e1e1e1e
33.383: MTRR: Fixed MSR 0x26c 0x1e1e1e1e1e1e1e1e
33.383: MTRR: Fixed MSR 0x26d 0x1e1e1e1e1e1e1e1e
33.383: MTRR: Fixed MSR 0x26e 0x1e1e1e1e1e1e1e1e
33.383: MTRR: Fixed MSR 0x26f 0x1e1e1e1e1e1e1e1e
33.383: nodeid =3D 01, coreid =3D 05
33.383: Setting up local APIC...Enabling cache
33.383: MTRR: Fixed MSR 0x250 0x1e1e1e1e1e1e1e1e
33.383: MTRR: Fixed MSR 0x258 0x1e1e1e1e1e1e1e1e
33.383: MTRR: Fixed MSR 0x259 0x0000000000000000
33.383: MTRR: Fixed MSR 0x268 0x1e1e1e1e1e1e1e1e
33.383: MTRR: Fixed MSR 0x269 0x1e1e1e1e1e1e1e1e
33.383: MTRR: Fixed MSR 0x26a 0x1e1e1e1e1e1e1e1e
33.383: MTRR: Fixed MSR 0x26b 0x1e1e1e1e1e1e1e1e
33.383: MTRR: Fixed MSR 0x26c 0x1e1e1e1e1e1e1e1e
33.383: MTRR: Fixed MSR 0x26d 0x1e1e1e1e1e1e1e1e
33.383: MTRR: Fixed MSR 0x26e 0x1e1e1e1e1e1e1e1e
33.383: MTRR: Fixed MSR 0x26f 0x1e1e1e1e1e1e1e1e
33.383:=20
33.383: MTRR check
33.383: Fixed MTRRs   : Enabled
33.383: Variable MTRRs: Enabled
33.383:=20
33.383:  apic_id: 0x0c done.
33.383:=20
33.383: MTRR check
33.383: Fixed MTRRs   : Enabled
33.383: Variable MTRRs: Enabled
33.383:=20
33.383: Setting up local APIC...Enabling cache
33.383:  apic_id: 0x24 done.
33.383: CPU model: AMD Opteron(tm) Processor 6278
33.384: CPU model: AMD Opteron(tm) Processor 6278
33.384: siblings =3D 15, siblings =3D 15, Disabling SMM ASeg memory
33.384: Disabling SMM ASeg memory
33.384:=20
33.384: MTRR check
33.384: Fixed MTRRs   : Enabled
33.384: Variable MTRRs:=20
33.384: MTRR check
33.384: Fixed MTRRs   : Enabled
33.384: Variable MTRRs: Enabled
33.384:=20
33.384: Setting up local APIC...Enabled
33.384:=20
33.384: Setting up local APIC...CPU #20 initialized
33.384:  apic_id: 0x25 done.
33.384: Setting up local APIC...CPU #12 initialized
33.384: CPU model: AMD Opteron(tm) Processor 6278
33.384:  apic_id: 0x0d done.
33.384: siblings =3D 15, CPU model: AMD Opteron(tm) Processor 6278
33.384: Disabling SMM ASeg memory
33.384: siblings =3D 15, CPU #21 initialized
33.384: Disabling SMM ASeg memory
33.384: Waiting for 5 CPUS to stop
33.384: CPU #13 initialized
33.384:  apic_id: 0x04 done.
33.384: Waiting for 3 CPUS to stop
33.384: CPU model: AMD Opteron(tm) Processor 6278
33.384: Waiting for 2 CPUS to stop
33.384: siblings =3D 15, Disabling SMM ASeg memory
33.384: CPU #4 initialized
33.384:=20
33.384: MTRR check
33.384: Fixed MTRRs   : Enabled
33.384: Variable MTRRs: Enabled
33.384:=20
33.384: Waiting for 1 CPUS to stop
33.384: Setting up local APIC... apic_id: 0x05 done.
33.384: CPU model: AMD Opteron(tm) Processor 6278
33.384: siblings =3D 15, Disabling SMM ASeg memory
33.384: CPU #5 initialized
33.384: All AP CPUs stopped (128979 loops)
33.384: CPU_CLUSTER: 0 init finished in 1379766 usecs
33.384: PCI: 00:18.0 init ...
33.384: PCI: 00:18.0 init finished in 1463 usecs
33.385: PCI: 00:18.1 init ...
33.385: PCI: 00:18.1 init finished in 1461 usecs
33.385: PCI: 00:18.2 init ...
33.385: PCI: 00:18.2 init finished in 1461 usecs
33.385: PCI: 00:18.3 init ...
33.385: NB: Function 3 Misc Control.. FMAP: area COREBOOT found @ 200 (20=
96640 bytes)
33.385: CBFS: Locating 'cmos_layout.bin'
33.385: CBFS: Found @ offset 2adc0 size dc4
33.386: done.
33.386: PCI: 00:18.3 init finished in 12309 usecs
33.386: PCI: 00:18.4 init ...
33.386: NB: Function 4 Link Control.. FMAP: area COREBOOT found @ 200 (20=
96640 bytes)
33.386: CBFS: Locating 'cmos_layout.bin'
33.386: CBFS: Found @ offset 2adc0 size dc4
33.387: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.387: CBFS: Locating 'cmos_layout.bin'
33.387: CBFS: Found @ offset 2adc0 size dc4
33.388: done.
33.388: PCI: 00:18.4 init finished in 20465 usecs
33.388: PCI: 00:18.5 init ...
33.388: NB: Function 5 Northbridge Control.. done.
33.388: PCI: 00:18.5 init finished in 4259 usecs
33.388: PCI: 00:19.0 init ...
33.388: PCI: 00:19.0 init finished in 1461 usecs
33.388: PCI: 00:19.1 init ...
33.388: PCI: 00:19.1 init finished in 1462 usecs
33.388: PCI: 00:19.2 init ...
33.388: PCI: 00:19.2 init finished in 1461 usecs
33.388: PCI: 00:19.3 init ...
33.388: NB: Function 3 Misc Control.. FMAP: area COREBOOT found @ 200 (20=
96640 bytes)
33.388: CBFS: Locating 'cmos_layout.bin'
33.388: CBFS: Found @ offset 2adc0 size dc4
33.389: done.
33.389: PCI: 00:19.3 init finished in 12302 usecs
33.389: PCI: 00:19.4 init ...
33.389: NB: Function 4 Link Control.. FMAP: area COREBOOT found @ 200 (20=
96640 bytes)
33.390: CBFS: Locating 'cmos_layout.bin'
33.390: CBFS: Found @ offset 2adc0 size dc4
33.391: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.391: CBFS: Locating 'cmos_layout.bin'
33.391: CBFS: Found @ offset 2adc0 size dc4
33.391: done.
33.391: PCI: 00:19.4 init finished in 20465 usecs
33.392: PCI: 00:19.5 init ...
33.392: NB: Function 5 Northbridge Control.. done.
33.392: PCI: 00:19.5 init finished in 4260 usecs
33.392: PCI: 00:1a.0 init ...
33.392: PCI: 00:1a.0 init finished in 1462 usecs
33.392: PCI: 00:1a.1 init ...
33.392: PCI: 00:1a.1 init finished in 1462 usecs
33.392: PCI: 00:1a.2 init ...
33.392: PCI: 00:1a.2 init finished in 1461 usecs
33.392: PCI: 00:1a.3 init ...
33.392: NB: Function 3 Misc Control.. FMAP: area COREBOOT found @ 200 (20=
96640 bytes)
33.392: CBFS: Locating 'cmos_layout.bin'
33.392: CBFS: Found @ offset 2adc0 size dc4
33.393: done.
33.393: PCI: 00:1a.3 init finished in 12303 usecs
33.393: PCI: 00:1a.4 init ...
33.393: NB: Function 4 Link Control.. FMAP: area COREBOOT found @ 200 (20=
96640 bytes)
33.393: CBFS: Locating 'cmos_layout.bin'
33.393: CBFS: Found @ offset 2adc0 size dc4
33.394: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.394: CBFS: Locating 'cmos_layout.bin'
33.394: CBFS: Found @ offset 2adc0 size dc4
33.395: done.
33.395: PCI: 00:1a.4 init finished in 20466 usecs
33.395: PCI: 00:1a.5 init ...
33.395: NB: Function 5 Northbridge Control.. done.
33.395: PCI: 00:1a.5 init finished in 4259 usecs
33.395: PCI: 00:1b.0 init ...
33.395: PCI: 00:1b.0 init finished in 1461 usecs
33.395: PCI: 00:1b.1 init ...
33.395: PCI: 00:1b.1 init finished in 1461 usecs
33.395: PCI: 00:1b.2 init ...
33.395: PCI: 00:1b.2 init finished in 1461 usecs
33.395: PCI: 00:1b.3 init ...
33.395: NB: Function 3 Misc Control.. FMAP: area COREBOOT found @ 200 (20=
96640 bytes)
33.395: CBFS: Locating 'cmos_layout.bin'
33.396: CBFS: Found @ offset 2adc0 size dc4
33.396: done.
33.396: PCI: 00:1b.3 init finished in 12302 usecs
33.396: PCI: 00:1b.4 init ...
33.396: NB: Function 4 Link Control.. FMAP: area COREBOOT found @ 200 (20=
96640 bytes)
33.397: CBFS: Locating 'cmos_layout.bin'
33.397: CBFS: Found @ offset 2adc0 size dc4
33.398: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.398: CBFS: Locating 'cmos_layout.bin'
33.398: CBFS: Found @ offset 2adc0 size dc4
33.399: done.
33.399: PCI: 00:1b.4 init finished in 20465 usecs
33.399: PCI: 00:1b.5 init ...
33.399: NB: Function 5 Northbridge Control.. done.
33.399: PCI: 00:1b.5 init finished in 4260 usecs
33.399: PCI: 00:00.0 init ...
33.399: pcie_init in sr5650_ht.c
33.399: IOAPIC: Initializing IOAPIC at 0xfce00000
33.399: IOAPIC: Bootstrap Processor Local APIC =3D 0x00
33.399: IOAPIC: ID =3D 0x01
33.399: IOAPIC: 32 interrupts
33.399: IOAPIC: Enabling interrupts on FSB
33.399: PCI: 00:00.0 init finished in 13766 usecs
33.399: PCI: 00:11.0 init ...
33.399: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.399: CBFS: Locating 'cmos_layout.bin'
33.399: CBFS: Found @ offset 2adc0 size dc4
33.400: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.400: CBFS: Locating 'cmos_layout.bin'
33.400: CBFS: Found @ offset 2adc0 size dc4
33.423: drive no longer selected after 10 ms, retrying init
33.423: AHCI device 0 is ready after 2 tries
33.423: No AHCI SATA drive on Slot1
33.423: No AHCI SATA drive on Slot2
33.443: drive no longer selected after 20 ms, retrying init
33.443: AHCI device 3 is ready after 2 tries
33.443: No AHCI SATA drive on Slot4
33.443: No AHCI SATA drive on Slot5
33.443: PCI: 00:11.0 init finished in 67634 usecs
33.443: PCI: 00:12.0 init ...
33.443: PCI: 00:12.0 init finished in 1484 usecs
33.443: PCI: 00:12.1 init ...
33.443: PCI: 00:12.1 init finished in 1483 usecs
33.443: PCI: 00:12.2 init ...
33.443: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.443: CBFS: Locating 'cmos_layout.bin'
33.444: CBFS: Found @ offset 2adc0 size dc4
33.444: usb2_bar0=3D0xfcb0e000
33.444: rpr 6.23, final dword=3D849e03c8
33.444: PCI: 00:12.2 init finished in 13317 usecs
33.444: PCI: 00:13.0 init ...
33.444: PCI: 00:13.0 init finished in 1483 usecs
33.444: PCI: 00:13.1 init ...
33.444: PCI: 00:13.1 init finished in 1482 usecs
33.445: PCI: 00:13.2 init ...
33.445: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.445: CBFS: Locating 'cmos_layout.bin'
33.445: CBFS: Found @ offset 2adc0 size dc4
33.446: usb2_bar0=3D0xfcb0f000
33.446: rpr 6.23, final dword=3D849e03c8
33.446: PCI: 00:13.2 init finished in 13324 usecs
33.446: PCI: 00:14.0 init ...
33.446: sm_init().
33.446: IOAPIC: Initializing IOAPIC at 0xfec00000
33.446: IOAPIC: Bootstrap Processor Local APIC =3D 0x00
33.446: IOAPIC: 24 interrupts
33.446: IOAPIC: Enabling interrupts on FSB
33.446: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.446: CBFS: Locating 'cmos_layout.bin'
33.446: CBFS: Found @ offset 2adc0 size dc4
33.447: No CMOS option 'enable_legacy_usb'.
33.447: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.447: CBFS: Locating 'cmos_layout.bin'
33.447: CBFS: Found @ offset 2adc0 size dc4
33.448: set power "on" after power fail
33.448: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.448: CBFS: Locating 'cmos_layout.bin'
33.448: CBFS: Found @ offset 2adc0 size dc4
33.449: ++++++++++no set NMI+++++
33.449: RTC Init
33.449: sm_init() end
33.449: PCI: 00:14.0 init finished in 44566 usecs
33.449: PCI: 00:14.1 init ...
33.449: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.449: CBFS: Locating 'cmos_layout.bin'
33.450: CBFS: Found @ offset 2adc0 size dc4
33.450: PCI: 00:14.1 init finished in 9804 usecs
33.450: PCI: 00:14.2 init ...
33.450: base =3D 0xfcb04000
33.454: No codec!
33.454: PCI: 00:14.2 init finished in 6296 usecs
33.454: PCI: 00:14.3 init ...
33.454: PCI: 00:14.3 init finished in 1483 usecs
33.454: PCI: 00:14.4 init ...
33.454: PCI: 00:14.4 init finished in 1479 usecs
33.454: PCI: 00:14.5 init ...
33.454: PCI: 00:14.5 init finished in 1483 usecs
33.454: PCI: 03:00.0 init ...
33.455: PCI: 03:00.0 init finished in 1461 usecs
33.455: PCI: 04:00.0 init ...
33.455: PCI: 04:00.0 init finished in 1461 usecs
33.455: PCI: 07:00.0 init ...
33.455: PCI: 07:00.0 init finished in 1461 usecs
33.455: PCI: 07:00.1 init ...
33.455: PCI: 07:00.1 init finished in 1461 usecs
33.455: smbus: PCI: 00:14.0[0]->I2C: 01:2f init ...
33.455: Set SMBUS controller to channel 1
33.459: Found 64 pin W83795G Nuvoton H/W Monitor
33.743: W83795G/ADG work in Thermal Cruise Mode
33.743: Fan<09>CTFS(celsius)<09>TTTI(celsius)
33.745:  1<09>80<09>80
33.751:  2<09>80<09>80
33.756:  3<09>80<09>80
33.762:  4<09>80<09>80
33.768:  5<09>80<09>80
33.773:  6<09>80<09>80
33.779: DTS1 current value: 1a
33.781: DTS2 current value: 19
33.784: DTS3 current value: 0
33.787: DTS4 current value: 0
33.790: DTS5 current value: 0
33.793: DTS6 current value: 0
33.795: DTS7 current value: 0
33.798: DTS8 current value: 0
33.803: Set SMBUS controller to channel 0
33.803: I2C: 01:2f init finished in 283764 usecs
33.803: PNP: 002e.2 init ...
33.803: PNP: 002e.2 init finished in 1396 usecs
33.803: PNP: 002e.3 init ...
33.803: PNP: 002e.3 init finished in 1397 usecs
33.803: PNP: 002e.5 init ...
33.803: w83667hg_a_init: Disable mouse controller.PNP: 002e.5 init finish=
ed in 4072 usecs
33.803: PNP: 002e.a init ...
33.804: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.804: CBFS: Locating 'cmos_layout.bin'
33.804: CBFS: Found @ offset 2adc0 size dc4
33.804: set power on after power fail
33.804: PNP: 002e.a init finished in 11561 usecs
33.804: PNP: 002e.b init ...
33.804: PNP: 002e.b init finished in 1398 usecs
33.804: PCI: 08:01.0 init ...
33.804: ASpeed AST2050: initializing video device
33.804: ast_detect_chip: AST 1100 detected
33.804: ast_detect_chip: VGA not enabled on entry, requesting chip POST
33.804: ast_detect_chip: Analog VGA only
33.805: ast_driver_load: dram 132000000 0 32 00800000
33.826: ASpeed VGA text mode initialized
33.826: PCI: 08:01.0 init finished in 33439 usecs
33.826: PCI: 08:02.0 init ...
33.826: PCI: 08:02.0 init finished in 1461 usecs
33.826: Devices initialized
33.826: BS: BS_DEV_INIT times (us): entry 0 run 2212421 exit 0
33.826: Finalize devices...
33.826: Devices finalized
33.826: BS: BS_POST_DEVICE times (us): entry 0 run 2546 exit 0
33.826: BS: BS_OS_RESUME_CHECK times (us): entry 0 run 1 exit 0
33.826: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.826: CBFS: Locating 'cmos_layout.bin'
33.826: CBFS: Found @ offset 2adc0 size dc4
33.827: Writing IRQ routing tables to 0xf0000...done.
33.827: Writing IRQ routing tables to 0xb7dbe000...done.
33.827: PIRQ table: 48 bytes.
33.827: Wrote the mp table end at: 000f0410 - 000f08ac
33.827: Wrote the mp table end at: b7dbd010 - b7dbd4ac
33.827: MP table: 1196 bytes.
33.827: CBFS: 'Master Header Locator' located CBFS at [200:200000)
33.827: CBFS: Locating 'fallback/dsdt.aml'
33.827: CBFS: Found @ offset 2bbc0 size 26a7
33.827: CBFS: 'Master Header Locator' located CBFS at [200:200000)
33.827: CBFS: Locating 'fallback/slic'
33.828: CBFS: 'fallback/slic' not found.
33.828: ACPI: Writing ACPI tables at b7d99000.
33.828: ACPI:    * FACS
33.828: ACPI:    * DSDT
33.834: ACPI:    * FADT
33.834: pm_base: 0x0800
33.834: ACPI: added table 1/32, length now 40
33.834: ACPI:     * SSDT
33.834: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.834: CBFS: Locating 'cmos_layout.bin'
33.834: CBFS: Found @ offset 2adc0 size dc4
33.835: processor_brand=3DAMD Opteron(tm) Processor 6278
33.835: Pstates algorithm ...
33.835: Pstate_freq[0] =3D 2400MHz<09>Pstate_power[0] =3D 6150mw
33.835: Pstate_latency[0] =3D 5us
33.835: Pstate_freq[1] =3D 2100MHz<09>Pstate_power[1] =3D 5233mw
33.835: Pstate_latency[1] =3D 5us
33.835: Pstate_freq[2] =3D 1900MHz<09>Pstate_power[2] =3D 4620mw
33.835: Pstate_latency[2] =3D 5us
33.835: Pstate_freq[3] =3D 1600MHz<09>Pstate_power[3] =3D 3990mw
33.835: Pstate_latency[3] =3D 5us
33.835: Pstate_freq[4] =3D 1400MHz<09>Pstate_power[4] =3D 3422mw
33.835: Pstate_latency[4] =3D 5us
33.835: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.835: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.835: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.835: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.835: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.835: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.835: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.835: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.835: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.835: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.835: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.835: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.835: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.835: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.835: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.835: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.835: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.835: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.835: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.835: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.835: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.835: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.835: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.835: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.835: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.835: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.835: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.835: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.835: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.835: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.835: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.835: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.835: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.835: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.835: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.835: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.835: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.835: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.835: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.835: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.835: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.835: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.836: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.835: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.836: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.836: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.836: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.836: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.836: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.836: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.836: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.836: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.836: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.836: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.836: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.836: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.836: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.836: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.836: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.836: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.836: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.836: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.836: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.836: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.836: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.836: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.836: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.836: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.836: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.836: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.836: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.836: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.836: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.836: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.836: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.836: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.836: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.836: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.836: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.836: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.836: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.836: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.836: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.836: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.836: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.836: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.836: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.836: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.836: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.836: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.836: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.836: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.836: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.836: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.836: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.836: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.836: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.836: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.836: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.836: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.836: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.836: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.836: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.836: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.836: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.836: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.836: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.836: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.836: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.836: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.836: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.836: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.836: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.836: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.836: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.836: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.836: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.836: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.836: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.836: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.836: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.836: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.836: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.836: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.836: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.836: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.836: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.836: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.836: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.836: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.836: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.836: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.836: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.836: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.836: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.836: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.836: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.836: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.837: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.837: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.837: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.837: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.837: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.837: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.837: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.837: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.837: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.837: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.837: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.837: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.837: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.837: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.837: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.837: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.837: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.837: PSS: 2400MHz power 6150 control 0x0 status 0x0
33.837: PSS: 2100MHz power 5233 control 0x1 status 0x1
33.837: PSS: 1900MHz power 4620 control 0x2 status 0x2
33.837: PSS: 1600MHz power 3990 control 0x3 status 0x3
33.837: PSS: 1400MHz power 3422 control 0x4 status 0x4
33.837: \_SB.PCI0.LPC.TPM: LPC TPM PNP: 004e.0
33.837: ACPI: added table 2/32, length now 44
33.837: ACPI:    * MCFG
33.837: ACPI: added table 3/32, length now 48
33.837: ACPI:    * MADT
33.837: ACPI: added table 4/32, length now 52
33.837: current =3D b7d9f5d0
33.837: ACPI:    * SRAT at b7d9f5d0
33.837: SRAT: lapic cpu_index=3D00, node_id=3D00, apic_id=3D00
33.837: SRAT: lapic cpu_index=3D01, node_id=3D00, apic_id=3D01
33.837: SRAT: lapic cpu_index=3D02, node_id=3D00, apic_id=3D02
33.837: SRAT: lapic cpu_index=3D03, node_id=3D00, apic_id=3D03
33.837: SRAT: lapic cpu_index=3D04, node_id=3D00, apic_id=3D04
33.837: SRAT: lapic cpu_index=3D05, node_id=3D00, apic_id=3D05
33.837: SRAT: lapic cpu_index=3D06, node_id=3D00, apic_id=3D06
33.837: SRAT: lapic cpu_index=3D07, node_id=3D00, apic_id=3D07
33.837: SRAT: lapic cpu_index=3D08, node_id=3D01, apic_id=3D08
33.837: SRAT: lapic cpu_index=3D09, node_id=3D01, apic_id=3D09
33.837: SRAT: lapic cpu_index=3D0a, node_id=3D01, apic_id=3D0a
33.837: SRAT: lapic cpu_index=3D0b, node_id=3D01, apic_id=3D0b
33.837: SRAT: lapic cpu_index=3D0c, node_id=3D01, apic_id=3D0c
33.837: SRAT: lapic cpu_index=3D0d, node_id=3D01, apic_id=3D0d
33.837: SRAT: lapic cpu_index=3D0e, node_id=3D01, apic_id=3D0e
33.837: SRAT: lapic cpu_index=3D0f, node_id=3D01, apic_id=3D0f
33.837: SRAT: lapic cpu_index=3D10, node_id=3D02, apic_id=3D20
33.837: SRAT: lapic cpu_index=3D11, node_id=3D02, apic_id=3D21
33.837: SRAT: lapic cpu_index=3D12, node_id=3D02, apic_id=3D22
33.837: SRAT: lapic cpu_index=3D13, node_id=3D02, apic_id=3D23
33.837: SRAT: lapic cpu_index=3D14, node_id=3D02, apic_id=3D24
33.837: SRAT: lapic cpu_index=3D15, node_id=3D02, apic_id=3D25
33.837: SRAT: lapic cpu_index=3D16, node_id=3D02, apic_id=3D26
33.837: SRAT: lapic cpu_index=3D17, node_id=3D02, apic_id=3D27
33.837: SRAT: lapic cpu_index=3D18, node_id=3D03, apic_id=3D28
33.837: SRAT: lapic cpu_index=3D19, node_id=3D03, apic_id=3D29
33.837: SRAT: lapic cpu_index=3D1a, node_id=3D03, apic_id=3D2a
33.837: SRAT: lapic cpu_index=3D1b, node_id=3D03, apic_id=3D2b
33.837: SRAT: lapic cpu_index=3D1c, node_id=3D03, apic_id=3D2c
33.837: SRAT: lapic cpu_index=3D1d, node_id=3D03, apic_id=3D2d
33.837: SRAT: lapic cpu_index=3D1e, node_id=3D03, apic_id=3D2e
33.837: SRAT: lapic cpu_index=3D1f, node_id=3D03, apic_id=3D2f
33.837: set_srat_mem: dev DOMAIN: 0000, res->index=3D0007 startk=3D000000=
00, sizek=3D00300000
33.837: set_srat_mem: dev DOMAIN: 0000, res->index=3D0008 startk=3D080e00=
00, sizek=3D00020000
33.837: set_srat_mem: dev DOMAIN: 0000, res->index=3D0010 startk=3D000000=
00, sizek=3D00000280
33.837: set_srat_mem: dev DOMAIN: 0000, res->index=3D0020 startk=3D000003=
00, sizek=3D002ffd00
33.837: set_srat_mem: dev DOMAIN: 0000, res->index=3D0030 startk=3D004000=
00, sizek=3D01d00000
33.837: set_srat_mem: dev DOMAIN: 0000, res->index=3D0041 startk=3D021000=
00, sizek=3D02000000
33.837: set_srat_mem: dev DOMAIN: 0000, res->index=3D0052 startk=3D041000=
00, sizek=3D02000000
33.837: set_srat_mem: dev DOMAIN: 0000, res->index=3D0063 startk=3D061000=
00, sizek=3D02000000
33.837: ACPI: added table 5/32, length now 56
33.837: ACPI:   * SLIT at b7d9f8f0
33.837: ACPI: added table 6/32, length now 60
33.837: ACPI:    * SRAT at b7d9f930
33.837: SRAT: lapic cpu_index=3D00, node_id=3D00, apic_id=3D00
33.837: SRAT: lapic cpu_index=3D01, node_id=3D00, apic_id=3D01
33.837: SRAT: lapic cpu_index=3D02, node_id=3D00, apic_id=3D02
33.837: SRAT: lapic cpu_index=3D03, node_id=3D00, apic_id=3D03
33.837: SRAT: lapic cpu_index=3D04, node_id=3D00, apic_id=3D04
33.837: SRAT: lapic cpu_index=3D05, node_id=3D00, apic_id=3D05
33.837: SRAT: lapic cpu_index=3D06, node_id=3D00, apic_id=3D06
33.837: SRAT: lapic cpu_index=3D07, node_id=3D00, apic_id=3D07
33.837: SRAT: lapic cpu_index=3D08, node_id=3D01, apic_id=3D08
33.837: SRAT: lapic cpu_index=3D09, node_id=3D01, apic_id=3D09
33.837: SRAT: lapic cpu_index=3D0a, node_id=3D01, apic_id=3D0a
33.837: SRAT: lapic cpu_index=3D0b, node_id=3D01, apic_id=3D0b
33.837: SRAT: lapic cpu_index=3D0c, node_id=3D01, apic_id=3D0c
33.837: SRAT: lapic cpu_index=3D0d, node_id=3D01, apic_id=3D0d
33.837: SRAT: lapic cpu_index=3D0e, node_id=3D01, apic_id=3D0e
33.837: SRAT: lapic cpu_index=3D0f, node_id=3D01, apic_id=3D0f
33.837: SRAT: lapic cpu_index=3D10, node_id=3D02, apic_id=3D20
33.837: SRAT: lapic cpu_index=3D11, node_id=3D02, apic_id=3D21
33.837: SRAT: lapic cpu_index=3D12, node_id=3D02, apic_id=3D22
33.837: SRAT: lapic cpu_index=3D13, node_id=3D02, apic_id=3D23
33.837: SRAT: lapic cpu_index=3D14, node_id=3D02, apic_id=3D24
33.837: SRAT: lapic cpu_index=3D15, node_id=3D02, apic_id=3D25
33.838: SRAT: lapic cpu_index=3D16, node_id=3D02, apic_id=3D26
33.838: SRAT: lapic cpu_index=3D17, node_id=3D02, apic_id=3D27
33.838: SRAT: lapic cpu_index=3D18, node_id=3D03, apic_id=3D28
33.838: SRAT: lapic cpu_index=3D19, node_id=3D03, apic_id=3D29
33.838: SRAT: lapic cpu_index=3D1a, node_id=3D03, apic_id=3D2a
33.838: SRAT: lapic cpu_index=3D1b, node_id=3D03, apic_id=3D2b
33.838: SRAT: lapic cpu_index=3D1c, node_id=3D03, apic_id=3D2c
33.838: SRAT: lapic cpu_index=3D1d, node_id=3D03, apic_id=3D2d
33.838: SRAT: lapic cpu_index=3D1e, node_id=3D03, apic_id=3D2e
33.838: SRAT: lapic cpu_index=3D1f, node_id=3D03, apic_id=3D2f
33.838: set_srat_mem: dev DOMAIN: 0000, res->index=3D0007 startk=3D000000=
00, sizek=3D00300000
33.838: set_srat_mem: dev DOMAIN: 0000, res->index=3D0008 startk=3D080e00=
00, sizek=3D00020000
33.838: set_srat_mem: dev DOMAIN: 0000, res->index=3D0010 startk=3D000000=
00, sizek=3D00000280
33.838: set_srat_mem: dev DOMAIN: 0000, res->index=3D0020 startk=3D000003=
00, sizek=3D002ffd00
33.838: set_srat_mem: dev DOMAIN: 0000, res->index=3D0030 startk=3D004000=
00, sizek=3D01d00000
33.838: set_srat_mem: dev DOMAIN: 0000, res->index=3D0041 startk=3D021000=
00, sizek=3D02000000
33.838: set_srat_mem: dev DOMAIN: 0000, res->index=3D0052 startk=3D041000=
00, sizek=3D02000000
33.838: set_srat_mem: dev DOMAIN: 0000, res->index=3D0063 startk=3D061000=
00, sizek=3D02000000
33.838: ACPI: added table 7/32, length now 64
33.838: ACPI:   * SLIT at b7d9fc50
33.838: ACPI: added table 8/32, length now 68
33.838: ACPI:    * SRAT at b7d9fc90
33.838: SRAT: lapic cpu_index=3D00, node_id=3D00, apic_id=3D00
33.838: SRAT: lapic cpu_index=3D01, node_id=3D00, apic_id=3D01
33.838: SRAT: lapic cpu_index=3D02, node_id=3D00, apic_id=3D02
33.838: SRAT: lapic cpu_index=3D03, node_id=3D00, apic_id=3D03
33.838: SRAT: lapic cpu_index=3D04, node_id=3D00, apic_id=3D04
33.838: SRAT: lapic cpu_index=3D05, node_id=3D00, apic_id=3D05
33.838: SRAT: lapic cpu_index=3D06, node_id=3D00, apic_id=3D06
33.838: SRAT: lapic cpu_index=3D07, node_id=3D00, apic_id=3D07
33.838: SRAT: lapic cpu_index=3D08, node_id=3D01, apic_id=3D08
33.838: SRAT: lapic cpu_index=3D09, node_id=3D01, apic_id=3D09
33.838: SRAT: lapic cpu_index=3D0a, node_id=3D01, apic_id=3D0a
33.838: SRAT: lapic cpu_index=3D0b, node_id=3D01, apic_id=3D0b
33.838: SRAT: lapic cpu_index=3D0c, node_id=3D01, apic_id=3D0c
33.838: SRAT: lapic cpu_index=3D0d, node_id=3D01, apic_id=3D0d
33.838: SRAT: lapic cpu_index=3D0e, node_id=3D01, apic_id=3D0e
33.838: SRAT: lapic cpu_index=3D0f, node_id=3D01, apic_id=3D0f
33.838: SRAT: lapic cpu_index=3D10, node_id=3D02, apic_id=3D20
33.838: SRAT: lapic cpu_index=3D11, node_id=3D02, apic_id=3D21
33.838: SRAT: lapic cpu_index=3D12, node_id=3D02, apic_id=3D22
33.838: SRAT: lapic cpu_index=3D13, node_id=3D02, apic_id=3D23
33.838: SRAT: lapic cpu_index=3D14, node_id=3D02, apic_id=3D24
33.838: SRAT: lapic cpu_index=3D15, node_id=3D02, apic_id=3D25
33.838: SRAT: lapic cpu_index=3D16, node_id=3D02, apic_id=3D26
33.838: SRAT: lapic cpu_index=3D17, node_id=3D02, apic_id=3D27
33.838: SRAT: lapic cpu_index=3D18, node_id=3D03, apic_id=3D28
33.838: SRAT: lapic cpu_index=3D19, node_id=3D03, apic_id=3D29
33.838: SRAT: lapic cpu_index=3D1a, node_id=3D03, apic_id=3D2a
33.838: SRAT: lapic cpu_index=3D1b, node_id=3D03, apic_id=3D2b
33.838: SRAT: lapic cpu_index=3D1c, node_id=3D03, apic_id=3D2c
33.838: SRAT: lapic cpu_index=3D1d, node_id=3D03, apic_id=3D2d
33.838: SRAT: lapic cpu_index=3D1e, node_id=3D03, apic_id=3D2e
33.838: SRAT: lapic cpu_index=3D1f, node_id=3D03, apic_id=3D2f
33.838: set_srat_mem: dev DOMAIN: 0000, res->index=3D0007 startk=3D000000=
00, sizek=3D00300000
33.838: set_srat_mem: dev DOMAIN: 0000, res->index=3D0008 startk=3D080e00=
00, sizek=3D00020000
33.838: set_srat_mem: dev DOMAIN: 0000, res->index=3D0010 startk=3D000000=
00, sizek=3D00000280
33.838: set_srat_mem: dev DOMAIN: 0000, res->index=3D0020 startk=3D000003=
00, sizek=3D002ffd00
33.838: set_srat_mem: dev DOMAIN: 0000, res->index=3D0030 startk=3D004000=
00, sizek=3D01d00000
33.838: set_srat_mem: dev DOMAIN: 0000, res->index=3D0041 startk=3D021000=
00, sizek=3D02000000
33.838: set_srat_mem: dev DOMAIN: 0000, res->index=3D0052 startk=3D041000=
00, sizek=3D02000000
33.838: set_srat_mem: dev DOMAIN: 0000, res->index=3D0063 startk=3D061000=
00, sizek=3D02000000
33.838: ACPI: added table 9/32, length now 72
33.838: ACPI:   * SLIT at b7d9ffb0
33.838: ACPI: added table 10/32, length now 76
33.838: ACPI:    * SRAT at b7d9fff0
33.838: SRAT: lapic cpu_index=3D00, node_id=3D00, apic_id=3D00
33.838: SRAT: lapic cpu_index=3D01, node_id=3D00, apic_id=3D01
33.838: SRAT: lapic cpu_index=3D02, node_id=3D00, apic_id=3D02
33.838: SRAT: lapic cpu_index=3D03, node_id=3D00, apic_id=3D03
33.838: SRAT: lapic cpu_index=3D04, node_id=3D00, apic_id=3D04
33.838: SRAT: lapic cpu_index=3D05, node_id=3D00, apic_id=3D05
33.838: SRAT: lapic cpu_index=3D06, node_id=3D00, apic_id=3D06
33.838: SRAT: lapic cpu_index=3D07, node_id=3D00, apic_id=3D07
33.838: SRAT: lapic cpu_index=3D08, node_id=3D01, apic_id=3D08
33.838: SRAT: lapic cpu_index=3D09, node_id=3D01, apic_id=3D09
33.838: SRAT: lapic cpu_index=3D0a, node_id=3D01, apic_id=3D0a
33.838: SRAT: lapic cpu_index=3D0b, node_id=3D01, apic_id=3D0b
33.838: SRAT: lapic cpu_index=3D0c, node_id=3D01, apic_id=3D0c
33.838: SRAT: lapic cpu_index=3D0d, node_id=3D01, apic_id=3D0d
33.838: SRAT: lapic cpu_index=3D0e, node_id=3D01, apic_id=3D0e
33.838: SRAT: lapic cpu_index=3D0f, node_id=3D01, apic_id=3D0f
33.838: SRAT: lapic cpu_index=3D10, node_id=3D02, apic_id=3D20
33.838: SRAT: lapic cpu_index=3D11, node_id=3D02, apic_id=3D21
33.838: SRAT: lapic cpu_index=3D12, node_id=3D02, apic_id=3D22
33.838: SRAT: lapic cpu_index=3D13, node_id=3D02, apic_id=3D23
33.838: SRAT: lapic cpu_index=3D14, node_id=3D02, apic_id=3D24
33.838: SRAT: lapic cpu_index=3D15, node_id=3D02, apic_id=3D25
33.838: SRAT: lapic cpu_index=3D16, node_id=3D02, apic_id=3D26
33.838: SRAT: lapic cpu_index=3D17, node_id=3D02, apic_id=3D27
33.838: SRAT: lapic cpu_index=3D18, node_id=3D03, apic_id=3D28
33.838: SRAT: lapic cpu_index=3D19, node_id=3D03, apic_id=3D29
33.838: SRAT: lapic cpu_index=3D1a, node_id=3D03, apic_id=3D2a
33.838: SRAT: lapic cpu_index=3D1b, node_id=3D03, apic_id=3D2b
33.838: SRAT: lapic cpu_index=3D1c, node_id=3D03, apic_id=3D2c
33.838: SRAT: lapic cpu_index=3D1d, node_id=3D03, apic_id=3D2d
33.838: SRAT: lapic cpu_index=3D1e, node_id=3D03, apic_id=3D2e
33.838: SRAT: lapic cpu_index=3D1f, node_id=3D03, apic_id=3D2f
33.838: set_srat_mem: dev DOMAIN: 0000, res->index=3D0007 startk=3D000000=
00, sizek=3D00300000
33.838: set_srat_mem: dev DOMAIN: 0000, res->index=3D0008 startk=3D080e00=
00, sizek=3D00020000
33.838: set_srat_mem: dev DOMAIN: 0000, res->index=3D0010 startk=3D000000=
00, sizek=3D00000280
33.838: set_srat_mem: dev DOMAIN: 0000, res->index=3D0020 startk=3D000003=
00, sizek=3D002ffd00
33.838: set_srat_mem: dev DOMAIN: 0000, res->index=3D0030 startk=3D004000=
00, sizek=3D01d00000
33.838: set_srat_mem: dev DOMAIN: 0000, res->index=3D0041 startk=3D021000=
00, sizek=3D02000000
33.839: set_srat_mem: dev DOMAIN: 0000, res->index=3D0052 startk=3D041000=
00, sizek=3D02000000
33.839: set_srat_mem: dev DOMAIN: 0000, res->index=3D0063 startk=3D061000=
00, sizek=3D02000000
33.838: ACPI: added table 11/32, length now 80
33.839: ACPI:   * SLIT at b7da0310
33.839: ACPI: added table 12/32, length now 84
33.839: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.839: CBFS: Locating 'cmos_layout.bin'
33.839: CBFS: Found @ offset 2adc0 size dc4
33.840: ACPI:   * IVRS at b7da0350
33.840: ACPI: added table 13/32, length now 88
33.840: ACPI:    * HPET
33.840: ACPI: added table 14/32, length now 92
33.840: ACPI: done.
33.840: ACPI tables: 29776 bytes.
33.840: smbios_write_tables: b7d98000
33.840: DOMAIN: 0000 (AMD Family 10h/15h Root Complex)
33.840: SMBIOS tables: 1091 bytes.
33.840: Writing table forward entry at 0x00000500
33.840: Wrote coreboot table at: 00000500, 0x10 bytes, checksum 5802
33.840: Writing coreboot table at 0xb7dbf000
33.840: CBFS: 'Master Header Locator' located CBFS at [200:200000)
33.840: CBFS: Locating 'cmos_layout.bin'
33.840: CBFS: Found @ offset 2adc0 size dc4
33.842:  0. 0000000000000000-0000000000000fff: CONFIGURATION TABLES
33.842:  1. 0000000000001000-000000000009ffff: RAM
33.842:  2. 00000000000a0000-00000000000bffff: RESERVED
33.842:  3. 00000000000c0000-0000000000dfffff: RAM
33.842:  4. 0000000000e00000-0000000000f18fff: RAMSTAGE
33.842:  5. 0000000000f19000-00000000b7d97fff: RAM
33.842:  6. 00000000b7d98000-00000000b7ffffff: CONFIGURATION TABLES
33.842:  7. 00000000b8000000-00000000bfffffff: RAM
33.842:  8. 00000000c0000000-00000000cfffffff: RESERVED
33.842:  9. 00000000fcb00000-00000000fcb03fff: RESERVED
33.842: 10. 00000000feb00000-00000000feb00fff: RESERVED
33.842: 11. 00000000fec00000-00000000fec00fff: RESERVED
33.842: 12. 00000000fed00000-00000000fed00fff: RESERVED
33.842: 13. 00000000fed40000-00000000fed44fff: RESERVED
33.842: 14. 0000000100000000-0000002037ffffff: RAM
33.842: 15. 0000002038000000-000000203fffffff: RESERVED
33.842: Manufacturer: ef
33.842: SF: Detected W25Q16 with sector size 0x1000, total 0x200000
33.842: CBFS: 'Master Header Locator' located CBFS at [200:200000)
33.842: Wrote coreboot table at: b7dbf000, 0x1158 bytes, checksum eb33
33.842: coreboot table: 4464 bytes.
33.842: IMD ROOT    0. b7fff000 00001000
33.843: IMD SMALL   1. b7ffe000 00001000
33.843: CAR GLOBALS 2. b7ff3000 0000a7c0
33.843: CONSOLE     3. b7fd3000 00020000
33.843: TIME STAMP  4. b7fd2000 00000910
33.843: AMDMEM INFO 5. b7fc8000 000093fc
33.843: ACPI RESUME 6. b7dc7000 00201000
33.843: COREBOOT    7. b7dbf000 00008000
33.843: IRQ TABLE   8. b7dbe000 00001000
33.843: SMP TABLE   9. b7dbd000 00001000
33.843: ACPI       10. b7d99000 00024000
33.843: SMBIOS     11. b7d98000 00000800
33.843: IMD small region:
33.843:   IMD ROOT    0. b7ffec00 00000400
33.843:   ROMSTAGE    1. b7ffebe0 00000004
33.843:   GDT         2. b7ffe9e0 00000200
33.844:   COREBOOTFWD 3. b7ffe9a0 00000028
33.844: Writing AMD DCT configuration to Flash
33.845: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.845: CBFS: Locating 'cmos_layout.bin'
33.846: CBFS: Found @ offset 2adc0 size dc4
33.846: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.846: CBFS: Locating 'cmos_layout.bin'
33.846: CBFS: Found @ offset 2adc0 size dc4
33.847: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.847: CBFS: Locating 'cmos_layout.bin'
33.847: CBFS: Found @ offset 2adc0 size dc4
33.848: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.848: CBFS: Locating 'cmos_layout.bin'
33.848: CBFS: Found @ offset 2adc0 size dc4
33.849: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.849: CBFS: Locating 'cmos_layout.bin'
33.849: CBFS: Found @ offset 2adc0 size dc4
33.850: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.850: CBFS: Locating 'cmos_layout.bin'
33.850: CBFS: Found @ offset 2adc0 size dc4
33.851: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.851: CBFS: Locating 'cmos_layout.bin'
33.851: CBFS: Found @ offset 2adc0 size dc4
33.851: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.851: CBFS: Locating 'cmos_layout.bin'
33.852: CBFS: Found @ offset 2adc0 size dc4
33.852: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.852: CBFS: Locating 'cmos_layout.bin'
33.853: CBFS: Found @ offset 2adc0 size dc4
33.853: FMAP: area COREBOOT found @ 200 (2096640 bytes)
33.853: CBFS: Locating 'cmos_layout.bin'
33.854: CBFS: Found @ offset 2adc0 size dc4
33.854: CBFS: 'Master Header Locator' located CBFS at [200:200000)
33.854: CBFS: Locating 's3nv'
33.855: CBFS: Found @ offset 2fdc0 size 10000
33.855: Manufacturer: ef
33.855: SF: Detected W25Q16 with sector size 0x1000, total 0x200000
34.049: SF: Successfully erased 32768 bytes @ 0x38000
34.416: FMAP: area COREBOOT found @ 200 (2096640 bytes)
34.416: CBFS: Locating 'cmos_layout.bin'
34.416: CBFS: Found @ offset 2adc0 size dc4
34.417: BS: BS_WRITE_TABLES times (us): entry 0 run 1853207 exit 0
34.417: CBFS: 'Master Header Locator' located CBFS at [200:200000)
34.417: CBFS: Locating 'fallback/payload'
34.418: CBFS: Found @ offset 5cf00 size 10a0b
34.418: Checking segment from ROM address 0xffe5d138
34.418: Checking segment from ROM address 0xffe5d154
34.418: Loading segment from ROM address 0xffe5d138
34.418:   code (compression=3D1)
34.418:   New segment dstaddr 0x000e06e0 memsize 0x1f920 srcaddr 0xffe5d1=
70 filesize 0x109d3
34.418: Loading Segment: addr: 0x000e06e0 memsz: 0x000000000001f920 files=
z: 0x00000000000109d3
34.418: using LZMA
34.456: Loading segment from ROM address 0xffe5d154
34.456:   Entry Point 0x000fd258
34.456: BS: BS_PAYLOAD_LOAD times (us): entry 0 run 63466 exit 0
34.457: Jumping to boot code at 000fd258(b7dbf000)
34.456: SeaBIOS (version rel-1.12.0-4-g29ba89e6)
34.457: BUILD: gcc: (coreboot toolchain v1.53 August 16th, 2018) 8.1.0 bi=
nutils: (GNU Binutils) 2.30
34.457: SeaBIOS (version rel-1.12.0-4-g29ba89e6)
34.457: BUILD: gcc: (coreboot toolchain v1.53 August 16th, 2018) 8.1.0 bi=
nutils: (GNU Binutils) 2.30
34.457: Found coreboot cbmem console @ b7fd3000
34.457: Found mainboard ASUS KGPE-D16
34.457: Relocating init from 0x000e1d40 to 0xbffb3540 (size 51712)
34.457: Found CBFS header at 0xffe00238
34.458: multiboot: eax=3De32240, ebx=3De321f4
34.458: Found 52 PCI devices (max PCI bus is 08)
34.458: Copying SMBIOS entry point from 0xb7d98000 to 0x000f6280
34.458: Copying ACPI RSDP from 0xb7d99000 to 0x000f6250
34.458: Skipping MPTABLE copy due to large size (1196 bytes)
34.458: Copying PIR from 0xb7dbe000 to 0x000f6220
34.459: Using pmtimer, ioport 0x820
34.459: Scan for VGA option rom
34.475: Running option rom at c000:0003
34.475: Start SeaVGABIOS (version rel-1.12.0-4-g29ba89e6)
34.475: VGABUILD: gcc: (coreboot toolchain v1.53 August 16th, 2018) 8.1.0=
 binutils: (GNU Binutils) 2.30
34.475: enter vga_post:
34.475:    a=3D00000000  b=3D0000ffff  c=3D00000000  d=3D0000ffff ds=3D00=
00 es=3Df000 ss=3D0000
34.475:   si=3D00000000 di=3D000066a0 bp=3D00000000 sp=3D00006dda cs=3Df0=
00 ip=3Dd031  f=3D0000
34.475: coreboot vga init
34.475: Did not find coreboot framebuffer - assuming EGA text
34.475: Attempting to allocate 512 bytes lowmem via pmm call to f000:d0ac=

34.475: pmm call arg1=3D0
34.475: VGA stack allocated at edc80
34.476: Hooking hardware timer irq (old=3Df000fea5 new=3Dc0003e44)
34.476: Turning on vga text mode console
34.476: set VGA mode 3
34.476: SeaBIOS (version rel-1.12.0-4-g29ba89e6)
34.476: EHCI init on dev 00:12.2 (regs=3D0xfcb0e020)
34.476: EHCI init on dev 00:13.2 (regs=3D0xfcb0f020)
34.476: OHCI init on dev 00:12.0 (regs=3D0xfcb08000)
34.476: OHCI init on dev 00:12.1 (regs=3D0xfcb09000)
34.477: OHCI init on dev 00:13.0 (regs=3D0xfcb0a000)
34.477: OHCI init on dev 00:13.1 (regs=3D0xfcb0b000)
34.477: OHCI init on dev 00:14.5 (regs=3D0xfcb0c000)
34.480: ATA controller 1 at 1f0/3f4/0 (irq 14 dev a1)
34.480: ATA controller 2 at 170/374/0 (irq 15 dev a1)
34.480: AHCI controller at 00:11.0, iobase 0xfcb0d000, irq 0
34.481: Found 0 lpt ports
34.481: Found 2 serial ports
34.481: Searching bootorder for: /pci@i0cf8/*@11/drive@3/disk@0
34.481: AHCI/3: Set transfer mode to UDMA-6
34.481: Got ps2 nak (status=3D51)
34.481: Searching bootorder for: /pci@i0cf8/*@11/drive@0/disk@0
34.481: AHCI/0: Set transfer mode to UDMA-6
34.481: AHCI/3: registering: "AHCI/3: HGST HDN724030ALE640 ATA-8 Hard-Dis=
k (2794 GiBytes)"
34.481: AHCI/0: registering: "AHCI/0: Hitachi HUA721010KLA330 ATA-7 Hard-=
Disk (931 GiBytes)"
34.519: USB keyboard initialized
34.585: All threads complete.
34.585: Scan for option roms
34.585:=20
34.585: Press ESC for boot menu.
34.585:=20
37.114: Searching bootorder for: HALT
37.113: drive 0x000f6120: PCHS=3D16383/16/63 translation=3Dlba LCHS=3D102=
4/255/63 s=3D1953525168
37.114: drive 0x000f6170: PCHS=3D16383/16/63 translation=3Dlba LCHS=3D102=
4/255/63 s=3D1565565872
37.114: Space available for UMB: c7000-ed000, f5aa0-f6120
37.114: Returned 245760 bytes of ZoneHigh
37.114: e820 map has 14 items:
37.114:   0: 0000000000000000 - 000000000009fc00 =3D 1 RAM
37.114:   1: 000000000009fc00 - 00000000000a0000 =3D 2 RESERVED
37.114:   2: 00000000000f0000 - 0000000000100000 =3D 2 RESERVED
37.114:   3: 0000000000100000 - 00000000b7d98000 =3D 1 RAM
37.114:   4: 00000000b7d98000 - 00000000b8000000 =3D 2 RESERVED
37.114:   5: 00000000b8000000 - 00000000bfffc000 =3D 1 RAM
37.114:   6: 00000000bfffc000 - 00000000d0000000 =3D 2 RESERVED
37.114:   7: 00000000fcb00000 - 00000000fcb04000 =3D 2 RESERVED
37.114:   8: 00000000feb00000 - 00000000feb01000 =3D 2 RESERVED
37.114:   9: 00000000fec00000 - 00000000fec01000 =3D 2 RESERVED
37.114:   10: 00000000fed00000 - 00000000fed01000 =3D 2 RESERVED
37.114:   11: 00000000fed40000 - 00000000fed45000 =3D 2 RESERVED
37.114:   12: 0000000100000000 - 0000002038000000 =3D 1 RAM
37.114:   13: 0000002038000000 - 0000002040000000 =3D 2 RESERVED
37.115: enter handle_19:
37.115:   NULL
37.115: Booting from Hard Disk...
37.134: Booting from 0000:7c00
45.213: [    0.000000] Linux version 4.20.0-rc7.mx64.237 (root@likearolli=
ngstone.molgen.mpg.de) (gcc version 7.3.0 (GCC)) #1 SMP Mon Dec 17 11:32:=
46 CET 2018
45.214: [    0.000000] Command line: BOOT_IMAGE=3D/boot/bzImage-4.20.0-rc=
7.mx64.237 crashkernel=3D256M root=3DLABEL=3Droot ro console=3DttyS0,1152=
00n8 console=3DttyS1,115200n8 console=3Dtty0 init=3D/bin/systemd audit=3D=
0
45.215: [    0.000000] random: get_random_u32 called from bsp_init_amd+0x=
18e/0x2c0 with crng_init=3D0
45.215: [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floa=
ting point registers'
45.216: [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE regi=
sters'
45.216: [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX regi=
sters'
45.216: [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]: =
 256
45.216: [    0.000000] x86/fpu: Enabled xstate features 0x7, context size=
 is 832 bytes, using 'standard' format.
45.216: [    0.000000] BIOS-provided physical RAM map:
45.216: [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009f=
bff] usable
45.217: [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009f=
fff] reserved
45.217: [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000ff=
fff] reserved
45.217: [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000b7d97=
fff] usable
45.217: [    0.000000] BIOS-e820: [mem 0x00000000b7d98000-0x00000000b7fff=
fff] reserved
45.217: [    0.000000] BIOS-e820: [mem 0x00000000b8000000-0x00000000bfffb=
fff] usable
45.217: [    0.000000] BIOS-e820: [mem 0x00000000bfffc000-0x00000000cffff=
fff] reserved
45.218: [    0.000000] BIOS-e820: [mem 0x00000000fcb00000-0x00000000fcb03=
fff] reserved
45.218: [    0.000000] BIOS-e820: [mem 0x00000000feb00000-0x00000000feb00=
fff] reserved
45.218: [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00=
fff] reserved
45.218: [    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00=
fff] reserved
45.218: [    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44=
fff] reserved
45.218: [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000002037fff=
fff] usable
45.218: [    0.000000] BIOS-e820: [mem 0x0000002038000000-0x000000203ffff=
fff] reserved
45.219: [    0.000000] NX (Execute Disable) protection: active
45.219: [    0.000000] SMBIOS 2.7 present.
45.219: [    0.000000] DMI: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-103-g637bef2=
037 01/02/2019
45.219: [    0.000000] tsc: Fast TSC calibration using PIT
45.219: [    0.000000] tsc: Detected 2400.225 MHz processor
45.219: [    0.010434] AGP: No AGP bridge found
45.220: [    0.010511] last_pfn =3D 0x2038000 max_arch_pfn =3D 0x40000000=
0
45.220: [    0.012743] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  =
WP  UC- WT =20
45.220: [    0.012932] last_pfn =3D 0xbfffc max_arch_pfn =3D 0x400000000
45.220: [    0.019388] Using GB pages for direct mapping
45.220: [    0.019953] RAMDISK: [mem 0x375e7000-0x37aeafff]
45.220: [    0.019959] ACPI: Early table checksum verification disabled
45.221: [    0.020020] ACPI: RSDP 0x00000000000F6250 000024 (v02 COREv4)
45.221: [    0.020025] ACPI: XSDT 0x00000000B7D990E0 000094 (v01 COREv4 C=
OREBOOT 00000000 CORE 00000000)
45.221: [    0.020032] ACPI: FACP 0x00000000B7D9B930 0000F4 (v03 COREv4 C=
OREBOOT 00000000 CORE 00000000)
45.221: [    0.020038] ACPI: DSDT 0x00000000B7D99280 0026A7 (v02 COREv4 C=
OREBOOT 00000001 INTL 20180810)
45.221: [    0.020043] ACPI: FACS 0x00000000B7D99240 000040
45.222: [    0.020046] ACPI: FACS 0x00000000B7D99240 000040
45.222: [    0.020049] ACPI: SSDT 0x00000000B7D9BA30 0039F2 (v02 COREv4 C=
OREBOOT 0000002A CORE 0000002A)
45.222: [    0.020053] ACPI: MCFG 0x00000000B7D9F430 00003C (v01 COREv4 C=
OREBOOT 00000000 CORE 00000000)
45.222: [    0.020056] ACPI: APIC 0x00000000B7D9F470 00015E (v02 COREv4 C=
OREBOOT 00000000 CORE 00000000)
45.223: [    0.020060] ACPI: SRAT 0x00000000B7D9F5D0 000320 (v01 COREv4 C=
OREBOOT 00000000 CORE 00000000)
45.223: [    0.020064] ACPI: SLIT 0x00000000B7D9F8F0 00003C (v01 COREv4 C=
OREBOOT 00000000 CORE 00000000)
45.223: [    0.020067] ACPI: SRAT 0x00000000B7D9F930 000320 (v01 COREv4 C=
OREBOOT 00000000 CORE 00000000)
45.223: [    0.020071] ACPI: SLIT 0x00000000B7D9FC50 00003C (v01 COREv4 C=
OREBOOT 00000000 CORE 00000000)
45.224: [    0.020074] ACPI: SRAT 0x00000000B7D9FC90 000320 (v01 COREv4 C=
OREBOOT 00000000 CORE 00000000)
45.224: [    0.020078] ACPI: SLIT 0x00000000B7D9FFB0 00003C (v01 COREv4 C=
OREBOOT 00000000 CORE 00000000)
45.224: [    0.020082] ACPI: SRAT 0x00000000B7D9FFF0 000320 (v01 COREv4 C=
OREBOOT 00000000 CORE 00000000)
45.224: [    0.020086] ACPI: SLIT 0x00000000B7DA0310 00003C (v01 COREv4 C=
OREBOOT 00000000 CORE 00000000)
45.225: [    0.020089] ACPI: IVRS 0x00000000B7DA0350 0000B4 (v01 COREv4 C=
OREBOOT 00000000 CORE 00000000)
45.225: [    0.020093] ACPI: HPET 0x00000000B7DA0410 000038 (v01 COREv4 C=
OREBOOT 00000000 CORE 00000000)
45.225: [    0.020149] SRAT: PXM 0 -> APIC 0x00 -> Node 0
45.225: [    0.020151] SRAT: PXM 0 -> APIC 0x01 -> Node 0
45.225: [    0.020152] SRAT: PXM 0 -> APIC 0x02 -> Node 0
45.225: [    0.020153] SRAT: PXM 0 -> APIC 0x03 -> Node 0
45.226: [    0.020154] SRAT: PXM 0 -> APIC 0x04 -> Node 0
45.226: [    0.020156] SRAT: PXM 0 -> APIC 0x05 -> Node 0
45.226: [    0.020157] SRAT: PXM 0 -> APIC 0x06 -> Node 0
45.226: [    0.020158] SRAT: PXM 0 -> APIC 0x07 -> Node 0
45.226: [    0.020159] SRAT: PXM 1 -> APIC 0x08 -> Node 1
45.226: [    0.020161] SRAT: PXM 1 -> APIC 0x09 -> Node 1
45.227: [    0.020162] SRAT: PXM 1 -> APIC 0x0a -> Node 1
45.227: [    0.020163] SRAT: PXM 1 -> APIC 0x0b -> Node 1
45.227: [    0.020164] SRAT: PXM 1 -> APIC 0x0c -> Node 1
45.227: [    0.020166] SRAT: PXM 1 -> APIC 0x0d -> Node 1
45.227: [    0.020167] SRAT: PXM 1 -> APIC 0x0e -> Node 1
45.227: [    0.020168] SRAT: PXM 1 -> APIC 0x0f -> Node 1
45.227: [    0.020170] SRAT: PXM 2 -> APIC 0x20 -> Node 2
45.228: [    0.020171] SRAT: PXM 2 -> APIC 0x21 -> Node 2
45.228: [    0.020172] SRAT: PXM 2 -> APIC 0x22 -> Node 2
45.228: [    0.020174] SRAT: PXM 2 -> APIC 0x23 -> Node 2
45.228: [    0.020175] SRAT: PXM 2 -> APIC 0x24 -> Node 2
45.228: [    0.020176] SRAT: PXM 2 -> APIC 0x25 -> Node 2
45.228: [    0.020177] SRAT: PXM 2 -> APIC 0x26 -> Node 2
45.229: [    0.020178] SRAT: PXM 2 -> APIC 0x27 -> Node 2
45.229: [    0.020180] SRAT: PXM 3 -> APIC 0x28 -> Node 3
45.229: [    0.020181] SRAT: PXM 3 -> APIC 0x29 -> Node 3
45.229: [    0.020182] SRAT: PXM 3 -> APIC 0x2a -> Node 3
45.229: [    0.020183] SRAT: PXM 3 -> APIC 0x2b -> Node 3
45.229: [    0.020185] SRAT: PXM 3 -> APIC 0x2c -> Node 3
45.229: [    0.020186] SRAT: PXM 3 -> APIC 0x2d -> Node 3
45.230: [    0.020187] SRAT: PXM 3 -> APIC 0x2e -> Node 3
45.230: [    0.020188] SRAT: PXM 3 -> APIC 0x2f -> Node 3
45.230: [    0.020192] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009fff=
f]
45.230: [    0.020194] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xbffffff=
f]
45.230: [    0.020195] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x83ffff=
fff]
45.230: [    0.020197] ACPI: SRAT: Node 1 PXM 1 [mem 0x840000000-0x103fff=
ffff]
45.231: [    0.020199] ACPI: SRAT: Node 2 PXM 2 [mem 0x1040000000-0x183ff=
fffff]
45.231: [    0.020200] ACPI: SRAT: Node 3 PXM 3 [mem 0x1840000000-0x203ff=
fffff]
45.231: [    0.020207] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x=
00100000-0xbfffffff] -> [mem 0x00000000-0xbfffffff]
45.231: [    0.020209] NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [mem 0x=
100000000-0x83fffffff] -> [mem 0x00000000-0x83fffffff]
45.231: [    0.020215] NODE_DATA(0) allocated [mem 0x83fffc000-0x83ffffff=
f]
45.232: [    0.020220] NODE_DATA(1) allocated [mem 0x103fffc000-0x103ffff=
fff]
45.232: [    0.020226] NODE_DATA(2) allocated [mem 0x183fffc000-0x183ffff=
fff]
45.232: [    0.020232] NODE_DATA(3) allocated [mem 0x2037ff9000-0x2037ffc=
fff]
45.232: [    0.020245] Reserving 256MB of memory at 624MB for crashkernel=
 (System RAM: 130941MB)
45.232: [    0.020372] Zone ranges:
45.232: [    0.020373]   DMA      [mem 0x0000000000001000-0x0000000000fff=
fff]
45.233: [    0.020376]   DMA32    [mem 0x0000000001000000-0x00000000fffff=
fff]
45.233: [    0.020377]   Normal   [mem 0x0000000100000000-0x0000002037fff=
fff]
45.233: [    0.020379] Movable zone start for each node
45.233: [    0.020381] Early memory node ranges
45.233: [    0.020382]   node   0: [mem 0x0000000000001000-0x000000000009=
efff]
45.233: [    0.020384]   node   0: [mem 0x0000000000100000-0x00000000b7d9=
7fff]
45.234: [    0.020385]   node   0: [mem 0x00000000b8000000-0x00000000bfff=
bfff]
45.234: [    0.020386]   node   0: [mem 0x0000000100000000-0x000000083fff=
ffff]
45.234: [    0.020388]   node   1: [mem 0x0000000840000000-0x000000103fff=
ffff]
45.234: [    0.020389]   node   2: [mem 0x0000001040000000-0x000000183fff=
ffff]
45.234: [    0.020390]   node   3: [mem 0x0000001840000000-0x0000002037ff=
ffff]
45.234: [    0.020411] Zeroed struct page in unavailable ranges: 718 page=
s
45.235: [    0.020412] Initmem setup node 0 [mem 0x0000000000001000-0x000=
000083fffffff]
45.235: [    0.265226] Initmem setup node 1 [mem 0x0000000840000000-0x000=
000103fffffff]
45.235: [    0.521667] Initmem setup node 2 [mem 0x0000001040000000-0x000=
000183fffffff]
45.235: [    0.790539] Initmem setup node 3 [mem 0x0000001840000000-0x000=
0002037ffffff]
45.235: [    1.046835] ACPI: PM-Timer IO Port: 0x820
45.235: [    1.046851] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
45.236: [    1.046863] IOAPIC[0]: apic_id 32, version 33, address 0xfec00=
000, GSI 0-23
45.236: [    1.046867] IOAPIC[1]: apic_id 33, version 33, address 0xfce00=
000, GSI 24-55
45.236: [    1.046870] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 df=
l dfl)
45.236: [    1.046872] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 lo=
w level)
45.236: [    1.046878] Using ACPI (MADT) for SMP configuration informatio=
n
45.236: [    1.046880] ACPI: HPET id: 0x43538301 base: 0xfed00000
45.237: [    1.046886] smpboot: Allowing 32 CPUs, 0 hotplug CPUs
45.237: [    1.046908] [mem 0xd0000000-0xfcafffff] available for PCI devi=
ces
45.237: [    1.046912] clocksource: refined-jiffies: mask: 0xffffffff max=
_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
45.237: [    1.245847] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_c=
pu_ids:32 nr_node_ids:4
45.237: [    1.249076] percpu: Embedded 42 pages/cpu @(____ptrval____) s1=
33912 r8192 d29928 u262144
45.238: [    1.249134] Built 4 zonelists, mobility grouping on.  Total pa=
ges: 32997158
45.238: [    1.249136] Policy zone: Normal
45.238: [    1.249139] Kernel command line: BOOT_IMAGE=3D/boot/bzImage-4.=
20.0-rc7.mx64.237 crashkernel=3D256M root=3DLABEL=3Droot ro console=3Dtty=
S0,115200n8 console=3DttyS1,115200n8 console=3Dtty0 init=3D/bin/systemd a=
udit=3D0
45.238: [    1.249309] audit: disabled (until reboot)
45.238: [    1.249311] printk: log_buf_len individual max cpu contributio=
n: 4096 bytes
45.239: [    1.249312] printk: log_buf_len total cpu_extra contributions:=
 126976 bytes
45.239: [    1.249314] printk: log_buf_len min size: 131072 bytes
45.239: [    1.249430] printk: log_buf_len: 262144 bytes
45.239: [    1.249432] printk: early log buf free: 118596(90%)
45.239: [    1.264350] AGP: Checking aperture...
45.239: [    1.272816] AGP: No AGP bridge found
45.239: [    1.272820] AGP: Node 0: aperture [bus addr 0xf8000000-0xfbfff=
fff] (64MB)
45.240: [    1.272823] AGP: Node 1: aperture [bus addr 0xf8000000-0xfbfff=
fff] (64MB)
45.240: [    1.272826] AGP: Node 2: aperture [bus addr 0xf8000000-0xfbfff=
fff] (64MB)
45.240: [    1.272828] AGP: Node 3: aperture [bus addr 0xf8000000-0xfbfff=
fff] (64MB)
45.240: [    1.993836] Memory: 131620760K/134083784K available (14341K ke=
rnel code, 1377K rwdata, 3512K rodata, 1564K init, 1200K bss, 2463024K re=
served, 0K cma-reserved)
45.240: [    1.994187] ftrace: allocating 41693 entries in 163 pages
45.241: [    2.024627] rcu: Hierarchical RCU implementation.
45.241: [    2.024630] rcu: <09>RCU event tracing is enabled.
45.241: [    2.024632] rcu: <09>RCU restricting CPUs from NR_CPUS=3D256 t=
o nr_cpu_ids=3D32.
45.241: [    2.024634] rcu: RCU calculated value of scheduler-enlistment =
delay is 100 jiffies.
45.241: [    2.024635] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, =
nr_cpu_ids=3D32
45.243: [    2.027180] NR_IRQS: 16640, nr_irqs: 1224, preallocated irqs: =
16
45.243: [    2.032945] Console: colour VGA+ 80x25
45.243: [    2.057642] printk: console [tty0] enabled
45.243: [    3.055078] printk: console [ttyS0] enabled
45.244: [    3.059472] ACPI: Core revision 20181003
45.244: [    3.063812] clocksource: hpet: mask: 0xffffffff max_cycles: 0x=
ffffffff, max_idle_ns: 133484873504 ns
45.244: [    3.073203] APIC: Switch to symmetric I/O mode setup
45.244: [    3.078319] Switched APIC routing to physical flat.
45.245: [    3.083898] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D=
0 pin2=3D0
45.250: [    3.094195] clocksource: tsc-early: mask: 0xffffffffffffffff m=
ax_cycles: 0x22990c32be1, max_idle_ns: 440795280004 ns
45.250: [    3.104946] Calibrating delay loop (skipped), value calculated=
 using timer frequency.. 4800.45 BogoMIPS (lpj=3D2400225)
45.250: [    3.105947] pid_max: default: 32768 minimum: 301
45.274: [    3.130530] Dentry cache hash table entries: 8388608 (order: 1=
4, 67108864 bytes)
45.286: [    3.143030] Inode-cache hash table entries: 4194304 (order: 13=
, 33554432 bytes)
45.286: [    3.145005] Mount-cache hash table entries: 131072 (order: 8, =
1048576 bytes)
45.287: [    3.146318] Mountpoint-cache hash table entries: 131072 (order=
: 8, 1048576 bytes)
45.288: [    3.147408] mce: CPU supports 7 MCE banks
45.288: [    3.147954] LVT offset 1 assigned for vector 0xf9
45.288: [    3.148953] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 51=
2
45.288: [    3.149947] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 5=
12, 1GB 0
45.288: [    3.150949] Spectre V2 : Mitigation: Full AMD retpoline
45.288: [    3.151947] Spectre V2 : Spectre v2 / SpectreRSB mitigation: F=
illing RSB on context switch
45.289: [    3.152947] Spectre V2 : mitigation: Enabling conditional Indi=
rect Branch Prediction Barrier
45.289: [    3.153947] Spectre V2 : User space: Vulnerable
45.289: [    3.154949] Speculative Store Bypass: Mitigation: Speculative =
Store Bypass disabled via prctl and seccomp
45.290: [    3.156226] Freeing SMP alternatives memory: 44K
45.391: [    3.157945] smpboot: CPU0: AMD Opteron(tm) Processor 6278 (fam=
ily: 0x15, model: 0x1, stepping: 0x2)
45.391: [    3.158137] Performance Events: Fam15h core perfctr, AMD PMU d=
river.
45.392: [    3.158949] ... version:                0
45.392: [    3.159947] ... bit width:              48
45.392: [    3.160947] ... generic registers:      6
45.392: [    3.161947] ... value mask:             0000ffffffffffff
45.392: [    3.162947] ... max period:             00007fffffffffff
45.392: [    3.163947] ... fixed-purpose events:   0
45.393: [    3.164947] ... event mask:             000000000000003f
45.393: [    3.166015] rcu: Hierarchical SRCU implementation.
45.393: [    3.167053] MCE: In-kernel MCE decoding enabled.
45.394: [    3.169310] smp: Bringing up secondary CPUs ...
45.394: [    3.170148] x86: Booting SMP configuration:
45.397: [    3.170948] .... node  #0, CPUs:        #1
45.397: [    1.069444] do_IRQ: 1.55 No irq handler for vector
45.401: [    3.183134]   #2
45.401: [    1.069444] do_IRQ: 2.55 No irq handler for vector
45.405: [    3.192396]   #3
45.405: [    1.069444] do_IRQ: 3.55 No irq handler for vector
45.408: [    3.201681]   #4
45.409: [    1.069444] do_IRQ: 4.55 No irq handler for vector
45.412: [    3.210972]   #5
45.412: [    1.069444] do_IRQ: 5.55 No irq handler for vector
45.416: [    3.220253]   #6
45.416: [    1.069444] do_IRQ: 6.55 No irq handler for vector
45.420: [    3.229543]   #7
45.420: [    1.069444] do_IRQ: 7.55 No irq handler for vector
45.423: [    3.238910] .... node  #1, CPUs:    #8
45.423: [    1.069444] do_IRQ: 8.55 No irq handler for vector
45.427: [    3.250303]   #9
45.427: [    1.069444] do_IRQ: 9.55 No irq handler for vector
45.431: [    3.259706]  #10
45.431: [    1.069444] do_IRQ: 10.55 No irq handler for vector
45.449: [    3.269181]  #11 #12 #13 #14 #15
45.555: [    3.281949] .... node  #2, CPUs:   #16 #17 #18 #19 #20 #21 #22=
 #23
45.583: [    3.362949] .... node  #3, CPUs:   #24 #25 #26 #27 #28 #29 #30=
 #31
45.583: [    3.383080] smp: Brought up 4 nodes, 32 CPUs
45.583: [    3.384948] smpboot: Max logical packages: 2
45.584: [    3.385952] smpboot: Total of 32 processors activated (153596.=
57 BogoMIPS)
45.664: [    3.396221] devtmpfs: initialized
45.665: [    3.398321] clocksource: jiffies: mask: 0xffffffff max_cycles:=
 0xffffffff, max_idle_ns: 1911260446275000 ns
45.665: [    3.398990] futex hash table entries: 8192 (order: 7, 524288 b=
ytes)
45.665: [    3.401130] xor: automatically using best checksumming functio=
n   avx      =20
45.666: [    3.402200] NET: Registered protocol family 16
45.666: [    3.403401] cpuidle: using governor ladder
45.667: [    3.408308] ACPI: bus type PCI registered
45.667: [    3.412001] PCI: MMCONFIG for domain 0000 [bus 00-1f] at [mem =
0xc0000000-0xc1ffffff] (base 0xc0000000)
45.668: [    3.421950] PCI: MMCONFIG at [mem 0xc0000000-0xc1ffffff] reser=
ved in E820
45.668: [    3.428957] PCI: Using configuration type 1 for base access
45.674: [    3.440350] HugeTLB registered 2.00 MiB page size, pre-allocat=
ed 0 pages
45.690: [    3.463186] raid6: sse2x1   gen()  1921 MB/s
45.707: [    3.484192] raid6: sse2x1   xor()  3470 MB/s
45.724: [    3.505186] raid6: sse2x2   gen()  6941 MB/s
45.741: [    3.526186] raid6: sse2x2   xor()  5128 MB/s
45.757: [    3.547186] raid6: sse2x4   gen()  8914 MB/s
45.774: [    3.568187] raid6: sse2x4   xor()  2683 MB/s
45.774: [    3.572948] raid6: using algorithm sse2x4 gen() 8914 MB/s
45.774: [    3.577947] raid6: .... xor() 2683 MB/s, rmw enabled
45.775: [    3.583948] raid6: using ssse3x2 recovery algorithm
45.775: [    3.589166] ACPI: Added _OSI(Module Device)
45.775: [    3.592949] ACPI: Added _OSI(Processor Device)
45.775: [    3.597948] ACPI: Added _OSI(3.0 _SCP Extensions)
45.775: [    3.602948] ACPI: Added _OSI(Processor Aggregator Device)
45.776: [    3.607949] ACPI: Added _OSI(Linux-Dell-Video)
45.776: [    3.612950] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
45.781: [    3.622807] ACPI: 2 ACPI AML tables successfully acquired and =
loaded
45.783: [    3.631375] ACPI: Interpreter enabled
45.783: [    3.635976] ACPI: (supports S0 S1 S3 S5)
45.783: [    3.639948] ACPI: Using IOAPIC for interrupt routing
45.784: [    3.645033] PCI: Using host bridge windows from ACPI; if neces=
sary, use "pci=3Dnocrs" and report a bug
45.784: [    3.654064] ACPI: Enabled 6 GPEs in block 00 to 1F
45.799: [    3.673813] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 7 10 11 12=
 14 15) *0, disabled.
45.800: [    3.682022] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 10 11 12=
 14 15) *0, disabled.
45.800: [    3.690023] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 10 11 12=
 14 15) *0, disabled.
45.800: [    3.698022] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 7 10 11 12=
 14 15) *0, disabled.
45.800: [    3.706019] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 7 10 11 12=
 14 15) *0, disabled.
45.801: [    3.714018] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 7 10 11 12=
 14 15) *0, disabled.
45.801: [    3.722020] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 7 10 11 12=
 14 15) *0, disabled.
45.801: [    3.730019] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 7 10 11 12=
 14 15) *0, disabled.
45.812: [    3.747321] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-=
08])
45.812: [    3.753953] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig=
 ASPM ClockPM Segments MSI]
45.812: [    3.761984] acpi PNP0A08:00: _OSC: OS now controls [PME AER PC=
IeCapability LTR]
45.822: [    3.779467] acpi PNP0A08:00: host bridge window expanded to [i=
o  0x0000-0x0cf7 window]; [io  0x0000-0x0cf7 window] ignored
45.822: [    3.790986] PCI host bridge to bus 0000:00
45.822: [    3.794949] pci_bus 0000:00: root bus resource [io  0x0000-0x0=
cf7 window]
45.823: [    3.801949] pci_bus 0000:00: root bus resource [io  0x0d00-0x5=
fff window]
45.823: [    3.808949] pci_bus 0000:00: root bus resource [mem 0x000a0000=
-0x000bffff window]
45.823: [    3.816949] pci_bus 0000:00: root bus resource [mem 0xfc000000=
-0xfcbfffff window]
45.823: [    3.824948] pci_bus 0000:00: root bus resource [mem 0xfcc00000=
-0xfcefffff window]
45.824: [    3.831951] pci_bus 0000:00: root bus resource [bus 00-08]
45.824: [    3.838085] pci 0000:00:02.0: enabling Extended Tags
45.824: [    3.843094] pci 0000:00:04.0: enabling Extended Tags
45.825: [    3.849090] pci 0000:00:09.0: enabling Extended Tags
45.825: [    3.854088] pci 0000:00:0a.0: enabling Extended Tags
45.825: [    3.859037] pci 0000:00:0b.0: enabling Extended Tags
45.826: [    3.864090] pci 0000:00:0c.0: enabling Extended Tags
45.826: [    3.870090] pci 0000:00:0d.0: enabling Extended Tags
45.828: [    3.876311] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io =
 0x01f0-0x01f7]
45.828: [    3.883952] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io =
 0x03f6]
45.828: [    3.890948] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io =
 0x0170-0x0177]
45.828: [    3.897948] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io =
 0x0376]
45.831: [    3.907166] pci 0000:00:02.0: PCI bridge to [bus 01]
45.831: [    3.912985] pci 0000:00:04.0: PCI bridge to [bus 02]
45.832: [    3.918355] pci 0000:00:09.0: PCI bridge to [bus 03]
45.833: [    3.923355] pci 0000:00:0a.0: PCI bridge to [bus 04]
45.833: [    3.928987] pci 0000:00:0b.0: PCI bridge to [bus 05]
45.833: [    3.933984] pci 0000:00:0c.0: PCI bridge to [bus 06]
45.833: [    3.939103] pci 0000:07:00.0: VF(n) BAR0 space: [mem 0x0000000=
0-0x000fffff 64bit] (contains BAR0 for 64 VFs)
45.834: [    3.948961] pci 0000:07:00.0: VF(n) BAR3 space: [mem 0x0000000=
0-0x000fffff 64bit] (contains BAR3 for 64 VFs)
45.834: [    3.959068] pci 0000:07:00.0: 16.000 Gb/s available PCIe bandw=
idth, limited by 5 GT/s x4 link at 0000:00:0d.0 (capable of 32.000 Gb/s w=
ith 5 GT/s x8 link)
45.835: [    3.974123] pci 0000:07:00.1: VF(n) BAR0 space: [mem 0x0000000=
0-0x000fffff 64bit] (contains BAR0 for 64 VFs)
45.835: [    3.983961] pci 0000:07:00.1: VF(n) BAR3 space: [mem 0x0000000=
0-0x000fffff 64bit] (contains BAR3 for 64 VFs)
45.835: [    3.994121] pci 0000:00:0d.0: PCI bridge to [bus 07]
45.835: [    3.998967] pci_bus 0000:08: extended config space not accessi=
ble
45.836: [    4.006395] pci 0000:00:14.4: PCI bridge to [bus 08] (subtract=
ive decode)
45.837: [    4.013809] pci 0000:08:01.0: vgaarb: setting as boot VGA devi=
ce
45.837: [    4.013945] pci 0000:08:01.0: vgaarb: VGA device added: decode=
s=3Dio+mem,owns=3Dio+mem,locks=3Dnone
45.837: [    4.028950] pci 0000:08:01.0: vgaarb: bridge control possible
45.837: [    4.033947] vgaarb: loaded
45.838: [    4.037037] SCSI subsystem initialized
45.838: [    4.041801] ACPI: bus type USB registered
45.840: [    4.045971] usbcore: registered new interface driver usbfs
45.840: [    4.052960] usbcore: registered new interface driver hub
45.840: [    4.058547] usbcore: registered new device driver usb
45.840: [    4.062970] pps_core: LinuxPPS API ver. 1 registered
45.840: [    4.068947] pps_core: Software ver. 5.3.6 - Copyright 2005-200=
7 Rodolfo Giometti <giometti@linux.it>
45.841: [    4.077953] PTP clock support registered
45.841: [    4.082510] EDAC MC: Ver: 3.0.0
45.841: [    4.086019] Advanced Linux Sound Architecture Driver Initializ=
ed.
45.841: [    4.091962] PCI: Using ACPI for IRQ routing
45.843: [    4.097750] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
45.843: [    4.102950] hpet0: 4 comparators, 32-bit 14.318180 MHz counter=

45.846: [    4.111166] clocksource: Switched to clocksource tsc-early
45.867: [    4.138300] VFS: Disk quotas dquot_6.6.0
45.868: [    4.142416] VFS: Dquot-cache hash table entries: 512 (order 0,=
 4096 bytes)
45.868: [    4.149549] FS-Cache: Loaded
45.868: [    4.152682] CacheFiles: Loaded
45.868: [    4.155889] pnp: PnP ACPI init
45.869: [    4.159713] pnp: PnP ACPI: found 4 devices
45.876: [    4.170773] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0=
xffffff, max_idle_ns: 2085701024 ns
45.876: [    4.179995] pci 0000:00:02.0: BAR 14: no space for [mem size 0=
x00200000]
45.877: [    4.186854] pci 0000:00:02.0: BAR 14: failed to assign [mem si=
ze 0x00200000]
45.877: [    4.194071] pci 0000:00:02.0: BAR 15: no space for [mem size 0=
x00200000 64bit pref]
45.877: [    4.201962] pci 0000:00:02.0: BAR 15: failed to assign [mem si=
ze 0x00200000 64bit pref]
45.877: [    4.210205] pci 0000:00:04.0: BAR 14: no space for [mem size 0=
x00200000]
45.877: [    4.217057] pci 0000:00:04.0: BAR 14: failed to assign [mem si=
ze 0x00200000]
45.878: [    4.224264] pci 0000:00:04.0: BAR 15: no space for [mem size 0=
x00200000 64bit pref]
45.878: [    4.232163] pci 0000:00:04.0: BAR 15: failed to assign [mem si=
ze 0x00200000 64bit pref]
45.878: [    4.240406] pci 0000:00:09.0: BAR 15: no space for [mem size 0=
x00200000 64bit pref]
45.878: [    4.248308] pci 0000:00:09.0: BAR 15: failed to assign [mem si=
ze 0x00200000 64bit pref]
45.879: [    4.256555] pci 0000:00:0a.0: BAR 15: no space for [mem size 0=
x00200000 64bit pref]
45.879: [    4.264441] pci 0000:00:0a.0: BAR 15: failed to assign [mem si=
ze 0x00200000 64bit pref]
45.879: [    4.272677] pci 0000:00:0b.0: BAR 14: no space for [mem size 0=
x00200000]
45.879: [    4.279530] pci 0000:00:0b.0: BAR 14: failed to assign [mem si=
ze 0x00200000]
45.880: [    4.286734] pci 0000:00:0b.0: BAR 15: no space for [mem size 0=
x00200000 64bit pref]
45.880: [    4.294625] pci 0000:00:0b.0: BAR 15: failed to assign [mem si=
ze 0x00200000 64bit pref]
45.880: [    4.302867] pci 0000:00:0c.0: BAR 14: no space for [mem size 0=
x00200000]
45.880: [    4.309731] pci 0000:00:0c.0: BAR 14: failed to assign [mem si=
ze 0x00200000]
45.880: [    4.316935] pci 0000:00:0c.0: BAR 15: no space for [mem size 0=
x00200000 64bit pref]
45.881: [    4.324827] pci 0000:00:0c.0: BAR 15: failed to assign [mem si=
ze 0x00200000 64bit pref]
45.881: [    4.333078] pci 0000:00:0d.0: BAR 14: no space for [mem size 0=
x00800000]
45.881: [    4.339931] pci 0000:00:0d.0: BAR 14: failed to assign [mem si=
ze 0x00800000]
45.881: [    4.347135] pci 0000:00:02.0: BAR 13: no space for [io  size 0=
x1000]
45.881: [    4.353642] pci 0000:00:02.0: BAR 13: failed to assign [io  si=
ze 0x1000]
45.882: [    4.360501] pci 0000:00:04.0: BAR 13: no space for [io  size 0=
x1000]
45.882: [    4.367006] pci 0000:00:04.0: BAR 13: failed to assign [io  si=
ze 0x1000]
45.882: [    4.373860] pci 0000:00:0b.0: BAR 13: no space for [io  size 0=
x1000]
45.882: [    4.380376] pci 0000:00:0b.0: BAR 13: failed to assign [io  si=
ze 0x1000]
45.882: [    4.387240] pci 0000:00:0c.0: BAR 13: no space for [io  size 0=
x1000]
45.882: [    4.393748] pci 0000:00:0c.0: BAR 13: failed to assign [io  si=
ze 0x1000]
45.883: [    4.400615] pci 0000:00:0d.0: BAR 14: no space for [mem size 0=
x00800000]
45.883: [    4.407465] pci 0000:00:0d.0: BAR 14: failed to assign [mem si=
ze 0x00800000]
45.883: [    4.414669] pci 0000:00:0c.0: BAR 14: no space for [mem size 0=
x00200000]
45.883: [    4.421521] pci 0000:00:0c.0: BAR 14: failed to assign [mem si=
ze 0x00200000]
45.883: [    4.428725] pci 0000:00:0c.0: BAR 15: no space for [mem size 0=
x00200000 64bit pref]
45.884: [    4.436630] pci 0000:00:0c.0: BAR 15: failed to assign [mem si=
ze 0x00200000 64bit pref]
45.884: [    4.444868] pci 0000:00:0c.0: BAR 13: no space for [io  size 0=
x1000]
45.884: [    4.451376] pci 0000:00:0c.0: BAR 13: failed to assign [io  si=
ze 0x1000]
45.884: [    4.458231] pci 0000:00:0b.0: BAR 14: no space for [mem size 0=
x00200000]
45.884: [    4.465094] pci 0000:00:0b.0: BAR 14: failed to assign [mem si=
ze 0x00200000]
45.885: [    4.472299] pci 0000:00:0b.0: BAR 15: no space for [mem size 0=
x00200000 64bit pref]
45.885: [    4.480199] pci 0000:00:0b.0: BAR 15: failed to assign [mem si=
ze 0x00200000 64bit pref]
45.885: [    4.488454] pci 0000:00:0b.0: BAR 13: no space for [io  size 0=
x1000]
45.885: [    4.494958] pci 0000:00:0b.0: BAR 13: failed to assign [io  si=
ze 0x1000]
45.886: [    4.501819] pci 0000:00:0a.0: BAR 15: no space for [mem size 0=
x00200000 64bit pref]
45.886: [    4.509715] pci 0000:00:0a.0: BAR 15: failed to assign [mem si=
ze 0x00200000 64bit pref]
45.886: [    4.517959] pci 0000:00:09.0: BAR 15: no space for [mem size 0=
x00200000 64bit pref]
45.886: [    4.525850] pci 0000:00:09.0: BAR 15: failed to assign [mem si=
ze 0x00200000 64bit pref]
45.886: [    4.534094] pci 0000:00:04.0: BAR 14: no space for [mem size 0=
x00200000]
45.887: [    4.540948] pci 0000:00:04.0: BAR 14: failed to assign [mem si=
ze 0x00200000]
45.887: [    4.548151] pci 0000:00:04.0: BAR 15: no space for [mem size 0=
x00200000 64bit pref]
45.887: [    4.556051] pci 0000:00:04.0: BAR 15: failed to assign [mem si=
ze 0x00200000 64bit pref]
45.887: [    4.564295] pci 0000:00:04.0: BAR 13: no space for [io  size 0=
x1000]
45.887: [    4.570810] pci 0000:00:04.0: BAR 13: failed to assign [io  si=
ze 0x1000]
45.888: [    4.577675] pci 0000:00:02.0: BAR 14: no space for [mem size 0=
x00200000]
45.888: [    4.584537] pci 0000:00:02.0: BAR 14: failed to assign [mem si=
ze 0x00200000]
45.888: [    4.591743] pci 0000:00:02.0: BAR 15: no space for [mem size 0=
x00200000 64bit pref]
45.888: [    4.599641] pci 0000:00:02.0: BAR 15: failed to assign [mem si=
ze 0x00200000 64bit pref]
45.889: [    4.607889] pci 0000:00:02.0: BAR 13: no space for [io  size 0=
x1000]
45.889: [    4.614400] pci 0000:00:02.0: BAR 13: failed to assign [io  si=
ze 0x1000]
45.889: [    4.621259] pci 0000:00:02.0: PCI bridge to [bus 01]
45.889: [    4.626381] pci 0000:00:04.0: PCI bridge to [bus 02]
45.889: [    4.631493] pci 0000:00:09.0: PCI bridge to [bus 03]
45.889: [    4.636603] pci 0000:00:09.0:   bridge window [io  0x1000-0x1f=
ff]
45.890: [    4.642851] pci 0000:00:09.0:   bridge window [mem 0xfc900000-=
0xfc9fffff]
45.890: [    4.649795] pci 0000:00:0a.0: PCI bridge to [bus 04]
45.890: [    4.654914] pci 0000:00:0a.0:   bridge window [io  0x2000-0x2f=
ff]
45.890: [    4.661163] pci 0000:00:0a.0:   bridge window [mem 0xfca00000-=
0xfcafffff]
45.890: [    4.668114] pci 0000:00:0b.0: PCI bridge to [bus 05]
45.890: [    4.673229] pci 0000:00:0c.0: PCI bridge to [bus 06]
45.891: [    4.678351] pci 0000:07:00.0: BAR 7: no space for [mem size 0x=
00100000 64bit]
45.891: [    4.685643] pci 0000:07:00.0: BAR 7: failed to assign [mem siz=
e 0x00100000 64bit]
45.891: [    4.693365] pci 0000:07:00.0: BAR 10: no space for [mem size 0=
x00100000 64bit]
45.891: [    4.700817] pci 0000:07:00.0: BAR 10: failed to assign [mem si=
ze 0x00100000 64bit]
45.892: [    4.708625] pci 0000:07:00.1: BAR 7: no space for [mem size 0x=
00100000 64bit]
45.892: [    4.715921] pci 0000:07:00.1: BAR 7: failed to assign [mem siz=
e 0x00100000 64bit]
45.892: [    4.723636] pci 0000:07:00.1: BAR 10: no space for [mem size 0=
x00100000 64bit]
45.892: [    4.731095] pci 0000:07:00.1: BAR 10: failed to assign [mem si=
ze 0x00100000 64bit]
45.893: [    4.738907] pci 0000:07:00.1: BAR 10: no space for [mem size 0=
x00100000 64bit]
45.893: [    4.746358] pci 0000:07:00.1: BAR 10: failed to assign [mem si=
ze 0x00100000 64bit]
45.893: [    4.754167] pci 0000:07:00.1: BAR 7: no space for [mem size 0x=
00100000 64bit]
45.893: [    4.761461] pci 0000:07:00.1: BAR 7: failed to assign [mem siz=
e 0x00100000 64bit]
45.893: [    4.769173] pci 0000:07:00.0: BAR 10: no space for [mem size 0=
x00100000 64bit]
45.894: [    4.776634] pci 0000:07:00.0: BAR 10: failed to assign [mem si=
ze 0x00100000 64bit]
45.894: [    4.784444] pci 0000:07:00.0: BAR 7: no space for [mem size 0x=
00100000 64bit]
45.894: [    4.791732] pci 0000:07:00.0: BAR 7: failed to assign [mem siz=
e 0x00100000 64bit]
45.894: [    4.799454] pci 0000:00:0d.0: PCI bridge to [bus 07]
45.894: [    4.804565] pci 0000:00:0d.0:   bridge window [io  0x3000-0x3f=
ff]
45.895: [    4.810808] pci 0000:00:0d.0:   bridge window [mem 0xfcc00000-=
0xfcdfffff 64bit pref]
45.895: [    4.818790] pci 0000:00:14.4: PCI bridge to [bus 08]
45.895: [    4.823901] pci 0000:00:14.4:   bridge window [io  0x4000-0x4f=
ff]
45.895: [    4.830150] pci 0000:00:14.4:   bridge window [mem 0xfc000000-=
0xfc8fffff]
45.896: [    4.837315] NET: Registered protocol family 2
45.896: [    4.842215] tcp_listen_portaddr_hash hash table entries: 65536=
 (order: 8, 1048576 bytes)
45.897: [    4.851085] TCP established hash table entries: 524288 (order:=
 10, 4194304 bytes)
45.899: [    4.860484] TCP bind hash table entries: 65536 (order: 8, 1048=
576 bytes)
45.899: [    4.867671] TCP: Hash tables configured (established 524288 bi=
nd 65536)
45.900: [    4.874641] UDP hash table entries: 65536 (order: 9, 2097152 b=
ytes)
45.901: [    4.881861] UDP-Lite hash table entries: 65536 (order: 9, 2097=
152 bytes)
45.903: [    4.890787] pci 0000:08:01.0: Video device with shadowed ROM a=
t [mem 0x000c0000-0x000dffff]
45.903: [    4.899453] Trying to unpack rootfs image as initramfs...
46.006: [    5.007896] Freeing initrd memory: 5136K
46.048: [    5.053357] iommu: Adding device 0000:00:11.0 to group 0
46.049: [    5.059343] iommu: Adding device 0000:00:12.0 to group 1
46.049: [    5.064830] iommu: Adding device 0000:00:12.1 to group 1
46.049: [    5.070315] iommu: Adding device 0000:00:12.2 to group 1
46.050: [    5.076305] iommu: Adding device 0000:00:13.0 to group 2
46.050: [    5.081793] iommu: Adding device 0000:00:13.1 to group 2
46.050: [    5.087277] iommu: Adding device 0000:00:13.2 to group 2
46.051: [    5.093197] iommu: Adding device 0000:00:14.0 to group 3
46.051: [    5.099135] iommu: Adding device 0000:00:14.1 to group 4
46.052: [    5.105096] iommu: Adding device 0000:00:14.2 to group 5
46.053: [    5.111024] iommu: Adding device 0000:00:14.3 to group 6
46.053: [    5.116990] iommu: Adding device 0000:00:14.4 to group 7
46.054: [    5.122913] iommu: Adding device 0000:00:14.5 to group 8
46.055: [    5.128887] iommu: Adding device 0000:03:00.0 to group 9
46.055: [    5.134808] iommu: Adding device 0000:04:00.0 to group 10
46.056: [    5.140864] iommu: Adding device 0000:07:00.0 to group 11
46.057: [    5.146876] iommu: Adding device 0000:07:00.1 to group 12
46.058: [    5.152444] iommu: Adding device 0000:08:01.0 to group 7
46.058: [    5.159269] iommu: Adding device 0000:08:02.0 to group 7
46.099: [    5.204738] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
46.099: [    5.210343] AMD-Vi: Lazy IO/TLB flushing enabled
46.101: [    5.217274] amd_uncore: AMD NB counters detected
46.102: [    5.222898] LVT offset 0 assigned for vector 0x400
46.103: [    5.228281] perf: AMD IBS detected (0x000000ff)
46.104: [    5.234153] workingset: timestamp_bits=3D40 max_order=3D25 buc=
ket_order=3D0
46.105: [    5.241388] SGI XFS with ACLs, security attributes, realtime, =
no debug enabled
46.108: [    5.251268] Block layer SCSI generic (bsg) driver version 0.4 =
loaded (major 250)
46.108: [    5.259015] io scheduler noop registered
46.108: [    5.263083] io scheduler deadline registered
46.108: [    5.267546] io scheduler cfq registered (default)
46.109: [    5.272407] io scheduler mq-deadline registered
46.109: [    5.277087] io scheduler kyber registered
46.110: [    5.281927] pcieport 0000:00:02.0: Signaling PME with IRQ 27
46.110: [    5.287886] pcieport 0000:00:04.0: can't derive routing for PC=
I INT A
46.110: [    5.294485] pcieport 0000:00:04.0: PCI INT A: no GSI
46.110: [    5.299653] pcieport 0000:00:04.0: Signaling PME with IRQ 28
46.111: [    5.305628] pcieport 0000:00:09.0: Signaling PME with IRQ 30
46.111: [    5.311602] pcieport 0000:00:0a.0: Signaling PME with IRQ 32
46.111: [    5.317583] pcieport 0000:00:0b.0: Signaling PME with IRQ 33
46.112: [    5.323556] pcieport 0000:00:0c.0: Signaling PME with IRQ 34
46.112: [    5.329525] pcieport 0000:00:0d.0: Signaling PME with IRQ 35
46.112: [    5.335470] IPMI message handler: version 39.2
46.112: [    5.340073] ipmi device interface
46.113: [    5.343554] ipmi_si: IPMI System Interface driver
46.113: [    5.348473] ipmi_si: Unable to find any System Interface(s)
46.113: [    5.354212] IPMI Watchdog: driver initialized
46.113: [    5.358718] IPMI poweroff: Copyright (C) 2004 MontaVista Softw=
are - IPMI Powerdown via sys_reboot
46.114: [    5.367937] input: Power Button as /devices/LNXSYSTM:00/LNXSYB=
US:00/PNP0C0C:00/input/input0
46.114: [    5.376649] ACPI: Power Button [PWRB]
46.114: [    5.380564] input: Power Button as /devices/LNXSYSTM:00/LNXPWR=
BN:00/input/input1
46.115: [    5.388314] ACPI: Power Button [PWRF]
46.118: [    5.395013] Serial: 8250/16550 driver, 4 ports, IRQ sharing di=
sabled
46.139: [    5.422223] 00:02: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D=
 115200) is a 16550A
46.160: [    5.450562] 00:03: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D=
 115200) is a 16550A
46.161: [    5.459178] lp: driver loaded but no devices found
46.161: [    5.464492] Linux agpgart interface v0.103
46.171: [    5.478186] brd: module loaded
46.177: [    5.486945] loop: module loaded
46.191: [    5.504683] drbd: initialized. Version: 8.4.10 (api:1/proto:86=
-101)
46.192: [    5.511216] drbd: built-in
46.192: [    5.514111] drbd: registered as block device major 147
46.192: [    5.519549] Uniform Multi-Platform E-IDE driver
46.193: [    5.524645] ide_generic: please use "probe_mask=3D0x3f" module=
 parameter for probing all legacy ISA IDE ports
46.193: [    5.534733] ide-gd driver 1.18
46.193: [    5.537962] ide-cd driver 5.00
46.194: [    5.541570] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 0=
0:01:03 EST 2006)
46.194: [    5.549305] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32=
:35 EST 2006)
46.195: [    5.556548] megasas: 07.706.03.00-rc1
46.195: [    5.560433] mpt3sas version 26.100.00.00 loaded
46.196: [    5.565948] ahci 0000:00:11.0: AHCI 0001.0100 32 slots 6 ports=
 3 Gbps 0x3f impl SATA mode
46.196: [    5.574422] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck led =
clo pmp pio slum part ccc=20
46.198: [    5.583860] scsi host0: ahci
46.198: [    5.587257] scsi host1: ahci
46.199: [    5.590573] scsi host2: ahci
46.199: [    5.593927] scsi host3: ahci
46.200: [    5.597289] scsi host4: ahci
46.200: [    5.600613] scsi host5: ahci
46.200: [    5.603806] ata1: SATA max UDMA/133 abar m1024@0xfcb0d000 port=
 0xfcb0d100 irq 22
46.201: [    5.611480] ata2: SATA max UDMA/133 abar m1024@0xfcb0d000 port=
 0xfcb0d180 irq 22
46.201: [    5.619193] ata3: SATA max UDMA/133 abar m1024@0xfcb0d000 port=
 0xfcb0d200 irq 22
46.201: [    5.626853] ata4: SATA max UDMA/133 abar m1024@0xfcb0d000 port=
 0xfcb0d280 irq 22
46.202: [    5.634542] ata5: SATA max UDMA/133 abar m1024@0xfcb0d000 port=
 0xfcb0d300 irq 22
46.202: [    5.642234] ata6: SATA max UDMA/133 abar m1024@0xfcb0d000 port=
 0xfcb0d380 irq 22
46.204: [    5.651332] scsi host6: pata_atiixp
46.204: [    5.655268] scsi host7: pata_atiixp
46.204: [    5.658992] ata7: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma =
0x5010 irq 14
46.205: [    5.666173] ata8: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma =
0x5018 irq 15
46.205: [    5.673722] tun: Universal TUN/TAP device driver, 1.6
46.206: [    5.679202] bnx2x: QLogic 5771x/578xx 10/20-Gigabit Ethernet D=
river bnx2x 1.712.30-0 (2014/02/10)
46.206: [    5.688766] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-N=
API
46.207: [    5.695097] e100: Copyright(c) 1999-2006 Intel Corporation
46.207: [    5.700831] e1000: Intel(R) PRO/1000 Network Driver - version =
7.3.21-k8-NAPI
46.207: [    5.708097] e1000: Copyright (c) 1999-2006 Intel Corporation.
46.207: [    5.714101] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k=

46.208: [    5.720157] e1000e: Copyright(c) 1999 - 2015 Intel Corporation=
=2E
46.208: [    5.726461] e1000e 0000:03:00.0: Interrupt Throttling Rate (in=
ts/sec) set to dynamic conservative mode
46.256: [    5.784021] e1000e 0000:03:00.0 0000:03:00.0 (uninitialized): =
registered PHC clock
46.302: [    5.836900] e1000e 0000:03:00.0 eth0: (PCI Express:2.5GT/s:Wid=
th x1) 20:cf:30:4e:1d:5c
46.302: [    5.845103] e1000e 0000:03:00.0 eth0: Intel(R) PRO/1000 Networ=
k Connection
46.302: [    5.852273] e1000e 0000:03:00.0 eth0: MAC: 3, PHY: 8, PBA No: =
FFFFFF-0FF
46.303: [    5.859344] e1000e 0000:04:00.0: Interrupt Throttling Rate (in=
ts/sec) set to dynamic conservative mode
46.351: [    5.916951] e1000e 0000:04:00.0 0000:04:00.0 (uninitialized): =
registered PHC clock
46.396: [    5.969809] e1000e 0000:04:00.0 eth1: (PCI Express:2.5GT/s:Wid=
th x1) 20:cf:30:4e:1d:3e
46.396: [    5.978008] e1000e 0000:04:00.0 eth1: Intel(R) PRO/1000 Networ=
k Connection
46.397: [    5.985149] e1000e 0000:04:00.0 eth1: MAC: 3, PHY: 8, PBA No: =
FFFFFF-0FF
46.397: [    5.992155] igb: Intel(R) Gigabit Ethernet Network Driver - ve=
rsion 5.4.0-k
46.397: [    5.999333] igb: Copyright (c) 2007-2014 Intel Corporation.
46.398: [    6.005152] igbvf: Intel(R) Gigabit Virtual Function Network D=
river - version 2.4.0-k
46.398: [    6.013370] igbvf: Copyright (c) 2009 - 2012 Intel Corporation=
=2E
46.398: [    6.019543] sky2: driver version 1.30
46.399: [    6.023676] Fusion MPT base driver 3.04.20
46.399: [    6.027945] Copyright (c) 1999-2008 LSI Corporation
46.399: [    6.033082] Fusion MPT SPI Host driver 3.04.20
46.400: [    6.037744] Fusion MPT FC Host driver 3.04.20
46.400: [    6.042356] Fusion MPT SAS Host driver 3.04.20
46.400: [    6.047073] Fusion MPT misc device (ioctl) driver 3.04.20
46.400: [    6.047970] ata2: SATA link down (SStatus 0 SControl 300)
46.401: [    6.052788] mptctl: Registered with Fusion MPT base driver
46.401: [    6.058379] ata6: SATA link down (SStatus 0 SControl 300)
46.401: [    6.064015] mptctl: /dev/mptctl @ (major,minor=3D10,220)
46.401: [    6.064044] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI=
) Driver
46.401: [    6.069666] ata3: SATA link down (SStatus 0 SControl 300)
46.402: [    6.074934] ehci-pci: EHCI PCI platform driver
46.402: [    6.075145] ehci-pci 0000:00:12.2: EHCI Host Controller
46.402: [    6.081770] ata5: SATA link down (SStatus 0 SControl 300)
46.402: [    6.087317] ehci-pci 0000:00:12.2: new USB bus registered, ass=
igned bus number 1
46.403: [    6.110693] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hu=
dson-2/3 EHCI dummy qh workaround
46.403: [    6.119701] ehci-pci 0000:00:12.2: debug port 1
46.403: [    6.124430] ehci-pci 0000:00:12.2: irq 17, io mem 0xfcb0e000
46.410: [    6.137023] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
46.411: [    6.143205] hub 1-0:1.0: USB hub found
46.411: [    6.147121] hub 1-0:1.0: 6 ports detected
46.411: [    6.151581] ehci-pci 0000:00:13.2: EHCI Host Controller
46.411: [    6.156989] ehci-pci 0000:00:13.2: new USB bus registered, ass=
igned bus number 2
46.412: [    6.164690] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hu=
dson-2/3 EHCI dummy qh workaround
46.412: [    6.173690] ehci-pci 0000:00:13.2: debug port 1
46.412: [    6.178430] ehci-pci 0000:00:13.2: irq 19, io mem 0xfcb0f000
46.419: [    6.190981] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
46.420: [    6.197149] hub 2-0:1.0: USB hub found
46.420: [    6.201074] hub 2-0:1.0: 6 ports detected
46.420: [    6.205441] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Dr=
iver
46.420: [    6.211834] ohci-pci: OHCI PCI platform driver
46.421: [    6.216568] ohci-pci 0000:00:12.0: OHCI PCI host controller
46.421: [    6.222329] ohci-pci 0000:00:12.0: new USB bus registered, ass=
igned bus number 3
46.421: [    6.230055] ohci-pci 0000:00:12.0: irq 16, io mem 0xfcb08000
46.477: [    6.291142] hub 3-0:1.0: USB hub found
46.477: [    6.295058] hub 3-0:1.0: 3 ports detected
46.477: [    6.299439] ohci-pci 0000:00:12.1: OHCI PCI host controller
46.478: [    6.305195] ohci-pci 0000:00:12.1: new USB bus registered, ass=
igned bus number 4
46.478: [    6.312861] ohci-pci 0000:00:12.1: irq 16, io mem 0xfcb09000
46.522: [    6.362277] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl =
300)
46.522: [    6.368701] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl =
300)
46.522: [    6.374144] hub 4-0:1.0: USB hub found
46.522: [    6.375376] ata4.00: ATA-8: HGST HDN724030ALE640, MJ8OA5E0, ma=
x UDMA/133
46.522: [    6.379044] hub 4-0:1.0: 3 ports detected
46.523: [    6.385889] ata4.00: 5860533168 sectors, multi 0: LBA48 NCQ (d=
epth 32), AA
46.523: [    6.386246] ata1.00: ATA-7: Hitachi HUA721010KLA330, GKAOA70M,=
 max UDMA/133
46.523: [    6.390435] ohci-pci 0000:00:13.0: OHCI PCI host controller
46.523: [    6.397258] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (d=
epth 32), AA
46.524: [    6.397536] ata4.00: configured for UDMA/133
46.524: [    6.404412] ohci-pci 0000:00:13.0: new USB bus registered, ass=
igned bus number 5
46.524: [    6.410534] ata1.00: configured for UDMA/133
46.524: [    6.417289] ohci-pci 0000:00:13.0: irq 18, io mem 0xfcb0a000
46.580: [    6.495095] hub 5-0:1.0: USB hub found
46.580: [    6.499021] hub 5-0:1.0: 3 ports detected
46.582: [    6.503445] ohci-pci 0000:00:13.1: OHCI PCI host controller
46.582: [    6.510598] ohci-pci 0000:00:13.1: new USB bus registered, ass=
igned bus number 6
46.582: [    6.518289] ohci-pci 0000:00:13.1: irq 18, io mem 0xfcb0b000
46.639: [    6.580057] hub 6-0:1.0: USB hub found
46.639: [    6.583982] hub 6-0:1.0: 3 ports detected
46.639: [    6.588367] ohci-pci 0000:00:14.5: OHCI PCI host controller
46.639: [    6.594117] ohci-pci 0000:00:14.5: new USB bus registered, ass=
igned bus number 7
46.640: [    6.601780] ohci-pci 0000:00:14.5: irq 18, io mem 0xfcb0c000
46.695: [    6.663061] hub 7-0:1.0: USB hub found
46.696: [    6.666994] hub 7-0:1.0: 2 ports detected
46.696: [    6.671312] uhci_hcd: USB Universal Host Controller Interface =
driver
46.696: [    6.678015] usbcore: registered new interface driver usb-stora=
ge
46.696: [    6.684278] usbcore: registered new interface driver ftdi_sio
46.697: [    6.690243] usbserial: USB Serial support registered for FTDI =
USB Serial Device
46.697: [    6.697939] usbcore: registered new interface driver omninet
46.697: [    6.703810] usbserial: USB Serial support registered for ZyXEL=
 - omni.net lcd plus usb
46.698: [    6.712143] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60=
,0x64 irq 1
46.698: [    6.719170] i8042: PNP: PS/2 appears to have AUX port disabled=
, if this is incorrect please boot with i8042.nopnp
46.698: [    6.723481] tsc: Refined TSC clocksource calibration: 2400.027=
 MHz
46.699: [    6.730510] serio: i8042 KBD port at 0x60,0x64 irq 1
46.699: [    6.736280] clocksource: tsc: mask: 0xffffffffffffffff max_cyc=
les: 0x229850e3768, max_idle_ns: 440795212339 ns
46.699: [    6.741780] rtc_cmos 00:00: RTC can wake from S4
46.700: [    6.756653] clocksource: Switched to clocksource tsc
46.700: [    6.757124] rtc_cmos 00:00: registered as rtc0
46.700: [    6.758079] floppy0: no floppy controllers found
46.700: [    6.758656] scsi 0:0:0:0: Direct-Access     ATA      Hitachi H=
UA72101 A70M PQ: 0 ANSI: 5
46.701: [    6.758900] sd 0:0:0:0: Attached scsi generic sg0 type 0
46.701: [    6.759111] sd 0:0:0:0: [sda] 1953525168 512-byte logical bloc=
ks: (1.00 TB/932 GiB)
46.702: [    6.759159] sd 0:0:0:0: [sda] Write Protect is off
46.702: [    6.759205] sd 0:0:0:0: [sda] Write cache: enabled, read cache=
: enabled, doesn't support DPO or FUA
46.702: [    6.759418] scsi 3:0:0:0: Direct-Access     ATA      HGST HDN7=
24030AL A5E0 PQ: 0 ANSI: 5
46.703: [    6.759768] sd 3:0:0:0: Attached scsi generic sg1 type 0
46.703: [    6.759804] sd 3:0:0:0: [sdb] 5860533168 512-byte logical bloc=
ks: (3.00 TB/2.73 TiB)
46.703: [    6.759807] sd 3:0:0:0: [sdb] 4096-byte physical blocks
46.704: [    6.759833] sd 3:0:0:0: [sdb] Write Protect is off
46.704: [    6.759901] sd 3:0:0:0: [sdb] Write cache: enabled, read cache=
: enabled, doesn't support DPO or FUA
46.704: [    6.770323]  sda: sda1 sda2
46.705: [    6.771430] rtc_cmos 00:00: alarms up to one day, 114 bytes nv=
ram, hpet irqs
46.705: [    6.780800] sd 0:0:0:0: [sda] Attached SCSI disk
46.705: [    6.786124] piix4_smbus 0000:00:14.0: SMBus Host Controller at=
 0xb00, revision 0
46.705: [    6.819606]  sdb:
46.706: [    6.822132] usb 3-1: new low-speed USB device number 2 using o=
hci-pci
46.706: [    6.830831] sd 3:0:0:0: [sdb] Attached SCSI disk
46.706: [    6.835763] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Con=
troller at 0xb20
46.707: [    6.894844] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
46.707: [    6.900696] iTCO_vendor_support: vendor-support=3D0
46.708: [    6.905670] nv_tco: NV TCO WatchDog Timer Driver v0.01
46.708: [    6.911698] EDAC amd64: Node 0: DRAM ECC enabled.
46.709: [    6.916673] EDAC amd64: F15h detected (node 0).
46.709: [    6.921468] EDAC amd64: MC: 0:     0MB 1:     0MB
46.709: [    6.926396] EDAC amd64: MC: 2:  8192MB 3:  8192MB
46.709: [    6.931336] EDAC amd64: MC: 4:     0MB 5:     0MB
46.710: [    6.936285] EDAC amd64: MC: 6:     0MB 7:     0MB
46.710: [    6.941234] EDAC amd64: MC: 0:     0MB 1:     0MB
46.710: [    6.946160] EDAC amd64: MC: 2:  8192MB 3:  8192MB
46.711: [    6.951117] EDAC amd64: MC: 4:     0MB 5:     0MB
46.711: [    6.956064] EDAC amd64: MC: 6:     0MB 7:     0MB
46.711: [    6.960978] EDAC amd64: using x4 syndromes.
46.711: [    6.965421] EDAC amd64: MCT channel count: 2
46.712: [    6.970116] EDAC MC0: Giving out device to module amd64_edac c=
ontroller F15h: DEV 0000:00:18.3 (INTERRUPT)
46.712: [    6.980246] EDAC amd64: Node 1: DRAM ECC enabled.
46.712: [    6.985161] EDAC amd64: F15h detected (node 1).
46.713: [    6.990021] EDAC amd64: MC: 0:     0MB 1:     0MB
46.713: [    6.994979] EDAC amd64: MC: 2:  8192MB 3:  8192MB
46.713: [    6.999974] EDAC amd64: MC: 4:     0MB 5:     0MB
46.714: [    7.004916] EDAC amd64: MC: 6:     0MB 7:     0MB
46.714: [    7.009854] EDAC amd64: MC: 0:     0MB 1:     0MB
46.714: [    7.014771] EDAC amd64: MC: 2:  8192MB 3:  8192MB
46.714: [    7.019711] EDAC amd64: MC: 4:     0MB 5:     0MB
46.715: [    7.024641] EDAC amd64: MC: 6:     0MB 7:     0MB
46.715: [    7.029614] EDAC amd64: using x4 syndromes.
46.715: [    7.034065] EDAC amd64: MCT channel count: 2
46.716: [    7.038754] EDAC MC1: Giving out device to module amd64_edac c=
ontroller F15h: DEV 0000:00:19.3 (INTERRUPT)
46.716: [    7.048940] EDAC amd64: Node 2: DRAM ECC enabled.
46.717: [    7.053933] EDAC amd64: F15h detected (node 2).
46.717: [    7.058733] EDAC amd64: MC: 0:     0MB 1:     0MB
46.717: [    7.063641] EDAC amd64: MC: 2:  8192MB 3:  8192MB
46.717: [    7.068589] EDAC amd64: MC: 4:     0MB 5:     0MB
46.717: [    7.073540] EDAC amd64: MC: 6:     0MB 7:     0MB
46.718: [    7.078504] EDAC amd64: MC: 0:     0MB 1:     0MB
46.718: [    7.083427] EDAC amd64: MC: 2:  8192MB 3:  8192MB
46.718: [    7.088402] EDAC amd64: MC: 4:     0MB 5:     0MB
46.718: [    7.093333] EDAC amd64: MC: 6:     0MB 7:     0MB
46.719: [    7.098281] EDAC amd64: using x4 syndromes.
46.719: [    7.102682] EDAC amd64: MCT channel count: 2
46.720: [    7.107359] EDAC MC2: Giving out device to module amd64_edac c=
ontroller F15h: DEV 0000:00:1a.3 (INTERRUPT)
46.720: [    7.117474] EDAC amd64: Node 3: DRAM ECC enabled.
46.720: [    7.122427] EDAC amd64: F15h detected (node 3).
46.720: [    7.127229] EDAC amd64: MC: 0:     0MB 1:     0MB
46.721: [    7.132134] EDAC amd64: MC: 2:  8192MB 3:  8192MB
46.721: [    7.137126] EDAC amd64: MC: 4:     0MB 5:     0MB
46.721: [    7.142104] EDAC amd64: MC: 6:     0MB 7:     0MB
46.722: [    7.147080] EDAC amd64: MC: 0:     0MB 1:     0MB
46.722: [    7.151996] EDAC amd64: MC: 2:  8192MB 3:  8192MB
46.722: [    7.156988] EDAC amd64: MC: 4:     0MB 5:     0MB
46.722: [    7.161929] EDAC amd64: MC: 6:     0MB 7:     0MB
46.723: [    7.166886] EDAC amd64: using x4 syndromes.
46.723: [    7.171315] EDAC amd64: MCT channel count: 2
46.723: [    7.175914] EDAC MC3: Giving out device to module amd64_edac c=
ontroller F15h: DEV 0000:00:1b.3 (INTERRUPT)
46.724: [    7.186029] EDAC PCI0: Giving out device to module amd64_edac =
controller EDAC PCI controller: DEV 0000:00:18.2 (POLLED)
46.724: [    7.197204] AMD64 EDAC driver v3.5.0
46.724: [    7.200997] hidraw: raw HID events driver (C) Jiri Kosina
46.730: [    7.211650] input: Logitech USB Keyboard as /devices/pci0000:0=
0/0000:00:12.0/usb3/3-1/3-1:1.0/0003:046D:C31C.0001/input/input4
46.783: [    7.276305] hid-generic 0003:046D:C31C.0001: input,hidraw0: US=
B HID v1.10 Keyboard [Logitech USB Keyboard] on usb-0000:00:12.0-1/input0=

46.790: [    7.295696] input: Logitech USB Keyboard Consumer Control as /=
devices/pci0000:00/0000:00:12.0/usb3/3-1/3-1:1.1/0003:046D:C31C.0002/inpu=
t/input5
46.843: [    7.361293] input: Logitech USB Keyboard System Control as /de=
vices/pci0000:00/0000:00:12.0/usb3/3-1/3-1:1.1/0003:046D:C31C.0002/input/=
input6
46.844: [    7.374692] hid-generic 0003:046D:C31C.0002: input,hidraw1: US=
B HID v1.10 Device [Logitech USB Keyboard] on usb-0000:00:12.0-1/input1
46.844: [    7.387238] usbcore: registered new interface driver usbhid
46.844: [    7.393066] usbhid: USB HID core driver
46.846: [    7.398172] Key type dns_resolver registered
46.846: [    7.401385] snd_hda_intel 0000:00:14.2: no codecs found!
46.849: [    7.411388] microcode: CPU0: patch_level=3D0x0600063e
46.850: [    7.416460] microcode: CPU1: patch_level=3D0x0600063e
46.850: [    7.421675] microcode: CPU2: patch_level=3D0x0600063e
46.850: [    7.426781] microcode: CPU3: patch_level=3D0x0600063e
46.851: [    7.431939] microcode: CPU4: patch_level=3D0x0600063e
46.851: [    7.437133] microcode: CPU5: patch_level=3D0x0600063e
46.851: [    7.442276] microcode: CPU6: patch_level=3D0x0600063e
46.851: [    7.447364] microcode: CPU7: patch_level=3D0x0600063e
46.852: [    7.452464] microcode: CPU8: patch_level=3D0x0600063e
46.852: [    7.457643] microcode: CPU9: patch_level=3D0x0600063e
46.852: [    7.462877] microcode: CPU10: patch_level=3D0x0600063e
46.853: [    7.468146] microcode: CPU11: patch_level=3D0x0600063e
46.853: [    7.473368] microcode: CPU12: patch_level=3D0x0600063e
46.853: [    7.478613] microcode: CPU13: patch_level=3D0x0600063e
46.854: [    7.483907] microcode: CPU14: patch_level=3D0x0600063e
46.854: [    7.489190] microcode: CPU15: patch_level=3D0x0600063e
46.854: [    7.494419] microcode: CPU16: patch_level=3D0x0600063e
46.854: [    7.499670] microcode: CPU17: patch_level=3D0x0600063e
46.855: [    7.504978] microcode: CPU18: patch_level=3D0x0600063e
46.855: [    7.510229] microcode: CPU19: patch_level=3D0x0600063e
46.855: [    7.515432] microcode: CPU20: patch_level=3D0x0600063e
46.856: [    7.520685] microcode: CPU21: patch_level=3D0x0600063e
46.856: [    7.525868] microcode: CPU22: patch_level=3D0x0600063e
46.856: [    7.531158] microcode: CPU23: patch_level=3D0x0600063e
46.856: [    7.536351] microcode: CPU24: patch_level=3D0x0600063e
46.857: [    7.541590] microcode: CPU25: patch_level=3D0x0600063e
46.857: [    7.546940] microcode: CPU26: patch_level=3D0x0600063e
46.858: [    7.552226] microcode: CPU27: patch_level=3D0x0600063e
46.858: [    7.557415] microcode: CPU28: patch_level=3D0x0600063e
46.858: [    7.562640] microcode: CPU29: patch_level=3D0x0600063e
46.858: [    7.567977] microcode: CPU30: patch_level=3D0x0600063e
46.859: [    7.573240] microcode: CPU31: patch_level=3D0x0600063e
46.859: [    7.578507] microcode: Microcode Update Driver: v2.2.
46.860: [    7.578539] sched_clock: Marking stable (6510054745, 106844465=
9)->(7999876773, -421377369)
46.860: [    7.593013] registered taskstats version 1
46.861: [    7.598091] rtc_cmos 00:00: setting system clock to 2000-01-01=
 08:01:51 UTC (946713711)
46.862: [    7.606575] ALSA device list:
46.862: [    7.609802]   No soundcards found.
46.865: [    7.615887] Freeing unused kernel image memory: 1564K
46.871: [    7.627073] Write protecting the kernel read-only data: 20480k=

46.872: [    7.634366] Freeing unused kernel image memory: 2016K
46.873: [    7.640297] Freeing unused kernel image memory: 584K
46.874: [    7.645521] Run /init as init process
46.877: [    7.652262] general protection fault: 0000 [#1] SMP NOPTI
46.877: [    7.657931] CPU: 18 PID: 0 Comm: swapper/18 Not tainted 4.20.0=
-rc7.mx64.237 #1
46.877: [    7.665514] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-10=
3-g637bef2037 01/02/2019
46.878: [    7.673804] RIP: 0010:switch_mm_irqs_off+0xb2/0x640
46.878: [    7.678948] Code: 48 c1 ef 09 83 e7 01 48 09 c7 65 48 8b 05 8e=
 34 fc 7e 48 39 c7 74 15 48 09 f8 a8 01 74 0e b9 49 00 00 00 b8 01 00 00 =
00 31 d2 <0f> 30 65 48 89 3d 6c 34 fc 7e 8b 05 9a ef a7 01 85 c0 0f 8f 41=
 04
46.879: [    7.698394] RSP: 0018:ffffc90006343e20 EFLAGS: 00010046
46.879: [    7.703844] RAX: 0000000000000001 RBX: ffff88981ca0b800 RCX: 0=
000000000000049
46.879: [    7.711238] RDX: 0000000000000000 RSI: ffff88981b87cf80 RDI: f=
fff88981ca0b800
46.880: [    7.718665] RBP: ffffc90006343e70 R08: 00000001c81bec00 R09: 0=
000000000000000
46.880: [    7.726092] R10: ffffc90006343e88 R11: 0000000000000000 R12: f=
fffffff82479b40
46.880: [    7.733494] R13: 0000000000000000 R14: 0000000000000012 R15: f=
fff88981dd50080
46.881: [    7.740853] FS:  0000000000000000(0000) GS:ffff88981fa80000(00=
00) knlGS:0000000000000000
46.881: [    7.749318] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
46.881: [    7.755281] CR2: 0000000000000000 CR3: 000000000240a000 CR4: 0=
0000000000406e0
46.881: [    7.762761] Call Trace:
46.881: [    7.765369]  ? __schedule+0x1b9/0x7b0
46.882: [    7.769253]  __schedule+0x1b9/0x7b0
46.882: [    7.772930]  schedule_idle+0x1e/0x40
46.882: [    7.776744]  do_idle+0x146/0x200
46.882: [    7.780181]  cpu_startup_entry+0x19/0x20
46.883: [    7.784274]  start_secondary+0x183/0x1b0
46.883: [    7.788409]  secondary_startup_64+0xa4/0xb0
46.883: [    7.792766] Modules linked in:
46.883: [    7.796105] ---[ end trace a423e363fe1ecf67 ]---
46.884: [    7.800939] RIP: 0010:switch_mm_irqs_off+0xb2/0x640
46.884: [    7.806048] Code: 48 c1 ef 09 83 e7 01 48 09 c7 65 48 8b 05 8e=
 34 fc 7e 48 39 c7 74 15 48 09 f8 a8 01 74 0e b9 49 00 00 00 b8 01 00 00 =
00 31 d2 <0f> 30 65 48 89 3d 6c 34 fc 7e 8b 05 9a ef a7 01 85 c0 0f 8f 41=
 04
46.884: [    7.825440] RSP: 0018:ffffc90006343e20 EFLAGS: 00010046
46.885: [    7.830855] RAX: 0000000000000001 RBX: ffff88981ca0b800 RCX: 0=
000000000000049
46.885: [    7.838230] RDX: 0000000000000000 RSI: ffff88981b87cf80 RDI: f=
fff88981ca0b800
46.885: [    7.845614] RBP: ffffc90006343e70 R08: 00000001c81bec00 R09: 0=
000000000000000
46.886: [    7.853047] R10: ffffc90006343e88 R11: 0000000000000000 R12: f=
fffffff82479b40
46.886: [    7.860427] R13: 0000000000000000 R14: 0000000000000012 R15: f=
fff88981dd50080
46.886: [    7.867862] FS:  0000000000000000(0000) GS:ffff88981fa80000(00=
00) knlGS:0000000000000000
46.886: [    7.876320] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
46.887: [    7.882351] CR2: 0000000000000000 CR3: 000000000240a000 CR4: 0=
0000000000406e0
46.887: [    7.889746] Kernel panic - not syncing: Attempted to kill the =
idle task!
46.888: [    7.896907] Kernel Offset: disabled
46.888: [    7.900558] ---[ end Kernel panic - not syncing: Attempted to =
kill the idle task! ]---

--------------977E1A8B6201E06D1B9C18A4--
