Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeBSIJS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 03:09:18 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:37301 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbeBSIJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 03:09:16 -0500
X-Google-Smtp-Source: AH8x226IIwXJk6o8zRxFiuRHG8m+DOYJSmtQWKqBVkwz0hxXkCKy2Tn5vNQ94Ca5w6eIt2JwGHkv8tGfDiCbh8N++Ek=
MIME-Version: 1.0
In-Reply-To: <c35cd314-9dad-5d25-4627-1cc8687dbf7f@suse.de>
References: <CALQ-8CJ8biPVCKvg+Gri9Am+TRBP0Rw-cWL42U2F_z8VvWTNfg@mail.gmail.com>
 <c35cd314-9dad-5d25-4627-1cc8687dbf7f@suse.de>
From: Max Ivanov <ivanov.maxim@gmail.com>
Date: Mon, 19 Feb 2018 08:08:54 +0000
Message-ID: <CALQ-8CJnodw3aGsHyC2Tm1YCyDKWqZjc19mr_JuxW81JA1v+3A@mail.gmail.com>
Subject: Re: iSCSI session logout regression after fbce4d97fd ("scsi: fixup
 kernel warning during rmmod()")
To: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
        Kyle Fortin <kyle.fortin@oracle.com>,
        Don Brace <don.brace@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        labbott@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1J89NX7030278

It seems that commit 81b6c9998979 ('scsi: core: check for device state
in __scsi_remove_target()') didn't make it to 4.14 branch

$ git tag --contains 81b6c9998979
v4.15
v4.15-rc6
v4.15-rc7
v4.15-rc8
v4.15-rc9
v4.15.1
v4.15.2
v4.15.3
v4.15.4
v4.16-rc1
v4.16-rc2

On 19 February 2018 at 06:56, Hannes Reinecke <hare@suse.de> wrote:
> On 02/18/2018 07:33 PM, Max Ivanov wrote:
>> Hi,
>>
>> on my system I can't logout from iSCSI session when on 4.4.18, but
>> 4.3.19 works just fine. git bisect points to  fbce4d97fd ("scsi: fixup
>> kernel warning during rmmod()")
>>
>> Bug manifests itself like following:
>>   - iSCSI session logout hangs and never completes
>>   - 1 kworker per iSCSI session start consuming 100% CPU
>>   - very shortly one of 2 errors show up in dmesg (full listings are below):
>>       * kernel: list_del corruption, ffff88c1cd6bb810->next is LIST_POISON1
>>       * kernel BUG at mm/slub.c:295!
>>
>> Ways to trigger bug:
>>   1. initiate iSCSI sessions to multiple portals
>>   2. let multipathd to create multipath devices
>>   3. run 'iscsiadm -m node --logoutall=all'
>>
>> Bugs is NOT triggered and iSCSI logout succeeds when either:
>>   - multipathd is masked and never started
>>   - I manually delete all scsi devices via /sys/block/$d/device/delete
>> before attempting
>>     to do iSCSI logout
>>
>> list_del_corrpution:
>>
>> Feb 16 10:37:11 localhost.localdomain kernel: alua: device handler registered
>> Feb 16 10:37:11 localhost.localdomain kernel: emc: device handler registered
>> Feb 16 10:37:11 localhost.localdomain kernel: rdac: device handler registered
>> Feb 16 10:37:11 localhost.localdomain kernel: device-mapper: multipath
>> service-time: version 0.3.0 loaded
>> Feb 16 10:38:38 localhost.localdomain kernel: list_del corruption,
>> ffff88c1cd6bb810->next is LIST_POISON1 (dead000000000100)
>> Feb 16 10:38:38 localhost.localdomain kernel: ------------[ cut here
>> ]------------
>> Feb 16 10:38:38 localhost.localdomain kernel: kernel BUG at lib/list_debug.c:47!
>> Feb 16 10:38:38 localhost.localdomain kernel: invalid opcode: 0000 [#1] SMP PTI
>> Feb 16 10:38:38 localhost.localdomain kernel: Modules linked in:
>> dm_service_time dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua
>> binfmt_misc iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi
>> ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ip_set nfnetlink
>> ebtable_nat ebtable_broute bridge stp llc ip6tabl
>> Feb 16 10:38:38 localhost.localdomain kernel:  pata_acpi
>> Feb 16 10:38:38 localhost.localdomain kernel: CPU: 2 PID: 5 Comm:
>> kworker/u24:0 Not tainted 4.14.18-300.fc27.x86_64 #1
>> Feb 16 10:38:38 localhost.localdomain kernel: Hardware name: VMware,
>> Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS
>> 6.00 09/21/2015
>> Feb 16 10:38:38 localhost.localdomain kernel: Workqueue: scsi_wq_5
>> __iscsi_unbind_session [scsi_transport_iscsi]
>> Feb 16 10:38:38 localhost.localdomain kernel: task: ffff88bdede83e80
>> task.stack: ffffb15043158000
>> Feb 16 10:38:38 localhost.localdomain kernel: RIP:
>> 0010:__list_del_entry_valid+0x4e/0x90
>> Feb 16 10:38:38 localhost.localdomain kernel: RSP:
>> 0018:ffffb1504315bd88 EFLAGS: 00010082
>> Feb 16 10:38:38 localhost.localdomain kernel: RAX: 000000000000004e
>> RBX: ffff88c1cd6bbf38 RCX: 0000000000000000
>> Feb 16 10:38:38 localhost.localdomain kernel: RDX: 0000000000000000
>> RSI: ffff88bdefc96a38 RDI: ffff88bdefc96a38
>> Feb 16 10:38:38 localhost.localdomain kernel: RBP: 0000000000000246
>> R08: 00000000000007be R09: 0000000000aaaaaa
>> Feb 16 10:38:38 localhost.localdomain kernel: R10: ffffb1504315bd58
>> R11: 00000000ffffffff R12: ffff88c1ebb659c0
>> Feb 16 10:38:38 localhost.localdomain kernel: R13: ffff88bdec827010
>> R14: ffff88c1cd6bb800 R15: ffff88c1cd6bb800
>> Feb 16 10:38:38 localhost.localdomain kernel: FS:
>> 0000000000000000(0000) GS:ffff88bdefc80000(0000)
>> knlGS:0000000000000000
>> Feb 16 10:38:38 localhost.localdomain kernel: CS:  0010 DS: 0000 ES:
>> 0000 CR0: 0000000080050033
>> Feb 16 10:38:38 localhost.localdomain kernel: CR2: 0000563d0c1ed280
>> CR3: 000000057120a001 CR4: 00000000001606e0
>> Feb 16 10:38:38 localhost.localdomain kernel: Call Trace:
>> Feb 16 10:38:38 localhost.localdomain kernel:
>> scsi_device_dev_release_usercontext+0x52/0x250
>> Feb 16 10:38:38 localhost.localdomain kernel:  ? __schedule+0x10f/0x880
>> Feb 16 10:38:38 localhost.localdomain kernel:
>> execute_in_process_context+0x21/0x60
>> Feb 16 10:38:38 localhost.localdomain kernel:  device_release+0x30/0x80
>> Feb 16 10:38:38 localhost.localdomain kernel:  kobject_put+0x80/0x1a0
>> Feb 16 10:38:38 localhost.localdomain kernel:  scsi_remove_target+0x16d/0x1b0
>> Feb 16 10:38:38 localhost.localdomain kernel:
>> __iscsi_unbind_session+0xad/0x150 [scsi_transport_iscsi]
>> Feb 16 10:38:38 localhost.localdomain kernel:  process_one_work+0x184/0x3a0
>> Feb 16 10:38:38 localhost.localdomain kernel:  worker_thread+0x2e/0x380
>> Feb 16 10:38:38 localhost.localdomain kernel:  ? process_one_work+0x3a0/0x3a0
>> Feb 16 10:38:38 localhost.localdomain kernel:  kthread+0x11a/0x130
>> Feb 16 10:38:38 localhost.localdomain kernel:  ? kthread_park+0x60/0x60
>> Feb 16 10:38:38 localhost.localdomain kernel:  ret_from_fork+0x35/0x40
>> Feb 16 10:38:38 localhost.localdomain kernel: Code: 74 2b 48 8b 32 48
>> 39 fe 75 34 48 8b 50 08 48 39 f2 75 3f b8 01 00 00 00 c3 48 89 fe 48
>> 89 c2 48 c7 c7 90 c6 0c bf e8 0d 94 cc ff <0f> 0b 48 89 fe 48 c7 c7 c8
>> c6 0c bf e8 fc 93 cc ff 0f 0b 48 89
>> Feb 16 10:38:38 localhost.localdomain kernel: RIP:
>> __list_del_entry_valid+0x4e/0x90 RSP: ffffb1504315bd88
>> Feb 16 10:38:38 localhost.localdomain kernel: ---[ end trace
>> 20bb15aa6c0307f2 ]---
>> Feb 16 10:38:38 localhost.localdomain kernel: device-mapper:
>> multipath: Failing path 65:0.
>> Feb 16 10:38:39 localhost.localdomain kernel: print_req_error: I/O
>> error, dev dm-2, sector 2097024
>> Feb 16 10:38:39 localhost.localdomain kernel: print_req_error: I/O
>> error, dev dm-2, sector 2097024
>> Feb 16 10:38:39 localhost.localdomain kernel: Buffer I/O error on dev
>> dm-2, logical block 262128, async page read
>> Feb 16 10:38:39 localhost.localdomain kernel: device-mapper:
>> multipath: Failing path 65:64.
>> Feb 16 10:38:40 localhost.localdomain kernel: device-mapper:
>> multipath: Failing path 65:112.
>> Feb 16 10:38:41 localhost.localdomain kernel: device-mapper:
>> multipath: Failing path 65:208.
>> Feb 16 10:38:42 localhost.localdomain kernel: device-mapper:
>> multipath: Failing path 8:112.
>> Feb 16 10:38:43 localhost.localdomain kernel: device-mapper:
>> multipath: Failing path 8:208.
>> Feb 16 10:38:43 localhost.localdomain kernel: device-mapper:
>> multipath: Failing path 8:208.
>> Feb 16 10:38:43 localhost.localdomain kernel: list_del corruption,
>> ffff88c1ebc26010->next is LIST_POISON1 (dead000000000100)
>>
>>
>> kernel BUG at mm/slub.c:
>>
>> [   70.433229] scsi 3:0:0:0: alua: Detached
>> [   70.433233] ------------[ cut here ]------------
>> [   70.433234] kernel BUG at mm/slub.c:295!
>> [   70.433253] invalid opcode: 0000 [#1] SMP PTI
>> [   70.433265] Modules linked in: ip6t_rpfilter ip6t_REJECT
>> nf_reject_ipv6 xt_conntrack ip_set nfnetlink ebtable_nat
>> ebtable_broute bridge stp llc ip6table_nat nf_conntrack_ipv6
>> nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_raw
>> ip6table_security iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
>> nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle iptable_raw
>> iptable_security dm_service_time ebtable_filter ebtables
>> ip6table_filter ip6_tables vmw_vsock_vmci_transport vsock sunrpc
>> sb_edac crct10dif_pclmul crc32_pclmul vmw_balloon ghash_clmulni_intel
>> intel_rapl_perf joydev i2c_piix4 vmw_vmci shpchp dm_multipath
>> scsi_dh_rdac scsi_dh_emc scsi_dh_alua iscsi_tcp libiscsi_tcp libiscsi
>> scsi_transport_iscsi xfs libcrc32c vmwgfx drm_kms_helper ttm drm
>> crc32c_intel ata_generic serio_raw vmxnet3 vmw_pvscsi pata_acpi
>> [   70.433441] CPU: 10 PID: 776 Comm: multipathd Not tainted
>> 4.14.18-300.fc27.x86_64 #1
>> [   70.433458] Hardware name: VMware, Inc. VMware Virtual
>> Platform/440BX Desktop Reference Platform, BIOS 6.00 09/21/2015
>> [   70.433483] task: ffff99ab2b5ebe80 task.stack: ffffb07f83a64000
>> [   70.433500] RIP: 0010:__slab_free+0x18b/0x300
>> [   70.433511] RSP: 0018:ffffb07f83a67cb0 EFLAGS: 00010246
>> [   70.433525] RAX: ffff99ab2b11ff00 RBX: ffff99ab2b11ff00 RCX: 00000001802a0022
>> [   70.433542] RDX: ffff99ab2b11ff00 RSI: fffff31490ac47c0 RDI: ffff99ab2f803680
>> [   70.433558] RBP: ffffb07f83a67d50 R08: 0000000000000001 R09: ffffffff815cccbe
>> [   70.433574] R10: fffff31490ac47c0 R11: 0000000000000000 R12: ffff99ab2f803680
>> [   70.433591] R13: fffff31490ac47c0 R14: ffff99ab2b11ff00 R15: ffff99ab2d742fb0
>> [   70.433607] FS:  00007f6d65a7a700(0000) GS:ffff99af3fd00000(0000)
>> knlGS:0000000000000000
>> [   70.433626] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   70.433640] CR2: 00007f4a983c67f8 CR3: 000000082a726001 CR4: 00000000001606e0
>> [   70.433688] Call Trace:
>> [   70.433701]  ? __wake_up_common_lock+0x89/0xc0
>> [   70.433715]  ? __slab_free+0x15b/0x300
>> [   70.433726]  ? scsi_dh_release_device+0x1e/0x60
>> [   70.433738]  scsi_dh_release_device+0x1e/0x60
>> [   70.433750]  scsi_device_dev_release_usercontext+0x2a/0x250
>> [   70.434206]  execute_in_process_context+0x21/0x60
>> [   70.434643]  device_release+0x30/0x80
>> [   70.435098]  kobject_put+0x80/0x1a0
>> [   70.435525]  scsi_disk_put+0x2b/0x40
>> [   70.435942]  __blkdev_put+0x197/0x1f0
>> [   70.436355]  blkdev_close+0x21/0x30
>> [   70.436756]  __fput+0xd0/0x1e0
>> [   70.437152]  task_work_run+0x84/0xa0
>> [   70.437539]  exit_to_usermode_loop+0x9e/0xa0
>> [   70.437917]  do_syscall_64+0x173/0x180
>> [   70.438133] device-mapper: multipath: Failing path 65:16.
>> [   70.438140] device-mapper: multipath: Failing path 65:0.
>> [   70.438985]  entry_SYSCALL_64_after_hwframe+0x21/0x86
>> [   70.439325] RIP: 0033:0x7f6d64a3a70c
>> [   70.439648] RSP: 002b:00007f6d65a78880 EFLAGS: 00000293 ORIG_RAX:
>> 0000000000000003
>> [   70.439974] RAX: 0000000000000000 RBX: 00007f6d4c0306f0 RCX: 00007f6d64a3a70c
>> [   70.440293] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000000000000000a
>> [   70.440605] RBP: 00007f6d4c030a68 R08: 0000000000000054 R09: 0000000000000080
>> [   70.440907] R10: 00000000ffffffdf R11: 0000000000000293 R12: 000055867dd47410
>> [   70.441199] R13: 0000000000000000 R14: 0000000000000001 R15: 00007f6d4c03be00
>> [   70.441486] Code: fe ff ff 44 0f b6 bd 7f ff ff ff 80 7d ab 00 79
>> 05 45 84 ff 74 7b 48 83 c4 78 5b 41 5c 41 5d 41 5e 41 5f 5d 49 8d 65
>> f0 41 5d c3 <0f> 0b 4c 89 d0 4c 89 55 88 45 89 fa 48 85 c0 44 0f b6 bd
>> 7f ff
>> [   70.442406] RIP: __slab_free+0x18b/0x300 RSP: ffffb07f83a67cb0
>> [   70.442735] ---[ end trace c79c468d1b715f7e ]---
>> [   70.540044] device-mapper: multipath: Failing path 8:32.
>>
> As already explained in the previous mail, there is a fixup for this in
> commit 81b6c9998979 ('scsi: core: check for device state in
> __scsi_remove_target()').
> Please check if this is applied, too.
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                Teamlead Storage & Networking
> hare@suse.de                                   +49 911 74053 688
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
> GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
> HRB 21284 (AG Nürnberg)
