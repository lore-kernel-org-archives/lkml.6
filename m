Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF256C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E13D20837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VsTdMaS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E13D20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbeIBRoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:44:12 -0400
Received: from mail-eopbgr680109.outbound.protection.outlook.com ([40.107.68.109]:27920
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727023AbeIBRWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNCUSE9zrDo9R+2Zap+lFl/Tvuq5iI3z0X/aNmTjnUk=;
 b=VsTdMaS8ioaaSfS3VOwj17RJp4XF1YRjDeGik6Mot7wc0fS/AZuFmjNWl7BDVmKwoo86+Uogn8vnRk/p/lWDRqYJVy0GjwFU/DSicncMWEaBNpRKGZ7lcUWQjKKk1SLSYt+AjnHcawqwjk6SqsdgPwJ2yqXFZede/1MA7bpG/o0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:06:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 121/131] f2fs: fix to do sanity check with
 extra_attr feature
Thread-Topic: [PATCH AUTOSEL 4.18 121/131] f2fs: fix to do sanity check with
 extra_attr feature
Thread-Index: AQHUQr2jSfFGJC3XEUasI3tl8xfcIQ==
Date:   Sun, 2 Sep 2018 13:05:36 +0000
Message-ID: <20180902064601.183036-121-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:SuUXht5kSJdHsPw9tzEKPzIIr7B+W0Kw679aokSrHW5yXbcHuwmmNIzXQ/8VOdRBsQvH14x6U4foF+7ej9VO3SkCmDsw8FWSkQSkpU5rlexwu+1twERd4hfiPDj+BVWabBkalaFAabBa2rmHkMTHdkh8jlTEkJKpetaSmYlHgX7hv72gbzb0KccAPiRSweiTO+IIcIqVU7XnPj8svWIlIc3+rd+YOvb77Ta47ab+1R+ciOu2Uxr/C5HiadpuxOenPwbuGdpCVM4EnKWhtw4L7VVEPQU41dVMwhpRferHjP8GImcoW0ZU6kJJq23kHZ0nySy/BXT3RpP4m5mHpMPZX96bkjOUxranehVvZoWVWSKlr+sayAwE1Wo5nkfj38PKHb9Y/nSYyK/Brkj/QuWkwfy9HQv4fqb0Q19Fim63w73r0PPf0QLtqyMQ0BCZv1XAkbpziwKkOU/wI4q7LAwZYA==;5:V3W4wKuYA+WyOo2ofSVz/88/WTX4k6/u6nwPIgUPFjlqiLT2ZkaJuIqeLjycAAgaeb4ibvZMWVkuZweCX28c0F6ihYqWp9CCaQSfGR2gYuMF5WqU6XQVuM2UAHRduz0IFj7aYp+LT58h97WU5FDnGhPwEmAeWTJ5BLM5XAo9HAM=;7:iMxL3ch/ibiObhkiMGPy0DMWYhkxJJGr+wRXwmY4Yez7lglfcX+RDbivDeVTyeIK1pyxjG/3tBfWmNWPoD5QkkGnm4kIikKCU4ZyraqD0rGg4XEmAvDpVJgkMZVhRjTlCf2uvrh+D9Wr/VqlfvVP0OySX9OUqavzgOd2JuzmkFo4EZeVKHcqh//CZVJtDJ4m+I2Kg2ccCA2+f68GIThlXULl8z4RFEigxbRhvyeoQvsFGChYt2cY/mKUyB+idbNY
x-ms-office365-filtering-correlation-id: e1a00dc9-3364-4b86-472b-08d610d4dc14
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB062945B1F2C81BA6D773A502FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(50582790962513)(108815179253565);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(6486002)(8936002)(6512007)(22452003)(53936002)(6436002)(66066001)(4326008)(186003)(25786009)(575784001)(86362001)(2900100001)(107886003)(76176011)(486006)(68736007)(36756003)(99286004)(2501003)(6666003)(5250100002)(110136005)(54906003)(106356001)(316002)(105586002)(10290500003)(72206003)(10090500001)(8676002)(478600001)(14454004)(5660300001)(476003)(1076002)(3846002)(305945005)(446003)(6116002)(217873002)(6346003)(11346002)(97736004)(81156014)(7736002)(81166006)(2906002)(14444005)(102836004)(86612001)(26005)(6506007)(256004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: JKdD822YBwvB0inqdV51MMNLXuT+Hv4tdmjvVUdGYD9XGVng4S9hWH7KhxDUYrTnpzTL3fvmTo064s60UxHJ/QmlZK0C56TErKMU0v/jeIC2vROpZxx3/95sYXkDfsV/X8W9SAJP/9X//D+bCu6Zp+aDLgXSNiqbnY2sYBkzUPAVQTtlCpGMM/CJxzbakMSlCcTydpncCDwNNPD+SIVdDcjrBEqf+Vm07fpyY54v6bnN0e9zPwNqUu/2otn5TCiiMQqK8BoXFNLcTkKG/aRUlRxq0YXfLQJxyPjxyvj5Ci+juaoifo6xWcidwz0Jr1V6t01gfZBvqLgguUZXeMZcNnyyzCrLdcQHe0cC5w2OQPs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a00dc9-3364-4b86-472b-08d610d4dc14
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:36.8290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 76d56d4ab4f2a9e4f085c7d77172194ddaccf7d2 ]

If FI_EXTRA_ATTR is set in inode by fuzzing, inode.i_addr[0] will be
parsed as inode.i_extra_isize, then in __recover_inline_status, inline
data address will beyond boundary of page, result in accessing invalid
memory.

So in this condition, during reading inode page, let's do sanity check
with EXTRA_ATTR feature of fs and extra_attr bit of inode, if they're
inconsistent, deny to load this inode.

- Overview
Out-of-bound access in f2fs_iget() when mounting a corrupted f2fs image

- Reproduce

The following message will be got in KASAN build of 4.18 upstream kernel.
[  819.392227] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  819.393901] BUG: KASAN: slab-out-of-bounds in f2fs_iget+0x736/0x1530
[  819.395329] Read of size 4 at addr ffff8801f099c968 by task mount/1292

[  819.397079] CPU: 1 PID: 1292 Comm: mount Not tainted 4.18.0-rc1+ #4
[  819.397082] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[  819.397088] Call Trace:
[  819.397124]  dump_stack+0x7b/0xb5
[  819.397154]  print_address_description+0x70/0x290
[  819.397159]  kasan_report+0x291/0x390
[  819.397163]  ? f2fs_iget+0x736/0x1530
[  819.397176]  check_memory_region+0x139/0x190
[  819.397182]  __asan_loadN+0xf/0x20
[  819.397185]  f2fs_iget+0x736/0x1530
[  819.397197]  f2fs_fill_super+0x1b4f/0x2b40
[  819.397202]  ? f2fs_fill_super+0x1b4f/0x2b40
[  819.397208]  ? f2fs_commit_super+0x1b0/0x1b0
[  819.397227]  ? set_blocksize+0x90/0x140
[  819.397241]  mount_bdev+0x1c5/0x210
[  819.397245]  ? f2fs_commit_super+0x1b0/0x1b0
[  819.397252]  f2fs_mount+0x15/0x20
[  819.397256]  mount_fs+0x60/0x1a0
[  819.397267]  ? alloc_vfsmnt+0x309/0x360
[  819.397272]  vfs_kern_mount+0x6b/0x1a0
[  819.397282]  do_mount+0x34a/0x18c0
[  819.397300]  ? lockref_put_or_lock+0xcf/0x160
[  819.397306]  ? copy_mount_string+0x20/0x20
[  819.397318]  ? memcg_kmem_put_cache+0x1b/0xa0
[  819.397324]  ? kasan_check_write+0x14/0x20
[  819.397334]  ? _copy_from_user+0x6a/0x90
[  819.397353]  ? memdup_user+0x42/0x60
[  819.397359]  ksys_mount+0x83/0xd0
[  819.397365]  __x64_sys_mount+0x67/0x80
[  819.397388]  do_syscall_64+0x78/0x170
[  819.397403]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  819.397422] RIP: 0033:0x7f54c667cb9a
[  819.397424] Code: 48 8b 0d 01 c3 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 =
2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ce c2 2b 00 f7 d8 64 89 01 48
[  819.397483] RSP: 002b:00007ffd8f46cd08 EFLAGS: 00000202 ORIG_RAX: 000000=
00000000a5
[  819.397496] RAX: ffffffffffffffda RBX: 0000000000dfa030 RCX: 00007f54c66=
7cb9a
[  819.397498] RDX: 0000000000dfa210 RSI: 0000000000dfbf30 RDI: 0000000000e=
02ec0
[  819.397501] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00013
[  819.397503] R10: 00000000c0ed0000 R11: 0000000000000202 R12: 0000000000e=
02ec0
[  819.397505] R13: 0000000000dfa210 R14: 0000000000000000 R15: 00000000000=
00003

[  819.397866] Allocated by task 139:
[  819.398702]  save_stack+0x46/0xd0
[  819.398705]  kasan_kmalloc+0xad/0xe0
[  819.398709]  kasan_slab_alloc+0x11/0x20
[  819.398713]  kmem_cache_alloc+0xd1/0x1e0
[  819.398717]  dup_fd+0x50/0x4c0
[  819.398740]  copy_process.part.37+0xbed/0x32e0
[  819.398744]  _do_fork+0x16e/0x590
[  819.398748]  __x64_sys_clone+0x69/0x80
[  819.398752]  do_syscall_64+0x78/0x170
[  819.398756]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[  819.399097] Freed by task 159:
[  819.399743]  save_stack+0x46/0xd0
[  819.399747]  __kasan_slab_free+0x13c/0x1a0
[  819.399750]  kasan_slab_free+0xe/0x10
[  819.399754]  kmem_cache_free+0x89/0x1e0
[  819.399757]  put_files_struct+0x132/0x150
[  819.399761]  exit_files+0x62/0x70
[  819.399766]  do_exit+0x47b/0x1390
[  819.399770]  do_group_exit+0x86/0x130
[  819.399774]  __x64_sys_exit_group+0x2c/0x30
[  819.399778]  do_syscall_64+0x78/0x170
[  819.399782]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[  819.400115] The buggy address belongs to the object at ffff8801f099c680
                which belongs to the cache files_cache of size 704
[  819.403234] The buggy address is located 40 bytes to the right of
                704-byte region [ffff8801f099c680, ffff8801f099c940)
[  819.405689] The buggy address belongs to the page:
[  819.406709] page:ffffea0007c26700 count:1 mapcount:0 mapping:ffff8801f69=
a3340 index:0xffff8801f099d380 compound_mapcount: 0
[  819.408984] flags: 0x2ffff0000008100(slab|head)
[  819.409932] raw: 02ffff0000008100 ffffea00077fb600 0000000200000002 ffff=
8801f69a3340
[  819.411514] raw: ffff8801f099d380 0000000080130000 00000001ffffffff 0000=
000000000000
[  819.413073] page dumped because: kasan: bad access detected

[  819.414539] Memory state around the buggy address:
[  819.415521]  ffff8801f099c800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[  819.416981]  ffff8801f099c880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[  819.418454] >ffff8801f099c900: fb fb fb fb fb fb fb fb fc fc fc fc fc fc=
 fc fc
[  819.419921]                                                           ^
[  819.421265]  ffff8801f099c980: fc fc fc fc fc fc fc fc fb fb fb fb fb fb=
 fb fb
[  819.422745]  ffff8801f099ca00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[  819.424206] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  819.425668] Disabling lock debugging due to kernel taint
[  819.457463] F2FS-fs (loop0): Mounted with checkpoint version =3D 3

The kernel still mounts the image. If you run the following program on the =
mounted folder mnt,

(poc.c)

static void activity(char *mpoint) {

  char *foo_bar_baz;
  int err;

  static int buf[8192];
  memset(buf, 0, sizeof(buf));

  err =3D asprintf(&foo_bar_baz, "%s/foo/bar/baz", mpoint);
    int fd =3D open(foo_bar_baz, O_RDONLY, 0);
  if (fd >=3D 0) {
      read(fd, (char *)buf, 11);
      close(fd);
  }
}

int main(int argc, char *argv[]) {
  activity(argv[1]);
  return 0;
}

You can get kernel crash:
[  819.457463] F2FS-fs (loop0): Mounted with checkpoint version =3D 3
[  918.028501] BUG: unable to handle kernel paging request at ffffed0048000=
d82
[  918.044020] PGD 23ffee067 P4D 23ffee067 PUD 23fbef067 PMD 0
[  918.045207] Oops: 0000 [#1] SMP KASAN PTI
[  918.046048] CPU: 0 PID: 1309 Comm: poc Tainted: G    B             4.18.=
0-rc1+ #4
[  918.047573] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[  918.049552] RIP: 0010:check_memory_region+0x5e/0x190
[  918.050565] Code: f8 49 c1 e8 03 49 89 db 49 c1 eb 03 4d 01 cb 4d 01 c1 =
4d 8d 63 01 4c 89 c8 4d 89 e2 4d 29 ca 49 83 fa 10 7f 3d 4d 85 d2 74 32 <41=
> 80 39 00 75 23 48 b8 01 00 00 00 00 fc ff df 4d 01 d1 49 01 c0
[  918.054322] RSP: 0018:ffff8801e3a1f258 EFLAGS: 00010202
[  918.055400] RAX: ffffed0048000d82 RBX: ffff880240006c11 RCX: ffffffffb88=
67d14
[  918.056832] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff8802400=
06c10
[  918.058253] RBP: ffff8801e3a1f268 R08: 1ffff10048000d82 R09: ffffed00480=
00d82
[  918.059717] R10: 0000000000000001 R11: ffffed0048000d82 R12: ffffed00480=
00d83
[  918.061159] R13: ffff8801e3a1f390 R14: 0000000000000000 R15: ffff8802400=
06c08
[  918.062614] FS:  00007fac9732c700(0000) GS:ffff8801f6e00000(0000) knlGS:=
0000000000000000
[  918.064246] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  918.065412] CR2: ffffed0048000d82 CR3: 00000001df77a000 CR4: 00000000000=
006f0
[  918.066882] Call Trace:
[  918.067410]  __asan_loadN+0xf/0x20
[  918.068149]  f2fs_find_target_dentry+0xf4/0x270
[  918.069083]  ? __get_node_page+0x331/0x5b0
[  918.069925]  f2fs_find_in_inline_dir+0x24b/0x310
[  918.070881]  ? f2fs_recover_inline_data+0x4c0/0x4c0
[  918.071905]  ? unwind_next_frame.part.5+0x34f/0x490
[  918.072901]  ? unwind_dump+0x290/0x290
[  918.073695]  ? is_bpf_text_address+0xe/0x20
[  918.074566]  __f2fs_find_entry+0x599/0x670
[  918.075408]  ? kasan_unpoison_shadow+0x36/0x50
[  918.076315]  ? kasan_kmalloc+0xad/0xe0
[  918.077100]  ? memcg_kmem_put_cache+0x55/0xa0
[  918.077998]  ? f2fs_find_target_dentry+0x270/0x270
[  918.079006]  ? d_set_d_op+0x30/0x100
[  918.079749]  ? __d_lookup_rcu+0x69/0x2e0
[  918.080556]  ? __d_alloc+0x275/0x450
[  918.081297]  ? kasan_check_write+0x14/0x20
[  918.082135]  ? memset+0x31/0x40
[  918.082820]  ? fscrypt_setup_filename+0x1ec/0x4c0
[  918.083782]  ? d_alloc_parallel+0x5bb/0x8c0
[  918.084640]  f2fs_find_entry+0xe9/0x110
[  918.085432]  ? __f2fs_find_entry+0x670/0x670
[  918.086308]  ? kasan_check_write+0x14/0x20
[  918.087163]  f2fs_lookup+0x297/0x590
[  918.087902]  ? f2fs_link+0x2b0/0x2b0
[  918.088646]  ? legitimize_path.isra.29+0x61/0xa0
[  918.089589]  __lookup_slow+0x12e/0x240
[  918.090371]  ? may_delete+0x2b0/0x2b0
[  918.091123]  ? __nd_alloc_stack+0xa0/0xa0
[  918.091944]  lookup_slow+0x44/0x60
[  918.092642]  walk_component+0x3ee/0xa40
[  918.093428]  ? is_bpf_text_address+0xe/0x20
[  918.094283]  ? pick_link+0x3e0/0x3e0
[  918.095047]  ? in_group_p+0xa5/0xe0
[  918.095771]  ? generic_permission+0x53/0x1e0
[  918.096666]  ? security_inode_permission+0x1d/0x70
[  918.097646]  ? inode_permission+0x7a/0x1f0
[  918.098497]  link_path_walk+0x2a2/0x7b0
[  918.099298]  ? apparmor_capget+0x3d0/0x3d0
[  918.100140]  ? walk_component+0xa40/0xa40
[  918.100958]  ? path_init+0x2e6/0x580
[  918.101695]  path_openat+0x1bb/0x2160
[  918.102471]  ? __save_stack_trace+0x92/0x100
[  918.103352]  ? save_stack+0xb5/0xd0
[  918.104070]  ? vfs_unlink+0x250/0x250
[  918.104822]  ? save_stack+0x46/0xd0
[  918.105538]  ? kasan_slab_alloc+0x11/0x20
[  918.106370]  ? kmem_cache_alloc+0xd1/0x1e0
[  918.107213]  ? getname_flags+0x76/0x2c0
[  918.107997]  ? getname+0x12/0x20
[  918.108677]  ? do_sys_open+0x14b/0x2c0
[  918.109450]  ? __x64_sys_open+0x4c/0x60
[  918.110255]  ? do_syscall_64+0x78/0x170
[  918.111083]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  918.112148]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  918.113204]  ? f2fs_empty_inline_dir+0x1e0/0x1e0
[  918.114150]  ? timespec64_trunc+0x5c/0x90
[  918.114993]  ? wb_io_lists_depopulated+0x1a/0xc0
[  918.115937]  ? inode_io_list_move_locked+0x102/0x110
[  918.116949]  do_filp_open+0x12b/0x1d0
[  918.117709]  ? may_open_dev+0x50/0x50
[  918.118475]  ? kasan_kmalloc+0xad/0xe0
[  918.119246]  do_sys_open+0x17c/0x2c0
[  918.119983]  ? do_sys_open+0x17c/0x2c0
[  918.120751]  ? filp_open+0x60/0x60
[  918.121463]  ? task_work_run+0x4d/0xf0
[  918.122237]  __x64_sys_open+0x4c/0x60
[  918.123001]  do_syscall_64+0x78/0x170
[  918.123759]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  918.124802] RIP: 0033:0x7fac96e3e040
[  918.125537] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 =
00 00 00 0f 1f 44 00 00 83 3d 09 27 2d 00 00 75 10 b8 02 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 7e e0 01 00 48 89 04 24
[  918.129341] RSP: 002b:00007fff1b37f848 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000002
[  918.130870] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fac96e=
3e040
[  918.132295] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000012=
2d080
[  918.133748] RBP: 00007fff1b37f9b0 R08: 00007fac9710bbd8 R09: 00000000000=
00001
[  918.135209] R10: 000000000000069d R11: 0000000000000246 R12: 00000000004=
00c20
[  918.136650] R13: 00007fff1b37fab0 R14: 0000000000000000 R15: 00000000000=
00000
[  918.138093] Modules linked in: snd_hda_codec_generic snd_hda_intel snd_h=
da_codec snd_hwdep snd_hda_core snd_pcm snd_timer snd mac_hid i2c_piix4 sou=
ndcore ib_iser rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi =
scsi_transport_iscsi raid10 raid456 async_raid6_recov async_memcpy async_pq=
 async_xor async_tx raid1 raid0 multipath linear 8139too crct10dif_pclmul c=
rc32_pclmul qxl drm_kms_helper syscopyarea aesni_intel sysfillrect sysimgbl=
t fb_sys_fops ttm drm aes_x86_64 crypto_simd cryptd 8139cp glue_helper mii =
pata_acpi floppy
[  918.147924] CR2: ffffed0048000d82
[  918.148619] ---[ end trace 4ce02f25ff7d3df5 ]---
[  918.149563] RIP: 0010:check_memory_region+0x5e/0x190
[  918.150576] Code: f8 49 c1 e8 03 49 89 db 49 c1 eb 03 4d 01 cb 4d 01 c1 =
4d 8d 63 01 4c 89 c8 4d 89 e2 4d 29 ca 49 83 fa 10 7f 3d 4d 85 d2 74 32 <41=
> 80 39 00 75 23 48 b8 01 00 00 00 00 fc ff df 4d 01 d1 49 01 c0
[  918.154360] RSP: 0018:ffff8801e3a1f258 EFLAGS: 00010202
[  918.155411] RAX: ffffed0048000d82 RBX: ffff880240006c11 RCX: ffffffffb88=
67d14
[  918.156833] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff8802400=
06c10
[  918.158257] RBP: ffff8801e3a1f268 R08: 1ffff10048000d82 R09: ffffed00480=
00d82
[  918.159722] R10: 0000000000000001 R11: ffffed0048000d82 R12: ffffed00480=
00d83
[  918.161149] R13: ffff8801e3a1f390 R14: 0000000000000000 R15: ffff8802400=
06c08
[  918.162587] FS:  00007fac9732c700(0000) GS:ffff8801f6e00000(0000) knlGS:=
0000000000000000
[  918.164203] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  918.165356] CR2: ffffed0048000d82 CR3: 00000001df77a000 CR4: 00000000000=
006f0

Reported-by: Wen Xu <wen.xu@gatech.edu>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/inode.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index f121c864f4c0..cf0f944fcaea 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -197,6 +197,16 @@ static bool sanity_check_inode(struct inode *inode)
 			__func__, inode->i_ino);
 		return false;
 	}
+
+	if (f2fs_has_extra_attr(inode) &&
+			!f2fs_sb_has_extra_attr(sbi->sb)) {
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_msg(sbi->sb, KERN_WARNING,
+			"%s: inode (ino=3D%lx) is with extra_attr, "
+			"but extra_attr feature is off",
+			__func__, inode->i_ino);
+		return false;
+	}
 	return true;
 }
=20
@@ -249,6 +259,11 @@ static int do_read_inode(struct inode *inode)
=20
 	get_inline_info(inode, ri);
=20
+	if (!sanity_check_inode(inode)) {
+		f2fs_put_page(node_page, 1);
+		return -EINVAL;
+	}
+
 	fi->i_extra_isize =3D f2fs_has_extra_attr(inode) ?
 					le16_to_cpu(ri->i_extra_isize) : 0;
=20
@@ -330,10 +345,6 @@ struct inode *f2fs_iget(struct super_block *sb, unsign=
ed long ino)
 	ret =3D do_read_inode(inode);
 	if (ret)
 		goto bad_inode;
-	if (!sanity_check_inode(inode)) {
-		ret =3D -EINVAL;
-		goto bad_inode;
-	}
 make_now:
 	if (ino =3D=3D F2FS_NODE_INO(sbi)) {
 		inode->i_mapping->a_ops =3D &f2fs_node_aops;
--=20
2.17.1
