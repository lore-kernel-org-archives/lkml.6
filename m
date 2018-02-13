Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965708AbeBMUEd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 15:04:33 -0500
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:51131 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965574AbeBMUEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 15:04:31 -0500
Date: Tue, 13 Feb 2018 22:04:28 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: 4.16-rc1: UBSAN warning in nouveau/nvkm/subdev/therm/base.c + oops
 in nvkm_therm_clkgate_fini
Message-ID: <alpine.LRH.2.21.1802132200260.24929@math.ut.ee>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is 4.16-rc1+todays git ona lowly P4 with NV5, worked fine in 4.15:

[    7.361155] nouveau 0000:01:00.0: NVIDIA NV05 (20154000)
[    7.386601] nouveau 0000:01:00.0: bios: version 02.05.19.03.00
[    7.386715] nouveau 0000:01:00.0: bios: DCB table not found
[    7.386983] nouveau 0000:01:00.0: bios: DCB table not found
[    7.387166] nouveau 0000:01:00.0: bios: DCB table not found
[    7.387266] nouveau 0000:01:00.0: bios: DCB table not found
[    7.397578] agpgart-intel 0000:00:00.0: AGP 2.0 bridge
[    7.397705] agpgart-intel 0000:00:00.0: putting AGP V2 device into 4x mode
[    7.397827] nouveau 0000:01:00.0: putting AGP V2 device into 4x mode
[    7.398021] ================================================================================
[    7.398163] UBSAN: Undefined behaviour in drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c:315:12
[    7.398302] member access within null pointer of type 'struct nvkm_therm'
[    7.398403] CPU: 0 PID: 125 Comm: systemd-udevd Not tainted 4.16.0-rc1-00010-g178e834c47b0 #65
[    7.398543] Hardware name:  /D850GB                         , BIOS GB85010A.86A.0078.P18.0110081719 10/08/2001
[    7.398686] Call Trace:
[    7.398788]  dump_stack+0x16/0x18
[    7.398885]  ubsan_epilogue+0xe/0x2f
[    7.398979]  ubsan_type_mismatch_common+0xdc/0x152
[    7.399079]  __ubsan_handle_type_mismatch+0x24/0x26
[    7.399368]  nvkm_therm_clkgate_fini+0x14d/0x174 [nouveau]
[    7.399638]  ? nvkm_device_subdev+0x1b9/0x1fa [nouveau]
[    7.399907]  nvkm_device_fini+0x113/0x3e9 [nouveau]
[    7.400010]  ? ktime_get+0x4b/0x135
[    7.400253]  ? nvkm_devinit_post+0x35/0xbf [nouveau]
[    7.400519]  nvkm_device_init+0x228/0x5b0 [nouveau]
[    7.400626]  ? kmem_cache_alloc+0xbd/0x12a
[    7.400893]  nvkm_udevice_init+0x51/0xa9 [nouveau]
[    7.401137]  nvkm_object_init+0xc8/0x442 [nouveau]
[    7.401244]  ? check_preempt_wakeup+0xc2/0x1c1
[    7.401487]  ? nvkm_client_child_new+0x1d/0x38 [nouveau]
[    7.401729]  nvkm_ioctl_new+0x152/0x3d9 [nouveau]
[    7.401835]  ? default_wake_function+0x1a/0x35
[    7.402077]  ? nvif_vmm_init+0x2ce/0x2ce [nouveau]
[    7.402345]  ? nvkm_udevice_rd08+0x5b/0x5b [nouveau]
[    7.402587]  nvkm_ioctl+0x1c6/0x48d [nouveau]
[    7.402829]  ? nvif_client_init+0xc3/0x114 [nouveau]
[    7.403094]  ? nvkm_client_map+0xf/0xf [nouveau]
[    7.403382]  nvkm_client_ioctl+0x1c/0x22 [nouveau]
[    7.403643]  nvif_object_ioctl+0x6f/0xff [nouveau]
[    7.403903]  nvif_object_init+0xd4/0x1de [nouveau]
[    7.404164]  nvif_device_init+0x21/0x5c [nouveau]
[    7.404453]  nouveau_cli_init+0x21f/0xe1f [nouveau]
[    7.404733]  ? nouveau_drm_load+0x1d/0xe11 [nouveau]
[    7.405011]  nouveau_drm_load+0x54/0xe11 [nouveau]
[    7.405112]  ? kernfs_new_node+0x2b/0x8e
[    7.405209]  ? kernfs_create_link+0x55/0xcd
[    7.405323]  ? drm_dev_register+0x12f/0x2e0 [drm]
[    7.405437]  drm_dev_register+0x168/0x2e0 [drm]
[    7.405538]  ? pci_enable_device_flags+0xeb/0x15e
[    7.405651]  drm_get_pci_dev+0xbf/0x230 [drm]
[    7.405924]  nouveau_drm_probe+0x183/0x1ea [nouveau]
[    7.406035]  pci_device_probe+0xaa/0x163
[    7.406136]  driver_probe_device+0x1db/0x383
[    7.406234]  __driver_attach+0x86/0xb8
[    7.406330]  ? driver_probe_device+0x383/0x383
[    7.406427]  bus_for_each_dev+0x4e/0x83
[    7.406522]  driver_attach+0x1d/0x33
[    7.406618]  ? driver_probe_device+0x383/0x383
[    7.406714]  bus_add_driver+0x184/0x273
[    7.406810]  driver_register+0x66/0x107
[    7.407039]  ? nouveau_drm_init+0x66/0x1000 [nouveau]
[    7.407146]  __pci_register_driver+0x47/0x71
[    7.407379]  nouveau_drm_init+0x18a/0x1000 [nouveau]
[    7.407478]  ? 0xf831a000
[    7.407575]  do_one_initcall+0x4f/0x1e2
[    7.407672]  ? free_unref_page_commit.isra.88+0xd5/0x176
[    7.407771]  ? kvfree+0x3c/0x3e
[    7.407864]  ? __vunmap+0x89/0xef
[    7.407960]  ? do_init_module+0x1a/0x23f
[    7.408055]  do_init_module+0x82/0x23f
[    7.408153]  load_module+0x243c/0x36ae
[    7.408253]  ? kernel_read+0x4c/0xa1
[    7.408350]  SyS_finit_module+0x78/0x8d
[    7.408447]  do_fast_syscall_32+0xc1/0x31b
[    7.408545]  entry_SYSENTER_32+0x4e/0x7c
[    7.408640] EIP: 0xb7ee9ad5
[    7.408730] EFLAGS: 00000296 CPU: 0
[    7.408823] EAX: ffffffda EBX: 00000019 ECX: b7ce0bdd EDX: 00000000
[    7.408920] ESI: 00eb6670 EDI: 00ebe610 EBP: 00000000 ESP: bff8704c
[    7.409017]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[    7.409113] ================================================================================
[    7.409344] BUG: unable to handle kernel NULL pointer dereference at   (null)
[    7.409640] IP: nvkm_therm_clkgate_fini+0x15/0x174 [nouveau]
[    7.409738] *pde = 00000000 
[    7.409833] Oops: 0000 [#1]
[    7.409923] Modules linked in: nouveau(+) evdev wmi video i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops uhci_hcd ttm ehci_hcd usbcore drm pcspkr psmouse sr_mod cdrom sg drm_panel_orientation_quirks parport_pc floppy i2c_i801 parport usb_common snd_intel8x0 snd_ac97_codec button rng_core ac97_bus snd_pcm snd_timer snd soundcore eeprom adm1031 adm1025 hwmon_vid i2c_core ip_tables x_tables ipv6 autofs4
[    7.410357] CPU: 0 PID: 125 Comm: systemd-udevd Not tainted 4.16.0-rc1-00010-g178e834c47b0 #65
[    7.410499] Hardware name:  /D850GB                         , BIOS GB85010A.86A.0078.P18.0110081719 10/08/2001
[    7.410824] EIP: nvkm_therm_clkgate_fini+0x15/0x174 [nouveau]
[    7.410921] EFLAGS: 00010286 CPU: 0
[    7.411014] EAX: f6b3b800 EBX: 00000000 ECX: 00000006 EDX: 00000007
[    7.411109] ESI: 00000000 EDI: 00000000 EBP: f6155858 ESP: f6155834
[    7.411205]  DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068
[    7.411299] CR0: 80050033 CR2: 00000000 CR3: 3614b000 CR4: 000006d0
[    7.411395] Call Trace:
[    7.411662]  ? nvkm_device_subdev+0x1b9/0x1fa [nouveau]
[    7.411926]  nvkm_device_fini+0x113/0x3e9 [nouveau]
[    7.412030]  ? ktime_get+0x4b/0x135
[    7.412274]  ? nvkm_devinit_post+0x35/0xbf [nouveau]
[    7.412536]  nvkm_device_init+0x228/0x5b0 [nouveau]
[    7.412640]  ? kmem_cache_alloc+0xbd/0x12a
[    7.412906]  nvkm_udevice_init+0x51/0xa9 [nouveau]
[    7.413146]  nvkm_object_init+0xc8/0x442 [nouveau]
[    7.413248]  ? check_preempt_wakeup+0xc2/0x1c1
[    7.413602]  ? nvkm_client_child_new+0x1d/0x38 [nouveau]
[    7.413956]  nvkm_ioctl_new+0x152/0x3d9 [nouveau]
[    7.414055]  ? default_wake_function+0x1a/0x35
[    7.414409]  ? nvif_vmm_init+0x2ce/0x2ce [nouveau]
[    7.414788]  ? nvkm_udevice_rd08+0x5b/0x5b [nouveau]
[    7.415150]  nvkm_ioctl+0x1c6/0x48d [nouveau]
[    7.416466]  ? nvif_client_init+0xc3/0x114 [nouveau]
[    7.416832]  ? nvkm_client_map+0xf/0xf [nouveau]
[    7.417201]  nvkm_client_ioctl+0x1c/0x22 [nouveau]
[    7.417554]  nvif_object_ioctl+0x6f/0xff [nouveau]
[    7.417909]  nvif_object_init+0xd4/0x1de [nouveau]
[    7.418271]  nvif_device_init+0x21/0x5c [nouveau]
[    7.418536]  nouveau_cli_init+0x21f/0xe1f [nouveau]
[    7.418799]  ? nouveau_drm_load+0x1d/0xe11 [nouveau]
[    7.419058]  nouveau_drm_load+0x54/0xe11 [nouveau]
[    7.419158]  ? kernfs_new_node+0x2b/0x8e
[    7.419255]  ? kernfs_create_link+0x55/0xcd
[    7.419369]  ? drm_dev_register+0x12f/0x2e0 [drm]
[    7.419496]  drm_dev_register+0x168/0x2e0 [drm]
[    7.419596]  ? pci_enable_device_flags+0xeb/0x15e
[    7.419724]  drm_get_pci_dev+0xbf/0x230 [drm]
[    7.420102]  nouveau_drm_probe+0x183/0x1ea [nouveau]
[    7.420207]  pci_device_probe+0xaa/0x163
[    7.420305]  driver_probe_device+0x1db/0x383
[    7.420402]  __driver_attach+0x86/0xb8
[    7.420497]  ? driver_probe_device+0x383/0x383
[    7.420597]  bus_for_each_dev+0x4e/0x83
[    7.420694]  driver_attach+0x1d/0x33
[    7.420790]  ? driver_probe_device+0x383/0x383
[    7.420886]  bus_add_driver+0x184/0x273
[    7.420983]  driver_register+0x66/0x107
[    7.421215]  ? nouveau_drm_init+0x66/0x1000 [nouveau]
[    7.421322]  __pci_register_driver+0x47/0x71
[    7.421555]  nouveau_drm_init+0x18a/0x1000 [nouveau]
[    7.421654]  ? 0xf831a000
[    7.421751]  do_one_initcall+0x4f/0x1e2
[    7.421850]  ? free_unref_page_commit.isra.88+0xd5/0x176
[    7.421947]  ? kvfree+0x3c/0x3e
[    7.422041]  ? __vunmap+0x89/0xef
[    7.422136]  ? do_init_module+0x1a/0x23f
[    7.422232]  do_init_module+0x82/0x23f
[    7.422329]  load_module+0x243c/0x36ae
[    7.422428]  ? kernel_read+0x4c/0xa1
[    7.422524]  SyS_finit_module+0x78/0x8d
[    7.422624]  do_fast_syscall_32+0xc1/0x31b
[    7.422722]  entry_SYSENTER_32+0x4e/0x7c
[    7.422817] EIP: 0xb7ee9ad5
[    7.422907] EFLAGS: 00000296 CPU: 0
[    7.423001] EAX: ffffffda EBX: 00000019 ECX: b7ce0bdd EDX: 00000000
[    7.423098] ESI: 00eb6670 EDI: 00ebe610 EBP: 00000000 ESP: bff8704c
[    7.423195]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[    7.423291] Code: e9 30 ff ff ff 31 d2 b8 78 cf b0 f8 e8 ba 07 a2 c8 e9 0f ff ff ff 55 89 e5 57 56 53 83 ec 18 89 c3 89 d6 85 c0 0f 84 2c 01 00 00 <8b> 3b 85 ff 0f 84 11 01 00 00 8b 47 30 85 c0 0f 84 a1 00 00 00
[    7.423757] EIP: nvkm_therm_clkgate_fini+0x15/0x174 [nouveau] SS:ESP: 0068:f6155834
[    7.423899] CR2: 0000000000000000
[    7.424033] ---[ end trace cad535783d11d7b9 ]---

-- 
Meelis Roos (mroos@linux.ee)
