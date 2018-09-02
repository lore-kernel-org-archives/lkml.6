Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25D3C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862AD20855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="otCt+s1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862AD20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbeIBRVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:21:43 -0400
Received: from mail-eopbgr680092.outbound.protection.outlook.com ([40.107.68.92]:55808
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726711AbeIBRVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kV6W0r7ANCVld6Bp3T0OpdntH+G7EOtTDyH1vzgvUY=;
 b=otCt+s1biK1X+YpdtMpPy24PQpfOcB+37AwOxSABhskXVd6tpLmJb66uqWGqket5H4EiiJ/la6OefMZaocfF/OmWvasQ1uI2gSKQt+es3kQMMLQKUoLzP8+uXyTjBA8rpQ4VjvIFT0SSOCT+HQw/swX6ho3obHyTqqZ1QlypSFk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:05:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 120/131] f2fs: fix to propagate return value of
 scan_nat_page()
Thread-Topic: [PATCH AUTOSEL 4.18 120/131] f2fs: fix to propagate return value
 of scan_nat_page()
Thread-Index: AQHUQr2itR4vM8CWF02Fa119BLHMHw==
Date:   Sun, 2 Sep 2018 13:05:33 +0000
Message-ID: <20180902064601.183036-120-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:VrFrCt3JcRPAW3lz+kOiLKSoxU2CfPhFDhRAN0TSmi8bmUC+DeQnlzAHm8JgxAX5ERRgLeAZTX/6DHgCyeLwxgZvHfjlW8Y7EK6WvESYH5f690hwNj+NIj+lRq0SY7QbWGj6OzSJKtRPDcryEIwXEA8dQhXpfUVolT3wGyVogLCzOipGTsXQx9KnGCRAKUKDD/jE6RoOr/yYsTOHbJ9Eafr78c0Y7quGETSFjdwYfo9dmjgoImKRDmcXnryd2GwqZYDArfb+qUsL9Bh+99AAC3aAiZlRkTeMl9dwExDOumKVqrjUZWiMJgCZEVcc2LiIpGZFnzJsGx3+3lXlxbZmqqjFm4WST9NCEexK1ReOwKk/Tv7sh3JH8MW5RjSXhNepQ2syLon4HunUbFITxyud0eWqTDchlZ7j8J0EDDrb5VoyLQrP9hUt8DRoWlIHFbuYUx2shjnAidTRZZNFJko72Q==;5:o5BIQ95etyMzYxY2VicL1NxdNrZ2OFxpA9njEVssq+GUhIIJDy7TajnAJPe3zbjY8nGTqc4Zb+hkJojvYCLTbbTmsfQs0pkZ8AUKXAP+J1myDZEAcKZXaS/0zKweXMGjOMVrsNBQ/y70G3gDV/GzSdA60QgxO+VJT3XF/7GEDOk=;7:0iC4j7eoV37R0zCA6X2cvhN4TZP+ic/nR0YimRN3NGbeVfoi87QCPq55tWzjZs3Omi6udA1fwNaX6jPVoTCLXxjLr1xhryruoSDFXWhM2QdVNUhc0IxzCa7n4pcTRBq8IhtX+KGFia006kBW7tuEYSqXwesHXYjqUcuARB/4+Ba4TSxAgzgebL/9edMX3E0U+s3Z3uwkdRSAkvUormBprQaDPL0Vku+E3I0n2xvZXpPUoLgsrIduW0X9ftDS51/w
x-ms-office365-filtering-correlation-id: 465cc0a2-d6af-40e9-9e97-08d610d4c9f8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB0629EC36C1F501F646528289FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(6486002)(8936002)(6512007)(6306002)(22452003)(53936002)(6436002)(66066001)(4326008)(186003)(25786009)(86362001)(2900100001)(107886003)(76176011)(486006)(68736007)(36756003)(99286004)(2501003)(6666003)(5250100002)(110136005)(54906003)(106356001)(316002)(105586002)(10290500003)(72206003)(966005)(10090500001)(8676002)(478600001)(14454004)(5660300001)(476003)(1076002)(3846002)(305945005)(446003)(6116002)(217873002)(6346003)(11346002)(97736004)(81156014)(7736002)(81166006)(2906002)(5024004)(14444005)(102836004)(86612001)(26005)(6506007)(256004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: IPhwISh+Y5kARyj9GtcpeiAZeWejszUpZep0YYZiil9fai42/mzJofEGtjUoTlG58ZCdXt4EMOdA2k5b8B8Wneg2rPclf/dbe1Ez+QS3u8GGsPxzqyEtccs4kXfY4T2pt0gc9Ot/fMibPobOoe98XJ7uORUVSB1GrBgot+KBRt4HGpJbcCV6k/o8vvFpksNpebaVmFL8GcAAX9ckQxAjnBE8UMWHA5Zf8sVmhNYnzpnu2LVQV7oIcrebwExTa4wJc7q6k39m0P4W0RGQgMhU1TzXuKN1kRyE5D7B9lnSrRxhHgx6qWio8eijQtaiDrwbvzxKlWdF5upDJf45QQhimPqsLv3gAGs6Tulco7kOLHc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465cc0a2-d6af-40e9-9e97-08d610d4c9f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:33.6153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit e2374015f27fe5ee5d5c37966e2faf396cdaaa65 ]

As Anatoly Trosinenko reported in bugzilla:

How to reproduce:
1. Compile the 73fcb1a370c76 version of the kernel using the config attache=
d
2. Unpack and mount the attached filesystem image as F2FS
3. The kernel will BUG() on mount (BUGs are explicitly enabled in config)

[    2.233612] F2FS-fs (sda): Found nat_bits in checkpoint
[    2.248422] ------------[ cut here ]------------
[    2.248857] kernel BUG at fs/f2fs/node.c:1967!
[    2.249760] invalid opcode: 0000 [#1] SMP NOPTI
[    2.250219] Modules linked in:
[    2.251848] CPU: 0 PID: 944 Comm: mount Not tainted 4.17.0-rc5+ #1
[    2.252331] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.10.2-1ubuntu1 04/01/2014
[    2.253305] RIP: 0010:build_free_nids+0x337/0x3f0
[    2.253672] RSP: 0018:ffffae7fc0857c50 EFLAGS: 00000246
[    2.254080] RAX: 00000000ffffffff RBX: 0000000000000123 RCX: 00000000000=
00001
[    2.254638] RDX: ffff9aa7063d5c00 RSI: 0000000000000122 RDI: ffff9aa7058=
52e00
[    2.255190] RBP: ffff9aa705852e00 R08: 0000000000000001 R09: ffff9aa7059=
090c0
[    2.255719] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9aa7058=
52e00
[    2.256242] R13: ffff9aa7063ad000 R14: ffff9aa705919000 R15: 00000000000=
00123
[    2.256809] FS:  00000000023078c0(0000) GS:ffff9aa707800000(0000) knlGS:=
0000000000000000
[    2.258654] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.259153] CR2: 00000000005511ae CR3: 0000000005872000 CR4: 00000000000=
006f0
[    2.259801] Call Trace:
[    2.260583]  build_node_manager+0x5cd/0x600
[    2.260963]  f2fs_fill_super+0x66a/0x17c0
[    2.261300]  ? f2fs_commit_super+0xe0/0xe0
[    2.261622]  mount_bdev+0x16e/0x1a0
[    2.261899]  mount_fs+0x30/0x150
[    2.262398]  vfs_kern_mount.part.28+0x4f/0xf0
[    2.262743]  do_mount+0x5d0/0xc60
[    2.263010]  ? _copy_from_user+0x37/0x60
[    2.263313]  ? memdup_user+0x39/0x60
[    2.263692]  ksys_mount+0x7b/0xd0
[    2.263960]  __x64_sys_mount+0x1c/0x20
[    2.264268]  do_syscall_64+0x43/0xf0
[    2.264560]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.265095] RIP: 0033:0x48d31a
[    2.265502] RSP: 002b:00007ffc6fe60a08 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000a5
[    2.266089] RAX: ffffffffffffffda RBX: 0000000000008000 RCX: 00000000004=
8d31a
[    2.266607] RDX: 00007ffc6fe62fa5 RSI: 00007ffc6fe62f9d RDI: 00007ffc6fe=
62f94
[    2.267130] RBP: 00000000023078a0 R08: 0000000000000000 R09: 00000000000=
00000
[    2.267670] R10: 0000000000008000 R11: 0000000000000246 R12: 00000000000=
00000
[    2.268192] R13: 0000000000000000 R14: 00007ffc6fe60c78 R15: 00000000000=
00000
[    2.268767] Code: e8 5f c3 ff ff 83 c3 01 41 83 c7 01 81 fb c7 01 00 00 =
74 48 44 39 7d 04 76 42 48 63 c3 48 8d 04 c0 41 8b 44 06 05 83 f8 ff 75 c1 =
<0f> 0b 49 8b 45 50 48 8d b8 b0 00 00 00 e8 37 59 69 00 b9 01 00
[    2.270434] RIP: build_free_nids+0x337/0x3f0 RSP: ffffae7fc0857c50
[    2.271426] ---[ end trace ab20c06cd3c8fde4 ]---

During loading NAT entries, we will do sanity check, once the entry info
is corrupted, it will cause BUG_ON directly to protect user data from
being overwrited.

In this case, it will be better to just return failure on mount() instead
of panic, so that user can get hint from kmsg and try fsck for recovery
immediately rather than after an abnormal reboot.

https://bugzilla.kernel.org/show_bug.cgi?id=3D199769

Reported-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/f2fs.h |  2 +-
 fs/f2fs/node.c | 42 ++++++++++++++++++++++++++++++------------
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 03c07721da49..b6f2dc8163e1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2819,7 +2819,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, s=
truct inode *inode,
 int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 			struct writeback_control *wbc,
 			bool do_balance, enum iostat_type io_type);
-void f2fs_build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)=
;
+int f2fs_build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount);
 bool f2fs_alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid);
 void f2fs_alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid);
 void f2fs_alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b949002e52a7..52ed02b0327c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1970,7 +1970,7 @@ static void remove_free_nid(struct f2fs_sb_info *sbi,=
 nid_t nid)
 		kmem_cache_free(free_nid_slab, i);
 }
=20
-static void scan_nat_page(struct f2fs_sb_info *sbi,
+static int scan_nat_page(struct f2fs_sb_info *sbi,
 			struct page *nat_page, nid_t start_nid)
 {
 	struct f2fs_nm_info *nm_i =3D NM_I(sbi);
@@ -1988,7 +1988,10 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
 			break;
=20
 		blk_addr =3D le32_to_cpu(nat_blk->entries[i].block_addr);
-		f2fs_bug_on(sbi, blk_addr =3D=3D NEW_ADDR);
+
+		if (blk_addr =3D=3D NEW_ADDR)
+			return -EINVAL;
+
 		if (blk_addr =3D=3D NULL_ADDR) {
 			add_free_nid(sbi, start_nid, true, true);
 		} else {
@@ -1997,6 +2000,8 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
 			spin_unlock(&NM_I(sbi)->nid_list_lock);
 		}
 	}
+
+	return 0;
 }
=20
 static void scan_curseg_cache(struct f2fs_sb_info *sbi)
@@ -2052,11 +2057,11 @@ static void scan_free_nid_bits(struct f2fs_sb_info =
*sbi)
 	up_read(&nm_i->nat_tree_lock);
 }
=20
-static void __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
+static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
 						bool sync, bool mount)
 {
 	struct f2fs_nm_info *nm_i =3D NM_I(sbi);
-	int i =3D 0;
+	int i =3D 0, ret;
 	nid_t nid =3D nm_i->next_scan_nid;
=20
 	if (unlikely(nid >=3D nm_i->max_nid))
@@ -2064,17 +2069,17 @@ static void __f2fs_build_free_nids(struct f2fs_sb_i=
nfo *sbi,
=20
 	/* Enough entries */
 	if (nm_i->nid_cnt[FREE_NID] >=3D NAT_ENTRY_PER_BLOCK)
-		return;
+		return 0;
=20
 	if (!sync && !f2fs_available_free_memory(sbi, FREE_NIDS))
-		return;
+		return 0;
=20
 	if (!mount) {
 		/* try to find free nids in free_nid_bitmap */
 		scan_free_nid_bits(sbi);
=20
 		if (nm_i->nid_cnt[FREE_NID] >=3D NAT_ENTRY_PER_BLOCK)
-			return;
+			return 0;
 	}
=20
 	/* readahead nat pages to be scanned */
@@ -2088,8 +2093,16 @@ static void __f2fs_build_free_nids(struct f2fs_sb_in=
fo *sbi,
 						nm_i->nat_block_bitmap)) {
 			struct page *page =3D get_current_nat_page(sbi, nid);
=20
-			scan_nat_page(sbi, page, nid);
+			ret =3D scan_nat_page(sbi, page, nid);
 			f2fs_put_page(page, 1);
+
+			if (ret) {
+				up_read(&nm_i->nat_tree_lock);
+				f2fs_bug_on(sbi, !mount);
+				f2fs_msg(sbi->sb, KERN_ERR,
+					"NAT is corrupt, run fsck to fix it");
+				return -EINVAL;
+			}
 		}
=20
 		nid +=3D (NAT_ENTRY_PER_BLOCK - (nid % NAT_ENTRY_PER_BLOCK));
@@ -2110,13 +2123,19 @@ static void __f2fs_build_free_nids(struct f2fs_sb_i=
nfo *sbi,
=20
 	f2fs_ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nm_i->next_scan_nid),
 					nm_i->ra_nid_pages, META_NAT, false);
+
+	return 0;
 }
=20
-void f2fs_build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
+int f2fs_build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 {
+	int ret;
+
 	mutex_lock(&NM_I(sbi)->build_lock);
-	__f2fs_build_free_nids(sbi, sync, mount);
+	ret =3D __f2fs_build_free_nids(sbi, sync, mount);
 	mutex_unlock(&NM_I(sbi)->build_lock);
+
+	return ret;
 }
=20
 /*
@@ -2803,8 +2822,7 @@ int f2fs_build_node_manager(struct f2fs_sb_info *sbi)
 	/* load free nid status from nat_bits table */
 	load_free_nid_bitmap(sbi);
=20
-	f2fs_build_free_nids(sbi, true, true);
-	return 0;
+	return f2fs_build_free_nids(sbi, true, true);
 }
=20
 void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi)
--=20
2.17.1
