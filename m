Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753120AbeDSF0C (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 01:26:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:9382 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750953AbeDSFZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 01:25:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,467,1517904000";
   d="scan'208";a="44428693"
Date: Thu, 19 Apr 2018 13:25:48 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: linux-btrfs@vger.kernel.org
Cc: Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        linux-kernel@vger.kernel.org, lkp@01.org
Subject: [btrfs_destroy_workqueue] WARNING: CPU: 0 PID: 6954 at
 kernel/workqueue.c:4142 destroy_workqueue+0x64/0x1e0
Message-ID: <20180419052548.ewio4pf6i7ptqj54@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dsxiu7sfiuyrfgls"
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dsxiu7sfiuyrfgls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

FYI this happens in mainline kernel 4.17.0-rc1.
It at least dates back to v4.14-rc2 .

It's triggered when running fio tests. It's really hard to reproduce
(only happened once in 4.17-rc1 and several times in v4.14-rc2) and
all bisects failed so far.

[  133.751073] WARNING: stack going in the wrong direction? ip=__schedule+0x489/0x830:
						perf_sw_event_sched at include/linux/perf_event.h:1062
						 (inlined by) perf_event_task_sched_out at include/linux/perf_event.h:1100
						 (inlined by) prepare_task_switch at kernel/sched/core.c:2636
						 (inlined by) context_switch at kernel/sched/core.c:2813
						 (inlined by) __schedule at kernel/sched/core.c:3490
[  134.048965] perf: interrupt took too long (9682 > 9626), lowering kernel.perf_event_max_sample_rate to 20000
[  134.472390] perf: interrupt took too long (12178 > 12102), lowering kernel.perf_event_max_sample_rate to 16000
[  234.324541] 2018-04-17 16:08:50 umount /fs/pmem0
[  234.324546]
[  240.185400] WARNING: CPU: 0 PID: 6954 at kernel/workqueue.c:4142 destroy_workqueue+0x64/0x1e0:
						destroy_workqueue at kernel/workqueue.c:4142 (discriminator 1)
[  240.197915] Modules linked in: btrfs xor zstd_decompress zstd_compress xxhash raid6_pq dm_mod sr_mod cdrom intel_rapl sd_mod sg sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp mgag200 kvm_intel ttm kvm irqbypass crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel ghash_clmulni_intel syscopyarea nd_pmem(O) dax_pmem(O) snd_pcm pcbc sysfillrect device_dax(O) nd_btt(O) snd_timer sysimgblt aesni_intel fb_sys_fops nd_e820(O) crypto_simd ipmi_si libnvdimm(O) snd soundcore ahci mxm_wmi cryptd ipmi_devintf wdat_wdt dcdbas nfit_test_iomap(O) libahci pcspkr drm megaraid_sas glue_helper libata ipmi_msghandler wmi acpi_power_meter shpchp ip_tables
[  240.267813] CPU: 0 PID: 6954 Comm: umount Tainted: G           O      4.17.0-rc1 #1
[  240.277473] Hardware name: Dell Inc. PowerEdge R630/0CNCJW, BIOS 2.1.7 06/16/2016
[  240.286967] RIP: 0010:destroy_workqueue+0x64/0x1e0:
						destroy_workqueue at kernel/workqueue.c:4142 (discriminator 1)
[  240.293463] RSP: 0018:ffffc90021b0fde0 EFLAGS: 00010202
[  240.300462] RAX: ffff884072f4c058 RBX: ffff88407a17dc00 RCX: ffff884072f4c000
[  240.309628] RDX: ffff884072f4c058 RSI: 0000000000000000 RDI: ffffffff820cfa30
[  240.318802] RBP: ffff88407a17dc20 R08: ffffc90021b0fd40 R09: 0000000000000000
[  240.327990] R10: ffffc90021b0fdb8 R11: 0000000000000000 R12: ffff8820347f4fc0
[  240.337306] R13: ffff884079c23138 R14: ffffffff82d47aa0 R15: 0000000000000000
[  240.346546] FS:  00007f941fee2840(0000) GS:ffff882067600000(0000) knlGS:0000000000000000
[  240.356876] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  240.364602] CR2: 00007ff793645258 CR3: 0000004074f4a005 CR4: 00000000001606f0
[  240.373917] Call Trace:
[  240.378060]  btrfs_destroy_workqueue+0x40/0x110 [btrfs]
[  240.385322]  btrfs_stop_all_workers+0x2d/0xf0 [btrfs]
[  240.392397]  close_ctree+0x133/0x2f0 [btrfs]
[  240.398581]  generic_shutdown_super+0x6c/0x120:
						__read_once_size at include/linux/compiler.h:188
						 (inlined by) list_empty at include/linux/list.h:203
						 (inlined by) generic_shutdown_super at fs/super.c:442
[  240.404956]  kill_anon_super+0xe/0x20:
						kill_anon_super at fs/super.c:1038
[  240.410482]  btrfs_kill_super+0x13/0x100 [btrfs]
[  240.417076]  deactivate_locked_super+0x3f/0x70:
						deactivate_locked_super at fs/super.c:320
[  240.423483]  cleanup_mnt+0x3b/0x70:
						cleanup_mnt at fs/namespace.c:1174
[  240.428737]  task_work_run+0xa3/0xe0:
						task_work_run at kernel/task_work.c:115 (discriminator 1)
[  240.434199]  exit_to_usermode_loop+0x9e/0xa0:
						tracehook_notify_resume at include/linux/tracehook.h:191
						 (inlined by) exit_to_usermode_loop at arch/x86/entry/common.c:166
[  240.440456]  do_syscall_64+0x16c/0x180:
						prepare_exit_to_usermode at arch/x86/entry/common.c:196
						 (inlined by) syscall_return_slowpath at arch/x86/entry/common.c:265
						 (inlined by) do_syscall_64 at arch/x86/entry/common.c:290
[  240.446133]  entry_SYSCALL_64_after_hwframe+0x44/0xa9:
						entry_SYSCALL_64_after_hwframe at arch/x86/entry/entry_64.S:247
[  240.453285] RIP: 0033:0x7f941f7c7277
[  240.458782] RSP: 002b:00007fffb9a17cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[  240.468778] RAX: 0000000000000000 RBX: 000000000158b6e0 RCX: 00007f941f7c7277
[  240.478299] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000000000158b8c0
[  240.487824] RBP: 000000000158b8c0 R08: 0000000000000000 R09: 0000000000000015
[  240.497317] R10: 00000000000006b0 R11: 0000000000000246 R12: 00007f941fcc9e44
[  240.506810] R13: 0000000000000000 R14: 0000000000000000 R15: 00007fffb9a17f80
[  240.516315] Code: c2 74 19 8b 30 85 f6 74 f1 0f 0b 48 89 ef e8 84 9f 8c 00 5b 5d 41 5c e9 cb fa ff ff 48 39 8b a0 00 00 00 74 0a 83 79 18 01 7e 04 <0f> 0b eb dc 8b 41 58 85 c0 0f 85 3d 01 00 00 48 8b 41 60 48 8d
[  240.540655] ---[ end trace faf649c5bf432714 ]---
[  240.547594] Showing busy workqueues and worker pools:

Attached the full dmesg and kconfig.

Thanks,
Fengguang

--dsxiu7sfiuyrfgls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-lkp-hsw-ep6:20180417161212:x86_64-rhel-7.2:gcc-7:4.17.0-rc1:1"
Content-Transfer-Encoding: quoted-printable

Decompressing Linux... Parsing ELF... done.
Booting the kernel.
[    0.000000] Linux version 4.17.0-rc1 (kbuild@lkp-ib04) (gcc version 7.3.=
0 (Debian 7.3.0-1)) #1 SMP Mon Apr 16 12:27:23 CST 2018
[    0.000000] Command line: ip=3D::::lkp-hsw-ep6::dhcp root=3D/dev/ram0 us=
er=3Dlkp job=3D/lkp/scheduled/lkp-hsw-ep6/fio-basic-2pmem-btrfs-200s-50%-tb=
-randwrite-2M-libaio-100G-performance-debian-x86_64-2016-08-31.cgz-60cc43fc=
888428bb2f18f08997432d426a243338-20180417-83132-1vmen9v-2.yaml ARCH=3Dx86_6=
4 kconfig=3Dx86_64-rhel-7.2 branch=3Dlinux-devel/devel-hourly-2018041619 co=
mmit=3D60cc43fc888428bb2f18f08997432d426a243338 BOOT_IMAGE=3D/pkg/linux/x86=
_64-rhel-7.2/gcc-7/60cc43fc888428bb2f18f08997432d426a243338/vmlinuz-4.17.0-=
rc1 memmap=3D104G!4G memmap=3D104G!132G max_uptime=3D1200 RESULT_ROOT=3D/re=
sult/fio-basic/2pmem-btrfs-200s-50%-tb-randwrite-2M-libaio-100G-performance=
/lkp-hsw-ep6/debian-x86_64-2016-08-31.cgz/x86_64-rhel-7.2/gcc-7/60cc43fc888=
428bb2f18f08997432d426a243338/2 LKP_SERVER=3Dinn debug apic=3Ddebug sysrq_a=
lways_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.d=
evkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpan=
ic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_lev=
el=3De
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 by=
tes, using 'standard' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000100-0x000000000009bfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009c000-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007a288fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a289000-0x000000007af0afff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007af0b000-0x000000007b93afff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000007b93b000-0x000000007bab5fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000007bab6000-0x000000007bae8fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007bae9000-0x000000007bafefff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000007baff000-0x000000007bafffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007bb00000-0x000000008fffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000feda8000-0x00000000fedabfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ff310000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000407fffffff] usable
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: user-defined physical RAM map:
[    0.000000] user: [mem 0x0000000000000100-0x000000000009bfff] usable
[    0.000000] user: [mem 0x000000000009c000-0x000000000009ffff] reserved
[    0.000000] user: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] user: [mem 0x0000000000100000-0x000000007a288fff] usable
[    0.000000] user: [mem 0x000000007a289000-0x000000007af0afff] reserved
[    0.000000] user: [mem 0x000000007af0b000-0x000000007b93afff] ACPI NVS
[    0.000000] user: [mem 0x000000007b93b000-0x000000007bab5fff] ACPI data
[    0.000000] user: [mem 0x000000007bab6000-0x000000007bae8fff] usable
[    0.000000] user: [mem 0x000000007bae9000-0x000000007bafefff] ACPI data
[    0.000000] user: [mem 0x000000007baff000-0x000000007bafffff] usable
[    0.000000] user: [mem 0x000000007bb00000-0x000000008fffffff] reserved
[    0.000000] user: [mem 0x00000000feda8000-0x00000000fedabfff] reserved
[    0.000000] user: [mem 0x00000000ff310000-0x00000000ffffffff] reserved
[    0.000000] user: [mem 0x0000000100000000-0x0000001affffffff] persistent=
 (type 12)
[    0.000000] user: [mem 0x0000001b00000000-0x00000020ffffffff] usable
[    0.000000] user: [mem 0x0000002100000000-0x0000003affffffff] persistent=
 (type 12)
[    0.000000] user: [mem 0x0000003b00000000-0x000000407fffffff] usable
[    0.000000] random: fast init done
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: Dell Inc. PowerEdge R630/0CNCJW, BIOS 2.1.7 06/16/2016
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn =3D 0x4080000 max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000080000000 mask 3FFF80000000 uncachable
[    0.000000]   1 base 0000FF000000 mask 3FFFFF000000 write-protect
[    0.000000]   2 base 038000000000 mask 3F8000000000 uncachable
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.000000] e820: last_pfn =3D 0x7bb00 max_arch_pfn =3D 0x400000000
[    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.000000] Scan for SMP in [mem 0x0009cc00-0x0009cfff]
[    0.000000] Base memory trampoline at [        (ptrval)] 96000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x407ef4b000, 0x407ef4bfff] PGTABLE
[    0.000000] BRK [0x407ef4c000, 0x407ef4cfff] PGTABLE
[    0.000000] BRK [0x407ef4d000, 0x407ef4dfff] PGTABLE
[    0.000000] BRK [0x407ef4e000, 0x407ef4efff] PGTABLE
[    0.000000] BRK [0x407ef4f000, 0x407ef4ffff] PGTABLE
[    0.000000] BRK [0x407ef50000, 0x407ef50fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x4067b2d000-0x407cffffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000FE320 000024 (v02 DELL  )
[    0.000000] ACPI: XSDT 0x000000007BAB40E8 0000BC (v01 DELL   PE_SC3   00=
000000      01000013)
[    0.000000] ACPI: FACP 0x000000007BAB0000 0000F4 (v04 DELL   PE_SC3   00=
000000 DELL 00000001)
[    0.000000] ACPI: DSDT 0x000000007BA98000 0105A9 (v02 DELL   PE_SC3   00=
000003 DELL 00000001)
[    0.000000] ACPI: FACS 0x000000007B8C3000 000040
[    0.000000] ACPI: MCEJ 0x000000007BAB3000 000130 (v01 INTEL           00=
000001 INTL 0100000D)
[    0.000000] ACPI: WDAT 0x000000007BAB2000 000134 (v01 DELL   PE_SC3   00=
000001 DELL 00000001)
[    0.000000] ACPI: SLIC 0x000000007BAB1000 000024 (v01 DELL   PE_SC3   00=
000001 DELL 00000001)
[    0.000000] ACPI: HPET 0x000000007BAAF000 000038 (v01 DELL   PE_SC3   00=
000001 DELL 00000001)
[    0.000000] ACPI: APIC 0x000000007BAAE000 000AFC (v02 DELL   PE_SC3   00=
000000 DELL 00000001)
[    0.000000] ACPI: MCFG 0x000000007BAAD000 00003C (v01 DELL   PE_SC3   00=
000001 DELL 00000001)
[    0.000000] ACPI: MSCT 0x000000007BAAC000 000090 (v01 DELL   PE_SC3   00=
000001 DELL 00000001)
[    0.000000] ACPI: SLIT 0x000000007BAAB000 00006C (v01 DELL   PE_SC3   00=
000001 DELL 00000001)
[    0.000000] ACPI: SRAT 0x000000007BAA9000 001130 (v03 DELL   PE_SC3   00=
000001 DELL 00000001)
[    0.000000] ACPI: SSDT 0x000000007B955000 1424A9 (v02 DELL   PE_SC3   00=
004000 INTL 20121114)
[    0.000000] ACPI: SSDT 0x000000007B952000 002198 (v02 DELL   PE_SC3   00=
000002 INTL 20121114)
[    0.000000] ACPI: SSDT 0x000000007B951000 00006E (v02 DELL   PE_SC3   00=
000002 INTL 20121114)
[    0.000000] ACPI: PRAD 0x000000007B950000 000132 (v02 DELL   PE_SC3   00=
000002 INTL 20121114)
[    0.000000] ACPI: DMAR 0x000000007BAFE000 0000F0 (v01 DELL   PE_SC3   00=
000001 DELL 00000001)
[    0.000000] ACPI: HEST 0x000000007BAFD000 00017C (v01 DELL   PE_SC3   00=
000002 DELL 00000001)
[    0.000000] ACPI: BERT 0x000000007BAFC000 000030 (v01 DELL   PE_SC3   00=
000002 DELL 00000001)
[    0.000000] ACPI: ERST 0x000000007BAFB000 000230 (v01 DELL   PE_SC3   00=
000002 DELL 00000001)
[    0.000000] ACPI: EINJ 0x000000007BAFA000 000150 (v01 DELL   PE_SC3   00=
000002 DELL 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to ffffffffff5fc000 (        fee00000)
[    0.000000] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x20 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x22 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x24 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x26 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x08 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x28 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x0a -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x2a -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x0c -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x2c -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x10 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x30 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x12 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x32 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x14 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x34 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x16 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x36 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x18 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x38 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x1a -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x3a -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x1c -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x3c -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x21 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x23 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x25 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x27 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x09 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x29 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x0b -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x2b -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x0d -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x2d -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x11 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x31 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x13 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x33 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x15 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x35 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x17 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x37 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x19 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x39 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x1b -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x3b -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x1d -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x3d -> Node 1
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x207fffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x2080000000-0x407fffffff]
[    0.000000] NUMA: Initialized distance table, cnt=3D2
[    0.000000] NODE_DATA(0) allocated [mem 0x207ffd5000-0x207fffffff]
[    0.000000] NODE_DATA(1) allocated [mem 0x407ffd4000-0x407fffefff]
[    0.000000] cma: Reserved 200 MiB at 0x000000405b000000
[    0.000000] tsc: Fast TSC calibration failed
[    0.000000] tsc: Using PIT calibration value
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000407fffffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009bfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000007a288fff]
[    0.000000]   node   0: [mem 0x000000007bab6000-0x000000007bae8fff]
[    0.000000]   node   0: [mem 0x000000007baff000-0x000000007bafffff]
[    0.000000]   node   0: [mem 0x0000001b00000000-0x000000207fffffff]
[    0.000000]   node   1: [mem 0x0000002080000000-0x00000020ffffffff]
[    0.000000]   node   1: [mem 0x0000003b00000000-0x000000407fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000207ffff=
fff]
[    0.000000] On node 0 totalpages: 6267480
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3995 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7755 pages used for memmap
[    0.000000]   DMA32 zone: 496317 pages, LIFO batch:31
[    0.000000]   Normal zone: 90112 pages used for memmap
[    0.000000]   Normal zone: 5767168 pages, LIFO batch:31
[    0.000000] Initmem setup node 1 [mem 0x0000002080000000-0x000000407ffff=
fff]
[    0.000000] On node 1 totalpages: 6291456
[    0.000000]   Normal zone: 98304 pages used for memmap
[    0.000000]   Normal zone: 6291456 pages, LIFO batch:31
[    0.000000] Reserved but unavailable: 101 pages
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x08] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x09] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x10] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x11] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x12] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x13] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x14] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x15] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x16] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x17] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x18] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x19] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x20] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x21] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x22] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x23] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x24] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x25] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x26] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x27] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x28] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x29] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x30] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x31] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x32] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x33] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x34] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x35] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x36] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x37] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x38] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x39] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x40] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x41] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x42] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x43] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x44] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x45] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x46] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x47] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x48] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x49] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x50] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x51] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x52] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x53] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x54] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x55] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x56] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x57] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x58] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x59] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x60] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x61] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x62] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x63] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x64] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x65] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x66] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x67] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x68] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x69] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x70] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x71] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x72] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x73] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x74] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x75] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x76] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x77] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x78] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x79] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x80] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x81] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x82] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x83] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x84] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x85] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x86] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x87] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x88] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x89] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x90] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x91] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x92] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x93] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x94] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x95] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x96] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x97] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x98] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x99] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa0] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa1] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa2] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa3] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa4] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa5] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa6] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa7] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa8] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa9] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xaa] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xab] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xac] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xad] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xae] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xaf] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb0] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb1] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb2] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb3] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb4] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb5] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb6] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb7] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb8] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb9] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xba] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xbb] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xbc] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xbd] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xbe] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xbf] high level lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-=
23
[    0.000000] IOAPIC[1]: apic_id 9, version 32, address 0xfec01000, GSI 24=
-47
[    0.000000] IOAPIC[2]: apic_id 10, version 32, address 0xfec40000, GSI 4=
8-71
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 8, APIC =
INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 8, APIC =
INT 09
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 8, APIC =
INT 01
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 8, APIC =
INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 8, APIC =
INT 04
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 8, APIC =
INT 05
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 8, APIC =
INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 8, APIC =
INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 8, APIC =
INT 08
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 8, APIC =
INT 0a
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 8, APIC =
INT 0b
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 8, APIC =
INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 8, APIC =
INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 8, APIC =
INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 8, APIC =
INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 56 CPUs, 0 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffffffff5fb000 (fec00000)
[    0.000000] mapped IOAPIC to ffffffffff5fa000 (fec01000)
[    0.000000] mapped IOAPIC to ffffffffff5f9000 (fec40000)
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009c000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x7a289000-0x7af0afff]
[    0.000000] PM: Registered nosave memory: [mem 0x7af0b000-0x7b93afff]
[    0.000000] PM: Registered nosave memory: [mem 0x7b93b000-0x7bab5fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7bae9000-0x7bafefff]
[    0.000000] PM: Registered nosave memory: [mem 0x7bb00000-0x8fffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x90000000-0xfeda7fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfeda8000-0xfedabfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfedac000-0xff30ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff310000-0xffffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x100000000-0x1affffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x2100000000-0x3affffffff]
[    0.000000] e820: [mem 0x90000000-0xfeda7fff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:56 nr_cpu_ids:56 =
nr_node_ids:2
[    0.000000] percpu: Embedded 45 pages/cpu @        (ptrval) s147032 r819=
2 d29096 u262144
[    0.000000] pcpu-alloc: s147032 r8192 d29096 u262144 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 00 02 04 06 08 10 12 14 [0] 16 18 20 22 24 2=
6 28 30=20
[    0.000000] pcpu-alloc: [0] 32 34 36 38 40 42 44 46 [0] 48 50 52 54 -- -=
- -- --=20
[    0.000000] pcpu-alloc: [1] 01 03 05 07 09 11 13 15 [1] 17 19 21 23 25 2=
7 29 31=20
[    0.000000] pcpu-alloc: [1] 33 35 37 39 41 43 45 47 [1] 49 51 53 55 -- -=
- -- --=20
[    0.000000] Built 2 zonelists, mobility grouping on.  Total pages: 12362=
680
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: ip=3D::::lkp-hsw-ep6::dhcp root=3D/dev/=
ram0 user=3Dlkp job=3D/lkp/scheduled/lkp-hsw-ep6/fio-basic-2pmem-btrfs-200s=
-50%-tb-randwrite-2M-libaio-100G-performance-debian-x86_64-2016-08-31.cgz-6=
0cc43fc888428bb2f18f08997432d426a243338-20180417-83132-1vmen9v-2.yaml ARCH=
=3Dx86_64 kconfig=3Dx86_64-rhel-7.2 branch=3Dlinux-devel/devel-hourly-20180=
41619 commit=3D60cc43fc888428bb2f18f08997432d426a243338 BOOT_IMAGE=3D/pkg/l=
inux/x86_64-rhel-7.2/gcc-7/60cc43fc888428bb2f18f08997432d426a243338/vmlinuz=
-4.17.0-rc1 memmap=3D104G!4G memmap=3D104G!132G max_uptime=3D1200 RESULT_RO=
OT=3D/result/fio-basic/2pmem-btrfs-200s-50%-tb-randwrite-2M-libaio-100G-per=
formance/lkp-hsw-ep6/debian-x86_64-2016-08-31.cgz/x86_64-rhel-7.2/gcc-7/60c=
c43fc888428bb2f18f08997432d426a243338/2 LKP_SERVER=3Dinn debug apic=3Ddebug=
 sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 =
printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oo=
ps=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd=
=2Elog_
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] Memory: 48786856K/50235744K available (12300K kernel code, 2=
592K rwdata, 4168K rodata, 2384K init, 2472K bss, 1244088K reserved, 204800=
K cma-reserved)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D56, =
Nodes=3D2
[    0.000000] Kernel/User page tables isolation: enabled
[    0.000000] ftrace: allocating 39726 entries in 156 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=3D56.
[    0.000000] 	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_ti=
meout).
[    0.000000] 	Tasks RCU enabled.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D56
[    0.000000] NR_IRQS: 524544, nr_irqs: 1688, preallocated irqs: 16
[    0.000000] 	Offload RCU callbacks from CPUs: (none).
[    0.000000] spurious APIC interrupt through vector ff on CPU#0, should n=
ever happen.
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] console [ttyS0] enabled
[    0.000000] bootconsole [earlyser0] disabled
[    0.000000] mempolicy: Enabling automatic NUMA balancing. Configure with=
 numa_balancing=3D or the kernel.numa_balancing sysctl
[    0.000000] ACPI: Core revision 20180313
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] APIC: Switch to symmetric I/O mode setup
[    0.000000] DMAR: Host address width 46
[    0.000000] DMAR: DRHD base: 0x000000fbffc000 flags: 0x0
[    0.000000] DMAR: dmar0: reg_base_addr fbffc000 ver 1:0 cap d2078c106f04=
66 ecap f020df
[    0.000000] DMAR: DRHD base: 0x000000c7ffc000 flags: 0x1
[    0.000000] DMAR: dmar1: reg_base_addr c7ffc000 ver 1:0 cap d2078c106f04=
66 ecap f020df
[    0.000000] DMAR: RMRR base: 0x0000007ae07000 end: 0x0000007af06fff
[    0.000000] DMAR: ATSR flags: 0x0
[    0.000000] DMAR-IR: IOAPIC id 10 under DRHD base  0xfbffc000 IOMMU 0
[    0.000000] DMAR-IR: IOAPIC id 8 under DRHD base  0xc7ffc000 IOMMU 1
[    0.000000] DMAR-IR: IOAPIC id 9 under DRHD base  0xc7ffc000 IOMMU 1
[    0.000000] DMAR-IR: HPET id 0 under DRHD base 0xc7ffc000
[    0.000000] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out=
 bit.
[    0.000000] DMAR-IR: Use 'intremap=3Dno_x2apic_optout' to override the B=
IOS setting.
[    0.000000] DMAR-IR: IRQ remapping was enabled on dmar0 but we are not i=
n kdump mode
[    0.000000] DMAR-IR: IRQ remapping was enabled on dmar1 but we are not i=
n kdump mode
[    0.000000] DMAR-IR: Enabled IRQ remapping in xapic mode
[    0.000000] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.000000] Switched APIC routing to physical flat.
[    0.000000] masked ExtINT on CPU#0
[    0.000000] ENABLING IO-APIC IRQs
[    0.000000] init IO_APIC IRQs
[    0.000000]  apic 8 pin 0 not connected
[    0.000000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT=
:1)
[    0.000000] IOAPIC[0]: Set routing entry (8-1 -> 0xef -> IRQ 1 Mode:0 Ac=
tive:0 Dest:0)
[    0.000000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:30 Dest:00000000 SID:F0FF SQ:0 SVT=
:1)
[    0.000000] IOAPIC[0]: Set routing entry (8-2 -> 0x30 -> IRQ 0 Mode:0 Ac=
tive:0 Dest:0)
[    0.000000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT=
:1)
[    0.000000] IOAPIC[0]: Set routing entry (8-3 -> 0xef -> IRQ 3 Mode:0 Ac=
tive:0 Dest:0)
[    0.000000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT=
:1)
[    0.000000] IOAPIC[0]: Set routing entry (8-4 -> 0xef -> IRQ 4 Mode:0 Ac=
tive:0 Dest:0)
[    0.000000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT=
:1)
[    0.000000] IOAPIC[0]: Set routing entry (8-5 -> 0xef -> IRQ 5 Mode:0 Ac=
tive:0 Dest:0)
[    0.000000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT=
:1)
[    0.000000] IOAPIC[0]: Set routing entry (8-6 -> 0xef -> IRQ 6 Mode:0 Ac=
tive:0 Dest:0)
[    0.000000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT=
:1)
[    0.000000] IOAPIC[0]: Set routing entry (8-7 -> 0xef -> IRQ 7 Mode:0 Ac=
tive:0 Dest:0)
[    0.000000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT=
:1)
[    0.000000] IOAPIC[0]: Set routing entry (8-8 -> 0xef -> IRQ 8 Mode:0 Ac=
tive:0 Dest:0)
[    0.000000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT=
:1)
[    0.000000] IOAPIC[0]: Set routing entry (8-9 -> 0xef -> IRQ 9 Mode:1 Ac=
tive:0 Dest:0)
[    0.000000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT=
:1)
[    0.000000] IOAPIC[0]: Set routing entry (8-10 -> 0xef -> IRQ 10 Mode:0 =
Active:0 Dest:0)
[    0.000000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT=
:1)
[    0.000000] IOAPIC[0]: Set routing entry (8-11 -> 0xef -> IRQ 11 Mode:0 =
Active:0 Dest:0)
[    0.000000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT=
:1)
[    0.000000] IOAPIC[0]: Set routing entry (8-12 -> 0xef -> IRQ 12 Mode:0 =
Active:0 Dest:0)
[    0.000000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT=
:1)
[    0.000000] IOAPIC[0]: Set routing entry (8-13 -> 0xef -> IRQ 13 Mode:0 =
Active:0 Dest:0)
[    0.000000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT=
:1)
[    0.000000] IOAPIC[0]: Set routing entry (8-14 -> 0xef -> IRQ 14 Mode:0 =
Active:0 Dest:0)
[    0.000000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT=
:1)
[    0.000000] IOAPIC[0]: Set routing entry (8-15 -> 0xef -> IRQ 15 Mode:0 =
Active:0 Dest:0)
[    0.000000]  apic 8 pin 16 not connected
[    0.000000]  apic 8 pin 17 not connected
[    0.000000]  apic 8 pin 18 not connected
[    0.000000]  apic 8 pin 19 not connected
[    0.000000]  apic 8 pin 20 not connected
[    0.000000]  apic 8 pin 21 not connected
[    0.000000]  apic 8 pin 22 not connected
[    0.000000]  apic 8 pin 23 not connected
[    0.000000]  apic 9 pin 0 not connected
[    0.000000]  apic 9 pin 1 not connected
[    0.000000]  apic 9 pin 2 not connected
[    0.000000]  apic 9 pin 3 not connected
[    0.000000]  apic 9 pin 4 not connected
[    0.000000]  apic 9 pin 5 not connected
[    0.000000]  apic 9 pin 6 not connected
[    0.000000]  apic 9 pin 7 not connected
[    0.000000]  apic 9 pin 8 not connected
[    0.000000]  apic 9 pin 9 not connected
[    0.000000]  apic 9 pin 10 not connected
[    0.000000]  apic 9 pin 11 not connected
[    0.000000]  apic 9 pin 12 not connected
[    0.000000]  apic 9 pin 13 not connected
[    0.000000]  apic 9 pin 14 not connected
[    0.000000]  apic 9 pin 15 not connected
[    0.000000]  apic 9 pin 16 not connected
[    0.000000]  apic 9 pin 17 not connected
[    0.000000]  apic 9 pin 18 not connected
[    0.000000]  apic 9 pin 19 not connected
[    0.000000]  apic 9 pin 20 not connected
[    0.000000]  apic 9 pin 21 not connected
[    0.000000]  apic 9 pin 22 not connected
[    0.000000]  apic 9 pin 23 not connected
[    0.000000]  apic 10 pin 0 not connected
[    0.000000]  apic 10 pin 1 not connected
[    0.000000]  apic 10 pin 2 not connected
[    0.000000]  apic 10 pin 3 not connected
[    0.000000]  apic 10 pin 4 not connected
[    0.000000]  apic 10 pin 5 not connected
[    0.000000]  apic 10 pin 6 not connected
[    0.000000]  apic 10 pin 7 not connected
[    0.000000]  apic 10 pin 8 not connected
[    0.000000]  apic 10 pin 9 not connected
[    0.000000]  apic 10 pin 10 not connected
[    0.000000]  apic 10 pin 11 not connected
[    0.000000]  apic 10 pin 12 not connected
[    0.000000]  apic 10 pin 13 not connected
[    0.000000]  apic 10 pin 14 not connected
[    0.000000]  apic 10 pin 15 not connected
[    0.000000]  apic 10 pin 16 not connected
[    0.000000]  apic 10 pin 17 not connected
[    0.000000]  apic 10 pin 18 not connected
[    0.000000]  apic 10 pin 19 not connected
[    0.000000]  apic 10 pin 20 not connected
[    0.000000]  apic 10 pin 21 not connected
[    0.000000]  apic 10 pin 22 not connected
[    0.000000]  apic 10 pin 23 not connected
[    0.000000] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.005000] tsc: Fast TSC calibration using PIT
[    0.006000] tsc: Detected 2300.021 MHz processor
[    0.007000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x212748fdc2e, max_idle_ns: 440795232711 ns
[    0.008002] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 4600.04 BogoMIPS (lpj=3D2300021)
[    0.009001] pid_max: default: 57344 minimum: 448
[    0.010110] Security Framework initialized
[    0.011001] SELinux:  Initializing.
[    0.012044] SELinux:  Starting in permissive mode
[    0.024957] Dentry cache hash table entries: 8388608 (order: 14, 6710886=
4 bytes)
[    0.031186] Inode-cache hash table entries: 4194304 (order: 13, 33554432=
 bytes)
[    0.032227] Mount-cache hash table entries: 131072 (order: 8, 1048576 by=
tes)
[    0.033191] Mountpoint-cache hash table entries: 131072 (order: 8, 10485=
76 bytes)
[    0.035364] CPU: Physical Processor ID: 0
[    0.036001] CPU: Processor Core ID: 0
[    0.037010] mce: CPU supports 22 MCE banks
[    0.038018] CPU0: Thermal monitoring enabled (TM1)
[    0.039033] process: using mwait in idle threads
[    0.040003] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
[    0.041001] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
[    0.042004] Spectre V2 : Mitigation: Full generic retpoline
[    0.049911] Freeing SMP alternatives memory: 40K
[    0.051450] TSC deadline timer enabled
[    0.052000] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2695 v3 @ 2.30GHz (fa=
mily: 0x6, model: 0x3f, stepping: 0x2)
[    0.052157] Performance Events: PEBS fmt2+, Haswell events, 16-deep LBR,=
 full-width counters, Intel PMU driver.
[    0.053004] ... version:                3
[    0.054001] ... bit width:              48
[    0.055001] ... generic registers:      4
[    0.056001] ... value mask:             0000ffffffffffff
[    0.057001] ... max period:             00007fffffffffff
[    0.058001] ... fixed-purpose events:   3
[    0.059001] ... event mask:             000000070000000f
[    0.060071] Hierarchical SRCU implementation.
[    0.066935] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.067022] smp: Bringing up secondary CPUs ...
[    0.068098] x86: Booting SMP configuration:
[    0.069002] .... node  #1, CPUs:        #1
[    0.001000] masked ExtINT on CPU#1
[    0.140139] .... node  #0, CPUs:    #2
[    0.001000] masked ExtINT on CPU#2
[    0.150477] .... node  #1, CPUs:    #3
[    0.001000] masked ExtINT on CPU#3
[    0.160788] .... node  #0, CPUs:    #4
[    0.001000] masked ExtINT on CPU#4
[    0.171139] .... node  #1, CPUs:    #5
[    0.001000] masked ExtINT on CPU#5
[    0.181388] .... node  #0, CPUs:    #6
[    0.001000] masked ExtINT on CPU#6
[    0.191728] .... node  #1, CPUs:    #7
[    0.001000] masked ExtINT on CPU#7
[    0.202111] .... node  #0, CPUs:    #8
[    0.001000] masked ExtINT on CPU#8
[    0.212194] .... node  #1, CPUs:    #9
[    0.001000] masked ExtINT on CPU#9
[    0.222391] .... node  #0, CPUs:   #10
[    0.001000] masked ExtINT on CPU#10
[    0.233069] .... node  #1, CPUs:   #11
[    0.001000] masked ExtINT on CPU#11
[    0.243130] .... node  #0, CPUs:   #12
[    0.001000] masked ExtINT on CPU#12
[    0.253447] .... node  #1, CPUs:   #13
[    0.001000] masked ExtINT on CPU#13
[    0.263747] .... node  #0, CPUs:   #14
[    0.001000] masked ExtINT on CPU#14
[    0.274144] .... node  #1, CPUs:   #15
[    0.001000] masked ExtINT on CPU#15
[    0.284458] .... node  #0, CPUs:   #16
[    0.001000] masked ExtINT on CPU#16
[    0.295128] .... node  #1, CPUs:   #17
[    0.001000] masked ExtINT on CPU#17
[    0.305176] .... node  #0, CPUs:   #18
[    0.001000] masked ExtINT on CPU#18
[    0.315534] .... node  #1, CPUs:   #19
[    0.001000] masked ExtINT on CPU#19
[    0.326094] .... node  #0, CPUs:   #20
[    0.001000] masked ExtINT on CPU#20
[    0.336355] .... node  #1, CPUs:   #21
[    0.001000] masked ExtINT on CPU#21
[    0.346645] .... node  #0, CPUs:   #22
[    0.001000] masked ExtINT on CPU#22
[    0.357143] .... node  #1, CPUs:   #23
[    0.001000] masked ExtINT on CPU#23
[    0.367588] .... node  #0, CPUs:   #24
[    0.001000] masked ExtINT on CPU#24
[    0.378140] .... node  #1, CPUs:   #25
[    0.001000] masked ExtINT on CPU#25
[    0.388578] .... node  #0, CPUs:   #26
[    0.001000] masked ExtINT on CPU#26
[    0.399140] .... node  #1, CPUs:   #27
[    0.001000] masked ExtINT on CPU#27
[    0.409576] .... node  #0, CPUs:   #28
[    0.001000] masked ExtINT on CPU#28
[    0.418167] .... node  #1, CPUs:   #29
[    0.001000] masked ExtINT on CPU#29
[    0.428563] .... node  #0, CPUs:   #30
[    0.001000] masked ExtINT on CPU#30
[    0.439148] .... node  #1, CPUs:   #31
[    0.001000] masked ExtINT on CPU#31
[    0.449441] .... node  #0, CPUs:   #32
[    0.001000] masked ExtINT on CPU#32
[    0.460149] .... node  #1, CPUs:   #33
[    0.001000] masked ExtINT on CPU#33
[    0.470301] .... node  #0, CPUs:   #34
[    0.001000] masked ExtINT on CPU#34
[    0.480697] .... node  #1, CPUs:   #35
[    0.001000] masked ExtINT on CPU#35
[    0.491128] .... node  #0, CPUs:   #36
[    0.001000] masked ExtINT on CPU#36
[    0.501383] .... node  #1, CPUs:   #37
[    0.001000] masked ExtINT on CPU#37
[    0.511730] .... node  #0, CPUs:   #38
[    0.001000] masked ExtINT on CPU#38
[    0.522144] .... node  #1, CPUs:   #39
[    0.001000] masked ExtINT on CPU#39
[    0.532469] .... node  #0, CPUs:   #40
[    0.001000] masked ExtINT on CPU#40
[    0.543119] .... node  #1, CPUs:   #41
[    0.001000] masked ExtINT on CPU#41
[    0.553149] .... node  #0, CPUs:   #42
[    0.001000] masked ExtINT on CPU#42
[    0.563509] .... node  #1, CPUs:   #43
[    0.001000] masked ExtINT on CPU#43
[    0.574086] .... node  #0, CPUs:   #44
[    0.001000] masked ExtINT on CPU#44
[    0.584242] .... node  #1, CPUs:   #45
[    0.001000] masked ExtINT on CPU#45
[    0.594534] .... node  #0, CPUs:   #46
[    0.001000] masked ExtINT on CPU#46
[    0.605494] .... node  #1, CPUs:   #47
[    0.001000] masked ExtINT on CPU#47
[    0.616076] .... node  #0, CPUs:   #48
[    0.001000] masked ExtINT on CPU#48
[    0.626338] .... node  #1, CPUs:   #49
[    0.001000] masked ExtINT on CPU#49
[    0.636645] .... node  #0, CPUs:   #50
[    0.001000] masked ExtINT on CPU#50
[    0.647140] .... node  #1, CPUs:   #51
[    0.001000] masked ExtINT on CPU#51
[    0.657606] .... node  #0, CPUs:   #52
[    0.001000] masked ExtINT on CPU#52
[    0.668141] .... node  #1, CPUs:   #53
[    0.001000] masked ExtINT on CPU#53
[    0.678608] .... node  #0, CPUs:   #54
[    0.001000] masked ExtINT on CPU#54
[    0.689141] .... node  #1, CPUs:   #55
[    0.001000] masked ExtINT on CPU#55
[    0.699619] smp: Brought up 2 nodes, 56 CPUs
[    0.700003] smpboot: Max logical packages: 2
[    0.701002] smpboot: Total of 56 processors activated (258374.42 BogoMIP=
S)
[    0.706672] devtmpfs: initialized
[    0.707066] x86/mm: Memory block size: 2048MB
[    0.709086] Built 2 zonelists, mobility grouping on.  Total pages: 12247=
924
[    0.710001] Policy zone: Normal
[    0.711154] evm: security.selinux
[    0.712001] evm: security.ima
[    0.713001] evm: security.capability
[    0.714161] PM: Registering ACPI NVS region [mem 0x7af0b000-0x7b93afff] =
(10682368 bytes)
[    0.715319] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 1911260446275000 ns
[    0.716064] futex hash table entries: 16384 (order: 8, 1048576 bytes)
[    0.717461] pinctrl core: initialized pinctrl subsystem
[    0.718925] NET: Registered protocol family 16
[    0.719224] audit: initializing netlink subsys (disabled)
[    0.720030] audit: type=3D2000 audit(1523952220.720:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.729007] cpuidle: using governor menu
[    0.733364] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    0.742005] ACPI: bus type PCI registered
[    0.747004] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.754177] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000=
-0x8fffffff] (base 0x80000000)
[    0.765016] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
[    0.766014] PCI: Using configuration type 1 for base access
[    0.767018] PCI: Dell System detected, enabling pci=3Dbfsort.
[    0.768165] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    0.771649] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.772003] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.773253] ACPI: Added _OSI(Module Device)
[    0.774003] ACPI: Added _OSI(Processor Device)
[    0.775001] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.776007] ACPI: Added _OSI(Processor Aggregator Device)
[    0.777001] ACPI: Added _OSI(Linux-Dell-Video)
[    0.990622] ACPI: 4 ACPI AML tables successfully acquired and loaded
[    1.013160] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    1.032854] ACPI: Interpreter enabled
[    1.033016] ACPI: (supports S0 S5)
[    1.034001] ACPI: Using IOAPIC for interrupt routing
[    1.035053] HEST: Table parsing has been initialized.
[    1.036003] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    1.037380] ACPI: Enabled 2 GPEs in block 00 to 3F
[    1.051735] ACPI: PCI Root Bridge [UNC1] (domain 0000 [bus ff])
[    1.052007] acpi PNP0A03:02: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI]
[    1.053139] acpi PNP0A03:02: PCIe AER handled by firmware
[    1.054253] acpi PNP0A03:02: _OSC: OS now controls [PCIeHotplug PME PCIe=
Capability]
[    1.055002] acpi PNP0A03:02: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    1.056045] PCI host bridge to bus 0000:ff
[    1.057003] pci_bus 0000:ff: root bus resource [bus ff]
[    1.058012] pci 0000:ff:08.0: [8086:2f80] type 00 class 0x088000
[    1.059061] pci 0000:ff:08.2: [8086:2f32] type 00 class 0x110100
[    1.060050] pci 0000:ff:08.3: [8086:2f83] type 00 class 0x088000
[    1.061052] pci 0000:ff:09.0: [8086:2f90] type 00 class 0x088000
[    1.062046] pci 0000:ff:09.2: [8086:2f33] type 00 class 0x110100
[    1.063046] pci 0000:ff:09.3: [8086:2f93] type 00 class 0x088000
[    1.064051] pci 0000:ff:0b.0: [8086:2f81] type 00 class 0x088000
[    1.065044] pci 0000:ff:0b.1: [8086:2f36] type 00 class 0x110100
[    1.066044] pci 0000:ff:0b.2: [8086:2f37] type 00 class 0x110100
[    1.067046] pci 0000:ff:0c.0: [8086:2fe0] type 00 class 0x088000
[    1.068044] pci 0000:ff:0c.1: [8086:2fe1] type 00 class 0x088000
[    1.069050] pci 0000:ff:0c.2: [8086:2fe2] type 00 class 0x088000
[    1.070047] pci 0000:ff:0c.3: [8086:2fe3] type 00 class 0x088000
[    1.071044] pci 0000:ff:0c.4: [8086:2fe4] type 00 class 0x088000
[    1.072046] pci 0000:ff:0c.5: [8086:2fe5] type 00 class 0x088000
[    1.073044] pci 0000:ff:0c.6: [8086:2fe6] type 00 class 0x088000
[    1.074044] pci 0000:ff:0c.7: [8086:2fe7] type 00 class 0x088000
[    1.075045] pci 0000:ff:0d.0: [8086:2fe8] type 00 class 0x088000
[    1.076045] pci 0000:ff:0d.1: [8086:2fe9] type 00 class 0x088000
[    1.077044] pci 0000:ff:0d.2: [8086:2fea] type 00 class 0x088000
[    1.078044] pci 0000:ff:0d.3: [8086:2feb] type 00 class 0x088000
[    1.079044] pci 0000:ff:0d.4: [8086:2fec] type 00 class 0x088000
[    1.080044] pci 0000:ff:0d.5: [8086:2fed] type 00 class 0x088000
[    1.081047] pci 0000:ff:0f.0: [8086:2ff8] type 00 class 0x088000
[    1.082043] pci 0000:ff:0f.1: [8086:2ff9] type 00 class 0x088000
[    1.083044] pci 0000:ff:0f.2: [8086:2ffa] type 00 class 0x088000
[    1.084044] pci 0000:ff:0f.3: [8086:2ffb] type 00 class 0x088000
[    1.085045] pci 0000:ff:0f.4: [8086:2ffc] type 00 class 0x088000
[    1.086044] pci 0000:ff:0f.5: [8086:2ffd] type 00 class 0x088000
[    1.087044] pci 0000:ff:0f.6: [8086:2ffe] type 00 class 0x088000
[    1.088050] pci 0000:ff:10.0: [8086:2f1d] type 00 class 0x088000
[    1.089045] pci 0000:ff:10.1: [8086:2f34] type 00 class 0x110100
[    1.090048] pci 0000:ff:10.5: [8086:2f1e] type 00 class 0x088000
[    1.091044] pci 0000:ff:10.6: [8086:2f7d] type 00 class 0x110100
[    1.092044] pci 0000:ff:10.7: [8086:2f1f] type 00 class 0x088000
[    1.093045] pci 0000:ff:12.0: [8086:2fa0] type 00 class 0x088000
[    1.094046] pci 0000:ff:12.1: [8086:2f30] type 00 class 0x110100
[    1.095048] pci 0000:ff:12.2: [8086:2f70] type 00 class 0x088000
[    1.096046] pci 0000:ff:12.4: [8086:2f60] type 00 class 0x088000
[    1.097048] pci 0000:ff:12.5: [8086:2f38] type 00 class 0x110100
[    1.098046] pci 0000:ff:12.6: [8086:2f78] type 00 class 0x088000
[    1.099048] pci 0000:ff:13.0: [8086:2fa8] type 00 class 0x088000
[    1.100051] pci 0000:ff:13.1: [8086:2f71] type 00 class 0x088000
[    1.101050] pci 0000:ff:13.2: [8086:2faa] type 00 class 0x088000
[    1.102049] pci 0000:ff:13.3: [8086:2fab] type 00 class 0x088000
[    1.103051] pci 0000:ff:13.6: [8086:2fae] type 00 class 0x088000
[    1.104046] pci 0000:ff:13.7: [8086:2faf] type 00 class 0x088000
[    1.105047] pci 0000:ff:14.0: [8086:2fb0] type 00 class 0x088000
[    1.106050] pci 0000:ff:14.1: [8086:2fb1] type 00 class 0x088000
[    1.107049] pci 0000:ff:14.2: [8086:2fb2] type 00 class 0x088000
[    1.108050] pci 0000:ff:14.3: [8086:2fb3] type 00 class 0x088000
[    1.109050] pci 0000:ff:14.4: [8086:2fbc] type 00 class 0x088000
[    1.110046] pci 0000:ff:14.5: [8086:2fbd] type 00 class 0x088000
[    1.111047] pci 0000:ff:14.6: [8086:2fbe] type 00 class 0x088000
[    1.112046] pci 0000:ff:14.7: [8086:2fbf] type 00 class 0x088000
[    1.113048] pci 0000:ff:16.0: [8086:2f68] type 00 class 0x088000
[    1.114050] pci 0000:ff:16.1: [8086:2f79] type 00 class 0x088000
[    1.115051] pci 0000:ff:16.2: [8086:2f6a] type 00 class 0x088000
[    1.116051] pci 0000:ff:16.3: [8086:2f6b] type 00 class 0x088000
[    1.117052] pci 0000:ff:16.6: [8086:2f6e] type 00 class 0x088000
[    1.118046] pci 0000:ff:16.7: [8086:2f6f] type 00 class 0x088000
[    1.119046] pci 0000:ff:17.0: [8086:2fd0] type 00 class 0x088000
[    1.120052] pci 0000:ff:17.1: [8086:2fd1] type 00 class 0x088000
[    1.121051] pci 0000:ff:17.2: [8086:2fd2] type 00 class 0x088000
[    1.122050] pci 0000:ff:17.3: [8086:2fd3] type 00 class 0x088000
[    1.123049] pci 0000:ff:17.4: [8086:2fb8] type 00 class 0x088000
[    1.124047] pci 0000:ff:17.5: [8086:2fb9] type 00 class 0x088000
[    1.125048] pci 0000:ff:17.6: [8086:2fba] type 00 class 0x088000
[    1.126046] pci 0000:ff:17.7: [8086:2fbb] type 00 class 0x088000
[    1.127057] pci 0000:ff:1e.0: [8086:2f98] type 00 class 0x088000
[    1.128045] pci 0000:ff:1e.1: [8086:2f99] type 00 class 0x088000
[    1.129046] pci 0000:ff:1e.2: [8086:2f9a] type 00 class 0x088000
[    1.130046] pci 0000:ff:1e.3: [8086:2fc0] type 00 class 0x088000
[    1.131034] pci 0000:ff:1e.4: [8086:2f9c] type 00 class 0x088000
[    1.132053] pci 0000:ff:1f.0: [8086:2f88] type 00 class 0x088000
[    1.133048] pci 0000:ff:1f.2: [8086:2f8a] type 00 class 0x088000
[    1.134135] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus 7f])
[    1.135005] acpi PNP0A03:03: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI]
[    1.136143] acpi PNP0A03:03: PCIe AER handled by firmware
[    1.137265] acpi PNP0A03:03: _OSC: OS now controls [PCIeHotplug PME PCIe=
Capability]
[    1.138002] acpi PNP0A03:03: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    1.139053] PCI host bridge to bus 0000:7f
[    1.140003] pci_bus 0000:7f: root bus resource [bus 7f]
[    1.141009] pci 0000:7f:08.0: [8086:2f80] type 00 class 0x088000
[    1.142055] pci 0000:7f:08.2: [8086:2f32] type 00 class 0x110100
[    1.143048] pci 0000:7f:08.3: [8086:2f83] type 00 class 0x088000
[    1.144051] pci 0000:7f:09.0: [8086:2f90] type 00 class 0x088000
[    1.145046] pci 0000:7f:09.2: [8086:2f33] type 00 class 0x110100
[    1.146047] pci 0000:7f:09.3: [8086:2f93] type 00 class 0x088000
[    1.147052] pci 0000:7f:0b.0: [8086:2f81] type 00 class 0x088000
[    1.148044] pci 0000:7f:0b.1: [8086:2f36] type 00 class 0x110100
[    1.149046] pci 0000:7f:0b.2: [8086:2f37] type 00 class 0x110100
[    1.150046] pci 0000:7f:0c.0: [8086:2fe0] type 00 class 0x088000
[    1.151045] pci 0000:7f:0c.1: [8086:2fe1] type 00 class 0x088000
[    1.152045] pci 0000:7f:0c.2: [8086:2fe2] type 00 class 0x088000
[    1.153044] pci 0000:7f:0c.3: [8086:2fe3] type 00 class 0x088000
[    1.154045] pci 0000:7f:0c.4: [8086:2fe4] type 00 class 0x088000
[    1.155045] pci 0000:7f:0c.5: [8086:2fe5] type 00 class 0x088000
[    1.156045] pci 0000:7f:0c.6: [8086:2fe6] type 00 class 0x088000
[    1.157047] pci 0000:7f:0c.7: [8086:2fe7] type 00 class 0x088000
[    1.158044] pci 0000:7f:0d.0: [8086:2fe8] type 00 class 0x088000
[    1.159044] pci 0000:7f:0d.1: [8086:2fe9] type 00 class 0x088000
[    1.160044] pci 0000:7f:0d.2: [8086:2fea] type 00 class 0x088000
[    1.161045] pci 0000:7f:0d.3: [8086:2feb] type 00 class 0x088000
[    1.162044] pci 0000:7f:0d.4: [8086:2fec] type 00 class 0x088000
[    1.163045] pci 0000:7f:0d.5: [8086:2fed] type 00 class 0x088000
[    1.164047] pci 0000:7f:0f.0: [8086:2ff8] type 00 class 0x088000
[    1.165044] pci 0000:7f:0f.1: [8086:2ff9] type 00 class 0x088000
[    1.166046] pci 0000:7f:0f.2: [8086:2ffa] type 00 class 0x088000
[    1.167045] pci 0000:7f:0f.3: [8086:2ffb] type 00 class 0x088000
[    1.168045] pci 0000:7f:0f.4: [8086:2ffc] type 00 class 0x088000
[    1.169045] pci 0000:7f:0f.5: [8086:2ffd] type 00 class 0x088000
[    1.170044] pci 0000:7f:0f.6: [8086:2ffe] type 00 class 0x088000
[    1.171047] pci 0000:7f:10.0: [8086:2f1d] type 00 class 0x088000
[    1.172044] pci 0000:7f:10.1: [8086:2f34] type 00 class 0x110100
[    1.173046] pci 0000:7f:10.5: [8086:2f1e] type 00 class 0x088000
[    1.174043] pci 0000:7f:10.6: [8086:2f7d] type 00 class 0x110100
[    1.175044] pci 0000:7f:10.7: [8086:2f1f] type 00 class 0x088000
[    1.176052] pci 0000:7f:12.0: [8086:2fa0] type 00 class 0x088000
[    1.177048] pci 0000:7f:12.1: [8086:2f30] type 00 class 0x110100
[    1.178046] pci 0000:7f:12.2: [8086:2f70] type 00 class 0x088000
[    1.179048] pci 0000:7f:12.4: [8086:2f60] type 00 class 0x088000
[    1.180047] pci 0000:7f:12.5: [8086:2f38] type 00 class 0x110100
[    1.181047] pci 0000:7f:12.6: [8086:2f78] type 00 class 0x088000
[    1.182047] pci 0000:7f:13.0: [8086:2fa8] type 00 class 0x088000
[    1.183049] pci 0000:7f:13.1: [8086:2f71] type 00 class 0x088000
[    1.184049] pci 0000:7f:13.2: [8086:2faa] type 00 class 0x088000
[    1.185050] pci 0000:7f:13.3: [8086:2fab] type 00 class 0x088000
[    1.186051] pci 0000:7f:13.6: [8086:2fae] type 00 class 0x088000
[    1.187047] pci 0000:7f:13.7: [8086:2faf] type 00 class 0x088000
[    1.188048] pci 0000:7f:14.0: [8086:2fb0] type 00 class 0x088000
[    1.189050] pci 0000:7f:14.1: [8086:2fb1] type 00 class 0x088000
[    1.190049] pci 0000:7f:14.2: [8086:2fb2] type 00 class 0x088000
[    1.191051] pci 0000:7f:14.3: [8086:2fb3] type 00 class 0x088000
[    1.192054] pci 0000:7f:14.4: [8086:2fbc] type 00 class 0x088000
[    1.193047] pci 0000:7f:14.5: [8086:2fbd] type 00 class 0x088000
[    1.194046] pci 0000:7f:14.6: [8086:2fbe] type 00 class 0x088000
[    1.195047] pci 0000:7f:14.7: [8086:2fbf] type 00 class 0x088000
[    1.196048] pci 0000:7f:16.0: [8086:2f68] type 00 class 0x088000
[    1.197050] pci 0000:7f:16.1: [8086:2f79] type 00 class 0x088000
[    1.198049] pci 0000:7f:16.2: [8086:2f6a] type 00 class 0x088000
[    1.199050] pci 0000:7f:16.3: [8086:2f6b] type 00 class 0x088000
[    1.200051] pci 0000:7f:16.6: [8086:2f6e] type 00 class 0x088000
[    1.201047] pci 0000:7f:16.7: [8086:2f6f] type 00 class 0x088000
[    1.202046] pci 0000:7f:17.0: [8086:2fd0] type 00 class 0x088000
[    1.203051] pci 0000:7f:17.1: [8086:2fd1] type 00 class 0x088000
[    1.204050] pci 0000:7f:17.2: [8086:2fd2] type 00 class 0x088000
[    1.205051] pci 0000:7f:17.3: [8086:2fd3] type 00 class 0x088000
[    1.206050] pci 0000:7f:17.4: [8086:2fb8] type 00 class 0x088000
[    1.207047] pci 0000:7f:17.5: [8086:2fb9] type 00 class 0x088000
[    1.208047] pci 0000:7f:17.6: [8086:2fba] type 00 class 0x088000
[    1.209046] pci 0000:7f:17.7: [8086:2fbb] type 00 class 0x088000
[    1.210057] pci 0000:7f:1e.0: [8086:2f98] type 00 class 0x088000
[    1.211047] pci 0000:7f:1e.1: [8086:2f99] type 00 class 0x088000
[    1.212046] pci 0000:7f:1e.2: [8086:2f9a] type 00 class 0x088000
[    1.213046] pci 0000:7f:1e.3: [8086:2fc0] type 00 class 0x088000
[    1.214035] pci 0000:7f:1e.4: [8086:2f9c] type 00 class 0x088000
[    1.215052] pci 0000:7f:1f.0: [8086:2f88] type 00 class 0x088000
[    1.216048] pci 0000:7f:1f.2: [8086:2f8a] type 00 class 0x088000
[    1.218472] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
[    1.219006] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI]
[    1.220132] acpi PNP0A08:00: PCIe AER handled by firmware
[    1.221256] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIe=
Capability]
[    1.222002] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    1.223245] PCI host bridge to bus 0000:00
[    1.224004] pci_bus 0000:00: root bus resource [io  0x0000-0x03bb window]
[    1.225002] pci_bus 0000:00: root bus resource [io  0x03bc-0x03df window]
[    1.226002] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    1.227002] pci_bus 0000:00: root bus resource [io  0x1000-0x7fff window]
[    1.228002] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    1.229002] pci_bus 0000:00: root bus resource [mem 0x90000000-0xc7ffbff=
f window]
[    1.230002] pci_bus 0000:00: root bus resource [mem 0x38000000000-0x3bff=
fffffff window]
[    1.231002] pci_bus 0000:00: root bus resource [bus 00-7e]
[    1.232008] pci 0000:00:00.0: [8086:2f00] type 00 class 0x060000
[    1.233171] pci 0000:00:01.0: [8086:2f02] type 01 class 0x060400
[    1.234100] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    1.235153] pci 0000:00:02.0: [8086:2f04] type 01 class 0x060400
[    1.236101] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    1.237143] pci 0000:00:03.0: [8086:2f08] type 01 class 0x060400
[    1.238097] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    1.239128] pci 0000:00:05.0: [8086:2f28] type 00 class 0x088000
[    1.240144] pci 0000:00:05.1: [8086:2f29] type 00 class 0x088000
[    1.241161] pci 0000:00:05.2: [8086:2f2a] type 00 class 0x088000
[    1.242143] pci 0000:00:05.4: [8086:2f2c] type 00 class 0x080020
[    1.243010] pci 0000:00:05.4: reg 0x10: [mem 0x92314000-0x92314fff]
[    1.244155] pci 0000:00:11.0: [8086:8d7c] type 00 class 0xff0000
[    1.245065] pci 0000:00:11.0: reg 0x30: [mem 0xffff0000-0xffffffff pref]
[    1.246170] pci 0000:00:11.4: [8086:8d62] type 00 class 0x010601
[    1.247020] pci 0000:00:11.4: reg 0x10: [io  0x3078-0x307f]
[    1.248008] pci 0000:00:11.4: reg 0x14: [io  0x308c-0x308f]
[    1.249008] pci 0000:00:11.4: reg 0x18: [io  0x3070-0x3077]
[    1.250008] pci 0000:00:11.4: reg 0x1c: [io  0x3088-0x308b]
[    1.251008] pci 0000:00:11.4: reg 0x20: [io  0x3040-0x305f]
[    1.252008] pci 0000:00:11.4: reg 0x24: [mem 0x92311000-0x923117ff]
[    1.253084] pci 0000:00:11.4: PME# supported from D3hot
[    1.254085] pci 0000:00:14.0: [8086:8d31] type 00 class 0x0c0330
[    1.255020] pci 0000:00:14.0: reg 0x10: [mem 0x92300000-0x9230ffff 64bit]
[    1.256095] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    1.257082] pci 0000:00:16.0: [8086:8d3a] type 00 class 0x078000
[    1.258021] pci 0000:00:16.0: reg 0x10: [mem 0x3bffff03000-0x3bffff0300f=
 64bit]
[    1.259102] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    1.260080] pci 0000:00:16.1: [8086:8d3b] type 00 class 0x078000
[    1.261021] pci 0000:00:16.1: reg 0x10: [mem 0x3bffff02000-0x3bffff0200f=
 64bit]
[    1.262102] pci 0000:00:16.1: PME# supported from D0 D3hot D3cold
[    1.263096] pci 0000:00:1a.0: [8086:8d2d] type 00 class 0x0c0320
[    1.264022] pci 0000:00:1a.0: reg 0x10: [mem 0x92313000-0x923133ff]
[    1.265124] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    1.266086] pci 0000:00:1c.0: [8086:8d10] type 01 class 0x060400
[    1.267121] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.268090] pci 0000:00:1c.4: [8086:8d18] type 01 class 0x060400
[    1.269126] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    1.270137] pci 0000:00:1c.7: [8086:8d1e] type 01 class 0x060400
[    1.271127] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
[    1.272096] pci 0000:00:1d.0: [8086:8d26] type 00 class 0x0c0320
[    1.273022] pci 0000:00:1d.0: reg 0x10: [mem 0x92312000-0x923123ff]
[    1.274125] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    1.275090] pci 0000:00:1f.0: [8086:8d44] type 00 class 0x060100
[    1.276222] pci 0000:00:1f.2: [8086:8d02] type 00 class 0x010601
[    1.277018] pci 0000:00:1f.2: reg 0x10: [io  0x3068-0x306f]
[    1.278007] pci 0000:00:1f.2: reg 0x14: [io  0x3084-0x3087]
[    1.279007] pci 0000:00:1f.2: reg 0x18: [io  0x3060-0x3067]
[    1.280007] pci 0000:00:1f.2: reg 0x1c: [io  0x3080-0x3083]
[    1.281007] pci 0000:00:1f.2: reg 0x20: [io  0x3020-0x303f]
[    1.282007] pci 0000:00:1f.2: reg 0x24: [mem 0x92310000-0x923107ff]
[    1.283079] pci 0000:00:1f.2: PME# supported from D3hot
[    1.284113] pci 0000:02:00.0: [1000:005d] type 00 class 0x010400
[    1.285013] pci 0000:02:00.0: reg 0x10: [io  0x2000-0x20ff]
[    1.286008] pci 0000:02:00.0: reg 0x14: [mem 0x92200000-0x9220ffff 64bit]
[    1.287007] pci 0000:02:00.0: reg 0x1c: [mem 0x92100000-0x921fffff 64bit]
[    1.288009] pci 0000:02:00.0: reg 0x30: [mem 0xfff00000-0xffffffff pref]
[    1.289102] pci 0000:02:00.0: supports D1 D2
[    1.290048] pci 0000:00:01.0: PCI bridge to [bus 02]
[    1.291003] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    1.292003] pci 0000:00:01.0:   bridge window [mem 0x92100000-0x922fffff]
[    1.293044] pci 0000:00:02.0: PCI bridge to [bus 03]
[    1.294143] pci 0000:01:00.0: [8086:1528] type 00 class 0x020000
[    1.295021] pci 0000:01:00.0: reg 0x10: [mem 0x91c00000-0x91dfffff 64bit=
 pref]
[    1.296020] pci 0000:01:00.0: reg 0x20: [mem 0x91e04000-0x91e07fff 64bit=
 pref]
[    1.297007] pci 0000:01:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    1.298101] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    1.299024] pci 0000:01:00.0: reg 0x184: [mem 0x92500000-0x92503fff 64bi=
t pref]
[    1.300002] pci 0000:01:00.0: VF(n) BAR0 space: [mem 0x92500000-0x925fff=
ff 64bit pref] (contains BAR0 for 64 VFs)
[    1.301012] pci 0000:01:00.0: reg 0x190: [mem 0x92600000-0x92603fff 64bi=
t pref]
[    1.302002] pci 0000:01:00.0: VF(n) BAR3 space: [mem 0x92600000-0x926fff=
ff 64bit pref] (contains BAR3 for 64 VFs)
[    1.303237] pci 0000:01:00.1: [8086:1528] type 00 class 0x020000
[    1.304021] pci 0000:01:00.1: reg 0x10: [mem 0x91a00000-0x91bfffff 64bit=
 pref]
[    1.305020] pci 0000:01:00.1: reg 0x20: [mem 0x91e00000-0x91e03fff 64bit=
 pref]
[    1.306007] pci 0000:01:00.1: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    1.307100] pci 0000:01:00.1: PME# supported from D0 D3hot D3cold
[    1.308021] pci 0000:01:00.1: reg 0x184: [mem 0x92700000-0x92703fff 64bi=
t pref]
[    1.309002] pci 0000:01:00.1: VF(n) BAR0 space: [mem 0x92700000-0x927fff=
ff 64bit pref] (contains BAR0 for 64 VFs)
[    1.310012] pci 0000:01:00.1: reg 0x190: [mem 0x92800000-0x92803fff 64bi=
t pref]
[    1.311002] pci 0000:01:00.1: VF(n) BAR3 space: [mem 0x92800000-0x928fff=
ff 64bit pref] (contains BAR3 for 64 VFs)
[    1.312244] pci 0000:00:03.0: PCI bridge to [bus 01]
[    1.313005] pci 0000:00:03.0:   bridge window [mem 0x92400000-0x928fffff]
[    1.314004] pci 0000:00:03.0:   bridge window [mem 0x91a00000-0x91efffff=
 64bit pref]
[    1.315038] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    1.316077] pci 0000:05:00.0: [8086:1521] type 00 class 0x020000
[    1.317031] pci 0000:05:00.0: reg 0x10: [mem 0x91f80000-0x91ffffff]
[    1.318030] pci 0000:05:00.0: reg 0x1c: [mem 0x92004000-0x92007fff]
[    1.319030] pci 0000:05:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    1.320153] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[    1.321137] pci 0000:05:00.1: [8086:1521] type 00 class 0x020000
[    1.322031] pci 0000:05:00.1: reg 0x10: [mem 0x91f00000-0x91f7ffff]
[    1.323031] pci 0000:05:00.1: reg 0x1c: [mem 0x92000000-0x92003fff]
[    1.324030] pci 0000:05:00.1: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    1.325150] pci 0000:05:00.1: PME# supported from D0 D3hot D3cold
[    1.326159] pci 0000:00:1c.4: PCI bridge to [bus 05]
[    1.327006] pci 0000:00:1c.4:   bridge window [mem 0x91f00000-0x920fffff]
[    1.328368] pci 0000:06:00.0: [1912:001d] type 01 class 0x060400
[    1.332630] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
[    1.334100] pci 0000:00:1c.7: PCI bridge to [bus 06-0a]
[    1.335005] pci 0000:00:1c.7:   bridge window [mem 0x91000000-0x919fffff]
[    1.336005] pci 0000:00:1c.7:   bridge window [mem 0x90000000-0x90ffffff=
 64bit pref]
[    1.338195] pci 0000:07:00.0: [1912:001d] type 01 class 0x060400
[    1.343196] pci 0000:07:00.0: PME# supported from D0 D3hot D3cold
[    1.346777] pci 0000:06:00.0: PCI bridge to [bus 07-0a]
[    1.347194] pci 0000:06:00.0:   bridge window [mem 0x91000000-0x919fffff]
[    1.348132] pci 0000:06:00.0:   bridge window [mem 0x90000000-0x90ffffff=
 64bit pref]
[    1.350274] pci 0000:08:00.0: [1912:001a] type 01 class 0x060400
[    1.356331] pci 0000:07:00.0: PCI bridge to [bus 08-09]
[    1.357232] pci 0000:07:00.0:   bridge window [mem 0x91000000-0x918fffff]
[    1.358155] pci 0000:07:00.0:   bridge window [mem 0x90000000-0x90ffffff=
 64bit pref]
[    1.360161] pci 0000:09:00.0: [102b:0534] type 00 class 0x030000
[    1.361639] pci 0000:09:00.0: reg 0x10: [mem 0x90000000-0x90ffffff pref]
[    1.362277] pci 0000:09:00.0: reg 0x14: [mem 0x91800000-0x91803fff]
[    1.363279] pci 0000:09:00.0: reg 0x18: [mem 0x91000000-0x917fffff]
[    1.368493] pci 0000:08:00.0: PCI bridge to [bus 09]
[    1.369234] pci 0000:08:00.0:   bridge window [mem 0x91000000-0x918fffff]
[    1.370152] pci 0000:08:00.0:   bridge window [mem 0x90000000-0x90ffffff=
 64bit pref]
[    1.371840] pci_bus 0000:00: on NUMA node 0
[    1.372267] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 1=
4 15) *0, disabled.
[    1.373070] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 1=
4 15) *0, disabled.
[    1.374075] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 1=
4 15) *0, disabled.
[    1.375068] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 1=
4 15) *0, disabled.
[    1.376067] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 1=
4 15) *0, disabled.
[    1.377066] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 1=
4 15) *0, disabled.
[    1.378066] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 1=
4 15) *0, disabled.
[    1.379066] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 1=
4 15) *0, disabled.
[    1.380343] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-fe])
[    1.381006] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI]
[    1.382134] acpi PNP0A08:01: PCIe AER handled by firmware
[    1.383253] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PCIe=
Capability]
[    1.384002] acpi PNP0A08:01: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    1.385185] PCI host bridge to bus 0000:80
[    1.386003] pci_bus 0000:80: root bus resource [io  0x8000-0xffff window]
[    1.387002] pci_bus 0000:80: root bus resource [mem 0xc8000000-0xfbffbff=
f window]
[    1.388002] pci_bus 0000:80: root bus resource [mem 0x3c000000000-0x3fff=
fffffff window]
[    1.389002] pci_bus 0000:80: root bus resource [bus 80-fe]
[    1.390010] pci 0000:80:01.0: [8086:2f02] type 01 class 0x060400
[    1.391107] pci 0000:80:01.0: PME# supported from D0 D3hot D3cold
[    1.392147] pci 0000:80:03.0: [8086:2f08] type 01 class 0x060400
[    1.393106] pci 0000:80:03.0: PME# supported from D0 D3hot D3cold
[    1.394143] pci 0000:80:05.0: [8086:2f28] type 00 class 0x088000
[    1.395134] pci 0000:80:05.1: [8086:2f29] type 00 class 0x088000
[    1.396150] pci 0000:80:05.2: [8086:2f2a] type 00 class 0x088000
[    1.397132] pci 0000:80:05.4: [8086:2f2c] type 00 class 0x080020
[    1.398011] pci 0000:80:05.4: reg 0x10: [mem 0xc8000000-0xc8000fff]
[    1.399169] pci 0000:80:01.0: PCI bridge to [bus 81]
[    1.400045] pci 0000:80:03.0: PCI bridge to [bus 82]
[    1.401015] pci_bus 0000:80: on NUMA node 1
[    1.402234] pci 0000:09:00.0: vgaarb: setting as boot VGA device
[    1.403000] pci 0000:09:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[    1.403004] pci 0000:09:00.0: vgaarb: bridge control possible
[    1.404001] vgaarb: loaded
[    1.405099] SCSI subsystem initialized
[    1.406023] ACPI: bus type USB registered
[    1.407014] usbcore: registered new interface driver usbfs
[    1.408009] usbcore: registered new interface driver hub
[    1.409140] usbcore: registered new device driver usb
[    1.410021] pps_core: LinuxPPS API ver. 1 registered
[    1.411001] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    1.412003] PTP clock support registered
[    1.413099] EDAC MC: Ver: 3.0.0
[    1.414612] PCI: Using ACPI for IRQ routing
[    1.421146] PCI: pci_cache_line_size set to 64 bytes
[    1.422468] e820: reserve RAM buffer [mem 0x0009c000-0x0009ffff]
[    1.423002] e820: reserve RAM buffer [mem 0x7a289000-0x7bffffff]
[    1.424001] e820: reserve RAM buffer [mem 0x7bae9000-0x7bffffff]
[    1.425001] e820: reserve RAM buffer [mem 0x7bb00000-0x7bffffff]
[    1.426241] NetLabel: Initializing
[    1.427001] NetLabel:  domain hash size =3D 128
[    1.428001] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    1.429016] NetLabel:  unlabeled traffic allowed by default
[    1.430166] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    1.431003] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    1.434103] clocksource: Switched to clocksource tsc-early
[    1.451681] VFS: Disk quotas dquot_6.6.0
[    1.456097] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    1.463858] pnp: PnP ACPI init
[    1.467844] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.475259] system 00:01: [io  0x0500-0x053f] has been reserved
[    1.481868] system 00:01: [io  0x0400-0x047f] could not be reserved
[    1.488856] system 00:01: [io  0x0540-0x057f] has been reserved
[    1.495462] system 00:01: [io  0x0600-0x061f] has been reserved
[    1.502068] system 00:01: [io  0x0ca0-0x0ca5] has been reserved
[    1.508674] system 00:01: [io  0x0880-0x0883] has been reserved
[    1.515281] system 00:01: [io  0x0800-0x081f] has been reserved
[    1.521888] system 00:01: [mem 0xfeda8000-0xfedcbfff] could not be reser=
ved
[    1.529660] system 00:01: [mem 0xff000000-0xffffffff] could not be reser=
ved
[    1.537431] system 00:01: [mem 0xfee00000-0xfeefffff] has been reserved
[    1.544813] system 00:01: [mem 0xfed12000-0xfed1200f] has been reserved
[    1.552197] system 00:01: [mem 0xfed12010-0xfed1201f] has been reserved
[    1.559578] system 00:01: [mem 0xfed1b000-0xfed1bfff] has been reserved
[    1.567597] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.575426] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.582937] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.590286] system 00:04: [io  0x0ca8] has been reserved
[    1.596218] system 00:04: [io  0x0cac] has been reserved
[    1.602150] system 00:04: Plug and Play ACPI device, IDs IPI0001 PNP0c01=
 (active)
[    1.610619] pnp: PnP ACPI: found 5 devices
[    1.621187] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    1.631100] pci 0000:02:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffff=
ff pref]: no compatible bridge window
[    1.642168] pci 0000:01:00.0: can't claim BAR 6 [mem 0xfff80000-0xffffff=
ff pref]: no compatible bridge window
[    1.653236] pci 0000:01:00.1: can't claim BAR 6 [mem 0xfff80000-0xffffff=
ff pref]: no compatible bridge window
[    1.664305] pci 0000:00:11.0: can't claim BAR 6 [mem 0xffff0000-0xffffff=
ff pref]: no compatible bridge window
[    1.675365] pci 0000:05:00.0: can't claim BAR 6 [mem 0xfff80000-0xffffff=
ff pref]: no compatible bridge window
[    1.686423] pci 0000:05:00.1: can't claim BAR 6 [mem 0xfff80000-0xffffff=
ff pref]: no compatible bridge window
[    1.698288] pci 0000:00:11.0: BAR 6: assigned [mem 0x92320000-0x9232ffff=
 pref]
[    1.706352] pci 0000:02:00.0: BAR 6: no space for [mem size 0x00100000 p=
ref]
[    1.714219] pci 0000:02:00.0: BAR 6: failed to assign [mem size 0x001000=
00 pref]
[    1.722474] pci 0000:00:01.0: PCI bridge to [bus 02]
[    1.728014] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    1.734816] pci 0000:00:01.0:   bridge window [mem 0x92100000-0x922fffff]
[    1.742387] pci 0000:00:02.0: PCI bridge to [bus 03]
[    1.747924] pci 0000:01:00.0: BAR 6: assigned [mem 0x92400000-0x9247ffff=
 pref]
[    1.755986] pci 0000:01:00.1: BAR 6: assigned [mem 0x92480000-0x924fffff=
 pref]
[    1.764050] pci 0000:00:03.0: PCI bridge to [bus 01]
[    1.769592] pci 0000:00:03.0:   bridge window [mem 0x92400000-0x928fffff]
[    1.777171] pci 0000:00:03.0:   bridge window [mem 0x91a00000-0x91efffff=
 64bit pref]
[    1.785817] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    1.791378] pci 0000:05:00.0: BAR 6: assigned [mem 0x92080000-0x920fffff=
 pref]
[    1.799448] pci 0000:05:00.1: BAR 6: no space for [mem size 0x00080000 p=
ref]
[    1.807318] pci 0000:05:00.1: BAR 6: failed to assign [mem size 0x000800=
00 pref]
[    1.815567] pci 0000:00:1c.4: PCI bridge to [bus 05]
[    1.821112] pci 0000:00:1c.4:   bridge window [mem 0x91f00000-0x920fffff]
[    1.828698] pci 0000:08:00.0: PCI bridge to [bus 09]
[    1.834388] pci 0000:08:00.0:   bridge window [mem 0x91000000-0x918fffff]
[    1.842062] pci 0000:08:00.0:   bridge window [mem 0x90000000-0x90ffffff=
 64bit pref]
[    1.850899] pci 0000:07:00.0: PCI bridge to [bus 08-09]
[    1.856878] pci 0000:07:00.0:   bridge window [mem 0x91000000-0x918fffff]
[    1.864552] pci 0000:07:00.0:   bridge window [mem 0x90000000-0x90ffffff=
 64bit pref]
[    1.873388] pci 0000:06:00.0: PCI bridge to [bus 07-0a]
[    1.879341] pci 0000:06:00.0:   bridge window [mem 0x91000000-0x919fffff]
[    1.887005] pci 0000:06:00.0:   bridge window [mem 0x90000000-0x90ffffff=
 64bit pref]
[    1.895871] pci 0000:00:1c.7: PCI bridge to [bus 06-0a]
[    1.901707] pci 0000:00:1c.7:   bridge window [mem 0x91000000-0x919fffff]
[    1.909288] pci 0000:00:1c.7:   bridge window [mem 0x90000000-0x90ffffff=
 64bit pref]
[    1.917938] pci_bus 0000:00: resource 4 [io  0x0000-0x03bb window]
[    1.924837] pci_bus 0000:00: resource 5 [io  0x03bc-0x03df window]
[    1.931736] pci_bus 0000:00: resource 6 [io  0x03e0-0x0cf7 window]
[    1.938634] pci_bus 0000:00: resource 7 [io  0x1000-0x7fff window]
[    1.945535] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff windo=
w]
[    1.953209] pci_bus 0000:00: resource 9 [mem 0x90000000-0xc7ffbfff windo=
w]
[    1.960883] pci_bus 0000:00: resource 10 [mem 0x38000000000-0x3bffffffff=
f window]
[    1.969237] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
[    1.975457] pci_bus 0000:02: resource 1 [mem 0x92100000-0x922fffff]
[    1.982454] pci_bus 0000:01: resource 1 [mem 0x92400000-0x928fffff]
[    1.989443] pci_bus 0000:01: resource 2 [mem 0x91a00000-0x91efffff 64bit=
 pref]
[    1.997497] pci_bus 0000:05: resource 1 [mem 0x91f00000-0x920fffff]
[    2.004486] pci_bus 0000:06: resource 1 [mem 0x91000000-0x919fffff]
[    2.011483] pci_bus 0000:06: resource 2 [mem 0x90000000-0x90ffffff 64bit=
 pref]
[    2.019538] pci_bus 0000:07: resource 1 [mem 0x91000000-0x919fffff]
[    2.026534] pci_bus 0000:07: resource 2 [mem 0x90000000-0x90ffffff 64bit=
 pref]
[    2.034598] pci_bus 0000:08: resource 1 [mem 0x91000000-0x918fffff]
[    2.041595] pci_bus 0000:08: resource 2 [mem 0x90000000-0x90ffffff 64bit=
 pref]
[    2.049659] pci_bus 0000:09: resource 1 [mem 0x91000000-0x918fffff]
[    2.056655] pci_bus 0000:09: resource 2 [mem 0x90000000-0x90ffffff 64bit=
 pref]
[    2.065504] pci 0000:80:01.0: PCI bridge to [bus 81]
[    2.071054] pci 0000:80:03.0: PCI bridge to [bus 82]
[    2.076600] pci_bus 0000:80: resource 4 [io  0x8000-0xffff window]
[    2.083498] pci_bus 0000:80: resource 5 [mem 0xc8000000-0xfbffbfff windo=
w]
[    2.091171] pci_bus 0000:80: resource 6 [mem 0x3c000000000-0x3ffffffffff=
 window]
[    2.099520] NET: Registered protocol family 2
[    2.104707] tcp_listen_portaddr_hash hash table entries: 32768 (order: 7=
, 524288 bytes)
[    2.113857] TCP established hash table entries: 524288 (order: 10, 41943=
04 bytes)
[    2.122863] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    2.130485] TCP: Hash tables configured (established 524288 bind 65536)
[    2.138033] UDP hash table entries: 32768 (order: 8, 1048576 bytes)
[    2.145205] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes)
[    2.153072] NET: Registered protocol family 1
[    2.158163] RPC: Registered named UNIX socket transport module.
[    2.164773] RPC: Registered udp transport module.
[    2.170021] RPC: Registered tcp transport module.
[    2.175272] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.182606] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT=
:1)
[    2.197657] IOAPIC[0]: Set routing entry (8-19 -> 0xef -> IRQ 19 Mode:1 =
Active:1 Dest:0)
[    2.206803] pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x6a0 took 237=
53 usecs
[    2.215161] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT=
:1)
[    2.230208] IOAPIC[0]: Set routing entry (8-18 -> 0xef -> IRQ 18 Mode:1 =
Active:1 Dest:0)
[    2.239328] pci 0000:00:1a.0: quirk_usb_early_handoff+0x0/0x6a0 took 236=
84 usecs
[    2.247671] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT=
:1)
[    2.262717] IOAPIC[0]: Set routing entry (8-18 -> 0xef -> IRQ 18 Mode:1 =
Active:1 Dest:0)
[    2.271835] pci 0000:00:1d.0: quirk_usb_early_handoff+0x0/0x6a0 took 236=
71 usecs
[    2.280101] pci 0000:02:00.0: [Firmware Bug]: disabling VPD access (can'=
t determine size of non-standard VPD format)
[    2.291852] pci 0000:02:00.0: quirk_blacklist_vpd+0x0/0x30 took 11470 us=
ecs
[    2.299971] pci 0000:09:00.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    2.309512] PCI: CLS 32 bytes, default 64
[    2.314038] Unpacking initramfs...
[    8.259938] Freeing initrd memory: 349004K
[    8.264645] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    8.271835] software IO TLB [mem 0x76289000-0x7a289000] (64MB) mapped at=
 [000000001533e143-00000000979a4d39]
[    8.283575] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360=
 ms ovfl timer
[    8.292416] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    8.298829] RAPL PMU: hw unit of domain package 2^-14 Joules
[    8.305144] RAPL PMU: hw unit of domain dram 2^-16 Joules
[    8.322079] Initialise system trusted keyrings
[    8.327111] workingset: timestamp_bits=3D36 max_order=3D24 bucket_order=
=3D0
[    8.335524] zbud: loaded
[    8.339196] 9p: Installing v9fs 9p2000 file system support
[    8.345342] pstore: using deflate compression
[    8.350270] SELinux:  Registering netfilter hooks
[    8.358090] NET: Registered protocol family 38
[    8.363052] Key type asymmetric registered
[    8.367624] Asymmetric key parser 'x509' registered
[    8.373099] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 247)
[    8.381472] io scheduler noop registered
[    8.385848] io scheduler deadline registered (default)
[    8.391632] io scheduler cfq registered
[    8.395912] io scheduler mq-deadline registered (default)
[    8.401936] io scheduler kyber registered
[    8.406873] atomic64_test: passed for x86-64 platform with CX8 and with =
SSE
[    8.415096] IOAPIC[9]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:002C SQ:0 SVT=
:1)
[    8.430161] IOAPIC[1]: Set routing entry (9-23 -> 0xef -> IRQ 24 Mode:1 =
Active:1 Dest:0)
[    8.440190] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT=
:1)
[    8.455250] IOAPIC[0]: Set routing entry (8-16 -> 0xef -> IRQ 16 Mode:1 =
Active:1 Dest:0)
[    8.464824] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT=
:1)
[    8.479892] IOAPIC[0]: Set routing entry (8-19 -> 0xef -> IRQ 19 Mode:1 =
Active:1 Dest:0)
[    8.491752] IOAPIC[10]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:=
1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:802C SQ:0 SV=
T:1)
[    8.506916] IOAPIC[2]: Set routing entry (10-23 -> 0xef -> IRQ 31 Mode:1=
 Active:1 Dest:0)
[    8.516571] pcieport 0000:00:01.0: Signaling PME with IRQ 25
[    8.522914] pcieport 0000:00:02.0: Signaling PME with IRQ 26
[    8.529251] pcieport 0000:00:03.0: Signaling PME with IRQ 27
[    8.535583] pcieport 0000:00:1c.0: Signaling PME with IRQ 28
[    8.541917] pcieport 0000:00:1c.4: Signaling PME with IRQ 29
[    8.548250] pcieport 0000:00:1c.7: Signaling PME with IRQ 30
[    8.554599] pcieport 0000:80:01.0: Signaling PME with IRQ 32
[    8.560936] pcieport 0000:80:03.0: Signaling PME with IRQ 33
[    8.568177] intel_idle: MWAIT substates: 0x2120
[    8.573233] intel_idle: v0.4.1 model 0x3F
[    8.580802] intel_idle: lapic_timer_reliable_states 0xffffffff
[    8.587506] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input0
[    8.595798] ACPI: Power Button [PWRF]
[    8.602898] ERST: Error Record Serialization Table (ERST) support is ini=
tialized.
[    8.611344] pstore: Registered erst as persistent store backend
[    8.618803] GHES: APEI firmware first mode is enabled by APEI bit and WH=
EA _OSC.
[    8.627234] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    8.654766] 00:02: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[    8.683532] 00:03: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115200) =
is a 16550A
[    8.692228] Non-volatile memory driver v1.3
[    8.696968] Linux agpgart interface v0.103
[    8.709572] mei_me 0000:00:16.0: Device doesn't have valid ME Interface
[    8.717059] lpc_ich 0000:00:1f.0: No MFD cells added
[    8.722716] rdac: device handler registered
[    8.727509] hp_sw: device handler registered
[    8.732274] emc: device handler registered
[    8.736966] alua: device handler registered
[    8.741636] MACsec IEEE 802.1AE
[    8.745188] libphy: Fixed MDIO Bus: probed
[    8.749856] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-=
NAPI
[    8.757723] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    8.764170] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    8.770678] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    8.777331] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.=
0-k
[    8.785092] igb: Copyright (c) 2007-2014 Intel Corporation.
[    8.855506] igb 0000:05:00.0: added PHC on eth0
[    8.860576] igb 0000:05:00.0: Intel(R) Gigabit Ethernet Network Connecti=
on
[    8.868258] igb 0000:05:00.0: eth0: (PCIe:5.0Gb/s:Width x2) ec:f4:bb:cb:=
54:94
[    8.876548] igb 0000:05:00.0: eth0: PBA No: G59298-000
[    8.882288] igb 0000:05:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 t=
x queue(s)
[    8.890916] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:F0FF SQ:0 SVT=
:1)
[    8.905976] IOAPIC[0]: Set routing entry (8-18 -> 0xef -> IRQ 18 Mode:1 =
Active:1 Dest:0)
[    8.979252] igb 0000:05:00.1: added PHC on eth1
[    8.984321] igb 0000:05:00.1: Intel(R) Gigabit Ethernet Network Connecti=
on
[    8.991991] igb 0000:05:00.1: eth1: (PCIe:5.0Gb/s:Width x2) ec:f4:bb:cb:=
54:95
[    9.000241] igb 0000:05:00.1: eth1: PBA No: G59298-000
[    9.005981] igb 0000:05:00.1: Using MSI-X interrupts. 8 rx queue(s), 8 t=
x queue(s)
[    9.014525] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - vers=
ion 5.1.0-k
[    9.023084] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    9.029772] IOAPIC[9]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:002C SQ:0 SVT=
:1)
[    9.044839] IOAPIC[1]: Set routing entry (9-16 -> 0xef -> IRQ 52 Mode:1 =
Active:1 Dest:0)
[    9.333513] ixgbe 0000:01:00.0: Multiqueue Enabled: Rx Queue count =3D 5=
6, Tx Queue count =3D 56 XDP Queue count =3D 0
[    9.375075] tsc: Refined TSC clocksource calibration: 2299.997 MHz
[    9.382032] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x212=
73273464, max_idle_ns: 440795276752 ns
[    9.393381] clocksource: Switched to clocksource tsc
[    9.429805] ixgbe 0000:01:00.0: PCI Express bandwidth of 32GT/s available
[    9.437399] ixgbe 0000:01:00.0: (Speed:5.0GT/s, Width: x8, Encoding Loss=
:20%)
[    9.542368] ixgbe 0000:01:00.0: MAC: 3, PHY: 0, PBA No: G59298-000
[    9.549282] ixgbe 0000:01:00.0: ec:f4:bb:cb:54:90
[    9.714884] ixgbe 0000:01:00.0: Intel(R) 10 Gigabit Network Connection
[    9.722417] IOAPIC[9]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:002C SQ:0 SVT=
:1)
[    9.737478] IOAPIC[1]: Set routing entry (9-20 -> 0xef -> IRQ 112 Mode:1=
 Active:1 Dest:0)
[   10.018122] ixgbe 0000:01:00.1: Multiqueue Enabled: Rx Queue count =3D 5=
6, Tx Queue count =3D 56 XDP Queue count =3D 0
[   10.114357] ixgbe 0000:01:00.1: PCI Express bandwidth of 32GT/s available
[   10.121952] ixgbe 0000:01:00.1: (Speed:5.0GT/s, Width: x8, Encoding Loss=
:20%)
[   10.226887] ixgbe 0000:01:00.1: MAC: 3, PHY: 0, PBA No: G59298-000
[   10.233801] ixgbe 0000:01:00.1: ec:f4:bb:cb:54:92
[   10.388027] ixgbe 0000:01:00.1: Intel(R) 10 Gigabit Network Connection
[   10.395614] usbcore: registered new interface driver catc
[   10.401674] usbcore: registered new interface driver kaweth
[   10.407900] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Etherne=
t driver
[   10.416178] usbcore: registered new interface driver pegasus
[   10.422505] usbcore: registered new interface driver rtl8150
[   10.428836] usbcore: registered new interface driver asix
[   10.434875] usbcore: registered new interface driver cdc_ether
[   10.441396] usbcore: registered new interface driver cdc_eem
[   10.447715] usbcore: registered new interface driver dm9601
[   10.453950] usbcore: registered new interface driver smsc75xx
[   10.460378] usbcore: registered new interface driver smsc95xx
[   10.466803] usbcore: registered new interface driver gl620a
[   10.473033] usbcore: registered new interface driver net1080
[   10.479361] usbcore: registered new interface driver plusb
[   10.485496] usbcore: registered new interface driver rndis_host
[   10.492114] usbcore: registered new interface driver cdc_subset
[   10.498731] usbcore: registered new interface driver zaurus
[   10.504963] usbcore: registered new interface driver MOSCHIP usb-etherne=
t driver
[   10.513233] usbcore: registered new interface driver int51x1
[   10.519559] usbcore: registered new interface driver ipheth
[   10.525784] usbcore: registered new interface driver sierra_net
[   10.532569] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   10.539867] ehci-pci: EHCI PCI platform driver
[   10.545166] ehci-pci 0000:00:1a.0: EHCI Host Controller
[   10.551130] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus =
number 1
[   10.559409] ehci-pci 0000:00:1a.0: debug port 2
[   10.569954] ehci-pci 0000:00:1a.0: cache line size of 32 is not supported
[   10.577564] ehci-pci 0000:00:1a.0: irq 18, io mem 0x92313000
[   10.590067] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[   10.596568] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 4.17
[   10.605803] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   10.613872] usb usb1: Product: EHCI Host Controller
[   10.619319] usb usb1: Manufacturer: Linux 4.17.0-rc1 ehci_hcd
[   10.625739] usb usb1: SerialNumber: 0000:00:1a.0
[   10.631135] hub 1-0:1.0: USB hub found
[   10.635337] hub 1-0:1.0: 2 ports detected
[   10.640396] ehci-pci 0000:00:1d.0: EHCI Host Controller
[   10.646344] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus =
number 2
[   10.654623] ehci-pci 0000:00:1d.0: debug port 2
[   10.663947] ehci-pci 0000:00:1d.0: cache line size of 32 is not supported
[   10.671538] ehci-pci 0000:00:1d.0: irq 18, io mem 0x92312000
[   10.684062] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[   10.690548] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 4.17
[   10.699782] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   10.707848] usb usb2: Product: EHCI Host Controller
[   10.713297] usb usb2: Manufacturer: Linux 4.17.0-rc1 ehci_hcd
[   10.719718] usb usb2: SerialNumber: 0000:00:1d.0
[   10.725113] hub 2-0:1.0: USB hub found
[   10.729320] hub 2-0:1.0: 2 ports detected
[   10.734179] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   10.741103] ohci-pci: OHCI PCI platform driver
[   10.746110] uhci_hcd: USB Universal Host Controller Interface driver
[   10.753535] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   10.759499] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 3
[   10.769291] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
00 quirks 0x00009810
[   10.778717] xhci_hcd 0000:00:14.0: cache line size of 32 is not supported
[   10.786440] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 4.17
[   10.795674] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   10.803742] usb usb3: Product: xHCI Host Controller
[   10.809188] usb usb3: Manufacturer: Linux 4.17.0-rc1 xhci-hcd
[   10.815605] usb usb3: SerialNumber: 0000:00:14.0
[   10.820977] hub 3-0:1.0: USB hub found
[   10.825190] hub 3-0:1.0: 15 ports detected
[   10.833177] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   10.839120] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 4
[   10.847390] xhci_hcd 0000:00:14.0: Host supports USB 3.0  SuperSpeed
[   10.854533] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 4.17
[   10.863765] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   10.871832] usb usb4: Product: xHCI Host Controller
[   10.877280] usb usb4: Manufacturer: Linux 4.17.0-rc1 xhci-hcd
[   10.883698] usb usb4: SerialNumber: 0000:00:14.0
[   10.889077] hub 4-0:1.0: USB hub found
[   10.893286] hub 4-0:1.0: 6 ports detected
[   10.899764] usbcore: registered new interface driver usbserial_generic
[   10.907080] usbserial: USB Serial support registered for generic
[   10.913817] i8042: PNP: No PS/2 controller found.
[   10.919176] mousedev: PS/2 mouse device common for all mice
[   10.925584] rtc_cmos 00:00: RTC can wake from S4
[   10.930996] rtc_cmos 00:00: registered as rtc0
[   10.935996] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram=
, hpet irqs
[   10.944683] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   10.950920] iTCO_vendor_support: vendor-support=3D0
[   10.956184] intel_pstate: Intel P-state driver initializing
[   10.965811] hidraw: raw HID events driver (C) Jiri Kosina
[   10.971990] usbcore: registered new interface driver usbhid
[   10.978220] usbhid: USB HID core driver
[   10.982740] drop_monitor: Initializing network drop monitor service
[   10.989851] Initializing XFRM netlink socket
[   10.994772] NET: Registered protocol family 10
[   11.000512] Segment Routing with IPv6
[   11.002058] usb 1-1: new high-speed USB device number 2 using ehci-pci
[   11.004624] NET: Registered protocol family 17
[   11.016980] 9pnet: Installing 9P2000 support
[   11.031707] intel_rdt: Intel RDT L3 monitoring detected
[   11.037603] microcode: sig=3D0x306f2, pf=3D0x1, revision=3D0x3c
[   11.045312] microcode: Microcode Update Driver: v2.2.
[   11.045354] ... APIC ID:      00000000 (0)
[   11.046351] ... APIC VERSION: 01060015
[   11.046351] 000000000000000000000000000000000000000000000000000000000000=
0000
[   11.046351] 000000000000000000000000000000000000000000000000000000002000=
1000
[   11.084180] number of MP IRQ sources: 15.
[   11.084554] usb 2-1: new high-speed USB device number 2 using ehci-pci
[   11.088662] number of IO-APIC #8 registers: 24.
[   11.101010] number of IO-APIC #9 registers: 24.
[   11.106073] number of IO-APIC #10 registers: 24.
[   11.111228] testing the IO APIC.......................
[   11.116972] IO APIC #8......
[   11.120189] .... register #00: 08000000
[   11.124474] .......    : physical APIC id: 08
[   11.129340] .......    : Delivery Type: 0
[   11.133816] .......    : LTS          : 0
[   11.138283] .... register #01: 00170020
[   11.142558] .......     : max redirection entries: 17
[   11.148200] .......     : PRQ implemented: 0
[   11.150434] usb 1-1: New USB device found, idVendor=3D8087, idProduct=3D=
800a, bcdDevice=3D 0.05
[   11.152971] .......     : IO APIC version: 20
[   11.152975] .... IRQ redirection table:
[   11.162120] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[   11.166983] IOAPIC 0:
[   11.171267] usb 3-8: new full-speed USB device number 2 using xhci_hcd
[   11.171854] hub 1-1:1.0: USB hub found
[   11.179250]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.181960] hub 1-1:1.0: 6 ports detected
[   11.189079]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.215234]  pin02, enabled , edge , high, V(02), IRR(0), S(0), remapped=
, I(0001),  Z(0)
[   11.224276]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.233028]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.238435] usb 2-1: New USB device found, idVendor=3D8087, idProduct=3D=
8002, bcdDevice=3D 0.05
[   11.241780]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.250916] usb 2-1: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[   11.259669]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.267858] hub 2-1:1.0: USB hub found
[   11.276380]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.280712] hub 2-1:1.0: 8 ports detected
[   11.289314]  pin08, enabled , edge , high, V(08), IRR(0), S(0), remapped=
, I(0007),  Z(0)
[   11.302827]  pin09, enabled , level, high, V(09), IRR(0), S(0), remapped=
, I(0008),  Z(0)
[   11.311869]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.311906] usb 3-8: New USB device found, idVendor=3D14dd, idProduct=3D=
1005, bcdDevice=3D 0.00
[   11.320619]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.320625]  pin0c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.329757] usb 3-8: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[   11.338507]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.347242] usb 3-8: Product: D2CIM-VUSB
[   11.347244] usb 3-8: Manufacturer: Raritan
[   11.347247] usb 3-8: SerialNumber: EFFB212D0A6E618
[   11.355220]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.371205] input: Raritan D2CIM-VUSB as /devices/pci0000:00/0000:00:14.=
0/usb3/3-8/3-8:1.0/0003:14DD:1005.0001/input/input1
[   11.372914]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.408181]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.416931]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.425681]  pin12, enabled , level, low , V(12), IRR(0), S(0), remapped=
, I(0021),  Z(0)
[   11.430319] hid-generic 0003:14DD:1005.0001: input,hidraw0: USB HID v1.1=
1 Keyboard [Raritan D2CIM-VUSB] on usb-0000:00:14.0-8/input0
[   11.434724]  pin13, enabled , level, low , V(13), IRR(0), S(0), remapped=
, I(0016),  Z(0)
[   11.457073]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.465823]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.474571]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.483321]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.492068] IO APIC #9......
[   11.495284] .... register #00: 09000000
[   11.499557] .......    : physical APIC id: 09
[   11.504422] .......    : Delivery Type: 0
[   11.508900] .......    : LTS          : 0
[   11.513377] .... register #01: 00170020
[   11.517659] .......     : max redirection entries: 17
[   11.523299] .......     : PRQ implemented: 0
[   11.528067] .......     : IO APIC version: 20
[   11.532933] .... register #02: 00000000
[   11.537216] .......     : arbitration: 00
[   11.541693] .... register #03: 00000001
[   11.545967] .......     : Boot DT    : 1
[   11.550346] .... IRQ redirection table:
[   11.554629] IOAPIC 1:
[   11.557170]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.562276] usb 3-12: new high-speed USB device number 3 using xhci_hcd
[   11.566916]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.583051]  pin02, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.591795]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.600538]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.609281]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.618027]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.626771]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.635516]  pin08, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.644258]  pin09, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.653005]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.661747]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.670491]  pin0c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.679234]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.687978]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.696721]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.700691] usb 3-12: New USB device found, idVendor=3D413c, idProduct=
=3Da001, bcdDevice=3D 0.00
[   11.705467]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.705471]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.714706] usb 3-12: New USB device strings: Mfr=3D1, Product=3D2, Seri=
alNumber=3D3
[   11.714708] usb 3-12: Product: Gadget USB HUB
[   11.714711] usb 3-12: Manufacturer: no manufacturer
[   11.714713] usb 3-12: SerialNumber: 0123456789
[   11.723458]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.732678] hub 3-12:1.0: USB hub found
[   11.740254]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.745253] hub 3-12:1.0: 6 ports detected
[   11.750566]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.790599]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.799341]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.808085]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.816830] IO APIC #10......
[   11.820140] .... register #00: 0A000000
[   11.824420] .......    : physical APIC id: 0A
[   11.829282] .......    : Delivery Type: 0
[   11.833756] .......    : LTS          : 0
[   11.838230] .... register #01: 00170020
[   11.842509] .......     : max redirection entries: 17
[   11.848146] .......     : PRQ implemented: 0
[   11.852910] .......     : IO APIC version: 20
[   11.857773] .... register #02: 00000000
[   11.862053] .......     : arbitration: 00
[   11.866525] .... register #03: 00000001
[   11.870805] .......     : Boot DT    : 1
[   11.875183] .... IRQ redirection table:
[   11.879463] IOAPIC 2:
[   11.882000]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.890745]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.899489]  pin02, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.908234]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.916977]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.925723]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.934466]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.943210]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.951953]  pin08, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.960696]  pin09, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.969441]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.978185]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.986929]  pin0c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.995672]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.004416]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.013159]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.021905]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.030650]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.039394]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.048138]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.056881]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.066583]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.075326]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.084069]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.092808] IRQ to pin mappings:
[   12.096407] IRQ0 -> 0:2
[   12.099136] IRQ1 -> 0:1
[   12.101864] IRQ3 -> 0:3
[   12.104591] IRQ4 -> 0:4
[   12.107319] IRQ5 -> 0:5
[   12.110048] IRQ6 -> 0:6
[   12.112777] IRQ7 -> 0:7
[   12.115505] IRQ8 -> 0:8
[   12.118233] IRQ9 -> 0:9
[   12.120959] IRQ10 -> 0:10
[   12.123881] IRQ11 -> 0:11
[   12.126803] IRQ12 -> 0:12
[   12.129726] IRQ13 -> 0:13
[   12.132649] IRQ14 -> 0:14
[   12.135571] IRQ15 -> 0:15
[   12.138494] IRQ16 -> 0:16
[   12.141418] IRQ18 -> 0:18
[   12.144332] IRQ19 -> 0:19
[   12.147254] IRQ24 -> 1:23
[   12.150178] IRQ31 -> 2:23
[   12.153101] IRQ52 -> 1:16
[   12.156023] IRQ112 -> 1:20
[   12.159044] .................................... done.
[   12.164800] sched_clock: Marking stable (12164785292, 0)->(14895092687, =
-2730307395)
[   12.174011] registered taskstats version 1
[   12.178583] Loading compiled-in X.509 certificates
[   12.184004] zswap: loaded using pool lzo/zbud
[   12.194069] Key type big_key registered
[   12.200647] Key type trusted registered
[   12.207152] Key type encrypted registered
[   12.211633] ima: No TPM chip found, activating TPM-bypass! (rc=3D-19)
[   12.218633] ima: Allocated hash algorithm: sha1
[   12.223705] evm: HMAC attrs: 0x1
[   12.229334] rtc_cmos 00:00: setting system clock to 2018-04-17 08:03:55 =
UTC (1523952235)
[   12.341031] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   12.451714] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[   12.707543] pps pps0: new PPS source ptp2
[   12.712027] ixgbe 0000:01:00.0: registered PHC device on eth2
[   12.861666] IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
[   13.110260] pps pps1: new PPS source ptp3
[   13.114754] ixgbe 0000:01:00.1: registered PHC device on eth3
[   13.256216] IPv6: ADDRCONF(NETDEV_UP): eth3: link is not ready
[   14.774040] ixgbe 0000:01:00.0 eth2: NIC Link is Up 100 Mbps, Flow Contr=
ol: RX/TX
[   14.783592] IPv6: ADDRCONF(NETDEV_CHANGE): eth2: link becomes ready
[   14.795052] Sending DHCP requests ., OK
[   14.805392] IP-Config: Got DHCP answer from 192.168.1.1, my address is 1=
92.168.1.99
[   14.813941] IP-Config: Complete:
[   14.817548]      device=3Deth2, hwaddr=3Dec:f4:bb:cb:54:90, ipaddr=3D192=
=2E168.1.99, mask=3D255.255.255.0, gw=3D192.168.1.1
[   14.828813]      host=3Dlkp-hsw-ep6, domain=3Dlkp.intel.com, nis-domain=
=3D(none)
[   14.836487]      bootserver=3D192.168.1.1, rootserver=3D192.168.1.1, roo=
tpath=3D     nameserver0=3D192.168.1.1
[   14.928782] ixgbe 0000:01:00.1: removed PHC on eth3
[   15.668207] Freeing unused kernel memory: 2384K
[   15.673264] Write protecting the kernel read-only data: 20480k
[   15.681272] Freeing unused kernel memory: 2012K
[   15.690849] Freeing unused kernel memory: 1976K
[   15.695907] rodata_test: all tests were successful
SELinux:  Could=20
[   15.704506] systemd[1]: RTC configured in localtime, applying delta of 4=
80 minutes to system time.
not open policy file <=3D /etc/selinux/targeted/policy/policy.31:  No such =
file or directory

         Starting Load Kernel Modules...
         Mounting POSIX Message Queue File System...
         Mounting Huge Pages File System...
         Mounting Debug File System...
         Starting Create list of required st... nodes for the current kerne=
l...
         Starting Journal Service...
         Mounting RPC Pipe File System...
         Starting Remount Root and Kernel File Systems...
[0m] Started Load Kernel Modules
[   15.935646] ipmi message handler version 39.2
[   15.936210] ACPI Error:=20
[   15.936352] libata version 3.00 loaded.
[   15.941346] nfit_test_iomap: loading out-of-tree module taints kernel.
[   15.956346] No handler for Region [SYSI] (000000005cfef337) [IPMI] (2018=
0313/evregion-132)
[   15.965586] ACPI Error: Region IPMI (ID=3D7) has no handler (20180313/ex=
fldio-265)
[   15.973864] ACPI Error: Method parse/execution failed \_SB.PMI0._GHL, AE=
_NOT_EXIST (20180313/psparse-516)
[   15.984563] ACPI Error: Method parse/execution failed \_SB.PMI0._PMC, AE=
_NOT_EXIST (20180313/psparse-516)
[   15.995260] ACPI Error: AE_NOT_EXIST, Evaluating _PMC (20180313/power_me=
ter-755)
=2E
[   16.006116] dcdbas dcdbas: Dell Systems Management Base Driver (version =
5.6.0-3.2)
reate list of re
[   16.023110] megasas: 07.704.04.00-rc1
quired sta...ce=20
[   16.028209] IOAPIC[9]: Set IRTE entry (P:1 FPD:0 Dst_Mode:0 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000000 SID:002C SQ:0 SVT=
:1)
nodes for the cu
[   16.044662] IOAPIC[1]: Set routing entry (9-2 -> 0xef -> IRQ 170 Mode:1 =
Active:1 Dest:0)
rrent kernel.
[
[   16.055388] megaraid_sas 0000:02:00.0: Waiting for FW to come to ready s=
tate
[   16.074739] megaraid_sas 0000:02:00.0: 64 bit DMA mask and 32 bit consis=
tent mask
ipe File System.
         Start
[   16.085338] megaraid_sas 0000:02:00.0: firmware supports msix	: (96)
[   16.093297] megaraid_sas 0000:02:00.0: current msix/online cpus	: (56/56)
[   16.100890] megaraid_sas 0000:02:00.0: RDPQ mode	: (disabled)
[   16.107328] megaraid_sas 0000:02:00.0: Current firmware supports maximum=
 commands: 928	 LDIO threshold: 0
ing Create Stati
[   16.118696] ipmi device interface
c Device Nodes in /dev...
    =20
[   16.124952] cryptd: max_cpu_qlen set to 1000
    Mounting Con
[   16.132106] IPMI System Interface driver.
figuration File=20
[   16.137205] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
System...
    =20
[   16.145836] ipmi_si: SMBIOS: io 0xca8 regsize 1 spacing 4 irq 10
    Starting App
[   16.154086] ipmi_si: Adding SMBIOS-specified kcs state machine
ly Kernel Variab
[   16.162282] ipmi_si: Trying SMBIOS-specified kcs state machine at i/o ad=
dress 0xca8, slave address 0x20, irq 10
les...
ted Remount Root
[   16.183217] AES CTR mode by8 optimization enabled
 and Kernel File
[   16.190438] ahci 0000:00:11.4: version 3.0
 Systems.
    =20
[   16.196427] ahci 0000:00:11.4: SSS flag set, parallel bus scan disabled
    Starting Loa
[   16.205128] ahci 0000:00:11.4: AHCI 0001.0300 32 slots 4 ports 6 Gbps 0x=
f impl SATA mode
d/Save Random Se
[   16.215657] ahci 0000:00:11.4: flags: 64bit ncq stag led clo pio slum pa=
rt ems apst=20
ed...
         Starting udev Coldplug all Devic
[   16.229284] nd_pmem namespace0.0: unable to guarantee persistence of wri=
tes
es...
[
[   16.243192] alloc_contig_range: [405b200, 405b2cb) PFNs busy
m] Started Create Static Device=20
[   16.262497] Error: Driver 'pcspkr' is already registered, aborting...
[   16.263830] scsi host1: ahci
Nodes in /dev.
         Starting Preprocess NFS configuration...
      =20
[   16.291339] megaraid_sas 0000:02:00.0: FW supports sync cache	: No
  Starting udev Kernel Device Manager...
[   16.325053] ipmi_si dmi-ipmi-si.0: The BMC does not support setting the =
recv irq bit, compensating, but the BMC needs to be fixed.
[   16.328403] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[   16.348802] [TTM] Initializing pool allocator
[   16.353678] megaraid_sas 0000:02:00.0: Init cmd return status SUCCESS fo=
r SCSI host 0
[   16.362437] [TTM] Initializing DMA pool allocator
] Reached target NFS client services.
[   16.384063] megaraid_sas 0000:02:00.0: firmware type	: Legacy(64 VD) fir=
mware
[   16.396259] megaraid_sas 0000:02:00.0: controller type	: MR(2048MB)
[   16.403260] megaraid_sas 0000:02:00.0: Online Controller Reset(OCR)	: En=
abled
[   16.403262] megaraid_sas 0000:02:00.0: Secure JBOD support	: No
[   16.403266] megaraid_sas 0000:02:00.0: NVMe passthru support	: No
ted Journal Serv
[   16.434501] ipmi_si dmi-ipmi-si.0: IPMI kcs interface initialized
ice.
         Starting Flush Journal to Persistent Storage...
         Starting Create Volatile Files and Directories...
         Starting RPC bind portmap service...
         Starting Network Time Synchronization...
         Starting Update UTMP about System Boot/Shutdown...
[   16.583109] mgag200 0000:09:00.0: VGA-1: EDID is invalid:
[   16.589140] 	[00] BAD  00 ff ff ff ff ff ff 00 ff ff ff ff ff ff ff ff
[   16.596427] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   16.603706] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   16.610993] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   16.618272] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   16.625549] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   16.632836] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   16.640125] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   16.649587] fbcon: mgadrmfb (fb0) is primary device
[   16.649649] Console: switching to colour frame buffer device 128x48
[   16.712846] megaraid_sas 0000:02:00.0: INIT adapter done
[   16.712850] megaraid_sas 0000:02:00.0: Jbod map is not supported megasas=
_setup_jbod_map 5132
[   16.744687] megaraid_sas 0000:02:00.0: pci id		: (0x1000)/(0x005d)/(0x10=
28)/(0x1f47)
[   16.744689] megaraid_sas 0000:02:00.0: unevenspan support	: yes
[   16.744690] megaraid_sas 0000:02:00.0: firmware crash dump	: no
[   16.744691] megaraid_sas 0000:02:00.0: jbod sync map		: no
[   16.744694] scsi host0: Avago SAS based MegaRAID driver
[   16.793982] mgag200 0000:09:00.0: fb0: mgadrmfb frame buffer device
[   16.888368] scsi host2: ahci
[   16.891811] scsi host3: ahci
[   16.895281] scsi host4: ahci
[   16.898569] ata1: SATA max UDMA/133 abar m2048@0x92311000 port 0x9231110=
0 irq 227
[   16.906975] ata2: SATA max UDMA/133 abar m2048@0x92311000 port 0x9231118=
0 irq 227
[   16.915348] ata3: SATA max UDMA/133 abar m2048@0x92311000 port 0x9231120=
0 irq 227
[   16.923728] ata4: SATA max UDMA/133 abar m2048@0x92311000 port 0x9231128=
0 irq 227
[   16.932158] scsi 0:2:0:0: Direct-Access     DELL     PERC H730P       4.=
24 PQ: 0 ANSI: 5
[   16.935737] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[   16.948735] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x=
3f impl SATA mode
[   16.957911] ahci 0000:00:1f.2: flags: 64bit ncq stag led clo pio slum pa=
rt ems apst=20
[   16.971115] [drm] Initialized mgag200 1.0.0 20110418 for 0000:09:00.0 on=
 minor 0
[   16.981945] EDAC sbridge: Seeking for: PCI ID 8086:2fa0
[   16.987833] EDAC sbridge: Seeking for: PCI ID 8086:2fa0
[   16.989562] scsi host5: ahci
[   16.994409] EDAC sbridge: Seeking for: PCI ID 8086:2fa0
[   16.998433] scsi host6: ahci
[   17.004861] EDAC sbridge: Seeking for: PCI ID 8086:2f60
[   17.008836] scsi host7: ahci
[   17.015275] EDAC sbridge: Seeking for: PCI ID 8086:2f60
[   17.019251] scsi host8: ahci
[   17.025671] EDAC sbridge: Seeking for: PCI ID 8086:2f60
[   17.029653] scsi host9: ahci
[   17.036044] EDAC sbridge: Seeking for: PCI ID 8086:2fa8
[   17.040035] scsi host10: ahci
[   17.046426] EDAC sbridge: Seeking for: PCI ID 8086:2fa8
[   17.046560] scsi 0:2:0:0: Attached scsi generic sg0 type 0
[   17.050398] ata5: SATA max UDMA/133 abar m2048@0x92310000 port 0x9231010=
0 irq 228
[   17.056892] EDAC sbridge: Seeking for: PCI ID 8086:2fa8
[   17.064266] ata6: SATA max UDMA/133 abar m2048@0x92310000 port 0x9231018=
0 irq 228
[   17.073696] EDAC sbridge: Seeking for: PCI ID 8086:2f71
[   17.080176] ata7: SATA max UDMA/133 abar m2048@0x92310000 port 0x9231020=
0 irq 228
[   17.089735] EDAC sbridge: Seeking for: PCI ID 8086:2f71
[   17.096208] ata8: SATA max UDMA/133 abar m2048@0x92310000 port 0x9231028=
0 irq 228
[   17.096212] ata9: SATA max UDMA/133 abar m2048@0x92310000 port 0x9231030=
0 irq 228
[   17.105832] EDAC sbridge: Seeking for: PCI ID 8086:2f71
[   17.112331] ata10: SATA max UDMA/133 abar m2048@0x92310000 port 0x923103=
80 irq 228
[   17.112891] sd 0:2:0:0: [sda] 7805599744 512-byte logical blocks: (4.00 =
TB/3.63 TiB)
[   17.122016] EDAC sbridge: Seeking for: PCI ID 8086:2faa
[   17.131646] sd 0:2:0:0: [sda] 4096-byte physical blocks
[   17.138842] EDAC sbridge: Seeking for: PCI ID 8086:2faa
[   17.148674] sd 0:2:0:0: [sda] Write Protect is off
[   17.158702] EDAC sbridge: Seeking for: PCI ID 8086:2faa
[   17.165862] sd 0:2:0:0: [sda] Mode Sense: 1f 00 00 08
[   17.165927] sd 0:2:0:0: [sda] Write cache: disabled, read cache: enabled=
, doesn't support DPO or FUA
[   17.173081] EDAC sbridge: Seeking for: PCI ID 8086:2fab
[   17.181270] sd 0:2:0:0: [sda] Attached SCSI disk
[   17.186981] EDAC sbridge: Seeking for: PCI ID 8086:2fab
[   17.233731] EDAC sbridge: Seeking for: PCI ID 8086:2fab
[   17.236582] ata1: SATA link down (SStatus 0 SControl 300)
[   17.240935] EDAC sbridge: Seeking for: PCI ID 8086:2fac
[   17.255636] EDAC sbridge: Seeking for: PCI ID 8086:2fad
[   17.262870] EDAC sbridge: Seeking for: PCI ID 8086:2f68
[   17.270096] EDAC sbridge: Seeking for: PCI ID 8086:2f68
[   17.277314] EDAC sbridge: Seeking for: PCI ID 8086:2f68
[   17.284473] EDAC sbridge: Seeking for: PCI ID 8086:2f79
[   17.291599] EDAC sbridge: Seeking for: PCI ID 8086:2f79
[   17.298704] EDAC sbridge: Seeking for: PCI ID 8086:2f79
[   17.305767] EDAC sbridge: Seeking for: PCI ID 8086:2f6a
[   17.312812] EDAC sbridge: Seeking for: PCI ID 8086:2f6a
[   17.318263] pmem0: detected capacity change from 0 to 111669149696
[   17.319802] EDAC sbridge: Seeking for: PCI ID 8086:2f6a
[   17.334309] nd_pmem namespace1.0: unable to guarantee persistence of wri=
tes
[   17.334310] EDAC sbridge: Seeking for: PCI ID 8086:2f6b
[   17.334321] EDAC sbridge: Seeking for: PCI ID 8086:2f6b
[   17.356717] EDAC sbridge: Seeking for: PCI ID 8086:2f6b
[   17.363695] EDAC sbridge: Seeking for: PCI ID 8086:2f6c
[   17.370660] EDAC sbridge: Seeking for: PCI ID 8086:2f6d
[   17.377610] EDAC sbridge: Seeking for: PCI ID 8086:2ffc
[   17.384530] EDAC sbridge: Seeking for: PCI ID 8086:2ffc
[   17.391427] EDAC sbridge: Seeking for: PCI ID 8086:2ffc
[   17.398302] EDAC sbridge: Seeking for: PCI ID 8086:2ffd
[   17.405157] EDAC sbridge: Seeking for: PCI ID 8086:2ffd
[   17.411996] EDAC sbridge: Seeking for: PCI ID 8086:2ffd
[   17.418808] EDAC sbridge: Seeking for: PCI ID 8086:2fbd
[   17.421591] ata5: SATA link down (SStatus 0 SControl 300)
[   17.425597] EDAC sbridge: Seeking for: PCI ID 8086:2fbd
[   17.439523] EDAC sbridge: Seeking for: PCI ID 8086:2fbd
[   17.446250] EDAC sbridge: Seeking for: PCI ID 8086:2fbf
[   17.452960] EDAC sbridge: Seeking for: PCI ID 8086:2fbf
[   17.459629] EDAC sbridge: Seeking for: PCI ID 8086:2fbf
[   17.466259] EDAC sbridge: Seeking for: PCI ID 8086:2fb9
[   17.472882] EDAC sbridge: Seeking for: PCI ID 8086:2fb9
[   17.479486] EDAC sbridge: Seeking for: PCI ID 8086:2fb9
[   17.486047] EDAC sbridge: Seeking for: PCI ID 8086:2fbb
[   17.492576] EDAC sbridge: Seeking for: PCI ID 8086:2fbb
[   17.499080] EDAC sbridge: Seeking for: PCI ID 8086:2fbb
[   17.505853] EDAC MC0: Giving out device to module sb_edac controller Has=
well SrcID#0_Ha#0: DEV 0000:7f:12.0 (INTERRUPT)
[   17.518863] EDAC MC1: Giving out device to module sb_edac controller Has=
well SrcID#1_Ha#0: DEV 0000:ff:12.0 (INTERRUPT)
[   17.531856] EDAC MC2: Giving out device to module sb_edac controller Has=
well SrcID#0_Ha#1: DEV 0000:7f:12.4 (INTERRUPT)
[   17.544824] EDAC MC3: Giving out device to module sb_edac controller Has=
well SrcID#1_Ha#1: DEV 0000:ff:12.4 (INTERRUPT)
[   17.556694] ata2: SATA link down (SStatus 0 SControl 300)
[   17.557515] EDAC sbridge:  Ver: 1.1.2=20
[   17.575194] intel_rapl: Found RAPL domain package
[   17.581213] intel_rapl: Found RAPL domain dram
[   17.586526] intel_rapl: DRAM domain energy unit 15300pj
[   17.592715] intel_rapl: RAPL package 0 domain package locked by BIOS
[   17.600248] intel_rapl: Found RAPL domain package
[   17.606238] intel_rapl: Found RAPL domain dram
[   17.611578] intel_rapl: DRAM domain energy unit 15300pj
[   17.617813] intel_rapl: RAPL package 1 domain package locked by BIOS
         Starting Login Service...
         Starting Permit User Sessions...
         Starting LKP bootstrap...
         Starting /etc/rc.local Compatibility...
[   17.733323] rc.local[744]: mkdir: cannot create directory '/var/lock/lkp=
-bootstrap.lock': File exists
LKP: HOSTNAME lkp-hsw-ep6, MAC ec:f4:bb:cb:54:90, kernel 4.17.0-rc1 1, seri=
al console /dev/ttyS0
         Starting OpenBSD Secure Shell server...
0m] Started Perm
[   17.795984]=20
it User Sessions.
[   17.876553] ata3: SATA link down (SStatus 0 SControl 300)
[   17.888939] install debs round one: dpkg -i --force-confdef --force-depe=
nds /opt/deb/debconf_1.5.66_all.deb
[   17.888941]=20
[   17.903647] /opt/deb/libtext-charwidth-perl_0.04-7.1_amd64.deb
[   17.903648]=20
[   17.913900] /opt/deb/libtext-iconv-perl_1.7-5+b6_amd64.deb
[   17.913901]=20
[   17.923516] /opt/deb/perl-base_5.26.1-5_amd64.deb
[   17.923518]=20
[   17.932623] /opt/deb/liblocale-gettext-perl_1.07-3+b3_amd64.deb
[   17.932625]=20
[   17.942938] /opt/deb/perl-modules-5.26_5.26.1-5_all.deb
[   17.942939]=20
[   17.952255] /opt/deb/mime-support_3.60_all.deb
[   17.952256]=20
[   17.960953] /opt/deb/libgdbm-compat4_1.14.1-6_amd64.deb
[   17.960954]=20
[   17.970491] /opt/deb/libperl5.26_5.26.1-5_amd64.deb
[   17.970492]=20
[   17.979597] /opt/deb/libssl1.1_1.1.0h-2_amd64.deb
[   17.979599]=20
[   17.988459] /opt/deb/sysstat_11.6.1-1_amd64.deb
[   17.988460]=20
[   17.997304] /opt/deb/gawk_1%3a4.1.4+dfsg-1_amd64.deb
[   17.997306]=20
[   18.006522] /opt/deb/sysstat_11.6.0-1_amd64.deb
[   18.006524]=20
[   18.016241] (Reading database ... 2202 files and directories currently i=
nstalled.)
[   18.016242]=20
[   18.029242] Preparing to unpack .../opt/deb/debconf_1.5.66_all.deb ...
[   18.029244]=20
[   18.040646] Unpacking debconf (1.5.66) over (1.5.59) ...
[   18.040647]=20
[   18.051393] Preparing to unpack .../libtext-charwidth-perl_0.04-7.1_amd6=
4.deb ...
[   18.051395]=20
[   18.065798] Unpacking libtext-charwidth-perl (0.04-7.1) over (0.04-7+b4)=
 ...
[   18.065799]=20
[   18.078841] Preparing to unpack .../libtext-iconv-perl_1.7-5+b6_amd64.de=
b ...
[   18.078842]=20
[   18.091826] Unpacking libtext-iconv-perl (1.7-5+b6) over (1.7-5+b3) ...
[   18.091827]=20
[   18.104404] Preparing to unpack .../perl-base_5.26.1-5_amd64.deb ...
[   18.104406]=20
[   18.106364] Unpacking perl-base (5.26.1-5) over (5.22.2-3) ...
[   18.106365]=20
[   18.188638] ata4: SATA link down (SStatus 0 SControl 300)
[   18.195643] Preparing to unpack .../liblocale-gettext-perl_1.07-3+b3_amd=
64.deb ...
[   18.195995]=20
[   18.209876] Unpacking liblocale-gettext-perl (1.07-3+b3) over (1.07-3) .=
=2E.
[   18.209877]=20
[   18.222180] Selecting previously unselected package perl-modules-5.26.
[   18.222182]=20
[   18.234198] Preparing to unpack .../perl-modules-5.26_5.26.1-5_all.deb .=
=2E.
[   18.234199]=20
[   18.246111] Unpacking perl-modules-5.26 (5.26.1-5) ...
[   18.246113]=20
[   18.500884] ata6: SATA link down (SStatus 0 SControl 300)
[   18.566484] Selecting previously unselected package mime-support.
[   18.566488]=20
[   18.578613] Preparing to unpack .../deb/mime-support_3.60_all.deb ...
[   18.578615]=20
[   18.589796] Unpacking mime-support (3.60) ...
[   18.589798]=20
[   18.599433] Selecting previously unselected package libgdbm-compat4:amd6=
4.
[   18.599434]=20
[   18.606536] pmem1: detected capacity change from 0 to 111669149696
[   18.609524] Preparing to unpack .../libgdbm-compat4_1.14.1-6_amd64.deb .=
=2E.
[   18.618006]=20
[   18.630095] Unpacking libgdbm-compat4:amd64 (1.14.1-6) ...
[   18.630097]=20
[   18.640988] Selecting previously unselected package libperl5.26:amd64.
[   18.640990]=20
[   18.653049] Preparing to unpack .../libperl5.26_5.26.1-5_amd64.deb ...
[   18.653051]=20
[   18.664716] Unpacking libperl5.26:amd64 (5.26.1-5) ...
[   18.664717]=20
[   18.812952] ata7: SATA link down (SStatus 0 SControl 300)
[   19.027921] Selecting previously unselected package libssl1.1:amd64.
[   19.027924]=20
[   19.039993] Preparing to unpack .../libssl1.1_1.1.0h-2_amd64.deb ...
[   19.039995]=20
[   19.051357] Unpacking libssl1.1:amd64 (1.1.0h-2) ...
[   19.051358]=20
[   19.124251] ata8: SATA link down (SStatus 0 SControl 300)
[   19.233790] Selecting previously unselected package sysstat.
[   19.233793]=20
[   19.245987] Preparing to unpack .../deb/sysstat_11.6.1-1_amd64.deb ...
[   19.245989]=20
[   19.257382] Unpacking sysstat (11.6.1-1) ...
[   19.257384]=20
[   19.286155] Preparing to unpack .../gawk_1%3a4.1.4+dfsg-1_amd64.deb ...
[   19.286158]=20
[   19.298759] Unpacking gawk (1:4.1.4+dfsg-1) over (1:4.1.1+dfsg-1) ...
[   19.298761]=20
[   19.357950] Preparing to unpack .../deb/sysstat_11.6.0-1_amd64.deb ...
[   19.357953]=20
[   19.360454] Unpacking sysstat (11.6.0-1) over (11.6.1-1) ...
[   19.360456]=20
[   19.443571] More than one copy of package sysstat has been unpacked
[   19.443574]=20
[   19.444960] ata9: SATA link down (SStatus 0 SControl 300)
[   19.453537]  in this run !  Only configuring it once.
[   19.460866]=20
[   19.470492] Setting up perl-base (5.26.1-5) ...
[   19.470493]=20
[   19.479934] Setting up liblocale-gettext-perl (1.07-3+b3) ...
[   19.479936]=20
[   19.490548] Setting up perl-modules-5.26 (5.26.1-5) ...
[   19.490549]=20
[   19.500417] Setting up mime-support (3.60) ...
[   19.500419]=20
[   19.509333] Setting up debconf (1.5.66) ...
[   19.509334]=20
[   19.608293] Setting up libtext-charwidth-perl (0.04-7.1) ...
[   19.608296]=20
[   19.619592] Setting up libtext-iconv-perl (1.7-5+b6) ...
[   19.619593]=20
[   19.629614] Setting up libssl1.1:amd64 (1.1.0h-2) ...
[   19.629616]=20
[   19.740616] Setting up libgdbm-compat4:amd64 (1.14.1-6) ...
[   19.740618]=20
[   19.751491] Setting up libperl5.26:amd64 (5.26.1-5) ...
[   19.751492]=20
[   19.761181] Setting up sysstat (11.6.0-1) ...
[   19.761183]=20
[   19.764884] ata10: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   19.780528] ata10.00: ATAPI: HL-DT-ST DVD-ROM DU90N, D300, max UDMA/100
[   19.792770] ata10.00: configured for UDMA/100
[   19.802901] scsi 10:0:0:0: CD-ROM            HL-DT-ST DVD-ROM DU90N    D=
300 PQ: 0 ANSI: 5
[   19.835493] scsi 10:0:0:0: Attached scsi generic sg1 type 5
[   19.870471] sr 10:0:0:0: [sr0] scsi3-mmc drive: 24x/24x cd/rw xa/form2 c=
dda tray
[   19.879516] cdrom: Uniform CD-ROM driver Revision: 3.20
[   19.886224] sr 10:0:0:0: Attached scsi CD-ROM sr0
[   19.997348] random: crng init done
[   20.339797] Setting up gawk (1:4.1.4+dfsg-1) ...
[   20.339801]=20
[   20.350037] Processing triggers for libc-bin (2.23-5) ...
[   20.350038]=20
[   20.360243] Processing triggers for systemd (231-5) ...
[   20.360245]=20
[   26.471033] 17 Apr 16:05:22 ntpdate[1104]: step time server 192.168.1.1 =
offset 28873.209604 sec
[   26.471036]=20
[   26.487870] /lkp/lkp/src/bin/run-lkp
[   26.487873]=20
0m] Reached targ
[   26.519760]=20
et Host and Network Name Lookups.
         Startin
[   26.552733] job=3D/lkp/scheduled/lkp-hsw-ep6/fio-basic-2pmem-btrfs-200s-=
50%-tb-randwrite-2M-libaio-100G-performance-debian-x86_64-2016-08-31.cgz-60=
cc43fc888428bb2f18f08997432d426a243338-20180417-83132-1vmen9v-2.yaml
g Notify NFS peers of a restart.
[   26.552735]=20
=2E.
[   26.583493] mount.nfs: try 1 time...
[   26.583496]=20
         Starting NFS status monitor for NFSv2/3 locking....
[   28.432257] run-job /lkp/scheduled/lkp-hsw-ep6/fio-basic-2pmem-btrfs-200=
s-50%-tb-randwrite-2M-libaio-100G-performance-debian-x86_64-2016-08-31.cgz-=
60cc43fc888428bb2f18f08997432d426a243338-20180417-83132-1vmen9v-2.yaml
[   28.432259]=20
[   28.500504] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin/lkp-jobfile-ap=
pend-var?job_file=3D/lkp/scheduled/lkp-hsw-ep6/fio-basic-2pmem-btrfs-200s-5=
0%25-tb-randwrite-2M-libaio-100G-performance-debian-x86_64-2016-08-31.cgz-6=
0cc43fc888428bb2f18f08997432d426a243338-20180417-83132-1vmen9v-2.yaml&job_s=
tate=3Drunning -o /dev/null
[   28.500506]=20
[   28.724377] microcode current_version: 0x3c, target_version: 0x3c
[   28.724380]=20
[   28.741425] 2018-04-17 16:05:25 modprobe nd_e820
[   28.741429]=20
[   29.764928] 2018-04-17 16:05:26 dmsetup remove_all
[   29.764932]=20
[   29.775958] device-mapper: uevent: version 1.0.3
[   29.782935] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised:=
 dm-devel@redhat.com
[   29.799023] 2018-04-17 16:05:26 wipefs -a --force /dev/pmem0
[   29.799026]=20
[   29.811546] /dev/pmem0: 4 bytes were erased at offset 0x00000000 (xfs): =
58 46 53 42
[   29.811547]=20
[   29.824953] 2018-04-17 16:05:26 wipefs -a --force /dev/pmem1
[   29.824955]=20
[   29.836785] /dev/pmem1: 4 bytes were erased at offset 0x00000000 (xfs): =
58 46 53 42
[   29.836787]=20
[   29.849954] 2018-04-17 16:05:26 mkfs -t btrfs /dev/pmem0
[   29.849956]=20
[   29.852041] raid6: sse2x1   gen()  6472 MB/s
[   29.857964] 2018-04-17 16:05:26 mkfs -t btrfs /dev/pmem1
[   29.864938]=20
[   29.876036] raid6: sse2x1   xor()  5681 MB/s
[   29.898034] raid6: sse2x2   gen()  9507 MB/s
[   29.920038] raid6: sse2x2   xor()  6484 MB/s
[   29.942036] raid6: sse2x4   gen() 11398 MB/s
[   29.964039] raid6: sse2x4   xor()  6101 MB/s
[   29.981035] raid6: avx2x1   gen()  9261 MB/s
[   30.004034] raid6: avx2x1   xor() 14060 MB/s
[   30.026038] raid6: avx2x2   gen() 23957 MB/s
[   30.048035] raid6: avx2x2   xor() 14958 MB/s
[   30.070028] raid6: avx2x4   gen() 20828 MB/s
[   30.092037] raid6: avx2x4   xor() 11179 MB/s
[   30.097725] raid6: using algorithm avx2x2 gen() 23957 MB/s
[   30.104770] raid6: .... xor() 14958 MB/s, rmw enabled
[   30.111288] raid6: using avx2x2 recovery algorithm
[   30.122939] xor: automatically using best checksumming function   avx   =
   =20
[   30.166384] Btrfs loaded, crc32c=3Dcrc32c-generic
[   30.172885] BTRFS: device fsid d71fd665-a32f-492b-8015-4072f66eb091 devi=
d 1 transid 5 /dev/pmem0
[   30.184088] BTRFS: device fsid 8ff59895-9334-4279-aef6-12856848b3a9 devi=
d 1 transid 5 /dev/pmem1
[   30.185181] btrfs-progs v4.7.3
[   30.195260]=20
[   30.203291] See http://btrfs.wiki.kernel.org for more information.
[   30.203293]=20
[   30.204045] BTRFS info (device pmem0): disk space caching is enabled
[   30.213793] BTRFS info (device pmem0): has skinny extents
[   30.221537]=20
[   30.228188] BTRFS info (device pmem0): flagging fs with big metadata fea=
ture
[   30.233526] Detected a SSD, turning off metadata duplication.  Mkfs with=
 -m dup if you want to force metadata duplication.
[   30.238920]=20
[   30.240494] BTRFS info (device pmem0): enabling ssd optimizations
[   30.252595] Label:              (null)
[   30.254438] BTRFS info (device pmem0): creating UUID tree
[   30.261712]=20
[   30.262260] UUID:              =20
[   30.275580]=20
[   30.282744] Node size:          16384
[   30.282745]=20
[   30.290367] Sector size:        4096
[   30.290368]=20
[   30.298014] Filesystem size:    104.00GiB
[   30.298016]=20
[   30.305892] Block group profiles:
[   30.305893]=20
[   30.313618]   Data:             single            8.00MiB
[   30.313620]=20
[   30.322419] BTRFS info (device pmem1): disk space caching is enabled
[   30.323605]   Metadata:         single            8.00MiB
[   30.330457]=20
[   30.330469] BTRFS info (device pmem1): has skinny extents
[   30.338225]   System:           single            4.00MiB
[   30.339198] BTRFS info (device pmem1): flagging fs with big metadata fea=
ture
[   30.345754]=20
[   30.354097] BTRFS info (device pmem1): enabling ssd optimizations
[   30.361365] SSD detected:       yes
[   30.363677] BTRFS info (device pmem1): creating UUID tree
[   30.370850]=20
[   30.371996] Incompat features:  extref, skinny-metadata
[   30.384178]=20
[   30.393211] Number of devices:  1
[   30.393212]=20
[   30.400022] Devices:
[   30.400023]=20
[   30.406488]    ID        SIZE  PATH
[   30.406489]=20
[   30.413973]     1   104.00GiB  /dev/pmem0
[   30.413974]=20
[   30.421240]=20
[   30.423918] btrfs-progs v4.7.3
[   30.423919]=20
[   30.431310] See http://btrfs.wiki.kernel.org for more information.
[   30.431312]=20
[   30.440834]=20
[   30.445580] Detected a SSD, turning off metadata duplication.  Mkfs with=
 -m dup if you want to force metadata duplication.
[   30.445581]=20
[   30.461334] Label:              (null)
[   30.461335]=20
[   30.468726] UUID:              =20
[   30.468727]=20
[   30.475465] Node size:          16384
[   30.475467]=20
[   30.482744] Sector size:        4096
[   30.482745]=20
[   30.490055] Filesystem size:    104.00GiB
[   30.490057]=20
[   30.497569] Block group profiles:
[   30.497570]=20
[   30.504961]   Data:             single            8.00MiB
[   30.504962]=20
[   30.514577]   Metadata:         single            8.00MiB
[   30.514578]=20
[   30.524265]   System:           single            4.00MiB
[   30.524266]=20
[   30.533349] SSD detected:       yes
[   30.533351]=20
[   30.540650] Incompat features:  extref, skinny-metadata
[   30.540652]=20
[   30.549534] Number of devices:  1
[   30.549536]=20
[   30.555973] Devices:
[   30.555974]=20
[   30.562450]    ID        SIZE  PATH
[   30.562452]=20
[   30.569544]     1   104.00GiB  /dev/pmem1
[   30.569545]=20
[   30.576435]=20
[   30.579456] 2018-04-17 16:05:26 mkdir -p /fs/pmem0
[   30.579457]=20
[   30.588652] 2018-04-17 16:05:26 mount -t btrfs /dev/pmem0 /fs/pmem0
[   30.588654]=20
[   30.599115] 2018-04-17 16:05:26 mkdir -p /fs/pmem1
[   30.599117]=20
[   30.608484] 2018-04-17 16:05:26 mount -t btrfs /dev/pmem1 /fs/pmem1
[   30.608485]=20
[   30.618045]=20
[   31.141867] 2018-04-17 16:05:27=20
[   31.141872]=20
[   31.151129] for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
[   31.151132]=20
[   31.160383] do
[   31.160385]=20
[   31.165428] 	online_file=3D"$cpu_dir"/online
[   31.165429]=20
[   31.174156] 	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] =
&& continue
[   31.174157]=20
[   31.185202]=20
[   31.188163] 	file=3D"$cpu_dir"/cpufreq/scaling_governor
[   31.188164]=20
[   31.197336] 	[ -f "$file" ] && echo "performance" > "$file"
[   31.197337]=20
[   31.206215] done
[   31.206217]=20
[   31.210792]=20
[   31.886303] kernel profiling enabled schedstats, disable via kernel.sche=
d_schedstats.
[   31.915074] capability: warning: `turbostat' uses 32-bit capabilities (l=
egacy support in use)
[   31.929755] IPMI Device Information
[   31.929757]=20
[   32.267434]=20
[   32.278871] BMC ARP Control         : ARP Responses Enabled, Gratuitous =
ARP Disabled
[   32.278875]=20
[   32.903216] 2018-04-17 16:05:29 echo '
[   32.903220]=20
[   32.911450] [global]
[   32.911453]=20
[   32.917698] bs=3D2M
[   32.917701]=20
[   32.924188] ioengine=3Dlibaio
[   32.924192]=20
[   32.931357] iodepth=3D32
[   32.931360]=20
[   32.938280] size=3D3834792228
[   32.938283]=20
[   32.945329] direct=3D0
[   32.945332]=20
[   32.951809] runtime=3D200
[   32.951812]=20
[   32.958608] invalidate=3D1
[   32.958611]=20
[   32.965577] fallocate=3Dposix
[   32.965580]=20
[   32.972766] group_reporting
[   32.972769]=20
[   32.979147]=20
[   32.982151] time_based
[   32.982154]=20
[   32.987986]=20
[   32.990807] [task_0]
[   32.990809]=20
[   32.997059] rw=3Drandwrite
[   32.997062]=20
[   33.003998] directory=3D/fs/pmem0
[   33.004001]=20
[   33.011116] numjobs=3D14
[   33.011119]=20
[   33.016776]=20
[   33.019517] [task_1]
[   33.019519]=20
[   33.025503] rw=3Drandwrite
[   33.025506]=20
[   33.032206] directory=3D/fs/pmem1
[   33.032210]=20
[   33.040668] numjobs=3D14' | fio --output-format=3Djson -
[   33.040671]=20
[  132.830845] perf: interrupt took too long (2502 > 2500), lowering kernel=
=2Eperf_event_max_sample_rate to 79000
[  132.842788] perf: interrupt took too long (3137 > 3127), lowering kernel=
=2Eperf_event_max_sample_rate to 63000
[  132.854754] perf: interrupt took too long (3922 > 3921), lowering kernel=
=2Eperf_event_max_sample_rate to 50000
[  132.920269] perf: interrupt took too long (4914 > 4902), lowering kernel=
=2Eperf_event_max_sample_rate to 40000
[  132.977509] perf: interrupt took too long (6159 > 6142), lowering kernel=
=2Eperf_event_max_sample_rate to 32000
[  133.531057] perf: interrupt took too long (7701 > 7698), lowering kernel=
=2Eperf_event_max_sample_rate to 25000
[  133.751073] WARNING: stack going in the wrong direction? ip=3D__schedule=
+0x489/0x830
[  134.048965] perf: interrupt took too long (9682 > 9626), lowering kernel=
=2Eperf_event_max_sample_rate to 20000
[  134.472390] perf: interrupt took too long (12178 > 12102), lowering kern=
el.perf_event_max_sample_rate to 16000
[  234.324541] 2018-04-17 16:08:50 umount /fs/pmem0
[  234.324546]=20
[  240.185400] WARNING: CPU: 0 PID: 6954 at kernel/workqueue.c:4142 destroy=
_workqueue+0x64/0x1e0
[  240.197915] Modules linked in: btrfs xor zstd_decompress zstd_compress x=
xhash raid6_pq dm_mod sr_mod cdrom intel_rapl sd_mod sg sb_edac x86_pkg_tem=
p_thermal intel_powerclamp coretemp mgag200 kvm_intel ttm kvm irqbypass crc=
t10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel ghash_clmulni_intel =
syscopyarea nd_pmem(O) dax_pmem(O) snd_pcm pcbc sysfillrect device_dax(O) n=
d_btt(O) snd_timer sysimgblt aesni_intel fb_sys_fops nd_e820(O) crypto_simd=
 ipmi_si libnvdimm(O) snd soundcore ahci mxm_wmi cryptd ipmi_devintf wdat_w=
dt dcdbas nfit_test_iomap(O) libahci pcspkr drm megaraid_sas glue_helper li=
bata ipmi_msghandler wmi acpi_power_meter shpchp ip_tables
[  240.267813] CPU: 0 PID: 6954 Comm: umount Tainted: G           O      4.=
17.0-rc1 #1
[  240.277473] Hardware name: Dell Inc. PowerEdge R630/0CNCJW, BIOS 2.1.7 0=
6/16/2016
[  240.286967] RIP: 0010:destroy_workqueue+0x64/0x1e0
[  240.293463] RSP: 0018:ffffc90021b0fde0 EFLAGS: 00010202
[  240.300462] RAX: ffff884072f4c058 RBX: ffff88407a17dc00 RCX: ffff884072f=
4c000
[  240.309628] RDX: ffff884072f4c058 RSI: 0000000000000000 RDI: ffffffff820=
cfa30
[  240.318802] RBP: ffff88407a17dc20 R08: ffffc90021b0fd40 R09: 00000000000=
00000
[  240.327990] R10: ffffc90021b0fdb8 R11: 0000000000000000 R12: ffff8820347=
f4fc0
[  240.337306] R13: ffff884079c23138 R14: ffffffff82d47aa0 R15: 00000000000=
00000
[  240.346546] FS:  00007f941fee2840(0000) GS:ffff882067600000(0000) knlGS:=
0000000000000000
[  240.356876] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  240.364602] CR2: 00007ff793645258 CR3: 0000004074f4a005 CR4: 00000000001=
606f0
[  240.373917] Call Trace:
[  240.378060]  btrfs_destroy_workqueue+0x40/0x110 [btrfs]
[  240.385322]  btrfs_stop_all_workers+0x2d/0xf0 [btrfs]
[  240.392397]  close_ctree+0x133/0x2f0 [btrfs]
[  240.398581]  generic_shutdown_super+0x6c/0x120
[  240.404956]  kill_anon_super+0xe/0x20
[  240.410482]  btrfs_kill_super+0x13/0x100 [btrfs]
[  240.417076]  deactivate_locked_super+0x3f/0x70
[  240.423483]  cleanup_mnt+0x3b/0x70
[  240.428737]  task_work_run+0xa3/0xe0
[  240.434199]  exit_to_usermode_loop+0x9e/0xa0
[  240.440456]  do_syscall_64+0x16c/0x180
[  240.446133]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  240.453285] RIP: 0033:0x7f941f7c7277
[  240.458782] RSP: 002b:00007fffb9a17cf8 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000a6
[  240.468778] RAX: 0000000000000000 RBX: 000000000158b6e0 RCX: 00007f941f7=
c7277
[  240.478299] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 00000000015=
8b8c0
[  240.487824] RBP: 000000000158b8c0 R08: 0000000000000000 R09: 00000000000=
00015
[  240.497317] R10: 00000000000006b0 R11: 0000000000000246 R12: 00007f941fc=
c9e44
[  240.506810] R13: 0000000000000000 R14: 0000000000000000 R15: 00007fffb9a=
17f80
[  240.516315] Code: c2 74 19 8b 30 85 f6 74 f1 0f 0b 48 89 ef e8 84 9f 8c =
00 5b 5d 41 5c e9 cb fa ff ff 48 39 8b a0 00 00 00 74 0a 83 79 18 01 7e 04 =
<0f> 0b eb dc 8b 41 58 85 c0 0f 85 3d 01 00 00 48 8b 41 60 48 8d=20
[  240.540655] ---[ end trace faf649c5bf432714 ]---
[  240.547594] Showing busy workqueues and worker pools:
[  240.554933] workqueue events_power_efficient: flags=3D0x80
[  240.563369]   pwq 0: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1/2=
56
[  240.571144]     pending: fb_flashcursor
[  240.610671] 2018-04-17 16:08:57 umount /fs/pmem1
[  240.610676]=20
[  246.450688] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin/lkp-jobfile-ap=
pend-var?job_file=3D/lkp/scheduled/lkp-hsw-ep6/fio-basic-2pmem-btrfs-200s-5=
0%25-tb-randwrite-2M-libaio-100G-performance-debian-x86_64-2016-08-31.cgz-6=
0cc43fc888428bb2f18f08997432d426a243338-20180417-83132-1vmen9v-2.yaml&job_s=
tate=3Dpost_run -o /dev/null
[  246.450694]=20
[  247.684102] kill 1471 vmstat --timestamp -n 10=20
[  247.684106]=20
[  247.697061] kill 1469 iostat -tkx 1 fake pmem disk, you shouldn't use it=
=20
[  247.697064]=20
[  247.710929] kill 1462 dmesg --follow --decode=20
[  247.710932]=20
[  247.721382] kill 1630 mpstat 1=20
[  247.721385]=20
[  247.860154] kill 1617 /lkp/benchmarks/perf/perf stat -a -c -I 1000 -x  -=
e {cpu-cycles,instructions,cache-references,cache-misses,branch-instruction=
s,branch-misses},{dTLB-loads,dTLB-load-misses},{dTLB-stores,dTLB-store-miss=
es},{iTLB-loads,iTLB-load-misses},{node-loads,node-load-misses},{node-store=
s,node-store-misses},cpu-clock,task-clock,page-faults,context-switches,cpu-=
migrations,minor-faults,major-faults --log-fd 1 --=20
[  247.860158]=20
[  247.912379] kill 1475 vmstat --timestamp -n 1=20
[  247.912382]=20
[  247.940694] wait for background monitors: 1496 1511 1519 1492 1481 1564 =
1485 1525 1579 1551 1607 1503 1646 1664 1544 1602 1634 proc-vmstat meminfo =
slabinfo numa-meminfo numa-numastat diskstats numa-vmstat interrupts cpuidl=
e softirqs sched_debug proc-stat oom-killer nfs-hang latency_stats turbosta=
t perf-profile
[  247.940697]=20
[  250.312700] no symbols found in /bin/dash, maybe install a debug package?
[  250.312704]=20
[  250.347266] /lkp/benchmarks/perf/perf with build id 880fc0d2f19b54bf8716=
48a97ae2d6649363418c not found, continuing without symbols
[  250.347271]=20
[  250.580123] no symbols found in /bin/gzip, maybe install a debug package?
[  250.580128]=20
[  250.789413] /lkp/lkp/src/bin/event/wakeup with build id ab3311ef83925062=
42d8b1581ac915ccffd66899 not found, continuing without symbols
[  250.789417]=20
[  256.497818] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin/lkp-jobfile-ap=
pend-var?job_file=3D/lkp/scheduled/lkp-hsw-ep6/fio-basic-2pmem-btrfs-200s-5=
0%25-tb-randwrite-2M-libaio-100G-performance-debian-x86_64-2016-08-31.cgz-6=
0cc43fc888428bb2f18f08997432d426a243338-20180417-83132-1vmen9v-2.yaml&loada=
vg=3D27.29%2019.14%208.04%201/564%207390&start_time=3D1523952329&end_time=
=3D1523952542&version=3D/lkp/lkp/.src-20180417-151744& -o /dev/null
[  256.497823]=20
[  256.749129] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin/lkp-jobfile-ap=
pend-var?job_file=3D/lkp/scheduled/lkp-hsw-ep6/fio-basic-2pmem-btrfs-200s-5=
0%25-tb-randwrite-2M-libaio-100G-performance-debian-x86_64-2016-08-31.cgz-6=
0cc43fc888428bb2f18f08997432d426a243338-20180417-83132-1vmen9v-2.yaml&job_s=
tate=3Dfinished -o /dev/null
[  256.749134]=20
[  256.984905] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin/lkp-post-run?j=
ob_file=3D/lkp/scheduled/lkp-hsw-ep6/fio-basic-2pmem-btrfs-200s-50%25-tb-ra=
ndwrite-2M-libaio-100G-performance-debian-x86_64-2016-08-31.cgz-60cc43fc888=
428bb2f18f08997432d426a243338-20180417-83132-1vmen9v-2.yaml -o /dev/null
[  256.984917]=20
[  257.404308] getting new job...
[  257.404312]=20
[  257.428062] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin/gpxelinux.cgi?=
hostname=3Dlkp-hsw-ep6&mac=3Dec:f4:bb:cb:54:90&last_kernel=3D/pkg/linux/x86=
_64-rhel-7.2/gcc-7/60cc43fc888428bb2f18f08997432d426a243338/vmlinuz-4.17.0-=
rc1&lkp_wtmp -o /tmp/next-job-lkp
[  257.428065]=20
[  259.277949] /usr/bin/curl -sSf http://inn:80/~lkp//lkp/scheduled/lkp-hsw=
-ep6/fio-basic-2pmem-xfs-dax-200s-50%25-tb-rw-4k-sync-200G-performance-debi=
an-x86_64-2016-08-31.cgz-3a8c7231d53641a21d794c7406044e19ad299a00-20180417-=
21688-1p9qpq0-0.cgz -o /tmp/next-job.cgz
[  259.277953]=20
[  259.281360] 27 blocks
[  259.311649] downloading kernel image ...
[  259.313915]=20
[  259.318523]=20
[  259.352219] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin/lkp-jobfile-ap=
pend-var?job_file=3D/lkp/scheduled/lkp-hsw-ep6/fio-basic-2pmem-xfs-dax-200s=
-50%25-tb-rw-4k-sync-200G-performance-debian-x86_64-2016-08-31.cgz-3a8c7231=
d53641a21d794c7406044e19ad299a00-20180417-21688-1p9qpq0-0.yaml&job_state=3D=
wget_kernel -o /dev/null
[  259.352222]=20
[  259.563430] /usr/bin/curl -sSf http://inn:80/~lkp/pkg/linux/x86_64-rhel-=
7.2/gcc-7/3a8c7231d53641a21d794c7406044e19ad299a00/vmlinuz-4.15.0-rc3-00021=
-g3a8c7231 -o /tmp/cache/pkg/linux/x86_64-rhel-7.2/gcc-7/3a8c7231d53641a21d=
794c7406044e19ad299a00/vmlinuz-4.15.0-rc3-00021-g3a8c7231
[  259.563435]=20
[  260.307612] downloading initrds ...
[  260.307616]=20
[  260.336635] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin/lkp-jobfile-ap=
pend-var?job_file=3D/lkp/scheduled/lkp-hsw-ep6/fio-basic-2pmem-xfs-dax-200s=
-50%25-tb-rw-4k-sync-200G-performance-debian-x86_64-2016-08-31.cgz-3a8c7231=
d53641a21d794c7406044e19ad299a00-20180417-21688-1p9qpq0-0.yaml&job_state=3D=
wget_initrd -o /dev/null
[  260.336638]=20
[  260.547432] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/debian/debian-=
x86_64-2016-08-31.cgz -o /tmp/cache/osimage/debian/debian-x86_64-2016-08-31=
=2Ecgz
[  260.547436]=20
[  276.795385] 868655 blocks
[  276.795389]=20
[  276.819704] 27 blocks
[  276.819708]=20
[  276.851865] /usr/bin/curl -sSf http://inn:80/~lkp/lkp/scheduled/lkp-hsw-=
ep6/fio-basic-2pmem-xfs-dax-200s-50%25-tb-rw-4k-sync-200G-performance-debia=
n-x86_64-2016-08-31.cgz-3a8c7231d53641a21d794c7406044e19ad299a00-20180417-2=
1688-1p9qpq0-0.cgz -o /tmp/cache/lkp/scheduled/lkp-hsw-ep6/fio-basic-2pmem-=
xfs-dax-200s-50%-tb-rw-4k-sync-200G-performance-debian-x86_64-2016-08-31.cg=
z-3a8c7231d53641a21d794c7406044e19ad299a00-20180417-21688-1p9qpq0-0.cgz
[  276.851870]=20
[  276.912433] /usr/bin/curl -sSf http://inn:80/~lkp/lkp/lkp/lkp-x86_64.cgz=
 -o /tmp/cache/lkp/lkp/lkp-x86_64.cgz
[  276.912435]=20
[  277.072736] 15450 blocks
[  277.072740]=20
[  277.090200] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/deps/debian-x8=
6_64-2016-08-31.cgz/run-ipconfig_2016-11-15.cgz -o /tmp/cache/osimage/deps/=
debian-x86_64-2016-08-31.cgz/run-ipconfig_2016-11-15.cgz
[  277.090204]=20
[  277.129453] 1077 blocks
[  277.129457]=20
[  277.145142] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/deps/debian-x8=
6_64-2016-08-31.cgz/lkp_2017-12-14.cgz -o /tmp/cache/osimage/deps/debian-x8=
6_64-2016-08-31.cgz/lkp_2017-12-14.cgz
[  277.145146]=20
[  277.309763] 4350 blocks
[  277.309767]=20
[  277.326688] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/deps/debian-x8=
6_64-2016-08-31.cgz/rsync-rootfs_2016-11-15.cgz -o /tmp/cache/osimage/deps/=
debian-x86_64-2016-08-31.cgz/rsync-rootfs_2016-11-15.cgz
[  277.326692]=20
[  277.600763] 8266 blocks
[  277.600767]=20
[  277.617060] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/deps/debian-x8=
6_64-2016-08-31.cgz/fs_2016-11-15.cgz -o /tmp/cache/osimage/deps/debian-x86=
_64-2016-08-31.cgz/fs_2016-11-15.cgz
[  277.617064]=20
[  278.215614] 18404 blocks
[  278.215618]=20
[  278.232443] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/deps/debian-x8=
6_64-2016-08-31.cgz/fio_2016-11-15.cgz -o /tmp/cache/osimage/deps/debian-x8=
6_64-2016-08-31.cgz/fio_2016-11-15.cgz
[  278.232447]=20
[  279.973266] 68624 blocks
[  279.973270]=20
[  279.991032] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/deps/debian-x8=
6_64-2016-08-31.cgz/mpstat_2017-12-25.cgz -o /tmp/cache/osimage/deps/debian=
-x86_64-2016-08-31.cgz/mpstat_2017-12-25.cgz
[  279.991037]=20
[  280.036743] 764 blocks
[  280.036747]=20
[  280.054690] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/deps/debian-x8=
6_64-2016-08-31.cgz/turbostat_2016-11-15.cgz -o /tmp/cache/osimage/deps/deb=
ian-x86_64-2016-08-31.cgz/turbostat_2016-11-15.cgz
[  280.054694]=20
[  280.229354] 5007 blocks
[  280.229358]=20
[  280.250488] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/pkg/debian-x86=
_64-2016-08-31.cgz/turbostat-x86_64-d5256b2_2017-06-20.cgz -o /tmp/cache/os=
image/pkg/debian-x86_64-2016-08-31.cgz/turbostat-x86_64-d5256b2_2017-06-20.=
cgz
[  280.250492]=20
[  280.260543] 208 blocks
[  280.279828]=20
[  280.286845] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/deps/debian-x8=
6_64-2016-08-31.cgz/perf_2018-04-04.cgz -o /tmp/cache/osimage/deps/debian-x=
86_64-2016-08-31.cgz/perf_2018-04-04.cgz
[  280.287551]=20
[  283.915323] 134702 blocks
[  283.915327]=20
[  283.934229] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/pkg/debian-x86=
_64-2016-08-31.cgz/perf-x86_64-f8cf2f16a7c9_2018-04-09.cgz -o /tmp/cache/os=
image/pkg/debian-x86_64-2016-08-31.cgz/perf-x86_64-f8cf2f16a7c9_2018-04-09.=
cgz
[  283.934233]=20
[  284.255984] 12982 blocks
[  284.255988]=20
[  284.271607] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/deps/debian-x8=
6_64-2016-08-31.cgz/hw_2016-11-15.cgz -o /tmp/cache/osimage/deps/debian-x86=
_64-2016-08-31.cgz/hw_2016-11-15.cgz
[  284.271611]=20
[  285.131156] 31441 blocks
[  285.131160]=20
[  285.149961] /usr/bin/curl -sSf http://inn:80/~lkp/pkg/linux/x86_64-rhel-=
7.2/gcc-7/3a8c7231d53641a21d794c7406044e19ad299a00/modules.cgz -o /tmp/cach=
e/pkg/linux/x86_64-rhel-7.2/gcc-7/3a8c7231d53641a21d794c7406044e19ad299a00/=
modules.cgz
[  285.149966]=20
[  302.731394] 1108397 blocks
[  302.731399]=20
[  302.946172] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin/lkp-jobfile-ap=
pend-var?job_file=3D/lkp/scheduled/lkp-hsw-ep6/fio-basic-2pmem-xfs-dax-200s=
-50%25-tb-rw-4k-sync-200G-performance-debian-x86_64-2016-08-31.cgz-3a8c7231=
d53641a21d794c7406044e19ad299a00-20180417-21688-1p9qpq0-0.yaml&job_state=3D=
booting -o /dev/null
[  302.946185]=20
[  303.139539] LKP: kexec loading...
[  303.139543]=20
[  303.160245] kexec --noefi -l /tmp/cache/pkg/linux/x86_64-rhel-7.2/gcc-7/=
3a8c7231d53641a21d794c7406044e19ad299a00/vmlinuz-4.15.0-rc3-00021-g3a8c7231=
 --initrd=3D/tmp/cache/initrd-concatenated
[  303.160257]=20
[  305.195727] Unknown type (Reserved) while parsing /sys/firmware/memmap/1=
1/type. Please report this as bug. Using RANGE_RESERVED now.
[  305.195732]=20
[  305.223020] Unknown type (Reserved) while parsing /sys/firmware/memmap/1=
/type. Please report this as bug. Using RANGE_RESERVED now.
[  305.223025]=20
[  305.245234] --append=3Dip=3D::::lkp-hsw-ep6::dhcp root=3D/dev/ram0 user=
=3Dlkp job=3D/lkp/scheduled/lkp-hsw-ep6/fio-basic-2pmem-xfs-dax-200s-50%-tb=
-rw-4k-sync-200G-performance-debian-x86_64-2016-08-31.cgz-3a8c7231d53641a21=
d794c7406044e19ad299a00-20180417-21688-1p9qpq0-0.yaml ARCH=3Dx86_64 kconfig=
=3Dx86_64-rhel-7.2 branch=3Dlinux-next/master commit=3D3a8c7231d53641a21d79=
4c7406044e19ad299a00 BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-7.2/gcc-7/3a8c7231=
d53641a21d794c7406044e19ad299a00/vmlinuz-4.15.0-rc3-00021-g3a8c7231 memmap=
=3D104G!4G memmap=3D104G!132G max_uptime=3D1200 RESULT_ROOT=3D/result/fio-b=
asic/2pmem-xfs-dax-200s-50%-tb-rw-4k-sync-200G-performance/lkp-hsw-ep6/debi=
an-x86_64-2016-08-31.cgz/x86_64-rhel-7.2/gcc-7/3a8c7231d53641a21d794c740604=
4e19ad299a00/0 LKP_SERVER=3Dinn debug apic=3Ddebug sysrq_always_enabled rcu=
pdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=
=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic lo
[  305.250207] Unknown type (Reserved) while parsing /sys/firmware/memmap/4=
/type. Please report this as bug. Using RANGE_RESERVED now.
[  305.342459]=20
[  305.342460]=20
[  305.374049] Unknown type (Reserved) while parsing /sys/firmware/memmap/1=
2/type. Please report this as bug. Using RANGE_RESERVED now.
[  305.374053]=20
[  305.402037] Unknown type (Reserved) while parsing /sys/firmware/memmap/2=
/type. Please report this as bug. Using RANGE_RESERVED now.
[  305.402041]=20
[  305.430291] Unknown type (Reserved) while parsing /sys/firmware/memmap/1=
0/type. Please report this as bug. Using RANGE_RESERVED now.
[  305.430294]=20
[  308.541366] umount: /tmp: target is busy
[  308.541370]=20
[  308.554716]         (In some cases useful info about processes that
[  308.554718]=20
[  308.571395]          use the device is found by lsof(8) or fuser(1).)
[  308.571398]=20
[  308.710832] umount: /sys/fs/cgroup/systemd: target is busy
[  308.710836]=20
[  308.725538]         (In some cases useful info about processes that
[  308.725540]=20
[  308.741018]          use the device is found by lsof(8) or fuser(1).)
[  308.741021]=20
[  308.755825] umount: /sys/fs/cgroup: target is busy
[  308.755827]=20
[  308.770277]         (In some cases useful info about processes that
[  308.770279]=20
[  308.774253]          use the device is found by lsof(8) or fuser(1).)
[  308.774256]=20
[  308.776116] umount: /run: target is busy
[  308.776119]=20
[  308.779887]         (In some cases useful info about processes that
[  308.779898]=20
[  308.783863]          use the device is found by lsof(8) or fuser(1).)
[  308.783871]=20
[  308.846754] umount: /dev: target is busy
LKP: kexecing
[  308.846758]=20
[  308.847564] LKP: kexecing
[  308.855790]         (In some cases useful info about processes that
[  308.856143]=20
[  308.856542] ixgbe 0000:01:00.0: removed PHC on eth2
[  308.860750]=20
[  308.885918]          use the device is found by lsof(8) or fuser(1).)
[  308.885921]=20
[  308.898938] umount: /: not mounted
[  308.898941]=20
[  309.218763] kvm: exiting hardware virtualization
Starting new kernel

--dsxiu7sfiuyrfgls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.17.0-rc1 Kernel Configuration
#
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y
CONFIG_AUDIT_WATCH=y
CONFIG_AUDIT_TREE=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_RCU_NOCB_CPU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
CONFIG_CC_STACKPROTECTOR_NONE=y
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
# CONFIG_CC_STACKPROTECTOR_AUTO is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_CFQ_GROUP_IOSCHED=y
CONFIG_DEFAULT_DEADLINE=y
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="deadline"
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_INTEL_RDT=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
# CONFIG_QUEUED_LOCK_STAT is not set
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
CONFIG_XEN_DOM0=y
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
CONFIG_NO_BOOTMEM=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_ZONE_DEVICE=y
CONFIG_ARCH_HAS_HMM=y
# CONFIG_HMM_MIRROR is not set
# CONFIG_DEVICE_PRIVATE is not set
# CONFIG_DEVICE_PUBLIC is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_X86_INTEL_MPX=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
# CONFIG_EFI_MIXED is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
# CONFIG_LIVEPATCH is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_TEST_SUSPEND=y
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_PCI_DOMAINS=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIE_ECRC=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_BUS_ADDR_T_64BIT=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_PCI_HYPERV is not set
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=m

#
# Cadence PCIe controllers support
#

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT is not set

#
# PCI host controller drivers
#
# CONFIG_VMD is not set

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_XFRM_MODE_TRANSPORT=m
CONFIG_INET_XFRM_MODE_TUNNEL=m
CONFIG_INET_XFRM_MODE_BEET=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
# CONFIG_TCP_CONG_DCTCP is not set
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_INET6_XFRM_MODE_TRANSPORT=m
CONFIG_INET6_XFRM_MODE_TUNNEL=m
CONFIG_INET6_XFRM_MODE_BEET=m
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
# CONFIG_IPV6_GRE is not set
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=m
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
# CONFIG_NF_CT_NETLINK_TIMEOUT is not set
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_NEEDED=y
CONFIG_NF_NAT_PROTO_DCCP=y
CONFIG_NF_NAT_PROTO_UDPLITE=y
CONFIG_NF_NAT_PROTO_SCTP=y
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=m
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
# CONFIG_NF_TABLES_INET is not set
# CONFIG_NF_TABLES_NETDEV is not set
CONFIG_NFT_EXTHDR=m
CONFIG_NFT_META=m
# CONFIG_NFT_RT is not set
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
# CONFIG_NFT_SET_RBTREE is not set
# CONFIG_NFT_SET_HASH is not set
# CONFIG_NFT_SET_BITMAP is not set
CONFIG_NFT_COUNTER=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
# CONFIG_NFT_MASQ is not set
# CONFIG_NFT_REDIR is not set
CONFIG_NFT_NAT=m
# CONFIG_NFT_OBJREF is not set
# CONFIG_NFT_QUEUE is not set
# CONFIG_NFT_QUOTA is not set
# CONFIG_NFT_REJECT is not set
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
# CONFIG_IP_SET_HASH_IPMARK is not set
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
# CONFIG_IP_SET_HASH_IPMAC is not set
# CONFIG_IP_SET_HASH_MAC is not set
# CONFIG_IP_SET_HASH_NETPORTNET is not set
CONFIG_IP_SET_HASH_NET=m
# CONFIG_IP_SET_HASH_NETNET is not set
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_CONNTRACK_IPV4=m
# CONFIG_NF_SOCKET_IPV4 is not set
# CONFIG_NF_TABLES_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_IPV4=m
CONFIG_NF_NAT_MASQUERADE_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PROTO_GRE=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_CONNTRACK_IPV6=m
# CONFIG_NF_SOCKET_IPV6 is not set
# CONFIG_NF_TABLES_IPV6 is not set
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_NF_NAT_IPV6=m
# CONFIG_NF_NAT_MASQUERADE_IPV6 is not set
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
# CONFIG_IP6_NF_NAT is not set
# CONFIG_NF_TABLES_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_FQ is not set
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
# CONFIG_NET_CLS_FLOWER is not set
# CONFIG_NET_CLS_MATCHALL is not set
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
# CONFIG_NET_ACT_SAMPLE is not set
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_VLAN is not set
# CONFIG_NET_ACT_BPF is not set
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_SKBMOD is not set
# CONFIG_NET_ACT_IFE is not set
# CONFIG_NET_ACT_TUNNEL_KEY is not set
CONFIG_NET_CLS_IND=y
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
# CONFIG_VIRTIO_VSOCKETS is not set
# CONFIG_HYPERV_VSOCKETS is not set
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_LEDS is not set
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_SOFTING is not set

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set

#
# CAN USB interfaces
#
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_MINSTREL_HT=y
# CONFIG_MAC80211_RC_MINSTREL_VHT is not set
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8

#
# Bus devices
#
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is not set
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
# CONFIG_XEN_BLKDEV_BACKEND is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
# CONFIG_BLK_DEV_RBD is not set
CONFIG_BLK_DEV_RSXX=m

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
# CONFIG_NVME_MULTIPATH is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TARGET is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_SGI_IOC4=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
# CONFIG_SCSI_MQ_DEFAULT is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_IPR=m
CONFIG_SCSI_IPR_TRACE=y
CONFIG_SCSI_IPR_DUMP=y
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
# CONFIG_TCM_QLA2XXX is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
CONFIG_SCSI_CHELSIO_FCOE=m
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
CONFIG_SCSI_OSD_INITIATOR=m
CONFIG_SCSI_OSD_ULD=m
CONFIG_SCSI_OSD_DPRINT_SENSE=1
# CONFIG_SCSI_OSD_DEBUG is not set
CONFIG_ATA=m
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_MQ_DEFAULT is not set
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_ERA is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
# CONFIG_ISCSI_TARGET_CXGB4 is not set
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=m
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=y
CONFIG_NLMON=m
CONFIG_NET_VRF=y
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
# CONFIG_BNX2X is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_NET_VENDOR_EXAR is not set
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
CONFIG_IXGB=m
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=m
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=m
CONFIG_SKGE_DEBUG=y
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
CONFIG_SKY2_DEBUG=y
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_PACKET_ENGINE=y
# CONFIG_HAMACHI is not set
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_QLGE=m
CONFIG_NETXEN_NIC=m
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AT803X_PHY=m
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_LXT_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=m
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=m
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x2E is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PEARL_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
# CONFIG_DSCC4 is not set
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
CONFIG_XEN_NETDEV_FRONTEND=m
# CONFIG_XEN_NETDEV_BACKEND is not set
CONFIG_VMXNET3=m
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_ISDN=y
CONFIG_ISDN_I4L=m
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_IPPP_FILTER=y
# CONFIG_ISDN_PPP_BSDCOMP is not set
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y

#
# ISDN feature submodules
#
CONFIG_ISDN_DIVERSION=m

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
# CONFIG_ISDN_DRV_HISAX is not set
CONFIG_ISDN_CAPI=m
# CONFIG_CAPI_TRACE is not set
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPIDRV=m
# CONFIG_ISDN_CAPI_CAPIDRV_VERBOSE is not set

#
# CAPI hardware drivers
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m
# CONFIG_CAPI_EICON is not set
CONFIG_ISDN_DRV_GIGASET=m
CONFIG_GIGASET_CAPI=y
CONFIG_GIGASET_BASE=m
CONFIG_GIGASET_M105=m
CONFIG_GIGASET_M101=m
# CONFIG_GIGASET_DEBUG is not set
CONFIG_HYSDN=m
CONFIG_HYSDN_CAPI=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_ISDN_HDLC=m
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
# CONFIG_INPUT_GP2A is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PROC_INTERFACE=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PCI=m
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_DESIGNWARE=m
# CONFIG_SPI_DW_PCI is not set
# CONFIG_SPI_DW_MMIO is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
CONFIG_PTP_1588_CLOCK_KVM=y
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_GPIOLIB=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_LYNXPOINT=m
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_ISP1704 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LTC3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_INTEL_MEI_WDT is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
# CONFIG_SSB_SILENT is not set
# CONFIG_SSB_DEBUG is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS68470 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
# CONFIG_LIRC is not set
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_XMP_DECODER=m
# CONFIG_IR_IMON_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
# CONFIG_RC_LOOPBACK is not set
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L2=m
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
CONFIG_VIDEOBUF_DVB=m
CONFIG_DVB_CORE=m
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_USBVISION=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_FRIIO=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set
# CONFIG_VIDEO_ZORAN is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
CONFIG_VIDEO_SAA711X=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m

#
# Camera sensor devices
#

#
# Flash devices
#

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_M52790=m

#
# Sensors used on soc_camera driver
#

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
CONFIG_MEDIA_TUNER=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_GP8PSK_FE=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m

#
# Tools to develop new frontends
#

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
# CONFIG_DRM_DEBUG_MM_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_TTM=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
CONFIG_DRM_VGEM=m
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_QXL=m
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_AUO_K190X is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_S6E63M0 is not set
# CONFIG_LCD_LD9040 is not set
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
# CONFIG_SND_HDA_RECONFIG is not set
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_PREALLOC_SIZE=512
CONFIG_SND_SPI=y
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
# CONFIG_SND_USB_POD is not set
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
# CONFIG_SND_SOC is not set
CONFIG_SND_X86=y
# CONFIG_HDMI_LPE_AUDIO is not set
CONFIG_SND_SYNTH_EMUX=m
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_GOOGLE_HAMMER is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y

#
# I2C HID support
#
CONFIG_I2C_HID=m

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_MON=y
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
CONFIG_USB_DWC3=y
# CONFIG_USB_DWC3_HOST is not set
CONFIG_USB_DWC3_GADGET=y
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_FOTG210_UDC is not set
# CONFIG_USB_GR_UDC is not set
# CONFIG_USB_R8A66597 is not set
# CONFIG_USB_PXA27X is not set
# CONFIG_USB_MV_UDC is not set
# CONFIG_USB_MV_U3D is not set
# CONFIG_USB_M66592 is not set
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_AMD5536UDC is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
# CONFIG_USB_DUMMY_HCD is not set
CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_MASS_STORAGE=m
# CONFIG_USB_CONFIGFS is not set
# CONFIG_USB_ZERO is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_FUNCTIONFS is not set
CONFIG_USB_MASS_STORAGE=m
# CONFIG_USB_GADGET_TARGET is not set
# CONFIG_USB_G_SERIAL is not set
# CONFIG_USB_MIDI_GADGET is not set
# CONFIG_USB_G_PRINTER is not set
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_ACM_MS is not set
# CONFIG_USB_G_MULTI is not set
# CONFIG_USB_G_HID is not set
# CONFIG_USB_G_DBGP is not set
# CONFIG_USB_G_WEBCAM is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
# CONFIG_EDAC_GHES is not set
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
# CONFIG_EDAC_IE31200 is not set
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
# CONFIG_EDAC_SKX is not set
# CONFIG_EDAC_PND2 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
CONFIG_RTC_DRV_DS1307_HWMON=y
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV8803 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_UIO_HV_GENERIC is not set
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI_IGD=y
# CONFIG_VFIO_MDEV is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TSCPAGE=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_SELFBALLOONING is not set
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES=y
CONFIG_XEN_DEV_EVTCHN=m
CONFIG_XEN_BACKEND=y
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_TMEM=m
CONFIG_XEN_PCIDEV_BACKEND=m
# CONFIG_XEN_PVCALLS_FRONTEND is not set
# CONFIG_XEN_PVCALLS_BACKEND is not set
# CONFIG_XEN_SCSI_BACKEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_ACPI_PROCESSOR=m
# CONFIG_XEN_MCE_LOG is not set
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_SYMS=y
CONFIG_XEN_HAVE_VPMU=y
CONFIG_STAGING=y
# CONFIG_IPX is not set
# CONFIG_NCP_FS is not set
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_R8822BE is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_LNET is not set
# CONFIG_DGNC is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_CRYPTO_SKEIN is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS is not set

#
# USB Power Delivery and Type-C drivers
#
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_PI433 is not set
# CONFIG_MTK_MMC is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACERHDF=m
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=m
# CONFIG_DELL_SMBIOS is not set
# CONFIG_DELL_LAPTOP is not set
# CONFIG_DELL_WMI is not set
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBTN is not set
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_HP_WIRELESS is not set
CONFIG_HP_WMI=m
CONFIG_MSI_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_WMI=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_SAMSUNG_Q10=m
CONFIG_APPLE_GMUX=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_PVPANIC=y
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IOVA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=m
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_NVMEM=y

#
# HW tracing support
#
CONFIG_STM=m
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=m
CONFIG_DCDBAS=m
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
CONFIG_UEFI_CPER=y

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
# CONFIG_XFS_ONLINE_SCRUB is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_FS_ENCRYPTION=y
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EXOFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
# CONFIG_NFSD_SCSILAYOUT is not set
# CONFIG_NFSD_FLEXFILELAYOUT is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SUNRPC_DEBUG=y
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS=y
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_ACL=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SMB311 is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KASAN=y
# CONFIG_KASAN is not set
CONFIG_ARCH_HAS_KCOV=y
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAIL_FUNCTION is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_TRACING_EVENTS_GPIO=y
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=m
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=m
CONFIG_INTERVAL_TREE_TEST=m
CONFIG_PERCPU_TEST=m
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_ASYNC_RAID6_TEST=m
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_KSTRTOX=m
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
CONFIG_TEST_UDELAY=m
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_EFI is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
# CONFIG_SECURITY_PATH is not set
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_APPRAISE_BOOTPARAM=y
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_DEFAULT_SECURITY="selinux"
CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_MCRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=m
CONFIG_CRYPTO_SHA256_SSSE3=m
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA1_MB=m
CONFIG_CRYPTO_SHA256_MB=m
CONFIG_CRYPTO_SHA512_MB=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_SALSA20_X86_64=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
# CONFIG_CRYPTO_SPECK is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
# CONFIG_CRYPTO_DEV_CHELSIO is not set
CONFIG_CRYPTO_DEV_VIRTIO=m
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_MMU_AUDIT=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
# CONFIG_VHOST_VSOCK is not set
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=m
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_SGL_ALLOC=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=m
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set

--dsxiu7sfiuyrfgls--
