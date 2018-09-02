Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDC7C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62111204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YgOJCu8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62111204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbeIBRYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:24:00 -0400
Received: from mail-sn1nam02on0134.outbound.protection.outlook.com ([104.47.36.134]:59648
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729437AbeIBRX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVSG8cUM73W4VOtKLnalnOgSD+P1op7ZwtfinBHqVtw=;
 b=YgOJCu8SxK1KK5DuAlT8ZGzMD+Y9MoogT9AgBM3YzCsdqdp8IqnQuY5kvzMMPZHN9HhkQE2KrRWmEgUWd97Tuxa3te58fAldalaBd1PxnN9VI156lCse2Hy0iN6DykbzCfofUPVoxMuewdDziKaGAurR0wZiMv9WttCd3uu+7l4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:48 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 59/89] f2fs: fix to do sanity check with reserved
 blkaddr of inline inode
Thread-Topic: [PATCH AUTOSEL 4.14 59/89] f2fs: fix to do sanity check with
 reserved blkaddr of inline inode
Thread-Index: AQHUQr3i91cReAYiRkOSFtTUBoz3fw==
Date:   Sun, 2 Sep 2018 13:07:22 +0000
Message-ID: <20180902064918.183387-59-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:y7DSrP8DIk/+JK4r6cVskWwlk0mb6mAuBuzSU2JkRZdfiTP25uvidz6MX+pmqKFqEwExLlIvY4GU0rkh1A0XfW6Scyy2d+yIh+Aue4dvEGPHQ4aIFyH/6r/R9VcjkUKOY1S+GYE8hN0NXEiy7aMsKqmeTtLtF3j7UWOjiLAiDwJWq+4mReQL9vA268IG/HIO4xMi+FWyujMv3endsxs4NjNlA8ybFbzFjVo72w0KY1Beb40TRu6MbUclHEsxssl1+E29IkscYk4HoOMT25tJSE7f+tQPnzhI64OgCiTrXQIUaE+ZLWNpFh+2BbTRavbwUci3v0sgluRLlhAcOobejVLzMAv9t6ebvkgLjaSiYyCBPuq7KbWzkTy7Q4rC941rJEKNP2+uqSDJPdO/O5QiW13Pmo24KlvPJ7bf9xsPRovz8JwQhBVjxsP393xEkAt0vkUH/DhgNH67NCzZLA1n9g==;5:ZpSSgbEZPxyq7Lc/RSJoZAyyofy93Unq/OGq17q61KHRh95MFO4Num3jhCM4cmPSxLUUPmgUbXYfyQQi6BMNb0ePXZ4z8jzkuyZ93hIZR9tYogi1B0dLotufndU82WbSU7HNdIdlNeLzkuNE8DsQTiNn7vPIXG5KJJxIwNd7aKg=;7:QL2fp49dMjs4bm/yaqeGlWSuDn1KTZolh0f4oWX6eJKIgeRrJIB0hvIVrXgmL4UrjR9dVmrq9GdKS46vtH4rAZ2/UopweCiJjiCgQi3r7lIs+jTGFce7zzvWvtxp52muduSMghbuhOY84ParZi/QIffPpWaE5qCDxC+pu/AIyKJ8+7PpbvsjRt6EZf6mWZW1QZakKkHFFmPJEhPlEdPSYjarfenIQvD8e/GvyNOAVwAJPbZcANmmHg1tFdy3ST3/
x-ms-office365-filtering-correlation-id: 70834e66-b4fd-45b3-7b1d-08d610d514b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB0503297A84E6AD16F894AFB0FB0D0@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(108815179253565)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(105586002)(8936002)(102836004)(6346003)(68736007)(2900100001)(6116002)(217873002)(186003)(36756003)(81156014)(81166006)(1076002)(99286004)(26005)(5660300001)(66066001)(6666003)(8676002)(54906003)(256004)(316002)(305945005)(22452003)(3846002)(10090500001)(7736002)(110136005)(14444005)(106356001)(2906002)(6506007)(10290500003)(2501003)(966005)(478600001)(2616005)(72206003)(6512007)(53936002)(86362001)(86612001)(107886003)(6436002)(14454004)(76176011)(486006)(25786009)(476003)(97736004)(446003)(11346002)(6486002)(4326008)(6306002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ChX78asmdzViY1o5tirEpGwYPS7zq3+pYh0nduuPvVZAPR05lcrhlHsVr86cdiursZ5m3K3R/InvZPm/17LWGGyWvwGxBYalOtpcuTA8J0jSCd6SOOX4XF5i1ZJogNwJ8e+0BcROswgKUX1BUFEFnAJJhUB+BFrHgX7Y//0ae+d5b5ERYh8PKHEIcxjepcXAEDZHPxnmLltySBFiawhRsgrCmkPbzp0Xxv48etwaq3MM+GBiVMitdsTDVfaZP3BlDb4nkuxplo2tXZ/y2DBhr1lpn5QNOK8SEKDAw47VUWmKkbxMeYRuHk28QxFE6HvLux611faK9wkX+SBglIGNr6td4gXf9RAANl04it+E5GM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70834e66-b4fd-45b3-7b1d-08d610d514b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:22.2786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 4dbe38dc386910c668c75ae616b99b823b59f3eb ]

As Wen Xu reported in bugzilla, after image was injected with random data
by fuzzing, inline inode would contain invalid reserved blkaddr, then
during inline conversion, we will encounter illegal memory accessing
reported by KASAN, the root cause of this is when writing out converted
inline page, we will use invalid reserved blkaddr to update sit bitmap,
result in accessing memory beyond sit bitmap boundary.

In order to fix this issue, let's do sanity check with reserved block
address of inline inode to avoid above condition.

https://bugzilla.kernel.org/show_bug.cgi?id=3D200179

[ 1428.846352] BUG: KASAN: use-after-free in update_sit_entry+0x80/0x7f0
[ 1428.846618] Read of size 4 at addr ffff880194483540 by task a.out/2741

[ 1428.846855] CPU: 0 PID: 2741 Comm: a.out Tainted: G        W         4.1=
7.0+ #1
[ 1428.846858] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[ 1428.846860] Call Trace:
[ 1428.846868]  dump_stack+0x71/0xab
[ 1428.846875]  print_address_description+0x6b/0x290
[ 1428.846881]  kasan_report+0x28e/0x390
[ 1428.846888]  ? update_sit_entry+0x80/0x7f0
[ 1428.846898]  update_sit_entry+0x80/0x7f0
[ 1428.846906]  f2fs_allocate_data_block+0x6db/0xc70
[ 1428.846914]  ? f2fs_get_node_info+0x14f/0x590
[ 1428.846920]  do_write_page+0xc8/0x150
[ 1428.846928]  f2fs_outplace_write_data+0xfe/0x210
[ 1428.846935]  ? f2fs_do_write_node_page+0x170/0x170
[ 1428.846941]  ? radix_tree_tag_clear+0xff/0x130
[ 1428.846946]  ? __mod_node_page_state+0x22/0xa0
[ 1428.846951]  ? inc_zone_page_state+0x54/0x100
[ 1428.846956]  ? __test_set_page_writeback+0x336/0x5d0
[ 1428.846964]  f2fs_convert_inline_page+0x407/0x6d0
[ 1428.846971]  ? f2fs_read_inline_data+0x3b0/0x3b0
[ 1428.846978]  ? __get_node_page+0x335/0x6b0
[ 1428.846987]  f2fs_convert_inline_inode+0x41b/0x500
[ 1428.846994]  ? f2fs_convert_inline_page+0x6d0/0x6d0
[ 1428.847000]  ? kasan_unpoison_shadow+0x31/0x40
[ 1428.847005]  ? kasan_kmalloc+0xa6/0xd0
[ 1428.847024]  f2fs_file_mmap+0x79/0xc0
[ 1428.847029]  mmap_region+0x58b/0x880
[ 1428.847037]  ? arch_get_unmapped_area+0x370/0x370
[ 1428.847042]  do_mmap+0x55b/0x7a0
[ 1428.847048]  vm_mmap_pgoff+0x16f/0x1c0
[ 1428.847055]  ? vma_is_stack_for_current+0x50/0x50
[ 1428.847062]  ? __fsnotify_update_child_dentry_flags.part.1+0x160/0x160
[ 1428.847068]  ? do_sys_open+0x206/0x2a0
[ 1428.847073]  ? __fget+0xb4/0x100
[ 1428.847079]  ksys_mmap_pgoff+0x278/0x360
[ 1428.847085]  ? find_mergeable_anon_vma+0x50/0x50
[ 1428.847091]  do_syscall_64+0x73/0x160
[ 1428.847098]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1428.847102] RIP: 0033:0x7fb1430766ba
[ 1428.847103] Code: 89 f5 41 54 49 89 fc 55 53 74 35 49 63 e8 48 63 da 4d =
89 f9 49 89 e8 4d 63 d6 48 89 da 4c 89 ee 4c 89 e7 b8 09 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 56 5b 5d 41 5c 41 5d 41 5e 41 5f c3 0f 1f 00
[ 1428.847162] RSP: 002b:00007ffc651d9388 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000009
[ 1428.847167] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fb1430=
766ba
[ 1428.847170] RDX: 0000000000000001 RSI: 0000000000001000 RDI: 00000000000=
00000
[ 1428.847173] RBP: 0000000000000003 R08: 0000000000000003 R09: 00000000000=
00000
[ 1428.847176] R10: 0000000000008002 R11: 0000000000000246 R12: 00000000000=
00000
[ 1428.847179] R13: 0000000000001000 R14: 0000000000008002 R15: 00000000000=
00000

[ 1428.847252] Allocated by task 2683:
[ 1428.847372]  kasan_kmalloc+0xa6/0xd0
[ 1428.847380]  kmem_cache_alloc+0xc8/0x1e0
[ 1428.847385]  getname_flags+0x73/0x2b0
[ 1428.847390]  user_path_at_empty+0x1d/0x40
[ 1428.847395]  vfs_statx+0xc1/0x150
[ 1428.847401]  __do_sys_newlstat+0x7e/0xd0
[ 1428.847405]  do_syscall_64+0x73/0x160
[ 1428.847411]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[ 1428.847466] Freed by task 2683:
[ 1428.847566]  __kasan_slab_free+0x137/0x190
[ 1428.847571]  kmem_cache_free+0x85/0x1e0
[ 1428.847575]  filename_lookup+0x191/0x280
[ 1428.847580]  vfs_statx+0xc1/0x150
[ 1428.847585]  __do_sys_newlstat+0x7e/0xd0
[ 1428.847590]  do_syscall_64+0x73/0x160
[ 1428.847596]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[ 1428.847648] The buggy address belongs to the object at ffff880194483300
                which belongs to the cache names_cache of size 4096
[ 1428.847946] The buggy address is located 576 bytes inside of
                4096-byte region [ffff880194483300, ffff880194484300)
[ 1428.848234] The buggy address belongs to the page:
[ 1428.848366] page:ffffea0006512000 count:1 mapcount:0 mapping:ffff8801f35=
86380 index:0x0 compound_mapcount: 0
[ 1428.848606] flags: 0x17fff8000008100(slab|head)
[ 1428.848737] raw: 017fff8000008100 dead000000000100 dead000000000200 ffff=
8801f3586380
[ 1428.848931] raw: 0000000000000000 0000000000070007 00000001ffffffff 0000=
000000000000
[ 1428.849122] page dumped because: kasan: bad access detected

[ 1428.849305] Memory state around the buggy address:
[ 1428.849436]  ffff880194483400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[ 1428.849620]  ffff880194483480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[ 1428.849804] >ffff880194483500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[ 1428.849985]                                            ^
[ 1428.850120]  ffff880194483580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[ 1428.850303]  ffff880194483600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[ 1428.850498] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Reported-by: Wen Xu <wen.xu@gatech.edu>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/inline.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 8322e4e7bb3f..295d5505b939 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -128,6 +128,16 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn,=
 struct page *page)
 	if (err)
 		return err;
=20
+	if (unlikely(dn->data_blkaddr !=3D NEW_ADDR)) {
+		f2fs_put_dnode(dn);
+		set_sbi_flag(fio.sbi, SBI_NEED_FSCK);
+		f2fs_msg(fio.sbi->sb, KERN_WARNING,
+			"%s: corrupted inline inode ino=3D%lx, i_addr[0]:0x%x, "
+			"run fsck to fix.",
+			__func__, dn->inode->i_ino, dn->data_blkaddr);
+		return -EINVAL;
+	}
+
 	f2fs_bug_on(F2FS_P_SB(page), PageWriteback(page));
=20
 	read_inline_data(page, dn->inode_page);
@@ -365,6 +375,17 @@ static int f2fs_move_inline_dirents(struct inode *dir,=
 struct page *ipage,
 	if (err)
 		goto out;
=20
+	if (unlikely(dn.data_blkaddr !=3D NEW_ADDR)) {
+		f2fs_put_dnode(&dn);
+		set_sbi_flag(F2FS_P_SB(page), SBI_NEED_FSCK);
+		f2fs_msg(F2FS_P_SB(page)->sb, KERN_WARNING,
+			"%s: corrupted inline inode ino=3D%lx, i_addr[0]:0x%x, "
+			"run fsck to fix.",
+			__func__, dir->i_ino, dn.data_blkaddr);
+		err =3D -EINVAL;
+		goto out;
+	}
+
 	f2fs_wait_on_page_writeback(page, DATA, true);
 	zero_user_segment(page, MAX_INLINE_DATA(dir), PAGE_SIZE);
=20
--=20
2.17.1
