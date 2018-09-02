Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70975C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3CD2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XFeoavjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3CD2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbeIBRpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:45:09 -0400
Received: from mail-eopbgr710105.outbound.protection.outlook.com ([40.107.71.105]:27886
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728601AbeIBRV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFhJRw50s9YihsaVtqbtuQsW/ar6JhbxzTy2xICjW4Y=;
 b=XFeoavjp4hNhogvlkggvuu4VkooNUpy5HTR5Iis+JsyZ6ayvVL7o+lTo0DYa/1TjJsNptS1lAGU7agRGWJ+9ZGcsilnE3DFRB31PLFDAFfgUpOQnyxJOCNcjWHFPLJbNGwjBoIfAfZTPw5+O2FQGQRkO/6OJBPIQBDHg4WD8y88=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:05:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 108/131] f2fs: fix to do sanity check with
 secs_per_zone
Thread-Topic: [PATCH AUTOSEL 4.18 108/131] f2fs: fix to do sanity check with
 secs_per_zone
Thread-Index: AQHUQr2Z6MEfdPaxYU+14Wr2xdvpKg==
Date:   Sun, 2 Sep 2018 13:05:19 +0000
Message-ID: <20180902064601.183036-108-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:0AkEdCEueraIaL4QCojmsQPzt2oMtZ2u5BDW5k2BdG/qYQdfjFUgypyGJfjRRlLRsuSjqkNXxmpPfdhIbuD9RcW6HJBWlVSwfNkokPn9GxLDZX6mq57chZ0JGyqIZ5rxKRj3ciobEUZneSQKIcRPHfaYqfTj70x75Kee8MNWz81qLogpY4uzQnxevK8QUuERYm7JQpWwAEuVdypLkz0TrvnkEK9aeoCfcQofViFFgQICgoYsQyEldFesnrah9YiatNAvVA0WNRgObe+5lwKC+LvDoxRITa66IyhrVi6k83wDXaI2aVWOSU4M6fe9FJMvTnas5ytr3pE1PPRt+ePrShmoan14R4dr0zdY5O3qkB4EoiG0l+qF2aBfoAG1ZdXLTc2myup7Z/8KPw5vEHXSsQpOPerU293FBxJ3UvA8utt6r1I1uv8E7CtrJpMMz4HCo4YZtoVm2XyYTfoiXyPnmQ==;5:zWgWmgvD1iFMEzaIoFMpjCWQBryhBXvQ7svMtDIYE8p6niesQ7pt7EG28nkMwqayu2HCnrN/tIMAsqeYuYuEqGqvlWWQi3w14/GRHbJnI/pe1eWyaKB7xqfeOsdWeIW6q4wSrK5DMHSMXgpWorVxkw6VkZcMl2V1zzBYl1XkNpU=;7:YPcDrTK++jA7cernv2EhS0ZQrv0pmm90DN3/skkV5SKOJZ4/1OzZkwFd+yUpqsLiBjCisdnfadgUJ/Ac0jLrOtjKiv4bzdgIq3ySPkEFBogR3jl4piODPId/IEP07964CKHGbdo6tdbLENbNVlO9igZynEIbuil/ooSQx/YF35TN0AwNzF9gj7G+uiWXVvS3EmdvYrMqK/lKsLVbdWN6c6rGFoReVRiiMZCuYBUglQl/27iFBS3BCJrBOtrT9U1k
x-ms-office365-filtering-correlation-id: 79e82bf0-fa50-4309-439b-08d610d4c728
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0184DD8764FD74C2F206ECA1FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6306002)(6512007)(53936002)(6436002)(97736004)(105586002)(22452003)(25786009)(106356001)(107886003)(4326008)(6486002)(110136005)(54906003)(316002)(10090500001)(5250100002)(256004)(66066001)(36756003)(6116002)(2501003)(26005)(6506007)(5660300001)(3846002)(81156014)(76176011)(99286004)(102836004)(1076002)(8676002)(81166006)(10290500003)(2616005)(68736007)(476003)(2906002)(8936002)(11346002)(72206003)(186003)(305945005)(7736002)(486006)(6666003)(217873002)(966005)(86362001)(2900100001)(86612001)(446003)(575784001)(14454004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7efCpVCuRxq3YKJANadvsJHY83bWYK1HmkBP/R9Xvt61RRZgESqY+jvnNNqgpTzJYV2djr9eeXI+ePxChaIaFi/dAZQChxHHPmFIyqX8Eh+7OVRUqtPDTfi6dXcDIsRuvlJPS0W06CHlffJX85tAPIC8/z/boK7uFm+G3AdTUt5rkNDkB5W8pu+MRgf3jlxSV7Y6EKryfND5F/F/o4uTmI1zKjXu2wdveQNCMEce0Ow8S3lKQlJTjkdJ5yBsiT+YPj4/Q925bQEWyc94VIi6R+O7qZ3s2fNg90DYJNYcZXHCX6IKBNpr3BQp4G5agXVTRfiG/rYZuTviMH6FX6Ik7fK+M8DTkubzRqjkWlY3AOs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e82bf0-fa50-4309-439b-08d610d4c728
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:19.1333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 42bf546c1fe3f3654bdf914e977acbc2b80a5be5 ]

As Wen Xu reported in below link:

https://bugzilla.kernel.org/show_bug.cgi?id=3D200183

- Overview
Divide zero in reset_curseg() when mounting a crafted f2fs image

- Reproduce

- Kernel message
[  588.281510] divide error: 0000 [#1] SMP KASAN PTI
[  588.282701] CPU: 0 PID: 1293 Comm: mount Not tainted 4.18.0-rc1+ #4
[  588.284000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[  588.286178] RIP: 0010:reset_curseg+0x94/0x1a0
[  588.298166] RSP: 0018:ffff8801e88d7940 EFLAGS: 00010246
[  588.299360] RAX: 0000000000000014 RBX: ffff8801e1d46d00 RCX: ffffffffb88=
bf60b
[  588.300809] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffff8801e1d=
46d64
[  588.305272] R13: 0000000000000000 R14: 0000000000000014 R15: 00000000000=
00000
[  588.306822] FS:  00007fad85008840(0000) GS:ffff8801f6e00000(0000) knlGS:=
0000000000000000
[  588.308456] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  588.309623] CR2: 0000000001705078 CR3: 00000001f30f8000 CR4: 00000000000=
006f0
[  588.311085] Call Trace:
[  588.311637]  f2fs_build_segment_manager+0x103f/0x3410
[  588.316136]  ? f2fs_commit_super+0x1b0/0x1b0
[  588.317031]  ? set_blocksize+0x90/0x140
[  588.319473]  f2fs_mount+0x15/0x20
[  588.320166]  mount_fs+0x60/0x1a0
[  588.320847]  ? alloc_vfsmnt+0x309/0x360
[  588.321647]  vfs_kern_mount+0x6b/0x1a0
[  588.322432]  do_mount+0x34a/0x18c0
[  588.323175]  ? strndup_user+0x46/0x70
[  588.323937]  ? copy_mount_string+0x20/0x20
[  588.324793]  ? memcg_kmem_put_cache+0x1b/0xa0
[  588.325702]  ? kasan_check_write+0x14/0x20
[  588.326562]  ? _copy_from_user+0x6a/0x90
[  588.327375]  ? memdup_user+0x42/0x60
[  588.328118]  ksys_mount+0x83/0xd0
[  588.328808]  __x64_sys_mount+0x67/0x80
[  588.329607]  do_syscall_64+0x78/0x170
[  588.330400]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  588.331461] RIP: 0033:0x7fad848e8b9a
[  588.336022] RSP: 002b:00007ffd7c5b6be8 EFLAGS: 00000206 ORIG_RAX: 000000=
00000000a5
[  588.337547] RAX: ffffffffffffffda RBX: 00000000016f8030 RCX: 00007fad848=
e8b9a
[  588.338999] RDX: 00000000016f8210 RSI: 00000000016f9f30 RDI: 00000000017=
00ec0
[  588.340442] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00013
[  588.341887] R10: 00000000c0ed0000 R11: 0000000000000206 R12: 00000000017=
00ec0
[  588.343341] R13: 00000000016f8210 R14: 0000000000000000 R15: 00000000000=
00003
[  588.354891] ---[ end trace 4ce02f25ff7d3df5 ]---
[  588.355862] RIP: 0010:reset_curseg+0x94/0x1a0
[  588.360742] RSP: 0018:ffff8801e88d7940 EFLAGS: 00010246
[  588.361812] RAX: 0000000000000014 RBX: ffff8801e1d46d00 RCX: ffffffffb88=
bf60b
[  588.363485] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffff8801e1d=
46d64
[  588.365213] RBP: ffff8801e88d7968 R08: ffffed003c32266f R09: ffffed003c3=
2266f
[  588.366661] R10: 0000000000000001 R11: ffffed003c32266e R12: ffff8801f03=
37700
[  588.368110] R13: 0000000000000000 R14: 0000000000000014 R15: 00000000000=
00000
[  588.370057] FS:  00007fad85008840(0000) GS:ffff8801f6e00000(0000) knlGS:=
0000000000000000
[  588.372099] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  588.373291] CR2: 0000000001705078 CR3: 00000001f30f8000 CR4: 00000000000=
006f0

- Location
https://elixir.bootlin.com/linux/latest/source/fs/f2fs/segment.c#L2147
        curseg->zone =3D GET_ZONE_FROM_SEG(sbi, curseg->segno);

If secs_per_zone is corrupted due to fuzzing test, it will cause divide
zero operation when using GET_ZONE_FROM_SEG macro, so we should do more
sanity check with secs_per_zone during mount to avoid this issue.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3995e926ba3a..a4ac297e66df 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2229,9 +2229,9 @@ static int sanity_check_raw_super(struct f2fs_sb_info=
 *sbi,
 		return 1;
 	}
=20
-	if (secs_per_zone > total_sections) {
+	if (secs_per_zone > total_sections || !secs_per_zone) {
 		f2fs_msg(sb, KERN_INFO,
-			"Wrong secs_per_zone (%u > %u)",
+			"Wrong secs_per_zone / total_sections (%u, %u)",
 			secs_per_zone, total_sections);
 		return 1;
 	}
--=20
2.17.1
