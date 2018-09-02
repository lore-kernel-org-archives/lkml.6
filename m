Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFE0C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8343B20856
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LUEN3Llu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8343B20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbeIBRYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:24:07 -0400
Received: from mail-dm3nam03on0120.outbound.protection.outlook.com ([104.47.41.120]:20016
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727480AbeIBRYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUvwzdXGII83GUNcm8CUWouwmdy2DxVezqBjtOKIrNA=;
 b=LUEN3LluzgSpVAD7ZR1dI0ttqWpdR2F6G69CJvnruVPmjV6QEdUpTVI31fdQMsvJM9zFHu/9kU5BlW5QnyEOsuZknZwXrGKBgk0jaanQbGxOco27sZBpePAwUnpEpLFnZJC8bTMwV5O2v3+0fYB1mWhMsCg7QUQzgDm3rlO9AIY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 76/89] f2fs: fix to do sanity check with
 {sit,nat}_ver_bitmap_bytesize
Thread-Topic: [PATCH AUTOSEL 4.14 76/89] f2fs: fix to do sanity check with
 {sit,nat}_ver_bitmap_bytesize
Thread-Index: AQHUQr3vPF8v43rey0+JIPNQDKXCng==
Date:   Sun, 2 Sep 2018 13:07:43 +0000
Message-ID: <20180902064918.183387-76-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:Ai0cyQEbNdUhF4U5fDLG6+LsOjBxXRWBVO0vZk+1Yue0eyPrn0AQQxkP//NxKBDqQeg2M549mfz03xI/Uav6PPyV8x7giuYh3a4ATrOmmVFFtFLgbaMhHwlHnrJP9o15cOrbOm9F3EE3sEW/6ovN822O/x4WATGIWem1oavK/mk6uzfellalEHOFt1deADyte57kJHDUBZ2Lp2OZZDRyXKLkN30Pt/7JAAWdA4pvEJDUc/YT3bi9MtJLMpfYANsS9CAP7tVqA9hdLXVyuaS7BUOJ7TNzlhWbrfQ0hXJIy9LtfhmLxzzeZ1kX5syI1Tbe6ypzP2SXGwWZzuSrjAzShg/dEqqgu98eQoTaW/xd95tykneyNPundEJB1Xk9JGZepb+FnlTQMh2ubFOwx8eN7Te3N5/yXl51e1DEW8qbKiH74K6AEJyYYfAIhd1Bs19ZyhQXXEiIdYR4hjd6SE2IIQ==;5:jcFlOzewJ8aHDwYhYXSsAp7AJkWS/Mm1PCk93aXIskuSkv/nd+X0oy4FWwLv5GT6ryp0itMHwuqSuMEdH/trGU5+tmtHWzcOCcTBoTePMT6kvrj0YippetKvHSRZxBAbMGJWD4V1KbYkiNmN1qaEITGbkQJb+J8yIXj9ZBdfUIA=;7:2n707mirkn+cO/xyDY1GuIZEf5gcw/Xtz0lDKDo8lqhtlZoaRQn9VBRpfy6ONxmMuYL9zgfCrKsvXkfy/XAXKrZSzzB0y8sCaKd5+mLWVQSARsWw19ELhPIWM15LXV/UvmwywWHQePrqbH9pz2Fa4zTMnMVhIFXprFEQN6tqqTq2wxNFuQPHC7u4Jre51QzmCYNBGauWjHwNu/ddWNM+FhO1sOpFUCdl25HMO41apj88EjVReU8xdnzqGGoNP/Qa
x-ms-office365-filtering-correlation-id: e7dfbe9b-4541-48d3-d716-08d610d52334
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0149946E0205D2C78F45B1FEFB0D0@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(108815179253565);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(76176011)(6116002)(446003)(11346002)(3846002)(5660300001)(110136005)(54906003)(102836004)(26005)(22452003)(316002)(99286004)(6506007)(186003)(6666003)(107886003)(25786009)(1076002)(4326008)(305945005)(2501003)(7736002)(66066001)(97736004)(10090500001)(68736007)(5250100002)(8676002)(81156014)(81166006)(6486002)(6512007)(6306002)(6436002)(2906002)(53936002)(256004)(14444005)(217873002)(36756003)(575784001)(86362001)(10290500003)(105586002)(106356001)(72206003)(14454004)(478600001)(2616005)(476003)(486006)(966005)(2900100001)(8936002)(86612001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 59FL5nrk97RbiE0UUHvlKahu608HYKlfCSBv3oWWFINWSbHbt0XJ7rWwUPdf89resk4Pw8b06H6/5N7Ozrq9yxujecQLEmBgjrwdH29obZOyeND3eQKy2UK0lHmeiJURaYuNPJFAiLrIGAapTuwUwz/8I72OMGhTBD9zsLVJSh87ifMiMXdOufKwR3DWuo3WXARdmY7wF6o6QT0UEgpHHt3T7knNs2a056c2c/ZhLS9zCwg+QeGAs2yQ6w5QCAiHHjpvEhGgO2LFJj/5d9QdbXTONF9iYnSHb0OeE/UhLjXerLfDIXEGp252qXNfJOnl43Fw27OtKQrIOtTrgKs2uQdXTbscVXH3wdnv0bnkIaU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7dfbe9b-4541-48d3-d716-08d610d52334
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:43.4692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit c77ec61ca0a49544ca81881cc5d5529858f7e196 ]

This patch adds to do sanity check with {sit,nat}_ver_bitmap_bytesize
during mount, in order to avoid accessing across cache boundary with
this abnormal bitmap size.

- Overview
buffer overrun in build_sit_info() when mounting a crafted f2fs image

- Reproduce

- Kernel message
[  548.580867] F2FS-fs (loop0): Invalid log blocks per segment (8201)

[  548.580877] F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th sup=
erblock
[  548.584979] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  548.586568] BUG: KASAN: use-after-free in kmemdup+0x36/0x50
[  548.587715] Read of size 64 at addr ffff8801e9c265ff by task mount/1295

[  548.589428] CPU: 1 PID: 1295 Comm: mount Not tainted 4.18.0-rc1+ #4
[  548.589432] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[  548.589438] Call Trace:
[  548.589474]  dump_stack+0x7b/0xb5
[  548.589487]  print_address_description+0x70/0x290
[  548.589492]  kasan_report+0x291/0x390
[  548.589496]  ? kmemdup+0x36/0x50
[  548.589509]  check_memory_region+0x139/0x190
[  548.589514]  memcpy+0x23/0x50
[  548.589518]  kmemdup+0x36/0x50
[  548.589545]  f2fs_build_segment_manager+0x8fa/0x3410
[  548.589551]  ? __asan_loadN+0xf/0x20
[  548.589560]  ? f2fs_sanity_check_ckpt+0x1be/0x240
[  548.589566]  ? f2fs_flush_sit_entries+0x10c0/0x10c0
[  548.589587]  ? __put_user_ns+0x40/0x40
[  548.589604]  ? find_next_bit+0x57/0x90
[  548.589610]  f2fs_fill_super+0x194b/0x2b40
[  548.589617]  ? f2fs_commit_super+0x1b0/0x1b0
[  548.589637]  ? set_blocksize+0x90/0x140
[  548.589651]  mount_bdev+0x1c5/0x210
[  548.589655]  ? f2fs_commit_super+0x1b0/0x1b0
[  548.589667]  f2fs_mount+0x15/0x20
[  548.589672]  mount_fs+0x60/0x1a0
[  548.589683]  ? alloc_vfsmnt+0x309/0x360
[  548.589688]  vfs_kern_mount+0x6b/0x1a0
[  548.589699]  do_mount+0x34a/0x18c0
[  548.589710]  ? lockref_put_or_lock+0xcf/0x160
[  548.589716]  ? copy_mount_string+0x20/0x20
[  548.589728]  ? memcg_kmem_put_cache+0x1b/0xa0
[  548.589734]  ? kasan_check_write+0x14/0x20
[  548.589740]  ? _copy_from_user+0x6a/0x90
[  548.589744]  ? memdup_user+0x42/0x60
[  548.589750]  ksys_mount+0x83/0xd0
[  548.589755]  __x64_sys_mount+0x67/0x80
[  548.589781]  do_syscall_64+0x78/0x170
[  548.589797]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  548.589820] RIP: 0033:0x7f76fc331b9a
[  548.589821] Code: 48 8b 0d 01 c3 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 =
2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ce c2 2b 00 f7 d8 64 89 01 48
[  548.589880] RSP: 002b:00007ffd4f0a0e48 EFLAGS: 00000206 ORIG_RAX: 000000=
00000000a5
[  548.589890] RAX: ffffffffffffffda RBX: 000000000146c030 RCX: 00007f76fc3=
31b9a
[  548.589892] RDX: 000000000146c210 RSI: 000000000146df30 RDI: 00000000014=
74ec0
[  548.589895] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00013
[  548.589897] R10: 00000000c0ed0000 R11: 0000000000000206 R12: 00000000014=
74ec0
[  548.589900] R13: 000000000146c210 R14: 0000000000000000 R15: 00000000000=
00003

[  548.590242] The buggy address belongs to the page:
[  548.591243] page:ffffea0007a70980 count:0 mapcount:0 mapping:00000000000=
00000 index:0x0
[  548.592886] flags: 0x2ffff0000000000()
[  548.593665] raw: 02ffff0000000000 dead000000000100 dead000000000200 0000=
000000000000
[  548.595258] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000=
000000000000
[  548.603713] page dumped because: kasan: bad access detected

[  548.605203] Memory state around the buggy address:
[  548.606198]  ffff8801e9c26480: ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
 ff ff
[  548.607676]  ffff8801e9c26500: ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
 ff ff
[  548.609157] >ffff8801e9c26580: ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
 ff ff
[  548.610629]                                                             =
    ^
[  548.612088]  ffff8801e9c26600: ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
 ff ff
[  548.613674]  ffff8801e9c26680: ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
 ff ff
[  548.615141] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  548.616613] Disabling lock debugging due to kernel taint
[  548.622871] WARNING: CPU: 1 PID: 1295 at mm/page_alloc.c:4065 __alloc_pa=
ges_slowpath+0xe4a/0x1420
[  548.622878] Modules linked in: snd_hda_codec_generic snd_hda_intel snd_h=
da_codec snd_hwdep snd_hda_core snd_pcm snd_timer snd mac_hid i2c_piix4 sou=
ndcore ib_iser rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi =
scsi_transport_iscsi raid10 raid456 async_raid6_recov async_memcpy async_pq=
 async_xor async_tx raid1 raid0 multipath linear 8139too crct10dif_pclmul c=
rc32_pclmul qxl drm_kms_helper syscopyarea aesni_intel sysfillrect sysimgbl=
t fb_sys_fops ttm drm aes_x86_64 crypto_simd cryptd 8139cp glue_helper mii =
pata_acpi floppy
[  548.623217] CPU: 1 PID: 1295 Comm: mount Tainted: G    B             4.1=
8.0-rc1+ #4
[  548.623219] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[  548.623226] RIP: 0010:__alloc_pages_slowpath+0xe4a/0x1420
[  548.623227] Code: ff ff 01 89 85 c8 fe ff ff e9 91 fc ff ff 41 89 c5 e9 =
5c fc ff ff 0f 0b 89 f8 25 ff ff f7 ff 89 85 8c fe ff ff e9 d5 f2 ff ff <0f=
> 0b e9 65 f2 ff ff 65 8b 05 38 81 d2 47 f6 c4 01 74 1c 65 48 8b
[  548.623281] RSP: 0018:ffff8801f28c7678 EFLAGS: 00010246
[  548.623284] RAX: 0000000000000000 RBX: 00000000006040c0 RCX: ffffffffb82=
f73b7
[  548.623287] RDX: 1ffff1003e518eeb RSI: 000000000000000c RDI: 00000000000=
00000
[  548.623290] RBP: ffff8801f28c7880 R08: 0000000000000000 R09: ffffed0047f=
ff2c5
[  548.623292] R10: 0000000000000001 R11: ffffed0047fff2c4 R12: ffff8801e88=
de040
[  548.623295] R13: 00000000006040c0 R14: 000000000000000c R15: ffff8801f28=
c7938
[  548.623299] FS:  00007f76fca51840(0000) GS:ffff8801f6f00000(0000) knlGS:=
0000000000000000
[  548.623302] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  548.623304] CR2: 00007f19b9171760 CR3: 00000001ed952000 CR4: 00000000000=
006e0
[  548.623317] Call Trace:
[  548.623325]  ? kasan_check_read+0x11/0x20
[  548.623330]  ? __zone_watermark_ok+0x92/0x240
[  548.623336]  ? get_page_from_freelist+0x1c3/0x1d90
[  548.623347]  ? _raw_spin_lock_irqsave+0x2a/0x60
[  548.623353]  ? warn_alloc+0x250/0x250
[  548.623358]  ? save_stack+0x46/0xd0
[  548.623361]  ? kasan_kmalloc+0xad/0xe0
[  548.623366]  ? __isolate_free_page+0x2a0/0x2a0
[  548.623370]  ? mount_fs+0x60/0x1a0
[  548.623374]  ? vfs_kern_mount+0x6b/0x1a0
[  548.623378]  ? do_mount+0x34a/0x18c0
[  548.623383]  ? ksys_mount+0x83/0xd0
[  548.623387]  ? __x64_sys_mount+0x67/0x80
[  548.623391]  ? do_syscall_64+0x78/0x170
[  548.623396]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  548.623401]  __alloc_pages_nodemask+0x3c5/0x400
[  548.623407]  ? __alloc_pages_slowpath+0x1420/0x1420
[  548.623412]  ? __mutex_lock_slowpath+0x20/0x20
[  548.623417]  ? kvmalloc_node+0x31/0x80
[  548.623424]  alloc_pages_current+0x75/0x110
[  548.623436]  kmalloc_order+0x24/0x60
[  548.623442]  kmalloc_order_trace+0x24/0xb0
[  548.623448]  __kmalloc_track_caller+0x207/0x220
[  548.623455]  ? f2fs_build_node_manager+0x399/0xbb0
[  548.623460]  kmemdup+0x20/0x50
[  548.623465]  f2fs_build_node_manager+0x399/0xbb0
[  548.623470]  f2fs_fill_super+0x195e/0x2b40
[  548.623477]  ? f2fs_commit_super+0x1b0/0x1b0
[  548.623481]  ? set_blocksize+0x90/0x140
[  548.623486]  mount_bdev+0x1c5/0x210
[  548.623489]  ? f2fs_commit_super+0x1b0/0x1b0
[  548.623495]  f2fs_mount+0x15/0x20
[  548.623498]  mount_fs+0x60/0x1a0
[  548.623503]  ? alloc_vfsmnt+0x309/0x360
[  548.623508]  vfs_kern_mount+0x6b/0x1a0
[  548.623513]  do_mount+0x34a/0x18c0
[  548.623518]  ? lockref_put_or_lock+0xcf/0x160
[  548.623523]  ? copy_mount_string+0x20/0x20
[  548.623528]  ? memcg_kmem_put_cache+0x1b/0xa0
[  548.623533]  ? kasan_check_write+0x14/0x20
[  548.623537]  ? _copy_from_user+0x6a/0x90
[  548.623542]  ? memdup_user+0x42/0x60
[  548.623547]  ksys_mount+0x83/0xd0
[  548.623552]  __x64_sys_mount+0x67/0x80
[  548.623557]  do_syscall_64+0x78/0x170
[  548.623562]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  548.623566] RIP: 0033:0x7f76fc331b9a
[  548.623567] Code: 48 8b 0d 01 c3 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 =
2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ce c2 2b 00 f7 d8 64 89 01 48
[  548.623632] RSP: 002b:00007ffd4f0a0e48 EFLAGS: 00000206 ORIG_RAX: 000000=
00000000a5
[  548.623636] RAX: ffffffffffffffda RBX: 000000000146c030 RCX: 00007f76fc3=
31b9a
[  548.623639] RDX: 000000000146c210 RSI: 000000000146df30 RDI: 00000000014=
74ec0
[  548.623641] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00013
[  548.623643] R10: 00000000c0ed0000 R11: 0000000000000206 R12: 00000000014=
74ec0
[  548.623646] R13: 000000000146c210 R14: 0000000000000000 R15: 00000000000=
00003
[  548.623650] ---[ end trace 4ce02f25ff7d3df5 ]---
[  548.623656] F2FS-fs (loop0): Failed to initialize F2FS node manager
[  548.627936] F2FS-fs (loop0): Invalid log blocks per segment (8201)

[  548.627940] F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th sup=
erblock
[  548.635835] F2FS-fs (loop0): Failed to initialize F2FS node manager

- Location
https://elixir.bootlin.com/linux/v4.18-rc1/source/fs/f2fs/segment.c#L3578

	sit_i->sit_bitmap =3D kmemdup(src_bitmap, bitmap_size, GFP_KERNEL);

Buffer overrun happens when doing memcpy. I suspect there is missing (incon=
sistent) checks on bitmap_size.

Reported by Wen Xu (wen.xu@gatech.edu) from SSLab, Gatech.

Reported-by: Wen Xu <wen.xu@gatech.edu>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/super.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 400c00058bad..eae35909fa51 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1883,12 +1883,17 @@ int sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	struct f2fs_checkpoint *ckpt =3D F2FS_CKPT(sbi);
 	unsigned int ovp_segments, reserved_segments;
 	unsigned int main_segs, blocks_per_seg;
+	unsigned int sit_segs, nat_segs;
+	unsigned int sit_bitmap_size, nat_bitmap_size;
+	unsigned int log_blocks_per_seg;
 	int i;
=20
 	total =3D le32_to_cpu(raw_super->segment_count);
 	fsmeta =3D le32_to_cpu(raw_super->segment_count_ckpt);
-	fsmeta +=3D le32_to_cpu(raw_super->segment_count_sit);
-	fsmeta +=3D le32_to_cpu(raw_super->segment_count_nat);
+	sit_segs =3D le32_to_cpu(raw_super->segment_count_sit);
+	fsmeta +=3D sit_segs;
+	nat_segs =3D le32_to_cpu(raw_super->segment_count_nat);
+	fsmeta +=3D nat_segs;
 	fsmeta +=3D le32_to_cpu(ckpt->rsvd_segment_count);
 	fsmeta +=3D le32_to_cpu(raw_super->segment_count_ssa);
=20
@@ -1919,6 +1924,18 @@ int sanity_check_ckpt(struct f2fs_sb_info *sbi)
 			return 1;
 	}
=20
+	sit_bitmap_size =3D le32_to_cpu(ckpt->sit_ver_bitmap_bytesize);
+	nat_bitmap_size =3D le32_to_cpu(ckpt->nat_ver_bitmap_bytesize);
+	log_blocks_per_seg =3D le32_to_cpu(raw_super->log_blocks_per_seg);
+
+	if (sit_bitmap_size !=3D ((sit_segs / 2) << log_blocks_per_seg) / 8 ||
+		nat_bitmap_size !=3D ((nat_segs / 2) << log_blocks_per_seg) / 8) {
+		f2fs_msg(sbi->sb, KERN_ERR,
+			"Wrong bitmap size: sit: %u, nat:%u",
+			sit_bitmap_size, nat_bitmap_size);
+		return 1;
+	}
+
 	if (unlikely(f2fs_cp_error(sbi))) {
 		f2fs_msg(sbi->sb, KERN_ERR, "A bug case: need to run fsck");
 		return 1;
--=20
2.17.1
